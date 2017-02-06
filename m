From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/14] KVM: s390: detect some program check loops
Date: Mon,  6 Feb 2017 12:46:32 +0100
Message-ID: <1486381592-12949-3-git-send-email-borntraeger@de.ibm.com>
References: <1486381592-12949-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1486381592-12949-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Sometimes (e.g. early boot) a guest is broken in such ways that it loops
100% delivering operation exceptions (illegal operation) but the pgm new
PSW is not set properly. This will result in code being read from
address zero, which usually contains another illegal op. Let's detect
this case and return to userspace. Instead of only detecting
this for address zero apply a heuristic that will work for any program
check new psw.
We do not want guest problem state to be able to trigger a guest panic,
e.g. by faulting on an address that is the same as the program check
new PSW, so we check for the problem state bit being off.

With proper handling in userspace we
a: get rid of CPU consumption of such broken guests
b: keep the program old PSW. This allows to find out the original illegal
   operation - making debugging such early boot issues much easier than
   with single stepping

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 8b13f70..59920f9 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -361,6 +361,9 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
 
 static int handle_operexc(struct kvm_vcpu *vcpu)
 {
+	psw_t oldpsw, newpsw;
+	int rc;
+
 	vcpu->stat.exit_operation_exception++;
 	trace_kvm_s390_handle_operexc(vcpu, vcpu->arch.sie_block->ipa,
 				      vcpu->arch.sie_block->ipb);
@@ -371,6 +374,24 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 
 	if (vcpu->arch.sie_block->ipa == 0 && vcpu->kvm->arch.user_instr0)
 		return -EOPNOTSUPP;
+	rc = read_guest_lc(vcpu, __LC_PGM_NEW_PSW, &newpsw, sizeof(psw_t));
+	if (rc)
+		return rc;
+	/*
+	 * Avoid endless loops of operation exceptions, if the pgm new
+	 * PSW will cause a new operation exception.
+	 * The heuristic checks if the pgm new psw is within 6 bytes before
+	 * the faulting psw address (with same DAT, AS settings) and the
+	 * new psw is not a wait psw and the fault was not triggered by
+	 * problem state.
+	 */
+	oldpsw = vcpu->arch.sie_block->gpsw;
+	if (oldpsw.addr - newpsw.addr <= 6 &&
+	    !(newpsw.mask & PSW_MASK_WAIT) &&
+	    !(oldpsw.mask & PSW_MASK_PSTATE) &&
+	    (newpsw.mask & PSW_MASK_ASC) == (oldpsw.mask & PSW_MASK_ASC) &&
+	    (newpsw.mask & PSW_MASK_DAT) == (oldpsw.mask & PSW_MASK_DAT))
+		return -EOPNOTSUPP;
 
 	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 }
-- 
2.7.4
