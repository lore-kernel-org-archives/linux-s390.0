From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/52] KVM: s390: Limit sthyi execution
Date: Tue, 14 Jun 2016 20:56:44 +0200
Message-ID: <201606141857.u5EIs2x2001961@mx0a-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

Store hypervisor information is a valid instruction not only in
supervisor state but also in problem state, i.e. the guest's
userspace. Its execution is not only computational and memory
intensive, but also has to get hold of the ipte lock to write to the
guest's memory.

This lock is not intended to be held often and long, especially not
from the untrusted guest userspace. Therefore we apply rate limiting
of sthyi executions per VM.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Acked-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         |  2 ++
 arch/s390/kvm/sthyi.c            | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 7233b1c..bcc20dc 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -652,6 +652,7 @@ struct kvm_arch{
 	wait_queue_head_t ipte_wq;
 	int ipte_lock_count;
 	struct mutex ipte_mutex;
+	struct ratelimit_state sthyi_limit;
 	spinlock_t start_stop_lock;
 	struct sie_page2 *sie_page2;
 	struct kvm_s390_cpu_model model;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1c10254..44297ff 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1151,6 +1151,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	rc = -ENOMEM;
 
+	ratelimit_state_init(&kvm->arch.sthyi_limit, 5 * HZ, 500);
+
 	kvm->arch.use_esca = 0; /* start with basic SCA */
 	rwlock_init(&kvm->arch.sca_lock);
 	kvm->arch.sca = (struct bsca_block *) get_zeroed_page(GFP_KERNEL);
diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
index 894d562..bd98b7d 100644
--- a/arch/s390/kvm/sthyi.c
+++ b/arch/s390/kvm/sthyi.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
+#include <linux/ratelimit.h>
 
 #include <asm/kvm_host.h>
 #include <asm/asm-offsets.h>
@@ -403,6 +404,16 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
 	u64 code, addr, cc = 0;
 	struct sthyi_sctns *sctns = NULL;
 
+	/*
+	 * STHYI requires extensive locking in the higher hypervisors
+	 * and is very computational/memory expensive. Therefore we
+	 * ratelimit the executions per VM.
+	 */
+	if (!__ratelimit(&vcpu->kvm->arch.sthyi_limit)) {
+		kvm_s390_retry_instr(vcpu);
+		return 0;
+	}
+
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 	code = vcpu->run->s.regs.gprs[reg1];
 	addr = vcpu->run->s.regs.gprs[reg2];
-- 
2.5.5
