Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRM4S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Sep 2020 08:56:18 -0400
Date: Fri, 18 Sep 2020 13:56:11 +0100
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 3/9] fs: explicitly check for CHECK_IOVEC_ONLY in
 rw_copy_check_uvector
Message-ID: <20200918125611.GE32101@casper.infradead.org>
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918124533.3487701-4-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 18, 2020 at 02:45:27PM +0200, Christoph Hellwig wrote:
>  		}
> -		if (type >= 0
> -		    && unlikely(!access_ok(buf, len))) {
> +		if (type != CHECK_IOVEC_ONLY && unlikely(!access_ok(buf, len))) {

drop the unlikely() at the same time?  if it's really advantageous,
that should be embedded in the access_ok macro.
