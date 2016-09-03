Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 03/17] s390/debug: Add some spaces for better code readability
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <b272281b-84da-40f5-4233-5ae39d80dbd8@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:14:59 +0200
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
Date: Thu, 1 Sep 2016 16:00:39 +0200

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 177 +++++++++++++++++++++++++----------------------
 1 file changed, 93 insertions(+), 84 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index ddfc5e4..5bb9108 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -205,9 +205,9 @@ debug_areas_alloc(int pages_per_area, int nr_areas)
 					 GFP_KERNEL);
 		if (!areas[i])
 			goto fail_malloc_areas2;
-		for(j = 0; j < pages_per_area; j++) {
+		for (j = 0; j < pages_per_area; j++) {
 			areas[i][j] = kzalloc(PAGE_SIZE, GFP_KERNEL);
-			if(!areas[i][j]) {
+			if (!areas[i][j]) {
 				for (j--; j >= 0; j--)
 					kfree(areas[i][j]);
 				kfree(areas[i]);
@@ -218,7 +218,7 @@ debug_areas_alloc(int pages_per_area, int nr_areas)
 	return areas;
 
 fail_malloc_areas2:
-	for(i--; i >= 0; i--){
+	for (i--; i >= 0; i--) {
 		for (j = 0; j < pages_per_area; j++)
 			kfree(areas[i][j]);
 		kfree(areas[i]);
@@ -271,7 +271,7 @@ debug_info_alloc(const char *name, int pages_per_area, int nr_areas,
 	rc->entry_size     = sizeof(debug_entry_t) + buf_size;
 	strlcpy(rc->name, name, sizeof(rc->name));
 	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
-	memset(rc->debugfs_entries, 0 ,DEBUG_MAX_VIEWS *
+	memset(rc->debugfs_entries, 0, DEBUG_MAX_VIEWS *
 		sizeof(struct dentry*));
 	atomic_set(&(rc->ref_count), 0);
 
@@ -297,7 +297,7 @@ debug_areas_free(debug_info_t* db_info)
 {
 	int i,j;
 
-	if(!db_info->areas)
+	if (!db_info->areas)
 		return;
 	for (i = 0; i < db_info->nr_areas; i++) {
 		for (j = 0; j < db_info->pages_per_area; j++)
@@ -334,7 +334,7 @@ debug_info_create(const char *name, int pages_per_area, int nr_areas,
 
         rc = debug_info_alloc(name, pages_per_area, nr_areas, buf_size,
 				DEBUG_DEFAULT_LEVEL, ALL_AREAS);
-        if(!rc) 
+	if (!rc)
 		goto out;
 
 	rc->mode = mode & ~S_IFMT;
@@ -378,10 +378,10 @@ debug_info_copy(debug_info_t* in, int mode)
 		rc = debug_info_alloc(in->name, in->pages_per_area,
 			in->nr_areas, in->buf_size, in->level, mode);
 		spin_lock_irqsave(&in->lock, flags);
-		if(!rc)
+		if (!rc)
 			goto out;
 		/* has something changed in the meantime ? */
-		if((rc->pages_per_area == in->pages_per_area) &&
+		if ((rc->pages_per_area == in->pages_per_area) &&
 		   (rc->nr_areas == in->nr_areas)) {
 			break;
 		}
@@ -394,7 +394,7 @@ debug_info_copy(debug_info_t* in, int mode)
 
 	for (i = 0; i < in->nr_areas; i++)
 		for (j = 0; j < in->pages_per_area; j++)
-			memcpy(rc->areas[i][j], in->areas[i][j],PAGE_SIZE);
+			memcpy(rc->areas[i][j], in->areas[i][j], PAGE_SIZE);
 out:
         spin_unlock_irqrestore(&in->lock, flags);
         return rc;
@@ -431,12 +431,14 @@ debug_info_put(debug_info_t *db_info)
 			debugfs_remove(db_info->debugfs_entries[i]);
 		}
 		debugfs_remove(db_info->debugfs_root_entry);
-		if(db_info == debug_area_first)
+		if (db_info == debug_area_first)
 			debug_area_first = db_info->next;
-		if(db_info == debug_area_last)
+		if (db_info == debug_area_last)
 			debug_area_last = db_info->prev;
-		if(db_info->prev) db_info->prev->next = db_info->next;
-		if(db_info->next) db_info->next->prev = db_info->prev;
+		if (db_info->prev)
+			db_info->prev->next = db_info->next;
+		if (db_info->next)
+			db_info->next->prev = db_info->prev;
 		debug_info_free(db_info);
 	}
 }
@@ -453,10 +455,13 @@ debug_format_entry(file_private_info_t *p_info)
 	struct debug_view *view = p_info->view;
 	debug_entry_t *act_entry;
 	size_t len = 0;
-	if(p_info->act_entry == DEBUG_PROLOG_ENTRY){
+
+	if (p_info->act_entry == DEBUG_PROLOG_ENTRY) {
 		/* print prolog */
         	if (view->prolog_proc)
-                	len += view->prolog_proc(id_snap,view,p_info->temp_buf);
+			len += view->prolog_proc(id_snap,
+						 view,
+						 p_info->temp_buf);
 		goto out;
 	}
 	if (!id_snap->areas) /* this is true, if we have a prolog only view */
@@ -487,25 +492,25 @@ debug_next_entry(file_private_info_t *p_info)
 	debug_info_t *id;
 
 	id = p_info->debug_info_snap;
-	if(p_info->act_entry == DEBUG_PROLOG_ENTRY){
+	if (p_info->act_entry == DEBUG_PROLOG_ENTRY) {
 		p_info->act_entry = 0;
 		p_info->act_page  = 0;
 		goto out;
 	}
-	if(!id->areas)
+	if (!id->areas)
 		return 1;
 	p_info->act_entry += id->entry_size;
 	/* switch to next page, if we reached the end of the page  */
-	if (p_info->act_entry > (PAGE_SIZE - id->entry_size)){
+	if (p_info->act_entry > (PAGE_SIZE - id->entry_size)) {
 		/* next page */
 		p_info->act_entry = 0;
 		p_info->act_page += 1;
-		if((p_info->act_page % id->pages_per_area) == 0) {
+		if ((p_info->act_page % id->pages_per_area) == 0) {
 			/* next area */
         		p_info->act_area++;
 			p_info->act_page=0;
 		}
-        	if(p_info->act_area >= id->nr_areas)
+		if (p_info->act_area >= id->nr_areas)
 			return 1;
 	}
 out:
@@ -531,10 +536,10 @@ debug_output(struct file *file,		/* file descriptor */
 	p_info = ((file_private_info_t *) file->private_data);
 	if (*offset != p_info->offset) 
 		return -EPIPE;
-	if(p_info->act_area >= p_info->debug_info_snap->nr_areas)
+	if (p_info->act_area >= p_info->debug_info_snap->nr_areas)
 		return 0;
 	entry_offset = p_info->act_entry_offset;
-	while(count < len){
+	while (count < len) {
 		int formatted_line_size;
 		int formatted_line_residue;
 		int user_buf_residue;
@@ -544,16 +549,16 @@ debug_output(struct file *file,		/* file descriptor */
 		formatted_line_residue = formatted_line_size - entry_offset;
 		user_buf_residue = len-count;
 		copy_size = min(user_buf_residue, formatted_line_residue);
-		if(copy_size){
+		if (copy_size) {
 			if (copy_to_user(user_buf + count, p_info->temp_buf
 					+ entry_offset, copy_size))
 				return -EFAULT;
 			count += copy_size;
 			entry_offset += copy_size;
 		}
-		if(copy_size == formatted_line_residue){
+		if (copy_size == formatted_line_residue) {
 			entry_offset = 0;
-			if(debug_next_entry(p_info))
+			if (debug_next_entry(p_info))
 				goto out;
 		}
 	}
@@ -624,20 +629,20 @@ found:
 	/* To copy all the areas is only needed, if we have a view which  */
 	/* formats the debug areas. */
 
-	if(!debug_info->views[i]->format_proc &&
-		!debug_info->views[i]->header_proc){
+	if (!debug_info->views[i]->format_proc &&
+		!debug_info->views[i]->header_proc) {
 		debug_info_snapshot = debug_info_copy(debug_info, NO_AREAS);
 	} else {
 		debug_info_snapshot = debug_info_copy(debug_info, ALL_AREAS);
 	}
 
-	if(!debug_info_snapshot){
+	if (!debug_info_snapshot) {
 		rc = -ENOMEM;
 		goto out;
 	}
 	p_info = kmalloc(sizeof(file_private_info_t),
 						GFP_KERNEL);
-	if(!p_info){
+	if (!p_info) {
 		debug_info_free(debug_info_snapshot);
 		rc = -ENOMEM;
 		goto out;
@@ -669,7 +674,7 @@ debug_close(struct inode *inode, struct file *file)
 {
 	file_private_info_t *p_info;
 	p_info = (file_private_info_t *) file->private_data;
-	if(p_info->debug_info_snap)
+	if (p_info->debug_info_snap)
 		debug_info_free(p_info->debug_info_snap);
 	debug_info_put(p_info->debug_info_org);
 	kfree(file->private_data);
@@ -699,7 +704,7 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
         /* create new debug_info */
 
 	rc = debug_info_create(name, pages_per_area, nr_areas, buf_size, mode);
-	if(!rc) 
+	if (!rc)
 		goto out;
 	debug_register_view(rc, &debug_level_view);
         debug_register_view(rc, &debug_flush_view);
@@ -754,11 +759,11 @@ debug_set_size(debug_info_t* id, int nr_areas, int pages_per_area)
 {
 	unsigned long flags;
 	debug_entry_t *** new_areas;
-	int rc=0;
+	int rc = 0;
 
-	if(!id || (nr_areas <= 0) || (pages_per_area < 0))
+	if (!id || (nr_areas <= 0) || (pages_per_area < 0))
 		return -EINVAL;
-	if(pages_per_area > 0){
+	if (pages_per_area > 0) {
 		new_areas = debug_areas_alloc(pages_per_area, nr_areas);
 		if(!new_areas) {
 			pr_info("Allocating memory for %i pages failed\n",
@@ -769,16 +774,16 @@ debug_set_size(debug_info_t* id, int nr_areas, int pages_per_area)
 	} else {
 		new_areas = NULL;
 	}
-	spin_lock_irqsave(&id->lock,flags);
+	spin_lock_irqsave(&id->lock, flags);
 	debug_areas_free(id);
 	id->areas = new_areas;
 	id->nr_areas = nr_areas;
 	id->pages_per_area = pages_per_area;
 	id->active_area = 0;
-	memset(id->active_entries,0,sizeof(int)*id->nr_areas);
-	memset(id->active_pages, 0, sizeof(int)*id->nr_areas);
-	spin_unlock_irqrestore(&id->lock,flags);
-	pr_info("%s: set new size (%i pages)\n" ,id->name, pages_per_area);
+	memset(id->active_entries, 0, sizeof(int) * id->nr_areas);
+	memset(id->active_pages, 0, sizeof(int) * id->nr_areas);
+	spin_unlock_irqrestore(&id->lock, flags);
+	pr_info("%s: set new size (%i pages)\n", id->name, pages_per_area);
 out:
 	return rc;
 }
@@ -794,17 +799,17 @@ debug_set_level(debug_info_t* id, int new_level)
 	unsigned long flags;
 	if(!id)
 		return;	
-	spin_lock_irqsave(&id->lock,flags);
-        if(new_level == DEBUG_OFF_LEVEL){
+	spin_lock_irqsave(&id->lock, flags);
+	if (new_level == DEBUG_OFF_LEVEL) {
                 id->level = DEBUG_OFF_LEVEL;
-		pr_info("%s: switched off\n",id->name);
+		pr_info("%s: switched off\n", id->name);
         } else if ((new_level > DEBUG_MAX_LEVEL) || (new_level < 0)) {
 		pr_info("%s: level %i is out of range (%i - %i)\n",
                         id->name, new_level, 0, DEBUG_MAX_LEVEL);
         } else {
                 id->level = new_level;
         }
-	spin_unlock_irqrestore(&id->lock,flags);
+	spin_unlock_irqrestore(&id->lock, flags);
 }
 EXPORT_SYMBOL(debug_set_level);
 
@@ -996,10 +1001,10 @@ EXPORT_SYMBOL(debug_exception_common);
 static inline int
 debug_count_numargs(char *string)
 {
-	int numargs=0;
+	int numargs = 0;
 
 	while (*string)
-		if(*string++=='%')
+		if (*string++ == '%')
 			numargs++;
 	return(numargs);
 }
@@ -1019,7 +1024,7 @@ __debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
 
 	if (!debug_active || !id->areas)
 		return NULL;
-	numargs=debug_count_numargs(string);
+	numargs = debug_count_numargs(string);
 
 	if (debug_critical) {
 		if (!spin_trylock_irqsave(&id->lock, flags))
@@ -1027,11 +1032,13 @@ __debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
 	} else
 		spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
-	curr_event=(debug_sprintf_entry_t *) DEBUG_DATA(active);
+	curr_event = (debug_sprintf_entry_t *) DEBUG_DATA(active);
 	va_start(ap,string);
-	curr_event->string=string;
-	for(idx=0;idx<min(numargs,(int)(id->buf_size / sizeof(long))-1);idx++)
-		curr_event->args[idx]=va_arg(ap,long);
+	curr_event->string = string;
+	for (idx = 0;
+	     idx < min(numargs, (int)(id->buf_size / sizeof(long)) - 1);
+	     idx++)
+		curr_event->args[idx] = va_arg(ap, long);
 	va_end(ap);
 	debug_finish_entry(id, active, level, 0);
 	spin_unlock_irqrestore(&id->lock, flags);
@@ -1056,7 +1063,7 @@ __debug_sprintf_exception(debug_info_t *id, int level, char *string, ...)
 	if (!debug_active || !id->areas)
 		return NULL;
 
-	numargs=debug_count_numargs(string);
+	numargs = debug_count_numargs(string);
 
 	if (debug_critical) {
 		if (!spin_trylock_irqsave(&id->lock, flags))
@@ -1064,11 +1071,13 @@ __debug_sprintf_exception(debug_info_t *id, int level, char *string, ...)
 	} else
 		spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
-	curr_event=(debug_sprintf_entry_t *)DEBUG_DATA(active);
-	va_start(ap,string);
-	curr_event->string=string;
-	for(idx=0;idx<min(numargs,(int)(id->buf_size / sizeof(long))-1);idx++)
-		curr_event->args[idx]=va_arg(ap,long);
+	curr_event = (debug_sprintf_entry_t *) DEBUG_DATA(active);
+	va_start(ap, string);
+	curr_event->string = string;
+	for (idx = 0;
+	     idx < min(numargs, (int)(id->buf_size / sizeof(long)) - 1);
+	     idx++)
+		curr_event->args[idx] = va_arg(ap, long);
 	va_end(ap);
 	debug_finish_entry(id, active, level, 1);
 	spin_unlock_irqrestore(&id->lock, flags);
@@ -1214,26 +1223,26 @@ debug_input_pages_fn(debug_info_t * id, struct debug_view *view,
 			size_t user_len, loff_t * offset)
 {
 	char *str;
-	int rc,new_pages;
+	int rc, new_pages;
 
 	if (user_len > 0x10000)
                 user_len = 0x10000;
-	if (*offset != 0){
+	if (*offset != 0) {
 		rc = -EPIPE;
 		goto out;
 	}
-	str = debug_get_user_string(user_buf,user_len);
-	if(IS_ERR(str)){
+	str = debug_get_user_string(user_buf, user_len);
+	if (IS_ERR(str)) {
 		rc = PTR_ERR(str);
 		goto out;
 	}
 	new_pages = debug_get_uint(str);
-	if(new_pages < 0){
+	if (new_pages < 0) {
 		rc = -EINVAL;
 		goto free_str;
 	}
-	rc = debug_set_size(id,id->nr_areas, new_pages);
-	if(rc != 0){
+	rc = debug_set_size(id, id->nr_areas, new_pages);
+	if (rc != 0) {
 		rc = -EINVAL;
 		goto free_str;
 	}
@@ -1271,27 +1280,27 @@ debug_input_level_fn(debug_info_t * id, struct debug_view *view,
 			size_t user_len, loff_t * offset)
 {
 	char *str;
-	int rc,new_level;
+	int rc, new_level;
 
 	if (user_len > 0x10000)
                 user_len = 0x10000;
-	if (*offset != 0){
+	if (*offset != 0) {
 		rc = -EPIPE;
 		goto out;
 	}
-	str = debug_get_user_string(user_buf,user_len);
-	if(IS_ERR(str)){
+	str = debug_get_user_string(user_buf, user_len);
+	if (IS_ERR(str)) {
 		rc = PTR_ERR(str);
 		goto out;
 	}
-	if(str[0] == '-'){
+	if (str[0] == '-') {
 		debug_set_level(id, DEBUG_OFF_LEVEL);
 		rc = user_len;
 		goto free_str;
 	} else {
 		new_level = debug_get_uint(str);
 	}
-	if(new_level < 0) {
+	if (new_level < 0) {
 		pr_warn("%s is not a valid level for a debug feature\n", str);
 		rc = -EINVAL;
 	} else {
@@ -1313,12 +1322,12 @@ out:
 static void debug_flush(debug_info_t* id, int area)
 {
         unsigned long flags;
-        int i,j;
+	int i, j;
 
-        if(!id || !id->areas)
+	if (!id || !id->areas)
                 return;
-        spin_lock_irqsave(&id->lock,flags);
-        if(area == DEBUG_FLUSH_ALL){
+	spin_lock_irqsave(&id->lock, flags);
+	if (area == DEBUG_FLUSH_ALL) {
                 id->active_area = 0;
                 memset(id->active_entries, 0, id->nr_areas * sizeof(int));
                 for (i = 0; i < id->nr_areas; i++) {
@@ -1326,13 +1335,13 @@ static void debug_flush(debug_info_t* id, int area)
 			for (j = 0; j < id->pages_per_area; j++)
                         	memset(id->areas[i][j], 0, PAGE_SIZE);
 		}
-        } else if(area >= 0 && area < id->nr_areas) {
+	} else if (area >= 0 && area < id->nr_areas) {
                 id->active_entries[area] = 0;
 		id->active_pages[area] = 0;
 		for (i = 0; i < id->pages_per_area; i++)
-                	memset(id->areas[area][i],0,PAGE_SIZE);
+			memset(id->areas[area][i], 0, PAGE_SIZE);
         }
-        spin_unlock_irqrestore(&id->lock,flags);
+	spin_unlock_irqrestore(&id->lock, flags);
 }
 
 /*
@@ -1349,15 +1358,15 @@ debug_input_flush_fn(debug_info_t * id, struct debug_view *view,
 
 	if (user_len > 0x10000)
                 user_len = 0x10000;
-        if (*offset != 0){
+	if (*offset != 0) {
 		rc = -EPIPE;
                 goto out;
 	}
-        if (copy_from_user(input_buf, user_buf, 1)){
+	if (copy_from_user(input_buf, user_buf, 1)) {
                 rc = -EFAULT;
                 goto out;
         }
-        if(input_buf[0] == '-') { 
+	if (input_buf[0] == '-') {
                 debug_flush(id, DEBUG_FLUSH_ALL);
                 goto out;
         }
@@ -1386,7 +1395,7 @@ debug_raw_header_fn(debug_info_t * id, struct debug_view *view,
         int rc;
 
 	rc = sizeof(debug_entry_t);
-	memcpy(out_buf,entry,sizeof(debug_entry_t));
+	memcpy(out_buf, entry, sizeof(debug_entry_t));
         return rc;
 }
 
@@ -1477,9 +1486,9 @@ debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
 	/* count of longs fit into one entry */
 	num_longs = id->buf_size /  sizeof(long); 
 
-	if(num_longs < 1)
+	if (num_longs < 1)
 		goto out; /* bufsize of entry too small */
-	if(num_longs == 1) {
+	if (num_longs == 1) {
 		/* no args, we use only the string */
 		strcpy(out_buf, curr_event->string);
 		rc = strlen(curr_event->string);
@@ -1489,9 +1498,9 @@ debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
 	/* number of arguments used for sprintf (without the format string) */
 	num_used_args   = min(DEBUG_SPRINTF_MAX_ARGS, (num_longs - 1));
 
-	memset(index,0, DEBUG_SPRINTF_MAX_ARGS * sizeof(int));
+	memset(index, 0, DEBUG_SPRINTF_MAX_ARGS * sizeof(int));
 
-	for(i = 0; i < num_used_args; i++)
+	for (i = 0; i < num_used_args; i++)
 		index[i] = i;
 
 	rc =  sprintf(out_buf, curr_event->string, curr_event->args[index[0]],
-- 
2.9.3
