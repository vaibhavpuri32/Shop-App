class HttpException implements Exception
//Exception is a abstract class
{
    final String message;
    HttpException(this.message);

    String toString()
    {
      return message;
    }




}