Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39060 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727540AbgIOR1H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:07 -0400
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/4] s390/dis: get rid of set_fs() usage
Date: Tue, 15 Sep 2020 17:43:38 +0200
Message-Id: <20200915154340.4215-3-hca@linux.ibm.com>
In-Reply-To: <20200915154340.4215-1-hca@linux.ibm.com>
References: <20200915154340.4215-1-hca@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/dis.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index f304802ecf7b..68bf2e9ebe5a 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -487,26 +487,30 @@ void show_code(struct pt_regs *regs)
 	char *mode = user_mode(regs) ? "User" : "Krnl";
 	unsigned char code[64];
 	char buffer[128], *ptr;
-	mm_segment_t old_fs;
 	unsigned long addr;
 	int start, end, opsize, hops, i;
 
 	/* Get a snapshot of the 64 bytes surrounding the fault address. */
-	old_fs = get_fs();
-	set_fs(user_mode(regs) ? USER_DS : KERNEL_DS);
 	for (start = 32; start && regs->psw.addr >= 34 - start; start -= 2) {
 		addr = regs->psw.addr - 34 + start;
-		if (__copy_from_user(code + start - 2,
-				     (char __user *) addr, 2))
-			break;
+		if (user_mode(regs)) {
+			if (__copy_from_user(code + start - 2, (char __user *)addr, 2))
+				break;
+		} else {
+			if (copy_from_kernel_nofault(code + start - 2, (char *)addr, 2))
+				break;
+		}
 	}
 	for (end = 32; end < 64; end += 2) {
 		addr = regs->psw.addr + end - 32;
-		if (__copy_from_user(code + end,
-				     (char __user *) addr, 2))
-			break;
+		if (user_mode(regs)) {
+			if (__copy_from_user(code + end, (char __user *)addr, 2))
+				break;
+		} else {
+			if (copy_from_kernel_nofault(code + end, (char *)addr, 2))
+				break;
+		}
 	}
-	set_fs(old_fs);
 	/* Code snapshot useable ? */
 	if ((regs->psw.addr & 1) || start >= end) {
 		printk("%s Code: Bad PSW.\n", mode);
-- 
2.17.1
