From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/12] KVM: s390: guestdbg: filter i-fetch events on icpts
Date: Wed,  1 Feb 2017 12:38:10 +0100
Message-ID: <1485949094-138708-9-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We already filter PER events reported via icpt code 8. For icpt code
4 and 56, this is still missing.

So let's properly detect if we have a debugging event and if we have to
inject a PER i-fetch event into the guest at all.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index d7c6a7f..a207783 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -388,14 +388,13 @@ void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu)
 #define per_write_wp_event(code) \
 			(code & (PER_CODE_STORE | PER_CODE_STORE_REAL))
 
-static int debug_exit_required(struct kvm_vcpu *vcpu)
+static int debug_exit_required(struct kvm_vcpu *vcpu, u8 perc,
+			       unsigned long peraddr)
 {
-	u8 perc = vcpu->arch.sie_block->perc;
 	struct kvm_debug_exit_arch *debug_exit = &vcpu->run->debug.arch;
 	struct kvm_hw_wp_info_arch *wp_info = NULL;
 	struct kvm_hw_bp_info_arch *bp_info = NULL;
 	unsigned long addr = vcpu->arch.sie_block->gpsw.addr;
-	unsigned long peraddr = vcpu->arch.sie_block->peraddr;
 
 	if (guestdbg_hw_bp_enabled(vcpu)) {
 		if (per_write_wp_event(perc) &&
@@ -442,6 +441,8 @@ static int debug_exit_required(struct kvm_vcpu *vcpu)
 
 int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu)
 {
+	const u64 cr10 = vcpu->arch.sie_block->gcr[10];
+	const u64 cr11 = vcpu->arch.sie_block->gcr[11];
 	const u8 ilen = kvm_s390_get_ilen(vcpu);
 	struct kvm_s390_pgm_info pgm_info = {
 		.code = PGM_PER,
@@ -454,7 +455,19 @@ int kvm_s390_handle_per_ifetch_icpt(struct kvm_vcpu *vcpu)
 	 * instruction generated a PER i-fetch event. PER address therefore
 	 * points at the previous PSW address (could be an EXECUTE function).
 	 */
-	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
+	if (!guestdbg_enabled(vcpu))
+		return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
+
+	if (debug_exit_required(vcpu, pgm_info.per_code, pgm_info.per_address))
+		vcpu->guest_debug |= KVM_GUESTDBG_EXIT_PENDING;
+
+	if (!guest_per_enabled(vcpu) ||
+	    !(vcpu->arch.sie_block->gcr[9] & PER_EVENT_IFETCH))
+		return 0;
+
+	if (in_addr_range(pgm_info.per_address, cr10, cr11))
+		return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
+	return 0;
 }
 
 static void filter_guest_per_event(struct kvm_vcpu *vcpu)
@@ -500,7 +513,8 @@ void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu)
 {
 	int new_as;
 
-	if (debug_exit_required(vcpu))
+	if (debug_exit_required(vcpu, vcpu->arch.sie_block->perc,
+				vcpu->arch.sie_block->peraddr))
 		vcpu->guest_debug |= KVM_GUESTDBG_EXIT_PENDING;
 
 	filter_guest_per_event(vcpu);
-- 
2.7.4
