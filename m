From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 23/47] KVM: s390: convert handle_store_prefix()
Date: Tue, 15 Apr 2014 14:00:26 +0200
Message-ID: <1397563250-3089-24-git-send-email-borntraeger@de.ibm.com>
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

Convert handle_store_prefix() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9648504..306caa2 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -106,6 +106,7 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 {
 	u64 operand2;
 	u32 address;
+	int rc;
 
 	vcpu->stat.instruction_stpx++;
 
@@ -122,8 +123,9 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	address = address & 0x7fffe000u;
 
 	/* get the value */
-	if (put_guest(vcpu, address, (u32 __user *)operand2))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = write_guest(vcpu, operand2, &address, sizeof(address));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 
 	VCPU_EVENT(vcpu, 5, "storing prefix to %x", address);
 	trace_kvm_s390_handle_prefix(vcpu, 0, address);
-- 
1.8.4.2
