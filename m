From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: s390: provide a capability for AIS state migration
Date: Thu,  9 Nov 2017 10:04:04 +0100
Message-ID: <20171109090404.125475-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The AIS capability was introduced in 4.12, while the interface
to migrate the state was added in 4.13. Let's add a new capability
that tells userspace that AIS states can be migrated.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 include/uapi/linux/kvm.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index de6a5b7..8f4b655 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -395,6 +395,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_USER_INSTR0:
 	case KVM_CAP_S390_CMMA_MIGRATION:
 	case KVM_CAP_S390_AIS:
+	case KVM_CAP_S390_AIS_MIGRATION:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8388875..b605956 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -930,6 +930,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_S390_AIS_MIGRATION 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.9.4
