Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbgKFQJZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Nov 2020 11:09:25 -0500
Date: Fri, 6 Nov 2020 17:08:58 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 06/10] dasd: implement ->set_read_only to hook into
 BLKROSET processing
Message-ID: <20201106160858.GA76682@imap.linux.ibm.com>
References: <20201103100018.683694-1-hch@lst.de>
 <20201103100018.683694-7-hch@lst.de>
 <20201105205634.GA78869@imap.linux.ibm.com>
 <20201106140201.GA23087@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106140201.GA23087@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

Christoph Hellwig <hch@lst.de> schrieb am Fri, 06. Nov 15:02:
> On Thu, Nov 05, 2020 at 09:56:47PM +0100, Stefan Haberland wrote:
> > > +	/* do not manipulate hardware state for partitions */
> > >  	if (bdev_is_partition(bdev))
> > > -		// ro setting is not allowed for partitions
> > > -		return -EINVAL;
> > > -	if (get_user(intval, (int __user *)argp))
> > > -		return -EFAULT;
> > > +		return 0;
> > > +
> > >  	base = dasd_device_from_gendisk(bdev->bd_disk);
> > >  	if (!base)
> > >  		return -ENODEV;
> > > -	if (!intval && test_bit(DASD_FLAG_DEVICE_RO, &base->flags)) {
> > > -		dasd_put_device(base);
> > > -		return -EROFS;
> > > -	}
> > > -	set_disk_ro(bdev->bd_disk, intval);
> > 
> > 
> > While testing this patch I just noticed that when I set a device readonly this is
> > not going to be passed on to the partitions on this device any longer.
> > 
> > This is caused by the removed call to set_disk_ro().
> > 
> > Is this intentional or was this removed by accident?
> 
> It was unintentionally intentional :)
> 
> The generic code used already by almost all drivers in mainline only
> calls set_device_ro from blkdev_roset, that is it only sets the main
> device read-only.  dasd was the outlier here, and I didn't notice it
> actually called set_disk_ro instead of set_device_ro.   That being
> said I think setting all the partitions read-only as well when the
> full device is set read-only makes perfect sense.  I'm just a little
> worried it could cause regressions.  Let me prepare a follow on patch
> on top of the series that switches to that behavior.

Makes sense.
I am fine with that.

With this in mind:

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
