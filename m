Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: let import_iovec deal with compat_iovecs as well
Date: Sat, 19 Sep 2020 14:24:10 +0000
Message-ID: <2c7bf42ee4314484ae0177280cd8f5f3@AcuMS.aculab.com>
References: <20200918124533.3487701-1-hch@lst.de>
In-Reply-To: <20200918124533.3487701-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: 'Christoph Hellwig' <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

From: Christoph Hellwig
> Sent: 18 September 2020 13:45
> 
> this series changes import_iovec to transparently deal with comat iovec
> structures, and then cleanups up a lot of code dupliation.  But to get
> there it first has to fix the pre-existing bug that io_uring compat
> contexts don't trigger the in_compat_syscall() check.  This has so far
> been relatively harmless as very little code callable from io_uring used
> the check, and even that code that could be called usually wasn't.

I thought about that change while writing my import_iovec() => iovec_import()
patch - and thought that the io_uring code would (as usual) cause grief.

Christoph - did you see those patches?
	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
