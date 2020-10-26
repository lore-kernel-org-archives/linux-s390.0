Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 26 Oct 2020 13:49:08 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 1/1] s390: correct __bootdata / __bootdata_preserved macros
Message-ID: <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
References: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
 <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
List-ID: <linux-s390.vger.kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

Currently s390 build is broken.

  SECTCMP .boot.data
error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
make[2]: *** [arch/s390/boot/section_cmp.boot.data] Error 1
  SECTCMP .boot.preserved.data
error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
make[2]: *** [arch/s390/boot/section_cmp.boot.preserved.data] Error 1
make[1]: *** [bzImage] Error 2

Commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
to __section("foo")") converted all __section(foo) to __section("foo").
This is wrong for __bootdata / __bootdata_preserved macros which want
variable names to be a part of intermediate section names .boot.data.<var
name> and .boot.preserved.data.<var name>. Those sections are later
sorted by alignment + name and merged together into final .boot.data
/ .boot.preserved.data sections. Those sections must be identical in
the decompressor and the decompressed kernel (that is checked during
the build).

Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/include/asm/sections.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/sections.h b/arch/s390/include/asm/sections.h
index a996d3990a02..0c2151451ba5 100644
--- a/arch/s390/include/asm/sections.h
+++ b/arch/s390/include/asm/sections.h
@@ -26,14 +26,14 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
  * final .boot.data section, which should be identical in the decompressor and
  * the decompressed kernel (that is checked during the build).
  */
-#define __bootdata(var) __section(".boot.data.var") var
+#define __bootdata(var) __section(".boot.data." #var) var
 
 /*
  * .boot.preserved.data is similar to .boot.data, but it is not part of the
  * .init section and thus will be preserved for later use in the decompressed
  * kernel.
  */
-#define __bootdata_preserved(var) __section(".boot.preserved.data.var") var
+#define __bootdata_preserved(var) __section(".boot.preserved.data." #var) var
 
 extern unsigned long __sdma, __edma;
 extern unsigned long __stext_dma, __etext_dma;
-- 
2.25.4
