Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTDo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 May 2020 15:03:44 -0400
Date: Tue, 19 May 2020 20:03:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/2] block: remove ioctl_by_bdev
Message-ID: <20200519190333.GR23230@ZenIV.linux.org.uk>
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519143321.GB16127@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519143321.GB16127@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

On Tue, May 19, 2020 at 04:33:21PM +0200, Christoph Hellwig wrote:
> No callers left.

No callers left after...?  IOW, where are the patches?  There'd been
several patchsets posted, each with more than one revision...

I realize that some of that went into -mm, but could you repost
the final variant of the entire pile and/or tell which set of
git branches to look at?
