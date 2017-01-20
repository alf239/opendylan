Module: odbc-ffi
Author: yduJ
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

// This file is automatically generated from "sqltypes.j"; do not edit.

define constant <SQLCHAR> = <C-unsigned-char>;
define constant <SQLDATE> = <C-unsigned-char>;
define constant <SQLDECIMAL> = <C-unsigned-char>;
define constant <SQLDOUBLE> = <C-double>;
define constant <SQLFLOAT> = <C-double>;
define constant <SQLINTEGER> = <C-both-long>;
define constant <SQLUINTEGER> = <C-both-unsigned-long>;
define constant <SQLNUMERIC> = <C-unsigned-char>;
define constant <SQLPOINTER> = <C-void*>;
define constant <SQLREAL> = <C-float>;
define constant <SQLSMALLINT> = <C-short>;
define constant <SQLUSMALLINT> = <C-unsigned-short>;
define constant <SQLTIME> = <C-unsigned-char>;
define constant <SQLTIMESTAMP> = <C-unsigned-char>;
define constant <SQLVARCHAR> = <C-unsigned-char>;
define constant <SQLRETURN> = <SQLSMALLINT>;
define constant <SQLHANDLE> = <SQLPOINTER>;
define constant <SQLHENV> = <SQLHANDLE>;
define constant <SQLHDBC> = <SQLHANDLE>;
define constant <SQLHSTMT> = <SQLHANDLE>;
define constant <SQLHDESC> = <SQLHANDLE>;
define constant <UCHAR> = <C-unsigned-char>;
define constant <SCHAR> = <C-char>;
define constant <SQLSCHAR> = <SCHAR>;
define constant <SDWORD> = <C-both-long>;
define constant <SWORD> = <C-short>;
define constant <ULONG> = <C-both-unsigned-long>;
define constant <USHORT> = <C-unsigned-short>;
define constant <SDOUBLE> = <C-double>;
define constant <LDOUBLE> = <C-double>;
define constant <SFLOAT> = <C-float>;
define constant <PTR> = <C-void*>;
define constant <HENV> = <C-void*>;
define constant <HDBC> = <C-void*>;
define constant <HSTMT> = <C-void*>;
define constant <SQLHWND> = <SQLPOINTER>;
define constant <LPSQLCHAR> = <c-string>;
define c-pointer-type <LPSQLHDBC> => <SQLHDBC>;
define c-pointer-type <LPSQLHENV> => <SQLHENV>;
define c-pointer-type <LPSQLHSTMT> => <SQLHSTMT>;
define c-pointer-type <LPSQLHANDLE> => <SQLHANDLE>;
define c-pointer-type <LPSQLSMALLINT> => <SQLSMALLINT>;
define c-pointer-type <LPSQLINTEGER> => <SQLINTEGER>;
define c-pointer-type <LPSQLPOINTER> => <SQLPOINTER>;
define c-pointer-type <LPSQLUINTEGER> => <SQLUINTEGER>;
define c-pointer-type <LPSQLUSMALLINT> => <SQLUSMALLINT>;

define C-struct <DATE-STRUCT>
  slot year-value  :: <SQLSMALLINT>;
  slot month-value :: <SQLUSMALLINT>;
  slot day-value   :: <SQLUSMALLINT>;
  pointer-type-name: <LPDATE-STRUCT>;
  c-name: "struct tagDATE_STRUCT";
end C-struct <DATE-STRUCT>;
define constant <SQL-DATE-STRUCT> = <DATE-STRUCT>;

define C-struct <TIME-STRUCT>
  slot hour-value  :: <SQLUSMALLINT>;
  slot minute-value :: <SQLUSMALLINT>;
  slot second-value :: <SQLUSMALLINT>;
  pointer-type-name: <LPTIME-STRUCT>;
  c-name: "struct tagTIME_STRUCT";
end C-struct <TIME-STRUCT>;
define constant <SQL-TIME-STRUCT> = <TIME-STRUCT>;

define C-struct <TIMESTAMP-STRUCT>
  slot year-value  :: <SQLSMALLINT>;
  slot month-value :: <SQLUSMALLINT>;
  slot day-value   :: <SQLUSMALLINT>;
  slot hour-value  :: <SQLUSMALLINT>;
  slot minute-value :: <SQLUSMALLINT>;
  slot second-value :: <SQLUSMALLINT>;
  slot fraction-value :: <SQLUINTEGER>;
  pointer-type-name: <LPTIMESTAMP-STRUCT>;
  c-name: "struct tagTIMESTAMP_STRUCT";
end C-struct <TIMESTAMP-STRUCT>;
define constant <SQL-TIMESTAMP-STRUCT> = <TIMESTAMP-STRUCT>;
// enum SQLINTERVAL:
define constant $SQL-IS-YEAR = 1;
define constant $SQL-IS-MONTH = 2;
define constant $SQL-IS-DAY = 3;
define constant $SQL-IS-HOUR = 4;
define constant $SQL-IS-MINUTE = 5;
define constant $SQL-IS-SECOND = 6;
define constant $SQL-IS-YEAR-TO-MONTH = 7;
define constant $SQL-IS-DAY-TO-HOUR = 8;
define constant $SQL-IS-DAY-TO-MINUTE = 9;
define constant $SQL-IS-DAY-TO-SECOND = 10;
define constant $SQL-IS-HOUR-TO-MINUTE = 11;
define constant $SQL-IS-HOUR-TO-SECOND = 12;
define constant $SQL-IS-MINUTE-TO-SECOND = 13;


define C-struct <SQL-YEAR-MONTH-STRUCT>
  slot year-value  :: <SQLUINTEGER>;
  slot month-value :: <SQLUINTEGER>;
  pointer-type-name: <LPSQL-YEAR-MONTH-STRUCT>;
  c-name: "struct tagSQL_YEAR_MONTH";
end C-struct <SQL-YEAR-MONTH-STRUCT>;

define C-struct <SQL-DAY-SECOND-STRUCT>
  slot day-value   :: <SQLUINTEGER>;
  slot hour-value  :: <SQLUINTEGER>;
  slot minute-value :: <SQLUINTEGER>;
  slot second-value :: <SQLUINTEGER>;
  slot fraction-value :: <SQLUINTEGER>;
  pointer-type-name: <LPSQL-DAY-SECOND-STRUCT>;
  c-name: "struct tagSQL_DAY_SECOND";
end C-struct <SQL-DAY-SECOND-STRUCT>;
define C-union <intval%1>
  slot year-month-value :: <SQL-YEAR-MONTH-STRUCT>;
  slot day-second-value :: <SQL-DAY-SECOND-STRUCT>;
end;

define C-struct <SQL-INTERVAL-STRUCT>
  slot interval-type-value :: <C-int>;
  slot interval-sign-value :: <SQLSMALLINT>;
  slot intval-value :: <intval%1>;
  pointer-type-name: <LPSQL-INTERVAL-STRUCT>;
  c-name: "struct tagSQL_INTERVAL_STRUCT";
end C-struct <SQL-INTERVAL-STRUCT>;

define C-struct <SQL-NUMERIC-STRUCT>
  slot precision-value :: <SQLCHAR>;
  slot scale-value :: <SQLSCHAR>;
  slot sign-value  :: <SQLCHAR>;
  array slot val-array :: <SQLCHAR>, length: 16,
        address-getter: val-value;
  pointer-type-name: <LPSQL-NUMERIC-STRUCT>;
  c-name: "struct tagSQL_NUMERIC_STRUCT";
end C-struct <SQL-NUMERIC-STRUCT>;

define constant <wchar-t> = <C-unsigned-char>;
define constant <SQLWCHAR> = <wchar-t>;
define constant <SQLTCHAR> = <SQLCHAR>;

