From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 4/7] KVM: s390: Check for PSTATE when handling DIAGNOSE
Date: Thu, 20 Jun 2013 17:22:02 +0200
Message-ID: <1371741725-53624-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

DIAGNOSE is a privileged instruction and thus we must make sure that we are
in supervisor mode before taking any other actions.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 1c01a99..3074475 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -132,6 +132,9 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 {
 	int code = (vcpu->arch.sie_block->ipb & 0xfff0000) >> 16;
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	trace_kvm_s390_handle_diag(vcpu, code);
 	switch (code) {
 	case 0x10:
-- 
1.8.2.2
