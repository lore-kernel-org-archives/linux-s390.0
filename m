Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH] s390/dis: Fix invalid array size
Date: Mon, 25 Feb 2013 03:45:45 +0530
Message-Id: <1361744145-28112-1-git-send-email-s.syam@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, borntraeger@de.ibm.com, jang@linux.vnet.ibm.com, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syamsidhardh@gmail.com
List-ID: <linux-s390.vger.kernel.org>

We are using sizeof operator for an array given as function argument,
which is incorrect.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 arch/s390/kernel/dis.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index c50665f..3ad5e95 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -1711,10 +1711,10 @@ int insn_to_mnemonic(unsigned char *instruction, char buf[8])
 	if (!insn)
 		return -ENOENT;
 	if (insn->name[0] == '\0')
-		snprintf(buf, sizeof(buf), "%s",
+		snprintf(buf, 8, "%s",
 			 long_insn_name[(int) insn->name[1]]);
 	else
-		snprintf(buf, sizeof(buf), "%.5s", insn->name);
+		snprintf(buf, 8, "%.5s", insn->name);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(insn_to_mnemonic);
-- 
1.7.9.5
