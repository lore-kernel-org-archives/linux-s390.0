Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57883 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgKYIiK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 03:38:10 -0500
Date: Wed, 25 Nov 2020 09:38:08 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20201125083808.GB31753@lst.de>
References: <20200915154340.4215-1-hca@linux.ibm.com> <20200915154340.4215-5-hca@linux.ibm.com> <20200915160243.GB22056@lst.de> <20200915193755.GA8528@osiris> <20200916123603.GC7076@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916123603.GC7076@osiris>
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

On Wed, Sep 16, 2020 at 02:36:03PM +0200, Heiko Carstens wrote:
> So, I can think of several ways to fix this (or better: make this
> robust). However given that I will be away the next two weeks this is
> not going to happen for the upcoming merge window. I really don't want
> to rush this, since this has potential for severe subtle bugs... like
> we had them already several times with our address space and dynamic
> page table upgrade handling in the past (and like I nearly introduced
> at least one bug with this patch).
> 
> Therefore the first three patches of this series are scheduled for the
> upcoming merge window, while the final set_fs() removal should come
> one merge later.

Did you manage to get back to the s390 set_fs removal?
