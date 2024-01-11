class Tile {
  bool hasMine;
  int digit;
  bool isOpen;

  Tile({
    this.hasMine = false,
    this.digit = 0,
    this.isOpen = false
  });
}