Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463587AbgJWR7O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Oct 2020 13:59:14 -0400
Date: Fri, 23 Oct 2020 18:58:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
Message-ID: <20201023175857.GA3576660@ZenIV.linux.org.uk>
References: <a1533569-948a-1d5b-e231-5531aa988047@redhat.com>
 <bc0a091865f34700b9df332c6e9dcdfd@AcuMS.aculab.com>
 <5fd6003b-55a6-2c3c-9a28-8fd3a575ca78@redhat.com>
 <20201022104805.GA1503673@kroah.com>
 <20201022121849.GA1664412@kroah.com>
 <98d9df88-b7ef-fdfb-7d90-2fa7a9d7bab5@redhat.com>
 <20201022125759.GA1685526@kroah.com>
 <20201022135036.GA1787470@kroah.com>
 <134f162d711d466ebbd88906fae35b33@AcuMS.aculab.com>
 <935f7168-c2f5-dd14-7124-412b284693a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935f7168-c2f5-dd14-7124-412b284693a2@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: David Laight <David.Laight@aculab.com>, 'Greg KH' <gregkh@linuxfoundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Christoph Hellwig <hch@lst.de>, "kernel-team@android.com" <kernel-team@android.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

On Fri, Oct 23, 2020 at 03:09:30PM +0200, David Hildenbrand wrote:

> Now, I am not a compiler expert, but as I already cited, at least on
> x86-64 clang expects that the high bits were cleared by the caller - in
> contrast to gcc. I suspect it's the same on arm64, but again, I am no
> compiler expert.
> 
> If what I said and cites for x86-64 is correct, if the function expects
> an "unsigned int", it will happily use 64bit operations without further
> checks where valid when assuming high bits are zero. That's why even
> converting everything to "unsigned int" as proposed by me won't work on
> clang - it assumes high bits are zero (as indicated by Nick).
> 
> As I am neither a compiler experts (did I mention that already? ;) ) nor
> an arm64 experts, I can't tell if this is a compiler BUG or not.

On arm64 when callee expects a 32bit argument, the caller is *not* responsible
for clearing the upper half of 64bit register used to pass the value - it only
needs to store the actual value into the lower half.  The callee must consider
the contents of the upper half of that register as undefined.  See AAPCS64 (e.g.
https://github.com/ARM-software/abi-aa/blob/master/aapcs64/aapcs64.rst#parameter-passing-rules
); AFAICS, the relevant bit is
	"Unlike in the 32-bit AAPCS, named integral values must be narrowed by
the callee rather than the caller."
