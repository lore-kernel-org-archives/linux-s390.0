Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgCIIvj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298ovqQ087140
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8n6wjnm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:36 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/36] KVM: s390: protvirt: Handle SE notification interceptions
Date: Mon,  9 Mar 2020 09:51:02 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-13-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Since there is no interception for load control and load psw
instruction in the protected mode, we need a new way to get notified
whenever we can inject an IRQ right after the guest has just enabled
the possibility for receiving them.

The new interception codes solve that problem by providing a
notification for changes to IRQ enablement relevant bits in CRs 0, 6
and 14, as well a the machine check mask bit in the PSW.

No special handling is needed for these interception codes, the KVM
pre-run code will consult all necessary CRs and PSW bits and inject
IRQs the guest is enabled for.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/intercept.c        | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1aa2382fe363..fdc6ceff6397 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -215,6 +215,8 @@ struct kvm_s390_sie_block {
 #define ICPT_PARTEXEC	0x38
 #define ICPT_IOINST	0x40
 #define ICPT_KSS	0x5c
+#define ICPT_MCHKREQ	0x60
+#define ICPT_INT_ENABLE	0x64
 	__u8	icptcode;		/* 0x0050 */
 	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index a389fa85cca2..9090f29ae822 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -2,7 +2,7 @@
 /*
  * in-kernel handling for sie intercepts
  *
- * Copyright IBM Corp. 2008, 2014
+ * Copyright IBM Corp. 2008, 2020
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -480,6 +480,15 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 	case ICPT_KSS:
 		rc = kvm_s390_skey_check_enable(vcpu);
 		break;
+	case ICPT_MCHKREQ:
+	case ICPT_INT_ENABLE:
+		/*
+		 * PSW bit 13 or a CR (0, 6, 14) changed and we might
+		 * now be able to deliver interrupts. The pre-run code
+		 * will take care of this.
+		 */
+		rc = 0;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.24.1
