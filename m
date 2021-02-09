Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231825AbhBINvb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 08:51:31 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 1/8] s390x: Fix fpc store address in RESTORE_REGS_STACK
Date: Tue,  9 Feb 2021 08:49:18 -0500
Message-Id: <20210209134925.22248-2-frankja@linux.ibm.com>
In-Reply-To: <20210209134925.22248-1-frankja@linux.ibm.com>
References: <20210209134925.22248-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

The efpc stores in bits 32-63 of a register and we store a full 8
bytes to have the stack 8 byte aligned. This means that the fpc is
stored at offset 4 but we load it from offset 0. Lets replace efpc
with stfpc and get rid of the stg to store at offset 0.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/macros.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/s390x/macros.S b/s390x/macros.S
index 37a6a63e..e51a557a 100644
--- a/s390x/macros.S
+++ b/s390x/macros.S
@@ -54,8 +54,7 @@
 	.endr
 	/* Save fpc, but keep stack aligned on 64bits */
 	slgfi   %r15, 8
-	efpc	%r0
-	stg	%r0, 0(%r15)
+	stfpc	0(%r15)
 	.endm
 
 /* Restore the register in reverse order */
-- 
2.25.1
