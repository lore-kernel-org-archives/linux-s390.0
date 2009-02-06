Return-Path: <linux-kernel-owner+w=401wt.eu-S1757707AbZBFOXj@vger.kernel.org>
Message-ID: <498C47D4.1010305@in.ibm.com>
Date: Fri, 06 Feb 2009 19:53:16 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: [Patch] Remove remaining ref to proc_dir_entry::owner
References: <498C03E1.1040204@in.ibm.com> <20090207000636.ee67c759.sfr@canb.auug.org.au>
In-Reply-To: <20090207000636.ee67c759.sfr@canb.auug.org.au>
Content-Type: multipart/mixed;
 boundary="------------000109000202070209030003"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Mel Gorman <mel@csn.ul.ie>, Alexey Dobriyan <adobriyan@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000109000202070209030003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Stephen.

Here is a patch to fix this issue.

* Remove remaining references to struct proc_dir_entry::owner

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Cc : Alexey Dobriyan <adobriyan@gmail.com>
---

Thanks
-Sachin



--------------000109000202070209030003
Content-Type: text/x-patch;
 name="remove-remaining-proc-dir-entry-owner-refs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-remaining-proc-dir-entry-owner-refs.patch"

* Remove remaining references to struct proc_dir_entry::owner

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Cc : Alexey Dobriyan <adobriyan@gmail.com>
---

diff -Naurp a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
--- a/drivers/s390/block/dasd_proc.c	2009-02-06 21:58:57.000000000 +0530
+++ b/drivers/s390/block/dasd_proc.c	2009-02-06 22:01:48.000000000 +0530
@@ -318,7 +318,6 @@ dasd_proc_init(void)
 	dasd_proc_root_entry = proc_mkdir("dasd", NULL);
 	if (!dasd_proc_root_entry)
 		goto out_nodasd;
-	dasd_proc_root_entry->owner = THIS_MODULE;
 	dasd_devices_entry = proc_create("devices",
 					 S_IFREG | S_IRUGO | S_IWUSR,
 					 dasd_proc_root_entry,
@@ -332,7 +331,6 @@ dasd_proc_init(void)
 		goto out_nostatistics;
 	dasd_statistics_entry->read_proc = dasd_statistics_read;
 	dasd_statistics_entry->write_proc = dasd_statistics_write;
-	dasd_statistics_entry->owner = THIS_MODULE;
 	return 0;
 
  out_nostatistics:

--------------000109000202070209030003--
