Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46615 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgIOGj1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 02:39:27 -0400
Date: Tue, 15 Sep 2020 08:39:23 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt
 device driver
Message-ID: <20200915063923.GA19468@lst.de>
References: <20200910102838.28887-1-freude@linux.ibm.com> <20200911062134.GB21597@lst.de> <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On Mon, Sep 14, 2020 at 09:36:07AM +0200, Harald Freudenberger wrote:
> Christoph, maybe you have a greater idea on how to solve this. So don't hesitate and tell me.
> Otherwise how to we provide this fix then ? My recommendation would be to go the 'usual' way:
> Commit this s390 internal and then let this go out with the next kernel merge window when
> next time Linus is pulling patches from the s390 subsystem for the 5.10 kernel development cycle.

What I did for the networking code is to add a new structure that
contains a union of the kernel and userspace pointer and a flag for
which one to use.  That is pretty much the same as what you did, just
a little more structured and type safe.  The other alternative would
be to use the iov_iter infrastructure, but that has some overhead.
