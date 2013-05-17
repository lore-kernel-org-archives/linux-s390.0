From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/8] s390/pgtable: fix ipte notify bit
Date: Fri, 17 May 2013 14:41:31 +0200
Message-ID: <1368794498-2051-2-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Dont use the same bit as user referenced.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 4105b82..0f0de30 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -306,7 +306,7 @@ extern unsigned long MODULES_END;
 #define RCP_HC_BIT	0x00200000UL
 #define RCP_GR_BIT	0x00040000UL
 #define RCP_GC_BIT	0x00020000UL
-#define RCP_IN_BIT	0x00008000UL	/* IPTE notify bit */
+#define RCP_IN_BIT	0x00002000UL	/* IPTE notify bit */
 
 /* User dirty / referenced bit for KVM's migration feature */
 #define KVM_UR_BIT	0x00008000UL
@@ -374,7 +374,7 @@ extern unsigned long MODULES_END;
 #define RCP_HC_BIT	0x0020000000000000UL
 #define RCP_GR_BIT	0x0004000000000000UL
 #define RCP_GC_BIT	0x0002000000000000UL
-#define RCP_IN_BIT	0x0000800000000000UL	/* IPTE notify bit */
+#define RCP_IN_BIT	0x0000200000000000UL	/* IPTE notify bit */
 
 /* User dirty / referenced bit for KVM's migration feature */
 #define KVM_UR_BIT	0x0000800000000000UL
-- 
1.8.1.4
