From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/22] s390/bitops: add test_and_clear_bit_inv()
Date: Fri, 26 Jan 2018 16:53:25 +0100
Message-ID: <20180126155334.52956-14-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

This patch adds a MSB0 bit numbering version of test_and_clear_bit().

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/bitops.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 31e400c1a1f35..86e5b2fdee3c8 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -261,6 +261,11 @@ static inline void clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
 	return clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
 }
 
+static inline int test_and_clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
+{
+	return test_and_clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
+}
+
 static inline void __set_bit_inv(unsigned long nr, volatile unsigned long *ptr)
 {
 	return __set_bit(nr ^ (BITS_PER_LONG - 1), ptr);
-- 
2.13.4
