Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgIUOsT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 10:48:19 -0400
Date: Mon, 21 Sep 2020 15:48:09 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 02/11] mm: call import_iovec() instead of
 rw_copy_check_uvector() in process_vm_rw()
Message-ID: <20200921144809.GV32101@casper.infradead.org>
References: <20200921143434.707844-1-hch@lst.de>
 <20200921143434.707844-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921143434.707844-3-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Mon, Sep 21, 2020 at 04:34:25PM +0200, Christoph Hellwig wrote:
>  {
> -	WARN_ON(direction & ~(READ | WRITE));
> +	WARN_ON(direction & ~(READ | WRITE | CHECK_IOVEC_ONLY));

This is now a no-op because:

include/linux/fs.h:#define CHECK_IOVEC_ONLY -1

I'd suggest we renumber it to 2?

(READ is 0, WRITE is 1.  This WARN_ON should probably be
	WARN_ON(direction > CHECK_IOVEC_ONLY)
