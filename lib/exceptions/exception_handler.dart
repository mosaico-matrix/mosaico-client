import 'package:mosaico/exceptions/coap_exception.dart';
import 'package:mosaico/widgets/dialogs/toaster.dart';

void handleException(Object error, StackTrace stackTrace)
{
  switch (error.runtimeType) {
    case CoapException:
      Toaster.error(error.toString());
      break;
  }
}