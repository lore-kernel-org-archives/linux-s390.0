Return-Path: <linux-kernel-owner+w=401wt.eu-S1755933AbYK0KwA@vger.kernel.org>
Message-Id: <20081127103140.978646491@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:07 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 47/60] convert s390 debug feature printks to pr_xxx macros.
Content-Disposition: inline; filename=162-kmsg-debug.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/debug.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

Index: quilt-2.6/arch/s390/kernel/debug.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/debug.c
+++ quilt-2.6/arch/s390/kernel/debug.c
@@ -10,6 +10,9 @@
  *    Bugreports to: <Linux390@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "s390dbf"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -693,8 +696,8 @@ debug_info_t *debug_register_mode(const 
 	/* Since debugfs currently does not support uid/gid other than root, */
 	/* we do not allow gid/uid != 0 until we get support for that. */
 	if ((uid != 0) || (gid != 0))
-		printk(KERN_WARNING "debug: Warning - Currently only uid/gid "
-		       "= 0 are supported. Using root as owner now!");
+		pr_warning("Root becomes the owner of all s390dbf files "
+			   "in sysfs\n");
 	if (!initialized)
 		BUG();
 	mutex_lock(&debug_mutex);
@@ -709,7 +712,7 @@ debug_info_t *debug_register_mode(const 
 	debug_register_view(rc, &debug_pages_view);
 out:
         if (!rc){
-		printk(KERN_ERR "debug: debug_register failed for %s\n",name);
+		pr_err("Registering debug feature %s failed\n", name);
         }
 	mutex_unlock(&debug_mutex);
 	return rc;
@@ -763,8 +766,8 @@ debug_set_size(debug_info_t* id, int nr_
 	if(pages_per_area > 0){
 		new_areas = debug_areas_alloc(pages_per_area, nr_areas);
 		if(!new_areas) {
-			printk(KERN_WARNING "debug: could not allocate memory "\
-					 "for pagenumber: %i\n",pages_per_area);
+			pr_info("Allocating memory for %i pages failed\n",
+				pages_per_area);
 			rc = -ENOMEM;
 			goto out;
 		}
@@ -780,8 +783,7 @@ debug_set_size(debug_info_t* id, int nr_
 	memset(id->active_entries,0,sizeof(int)*id->nr_areas);
 	memset(id->active_pages, 0, sizeof(int)*id->nr_areas);
 	spin_unlock_irqrestore(&id->lock,flags);
-	printk(KERN_INFO "debug: %s: set new size (%i pages)\n"\
-			 ,id->name, pages_per_area);
+	pr_info("%s: set new size (%i pages)\n" ,id->name, pages_per_area);
 out:
 	return rc;
 }
@@ -800,10 +802,9 @@ debug_set_level(debug_info_t* id, int ne
 	spin_lock_irqsave(&id->lock,flags);
         if(new_level == DEBUG_OFF_LEVEL){
                 id->level = DEBUG_OFF_LEVEL;
-                printk(KERN_INFO "debug: %s: switched off\n",id->name);
+		pr_info("%s: switched off\n",id->name);
         } else if ((new_level > DEBUG_MAX_LEVEL) || (new_level < 0)) {
-                printk(KERN_INFO
-                        "debug: %s: level %i is out of range (%i - %i)\n",
+		pr_info("%s: level %i is out of range (%i - %i)\n",
                         id->name, new_level, 0, DEBUG_MAX_LEVEL);
         } else {
                 id->level = new_level;
@@ -1108,8 +1109,8 @@ debug_register_view(debug_info_t * id, s
 	pde = debugfs_create_file(view->name, mode, id->debugfs_root_entry,
 				id , &debug_file_ops);
 	if (!pde){
-		printk(KERN_WARNING "debug: debugfs_create_file() failed!"\
-			" Cannot register view %s/%s\n", id->name,view->name);
+		pr_err("Registering view %s/%s failed due to out of "
+		       "memory\n", id->name,view->name);
 		rc = -1;
 		goto out;
 	}
@@ -1119,10 +1120,8 @@ debug_register_view(debug_info_t * id, s
 			break;
 	}
 	if (i == DEBUG_MAX_VIEWS) {
-		printk(KERN_WARNING "debug: cannot register view %s/%s\n",
-			id->name,view->name);
-		printk(KERN_WARNING 
-			"debug: maximum number of views reached (%i)!\n", i);
+		pr_err("Registering view %s/%s would exceed the maximum "
+		       "number of views %i\n", id->name, view->name, i);
 		debugfs_remove(pde);
 		rc = -1;
 	} else {
@@ -1303,7 +1302,8 @@ debug_input_level_fn(debug_info_t * id, 
 		new_level = debug_get_uint(str);
 	}
 	if(new_level < 0) {
-		printk(KERN_INFO "debug: level `%s` is not valid\n", str);
+		pr_warning("%s is not a valid level for a debug "
+			   "feature\n", str);
 		rc = -EINVAL;
 	} else {
 		debug_set_level(id, new_level);
@@ -1380,7 +1380,8 @@ debug_input_flush_fn(debug_info_t * id, 
                 goto out;
         }
 
-        printk(KERN_INFO "debug: area `%c` is not valid\n", input_buf[0]);
+	pr_info("Flushing debug data failed because %c is not a valid "
+		 "area\n", input_buf[0]);
 
 out:
         *offset += user_len;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
