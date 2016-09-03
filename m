Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 11/17] s390/debug: Fix indentation in 13 functions
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <b81d1973-1e2e-cbfc-6801-8694623d8078@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:28:24 +0200
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
Date: Thu, 1 Sep 2016 23:05:51 +0200

The script "checkpatch.pl" can point the following information out.

ERROR: code indent should use tabs where possible

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 118 +++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index ef0db06..4a12faf 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -330,7 +330,7 @@ debug_info_create(const char *name, int pages_per_area, int nr_areas,
 {
 	debug_info_t* rc;
 
-        rc = debug_info_alloc(name, pages_per_area, nr_areas, buf_size,
+	rc = debug_info_alloc(name, pages_per_area, nr_areas, buf_size,
 				DEBUG_DEFAULT_LEVEL, ALL_AREAS);
 	if (!rc)
 		goto out;
@@ -338,21 +338,21 @@ debug_info_create(const char *name, int pages_per_area, int nr_areas,
 	rc->mode = mode & ~S_IFMT;
 
 	/* create root directory */
-        rc->debugfs_root_entry = debugfs_create_dir(rc->name,
+	rc->debugfs_root_entry = debugfs_create_dir(rc->name,
 					debug_debugfs_root_entry);
 
 	/* append new element to linked list */
-        if (!debug_area_first) {
-                /* first element in list */
-                debug_area_first = rc;
-                rc->prev = NULL;
-        } else {
-                /* append element to end of list */
-                debug_area_last->next = rc;
-                rc->prev = debug_area_last;
-        }
-        debug_area_last = rc;
-        rc->next = NULL;
+	if (!debug_area_first) {
+		/* first element in list */
+		debug_area_first = rc;
+		rc->prev = NULL;
+	} else {
+		/* append element to end of list */
+		debug_area_last->next = rc;
+		rc->prev = debug_area_last;
+	}
+	debug_area_last = rc;
+	rc->next = NULL;
 
 	debug_info_get(rc);
 out:
@@ -394,8 +394,8 @@ debug_info_copy(debug_info_t* in, int mode)
 		for (j = 0; j < in->pages_per_area; j++)
 			memcpy(rc->areas[i][j], in->areas[i][j], PAGE_SIZE);
  unlock:
-        spin_unlock_irqrestore(&in->lock, flags);
-        return rc;
+	spin_unlock_irqrestore(&in->lock, flags);
+	return rc;
 }
 
 /*
@@ -456,7 +456,7 @@ debug_format_entry(file_private_info_t *p_info)
 
 	if (p_info->act_entry == DEBUG_PROLOG_ENTRY) {
 		/* print prolog */
-        	if (view->prolog_proc)
+		if (view->prolog_proc)
 			len += view->prolog_proc(id_snap,
 						 view,
 						 p_info->temp_buf);
@@ -476,7 +476,7 @@ debug_format_entry(file_private_info_t *p_info)
 		len += view->format_proc(id_snap, view, p_info->temp_buf + len,
 						DEBUG_DATA(act_entry));
 out:
-        return len;
+	return len;
 }
 
 /*
@@ -505,7 +505,7 @@ debug_next_entry(file_private_info_t *p_info)
 		p_info->act_page += 1;
 		if ((p_info->act_page % id->pages_per_area) == 0) {
 			/* next area */
-        		p_info->act_area++;
+			p_info->act_area++;
 			p_info->act_page=0;
 		}
 		if (p_info->act_area >= id->nr_areas)
@@ -697,15 +697,14 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
 	BUG_ON(!initialized);
 	mutex_lock(&debug_mutex);
 
-        /* create new debug_info */
-
+	/* create new debug_info */
 	rc = debug_info_create(name, pages_per_area, nr_areas, buf_size, mode);
 	if (!rc) {
 		pr_err("Registering debug feature %s failed\n", name);
 		goto unlock;
 	}
 	debug_register_view(rc, &debug_level_view);
-        debug_register_view(rc, &debug_flush_view);
+	debug_register_view(rc, &debug_flush_view);
 	debug_register_view(rc, &debug_pages_view);
  unlock:
 	mutex_unlock(&debug_mutex);
@@ -794,14 +793,14 @@ debug_set_level(debug_info_t* id, int new_level)
 		return;	
 	spin_lock_irqsave(&id->lock, flags);
 	if (new_level == DEBUG_OFF_LEVEL) {
-                id->level = DEBUG_OFF_LEVEL;
+		id->level = DEBUG_OFF_LEVEL;
 		pr_info("%s: switched off\n", id->name);
-        } else if ((new_level > DEBUG_MAX_LEVEL) || (new_level < 0)) {
+	} else if ((new_level > DEBUG_MAX_LEVEL) || (new_level < 0)) {
 		pr_info("%s: level %i is out of range (%i - %i)\n",
-                        id->name, new_level, 0, DEBUG_MAX_LEVEL);
-        } else {
-                id->level = new_level;
-        }
+			id->name, new_level, 0, DEBUG_MAX_LEVEL);
+	} else {
+		id->level = new_level;
+	}
 	spin_unlock_irqrestore(&id->lock, flags);
 }
 EXPORT_SYMBOL(debug_set_level);
@@ -1175,7 +1174,7 @@ debug_get_user_string(const char __user *user_buf, size_t user_len)
 		buffer[user_len - 1] = 0;
 	else
 		buffer[user_len] = 0;
-        return buffer;
+	return buffer;
 }
 
 static inline int
@@ -1219,7 +1218,7 @@ debug_input_pages_fn(debug_info_t * id, struct debug_view *view,
 	int rc, new_pages;
 
 	if (user_len > 0x10000)
-                user_len = 0x10000;
+		user_len = 0x10000;
 	if (*offset != 0) {
 		rc = -EPIPE;
 		goto out;
@@ -1276,7 +1275,7 @@ debug_input_level_fn(debug_info_t * id, struct debug_view *view,
 	int rc, new_level;
 
 	if (user_len > 0x10000)
-                user_len = 0x10000;
+		user_len = 0x10000;
 	if (*offset != 0) {
 		rc = -EPIPE;
 		goto out;
@@ -1314,26 +1313,26 @@ out:
  
 static void debug_flush(debug_info_t* id, int area)
 {
-        unsigned long flags;
+	unsigned long flags;
 	int i, j;
 
 	if (!id || !id->areas)
-                return;
+		return;
 	spin_lock_irqsave(&id->lock, flags);
 	if (area == DEBUG_FLUSH_ALL) {
-                id->active_area = 0;
-                memset(id->active_entries, 0, id->nr_areas * sizeof(int));
-                for (i = 0; i < id->nr_areas; i++) {
+		id->active_area = 0;
+		memset(id->active_entries, 0, id->nr_areas * sizeof(int));
+		for (i = 0; i < id->nr_areas; i++) {
 			id->active_pages[i] = 0;
 			for (j = 0; j < id->pages_per_area; j++)
-                        	memset(id->areas[i][j], 0, PAGE_SIZE);
+				memset(id->areas[i][j], 0, PAGE_SIZE);
 		}
 	} else if (area >= 0 && area < id->nr_areas) {
-                id->active_entries[area] = 0;
+		id->active_entries[area] = 0;
 		id->active_pages[area] = 0;
 		for (i = 0; i < id->pages_per_area; i++)
 			memset(id->areas[area][i], 0, PAGE_SIZE);
-        }
+	}
 	spin_unlock_irqrestore(&id->lock, flags);
 }
 
@@ -1346,35 +1345,36 @@ debug_input_flush_fn(debug_info_t * id, struct debug_view *view,
 			struct file *file, const char __user *user_buf,
 			size_t user_len, loff_t * offset)
 {
-        char input_buf[1];
-        int rc = user_len;
+	char input_buf[1];
+	int rc = user_len;
 
 	if (user_len > 0x10000)
-                user_len = 0x10000;
+		user_len = 0x10000;
 	if (*offset != 0) {
 		rc = -EPIPE;
-                goto out;
+		goto out;
 	}
 	if (copy_from_user(input_buf, user_buf, 1)) {
-                rc = -EFAULT;
-                goto out;
-        }
+		rc = -EFAULT;
+		goto out;
+	}
 	if (input_buf[0] == '-') {
-                debug_flush(id, DEBUG_FLUSH_ALL);
-                goto out;
-        }
-        if (isdigit(input_buf[0])) {
-                int area = ((int) input_buf[0] - (int) '0');
-                debug_flush(id, area);
-                goto out;
-        }
+		debug_flush(id, DEBUG_FLUSH_ALL);
+		goto out;
+	}
+	if (isdigit(input_buf[0])) {
+		int area = ((int) input_buf[0] - (int) '0');
+
+		debug_flush(id, area);
+		goto out;
+	}
 
 	pr_info("Flushing debug data failed because %c is not a valid "
 		 "area\n", input_buf[0]);
 
 out:
-        *offset += user_len;
-        return rc;              /* number of input characters */
+	*offset += user_len;
+	return rc;              /* number of input characters */
 }
 
 /*
@@ -1385,11 +1385,11 @@ static int
 debug_raw_header_fn(debug_info_t * id, struct debug_view *view,
 			int area, debug_entry_t * entry, char *out_buf)
 {
-        int rc;
+	int rc;
 
 	rc = sizeof(debug_entry_t);
 	memcpy(out_buf, entry, sizeof(debug_entry_t));
-        return rc;
+	return rc;
 }
 
 /*
@@ -1418,8 +1418,8 @@ debug_hex_ascii_format_fn(debug_info_t * id, struct debug_view *view,
 	int i, rc = 0;
 
 	for (i = 0; i < id->buf_size; i++)
-                rc += sprintf(out_buf + rc, "%02x ",
-                              ((unsigned char *) in_buf)[i]);
+		rc += sprintf(out_buf + rc, "%02x ",
+			      ((unsigned char *) in_buf)[i]);
 	rc += sprintf(out_buf + rc, "| ");
 	for (i = 0; i < id->buf_size; i++) {
 		unsigned char c = in_buf[i];
-- 
2.9.3
