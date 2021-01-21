Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732297AbhAUPPs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 10:15:48 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 2/2] s390: mm: Fix secure storage access exception handling
Date: Thu, 21 Jan 2021 10:14:35 -0500
Message-Id: <20210121151436.417240-3-frankja@linux.ibm.com>
In-Reply-To: <20210121151436.417240-1-frankja@linux.ibm.com>
References: <20210121151436.417240-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, hca@linux.ibm.com, mihajlov@linux.ibm.com

Turns out that the bit 61 in the TEID is not always 1 and if that's
the case the address space ID and the address are
unpredictable. Without an address and its address space ID we can't
export memory and hence we can only send a SIGSEGV to the process or
panic the kernel depending on who caused the exception.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Fixes: 084ea4d611a3d ("s390/mm: add (non)secure page access exceptions handlers")
Cc: stable@vger.kernel.org
---
 arch/s390/mm/fault.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index e30c7c781172..3e8685ad938d 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -791,6 +791,20 @@ void do_secure_storage_access(struct pt_regs *regs)
 	struct page *page;
 	int rc;
 
+	/* There are cases where we don't have a TEID. */
+	if (!(regs->int_parm_long & 0x4)) {
+		/*
+		 * When this happens, userspace did something that it
+		 * was not supposed to do, e.g. branching into secure
+		 * memory. Trigger a segmentation fault.
+		 */
+		if (user_mode(regs)) {
+			send_sig(SIGSEGV, current, 0);
+			return;
+		} else
+			panic("Unexpected PGM 0x3d with TEID bit 61=0");
+	}
+
 	switch (get_fault_type(regs)) {
 	case USER_FAULT:
 		mm = current->mm;
-- 
2.25.1
