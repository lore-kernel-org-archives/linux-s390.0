Return-Path: <linux-kernel-owner+w=401wt.eu-S1761506AbYG1SAe@vger.kernel.org>
Message-Id: <20080728175514.161189822@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/15] kmsg: convert s390 debug feature to kmsg api
Content-Disposition: inline; filename=814-kmsg-debug.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/s390dbf |   84 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/debug.c        |   37 +++++++++--------
 2 files changed, 103 insertions(+), 18 deletions(-)

Index: quilt-2.6/arch/s390/kernel/debug.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/debug.c
+++ quilt-2.6/arch/s390/kernel/debug.c
@@ -23,6 +23,9 @@
 #include <linux/debugfs.h>
 
 #include <asm/debug.h>
+#include <asm/kmsg.h>
+
+#define KMSG_COMPONENT "s390dbf"
 
 #define DEBUG_PROLOG_ENTRY -1
 
@@ -693,8 +696,8 @@ debug_info_t *debug_register_mode(const 
 	/* Since debugfs currently does not support uid/gid other than root, */
 	/* we do not allow gid/uid != 0 until we get support for that. */
 	if ((uid != 0) || (gid != 0))
-		printk(KERN_WARNING "debug: Warning - Currently only uid/gid "
-		       "= 0 are supported. Using root as owner now!");
+		kmsg_warn(1, "Root becomes the owner of all s390dbf files "
+			  "in sysfs");
 	if (!initialized)
 		BUG();
 	mutex_lock(&debug_mutex);
@@ -709,7 +712,7 @@ debug_info_t *debug_register_mode(const 
 	debug_register_view(rc, &debug_pages_view);
 out:
         if (!rc){
-		printk(KERN_ERR "debug: debug_register failed for %s\n",name);
+		kmsg_err(2, "Registering debug feature %s failed\n", name);
         }
 	mutex_unlock(&debug_mutex);
 	return rc;
@@ -763,8 +766,8 @@ debug_set_size(debug_info_t* id, int nr_
 	if(pages_per_area > 0){
 		new_areas = debug_areas_alloc(pages_per_area, nr_areas);
 		if(!new_areas) {
-			printk(KERN_WARNING "debug: could not allocate memory "\
-					 "for pagenumber: %i\n",pages_per_area);
+			kmsg_info(6, "Allocating memory for %i pages failed",
+				  pages_per_area);
 			rc = -ENOMEM;
 			goto out;
 		}
@@ -780,8 +783,7 @@ debug_set_size(debug_info_t* id, int nr_
 	memset(id->active_entries,0,sizeof(int)*id->nr_areas);
 	memset(id->active_pages, 0, sizeof(int)*id->nr_areas);
 	spin_unlock_irqrestore(&id->lock,flags);
-	printk(KERN_INFO "debug: %s: set new size (%i pages)\n"\
-			 ,id->name, pages_per_area);
+	kmsg_info(0, "%s: set new size (%i pages)\n" ,id->name, pages_per_area);
 out:
 	return rc;
 }
@@ -800,10 +802,9 @@ debug_set_level(debug_info_t* id, int ne
 	spin_lock_irqsave(&id->lock,flags);
         if(new_level == DEBUG_OFF_LEVEL){
                 id->level = DEBUG_OFF_LEVEL;
-                printk(KERN_INFO "debug: %s: switched off\n",id->name);
+                kmsg_info(0, "%s: switched off\n",id->name);
         } else if ((new_level > DEBUG_MAX_LEVEL) || (new_level < 0)) {
-                printk(KERN_INFO
-                        "debug: %s: level %i is out of range (%i - %i)\n",
+                kmsg_info(0, "%s: level %i is out of range (%i - %i)\n",
                         id->name, new_level, 0, DEBUG_MAX_LEVEL);
         } else {
                 id->level = new_level;
@@ -1108,8 +1109,8 @@ debug_register_view(debug_info_t * id, s
 	pde = debugfs_create_file(view->name, mode, id->debugfs_root_entry,
 				id , &debug_file_ops);
 	if (!pde){
-		printk(KERN_WARNING "debug: debugfs_create_file() failed!"\
-			" Cannot register view %s/%s\n", id->name,view->name);
+		kmsg_err(0, "Registering view %s/%s failed due to out of "
+			 "memory", id->name,view->name);
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
+		kmsg_err(3, "Registering view %s/%s would exceed the maximum "
+			 "number of views %i", id->name, view->name, i);
 		debugfs_remove(pde);
 		rc = -1;
 	} else {
@@ -1303,7 +1302,8 @@ debug_input_level_fn(debug_info_t * id, 
 		new_level = debug_get_uint(str);
 	}
 	if(new_level < 0) {
-		printk(KERN_INFO "debug: level `%s` is not valid\n", str);
+		kmsg_warn(4, "%s is not a valid level for a debug "
+			  "feature\n", str);
 		rc = -EINVAL;
 	} else {
 		debug_set_level(id, new_level);
@@ -1380,7 +1380,8 @@ debug_input_flush_fn(debug_info_t * id, 
                 goto out;
         }
 
-        printk(KERN_INFO "debug: area `%c` is not valid\n", input_buf[0]);
+        kmsg_info(5, "Flushing debug data failed because %c is not a valid "
+		  "area\n", input_buf[0]);
 
 out:
         *offset += user_len;
Index: quilt-2.6/Documentation/s390/kmsg/s390dbf
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/s390dbf
@@ -0,0 +1,84 @@
+/*?
+ * Tag: s390dbf.1
+ * Text: "Root becomes the owner of all s390dbf files in sysfs"
+ * Severity: Warning
+ * Description:
+ * The S/390 debug feature you are using only supports uid/gid = 0.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: s390dbf.2
+ * Text: "Registering debug feature %s failed"
+ * Severity: Error
+ * Parameter:
+ *   @1: feature name
+ * Description:
+ * The initialization of an S/390 debug feature failed. A likely cause of this
+ * problem is memory constraints. The system keeps running, but the debug
+ * data for this feature will not be available in sysfs.
+ * User action:
+ * Consider assigning more memory to your LPAR or z/VM guest virtual machine.
+ */
+
+/*?
+ * Tag: s390dbf.3
+ * Text: "Registering view %s/%s would exceed the maximum number of views %i"
+ * Severity: Error
+ * Parameter:
+ *   @1: feature name
+ *   @2: view name
+ *   @3: maximum
+ * Description:
+ * The maximum number of allowed debug feature views has been reached. The
+ * view has not been registered. The system keeps running but the new view
+ * will not be available in sysfs. This is a program error.
+ * User action:
+ * Report this problem to your support partner.
+ */
+
+/*?
+ * Tag: s390dbf.4
+ * Text: "%s is not a valid level for a debug feature"
+ * Severity: Warning
+ * Parameter:
+ *   @1: level
+ * Description:
+ * Setting a new level for a debug feature by using the 'level' sysfs attribute
+ * failed. Valid levels are the minus sign (-) and the integers in the
+ * range 0 to 6. The minus sign switches off the feature. The numbers switch
+ * the feature on, where higher numbers produce more debug output.
+ * User action:
+ * Write a valid value to the 'level' sysfs attribute.
+ */
+
+/*?
+ * Tag: s390dbf.5
+ * Text: "Flushing debug data failed because %c is not a valid area"
+ * Severity: Warning
+ * Parameter:
+ *   @1: debug area number
+ * Description:
+ * Flushing a debug area by using the 'flush' sysfs attribute failed. Valid
+ * values are the minus sign (-) for flushing all areas, or the number of the
+ * respective area for flushing a single area.
+ * User action:
+ * Write a valid area number or the minus sign (-) to the 'flush' sysfs
+ * attribute.
+ */
+
+/*?
+ * Tag: s390dbf.6
+ * Text: "Allocating memory for %i pages failed"
+ * Severity: Error
+ * Parameter:
+ *   @1: number of pages
+ * Description:
+ * Setting the debug feature size by using the 'page' sysfs attribute failed.
+ * Linux did not have enough memory for expanding the debug feature to the
+ * requested size.
+ * User action:
+ * Use a smaller number of pages for the debug feature or allocate more
+ * memory to your LPAR or z/VM guest virtual machine.
+ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
