" Common ANSI-standard functions
syn keyword cAnsiFunction MULU_ DIVU_ MODU_ MUL_ DIV_ MOD_
syn keyword cAnsiFunction main typeof
syn keyword cAnsiFunction open close read write lseek dup dup2
syn keyword cAnsiFunction fcntl ioctl
syn keyword cAnsiFunction wctrans towctrans towupper
syn keyword cAnsiFunction towlower wctype iswctype
syn keyword cAnsiFunction iswxdigit iswupper iswspace
syn keyword cAnsiFunction iswpunct iswprint iswlower
syn keyword cAnsiFunction iswgraph iswdigit iswcntrl
syn keyword cAnsiFunction iswalpha iswalnum wcsrtombs
syn keyword cAnsiFunction mbsrtowcs wcrtomb mbrtowc
syn keyword cAnsiFunction mbrlen mbsinit wctob
syn keyword cAnsiFunction btowc wcsfxtime wcsftime
syn keyword cAnsiFunction wmemset wmemmove wmemcpy
syn keyword cAnsiFunction wmemcmp wmemchr wcstok
syn keyword cAnsiFunction wcsstr wcsspn wcsrchr
syn keyword cAnsiFunction wcspbrk wcslen wcscspn
syn keyword cAnsiFunction wcschr wcsxfrm wcsncmp
syn keyword cAnsiFunction wcscoll wcscmp wcsncat
syn keyword cAnsiFunction wcscat wcsncpy wcscpy
syn keyword cAnsiFunction wcstoull wcstoul wcstoll
syn keyword cAnsiFunction wcstol wcstold wcstof
syn keyword cAnsiFunction wcstod ungetwc putwchar
syn keyword cAnsiFunction putwc getwchar getwc
syn keyword cAnsiFunction fwide fputws fputwc
syn keyword cAnsiFunction fgetws fgetwc wscanf
syn keyword cAnsiFunction wprintf vwscanf vwprintf
syn keyword cAnsiFunction vswscanf vswprintf vfwscanf
syn keyword cAnsiFunction vfwprintf swscanf swprintf
syn keyword cAnsiFunction fwscanf fwprintf zonetime
syn keyword cAnsiFunction strfxtime strftime localtime
syn keyword cAnsiFunction gmtime ctime asctime
syn keyword cAnsiFunction time mkxtime mktime
syn keyword cAnsiFunction difftime clock strlen
syn keyword cAnsiFunction strerror memset strtok
syn keyword cAnsiFunction strstr strspn strrchr
syn keyword cAnsiFunction strpbrk strcspn strchr
syn keyword cAnsiFunction memchr strxfrm strncmp
syn keyword cAnsiFunction strcoll strcmp memcmp
syn keyword cAnsiFunction strncat strcat strncpy
syn keyword cAnsiFunction strcpy memmove memcpy
syn keyword cAnsiFunction wcstombs mbstowcs wctomb
syn keyword cAnsiFunction mbtowc mblen lldiv
syn keyword cAnsiFunction ldiv div llabs
syn keyword cAnsiFunction labs abs qsort
syn keyword cAnsiFunction bsearch system getenv
syn keyword cAnsiFunction exit atexit abort
syn keyword cAnsiFunction realloc malloc free
syn keyword cAnsiFunction calloc srand rand
syn keyword cAnsiFunction strtoull strtoul strtoll
syn keyword cAnsiFunction strtol strtold strtof
syn keyword cAnsiFunction strtod atoll atol
syn keyword cAnsiFunction atoi atof perror
syn keyword cAnsiFunction ferror feof clearerr
syn keyword cAnsiFunction rewind ftell fsetpos
syn keyword cAnsiFunction fseek fgetpos fwrite
syn keyword cAnsiFunction fread ungetc puts
syn keyword cAnsiFunction putchar putc gets
syn keyword cAnsiFunction getchar getc fputs
syn keyword cAnsiFunction fputc fgets fgetc
syn keyword cAnsiFunction vsscanf vsprintf vsnprintf
syn keyword cAnsiFunction vscanf vprintf vfscanf
syn keyword cAnsiFunction vfprintf sscanf sprintf
syn keyword cAnsiFunction snprintf scanf printf
syn keyword cAnsiFunction fscanf fprintf setvbuf
syn keyword cAnsiFunction setbuf freopen fopen
syn keyword cAnsiFunction fflush fclose tmpnam
syn keyword cAnsiFunction tmpfile rename remove
syn keyword cAnsiFunction offsetof va_start va_end
syn keyword cAnsiFunction va_copy va_arg raise signal
syn keyword cAnsiFunction longjmp setjmp isunordered
syn keyword cAnsiFunction islessgreater islessequal isless
syn keyword cAnsiFunction isgreaterequal isgreater fmal
syn keyword cAnsiFunction fmaf fma fminl
syn keyword cAnsiFunction fminf fmin fmaxl
syn keyword cAnsiFunction fmaxf fmax fdiml
syn keyword cAnsiFunction fdimf fdim nextafterxl
syn keyword cAnsiFunction nextafterxf nextafterx nextafterl
syn keyword cAnsiFunction nextafterf nextafter nanl
syn keyword cAnsiFunction nanf nan copysignl
syn keyword cAnsiFunction copysignf copysign remquol
syn keyword cAnsiFunction remquof remquo remainderl
syn keyword cAnsiFunction remainderf remainder fmodl
syn keyword cAnsiFunction fmodf fmod truncl
syn keyword cAnsiFunction truncf trunc llroundl
syn keyword cAnsiFunction llroundf llround lroundl
syn keyword cAnsiFunction lroundf lround roundl
syn keyword cAnsiFunction roundf round llrintl
syn keyword cAnsiFunction llrintf llrint lrintl
syn keyword cAnsiFunction lrintf lrint rintl
syn keyword cAnsiFunction rintf rint nearbyintl
syn keyword cAnsiFunction nearbyintf nearbyint floorl
syn keyword cAnsiFunction floorf floor ceill
syn keyword cAnsiFunction ceilf ceil tgammal
syn keyword cAnsiFunction tgammaf tgamma lgammal
syn keyword cAnsiFunction lgammaf lgamma erfcl
syn keyword cAnsiFunction erfcf erfc erfl
syn keyword cAnsiFunction erff erf sqrtl
syn keyword cAnsiFunction sqrtf sqrt powl
syn keyword cAnsiFunction powf pow hypotl
syn keyword cAnsiFunction hypotf hypot fabsl
syn keyword cAnsiFunction fabsf fabs cbrtl
syn keyword cAnsiFunction cbrtf cbrt scalblnl
syn keyword cAnsiFunction scalblnf scalbln scalbnl
syn keyword cAnsiFunction scalbnf scalbn modfl
syn keyword cAnsiFunction modff modf logbl
syn keyword cAnsiFunction logbf logb log2l
syn keyword cAnsiFunction log2f log2 log1pl
syn keyword cAnsiFunction log1pf log1p log10l
syn keyword cAnsiFunction log10f log10 logl
syn keyword cAnsiFunction logf log ldexpl
syn keyword cAnsiFunction ldexpf ldexp ilogbl
syn keyword cAnsiFunction ilogbf ilogb frexpl
syn keyword cAnsiFunction frexpf frexp expm1l
syn keyword cAnsiFunction expm1f expm1 exp2l
syn keyword cAnsiFunction exp2f exp2 expl
syn keyword cAnsiFunction expf exp tanhl
syn keyword cAnsiFunction tanhf tanh sinhl
syn keyword cAnsiFunction sinhf sinh coshl
syn keyword cAnsiFunction coshf cosh atanhl
syn keyword cAnsiFunction atanhf atanh asinhl
syn keyword cAnsiFunction asinhf asinh acoshl
syn keyword cAnsiFunction acoshf acosh tanl
syn keyword cAnsiFunction tanf tan sinl
syn keyword cAnsiFunction sinf sin cosl
syn keyword cAnsiFunction cosf cos atan2l
syn keyword cAnsiFunction atan2f atan2 atanl
syn keyword cAnsiFunction atanf atan asinl
syn keyword cAnsiFunction asinf asin acosl
syn keyword cAnsiFunction acosf acos signbit
syn keyword cAnsiFunction isnormal isnan isinf
syn keyword cAnsiFunction isfinite fpclassify localeconv
syn keyword cAnsiFunction setlocale wcstoumax wcstoimax
syn keyword cAnsiFunction strtoumax strtoimax feupdateenv
syn keyword cAnsiFunction fesetenv feholdexcept fegetenv
syn keyword cAnsiFunction fesetround fegetround fetestexcept
syn keyword cAnsiFunction fesetexceptflag feraiseexcept fegetexceptflag
syn keyword cAnsiFunction feclearexcept toupper tolower
syn keyword cAnsiFunction isxdigit isupper isspace
syn keyword cAnsiFunction ispunct isprint islower
syn keyword cAnsiFunction isgraph isdigit iscntrl
syn keyword cAnsiFunction isalpha isalnum creall
syn keyword cAnsiFunction crealf creal cprojl
syn keyword cAnsiFunction cprojf cproj conjl
syn keyword cAnsiFunction conjf conj cimagl
syn keyword cAnsiFunction cimagf cimag cargl
syn keyword cAnsiFunction cargf carg csqrtl
syn keyword cAnsiFunction csqrtf csqrt cpowl
syn keyword cAnsiFunction cpowf cpow cabsl
syn keyword cAnsiFunction cabsf cabs clogl
syn keyword cAnsiFunction clogf clog cexpl
syn keyword cAnsiFunction cexpf cexp ctanhl
syn keyword cAnsiFunction ctanhf ctanh csinhl
syn keyword cAnsiFunction csinhf csinh ccoshl
syn keyword cAnsiFunction ccoshf ccosh catanhl
syn keyword cAnsiFunction catanhf catanh casinhl
syn keyword cAnsiFunction casinhf casinh cacoshl
syn keyword cAnsiFunction cacoshf cacosh ctanl
syn keyword cAnsiFunction ctanf ctan csinl
syn keyword cAnsiFunction csinf csin ccosl
syn keyword cAnsiFunction ccosf ccos catanl
syn keyword cAnsiFunction catanf catan casinl
syn keyword cAnsiFunction casinf casin cacosl
syn keyword cAnsiFunction cacosf cacos assert

" Operators
syn match cOperator "\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match cOperator "<<\|>>\|++\|--"
syn match cOperator "[!~&%^|=+-]"
syn match cOperator "/\([^*]\)\@="
syn match cOperator "*\([^/]\)\@="
"syn match cOperator "*\@=[^/]"

" Conditionals
syn match cConditional "&&\|||\|=="

" Delimiters
syn match cDelimiter "[{}();\\.,:\[\]]"
syn match cDelimiter "->"

" Booleans
syn keyword cBoolean true false TRUE FALSE

" Links
hi link cAnsiFunction cFunction
hi link cFunction Function
hi link cOperator Delimiter
hi link cDelimiter Delimiter
hi link cBoolean Boolean
