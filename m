Return-Path: <linux-kernel-owner+w=401wt.eu-S1758679AbYFYOi2@vger.kernel.org>
Message-Id: <20080625143615.246159609@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/21] Cleanup s390 debug feature print messages.
Content-Disposition: inline; filename=814-printk-debug.diff
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

 arch/s390/kernel/debug.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: quilt-2.6/arch/s390/kernel/debug.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/debug.c
+++ quilt-2.6/arch/s390/kernel/debug.c
@@ -1079,7 +1079,6 @@ __init debug_init(void)
 	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table);
 	mutex_lock(&debug_mutex);
 	debug_debugfs_root_entry = debugfs_create_dir(DEBUG_DIR_ROOT,NULL);
-	printk(KERN_INFO "debug: Initialization complete\n");
 	initialized = 1;
 	mutex_unlock(&debug_mutex);
 
@@ -1193,7 +1192,6 @@ debug_get_uint(char *buf)
 	for(; isspace(*buf); buf++);
 	rc = simple_strtoul(buf, &buf, 10);
 	if(*buf){
-		printk("debug: no integer specified!\n");
 		rc = -EINVAL;
 	}
 	return rc;
@@ -1340,19 +1338,12 @@ static void debug_flush(debug_info_t* id
                         	memset(id->areas[i][j], 0, PAGE_SIZE);
 			}
 		}
-                printk(KERN_INFO "debug: %s: all areas flushed\n",id->name);
         } else if(area >= 0 && area < id->nr_areas) {
                 id->active_entries[area] = 0;
 		id->active_pages[area] = 0;
 		for(i = 0; i < id->pages_per_area; i++) {
                 	memset(id->areas[area][i],0,PAGE_SIZE);
 		}
-                printk(KERN_INFO "debug: %s: area %i has been flushed\n",
-                        id->name, area);
-        } else {
-                printk(KERN_INFO
-                      "debug: %s: area %i cannot be flushed (range: %i - %i)\n",
-                        id->name, area, 0, id->nr_areas-1);
         }
         spin_unlock_irqrestore(&id->lock,flags);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
