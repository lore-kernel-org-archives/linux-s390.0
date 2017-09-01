From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/3] KVM: s390: guestdbg: fix range check
Date: Fri,  1 Sep 2017 09:46:46 +0200
Message-ID: <1504252008-102471-2-git-send-email-borntraeger@de.ibm.com>
References: <1504252008-102471-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1504252008-102471-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

Looks like the "overflowing" range check is wrong.

|=======b-------a=======|

addr >= a || addr <= b

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170830160603.5452-2-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index c2e0ddc..bcbd866 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -308,7 +308,7 @@ static inline int in_addr_range(u64 addr, u64 a, u64 b)
 		return (addr >= a) && (addr <= b);
 	else
 		/* "overflowing" interval */
-		return (addr <= a) && (addr >= b);
+		return (addr >= a) || (addr <= b);
 }
 
 #define end_of_range(bp_info) (bp_info->addr + bp_info->len - 1)
-- 
2.7.4
