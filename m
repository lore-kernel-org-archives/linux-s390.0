From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 26/51] s390: introduce page_to_virt() and pfn_to_virt()
Date: Tue, 21 Jun 2016 15:13:04 +0200
Message-ID: <1466514809-146638-27-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index f874e7d5..b5edff3 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -147,6 +147,8 @@ static inline int devmem_is_allowed(unsigned long pfn)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
+#define page_to_virt(page)	pfn_to_virt(page_to_pfn(page))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-- 
2.5.5
