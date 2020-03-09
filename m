Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbgCIIvp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298ohcn006635
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ynj6egxar-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:42 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 29/36] KVM: s390: protvirt: Support cmd 5 operation state
Date: Mon,  9 Mar 2020 09:51:19 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-30-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Code 5 for the set cpu state UV call tells the UV to load a PSW from
the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
0/1). Also it sets the cpu into operating state afterwards, so we can
start it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 1 +
 arch/s390/kvm/kvm-s390.c   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index fc221d91a965..e55727b63a68 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -169,6 +169,7 @@ struct uv_cb_unp {
 #define PV_CPU_STATE_OPR	1
 #define PV_CPU_STATE_STP	2
 #define PV_CPU_STATE_CHKSTP	3
+#define PV_CPU_STATE_OPR_LOAD	5
 
 struct uv_cb_cpu_set_state {
 	struct uv_cb_header header;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 80e16bd72d48..028ce4e74393 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3736,6 +3736,12 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		rc = kvm_s390_vcpu_start(vcpu);
 		break;
 	case KVM_MP_STATE_LOAD:
+		if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
+			rc = -ENXIO;
+			break;
+		}
+		rc = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
+		break;
 	case KVM_MP_STATE_CHECK_STOP:
 		/* fall through - CHECK_STOP and LOAD are not supported yet */
 	default:
-- 
2.24.1
