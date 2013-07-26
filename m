From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 8/8] KVM: s390: Make KVM_HVA_ERR_BAD usable on s390
Date: Fri, 26 Jul 2013 15:04:07 +0200
Message-ID: <1374843847-5046-9-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Current common code uses PAGE_OFFSET to indicate a bad host virtual address.
As this check won't work on architectures that don't map kernel and user memory
into the same address space (e.g. s390), such architectures can now provide
their own KVM_HVA_ERR_BAD defines.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 8 ++++++++
 include/linux/kvm_host.h         | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3238d40..e87ecaa 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -274,6 +274,14 @@ struct kvm_arch{
 	int css_support;
 };
 
+#define KVM_HVA_ERR_BAD		(-1UL)
+#define KVM_HVA_ERR_RO_BAD	(-2UL)
+
+static inline bool kvm_is_error_hva(unsigned long addr)
+{
+	return IS_ERR_VALUE(addr);
+}
+
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c11c7686..ca645a0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -85,6 +85,12 @@ static inline bool is_noslot_pfn(pfn_t pfn)
 	return pfn == KVM_PFN_NOSLOT;
 }
 
+/*
+ * architectures with KVM_HVA_ERR_BAD other than PAGE_OFFSET (e.g. s390)
+ * provide own defines and kvm_is_error_hva
+ */
+#ifndef KVM_HVA_ERR_BAD
+
 #define KVM_HVA_ERR_BAD		(PAGE_OFFSET)
 #define KVM_HVA_ERR_RO_BAD	(PAGE_OFFSET + PAGE_SIZE)
 
@@ -93,6 +99,8 @@ static inline bool kvm_is_error_hva(unsigned long addr)
 	return addr >= PAGE_OFFSET;
 }
 
+#endif
+
 #define KVM_ERR_PTR_BAD_PAGE	(ERR_PTR(-ENOENT))
 
 static inline bool is_error_page(struct page *page)
-- 
1.8.3.1
