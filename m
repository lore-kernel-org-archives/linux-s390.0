Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgJGMOH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 7 Oct 2020 08:14:07 -0400
Date: Wed, 7 Oct 2020 14:14:03 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
Message-ID: <20201007121403.GA30795@lst.de>
References: <20200519142259.102279-1-sth@linux.ibm.com> <20200519142259.102279-3-sth@linux.ibm.com> <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com> <20201007103936.GA24327@lst.de> <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com> <20201007120005.GA29788@lst.de> <e1e4afa1-faa2-aa19-a973-ee1286288802@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e4afa1-faa2-aa19-a973-ee1286288802@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:09:18PM +0200, Christian Borntraeger wrote:
> Unfortunately not. On insmodding virtio_blk I do get:

Yeah, the symbol_put needs to be conditional as well.  New version below:

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index d6e18df9c53c6d..4b044e620d3534 100644
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
@@ -370,7 +368,8 @@ int ibm_partition(struct parsed_partitions *state)
 out_nogeo:
 	kfree(info);
 out_symbol:
-	symbol_put(dasd_biodasdinfo);
+	if (fn)
+		symbol_put(dasd_biodasdinfo);
 out_exit:
 	return res;
 }
