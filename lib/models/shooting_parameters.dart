// lib/models/shooting_parameters.dart
class ShootingParameters {
  int plantNumber;
  int beforeDropNumber;
  int afterDropNumber;
  bool nextPlant;
  bool beforeDrop;

  ShootingParameters({
    this.plantNumber = 0,
    this.beforeDropNumber = 0,
    this.afterDropNumber = 0,
    this.nextPlant = true,
    this.beforeDrop = true,
  });

  void saveAndAdvance() {
    if (nextPlant) {
      plantNumber++;
      beforeDropNumber = 0;
      afterDropNumber = 0;
    } else {
      beforeDrop ? beforeDropNumber++ : afterDropNumber++;
    }
  }

  void discardAndAdvance() {
    // No need to update any counters
  }

  void reset() {
    nextPlant = true;
    beforeDrop = true;
  }

  String getFileName() {
    if (beforeDrop) {
      return 'before_${plantNumber}_$beforeDropNumber';
    } else {
      return 'after_${plantNumber}_$afterDropNumber';
    }
  }
}
