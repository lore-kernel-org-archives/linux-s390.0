From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 08/47] s390/ctl_reg: add union type for control register 0
Date: Tue, 15 Apr 2014 14:00:11 +0200
Message-ID: <1397563250-3089-9-git-send-email-borntraeger@de.ibm.com>
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

Add 'union ctlreg0_bits' to easily allow setting and testing bits of
control register 0 bits.
This patch only adds the bits needed for the new guest access functions.
Other bits and control registers can be added when needed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/ctl_reg.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 4e63f1a..31ab9f3 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -57,6 +57,20 @@ static inline void __ctl_clear_bit(unsigned int cr, unsigned int bit)
 void smp_ctl_set_bit(int cr, int bit);
 void smp_ctl_clear_bit(int cr, int bit);
 
+union ctlreg0 {
+	unsigned long val;
+	struct {
+#ifdef CONFIG_64BIT
+		unsigned long	   : 32;
+#endif
+		unsigned long	   : 3;
+		unsigned long lap  : 1; /* Low-address-protection control */
+		unsigned long	   : 4;
+		unsigned long edat : 1; /* Enhanced-DAT-enablement control */
+		unsigned long	   : 23;
+	};
+};
+
 #ifdef CONFIG_SMP
 # define ctl_set_bit(cr, bit) smp_ctl_set_bit(cr, bit)
 # define ctl_clear_bit(cr, bit) smp_ctl_clear_bit(cr, bit)
-- 
1.8.4.2
