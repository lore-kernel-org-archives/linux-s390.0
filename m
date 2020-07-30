Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgG3Ghv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 02:37:51 -0400
From: Wang Hai <wanghai38@huawei.com>
Subject: [PATCH] s390/test_unwind: fix possible memleak in test_unwind()
Date: Thu, 30 Jul 2020 14:36:02 +0800
Message-ID: <20200730063602.31581-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, colin.king@canonical.com, iii@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

test_unwind() misses to call kfree(bt) in an error path.
Add the missed function call to fix it.

Fixes: 0610154650f1 ("s390/test_unwind: print verbose unwinding results")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 arch/s390/lib/test_unwind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 32b7a30b2485..b0b12b46bc57 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -63,6 +63,7 @@ static noinline int test_unwind(struct task_struct *task, struct pt_regs *regs,
 			break;
 		if (state.reliable && !addr) {
 			pr_err("unwind state reliable but addr is 0\n");
+			kfree(bt);
 			return -EINVAL;
 		}
 		sprint_symbol(sym, addr);
-- 
2.17.1
