Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38778 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbfJPP0W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Oct 2019 11:26:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so36677009qta.5
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 08:26:22 -0700 (PDT)
Message-ID: <1571239578.5937.62.camel@lca.pw>
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
From: Qian Cai <cai@lca.pw>
Date: Wed, 16 Oct 2019 11:26:18 -0400
In-Reply-To: <ddc3fb26-2286-de78-70dd-ef0f62bfd6c0@linux.ibm.com>
References: <1570044801.5576.262.camel@lca.pw>
         <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
         <1571234974.5937.53.camel@lca.pw>
         <ddc3fb26-2286-de78-70dd-ef0f62bfd6c0@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 16:56 +0200, Stefan Haberland wrote:
> On 16.10.19 16:09, Qian Cai wrote:
> > On Wed, 2019-10-16 at 15:29 +0200, Stefan Haberland wrote:
> > > Hi,
> > > 
> > > thanks for reporting this.
> > > 
> > > On 02.10.19 21:33, Qian Cai wrote:
> > > > For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
> > > > dasd_generic_set_online() emits this message,
> > > > 
> > > > dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
> > > > 
> > > > After that, there are several memory leaks below. There are "config_data" and
> > > > then stored as,
> > > > 
> > > > /* store per path conf_data */
> > > > device->path[pos].conf_data = conf_data;
> > > > 
> > > > When it processes the error path in  dasd_generic_set_online(), it calls
> > > > dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
> > > > the device->path[].conf_data first. 
> > > 
> > > Usually dasd_delete_device() calls dasd_generic_free_discipline() which
> > > takes care of
> > > the device->path[].conf_data in dasd_eckd_uncheck_device().
> > > From a first look this looks sane.
> > > 
> > > So I need to spend a closer look if this does not happen correctly here.
> > 
> > When dasd_eckd_check_characteristics() failed here,
> > 
> > 	if (!private) {
> > 		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
> > 		if (!private) {
> > 			dev_warn(&device->cdev->dev,
> > 				 "Allocating memory for private DASD data "
> > 				 "failed\n");
> > 			return -ENOMEM;
> > 		}
> > 		device->private = private;
> > 
> > The device->private is NULL.
> > 
> > Then, in dasd_eckd_uncheck_device(), it will return immediately.
> > 
> > 	if (!private)
> > 		return;
> 
> Yes but in this case there is no per_path configuration data stored.
> This is done after the private structure is allocated successfully.

Yes, you are right. It has been a while so I must lost a bit memory. Actually,
it looks like in dasd_eckd_check_characteristic() that device->private is set to
NULL from this path,

	/* Read Configuration Data */
	rc = dasd_eckd_read_conf(device);
	if (rc)
		goto out_err1;

out_err1:
	kfree(private->conf_data);
	kfree(device->private);
	device->private = NULL;
	return rc;

because dasd_eckd_read_conf() returns -ENOMEM and calls,

out_error:
	kfree(rcd_buf);
	*rcd_buffer = NULL;
	*rcd_buffer_size = 0;
	return ret;

It will only free its own config_data in one operational path, but there could
has already allocated in earlier paths in dasd_eckd_read_conf() without any
rollback and calls return,

	for (lpm = 0x80; lpm; lpm>>= 1) {
		if (!(lpm & opm))
			continue;
		rc = dasd_eckd_read_conf_lpm(device, &conf_data,
					     &conf_len, lpm);
		if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
			DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
					"Read configuration data returned "
					"error %d", rc);
			return rc;
		}

Later, dasd_eckd_uncheck_device() see private->device is NULL without cleaning
up. Does it make sense?

> 
> 
> > > > Is it safe to free those in
> > > > dasd_free_device() without worrying about the double-free? Or, is it better to
> > > > free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
> > > > out_err*?
> > > > 
> > > > --- a/drivers/s390/block/dasd.c
> > > > +++ b/drivers/s390/block/dasd.c
> > > > @@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
> > > >   */
> > > >  void dasd_free_device(struct dasd_device *device)
> > > >  {
> > > > +       for (int i = 0; i < 8; i++)
> > > > +               kfree(device->path[i].conf_data);
> > > > +
> > > >         kfree(device->private);
> > > >         free_pages((unsigned long) device->ese_mem, 1);
> > > >         free_page((unsigned long) device->erp_mem);
> > > > 
> > > > 
> > > > unreferenced object 0x0fcee900 (size 256):
> > > >   comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
> > > >   hex dump (first 32 bytes):
> > > >     dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
> > > >     f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
> > > >   backtrace:
> > > >     [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
> > > >     [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
> > > >     [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
> > > > [dasd_eckd_mod]
> > > >     [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
> > > >     [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
> > > >     [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
> > > >     [<00000000349a5446>] online_store+0x2ce/0x420
> > > >     [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
> > > >     [<0000000005664197>] vfs_write+0xce/0x220
> > > >     [<0000000044a8bccb>] ksys_write+0xea/0x190
> > > >     [<0000000037335938>] system_call+0x296/0x2b4
> 
> 
