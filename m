Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC PATCH 0/7] Kconfig: add new special property shell= to test compiler options in Kconfig
Date: Fri,  9 Feb 2018 01:19:05 +0900
Message-Id: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This was prompted by the email from Linus today's morning.

I implmented this in a rush today, so there are still many TODOs,
but I put it here to start discussion.

I think it is working, but as you notice, it is tedious to repeat something
like follows:

config CC_HAS_STACKPROTECTOR
        bool
        option shell="$CC -Werror -fstack-protector -c -x c /dev/null"

One possiblity is to put this ugly code into script like follows,

config CC_STACKPROTECTOR
          bool
          option shell="$srctree/scripts/cc-option.sh $CC -fstack-protector"

... but this is longer.

I was thinking of something like follows:

config CC_STACKPROTECTOR
          bool
          option shell="$(CC_OPTION -fstack-protector)"

Need time to brush up details.

Comments are appreciated.



Masahiro Yamada (7):
  kbuild: remove kbuild cache
  kconfig: add xrealloc() helper
  kconfig: remove const qualifier from sym_expand_string_value()
  kconfig: support new special property shell=
  kconfig: invoke silentoldconfig when compiler is updated
  kconfig: add basic environments to evaluate C flags in Kconfig
  Test stackprotector options in Kconfig to kill CC_STACKPROTECTOR_AUTO

 Makefile                    |  65 +++++++---------------------
 arch/Kconfig                |  54 +++++++++++++----------
 init/Kconfig                |  17 ++++++++
 scripts/Kbuild.include      | 101 ++++++--------------------------------------
 scripts/kconfig/confdata.c  |   2 +-
 scripts/kconfig/expr.h      |   1 +
 scripts/kconfig/kconf_id.c  |   1 +
 scripts/kconfig/lkc.h       |   2 +
 scripts/kconfig/lkc_proto.h |   2 +-
 scripts/kconfig/menu.c      |   3 ++
 scripts/kconfig/nconf.gui.c |   2 +-
 scripts/kconfig/symbol.c    |  78 +++++++++++++++++++++++++++++++++-
 scripts/kconfig/util.c      |  15 +++++--
 scripts/kconfig/zconf.l     |   2 +-
 14 files changed, 176 insertions(+), 169 deletions(-)

-- 
2.7.4
