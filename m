Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730142AbfJPN3y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 09:29:54 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9GDSUR4011649
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 09:29:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vng3ubfb4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 09:29:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Wed, 16 Oct 2019 14:29:48 +0100
References: <1570044801.5576.262.camel@lca.pw>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
Date: Wed, 16 Oct 2019 15:29:41 +0200
MIME-Version: 1.0
In-Reply-To: <1570044801.5576.262.camel@lca.pw>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

thanks for reporting this.

On 02.10.19 21:33, Qian Cai wrote:
> For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
> dasd_generic_set_online() emits this message,
>
> dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
>
> After that, there are several memory leaks below. There are "config_data" and
> then stored as,
>
> /* store per path conf_data */
> device->path[pos].conf_data = conf_data;
>
> When it processes the error path in  dasd_generic_set_online(), it calls
> dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
> the device->path[].conf_data first. 

Usually dasd_delete_device() calls dasd_generic_free_discipline() which
takes care of
the device->path[].conf_data in dasd_eckd_uncheck_device().
From a first look this looks sane.

So I need to spend a closer look if this does not happen correctly here.

> Is it safe to free those in
> dasd_free_device() without worrying about the double-free? Or, is it better to
> free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
> out_err*?
>
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
>   */
>  void dasd_free_device(struct dasd_device *device)
>  {
> +       for (int i = 0; i < 8; i++)
> +               kfree(device->path[i].conf_data);
> +
>         kfree(device->private);
>         free_pages((unsigned long) device->ese_mem, 1);
>         free_page((unsigned long) device->erp_mem);
>
>
> unreferenced object 0x0fcee900 (size 256):
>   comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
>   hex dump (first 32 bytes):
>     dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
>     f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
>   backtrace:
>     [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
>     [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
>     [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
> [dasd_eckd_mod]
>     [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
>     [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
>     [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
>     [<00000000349a5446>] online_store+0x2ce/0x420
>     [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
>     [<0000000005664197>] vfs_write+0xce/0x220
>     [<0000000044a8bccb>] ksys_write+0xea/0x190
>     [<0000000037335938>] system_call+0x296/0x2b4
