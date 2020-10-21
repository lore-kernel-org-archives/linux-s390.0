Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502871AbgJUQMX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Oct 2020 12:12:23 -0400
Date: Wed, 21 Oct 2020 18:13:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
Message-ID: <20201021161301.GA1196312@kroah.com>
References: <20200925045146.1283714-1-hch@lst.de>
 <20200925045146.1283714-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925045146.1283714-3-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, kernel-team@android.com
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 25, 2020 at 06:51:39AM +0200, Christoph Hellwig wrote:
> From: David Laight <David.Laight@ACULAB.COM>
> 
> This lets the compiler inline it into import_iovec() generating
> much better code.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/read_write.c | 179 ------------------------------------------------
>  lib/iov_iter.c  | 176 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 176 insertions(+), 179 deletions(-)

Strangely, this commit causes a regression in Linus's tree right now.

I can't really figure out what the regression is, only that this commit
triggers a "large Android system binary" from working properly.  There's
no kernel log messages anywhere, and I don't have any way to strace the
thing in the testing framework, so any hints that people can provide
would be most appreciated.

thanks,

greg k-h
