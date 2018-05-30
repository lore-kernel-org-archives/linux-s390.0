Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 30 May 2018 00:41:30 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
Message-ID: <20180530074130.GA6927@infradead.org>
References: <20180530075920.1f73275a@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530075920.1f73275a@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> -	req->completion_data = cqr;
> +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> +

Please don't play such tricks.  In general your driver structure
should have struct request embedded.  If for some reason
struct dasd_ccw_req has a different life time please create a new
structure instead of these hacks.

In either way this really doesn't look like a post-rc7 change.
