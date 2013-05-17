From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/8] s390/kvm: fix psw rewinding in handle_skey
Date: Fri, 17 May 2013 14:41:32 +0200
Message-ID: <1368794498-2051-3-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The PSW can wrap if the guest has been running in the 24 bit or 31 bit
addressing mode. Use __rewind_psw to find the correct address.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 6bbd7b5..ecc58a6 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -105,7 +105,8 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 static int handle_skey(struct kvm_vcpu *vcpu)
 {
 	vcpu->stat.instruction_storage_key++;
-	vcpu->arch.sie_block->gpsw.addr -= 4;
+	vcpu->arch.sie_block->gpsw.addr =
+		__rewind_psw(vcpu->arch.sie_block->gpsw, 4);
 	VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
 	return 0;
 }
-- 
1.8.1.4
