Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgDUPD6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 11:03:58 -0400
Date: Tue, 21 Apr 2020 17:03:54 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
Message-ID: <20200421150354.GA10191@lst.de>
References: <20200421061226.33731-1-hch@lst.de> <b4f38eb4-ab32-6713-fb8a-0c8e81efc645@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f38eb4-ab32-6713-fb8a-0c8e81efc645@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:17:53PM +0200, Stefan Haberland wrote:
> I can imagine some ways to get rid of this ioctl_by_bdev. Maybe having a
> udev
> rule to add a partition from userspace or having the driver add the implicit
> partition at the end. Or maybe something else.
> 
> If it is OK I will have a look at this and discuss this issue with my
> colleagues and come up with a different approach.

Sure, we can wait a few days.  Note that I don't want to break existing
userspace, which kinda speaks against a udev solution.
