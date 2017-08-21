From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: sthyi: fix sthyi inline assembly
Date: Mon, 21 Aug 2017 17:34:49 +0200
Message-ID: <1503329690-34224-2-git-send-email-borntraeger@de.ibm.com>
References: <1503329690-34224-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1503329690-34224-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The sthyi inline assembly misses register r3 within the clobber
list. The sthyi instruction will always write a return code to
register "R2+1", which in this case would be r3. Due to that we may
have register corruption and see host crashes or data corruption
depending on how gcc decided to allocate and use registers during
compile time.

Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
Cc: <stable@vger.kernel.org> # 4.8+
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sthyi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
index 926b524..2773a2f 100644
--- a/arch/s390/kvm/sthyi.c
+++ b/arch/s390/kvm/sthyi.c
@@ -394,7 +394,7 @@ static int sthyi(u64 vaddr)
 		"srl     %[cc],28\n"
 		: [cc] "=d" (cc)
 		: [code] "d" (code), [addr] "a" (addr)
-		: "memory", "cc");
+		: "3", "memory", "cc");
 	return cc;
 }
 
-- 
2.7.4
