Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH 4/7] kconfig: support new special property shell=
Date: Fri,  9 Feb 2018 01:19:09 +0900
Message-Id: <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This works with bool, int, hex, string types.

For bool, the symbol is set to 'y' or 'n' depending on the exit value
of the command.

For int, hex, string, the symbol is set to the value to the stdout
of the command. (only the first line of the stdout)

The following shows how to write this and how it works.

--------------------(example Kconfig)------------------
config srctree
        string
        option env="srctree"

config CC
        string
        option env="CC"

config CC_HAS_STACKPROTECTOR
        bool
        option shell="$CC -Werror -fstack-protector -c -x c /dev/null"

config CC_HAS_STACKPROTECTOR_STRONG
        bool
        option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"

config CC_VERSION
        int
        option shell="$srctree/scripts/gcc-version.sh $CC | sed 's/^0*//'"
        help
          gcc-version.sh returns 4 digits number. Unfortunately, the preceding
          zero would cause 'number is invalid'.  Cut it off.

config CC_IS_CLANG
        bool
        option shell="$CC --version | grep -q clang"

config CC_IS_GCC
        bool
        option shell="$CC --version | grep -q gcc"
-----------------------------------------------------

  $ make alldefconfig
  scripts/kconfig/conf  --alldefconfig Kconfig
  #
  # configuration written to .config
  #
  $ cat .config
  #
  # Automatically generated file; DO NOT EDIT.
  # Linux Kernel Configuration
  #
  CONFIG_CC_HAS_STACKPROTECTOR=y
  CONFIG_CC_HAS_STACKPROTECTOR_STRONG=y
  CONFIG_CC_VERSION=504
  # CONFIG_CC_IS_CLANG is not set
  CONFIG_CC_IS_GCC=y

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/expr.h     |  1 +
 scripts/kconfig/kconf_id.c |  1 +
 scripts/kconfig/lkc.h      |  1 +
 scripts/kconfig/menu.c     |  3 ++
 scripts/kconfig/symbol.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index c16e82e..83029f92 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -183,6 +183,7 @@ enum prop_type {
 	P_IMPLY,    /* imply BAR */
 	P_RANGE,    /* range 7..100 (for a symbol) */
 	P_ENV,      /* value from environment variable */
+	P_SHELL,    /* shell command */
 	P_SYMBOL,   /* where a symbol is defined */
 };
 
diff --git a/scripts/kconfig/kconf_id.c b/scripts/kconfig/kconf_id.c
index 3ea9c5f..0db9d1c 100644
--- a/scripts/kconfig/kconf_id.c
+++ b/scripts/kconfig/kconf_id.c
@@ -34,6 +34,7 @@ static struct kconf_id kconf_id_array[] = {
 	{ "defconfig_list",	T_OPT_DEFCONFIG_LIST,	TF_OPTION },
 	{ "env",		T_OPT_ENV,		TF_OPTION },
 	{ "allnoconfig_y",	T_OPT_ALLNOCONFIG_Y,	TF_OPTION },
+	{ "shell",		T_OPT_SHELL,		TF_OPTION },
 };
 
 #define KCONF_ID_ARRAY_SIZE (sizeof(kconf_id_array)/sizeof(struct kconf_id))
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 4e23feb..8d05042 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -60,6 +60,7 @@ enum conf_def_mode {
 #define T_OPT_DEFCONFIG_LIST	2
 #define T_OPT_ENV		3
 #define T_OPT_ALLNOCONFIG_Y	4
+#define T_OPT_SHELL		5
 
 struct kconf_id {
 	const char *name;
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 9922285..6254dfb 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -216,6 +216,9 @@ void menu_add_option(int token, char *arg)
 	case T_OPT_ENV:
 		prop_add_env(arg);
 		break;
+	case T_OPT_SHELL:
+		prop_add_shell(arg);
+		break;
 	case T_OPT_ALLNOCONFIG_Y:
 		current_entry->sym->flags |= SYMBOL_ALLNOCONFIG_Y;
 		break;
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 893eae6..02ac4f4 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -4,6 +4,7 @@
  */
 
 #include <ctype.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <regex.h>
@@ -1370,6 +1371,8 @@ const char *prop_get_type_name(enum prop_type type)
 		return "prompt";
 	case P_ENV:
 		return "env";
+	case P_SHELL:
+		return "shell";
 	case P_COMMENT:
 		return "comment";
 	case P_MENU:
@@ -1420,3 +1423,74 @@ static void prop_add_env(const char *env)
 	else
 		menu_warn(current_entry, "environment variable %s undefined", env);
 }
+
+static void prop_add_shell(const char *cmd)
+{
+	struct symbol *sym, *sym2;
+	struct property *prop;
+	char *expanded_cmd;
+	FILE *p;
+	char stdout[256];
+	int ret, len;
+
+	sym = current_entry->sym;
+	for_all_properties(sym, prop, P_SHELL) {
+		sym2 = prop_get_symbol(prop);
+		if (strcmp(sym2->name, cmd))
+			menu_warn(current_entry, "redefining shell command symbol from %s",
+				  sym2->name);
+		return;
+	}
+
+	prop = prop_alloc(P_SHELL, sym);
+	prop->expr = expr_alloc_symbol(sym_lookup(cmd, SYMBOL_CONST));
+
+	expanded_cmd = sym_expand_string_value(cmd);
+
+	/* surround the command with ( ) in case it is piped commands */
+	len = strlen(expanded_cmd);
+	expanded_cmd = xrealloc(expanded_cmd, len + 3);
+	memmove(expanded_cmd + 1, expanded_cmd, len);
+	expanded_cmd[0] = '(';
+	expanded_cmd[len + 1] = ')';
+	expanded_cmd[len + 2] = 0;
+
+	switch (sym->type) {
+	case S_BOOLEAN:
+		/* suppress both stdout and stderr. */
+		len = strlen(expanded_cmd) + strlen(" >/dev/null 2>&1") + 1;
+		expanded_cmd = realloc(expanded_cmd, len);
+		strcat(expanded_cmd, " >/dev/null 2>&1");
+
+		ret = system(expanded_cmd);
+		sym_add_default(sym, ret == 0 ? "y" : "n");
+		break;
+	case S_INT:
+	case S_HEX:
+	case S_STRING:
+		/* suppress only stderr. we want to get stdout. */
+		len = strlen(expanded_cmd) + strlen(" 2>/dev/null") + 1;
+		expanded_cmd = realloc(expanded_cmd, len);
+		strcat(expanded_cmd, " 2>/dev/null");
+
+		p = popen(expanded_cmd, "r");
+		if (!p)
+			goto free;
+		if (fgets(stdout, sizeof(stdout), p)) {
+			stdout[sizeof(stdout) - 1] = 0;
+			len = strlen(stdout);
+			if (stdout[len - 1] == '\n')
+				stdout[len - 1] = 0;
+		} else {
+			stdout[0] = 0;
+		}
+		sym_add_default(sym, stdout);
+		break;
+	default:
+		menu_warn(current_entry, "unsupported type for shell command\n");
+		break;
+	}
+
+free:
+	free(expanded_cmd);
+}
-- 
2.7.4
