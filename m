From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/9] KVM: s390: store cpu id in vcpu->cpu when scheduled in
Date: Thu, 10 Mar 2016 16:36:52 +0100
Message-ID: <1457624219-110920-3-git-send-email-borntraeger@de.ibm.com>
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

By storing the cpu id, we have a way to verify if the current cpu is
owning a VCPU.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 28bd5ea..bd5edb1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1449,10 +1449,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	restore_access_regs(vcpu->run->s.regs.acrs);
 	gmap_enable(vcpu->arch.gmap);
 	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	vcpu->cpu = cpu;
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	vcpu->cpu = -1;
 	atomic_andnot(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	gmap_disable(vcpu->arch.gmap);
 
-- 
2.5.0
