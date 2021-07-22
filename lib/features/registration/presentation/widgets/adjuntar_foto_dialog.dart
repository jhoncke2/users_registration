import 'package:flutter/material.dart';

/*
class AdjuntarFotosDialog extends StatelessWidget {
  final ImagePicker _imagePicker = ImagePicker();
  BuildContext _context;
  AdjuntarFotosDialog();

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Container(
      margin: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.025
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.height * 0.045
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createHeadComponents(),
          FotosPorAgregarGroup(),
          _createSubirArchivoButton()
        ],
      ),
    );
  }

  void _initInitialConfiguration(BuildContext appContext){
    _context = appContext;
    _imagesBloc = BlocProvider.of<ImagesOldBloc>(_context);
    _commImagesWidgBloc = BlocProvider.of<CommentedImagesBloc>(_context);
    _indexBloc = BlocProvider.of<IndexOldBloc>(_context);    
  }

  Widget _createHeadComponents(){
    return Container(
      child: Column(
        children: [
          _createTitle(),
          _createDivider(),
          _createExaminarButton()
        ],
      ),
    );
  }

  Widget _createTitle(){
    return Container(
      width: double.infinity,
      child: Text(
        'Adjuntar foto',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Theme.of(_context).primaryColor,
          fontSize: 15
        ),
      ),
    );
  }

  Widget _createDivider(){
    return Divider(
      color: Colors.black54,
    );
  }

  Widget _createExaminarButton(){
    return GeneralButton(
      text: 'Examinar', 
      onPressed: _onExaminarPressed, 
      backgroundColor: Theme.of(_context).secondaryHeaderColor
    );
  }

  void _onExaminarPressed()async{
     try{
        await _tryOnExaminarPressed();
     }catch(err){
       print('Ocurrió un error');
       print(err);
       Navigator.of(_context).pop();
     }
  }

  Future<void> _tryOnExaminarPressed()async{
    PickedFile pickedFile = await _imagePicker.getImage(
      source: ImageSource.gallery
    );
    final File photo = File(pickedFile.path);
  }

  Widget _createSubirArchivoButton(){
    return GeneralButton(
      text: 'Subir archivo',
      backgroundColor: Theme.of(_context).secondaryHeaderColor,
      onPressed: _onSubirArchivoPressed
    );
  }

  void _onSubirArchivoPressed(){
    //_addCurrentPhotosToCommentedImages();
    //_resetFotosPorAgregar();
    //Navigator.of(_context).pop();
    PagesNavigationManager.updateImgsToCommentedImgs();
    Navigator.of(_context).pop();
  }


  void _addCurrentPhotosToCommentedImages(){
    final AddImages addImagesEvent = AddImages(images: _imagesBloc.state.currentPhotosToSet, onEnd: _changeNPagesToIndex);
    _commImagesWidgBloc.add(addImagesEvent);
  }

  void _changeNPagesToIndex(){
    final CommentedImagesState commImgsState = _commImagesWidgBloc.state;
    final int newIndexNPages = commImgsState.nPaginasDeCommImages;
    final ChangeNPages changesNPagesEvent = ChangeNPages(nPages: newIndexNPages);
    _indexBloc.add(changesNPagesEvent);
  }

  void _resetFotosPorAgregar(){ 
    final ResetImages resetAllEvent = ResetImages();
    _imagesBloc.add(resetAllEvent);
  }
}
*/