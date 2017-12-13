From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v2 12/22] s390/mm: Add gmap_protect_large read protection support
Date: Wed, 13 Dec 2017 13:53:23 +0100
Message-ID: <1513169613-13509-13-git-send-email-frankja@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
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
index ba12eef..518e00c 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -17,6 +17,7 @@
 #define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
 /* Status bits only for huge segment entries */
 #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
+#define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
 
 /**
  * struct gmap_struct - guest address space
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index d396da8..dabc734 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1079,6 +1079,7 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
 	int ret = 0;
 
 	sbits |= (bits & GMAP_NOTIFY_MPROT) ? _SEGMENT_ENTRY_GMAP_IN : 0;
+	sbits |= (bits & GMAP_NOTIFY_SHADOW) ? _SEGMENT_ENTRY_GMAP_VSIE : 0;
 	/* Protect gmap pmd */
 	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot, sbits);
 	/*
-- 
2.7.4
