From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 31/47] KVM: s390: convert handle_stsi()
Date: Tue, 15 Apr 2014 14:00:34 +0200
Message-ID: <1397563250-3089-32-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert handle_stsi() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 44ff220..5fb503a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -530,9 +530,10 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		break;
 	}
 
-	if (copy_to_guest_absolute(vcpu, operand2, (void *) mem, PAGE_SIZE)) {
-		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out_exception;
+	rc = write_guest(vcpu, operand2, (void *)mem, PAGE_SIZE);
+	if (rc) {
+		rc = kvm_s390_inject_prog_cond(vcpu, rc);
+		goto out;
 	}
 	trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
 	free_page(mem);
@@ -541,7 +542,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	return 0;
 out_no_data:
 	kvm_s390_set_psw_cc(vcpu, 3);
-out_exception:
+out:
 	free_page(mem);
 	return rc;
 }
-- 
1.8.4.2
