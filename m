Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50546 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S464021AbgJWMqm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Oct 2020 08:46:42 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
Date: Fri, 23 Oct 2020 12:46:36 +0000
Message-ID: <134f162d711d466ebbd88906fae35b33@AcuMS.aculab.com>
References: <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com>
 <20201022090155.GA1483166@kroah.com>
 <e04d0c5d-e834-a15b-7844-44dcc82785cc@redhat.com>
 <a1533569-948a-1d5b-e231-5531aa988047@redhat.com>
 <bc0a091865f34700b9df332c6e9dcdfd@AcuMS.aculab.com>
 <5fd6003b-55a6-2c3c-9a28-8fd3a575ca78@redhat.com>
 <20201022104805.GA1503673@kroah.com> <20201022121849.GA1664412@kroah.com>
 <98d9df88-b7ef-fdfb-7d90-2fa7a9d7bab5@redhat.com>
 <20201022125759.GA1685526@kroah.com> <20201022135036.GA1787470@kroah.com>
In-Reply-To: <20201022135036.GA1787470@kroah.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
List-ID: <linux-s390.vger.kernel.org>
To: 'Greg KH' <gregkh@linuxfoundation.org>, David Hildenbrand <david@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Nick Desaulniers <ndesaulniers@google.com>, Christoph Hellwig <hch@lst.de>, "kernel-team@android.com" <kernel-team@android.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

From: Greg KH <gregkh@linuxfoundation.org>
> Sent: 22 October 2020 14:51

I've rammed the code into godbolt.

https://godbolt.org/z/9v5PPW

Definitely a clang bug.

Search for [wx]24 in the clang output.
nr_segs comes in as w2 and the initial bound checks are done on w2.
w24 is loaded from w2 - I don't believe this changes the high bits.
There are no references to w24, just x24.
So the kmalloc_array() is passed 'huge' and will fail.
The iov_iter_init also gets the 64bit value.

Note that the gcc code has a sign-extend copy of w2.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
