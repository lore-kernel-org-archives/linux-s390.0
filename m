Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgIUQ3K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 12:29:10 -0400
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200920151510.GS32101@casper.infradead.org>
 <20200920180742.GN3421308@ZenIV.linux.org.uk>
 <20200920190159.GT32101@casper.infradead.org>
 <20200920191031.GQ3421308@ZenIV.linux.org.uk>
 <20200920192259.GU32101@casper.infradead.org>
From: Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <4d07ec00-d1fb-1710-063e-670a18c33caf@gmail.com>
Date: Mon, 21 Sep 2020 19:26:34 +0300
MIME-Version: 1.0
In-Reply-To: <20200920192259.GU32101@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On 20/09/2020 22:22, Matthew Wilcox wrote:
> On Sun, Sep 20, 2020 at 08:10:31PM +0100, Al Viro wrote:
>> IMO it's much saner to mark those and refuse to touch them from io_uring...
> 
> Simpler solution is to remove io_uring from the 32-bit syscall list.
> If you're a 32-bit process, you don't get to use io_uring.  Would
> any real users actually care about that?

There were .net and\or wine (which AFAIK often works in compat) guys
experimenting with io_uring, they might want it.

-- 
Pavel Begunkov
