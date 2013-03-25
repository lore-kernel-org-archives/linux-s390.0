From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 02/11] KVM: s390: fix 24 bit psw handling in lpsw/lpswe handler
Date: Mon, 25 Mar 2013 17:22:49 +0100
Message-ID: <1364228578-20528-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

When checking for validity the lpsw/lpswe handler check that only
the lower 20 bits instead of 24 bits have a non-zero value.
There handling valid psws as invalid ones.
Fix the 24 bit psw mask.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 7db2ad0..7b397b3 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -255,7 +255,7 @@ static void handle_new_psw(struct kvm_vcpu *vcpu)
 
 #define PSW_MASK_ADDR_MODE (PSW_MASK_EA | PSW_MASK_BA)
 #define PSW_MASK_UNASSIGNED 0xb80800fe7fffffffUL
-#define PSW_ADDR_24 0x00000000000fffffUL
+#define PSW_ADDR_24 0x0000000000ffffffUL
 #define PSW_ADDR_31 0x000000007fffffffUL
 
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
-- 
1.7.12.4
