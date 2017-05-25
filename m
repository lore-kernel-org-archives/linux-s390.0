Return-Path: <linux-kernel-owner@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] s390: kernel: Delete an error message for a failed memory
 allocation in cpcmd()
Message-ID: <225c2a55-eb6e-35cb-285a-cb664a34bc7e@users.sourceforge.net>
Date: Thu, 25 May 2017 19:18:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 May 2017 19:09:50 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/cpcmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/cpcmd.c b/arch/s390/kernel/cpcmd.c
index 9f0e4a2785f7..2f9c97813846 100644
--- a/arch/s390/kernel/cpcmd.c
+++ b/arch/s390/kernel/cpcmd.c
@@ -95,10 +95,9 @@ int cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 	if ((virt_to_phys(response) != (unsigned long) response) ||
 			(((unsigned long)response + rlen) >> 31)) {
 		lowbuf = kmalloc(rlen, GFP_KERNEL | GFP_DMA);
-		if (!lowbuf) {
-			pr_warn("The cpcmd kernel function failed to allocate a response buffer\n");
+		if (!lowbuf)
 			return -ENOMEM;
-		}
+
 		spin_lock_irqsave(&cpcmd_lock, flags);
 		len = __cpcmd(cmd, lowbuf, rlen, response_code);
 		spin_unlock_irqrestore(&cpcmd_lock, flags);
-- 
2.13.0
