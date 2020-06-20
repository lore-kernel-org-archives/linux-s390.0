Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38352 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTRCX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 20 Jun 2020 13:02:23 -0400
Date: Sat, 20 Jun 2020 17:02:19 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 6/6] kernel: add a kernel_wait helper
Message-ID: <20200620170219.GT11244@42.do-not-panic.com>
References: <20200618144627.114057-1-hch@lst.de>
 <20200618144627.114057-7-hch@lst.de>
 <20200619211700.GS11244@42.do-not-panic.com>
 <20200620063538.GA2408@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620063538.GA2408@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 08:35:38AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 19, 2020 at 09:17:00PM +0000, Luis Chamberlain wrote:
> > On Thu, Jun 18, 2020 at 04:46:27PM +0200, Christoph Hellwig wrote:
> > > --- a/kernel/exit.c
> > > +++ b/kernel/exit.c
> > > @@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
> > >  	return ret;
> > >  }
> > >  
> > > +int kernel_wait(pid_t pid, int *stat)
> > > +{
> > > +	struct wait_opts wo = {
> > > +		.wo_type	= PIDTYPE_PID,
> > > +		.wo_pid		= find_get_pid(pid),
> > > +		.wo_flags	= WEXITED,
> > > +	};
> > > +	int ret;
> > > +
> > > +	ret = do_wait(&wo);
> > > +	if (ret > 0 && wo.wo_stat)
> > > +		*stat = wo.wo_stat;
> > 
> > Since all we care about is WEXITED, that could be simplified
> > to something like this:
> > 
> > if (ret > 0 && KWIFEXITED(wo.wo_stat)
> >  	*stat = KWEXITSTATUS(wo.wo_stat)
> > 
> > Otherwise callers have to use W*() wrappers.
> > 
> > > +	put_pid(wo.wo_pid);
> > > +	return ret;
> > > +}
> > 
> > Then we don't get *any* in-kernel code dealing with the W*() crap.
> > I just unwrapped this for the umh [0], given that otherwise we'd
> > have to use KW*() callers elsewhere. Doing it upshot one level
> > further would be even better.
> > 
> > [0] https://lkml.kernel.org/r/20200610154923.27510-1-mcgrof@kernel.org              
> Do you just want to pick this patch up, add your suggested bits and
> add it to the beginning of your series?  That should clean the whole
> thing up a bit.  Nothing else in this series depends on the patch.

Sure but let's wait to hear from the NFS folks.

I'm waiting to hear from NFS folks if the one place where the UMH is
fixed for the error code (on fs/nfsd/nfs4recover.c we never were
disabling the upcall as the error code of -ENOENT or -EACCES was *never*
properly checked for) to see how critical that was. If it can help
stable kernels the fix can go in as I proposed, followed by this patch
to further take the KWEXITSTATUS() up further, and ensure we *never*
deal with this in-kernel. If its not a fix stable kernels should care
for what you suggest of taking this patch first would be best and I'd be
happy to do that.

  Luis
