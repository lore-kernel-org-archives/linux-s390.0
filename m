Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] s390/jump_label: Use %*ph to print small buffers
Date: Thu, 27 Aug 2015 00:49:29 +0600
Message-Id: <1440614969-11351-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

printk() supports %*ph format specifier for printing a small buffers,
let's use it intead of %02x %02x...

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/s390/kernel/jump_label.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index a902996..cdf7c9e 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -44,11 +44,11 @@ static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 	unsigned char *ipn = (unsigned char *)new;
 
 	pr_emerg("Jump label code mismatch at %pS [%p]\n", ipc, ipc);
-	pr_emerg("Found:    %02x %02x %02x %02x %02x %02x\n",
+	pr_emerg("Found:    %6ph\n",
 		 ipc[0], ipc[1], ipc[2], ipc[3], ipc[4], ipc[5]);
-	pr_emerg("Expected: %02x %02x %02x %02x %02x %02x\n",
+	pr_emerg("Expected: %6ph\n",
 		 ipe[0], ipe[1], ipe[2], ipe[3], ipe[4], ipe[5]);
-	pr_emerg("New:      %02x %02x %02x %02x %02x %02x\n",
+	pr_emerg("New:      %6ph\n",
 		 ipn[0], ipn[1], ipn[2], ipn[3], ipn[4], ipn[5]);
 	panic("Corrupted kernel text");
 }
-- 
2.5.0
