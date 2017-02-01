From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/12] KVM: s390: Add debug logging to basic cpu model interface
Date: Wed,  1 Feb 2017 12:38:14 +0100
Message-ID: <1485949094-138708-13-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Let's log something for changes in facilities, cpuid and ibc now that we
have a cpu model in QEMU. All of these calls are pretty seldom, so we
will not spill the log, the they will help to understand pontential
guest issues, for example if some instructions are fenced off.

As the s390 debug feature has a limited amount of parameters and
strings must not go away we limit the facility printing to 3 double
words, instead of building that list dynamically. This should be enough
for several years. If we ever exceed 3 double words then the logging
will be incomplete but no functional impact will happen.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4078ba6..dabd3b15 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -829,6 +829,13 @@ static int kvm_s390_set_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 		}
 		memcpy(kvm->arch.model.fac_list, proc->fac_list,
 		       S390_ARCH_FAC_LIST_SIZE_BYTE);
+		VM_EVENT(kvm, 3, "SET: guest ibc: 0x%4.4x, guest cpuid: 0x%16.16llx",
+			 kvm->arch.model.ibc,
+			 kvm->arch.model.cpuid);
+		VM_EVENT(kvm, 3, "SET: guest faclist: 0x%16.16llx.%16.16llx.%16.16llx",
+			 kvm->arch.model.fac_list[0],
+			 kvm->arch.model.fac_list[1],
+			 kvm->arch.model.fac_list[2]);
 	} else
 		ret = -EFAULT;
 	kfree(proc);
@@ -902,6 +909,13 @@ static int kvm_s390_get_processor(struct kvm *kvm, struct kvm_device_attr *attr)
 	proc->ibc = kvm->arch.model.ibc;
 	memcpy(&proc->fac_list, kvm->arch.model.fac_list,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
+	VM_EVENT(kvm, 3, "GET: guest ibc: 0x%4.4x, guest cpuid: 0x%16.16llx",
+		 kvm->arch.model.ibc,
+		 kvm->arch.model.cpuid);
+	VM_EVENT(kvm, 3, "GET: guest faclist: 0x%16.16llx.%16.16llx.%16.16llx",
+		 kvm->arch.model.fac_list[0],
+		 kvm->arch.model.fac_list[1],
+		 kvm->arch.model.fac_list[2]);
 	if (copy_to_user((void __user *)attr->addr, proc, sizeof(*proc)))
 		ret = -EFAULT;
 	kfree(proc);
@@ -925,6 +939,17 @@ static int kvm_s390_get_machine(struct kvm *kvm, struct kvm_device_attr *attr)
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	memcpy((unsigned long *)&mach->fac_list, S390_lowcore.stfle_fac_list,
 	       sizeof(S390_lowcore.stfle_fac_list));
+	VM_EVENT(kvm, 3, "GET: host ibc:  0x%4.4x, host cpuid:  0x%16.16llx",
+		 kvm->arch.model.ibc,
+		 kvm->arch.model.cpuid);
+	VM_EVENT(kvm, 3, "GET: host facmask:  0x%16.16llx.%16.16llx.%16.16llx",
+		 mach->fac_mask[0],
+		 mach->fac_mask[1],
+		 mach->fac_mask[2]);
+	VM_EVENT(kvm, 3, "GET: host faclist:  0x%16.16llx.%16.16llx.%16.16llx",
+		 mach->fac_list[0],
+		 mach->fac_list[1],
+		 mach->fac_list[2]);
 	if (copy_to_user((void __user *)attr->addr, mach, sizeof(*mach)))
 		ret = -EFAULT;
 	kfree(mach);
-- 
2.7.4
