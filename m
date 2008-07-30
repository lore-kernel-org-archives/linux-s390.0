Return-Path: <linux-kernel-owner+w=401wt.eu-S1757876AbYG3Idb@vger.kernel.org>
Date: Wed, 30 Jul 2008 01:30:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 01/15] kmsg: Kernel message catalog macros.
Message-Id: <20080730013059.4d411750.akpm@linux-foundation.org>
In-Reply-To: <20080728175511.023246676@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
	<20080728175511.023246676@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Jul 2008 19:53:56 +0200 Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Introduce a new family of printk macros which prefixes each kmsg message
> with a component name and allows to tag the printk with a message id.
> 
> The kmsg component name is defined per source file with the KMSG_COMPONENT
> macro. The first argument of each kmsg printk is the message id. The
> message id "0" is special as it will suppress the message id prefix.
> 
> If the message id will be printed to the console / syslog at all depends
> on CONFIG_MSG_IDS. If it is "n" then a kmsg_xxx call is just another
> printk wrapper. These macros are intended to be used uniformly in the
> s390 architecture and the s390 device drivers.
> 
> Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  arch/s390/Kconfig       |    9 +++
>  include/asm-s390/kmsg.h |  124 ++++++++++++++++++++++++++++++++++++++++++++++++

Numerous people want a facility like this for other-than-s390 use. 
Progress has been intermittent and appears to have stopped.  The
apparently-dead mailing list is archived here:
https://lists.linux-foundation.org/pipermail/lf_kernel_messages/.

I don't know what the future holds for that development effort, but the
requirement won't go away.  So one day someone is going to go and yank
your implementation out of arch/s390 and into generic code.

So I'd suggest that you start out that way.
