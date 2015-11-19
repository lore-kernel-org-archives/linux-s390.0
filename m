From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/4] KVM: s390: fix wrong lookup of VCPUs by array index
Date: Thu, 19 Nov 2015 09:37:29 +0100
Message-ID: <1447922251-54261-3-git-send-email-borntraeger@de.ibm.com>
References: <1447922251-54261-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1447922251-54261-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, "c3853a8:KVM:Provide"@tuxmaker.boeblingen.de.ibm.com, function@tuxmaker.boeblingen.de.ibm.com, for@tuxmaker.boeblingen.de.ibm.com, VCPU@tuxmaker.boeblingen.de.ibm.com, lookup@tuxmaker.boeblingen.de.ibm.com, by@tuxmaker.boeblingen.de.ibm.com, id@tuxmaker.boeblingen.de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

For now, VCPUs were always created sequentially with incrementing
VCPU ids. Therefore, the index in the VCPUs array matched the id.

As sequential creation might change with cpu hotplug, let's use
the correct lookup function to find a VCPU by id, not array index.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split stable/non-stable parts]
Cc: stable@vger.kernel.org # c3853a8: KVM: Provide function for VCPU lookup by id
---
 arch/s390/kvm/sigp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index da690b6..081dbd0 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -291,12 +291,8 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 			   u16 cpu_addr, u32 parameter, u64 *status_reg)
 {
 	int rc;
-	struct kvm_vcpu *dst_vcpu;
+	struct kvm_vcpu *dst_vcpu = kvm_lookup_vcpu(vcpu->kvm, cpu_addr);
 
-	if (cpu_addr >= KVM_MAX_VCPUS)
-		return SIGP_CC_NOT_OPERATIONAL;
-
-	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
 	if (!dst_vcpu)
 		return SIGP_CC_NOT_OPERATIONAL;
 
@@ -478,7 +474,7 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_handle_sigp_pei(vcpu, order_code, cpu_addr);
 
 	if (order_code == SIGP_EXTERNAL_CALL) {
-		dest_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+		dest_vcpu = kvm_lookup_vcpu(vcpu->kvm, cpu_addr);
 		BUG_ON(dest_vcpu == NULL);
 
 		kvm_s390_vcpu_wakeup(dest_vcpu);
-- 
2.3.0
