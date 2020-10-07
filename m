Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37104 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgJGMAK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 7 Oct 2020 08:00:10 -0400
Date: Wed, 7 Oct 2020 14:00:05 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
Message-ID: <20201007120005.GA29788@lst.de>
References: <20200519142259.102279-1-sth@linux.ibm.com> <20200519142259.102279-3-sth@linux.ibm.com> <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com> <20201007103936.GA24327@lst.de> <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:44:55PM +0200, Christian Borntraeger wrote:
> 
> 
> On 07.10.20 12:39, Christoph Hellwig wrote:
> > On Wed, Oct 07, 2020 at 11:34:17AM +0200, Christian Borntraeger wrote:
> >>
> >> On 19.05.20 16:22, Stefan Haberland wrote:
> >>> The IBM partition parser requires device type specific information only
> >>> available to the DASD driver to correctly register partitions. The
> >>> current approach of using ioctl_by_bdev with a fake user space pointer
> >>> is discouraged.
> >>>
> >>> Fix this by replacing IOCTL calls with direct in-kernel function calls.
> >>>
> >>> Suggested-by: Christoph Hellwig <hch@lst.de>
> >>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> >>> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
> >>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> >>
> >> FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.
> > 
> > What are the symptoms?
> 
> During boot I normally have

> [    0.930231] virtio_blk virtio1: [vda] 5409180 4096-byte logical blocks (22.2 GB/20.6 GiB)
> [    0.930233] vda: detected capacity change from 0 to 22156001280
> [    0.932806]  vda:VOL1/  0X3333: vda1 vda2 vda3
> 
> With this change, the last line is no longer there (if CONFIG_DASD=m) and this also 
> reflects itself in /proc/partitions. The partitions are no longer detected.

Can you try this patch?

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index d6e18df9c53c6d..d91cee558ce67a 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -305,8 +305,6 @@ int ibm_partition(struct parsed_partitions *state)
 	if (!disk->fops->getgeo)
 		goto out_exit;
 	fn = symbol_get(dasd_biodasdinfo);
-	if (!fn)
-		goto out_exit;
 	blocksize = bdev_logical_block_size(bdev);
 	if (blocksize <= 0)
 		goto out_symbol;
@@ -326,7 +324,7 @@ int ibm_partition(struct parsed_partitions *state)
 	geo->start = get_start_sect(bdev);
 	if (disk->fops->getgeo(bdev, geo))
 		goto out_freeall;
-	if (fn(disk, info)) {
+	if (!fn || fn(disk, info)) {
 		kfree(info);
 		info = NULL;
 	}
