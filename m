Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:45629 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgEST3b (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 15:29:31 -0400
Date: Tue, 19 May 2020 21:29:29 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/2] block: remove ioctl_by_bdev
Message-ID: <20200519192929.GA7920@lst.de>
References: <20200519142259.102279-1-sth@linux.ibm.com> <20200519143321.GB16127@lst.de> <20200519190333.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519190333.GR23230@ZenIV.linux.org.uk>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

On Tue, May 19, 2020 at 08:03:33PM +0100, Al Viro wrote:
> On Tue, May 19, 2020 at 04:33:21PM +0200, Christoph Hellwig wrote:
> > No callers left.
> 
> No callers left after...?  IOW, where are the patches?  There'd been
> several patchsets posted, each with more than one revision...

In Jens' for-5.8/block tree, which has all the patches to remove them
merged.

Link: https://git.kernel.dk/cgit/linux-block/log/?h=for-5.8/block
