import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapsDemo extends StatelessWidget {
  //FIXME: Add your Mapbox access token here
  static const String ACCESS_TOKEN =
      "pk.eyJ1IjoiaXNtYWlsMDEiLCJhIjoiY2tuNzZ3ZHJnMDU2bTJ1bXFodDNkanExMSJ9.hjd7Q4-GUlZ1HhEKb6idOA";

  void _pushPage(BuildContext context, ExamplePage page) async {
    if (!kIsWeb) {
      final location = Location();
      final hasPermissions = await location.hasPermission();
      if (hasPermissions != PermissionStatus.granted) {
        await location.requestPermission();
      }
    }
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapboxMaps examples')),
      body: ListView.builder(
        itemCount: _allPages.length,
        itemBuilder: (_, int index) => ListTile(
          leading: _allPages[index].leading,
          title: Text(_allPages[index].title),
          onTap: () => _pushPage(context, _allPages[index]),
        ),
      ),
    );
  }
}

final List<ExamplePage> _allPages = <ExamplePage>[
  FullMapPage(),
  AnimateCameraPage(),
  CustomMarkerPage(),
  MoveCameraPage(),
  PlaceCirclePage(),
];

class FullMapPage extends ExamplePage {
  FullMapPage() : super(const Icon(Icons.map), 'Full screen map');

  @override
  Widget build(BuildContext context) {
    return const FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: MapboxMap(
      accessToken: MapsDemo.ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
      onStyleLoadedCallback: onStyleLoadedCallback,
    ));
  }

  void onStyleLoadedCallback() {}
}

abstract class ExamplePage extends StatelessWidget {
  const ExamplePage(this.leading, this.title);

  final Widget leading;
  final String title;
}

class AnimateCameraPage extends ExamplePage {
  AnimateCameraPage()
      : super(const Icon(Icons.map), 'Camera control, animated');

  @override
  Widget build(BuildContext context) {
    return const AnimateCamera();
  }
}

class AnimateCamera extends StatefulWidget {
  const AnimateCamera();

  @override
  State createState() => AnimateCameraState();
}

class AnimateCameraState extends State<AnimateCamera> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: MapboxMap(
              accessToken: MapsDemo.ACCESS_TOKEN,
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  const CameraPosition(target: LatLng(0.0, 0.0)),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    mapController
                        .animateCamera(
                          CameraUpdate.newCameraPosition(
                            const CameraPosition(
                              bearing: 270.0,
                              target: LatLng(51.5160895, -0.1294527),
                              tilt: 30.0,
                              zoom: 17.0,
                            ),
                          ),
                        )
                        .then((result) => print(
                            "mapController.animateCamera() returned $result"));
                  },
                  child: const Text('newCameraPosition'),
                ),
                TextButton(
                  onPressed: () {
                    mapController
                        .animateCamera(
                          CameraUpdate.newLatLng(
                            const LatLng(56.1725505, 10.1850512),
                          ),
                        )
                        .then((result) => print(
                            "mapController.animateCamera() returned $result"));
                  },
                  child: const Text('newLatLng'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.newLatLngBounds(
                        LatLngBounds(
                          southwest: const LatLng(-38.483935, 113.248673),
                          northeast: const LatLng(-8.982446, 153.823821),
                        ),
                        left: 10,
                        top: 5,
                        bottom: 25,
                      ),
                    );
                  },
                  child: const Text('newLatLngBounds'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        const LatLng(37.4231613, -122.087159),
                        11.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngZoom'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.scrollBy(150.0, -225.0),
                    );
                  },
                  child: const Text('scrollBy'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomBy(
                        -0.5,
                        const Offset(30.0, 20.0),
                      ),
                    );
                  },
                  child: const Text('zoomBy with focus'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomBy(-0.5),
                    );
                  },
                  child: const Text('zoomBy'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                  child: const Text('zoomIn'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                  child: const Text('zoomOut'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomTo(16.0),
                    );
                  },
                  child: const Text('zoomTo'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.bearingTo(45.0),
                    );
                  },
                  child: const Text('bearingTo'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.tiltTo(30.0),
                    );
                  },
                  child: const Text('tiltTo'),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

const randomMarkerNum = 100;

class CustomMarkerPage extends ExamplePage {
  CustomMarkerPage() : super(const Icon(Icons.place), 'Custom marker');

  @override
  Widget build(BuildContext context) {
    return CustomMarker();
  }
}

class CustomMarker extends StatefulWidget {
  const CustomMarker();

  @override
  State createState() => CustomMarkerState();
}

class CustomMarkerState extends State<CustomMarker> {
  final Random _rnd = new Random();

  MapboxMapController _mapController;
  List<Marker> _markers = [];
  List<_MarkerState> _markerStates = [];

  void _addMarkerStates(_MarkerState markerState) {
    _markerStates.add(markerState);
  }

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    controller.addListener(() {
      if (controller.isCameraMoving) {
        _updateMarkerPosition();
      }
    });
  }

  void _onStyleLoadedCallback() {
    print('onStyleLoadedCallback');
  }

  void _onMapLongClickCallback(Point<double> point, LatLng coordinates) {
    _addMarker(point, coordinates);
  }

  void _onCameraIdleCallback() {
    _updateMarkerPosition();
  }

  void _updateMarkerPosition() {
    final coordinates = <LatLng>[];

    for (final markerState in _markerStates) {
      coordinates.add(markerState.getCoordinate());
    }

    _mapController.toScreenLocationBatch(coordinates).then((points) {
      _markerStates.asMap().forEach((i, value) {
        _markerStates[i].updatePosition(points[i]);
      });
    });
  }

  void _addMarker(Point<double> point, LatLng coordinates) {
    setState(() {
      _markers.add(Marker(_rnd.nextInt(100000).toString(), coordinates, point,
          _addMarkerStates));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: [
        MapboxMap(
          accessToken: MapsDemo.ACCESS_TOKEN,
          trackCameraPosition: true,
          onMapCreated: _onMapCreated,
          onMapLongClick: _onMapLongClickCallback,
          onCameraIdle: _onCameraIdleCallback,
          onStyleLoadedCallback: _onStyleLoadedCallback,
          initialCameraPosition:
              const CameraPosition(target: LatLng(35.0, 135.0), zoom: 5),
        ),
        IgnorePointer(
            ignoring: true,
            child: Stack(
              children: _markers,
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_measurePerformance();

          // Generate random markers
          var param = <LatLng>[];
          for (var i = 0; i < randomMarkerNum; i++) {
            final lat = _rnd.nextDouble() * 20 + 30;
            final lng = _rnd.nextDouble() * 20 + 125;
            param.add(LatLng(lat, lng));
          }

          _mapController.toScreenLocationBatch(param).then((value) {
            for (var i = 0; i < randomMarkerNum; i++) {
              var point = Point<double>(value[i].x, value[i].y);
              _addMarker(point, param[i]);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // ignore: unused_element
  void _measurePerformance() {
    final trial = 10;
    final batches = [500, 1000, 1500, 2000, 2500, 3000];
    var results = Map<int, List<double>>();
    for (final batch in batches) {
      results[batch] = [0.0, 0.0];
    }

    _mapController.toScreenLocation(LatLng(0, 0));
    Stopwatch sw = Stopwatch();

    for (final batch in batches) {
      //
      // primitive
      //
      for (var i = 0; i < trial; i++) {
        sw.start();
        var list = <Future<Point<num>>>[];
        for (var j = 0; j < batch; j++) {
          var p = _mapController
              .toScreenLocation(LatLng(j.toDouble() % 80, j.toDouble() % 300));
          list.add(p);
        }
        Future.wait(list);
        sw.stop();
        results[batch][0] += sw.elapsedMilliseconds;
        sw.reset();
      }

      //
      // batch
      //
      for (var i = 0; i < trial; i++) {
        sw.start();
        var param = <LatLng>[];
        for (var j = 0; j < batch; j++) {
          param.add(LatLng(j.toDouble() % 80, j.toDouble() % 300));
        }
        Future.wait([_mapController.toScreenLocationBatch(param)]);
        sw.stop();
        results[batch][1] += sw.elapsedMilliseconds;
        sw.reset();
      }

      print(
          'batch=$batch,primitive=${results[batch][0] / trial}ms, batch=${results[batch][1] / trial}ms');
    }
  }
}

class Marker extends StatefulWidget {
  final Point _initialPosition;
  final LatLng _coordinate;
  final void Function(_MarkerState) _addMarkerState;

  Marker(
      String key, this._coordinate, this._initialPosition, this._addMarkerState)
      : super(key: Key(key));

  @override
  State<StatefulWidget> createState() {
    final state = _MarkerState(_initialPosition);
    _addMarkerState(state);
    return state;
  }
}

class _MarkerState extends State with TickerProviderStateMixin {
  final _iconSize = 20.0;

  Point _position;

  AnimationController _controller;
  Animation<double> _animation;

  _MarkerState(this._position);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ratio = 1.0;

    //web does not support Platform._operatingSystem
    if (!kIsWeb) {
      // iOS returns logical pixel while Android returns screen pixel
      ratio = Platform.isIOS ? 1.0 : MediaQuery.of(context).devicePixelRatio;
    }

    return Positioned(
        left: _position.x / ratio - _iconSize / 2,
        top: _position.y / ratio - _iconSize / 2,
        child: RotationTransition(
            turns: _animation,
            child: Image.asset('assets/symbols/2.0x/custom-icon.png',
                height: _iconSize)));
  }

  void updatePosition(Point<num> point) {
    setState(() {
      _position = point;
    });
  }

  LatLng getCoordinate() {
    return (widget as Marker)._coordinate;
  }
}

class MoveCameraPage extends ExamplePage {
  MoveCameraPage() : super(const Icon(Icons.map), 'Camera control');

  @override
  Widget build(BuildContext context) {
    return const MoveCamera();
  }
}

class MoveCamera extends StatefulWidget {
  const MoveCamera();

  @override
  State createState() => MoveCameraState();
}

class MoveCameraState extends State<MoveCamera> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: MapboxMap(
              accessToken: MapsDemo.ACCESS_TOKEN,
              onMapCreated: _onMapCreated,
              onCameraIdle: () => print("onCameraIdle"),
              initialCameraPosition:
                  const CameraPosition(target: LatLng(0.0, 0.0)),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          bearing: 270.0,
                          target: LatLng(51.5160895, -0.1294527),
                          tilt: 30.0,
                          zoom: 17.0,
                        ),
                      ),
                    );
                  },
                  child: const Text('newCameraPosition'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.newLatLng(
                        const LatLng(56.1725505, 10.1850512),
                      ),
                    );
                  },
                  child: const Text('newLatLng'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.newLatLngBounds(
                        LatLngBounds(
                          southwest: const LatLng(-38.483935, 113.248673),
                          northeast: const LatLng(-8.982446, 153.823821),
                        ),
                        left: 10,
                        top: 5,
                        bottom: 25,
                      ),
                    );
                  },
                  child: const Text('newLatLngBounds'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.newLatLngZoom(
                        const LatLng(37.4231613, -122.087159),
                        11.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngZoom'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.scrollBy(150.0, -225.0),
                    );
                  },
                  child: const Text('scrollBy'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.zoomBy(
                        -0.5,
                        const Offset(30.0, 20.0),
                      ),
                    );
                  },
                  child: const Text('zoomBy with focus'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.zoomBy(-0.5),
                    );
                  },
                  child: const Text('zoomBy'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                  child: const Text('zoomIn'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                  child: const Text('zoomOut'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.zoomTo(16.0),
                    );
                  },
                  child: const Text('zoomTo'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.bearingTo(45.0),
                    );
                  },
                  child: const Text('bearingTo'),
                ),
                TextButton(
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.tiltTo(30.0),
                    );
                  },
                  child: const Text('tiltTo'),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class PlaceCirclePage extends ExamplePage {
  PlaceCirclePage() : super(const Icon(Icons.check_circle), 'Place circle');

  @override
  Widget build(BuildContext context) {
    return const PlaceCircleBody();
  }
}

class PlaceCircleBody extends StatefulWidget {
  const PlaceCircleBody();

  @override
  State<StatefulWidget> createState() => PlaceCircleBodyState();
}

class PlaceCircleBodyState extends State<PlaceCircleBody> {
  PlaceCircleBodyState();

  static final LatLng center = const LatLng(-33.86711, 151.1947171);

  MapboxMapController controller;
  int _circleCount = 0;
  Circle _selectedCircle;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
    controller.onCircleTapped.add(_onCircleTapped);
  }

  @override
  void dispose() {
    controller?.onCircleTapped?.remove(_onCircleTapped);
    super.dispose();
  }

  void _onCircleTapped(Circle circle) {
    if (_selectedCircle != null) {
      _updateSelectedCircle(
        const CircleOptions(circleRadius: 60),
      );
    }
    setState(() {
      _selectedCircle = circle;
    });
    _updateSelectedCircle(
      CircleOptions(
        circleRadius: 30,
      ),
    );
  }

  void _updateSelectedCircle(CircleOptions changes) {
    controller.updateCircle(_selectedCircle, changes);
  }

  void _add() {
    controller.addCircle(
      CircleOptions(
          geometry: LatLng(
            center.latitude + sin(_circleCount * pi / 6.0) / 20.0,
            center.longitude + cos(_circleCount * pi / 6.0) / 20.0,
          ),
          circleColor: "#FF0000"),
    );
    setState(() {
      _circleCount += 1;
    });
  }

  void _remove() {
    controller.removeCircle(_selectedCircle);
    setState(() {
      _selectedCircle = null;
      _circleCount -= 1;
    });
  }

  void _changePosition() {
    final LatLng current = _selectedCircle.options.geometry;
    final Offset offset = Offset(
      center.latitude - current.latitude,
      center.longitude - current.longitude,
    );
    _updateSelectedCircle(
      CircleOptions(
        geometry: LatLng(
          center.latitude + offset.dy,
          center.longitude + offset.dx,
        ),
      ),
    );
  }

  void _changeDraggable() {
    bool draggable = _selectedCircle.options.draggable;
    if (draggable == null) {
      // default value
      draggable = false;
    }
    _updateSelectedCircle(
      CircleOptions(
        draggable: !draggable,
      ),
    );
  }

  void _getLatLng() async {
    LatLng latLng = await controller.getCircleLatLng(_selectedCircle);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(latLng.toString()),
      ),
    );
  }

  void _changeCircleStrokeOpacity() {
    double current = _selectedCircle.options.circleStrokeOpacity;
    if (current == null) {
      // default value
      current = 1.0;
    }

    _updateSelectedCircle(
      CircleOptions(circleStrokeOpacity: current < 0.1 ? 1.0 : current * 0.75),
    );
  }

  void _changeCircleStrokeWidth() {
    double current = _selectedCircle.options.circleStrokeWidth;
    if (current == null) {
      // default value
      current = 0;
    }
    _updateSelectedCircle(
        CircleOptions(circleStrokeWidth: current == 0 ? 5.0 : 0));
  }

  Future<void> _changeCircleStrokeColor() async {
    String current = _selectedCircle.options.circleStrokeColor;
    if (current == null) {
      // default value
      current = "#FFFFFF";
    }

    _updateSelectedCircle(
      CircleOptions(
          circleStrokeColor: current == "#FFFFFF" ? "#FF0000" : "#FFFFFF"),
    );
  }

  Future<void> _changeCircleOpacity() async {
    double current = _selectedCircle.options.circleOpacity;
    if (current == null) {
      // default value
      current = 1.0;
    }

    _updateSelectedCircle(
      CircleOptions(circleOpacity: current < 0.1 ? 1.0 : current * 0.75),
    );
  }

  Future<void> _changeCircleRadius() async {
    double current = _selectedCircle.options.circleRadius;
    if (current == null) {
      // default value
      current = 0;
    }
    _updateSelectedCircle(
      CircleOptions(circleRadius: current == 120.0 ? 30.0 : current + 30.0),
    );
  }

  Future<void> _changeCircleColor() async {
    String current = _selectedCircle.options.circleColor;
    if (current == null) {
      // default value
      current = "#FF0000";
    }

    _updateSelectedCircle(
      CircleOptions(circleColor: "#FFFF00"),
    );
  }

  Future<void> _changeCircleBlur() async {
    double current = _selectedCircle.options.circleBlur;
    if (current == null) {
      // default value
      current = 0;
    }
    _updateSelectedCircle(
      CircleOptions(circleBlur: current == 0.75 ? 0 : 0.75),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: MapboxMap(
              accessToken: MapsDemo.ACCESS_TOKEN,
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-33.852, 151.211),
                zoom: 11.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextButton(
                          child: const Text('add'),
                          onPressed: (_circleCount == 12) ? null : _add,
                        ),
                        TextButton(
                          child: const Text('remove'),
                          onPressed: (_selectedCircle == null) ? null : _remove,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                          child: const Text('change circle-opacity'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeCircleOpacity,
                        ),
                        TextButton(
                          child: const Text('change circle-radius'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeCircleRadius,
                        ),
                        TextButton(
                          child: const Text('change circle-color'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeCircleColor,
                        ),
                        TextButton(
                          child: const Text('change circle-blur'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeCircleBlur,
                        ),
                        TextButton(
                          child: const Text('change circle-stroke-width'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeCircleStrokeWidth,
                        ),
                        TextButton(
                          child: const Text('change circle-stroke-color'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeCircleStrokeColor,
                        ),
                        TextButton(
                          child: const Text('change circle-stroke-opacity'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeCircleStrokeOpacity,
                        ),
                        TextButton(
                          child: const Text('change position'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changePosition,
                        ),
                        TextButton(
                          child: const Text('toggle draggable'),
                          onPressed: (_selectedCircle == null)
                              ? null
                              : _changeDraggable,
                        ),
                        TextButton(
                          child: const Text('get current LatLng'),
                          onPressed:
                              (_selectedCircle == null) ? null : _getLatLng,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
