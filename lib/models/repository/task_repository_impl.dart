import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/local_db/db.dart';
import 'package:tiademo/models/repository/abstract/task_repository.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/service/generate_uuid.dart';
import 'package:tiademo/service/internet_check.dart';

class TaskRepositoryImpl extends TaskRepository {
  final FirebaseFirestore _cloud = FirebaseFirestore.instance;
  final String _userCollection = "USER";
  final String _taskCollection = "TASK";
  final String _categoryCollection = "CATEGORY";
  String? token = "000000";
  // String? token;
  final DatabaseHelper _db = DatabaseHelper();
  final ConnectivityService _connectivityService = ConnectivityService();
  final GenerateUuid _genId = GenerateUuid();

  void updateToken(String? newToken) {
    token = newToken;
  }

  TaskRepositoryImpl({this.token});

  @override
  Future<bool> addTask(Task task) async {
    // TODO: implement addTask
    //check net
    var networkCheck = await _connectivityService.isConnected();
    if (networkCheck) {
      try {
        var ref = _cloud.collection(_userCollection).doc(token);
        //id just use to identify have task on cloud yet ,in local it is docId if on cloud or genId start with LOCAL if not
        var taskRef = await ref.collection(_taskCollection).add(task.toMap()).then((value) async {
          await value.update({"id": value.id});
          return value;
        });
        task.id = taskRef.id;
        int? insert = await _db.insertTask(task);
        var tasks = await _db.tasks();
        tasks.forEach((element) {
          print("check after insert local ---------------------------");
          print(element.toString());
        });
        var loadNet = await getTasks();
        loadNet.forEach((element) {
          print("check after insert net ---------------------------");
          print(element.toString());
        });

        if (insert != 0) {
          //mean added
          return true;
        }
      } on Exception catch (e) {
        e.printError();
      }
    } else {
      //have no net
      String localId = _genId.generateId();
      task.id = localId;
      int? insert = await _db.insertTask(task);
      if (insert != 0) {
        //mean added
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> createCategory(Category category) async {
    // TODO: implement createCategory
    ///do similar to task
    ///but when local category sync with cloud id have to change tasks depend in both
    var networkCheck = await _connectivityService.isConnected();
    if (networkCheck) {
      try {
        var ref = _cloud.collection(_userCollection).doc(token);
        //id just use to identify have task on cloud yet ,in local it is docId if on cloud or genId start with LOCAL if not
        var taskRef = await ref.collection(_categoryCollection).add(category.toMap()..remove("id"));
        category.id = taskRef.id;
        int? insert = await _db.insertCategory(category);
        if (insert != 0) {
          //mean added
          return true;
        }
      } on Exception catch (e) {
        e.printError();
      }
    } else {
      //have no net
      String localId = _genId.generateId();
      category.id = localId;
      int? insert = await _db.insertCategory(category);
      if (insert != 0) {
        //mean added
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> deleteTask(Task task) async {
    //TODO: implement deleteTask
    //have to check it with id is local or cloud
    var isLocal = task.id.contains("LOCAL");
    if (isLocal) {
      return await _db.deleteTask(task.id);
    } else {
      ///check net to remove
      ///case no net it will not delete absolutely
      ///remove it on tasks table then store it on cachesDelete table
      ///when have net again sync will delete on cloud later
      var check = await _connectivityService.isConnected();
      if (!check) {
        //have no net case
        await _db.deleteTask(task.id);
        int? out = await _db.insertTaskCache(task, _db.DELETE);
        if (out == 0) {
          return false;
        }
        return true;
      } else {
        //have net case
        try {
          var ref = _cloud.collection(_userCollection).doc(token);
          //id just use to identify have task on cloud yet ,in local it is docId if on cloud or genId start with LOCAL if not
          return await ref.collection(_taskCollection).doc(task.id).delete().then((value) async {
            return await _db.deleteTask(task.id);
          });
        } catch (e) {
          e.printError(info: "deleteTaskdrop-------------------------------------------repository");
        }
      }
    }
    return false;
  }

  @override
  Future<List<Category>> getCategories() async {
    // TODO: implement getCategories
    //net
    var haveNet = await _connectivityService.isConnected();
    if (haveNet) {
      try {
        var ref = _cloud.collection(_userCollection).doc(token);
        //id just use to identify have task on cloud yet ,in local it is docId if on cloud or genId start with LOCAL if not
        var raw = await ref.collection(_categoryCollection).get();
        List<Category> out = [];
        for (var element in raw.docs) {
          //because when store on cloud it will not contain id field
          var m = element.data();
          var data = {
            "id": element.id,
            "name": m["name"],
            "iconId": m["iconId"],
            "description": m["description"],
            "colorId": m["colorId"]
          };
          out.add(Category.fromMap(data));
        }
        return out;
      } catch (e) {
        e.printError(info: "deleteTaskdrop-------------------------------------------repository");
      }
    } else {
      //have no net case
      return await _db.categories();
    }
    return [];
  }

  @override
  Future<List<Task>> getTasks() async {
    // TODO: implement getTasks
    var haveNet = await _connectivityService.isConnected();
    if (haveNet) {
      try {
        print("conectivity check ok from repository ---------------------------------repository");
        var ref = _cloud.collection(_userCollection).doc(token);
        //id just use to identify have task on cloud yet ,in local it is docId if on cloud or genId start with LOCAL if not
        var raw = await ref.collection(_taskCollection).get();
        List<Task> out = [];
        for (var element in raw.docs) {
          //because when store on cloud it will not contain id field
          var id = {"id": element.id};
          Map<String, dynamic> temp = {};
          temp.addAll(id);
          temp.addAll(element.data());
          out.add(Task.fromMap(temp));
        }
        return out;
      } catch (e) {
        e.printError();
        print("getTaskDrop-------------------------------------------repository");
      }
    } else {
      //have no net case
      return await _db.tasks();
    }
    return [];
  }

  Future<bool> syncData() async {
    ///todo:handle cached task here
    ///
    var didCategory = await syncCategory();
    var didTask = await syncTask();
    var didCache = await syncCache();
    return didTask && didCategory && didCache;
  }

  Future<bool> syncCache() async {
    var raw = await _db.getTaskCache();
    if (raw.isNotEmpty) {
      for (var map in raw) {
        var task = Task.fromMap(map);
        String action = map['action'] ?? "";
        switch (action) {
          case "UPDATE":
            {
              try {
                var userRef = _cloud.collection(_userCollection).doc(token);
                var taskRef = userRef.collection(_taskCollection).doc(task.id);
                taskRef.update(task.toMap());
              } on Exception catch (e) {
                e.printError();
              }
              await _db.deleteTaskCache(task.id);
              print(
                  "==================>update cache for ${task.toMap()}===================================>from taskRepository");
              break;
            }
          case "DELETE":
            {
              try {
                var userRef = _cloud.collection(_userCollection).doc(token);
                var taskRef = userRef.collection(_taskCollection).doc(task.id);
                taskRef.delete();
              } on Exception catch (e) {
                e.printError();
              }
              await _db.deleteTaskCache(task.id);
              break;
            }
        }
      }
    }

    return true;
  }

  Future<bool> syncCategory() async {
    //sync local categories and task depend on
    List<Category> localCategories = await _db.localCategories();
    var ref = _cloud.collection(_userCollection).doc(token);
    //id just use to identify have task on cloud yet ,in local it is docId if on cloud or genId start with LOCAL if not
    var categoriesCollection = ref.collection(_categoryCollection);
    if (localCategories.isNotEmpty) {
      //push to firebase then update depend
      for (var c in localCategories) {
        var doc = await categoriesCollection.add(c.toMap()).then((value) async {
          value.update({"id": value.id});
          return value;
        });
        //then update local db with new docId
        var willUpdateData = c.copyWith(id: doc.id);
        //todo:update task depend first then replace old category
        var dependTask = await _db.getTaskByCategory(c);
        for (var element in dependTask) {
          element.category = willUpdateData;
          var task = element.copyWith(
              id: element.id,
              label: element.label,
              description: element.description,
              time: element.time,
              state: element.state,
              category: willUpdateData,
              priority: element.priority);
          updateTask(element);
        }
        updateCategory(c.id, willUpdateData);
        return true;
        print("synced data for ${willUpdateData.toString()}-----------------------------------------taskRepository");
      }
    }
    return false;
  }

  Future<bool> syncTask() async {
    /// these code just done to sync task up
    /// have 2 flow
    /// sync data from local to firebase <done>
    /// sync from firebase to local <todo:not implement yet>
    List<Task> localTask = await _db.localTasks();
    var ref = _cloud.collection(_userCollection).doc(token);
    //id just use to identify have task on cloud yet ,in local it is docId if on cloud or genId start with LOCAL if not
    var taskCollection = ref.collection(_taskCollection);
    if (localTask.isNotEmpty) {
      for (var t in localTask) {
        var doc = await taskCollection.add(t.toMap());
        //then update local db with new docId
        var willUpdateData = t.copyWithId(doc.id);
        _db.deleteTask(t.id);
        _db.insertTask(willUpdateData);
        print("synced data for ${willUpdateData.toString()}-----------------------------------------taskRepository");
      }
    }
    return true;
  }

  @override
  Future<bool> updateTask(Task task) async {
    // TODO: implement updateTask
    //in the case the task is local we update directly

    await _db.updateTask(task);
    //in case it on cloud have to
    if (!task.id.contains('LOCAL')) {
      var haveNet = await _connectivityService.isConnected();
      if (haveNet) {
        await _cloud
            .collection(_userCollection)
            .doc(token)
            .collection(_taskCollection)
            .doc(task.id)
            .update(task.toMap());
      } else {
        //have no net case to add update to caches
        _db.insertTaskCache(task, _db.UPDATE);
      }
    }

    return true;
  }

  @override
  Future<bool> deleteCategory(Category category) async {
    // TODO: implement deleteCategory
    return false;
  }

  Future<void> updateCategory(String oldId, Category c) async {
    _db.deleteCategory(oldId);
    _db.insertCategory(c);
  }
}
