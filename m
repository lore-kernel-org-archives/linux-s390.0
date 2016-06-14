From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 40/52] s390/mm: don't drop errors in get_guest_storage_key
Date: Tue, 14 Jun 2016 20:57:17 +0200
Message-ID: <201606141857.u5EIs1GI001865@mx0a-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, 4.6+@tuxmaker.boeblingen.de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Commit 1e133ab296f3 ("s390/mm: split arch/s390/mm/pgtable.c") changed
the return value of get_guest_storage_key to an unsigned char, resulting
in -EFAULT getting interpreted as a valid storage key.

Cc: stable@vger.kernel.org # 4.6+
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 2 +-
 arch/s390/mm/pgtable.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 18d2beb..42b968a8 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -893,7 +893,7 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq);
-unsigned char get_guest_storage_key(struct mm_struct *mm, unsigned long addr);
+unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr);
 
 /*
  * Certain architectures need to do special things when PTEs
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4324b87..2a23ca9 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -543,7 +543,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(set_guest_storage_key);
 
-unsigned char get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
+unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned char key;
 	spinlock_t *ptl;
-- 
2.5.5
