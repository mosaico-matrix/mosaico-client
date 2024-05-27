enum MatrixWidgetEnum
{
  IDLE,
  ERROR,
  TEXT
}

enum MatrixGameEnum
{
  PIXEL_MOVER,
  TETROS,
}

/// This class is used to convert the enum values to the values that the matrix can understand
/// This is because dart is shit and can't convert enums to int
abstract class MatrixRunnerValue
{
  static int getMatrixWidgetEnumValue(MatrixWidgetEnum value)
  {
    switch(value)
    {
      case MatrixWidgetEnum.IDLE:
        return -2;
      case MatrixWidgetEnum.ERROR:
        return -1;
      case MatrixWidgetEnum.TEXT:
        return 0;
    }
  }

  static int getMatrixGameEnumValue(MatrixGameEnum value)
  {
    switch(value)
    {
      case MatrixGameEnum.PIXEL_MOVER:
        return -1;
      case MatrixGameEnum.TETROS:
        return 0;
    }
  }
}