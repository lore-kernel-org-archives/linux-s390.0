Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727101AbgBGLkH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:07 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 34/35] KVM: s390: protvirt: Add UV cpu reset calls
Date: Fri,  7 Feb 2020 06:39:57 -0500
Message-Id: <20200207113958.7320-35-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

For protected VMs, the VCPU resets are done by the Ultravisor, as KVM
has no access to the VCPU registers.

As the Ultravisor will only accept a call for the reset that is
needed, we need to fence the UV calls when chaining resets.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 27365fea5f95..a56660607fd5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4706,6 +4706,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	void __user *argp = (void __user *)arg;
 	int idx;
 	long r;
+	u32 uvret;
 
 	vcpu_load(vcpu);
 
@@ -4727,14 +4728,33 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_S390_CLEAR_RESET:
 		r = 0;
 		kvm_arch_vcpu_ioctl_clear_reset(vcpu);
+		if (kvm_s390_pv_handle_cpu(vcpu)) {
+			r = uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+					  UVC_CMD_CPU_RESET_CLEAR, &uvret);
+			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET CLEAR VCPU: rc %x rrc %x",
+				   uvret >> 16, uvret & 0x0000ffff);
+		}
 		break;
 	case KVM_S390_INITIAL_RESET:
 		r = 0;
 		kvm_arch_vcpu_ioctl_initial_reset(vcpu);
+		if (kvm_s390_pv_handle_cpu(vcpu)) {
+			r = uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+					  UVC_CMD_CPU_RESET_INITIAL,
+					  &uvret);
+			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET INITIAL VCPU: rc %x rrc %x",
+				   uvret >> 16, uvret & 0x0000ffff);
+		}
 		break;
 	case KVM_S390_NORMAL_RESET:
 		r = 0;
 		kvm_arch_vcpu_ioctl_normal_reset(vcpu);
+		if (kvm_s390_pv_handle_cpu(vcpu)) {
+			r = uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
+					  UVC_CMD_CPU_RESET, &uvret);
+			VCPU_EVENT(vcpu, 3, "PROTVIRT RESET NORMAL VCPU: rc %x rrc %x",
+				   uvret >> 16, uvret & 0x0000ffff);
+		}
 		break;
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
-- 
2.24.0
