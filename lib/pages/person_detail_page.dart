import 'package:flutter/material.dart';
import 'package:douban_app/manager/router.dart';
import 'package:douban_app/http/API.dart';
import 'package:douban_app/bean/celebrity_entity.dart';

class PersonDetailPage extends StatefulWidget {
  final String id;
  final String personImgUrl;

  const PersonDetailPage(this.personImgUrl, this.id, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PersonDetailPageState();
  }
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  API _api = API();
  CelebrityEntity celebrityEntity;

  @override
  void initState() {
    super.initState();
    _api.searchCelebrity(widget.id, (celebrityEntity) {
      setState(() {
        this.celebrityEntity = celebrityEntity;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _getBody()),
    );
  }

  _getBody() {
    if (celebrityEntity == null) {
      return _PersonPhoto(
        photoUrl: widget.personImgUrl,
      );
    } else {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _PersonPhoto(
                photoUrl: widget.personImgUrl,
              ),
              Column(
                children: <Widget>[
                  Text(celebrityEntity.name),
                  Text(celebrityEntity.name_en),
                ],
              )
            ],
          )
        ],
      );
    }
  }
}

class _PersonPhoto extends StatelessWidget {
  const _PersonPhoto({Key key, this.photoUrl}) : super(key: key);
  final String photoUrl;

  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      child: Hero(
        tag: photoUrl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              photoUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
