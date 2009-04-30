Return-Path: <linux-kernel-owner+w=401wt.eu-S932286AbZEAAKf@vger.kernel.org>
From: Tim Abbott <tabbott@MIT.EDU>
Subject: [PATCH 0/6] section name cleanup for s390
Date: Thu, 30 Apr 2009 19:57:15 -0400
Message-Id: <1241135841-9619-1-git-send-email-tabbott@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>
List-ID: <linux-s390.vger.kernel.org>

This patch series cleans up the section names on the s390
architecture.  It requires the architecture-independent macro
definitions from this patch series:

<http://www.spinics.net/lists/mips/msg33499.html>

The long-term goal here is to add support for building the kernel with
-ffunction-sections -fdata-sections.  This requires renaming all the
magic section names in the kernel of the form .text.foo, .data.foo,
.bss.foo, and .rodata.foo to not have collisions with sections
generated for code like:

static int nosave = 0; /* -fdata-sections places in .data.nosave */
static void head(); /* -ffunction-sections places in .text.head */

Note that these patches have not been boot-tested (aside from testing
the analogous changes on x86), since I don't have access to the
appropriate hardware.

	-Tim Abbott


Tim Abbott (6):
  s390: Use macros for .data.page_aligned.
  s390: use NOSAVE_DATA macro for .data.nosave section.
  s390: use new macro for .data.cacheline_aligned section.
  s390: use new macros for .data.init_task.
  s390: use new macro for .data.read_mostly section.
  s390: convert to new generic read_mostly support.

 arch/s390/Kconfig                        |    3 ++
 arch/s390/include/asm/cache.h            |    2 -
 arch/s390/kernel/init_task.c             |    3 +-
 arch/s390/kernel/vdso.c                  |    2 +-
 arch/s390/kernel/vdso32/vdso32_wrapper.S |    3 +-
 arch/s390/kernel/vdso64/vdso64_wrapper.S |    3 +-
 arch/s390/kernel/vmlinux.lds.S           |   33 ++++-------------------------
 7 files changed, 14 insertions(+), 35 deletions(-)
