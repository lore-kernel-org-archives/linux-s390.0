Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20333 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728162AbgDUKdQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 06:33:16 -0400
Date: Tue, 21 Apr 2020 12:32:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
Message-ID: <20200421123256.2f5d9dbd.cohuck@redhat.com>
In-Reply-To: <b7e4a728-1f58-f304-cb5b-1aa2206a6bb4@de.ibm.com>
References: <20200421061226.33731-1-hch@lst.de>
        <b7e4a728-1f58-f304-cb5b-1aa2206a6bb4@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 11:58:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 21.04.20 08:12, Christoph Hellwig wrote:
> > Hi Jens and DASD maintainers,
> > 
> > can you take a look at this series, which stops the DASD driver from
> > issuing ioctls from kernel space, in preparation of removing
> > ioctl_by_bdev.  I don't really like the new s390-only method, but short
> > of forcing the dasd driver to be built into the kernel I can't think of
> > anything better.  But maybe the s390 maintainers are fine with forcing
> > the DASD driver to be built in, in which case we could go down that
> > route?  
> 
> Hmm the defconfig results in dasd built-in anyway. But distros really like
> to keep it modular.
> 
> Hmm, we do have
> 
> obj-$(CONFIG_DASD) += dasd_mod.o
> obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod.o
> obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
> obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o
> 
> Would it work to make CONFIG_DASD built-in only and keep the other 3 as modules?
> Not sure about the implications. 
> 

I don't think non-eckd dasd drivers are really useful outside of z/VM
guests, so keeping at least the disciplines modular would be good.

Also, what about special purpose environments like the zfcp dumper?
Would be good to be able to keep these small.

How big is the dasd code in the end?
