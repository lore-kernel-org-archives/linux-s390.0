From: Christoffer Dall <cdall@kernel.org>
Subject: [PATCH v3 10/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_translate
Date: Mon,  4 Dec 2017 21:35:32 +0100
Message-ID: <20171204203538.8370-11-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

From: Christoffer Dall <christoffer.dall@linaro.org>

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_translate().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/booke.c | 2 ++
 arch/x86/kvm/x86.c       | 3 +++
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index cdf0be02c95a..1b491b89cd43 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1793,7 +1793,9 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 {
 	int r;
 
+	vcpu_load(vcpu);
 	r = kvmppc_core_vcpu_translate(vcpu, tr);
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8e67428af01b..c30ba99e7aa3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7660,6 +7660,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	gpa_t gpa;
 	int idx;
 
+	vcpu_load(vcpu);
+
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
@@ -7668,6 +7670,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	tr->writeable = 1;
 	tr->usermode = 0;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f3600052adbb..0a8a49073a23 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2627,9 +2627,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2
