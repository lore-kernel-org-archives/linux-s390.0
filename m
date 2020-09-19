Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgISWJc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 19 Sep 2020 18:09:32 -0400
Date: Sat, 19 Sep 2020 23:09:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <20200919220920.GI3421308@ZenIV.linux.org.uk>
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200918134012.GY3421308@ZenIV.linux.org.uk>
 <20200918134406.GA17064@lst.de>
 <20200918135822.GZ3421308@ZenIV.linux.org.uk>
 <20200918151615.GA23432@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918151615.GA23432@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 18, 2020 at 05:16:15PM +0200, Christoph Hellwig wrote:
> On Fri, Sep 18, 2020 at 02:58:22PM +0100, Al Viro wrote:
> > Said that, why not provide a variant that would take an explicit
> > "is it compat" argument and use it there?  And have the normal
> > one pass in_compat_syscall() to that...
> 
> That would help to not introduce a regression with this series yes.
> But it wouldn't fix existing bugs when io_uring is used to access
> read or write methods that use in_compat_syscall().  One example that
> I recently ran into is drivers/scsi/sg.c.

So screw such read/write methods - don't use them with io_uring.
That, BTW, is one of the reasons I'm sceptical about burying the
decisions deep into the callchain - we don't _want_ different
data layouts on read/write depending upon the 32bit vs. 64bit
caller, let alone the pointer-chasing garbage that is /dev/sg.
