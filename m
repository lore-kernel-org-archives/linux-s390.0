Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbgBGLkH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:07 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 30/35] KVM: s390: protvirt: Support cmd 5 operation state
Date: Fri,  7 Feb 2020 06:39:53 -0500
Message-Id: <20200207113958.7320-31-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

Code 5 for the set cpu state UV call tells the UV to load a PSW from
the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
0/1). Also it sets the cpu into operating state afterwards, so we can
start it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/uv.h | 1 +
 arch/s390/kvm/kvm-s390.c   | 7 +++++++
 include/uapi/linux/kvm.h   | 1 +
 3 files changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 237d0b417d07..94fc0b60e4c8 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -175,6 +175,7 @@ struct uv_cb_unp {
 #define PV_CPU_STATE_OPR	1
 #define PV_CPU_STATE_STP	2
 #define PV_CPU_STATE_CHKSTP	3
+#define PV_CPU_STATE_OPR_LOAD	5
 
 struct uv_cb_cpu_set_state {
 	struct uv_cb_header header;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ee98799212d3..3a06622c52fb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4667,6 +4667,13 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_vcpu *vcpu,
 		r = kvm_s390_pv_destroy_cpu(vcpu);
 		break;
 	}
+	case KVM_PV_VCPU_SET_IPL_PSW: {
+		if (!kvm_s390_pv_handle_cpu(vcpu))
+			return -EINVAL;
+
+		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 864e73bd40e4..9125d6b2a974 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1504,6 +1504,7 @@ enum pv_cmd_id {
 	KVM_PV_VM_UNSHARE_ALL,
 	KVM_PV_VCPU_CREATE,
 	KVM_PV_VCPU_DESTROY,
+	KVM_PV_VCPU_SET_IPL_PSW,
 };
 
 struct kvm_pv_cmd {
-- 
2.24.0
