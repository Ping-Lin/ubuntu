"type
syn keyword	SYNOType	SYNOLINKAGGROPT NETINFO SLIBNETIF ETHINFO NETIPV6 BOOL PSLIBSZHASH PSLIBSZLIST PSYNOUSER PSYNOGROUP LDAP_HOST LDAP_LDIF LDAP_SEARCH_REQUEST LDAP_RESULT SYNOUSER SYNOGROUP SLIBSZHASH SLIBSZLIST AUTH_TYPE PSYNOSHARE PSYNOSHAREDB
syn keyword	cppSTLType	string vector list map multimap ofstream ifstream ostream istream stringstream
syn keyword	cSTDType	pid_t gid_t uid_t socklen_t

" function
syn keyword	cSTDFunction	bzero strcpy strcmp strncmp snprintf strcasecmp strncasecmp stpcpy system getpid access strncpy strtol strtoul strlen
syn keyword	SYNOFunction	StrCP SYNOSDK_CHECK_ARGS
syn keyword	cppLIBFunction	isMember isObject isArray asBool asCString asString push_back push_front c_str

" constant
syn keyword	SYNOConstant	TRUE FALSE
syn keyword	cSTDConstant	X_OK W_OK R_OK F_OK LOG_EMERG LOG_ALERT LOG_CRIT LOG_ERR LOG_WARNING LOG_NOTICE LOG_INFO LOG_DEBUG WNOHANG WUNTRACED WCONTINUED

" operator
syn keyword	SYNODebug	DLOG DTTY DTTY_INDENT SYSLOG

" format & macro
syn keyword	SYNOFormat	SLIBERR_FMT SLIBERR_ARGS
syn keyword	cSTDMacro	errno optind opterr optarg optopt
syn keyword	BoostMacro	BOOST_FOREACH
syn keyword	SYNOSMBFormat	SYNOSMB_LOG SYNOSMB_ERR DEBUG DEBUGC SYNOSMB_FOLD SYNOSMB_FOLD_END SYNOSMB_SZ SYNOSMB_SZ_INIT_NON_REENTRANT SYNOSMB_ASSERT SYNOSMB_SZ_ADD SYNOSMB_SZ_ADD_FLAG SYNOSMB_SZ_ADD_FLAG_REST
syn keyword	cBkpMacro	SYNOBACKUP_ERROR SYNOBACKUP_ERROR_SDK SYNOBACKUP_WARN SYNOBACKUP_INFO SYNOBACKUP_DEBUG
syn keyword	cGtestMacro	ASSERT_TRUE ASSERT_EQ ASSERT_NE EXPECT_EQ EXPECT_TRUE EXPECT_NE 


hi def link cppSTLType			Type
hi def link cppLIBFunction		Function

hi def link cSTDType			Type
hi def link cSTDFunction		Function
hi def link cSTDConstant		Constant

hi def link SYNOType			Type
hi def link SYNOFunction		Function
hi def link SYNODebug			Operator
hi def link SYNOConstant		Constant
hi def link SYNOFormat			SpecialChar
hi def link SYNOSMBFormat		SpecialChar
hi def link cSTDMacro			Macro
hi def link cBkpMacro			Macro
hi def link BoostMacro			Macro
hi def link cGtestMacro			Macro

