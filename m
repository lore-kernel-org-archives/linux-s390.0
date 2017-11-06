From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 12/22] s390/mm: Add gmap_protect_large read protection support
Date: Mon,  6 Nov 2017 23:29:50 +0100
Message-ID: <1510007400-42493-13-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We need to be able to write protect segments for when shadowing them
for VSIE.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h | 1 +
 arch/s390/mm/gmap.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 16474c3..dfd50d7 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -16,6 +16,7 @@
 #define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
 /* Status bits only for huge segment entries */
 #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
+#define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
 
 /**
  * struct gmap_struct - guest address space
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index d23b750..69a575b 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1087,6 +1087,7 @@ static int gmap_protect_large(struct gmap *gmap, unsigned long gaddr,
 	int ret = 0;
 
 	sbits |= (bits & GMAP_ENTRY_IN) ? _SEGMENT_ENTRY_GMAP_IN : 0;
+	sbits |= (bits & GMAP_ENTRY_VSIE) ? _SEGMENT_ENTRY_GMAP_VSIE : 0;
 	/* Protect gmap pmd */
 	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot, sbits);
 	/*
-- 
2.7.4
