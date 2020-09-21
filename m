Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46099 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbgIUPFh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 11:05:37 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 04/11] iov_iter: explicitly check for CHECK_IOVEC_ONLY in
 rw_copy_check_uvector
Date: Mon, 21 Sep 2020 15:05:32 +0000
Message-ID: <7336624280b8444fb4cb00407317741b@AcuMS.aculab.com>
References: <20200921143434.707844-1-hch@lst.de>
 <20200921143434.707844-5-hch@lst.de>
In-Reply-To: <20200921143434.707844-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: 'Christoph Hellwig' <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

From: Christoph Hellwig
> Sent: 21 September 2020 15:34
> 
> Explicitly check for the magic value insted of implicitly relying on
> its numeric representation.   Also drop the rather pointless unlikely
> annotation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/iov_iter.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index d7e72343c360eb..a64867501a7483 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1709,8 +1709,7 @@ static ssize_t rw_copy_check_uvector(int type,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		if (type >= 0
> -		    && unlikely(!access_ok(buf, len))) {
> +		if (type != CHECK_IOVEC_ONLY && !access_ok(buf, len)) {
>  			ret = -EFAULT;
>  			goto out;
>  		}
> @@ -1824,7 +1823,7 @@ static ssize_t compat_rw_copy_check_uvector(int type,
>  		}
>  		if (len < 0)	/* size_t not fitting in compat_ssize_t .. */
>  			goto out;
> -		if (type >= 0 &&
> +		if (type != CHECK_IOVEC_ONLY &&
>  		    !access_ok(compat_ptr(buf), len)) {
>  			ret = -EFAULT;
>  			goto out;
> --
> 2.28.0

I've actually no idea:
1) Why there is an access_ok() check here.
   It will be repeated by the user copy functions.
2) Why it isn't done when called from mm/process_vm_access.c.
   Ok, the addresses refer to a different process, but they
   must still be valid user addresses.

Is 2 a legacy from when access_ok() actually checked that the
addresses were mapped into the process's address space?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
