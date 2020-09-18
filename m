Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 18 Sep 2020 14:58:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <20200918135822.GZ3421308@ZenIV.linux.org.uk>
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200918134012.GY3421308@ZenIV.linux.org.uk>
 <20200918134406.GA17064@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918134406.GA17064@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 18, 2020 at 03:44:06PM +0200, Christoph Hellwig wrote:
> On Fri, Sep 18, 2020 at 02:40:12PM +0100, Al Viro wrote:
> > >  	/* Vector 0x110 is LINUX_32BIT_SYSCALL_TRAP */
> > > -	return pt_regs_trap_type(current_pt_regs()) == 0x110;
> > > +	return pt_regs_trap_type(current_pt_regs()) == 0x110 ||
> > > +		(current->flags & PF_FORCE_COMPAT);
> > 
> > Can't say I like that approach ;-/  Reasoning about the behaviour is much
> > harder when it's controlled like that - witness set_fs() shite...
> 
> I don't particularly like it either.  But do you have a better idea
> how to deal with io_uring vs compat tasks?

<wry> git rm fs/io_uring.c would make a good starting point </wry>
Yes, I know it's not going to happen, but one can dream...

Said that, why not provide a variant that would take an explicit
"is it compat" argument and use it there?  And have the normal
one pass in_compat_syscall() to that...
