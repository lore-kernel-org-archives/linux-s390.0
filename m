Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38222 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgFSVRF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Jun 2020 17:17:05 -0400
Date: Fri, 19 Jun 2020 21:17:00 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 6/6] kernel: add a kernel_wait helper
Message-ID: <20200619211700.GS11244@42.do-not-panic.com>
References: <20200618144627.114057-1-hch@lst.de>
 <20200618144627.114057-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144627.114057-7-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:46:27PM +0200, Christoph Hellwig wrote:
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
>  	return ret;
>  }
>  
> +int kernel_wait(pid_t pid, int *stat)
> +{
> +	struct wait_opts wo = {
> +		.wo_type	= PIDTYPE_PID,
> +		.wo_pid		= find_get_pid(pid),
> +		.wo_flags	= WEXITED,
> +	};
> +	int ret;
> +
> +	ret = do_wait(&wo);
> +	if (ret > 0 && wo.wo_stat)
> +		*stat = wo.wo_stat;

Since all we care about is WEXITED, that could be simplified
to something like this:

if (ret > 0 && KWIFEXITED(wo.wo_stat)
 	*stat = KWEXITSTATUS(wo.wo_stat)

Otherwise callers have to use W*() wrappers.

> +	put_pid(wo.wo_pid);
> +	return ret;
> +}

Then we don't get *any* in-kernel code dealing with the W*() crap.
I just unwrapped this for the umh [0], given that otherwise we'd
have to use KW*() callers elsewhere. Doing it upshot one level
further would be even better.

[0] https://lkml.kernel.org/r/20200610154923.27510-1-mcgrof@kernel.org              

  Luis
