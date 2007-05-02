Return-Path: <linux-kernel-owner+w=401wt.eu-S1755004AbXEBKtx@vger.kernel.org>
Date: Wed, 2 May 2007 11:49:45 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 20/38] Minor fault path optimization.
Message-ID: <20070502104945.GA13496@infradead.org>
References: <20070427140503.087958775@de.ibm.com> <20070427140516.523272684@de.ibm.com> <17970.53875.506097.699517@cargo.ozlabs.ibm.com> <20070428083409.GA22156@infradead.org> <1178102706.2440.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1178102706.2440.9.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 02, 2007 at 12:45:06PM +0200, Martin Schwidefsky wrote:
> I thought about using a direct call for s390 as well. The advantage of a
> direct call is that it avoids the overhead of a notifier call even if
> kprobes is running. The disadvantage is that there cannot be a second
> consumer of the fault notifications. I choose the middle way: avoid the
> overhead if kprobes is not active and use the full notifier if kprobes
> is running. It should not hurt the performance too badly since
> kprobe_running is only true if the cpu gets a page fault while executing
> a kprobe.

There is not second caller :)  Also it wouldn't work because you check
for kprobe_running() which wouldn't be true for it.  It also means
you go through the whole notifier chain mechanism for every userspace
page fault when kprobes are running which is the least of them.

So let's no do odd preparations for the future but optimize for
the current case and add things if needed in the future.  Note that
I plan to send similar patches for all kprobes supporting architectures
so that we have common code again.  Eventually notify_page_fault should
move into include/linux/kprobes.h



> 
> --kprobe_running 
> blue skies,
>   Martin.
> 
> "Reality continues to ruin my life." - Calvin.
> 
> 
---end quoted text---
