Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
Date: Wed, 21 Oct 2020 20:59:43 +0000
Message-ID: <b416290b76684ac392e8c43d764645f8@AcuMS.aculab.com>
References: <20200925045146.1283714-1-hch@lst.de>
 <20200925045146.1283714-3-hch@lst.de> <20201021161301.GA1196312@kroah.com>
In-Reply-To: <20201021161301.GA1196312@kroah.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
List-ID: <linux-s390.vger.kernel.org>
To: 'Greg KH' <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>, "kernel-team@android.com" <kernel-team@android.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

From: Greg KH
> Sent: 21 October 2020 17:13
> 
> On Fri, Sep 25, 2020 at 06:51:39AM +0200, Christoph Hellwig wrote:
> > From: David Laight <David.Laight@ACULAB.COM>
> >
> > This lets the compiler inline it into import_iovec() generating
> > much better code.
> >
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/read_write.c | 179 ------------------------------------------------
> >  lib/iov_iter.c  | 176 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 176 insertions(+), 179 deletions(-)
> 
> Strangely, this commit causes a regression in Linus's tree right now.
> 
> I can't really figure out what the regression is, only that this commit
> triggers a "large Android system binary" from working properly.  There's
> no kernel log messages anywhere, and I don't have any way to strace the
> thing in the testing framework, so any hints that people can provide
> would be most appreciated.

My original commit just moved the function source from one file to another.
So it is odd that it makes any difference.
I don't even know if it gets inlined by Christoph's actual patch.
(I have another patch that depended on it that I need to resubmit.)

Some of the other changes from Christoph's same patch set might
make a difference though.

Might be worth forcing it to be not inlined - so it is no change.
Or try adding a kernel log to import_iovec() or the associated
copy failing.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
