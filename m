Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 21 Jan 2016 22:51:27 +0000
From: Keith Busch <keith.busch@intel.com>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
Message-ID: <20160121225127.GA30993@localhost.localdomain>
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
 <56A14EE4.1020008@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A14EE4.1020008@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@fb.com>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 21, 2016 at 02:34:28PM -0700, Jens Axboe wrote:
> On 01/21/2016 07:57 AM, Stefan Haberland wrote:
> >Hi,
> >
> >unfortunately commit e36f62042880 "block: split bios to maxpossible length"
> >breaks the DASD driver on s390.  We expect the block requests to be
> >multiple
> >of 4k in size. With the patch applied I see the requests split up in
> >multiple
> >of 512 byte and therefore the requests get rejected and lots of I/Os fail.
> 
> Sigh, that's definitely a bug. I'll take a look at it and see if I
> can get a tested fix in for 4.5-rc1. If not, we'll revert it, again.

My apologies for the trouble. I trust it really is broken, but I don't
quite see how. The patch supposedly splits the transfer to the max size
the request queue says it allows. How does the max allowed size end up
an invalid multiple?
