Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55251 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfLBJCS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 04:02:18 -0500
From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] s390/test_unwind: fix spelling mistake "reqister" -> "register"
Date: Mon,  2 Dec 2019 09:02:15 +0000
Message-Id: <20191202090215.28766-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/s390/lib/test_unwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index bda7ac0ddd29..32b7a30b2485 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -238,7 +238,7 @@ static int test_unwind_irq(struct unwindme *u)
 {
 	preempt_disable();
 	if (register_external_irq(EXT_IRQ_CLK_COMP, unwindme_irq_handler)) {
-		pr_info("Couldn't reqister external interrupt handler");
+		pr_info("Couldn't register external interrupt handler");
 		return -1;
 	}
 	u->task = current;
-- 
2.24.0
