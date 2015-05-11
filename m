From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/9] KVM: s390: make EDAT1 depend on host support
Date: Mon, 11 May 2015 10:44:31 +0200
Message-ID: <1431333877-28700-4-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Guenther Hutzl <hutzl@linux.vnet.ibm.com>

We should only enable EDAT1 for the guest if the host actually supports
it and the cpu model for the guest has EDAT-1 enabled.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f5282e6..2da36c4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1311,8 +1311,11 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	atomic_set(&vcpu->arch.sie_block->cpuflags, CPUSTAT_ZARCH |
 						    CPUSTAT_SM |
-						    CPUSTAT_STOPPED |
-						    CPUSTAT_GED);
+						    CPUSTAT_STOPPED);
+
+	if (test_kvm_facility(vcpu->kvm, 8))
+		atomic_set_mask(CPUSTAT_GED, &vcpu->arch.sie_block->cpuflags);
+
 	kvm_s390_vcpu_setup_model(vcpu);
 
 	vcpu->arch.sie_block->ecb   = 6;
-- 
2.3.0
