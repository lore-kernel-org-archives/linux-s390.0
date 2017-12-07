Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] s390/decompressor: add fortify_panic as x86 has.
Date: Thu,  7 Dec 2017 11:37:27 +0100
Message-Id: <20171207103727.9461-1-msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Suchanek <msuchanek@suse.de>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Fix following error:

  LD      arch/s390/boot/compressed/vmlinux
drivers/s390/char/sclp_early_core.o: In function `memcpy':
../include/linux/string.h:340: undefined reference to `fortify_panic'
make[4]: *** [../arch/s390/boot/compressed/Makefile:29: arch/s390/boot/compressed/vmlinux] Error 1

Fixes: 79962038dffa ("s390: add support for FORTIFY_SOURCE")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/s390/boot/compressed/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/boot/compressed/misc.c b/arch/s390/boot/compressed/misc.c
index cecf38b9ec82..e79c4499c548 100644
--- a/arch/s390/boot/compressed/misc.c
+++ b/arch/s390/boot/compressed/misc.c
@@ -174,3 +174,7 @@ unsigned long decompress_kernel(void)
 	return (unsigned long) output;
 }
 
+void fortify_panic(const char *name)
+{
+	error("detected buffer overflow");
+}
-- 
2.13.6
