From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: gaccess: fix real-space designation asce handling for gmap shadows
Date: Thu, 22 Jun 2017 15:34:27 +0200
Message-ID: <1498138467-29808-2-git-send-email-borntraeger@de.ibm.com>
References: <1498138467-29808-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498138467-29808-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

For real-space designation asces the asce origin part is only a token.
The asce token origin must not be used to generate an effective
address for storage references. This however is erroneously done
within kvm_s390_shadow_tables().

Furthermore within the same function the wrong parts of virtual
addresses are used to generate a corresponding real address
(e.g. the region second index is used as region first index).

Both of the above can result in incorrect address translations. Only
for real space designations with a token origin of zero and addresses
below one megabyte the translation was correct.

Furthermore replace a "!asce.r" statement with a "!*fake" statement to
make it more obvious that a specific condition has nothing to do with
the architecture, but with the fake handling of real space designations.

Fixes: 3218f7094b6b ("s390/mm: support real-space for gmap shadows")
Cc: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 9da243d..3b297fa 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -977,11 +977,12 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 	ptr = asce.origin * 4096;
 	if (asce.r) {
 		*fake = 1;
+		ptr = 0;
 		asce.dt = ASCE_TYPE_REGION1;
 	}
 	switch (asce.dt) {
 	case ASCE_TYPE_REGION1:
-		if (vaddr.rfx01 > asce.tl && !asce.r)
+		if (vaddr.rfx01 > asce.tl && !*fake)
 			return PGM_REGION_FIRST_TRANS;
 		break;
 	case ASCE_TYPE_REGION2:
@@ -1009,8 +1010,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		union region1_table_entry rfte;
 
 		if (*fake) {
-			/* offset in 16EB guest memory block */
-			ptr = ptr + ((unsigned long) vaddr.rsx << 53UL);
+			ptr += (unsigned long) vaddr.rfx << 53;
 			rfte.val = ptr;
 			goto shadow_r2t;
 		}
@@ -1036,8 +1036,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		union region2_table_entry rste;
 
 		if (*fake) {
-			/* offset in 8PB guest memory block */
-			ptr = ptr + ((unsigned long) vaddr.rtx << 42UL);
+			ptr += (unsigned long) vaddr.rsx << 42;
 			rste.val = ptr;
 			goto shadow_r3t;
 		}
@@ -1064,8 +1063,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		union region3_table_entry rtte;
 
 		if (*fake) {
-			/* offset in 4TB guest memory block */
-			ptr = ptr + ((unsigned long) vaddr.sx << 31UL);
+			ptr += (unsigned long) vaddr.rtx << 31;
 			rtte.val = ptr;
 			goto shadow_sgt;
 		}
@@ -1101,8 +1099,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		union segment_table_entry ste;
 
 		if (*fake) {
-			/* offset in 2G guest memory block */
-			ptr = ptr + ((unsigned long) vaddr.sx << 20UL);
+			ptr += (unsigned long) vaddr.sx << 20;
 			ste.val = ptr;
 			goto shadow_pgt;
 		}
-- 
2.7.4
