Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIRw1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 13:52:27 -0400
Date: Wed, 9 Oct 2019 10:51:49 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] proc: centralise declaration of cpuinfo_op
Message-ID: <20191009175149.GA28540@infradead.org>
References: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Oct 09, 2019 at 12:39:30PM +0100, Ben Dooks wrote:
> When building for arm, cpuinfo_op generates a warning due
> to no declaration. Since this is used in fs/proc/cpuinfo.c
> and inconsitently declared across archiectures move the
> declaration info <linux/seq_file.h>. This means that the
> cpuinfo_op will have a declaration any place it is used.
> 
> Removes the following sparse warning:
> 
> arch/arm/kernel/setup.c:1320:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?

I like the consolidation, but I don't think seq_file.h is the right
place.  A procfs or cpu topology related header seems like the better
choice.
