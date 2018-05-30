Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 30 May 2018 14:59:58 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
In-Reply-To: <20180530074130.GA6927@infradead.org>
References: <20180530075920.1f73275a@mschwideX1> <20180530074130.GA6927@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1805301425580.1717@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 May 2018, Christoph Hellwig wrote:

> > -	req->completion_data = cqr;
> > +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> > +
> 
> Please don't play such tricks.  In general your driver structure
> should have struct request embedded.  If for some reason
> struct dasd_ccw_req has a different life time please create a new
> structure instead of these hacks.

Would you agree that this is an improvement over using completion_data
(at least now we don't mess with the block layers internal data)?

I already looked into what needs to be done to put struct dasd_ccw_req
behind the request and let it be managed by the block layer.

My concerns are lifetime and memory constraints (some of our HW interfaces
still use 31 bit pointers) but I think both of these are manageable with
the blk-mq interfaces.

But this would not be a small change and nothing for rc7. Would you be
OK with doing the small fix now and I'll work on the mentioned
improvement?

Regards,
Sebastian
