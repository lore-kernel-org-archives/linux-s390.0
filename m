From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 9/9] KVM: s390: introduce AIS capability
Date: Fri,  7 Apr 2017 12:48:02 +0200
Message-ID: <1491562082-6392-10-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Introduce a cap to enable AIS facility bit, and add documentation
for this capability.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  8 ++++++++
 arch/s390/kvm/kvm-s390.c          | 15 +++++++++++++++
 include/uapi/linux/kvm.h          |  1 +
 3 files changed, 24 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 7252508..598278c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4110,6 +4110,14 @@ Returns: 0 on success; -EINVAL if the machine does not support
 
 Allows use of guarded storage for the KVM guest.
 
+7.10 KVM_CAP_S390_AIS
+
+Architectures: s390
+Parameters: none
+
+Allow use of adapter-interruption suppression.
+Returns: 0 on success; -EBUSY if a VCPU has already been created.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 977cc16..11b7d66 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -380,6 +380,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_SKEYS:
 	case KVM_CAP_S390_IRQ_STATE:
 	case KVM_CAP_S390_USER_INSTR0:
+	case KVM_CAP_S390_AIS:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
@@ -544,6 +545,20 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_RI %s",
 			 r ? "(not available)" : "(success)");
 		break;
+	case KVM_CAP_S390_AIS:
+		mutex_lock(&kvm->lock);
+		if (kvm->created_vcpus) {
+			r = -EBUSY;
+		} else {
+			set_kvm_facility(kvm->arch.model.fac_mask, 72);
+			set_kvm_facility(kvm->arch.model.fac_list, 72);
+			kvm->arch.float_int.ais_enabled = 1;
+			r = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		VM_EVENT(kvm, 3, "ENABLE: AIS %s",
+			 r ? "(not available)" : "(success)");
+		break;
 	case KVM_CAP_S390_GS:
 		r = -EINVAL;
 		mutex_lock(&kvm->lock);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c9d5227..33dd2a4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -884,6 +884,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
 #define KVM_CAP_S390_GS 137
+#define KVM_CAP_S390_AIS 138
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4
