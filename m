Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 6 Aug 2018 15:17:41 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 0/4] ftrace build improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

Support for -fentry -mrecord-mcount and -mnop-mcount has been added for
s390 in gcc master branch. An attempt to build 4.18 for s390 with that
gcc would produce a kernel with no __mcount_loc though because of the
new condition in scripts/Makefile.build:210 which disables recordmcount
tool if compiler supports -mrecord-mcount (s390 relies on combination
of -mhotpatch=0,3 gcc flag and recordmcount.pl).

This patch series adds s390 ftrace support based on combination of -pg
-fentry -mrecord-mcount and -mnop-mcount gcc flags (that fixes issue
mentioned above). At the same time this patch series fixes couple of
minor issues and adds -mnop-mcount gcc flag support (utilized by s390).

Vasily Gorbik (4):
  trace: handle CC_FLAGS_FTRACE more accurately
  trace: avoid calling cc-option -mrecord-mcount for every Makefile
  trace: add -mcount-nop option support
  s390/ftrace: add -mfentry and -mnop-mcount support

 Makefile                       | 24 ++++++++++++++++++++----
 arch/s390/Kconfig              |  2 ++
 arch/s390/Makefile             | 16 +++++++++-------
 arch/s390/include/asm/ftrace.h |  6 +++---
 arch/s390/kernel/ftrace.c      |  2 +-
 arch/s390/kernel/mcount.S      |  2 +-
 kernel/trace/Kconfig           |  5 +++++
 kernel/trace/ftrace.c          |  2 ++
 scripts/Makefile.build         |  9 +++------
 9 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.18.0.13.gd42ae10
