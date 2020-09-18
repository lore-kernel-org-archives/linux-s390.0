Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:32784 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRNoM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Sep 2020 09:44:12 -0400
Date: Fri, 18 Sep 2020 15:44:06 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <20200918134406.GA17064@lst.de>
References: <20200918124533.3487701-1-hch@lst.de> <20200918124533.3487701-2-hch@lst.de> <20200918134012.GY3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918134012.GY3421308@ZenIV.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 18, 2020 at 02:40:12PM +0100, Al Viro wrote:
> >  	/* Vector 0x110 is LINUX_32BIT_SYSCALL_TRAP */
> > -	return pt_regs_trap_type(current_pt_regs()) == 0x110;
> > +	return pt_regs_trap_type(current_pt_regs()) == 0x110 ||
> > +		(current->flags & PF_FORCE_COMPAT);
> 
> Can't say I like that approach ;-/  Reasoning about the behaviour is much
> harder when it's controlled like that - witness set_fs() shite...

I don't particularly like it either.  But do you have a better idea
how to deal with io_uring vs compat tasks?
