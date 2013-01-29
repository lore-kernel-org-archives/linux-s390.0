Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 29 Jan 2013 09:10:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] one s390 patch for 3.8-rc6
Message-ID: <20130129091019.0e7c4455@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following update:
Another transparent huge page fix, we need to define a s390 variant
for pmdp_set_wrprotect to flush the TLB for the huge page correctly.

Gerald Schaefer (1):
      s390/thp: implement pmdp_set_wrprotect()

 arch/s390/include/asm/pgtable.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index c1d7930..098adbb 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1365,6 +1365,18 @@ static inline void pmdp_invalidate(struct vm_area_struct *vma,
 	__pmd_idte(address, pmdp);
 }
 
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm,
+				      unsigned long address, pmd_t *pmdp)
+{
+	pmd_t pmd = *pmdp;
+
+	if (pmd_write(pmd)) {
+		__pmd_idte(address, pmdp);
+		set_pmd_at(mm, address, pmdp, pmd_wrprotect(pmd));
+	}
+}
+
 static inline pmd_t mk_pmd_phys(unsigned long physpage, pgprot_t pgprot)
 {
 	pmd_t __pmd;
