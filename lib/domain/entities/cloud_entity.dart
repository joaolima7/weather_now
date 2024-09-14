class CloudEntity {
  final int all;

  CloudEntity({
    required this.all,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'all': all,
    };
  }

  factory CloudEntity.fromMap(Map<String, dynamic> map) {
    return CloudEntity(
      all: map['all'] as int,
    );
  }
}
