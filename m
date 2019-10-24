Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409242AbfJXLmM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb8Lp137743
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vub4qgenw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:09 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 12/37] KVM: s390: protvirt: Handle SE notification interceptions
Date: Thu, 24 Oct 2019 07:40:34 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-13-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Since KVM doesn't emulate any form of load control and load psw
instructions anymore, we wouldn't get an interception if PSWs or CRs
are changed in the guest. That means we can't inject IRQs right after
the guest is enabled for them.

The new interception codes solve that problem by being a notification
for changes to IRQ enablement relevant bits in CRs 0, 6 and 14, as
well a the machine check mask bit in the PSW.

No special handling is needed for these interception codes, the KVM
pre-run code will consult all necessary CRs and PSW bits and inject
IRQs the guest is enabled for.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d4fd0f3af676..6cc3b73ca904 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -210,6 +210,8 @@ struct kvm_s390_sie_block {
 #define ICPT_PARTEXEC	0x38
 #define ICPT_IOINST	0x40
 #define ICPT_KSS	0x5c
+#define ICPT_PV_MCHKR	0x60
+#define ICPT_PV_INT_EN	0x64
 	__u8	icptcode;		/* 0x0050 */
 	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index a389fa85cca2..acc1710fc472 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -480,6 +480,24 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 	case ICPT_KSS:
 		rc = kvm_s390_skey_check_enable(vcpu);
 		break;
+	case ICPT_PV_MCHKR:
+		/*
+		 * A protected guest changed PSW bit 13 to one and is now
+		 * enabled for interrupts. The pre-run code will check
+		 * the registers and inject pending MCHKs based on the
+		 * PSW and CRs. No additional work to do.
+		 */
+		rc = 0;
+		break;
+	case  ICPT_PV_INT_EN:
+		/*
+		 * A protected guest changed CR 0,6,14 and may now be
+		 * enabled for interrupts. The pre-run code will check
+		 * the registers and inject pending IRQs based on the
+		 * CRs. No additional work to do.
+		 */
+		rc = 0;
+	break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.20.1
