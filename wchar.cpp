/*
 * Comparing Between
 * UTF-8
 * UTF-16
 * And char, wchar usage
 *
 * http://utf8everywhere.org/#conclusions
 * Conclusion : Use UTF-8, char, and std::string
 */
#include <iostream>
#include <bitset>

template < typename T >
void analysis( T const* data )
{
  std::cout << "std::cout : " << data << "\n";
  std::cout << "std::wcout : ";
  std::wcout << data << L"\n";
  std::cout << "binary : ";

  T const *t = data;
  while( *t )
  {
    T ch = *t;

    for( int b=0; b<sizeof(T); ++b )
    {
      int byte = ((char const*)t)[b];
      std::cout << std::bitset<8>(byte) << " ";
    }

    ++t;
  }
  std::cout << "\n\n";
}

int main()
{
  const char *char_eng = "Hello";
  const char *char_kor = "안녕";
  const wchar_t *wchar_eng = L"Hello";
  const wchar_t *wchar_kor = L"안녕";

  analysis( char_eng );
  analysis( char_kor );
  analysis( wchar_eng );
  analysis( wchar_kor );


  return 0;
}
