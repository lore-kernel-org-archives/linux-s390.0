Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39909 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKNOcr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 09:32:47 -0500
Date: Thu, 14 Nov 2019 15:32:45 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: disk revalidation cleanups and fixlets
Message-ID: <20191114143245.GB1591@lst.de>
References: <20191106151439.30056-1-hch@lst.de> <e994fc4b-cc72-c2db-cc2c-754a0aa03057@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e994fc4b-cc72-c2db-cc2c-754a0aa03057@kernel.dk>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, Nov 14, 2019 at 07:08:55AM -0700, Jens Axboe wrote:
> On 11/6/19 8:14 AM, Christoph Hellwig wrote:
> > Hi Jens and Jan,
> > 
> > this series takes the disk size change detection and revalidations
> > from Jan a step further and fully integrate the code path for
> > partitioned vs non-partitioned devices.  It also fixes up a few
> > bits where we have unintentionally differing behavior.
> > 
> 
> Were you going to re-send this on top of the other stuff for 5.5?
> If so, should probably get queued up...

Hmm.  I am pretty sure I resent it, but I can't find it in the
archives either.  Let me do that now with the typo fix and review
tags added to it.
