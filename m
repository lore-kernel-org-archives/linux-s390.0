Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJGLJm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 07:09:42 -0400
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519142259.102279-3-sth@linux.ibm.com>
 <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
 <20201007103936.GA24327@lst.de>
 <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <d339d5c2-30c7-5073-1ba8-6fbb83400d8c@linux.ibm.com>
Date: Wed, 7 Oct 2020 13:09:32 +0200
MIME-Version: 1.0
In-Reply-To: <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org

Am 07.10.20 um 12:44 schrieb Christian Borntraeger:
>
> On 07.10.20 12:39, Christoph Hellwig wrote:
>> On Wed, Oct 07, 2020 at 11:34:17AM +0200, Christian Borntraeger wrote:
>>> On 19.05.20 16:22, Stefan Haberland wrote:
>>>> The IBM partition parser requires device type specific information only
>>>> available to the DASD driver to correctly register partitions. The
>>>> current approach of using ioctl_by_bdev with a fake user space pointer
>>>> is discouraged.
>>>>
>>>> Fix this by replacing IOCTL calls with direct in-kernel function calls.
>>>>
>>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>>>> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
>>>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>>> FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.
>> What are the symptoms?
> During boot I normally have
>  
> [    0.930231] virtio_blk virtio1: [vda] 5409180 4096-byte logical blocks (22.2 GB/20.6 GiB)
> [    0.930233] vda: detected capacity change from 0 to 22156001280
> [    0.932806]  vda:VOL1/  0X3333: vda1 vda2 vda3
>
> With this change, the last line is no longer there (if CONFIG_DASD=m) and this also 
> reflects itself in /proc/partitions. The partitions are no longer detected.

OK, looks like the module is not loaded and with

        fn = symbol_get(dasd_biodasdinfo);
        if (!fn)
                goto out_exit;

the ibm.c partition detection aborts.

Solution could be not to exit in this case but jump to the probing
process. I will have a closer look at this.
