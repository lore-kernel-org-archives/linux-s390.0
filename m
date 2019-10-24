Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439148AbfJXLmR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb7sU127932
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vua4vausq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:14 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 15/37] KVM: s390: protvirt: Add machine-check interruption injection controls
Date: Thu, 24 Oct 2019 07:40:37 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-16-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

From: Michael Mueller <mimu@linux.ibm.com>

The following fields are added to the sie control block type 4:
     - Machine Check Interruption Code (mcic)
     - External Damage Code (edc)
     - Failing Storage Address (faddr)

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 33 +++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 63fc32d38aa9..0ab309b7bf4c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -261,16 +261,31 @@ struct kvm_s390_sie_block {
 #define HPID_VSIE	0x5
 	__u8	hpid;			/* 0x00b8 */
 	__u8	reservedb9[7];		/* 0x00b9 */
-	__u32	eiparams;		/* 0x00c0 */
-	__u16	extcpuaddr;		/* 0x00c4 */
-	__u16	eic;			/* 0x00c6 */
+	union {
+		struct {
+			__u32	eiparams;	/* 0x00c0 */
+			__u16	extcpuaddr;	/* 0x00c4 */
+			__u16	eic;		/* 0x00c6 */
+		};
+		__u64	mcic;			/* 0x00c0 */
+	} __packed;
 	__u32	reservedc8;		/* 0x00c8 */
-	__u16	pgmilc;			/* 0x00cc */
-	__u16	iprcc;			/* 0x00ce */
-	__u32	dxc;			/* 0x00d0 */
-	__u16	mcn;			/* 0x00d4 */
-	__u8	perc;			/* 0x00d6 */
-	__u8	peratmid;		/* 0x00d7 */
+	union {
+		struct {
+			__u16	pgmilc;		/* 0x00cc */
+			__u16	iprcc;		/* 0x00ce */
+		};
+		__u32	edc;			/* 0x00cc */
+	} __packed;
+	union {
+		struct {
+			__u32	dxc;		/* 0x00d0 */
+			__u16	mcn;		/* 0x00d4 */
+			__u8	perc;		/* 0x00d6 */
+			__u8	peratmid;	/* 0x00d7 */
+		};
+		__u64	faddr;			/* 0x00d0 */
+	} __packed;
 	__u64	peraddr;		/* 0x00d8 */
 	__u8	eai;			/* 0x00e0 */
 	__u8	peraid;			/* 0x00e1 */
-- 
2.20.1
