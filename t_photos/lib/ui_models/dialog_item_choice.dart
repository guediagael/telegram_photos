class DialogItemChoice {
  final String text;
  final Function onSelected;

  DialogItemChoice(this.text, this.onSelected);
}

typedef DialogItemChoiceList = List<DialogItemChoice>;
