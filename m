Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409250AbfJXLmO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBbUxV011418
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vu9avvqyf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:11 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 13/37] KVM: s390: protvirt: Add interruption injection controls
Date: Thu, 24 Oct 2019 07:40:35 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-14-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

From: Michael Mueller <mimu@linux.ibm.com>

Define the interruption injection codes and the related fields in the
sie control block for PVM interruption injection.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 6cc3b73ca904..82443236d4cc 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -215,7 +215,15 @@ struct kvm_s390_sie_block {
 	__u8	icptcode;		/* 0x0050 */
 	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
-	__u8	reserved54[2];		/* 0x0054 */
+	__u8	reserved54;		/* 0x0054 */
+#define IICTL_CODE_NONE		 0x00
+#define IICTL_CODE_MCHK		 0x01
+#define IICTL_CODE_EXT		 0x02
+#define IICTL_CODE_IO		 0x03
+#define IICTL_CODE_RESTART	 0x04
+#define IICTL_CODE_SPECIFICATION 0x10
+#define IICTL_CODE_OPERAND	 0x11
+	__u8	iictl;			/* 0x0055 */
 	__u16	ipa;			/* 0x0056 */
 	__u32	ipb;			/* 0x0058 */
 	__u32	scaoh;			/* 0x005c */
@@ -252,7 +260,8 @@ struct kvm_s390_sie_block {
 #define HPID_KVM	0x4
 #define HPID_VSIE	0x5
 	__u8	hpid;			/* 0x00b8 */
-	__u8	reservedb9[11];		/* 0x00b9 */
+	__u8	reservedb9[7];		/* 0x00b9 */
+	__u32	eiparams;		/* 0x00c0 */
 	__u16	extcpuaddr;		/* 0x00c4 */
 	__u16	eic;			/* 0x00c6 */
 	__u32	reservedc8;		/* 0x00c8 */
@@ -268,8 +277,16 @@ struct kvm_s390_sie_block {
 	__u8	oai;			/* 0x00e2 */
 	__u8	armid;			/* 0x00e3 */
 	__u8	reservede4[4];		/* 0x00e4 */
-	__u64	tecmc;			/* 0x00e8 */
-	__u8	reservedf0[12];		/* 0x00f0 */
+	union {
+		__u64	tecmc;		/* 0x00e8 */
+		struct {
+			__u16	subchannel_id;	/* 0x00e8 */
+			__u16	subchannel_nr;	/* 0x00ea */
+			__u32	io_int_parm;	/* 0x00ec */
+			__u32	io_int_word;	/* 0x00f0 */
+		};
+	} __packed;
+	__u8	reservedf4[8];		/* 0x00f4 */
 #define CRYCB_FORMAT_MASK 0x00000003
 #define CRYCB_FORMAT0 0x00000000
 #define CRYCB_FORMAT1 0x00000001
-- 
2.20.1
