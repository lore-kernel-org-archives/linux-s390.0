Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21079 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgIUPoG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 11:44:06 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 02/11] mm: call import_iovec() instead of
 rw_copy_check_uvector() in process_vm_rw()
Date: Mon, 21 Sep 2020 15:44:00 +0000
Message-ID: <226e03bf941844eba4d64af31633c177@AcuMS.aculab.com>
References: <20200921143434.707844-1-hch@lst.de>
 <20200921143434.707844-3-hch@lst.de>
 <20200921150211.GS3421308@ZenIV.linux.org.uk>
 <ef67787edb2f48548d69caaaff6997ba@AcuMS.aculab.com>
 <20200921152937.GX3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200921152937.GX3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: 'Al Viro' <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

From: Al Viro
> Sent: 21 September 2020 16:30
> 
> On Mon, Sep 21, 2020 at 03:21:35PM +0000, David Laight wrote:
> 
> > You really don't want to be looping through the array twice.
> 
> Profiles, please.

I did some profiling of send() v sendmsg() much earlier in the year.
I can't remember the exact details but the extra cost of sendmsg()
is far more than you might expect.
(I was timing sending fully built IPv4 UDP packets using a raw socket.)

About half the difference does away if you change the
copy_from_user() to __copy_from_user() when reading the struct msghdr
and iov[] from userspace (user copy hardening is expensive).

The rest is just code path, my gut feeling is that a lot of that
is in import_iovec().

Remember semdmsg() is likely to be called with an iov count of 1.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
