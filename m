Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44484 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBTd0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 15:33:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so16236925qkk.11
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 12:33:24 -0700 (PDT)
Message-ID: <1570044801.5576.262.camel@lca.pw>
Subject: memory leaks in dasd_eckd_check_characteristics() error paths
From: Qian Cai <cai@lca.pw>
Date: Wed, 02 Oct 2019 15:33:21 -0400
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
dasd_generic_set_online() emits this message,

dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12

After that, there are several memory leaks below. There are "config_data" and
then stored as,

/* store per path conf_data */
device->path[pos].conf_data = conf_data;

When it processes the error path in  dasd_generic_set_online(), it calls
dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
the device->path[].conf_data first. Is it safe to free those in
dasd_free_device() without worrying about the double-free? Or, is it better to
free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
out_err*?

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
  */
 void dasd_free_device(struct dasd_device *device)
 {
+       for (int i = 0; i < 8; i++)
+               kfree(device->path[i].conf_data);
+
        kfree(device->private);
        free_pages((unsigned long) device->ese_mem, 1);
        free_page((unsigned long) device->erp_mem);


unreferenced object 0x0fcee900 (size 256):
  comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
  hex dump (first 32 bytes):
    dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
    f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
  backtrace:
    [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
    [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
    [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
[dasd_eckd_mod]
    [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
    [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
    [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
    [<00000000349a5446>] online_store+0x2ce/0x420
    [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
    [<0000000005664197>] vfs_write+0xce/0x220
    [<0000000044a8bccb>] ksys_write+0xea/0x190
    [<0000000037335938>] system_call+0x296/0x2b4
