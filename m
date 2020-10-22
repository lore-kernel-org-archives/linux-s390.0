Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
Date: Thu, 22 Oct 2020 16:50:04 +0000
Message-ID: <089031589f0f43a39f9a5a7737443880@AcuMS.aculab.com>
References: <80a2e5fa-718a-8433-1ab0-dd5b3e3b5416@redhat.com>
 <5d2ecb24db1e415b8ff88261435386ec@AcuMS.aculab.com>
 <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com>
 <20201022090155.GA1483166@kroah.com>
 <e04d0c5d-e834-a15b-7844-44dcc82785cc@redhat.com>
 <a1533569-948a-1d5b-e231-5531aa988047@redhat.com>
 <bc0a091865f34700b9df332c6e9dcdfd@AcuMS.aculab.com>
 <5fd6003b-55a6-2c3c-9a28-8fd3a575ca78@redhat.com>
 <20201022132342.GB8781@lst.de>
 <8f1fff0c358b4b669d51cc80098dbba1@AcuMS.aculab.com>
 <20201022164040.GV20115@casper.infradead.org>
In-Reply-To: <20201022164040.GV20115@casper.infradead.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
List-ID: <linux-s390.vger.kernel.org>
To: 'Matthew Wilcox' <willy@infradead.org>
Cc: 'Christoph Hellwig' <hch@lst.de>, David Hildenbrand <david@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Desaulniers <ndesaulniers@google.com>, "kernel-team@android.com" <kernel-team@android.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

From: Matthew Wilcox <willy@infradead.org>
> Sent: 22 October 2020 17:41
> 
> On Thu, Oct 22, 2020 at 04:35:17PM +0000, David Laight wrote:
> > Wait...
> > readv(2) defines:
> > 	ssize_t readv(int fd, const struct iovec *iov, int iovcnt);
> 
> It doesn't really matter what the manpage says.  What does the AOSP
> libc header say?

The only copy I can find is:

/usr/include/x86_64-linux-gnu/sys/uio.h:extern ssize_t readv (int __fd, const struct iovec *__iovec, int __count)
/usr/include/x86_64-linux-gnu/sys/uio.h-  __wur;

and not surprisingly agrees.
POSIX and/or TOG will (more or less) mandate the prototype.

> > But the syscall is defined as:
> >
> > SYSCALL_DEFINE3(readv, unsigned long, fd, const struct iovec __user *, vec,
> >                 unsigned long, vlen)
> > {
> >         return do_readv(fd, vec, vlen, 0);
> > }

I wonder when the high bits of 'fd' get zapped?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
