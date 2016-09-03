Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 05/17] s390/debug: Fix jump targets in debug_info_alloc()
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <04f27ca2-274e-d09c-fc3e-d0a387f6bf05@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:18:09 +0200
MIME-Version: 1.0
In-Reply-To: <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Sep 2016 18:26:58 +0200

Adjust jump targets according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 0af14a4..c5da41b 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -244,17 +244,17 @@ debug_info_alloc(const char *name, int pages_per_area, int nr_areas,
 
 	rc = kmalloc(sizeof(debug_info_t), GFP_KERNEL);
 	if(!rc)
-		goto fail_malloc_rc;
+		goto exit;
 	rc->active_entries = kcalloc(nr_areas, sizeof(int), GFP_KERNEL);
 	if(!rc->active_entries)
-		goto fail_malloc_active_entries;
+		goto free_rc;
 	rc->active_pages = kcalloc(nr_areas, sizeof(int), GFP_KERNEL);
 	if(!rc->active_pages)
-		goto fail_malloc_active_pages;
+		goto free_entries;
 	if((mode == ALL_AREAS) && (pages_per_area != 0)){
 		rc->areas = debug_areas_alloc(pages_per_area, nr_areas);
 		if(!rc->areas)
-			goto fail_malloc_areas;
+			goto free_pages;
 	} else {
 		rc->areas = NULL;
 	}
@@ -275,14 +275,13 @@ debug_info_alloc(const char *name, int pages_per_area, int nr_areas,
 	atomic_set(&(rc->ref_count), 0);
 
 	return rc;
-
-fail_malloc_areas:
+ free_pages:
 	kfree(rc->active_pages);
-fail_malloc_active_pages:
+ free_entries:
 	kfree(rc->active_entries);
-fail_malloc_active_entries:
+ free_rc:
 	kfree(rc);
-fail_malloc_rc:
+ exit:
 	return NULL;
 }
 
-- 
2.9.3
