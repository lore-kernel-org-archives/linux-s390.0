From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/12] KVM: s390: Avoid endless loops of specification exceptions
Date: Fri, 16 May 2014 16:09:39 +0200
Message-ID: <1400249388-3969-4-git-send-email-borntraeger@de.ibm.com>
References: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

If the new PSW for program interrupts is invalid, the VM ends up
in an endless loop of specification exceptions. Since there is not
much left we can do in this case, we should better drop to userspace
instead so that the crash can be reported to the user.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index bd607cf..ddc69f5 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -195,6 +195,7 @@ static int handle_itdb(struct kvm_vcpu *vcpu)
 static int handle_prog(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_pgm_info pgm_info;
+	psw_t psw;
 	int rc;
 
 	vcpu->stat.exit_program_interruption++;
@@ -207,7 +208,14 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 	}
 
 	trace_kvm_s390_intercept_prog(vcpu, vcpu->arch.sie_block->iprcc);
-
+	if (vcpu->arch.sie_block->iprcc == PGM_SPECIFICATION) {
+		rc = read_guest_lc(vcpu, __LC_PGM_NEW_PSW, &psw, sizeof(psw_t));
+		if (rc)
+			return rc;
+		/* Avoid endless loops of specification exceptions */
+		if (!is_valid_psw(&psw))
+			return -EOPNOTSUPP;
+	}
 	rc = handle_itdb(vcpu);
 	if (rc)
 		return rc;
-- 
1.8.4.2
