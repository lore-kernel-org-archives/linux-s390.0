Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22128 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390228AbfKEQ3T (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 11:29:19 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5GQ7wM068138
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 11:29:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w14m4kd6k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 11:29:13 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 5 Nov 2019 16:29:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/2] s390x: Remove DAT and add short indication psw bits on diag308 reset
Date: Tue,  5 Nov 2019 11:28:28 -0500
In-Reply-To: <20191105162828.2490-1-frankja@linux.ibm.com>
References: <20191105162828.2490-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191105162828.2490-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com

On a diag308 subcode 0 CRs will be reset, so we need to mask of PSW
DAT indication until we restore our CRs.

Also we need to set the short psw indication to be compliant with the
architecture.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm-offsets.c  |  1 +
 lib/s390x/asm/arch_def.h |  3 ++-
 s390x/cstart64.S         | 20 ++++++++++++++------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
index 4b213f8..61d2658 100644
--- a/lib/s390x/asm-offsets.c
+++ b/lib/s390x/asm-offsets.c
@@ -58,6 +58,7 @@ int main(void)
 	OFFSET(GEN_LC_SW_INT_FPRS, lowcore, sw_int_fprs);
 	OFFSET(GEN_LC_SW_INT_FPC, lowcore, sw_int_fpc);
 	OFFSET(GEN_LC_SW_INT_CRS, lowcore, sw_int_crs);
+	OFFSET(GEN_LC_SW_INT_PSW, lowcore, sw_int_psw);
 	OFFSET(GEN_LC_MCCK_EXT_SA_ADDR, lowcore, mcck_ext_sa_addr);
 	OFFSET(GEN_LC_FPRS_SA, lowcore, fprs_sa);
 	OFFSET(GEN_LC_GRS_SA, lowcore, grs_sa);
diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 07d4e5e..7d25e4f 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -79,7 +79,8 @@ struct lowcore {
 	uint32_t	sw_int_fpc;			/* 0x0300 */
 	uint8_t		pad_0x0304[0x0308 - 0x0304];	/* 0x0304 */
 	uint64_t	sw_int_crs[16];			/* 0x0308 */
-	uint8_t		pad_0x0310[0x11b0 - 0x0388];	/* 0x0388 */
+	struct psw	sw_int_psw;			/* 0x0388 */
+	uint8_t		pad_0x0310[0x11b0 - 0x0390];	/* 0x0390 */
 	uint64_t	mcck_ext_sa_addr;		/* 0x11b0 */
 	uint8_t		pad_0x11b8[0x1200 - 0x11b8];	/* 0x11b8 */
 	uint64_t	fprs_sa[16];			/* 0x1200 */
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 0455591..2e0dcf5 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -129,8 +129,15 @@ memsetxc:
 .globl diag308_load_reset
 diag308_load_reset:
 	SAVE_REGS
-	/* Save the first PSW word to the IPL PSW */
+	/* Backup current PSW */
 	epsw	%r0, %r1
+	st	%r0, GEN_LC_SW_INT_PSW
+	st	%r1, GEN_LC_SW_INT_PSW + 4
+	/* Disable DAT as the CRs will be reset too */
+	nilh	%r0, 0xfbff
+	/* Add psw bit 12 to indicate short psw */
+	oilh	%r0, 0x0008
+	/* Save the first PSW word to the IPL PSW */
 	st	%r0, 0
 	/* Store the address and the bit for 31 bit addressing */
 	larl    %r0, 0f
@@ -142,12 +149,13 @@ diag308_load_reset:
 	xgr	%r2, %r2
 	br	%r14
 	/* Success path */
-	/* We lost cr0 due to the reset */
-0:	larl	%r1, initial_cr0
-	lctlg	%c0, %c0, 0(%r1)
-	RESTORE_REGS
+	/* Switch to z/Architecture mode and 64-bit */
+0:	RESTORE_REGS
 	lhi	%r2, 1
-	br	%r14
+	larl	%r0, 1f
+	stg	%r0, GEN_LC_SW_INT_PSW + 8
+	lpswe	GEN_LC_SW_INT_PSW
+1:	br	%r14
 
 .globl smp_cpu_setup_state
 smp_cpu_setup_state:
-- 
2.20.1
