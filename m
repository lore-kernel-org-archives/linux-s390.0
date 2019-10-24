Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439210AbfJXLmz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBcfXS137191
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vuaha9v8h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:51 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 36/37] KVM: s390: protvirt: Support cmd 5 operation state
Date: Thu, 24 Oct 2019 07:40:58 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-37-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Code 5 for the set cpu state UV call tells the UV to load a PSW from
the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
0/1). Also it sets the cpu into operating state afterwards, so we can
start it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/uv.h | 1 +
 arch/s390/kvm/kvm-s390.c   | 4 ++++
 include/uapi/linux/kvm.h   | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 33b52ba306af..8d10ae731458 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -163,6 +163,7 @@ struct uv_cb_unp {
 #define PV_CPU_STATE_OPR	1
 #define PV_CPU_STATE_STP	2
 #define PV_CPU_STATE_CHKSTP	3
+#define PV_CPU_STATE_OPR_LOAD	5
 
 struct uv_cb_cpu_set_state {
 	struct uv_cb_header header;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index cc5feb67f145..5cc9108c94e4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4652,6 +4652,10 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_vcpu *vcpu,
 		r = kvm_s390_pv_destroy_cpu(vcpu);
 		break;
 	}
+	case KVM_PV_VCPU_SET_IPL_PSW: {
+		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2846ed5e5dd9..973007d27d55 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1483,6 +1483,7 @@ enum pv_cmd_id {
 	KVM_PV_VM_UNSHARE,
 	KVM_PV_VCPU_CREATE,
 	KVM_PV_VCPU_DESTROY,
+	KVM_PV_VCPU_SET_IPL_PSW,
 };
 
 struct kvm_pv_cmd {
-- 
2.20.1
