Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 9 Jul 2018 10:55:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Build/qemu test results for v4.18-rc4
Message-ID: <20180709175550.GA7469@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Build results:
	total: 134 pass: 130 fail: 4
Failed builds: 
	nds32:defconfig 
	nds32:allnoconfig 
	s390:allmodconfig 
	sparc32:allmodconfig
Qemu test results:
	total: 158 pass: 158 fail: 0

---
nds32:defconfig:

nds32le-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_init':
timekeeping.c:(.init.text+0x1a8): undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1ac): undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1ec): undefined reference to `__lshrdi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1f0): undefined reference to `__lshrdi3'

Fix is available in -next with commit 78945c357f5 ("nds32: Fix build error
caused by configuration flag rename").

---
s390:allmodconfig:

arch/s390/kernel/als.o: In function `verify_facilities':
als.c:(.init.text+0x24): undefined reference to `latent_entropy'
als.c:(.init.text+0xae): undefined reference to `latent_entropy'
make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
make[1]: *** [bzImage] Error 2

This problem is only seen when using a compiler which has the relevant
plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
know if a fix for v4.18 has been submitted. The s390 boot code in -next
has been rearranged and the problem is no longer seen there.

---
sparc32:allmodconfig:

include/linux/highmem.h: In function 'clear_user_highpage':
include/linux/highmem.h:137:31: error:
	passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type

A possible fix is available at https://patchwork.kernel.org/patch/10497941/.

Guenter
