Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 02/17] s390/debug: Delete unnecessary braces
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <502fe4ad-d627-2f8d-e1e6-a45bcd8e0ce2@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:13:03 +0200
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
Date: Thu, 1 Sep 2016 15:06:06 +0200

Do not use curly brackets at some source code places
where a single statement should be sufficient.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 8e2be30..ddfc5e4 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -203,15 +203,13 @@ debug_areas_alloc(int pages_per_area, int nr_areas)
 		areas[i] = kmalloc_array(pages_per_area,
 					 sizeof(*areas[i]),
 					 GFP_KERNEL);
-		if (!areas[i]) {
+		if (!areas[i])
 			goto fail_malloc_areas2;
-		}
 		for(j = 0; j < pages_per_area; j++) {
 			areas[i][j] = kzalloc(PAGE_SIZE, GFP_KERNEL);
 			if(!areas[i][j]) {
-				for(j--; j >=0 ; j--) {
+				for (j--; j >= 0; j--)
 					kfree(areas[i][j]);
-				}
 				kfree(areas[i]);
 				goto fail_malloc_areas2;
 			}
@@ -221,9 +219,8 @@ debug_areas_alloc(int pages_per_area, int nr_areas)
 
 fail_malloc_areas2:
 	for(i--; i >= 0; i--){
-		for(j=0; j < pages_per_area;j++){
+		for (j = 0; j < pages_per_area; j++)
 			kfree(areas[i][j]);
-		}
 		kfree(areas[i]);
 	}
 	kfree(areas);
@@ -303,9 +300,8 @@ debug_areas_free(debug_info_t* db_info)
 	if(!db_info->areas)
 		return;
 	for (i = 0; i < db_info->nr_areas; i++) {
-		for(j = 0; j < db_info->pages_per_area; j++) {
+		for (j = 0; j < db_info->pages_per_area; j++)
 			kfree(db_info->areas[i][j]);
-		}
 		kfree(db_info->areas[i]);
 	}
 	kfree(db_info->areas);
@@ -396,11 +392,9 @@ debug_info_copy(debug_info_t* in, int mode)
 	if (mode == NO_AREAS)
                 goto out;
 
-        for(i = 0; i < in->nr_areas; i++){
-		for(j = 0; j < in->pages_per_area; j++) {
+	for (i = 0; i < in->nr_areas; i++)
+		for (j = 0; j < in->pages_per_area; j++)
 			memcpy(rc->areas[i][j], in->areas[i][j],PAGE_SIZE);
-		}
-        }
 out:
         spin_unlock_irqrestore(&in->lock, flags);
         return rc;
@@ -711,9 +705,8 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
         debug_register_view(rc, &debug_flush_view);
 	debug_register_view(rc, &debug_pages_view);
 out:
-        if (!rc){
+	if (!rc)
 		pr_err("Registering debug feature %s failed\n", name);
-        }
 	mutex_unlock(&debug_mutex);
 	return rc;
 }
@@ -1005,10 +998,9 @@ debug_count_numargs(char *string)
 {
 	int numargs=0;
 
-	while(*string) {
+	while (*string)
 		if(*string++=='%')
 			numargs++;
-	}
 	return(numargs);
 }
 
@@ -1114,10 +1106,9 @@ debug_register_view(debug_info_t * id, struct debug_view *view)
 		goto out;
 	}
 	spin_lock_irqsave(&id->lock, flags);
-	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
+	for (i = 0; i < DEBUG_MAX_VIEWS; i++)
 		if (!id->views[i])
 			break;
-	}
 	if (i == DEBUG_MAX_VIEWS) {
 		pr_err("Registering view %s/%s would exceed the maximum "
 		       "number of views %i\n", id->name, view->name, i);
@@ -1148,10 +1139,9 @@ debug_unregister_view(debug_info_t * id, struct debug_view *view)
 	if (!id)
 		goto out;
 	spin_lock_irqsave(&id->lock, flags);
-	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
+	for (i = 0; i < DEBUG_MAX_VIEWS; i++)
 		if (id->views[i] == view)
 			break;
-	}
 	if (i == DEBUG_MAX_VIEWS)
 		rc = -1;
 	else {
@@ -1193,9 +1183,8 @@ debug_get_uint(char *buf)
 
 	buf = skip_spaces(buf);
 	rc = simple_strtoul(buf, &buf, 10);
-	if(*buf){
+	if (*buf)
 		rc = -EINVAL;
-	}
 	return rc;
 }
 
@@ -1265,12 +1254,10 @@ debug_prolog_level_fn(debug_info_t * id, struct debug_view *view, char *out_buf)
 {
 	int rc = 0;
 
-	if(id->level == DEBUG_OFF_LEVEL) {
+	if (id->level == DEBUG_OFF_LEVEL)
 		rc = sprintf(out_buf,"-\n");
-	}
-	else {
+	else
 		rc = sprintf(out_buf, "%i\n", id->level);
-	}
 	return rc;
 }
 
@@ -1336,16 +1323,14 @@ static void debug_flush(debug_info_t* id, int area)
                 memset(id->active_entries, 0, id->nr_areas * sizeof(int));
                 for (i = 0; i < id->nr_areas; i++) {
 			id->active_pages[i] = 0;
-			for(j = 0; j < id->pages_per_area; j++) {
+			for (j = 0; j < id->pages_per_area; j++)
                         	memset(id->areas[i][j], 0, PAGE_SIZE);
-			}
 		}
         } else if(area >= 0 && area < id->nr_areas) {
                 id->active_entries[area] = 0;
 		id->active_pages[area] = 0;
-		for(i = 0; i < id->pages_per_area; i++) {
+		for (i = 0; i < id->pages_per_area; i++)
                 	memset(id->areas[area][i],0,PAGE_SIZE);
-		}
         }
         spin_unlock_irqrestore(&id->lock,flags);
 }
@@ -1430,10 +1415,9 @@ debug_hex_ascii_format_fn(debug_info_t * id, struct debug_view *view,
 {
 	int i, rc = 0;
 
-	for (i = 0; i < id->buf_size; i++) {
+	for (i = 0; i < id->buf_size; i++)
                 rc += sprintf(out_buf + rc, "%02x ",
                               ((unsigned char *) in_buf)[i]);
-        }
 	rc += sprintf(out_buf + rc, "| ");
 	for (i = 0; i < id->buf_size; i++) {
 		unsigned char c = in_buf[i];
-- 
2.9.3
