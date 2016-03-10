From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/9] KVM: s390: step the VCPU timer while in enabled wait
Date: Thu, 10 Mar 2016 16:36:56 +0100
Message-ID: <1457624219-110920-7-git-send-email-borntraeger@de.ibm.com>
References: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The cpu timer is a mean to measure task execution time. We want
to account everything for a VCPU for which it is responsible. Therefore,
if the VCPU wants to sleep, it shall be accounted for it.

We can easily get this done by not disabling cpu timer accounting when
scheduled out while sleeping because of enabled wait.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 arch/s390/kvm/kvm-s390.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 38223c4..b54daed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1538,7 +1538,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	restore_access_regs(vcpu->run->s.regs.acrs);
 	gmap_enable(vcpu->arch.gmap);
 	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
-	if (vcpu->arch.cputm_enabled)
+	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
 		__start_cpu_timer_accounting(vcpu);
 	vcpu->cpu = cpu;
 }
@@ -1546,7 +1546,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	vcpu->cpu = -1;
-	if (vcpu->arch.cputm_enabled)
+	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
 		__stop_cpu_timer_accounting(vcpu);
 	atomic_andnot(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	gmap_disable(vcpu->arch.gmap);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 9787299..b1f7ee3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -54,6 +54,11 @@ static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_STOPPED;
 }
 
+static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
+{
+	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_WAIT;
+}
+
 static inline int kvm_is_ucontrol(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_S390_UCONTROL
-- 
2.5.0
