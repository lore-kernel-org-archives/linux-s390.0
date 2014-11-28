From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/11] KVM: s390: trigger the right CPU exit for floating interrupts
Date: Fri, 28 Nov 2014 14:25:31 +0100
Message-ID: <1417181139-25623-4-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When injecting a floating interrupt and no CPU is idle we
kick one CPU to do an external exit. In case of I/O we
should trigger an I/O exit instead. This does not matter
for Linux guests as external and I/O interrupts are
enabled/disabled at the same time, but play safe anyway.

The same holds true for machine checks. Since there is no
special exit, just reuse the generic stop exit. The injection
code inside the VCPU loop will recheck anyway and rearm the
proper exits (e.g. control registers) if necessary.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/s390/kvm/interrupt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4fc3fed..ead52bf 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -851,7 +851,17 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
 	li = &dst_vcpu->arch.local_int;
 	spin_lock(&li->lock);
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+	switch (inti->type) {
+	case KVM_S390_MCHK:
+		atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
+		break;
+	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
+		atomic_set_mask(CPUSTAT_IO_INT, li->cpuflags);
+		break;
+	default:
+		atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+		break;
+	}
 	spin_unlock(&li->lock);
 	kvm_s390_vcpu_wakeup(kvm_get_vcpu(kvm, sigcpu));
 unlock_fi:
-- 
1.9.3
