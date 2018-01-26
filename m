From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 15/22] s390/css: indicate the availability of the AIV facility
Date: Fri, 26 Jan 2018 16:53:27 +0100
Message-ID: <20180126155334.52956-16-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The patch adds an indication for the presence Adapter Interruption
Virtualization facility (AIV) of the general channel subsystem
characteristics.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[change wording]
---
 arch/s390/include/asm/css_chars.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/css_chars.h b/arch/s390/include/asm/css_chars.h
index a478eb61aaf7f..fb56fa3283a2c 100644
--- a/arch/s390/include/asm/css_chars.h
+++ b/arch/s390/include/asm/css_chars.h
@@ -20,7 +20,9 @@ struct css_general_char {
 	u32 aif_tdd : 1; /* bit 56 */
 	u32 : 1;
 	u32 qebsm : 1;	 /* bit 58 */
-	u32 : 8;
+	u32 : 2;
+	u32 aiv : 1;     /* bit 61 */
+	u32 : 5;
 	u32 aif_osa : 1; /* bit 67 */
 	u32 : 12;
 	u32 eadm_rf : 1; /* bit 80 */
-- 
2.13.4
