From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 15/16] KVM: s390: Add KVM HPAGE capability
Date: Fri,  9 Feb 2018 10:34:23 +0100
Message-ID: <1518168864-147803-16-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

KVM huge page backing support can not be easily tested under
s390. Currently testing is only possible after most of the guest has
already been set up.

To indicate, that KVM has huge page backing support with 1m pages, we
add the KVM_CAP_S390_HPAGE capability. This does not mean, that
transparent huge pages are supported.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 10 ++++++++++
 arch/s390/kvm/kvm-s390.c          |  1 +
 include/uapi/linux/kvm.h          |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index fc3ae95..2e0512e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4415,3 +4415,13 @@ Parameters: none
 This capability indicates if the flic device will be able to get/set the
 AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute and allows
 to discover this without having to create a flic device.
+
+8.14 KVM_CAP_S390_HPAGE
+
+Architectures: s390
+This capability, if KVM_CHECK_EXTENSION indicates that it is
+available, means that KVM supports VMs that are memory backed through
+hugetlbfs with 1 megabyte pages.
+
+While it is generally possible to create and start such a VM without
+this support, the VM will not be functional.
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0862bf0..171b017 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -393,6 +393,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_CMMA_MIGRATION:
 	case KVM_CAP_S390_AIS:
 	case KVM_CAP_S390_AIS_MIGRATION:
+	case KVM_CAP_S390_HPAGE:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8fb90a0..99c2175 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -934,6 +934,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_AIS_MIGRATION 150
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
+#define KVM_CAP_S390_HPAGE 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4
