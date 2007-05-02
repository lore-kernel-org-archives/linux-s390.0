Return-Path: <linux-kernel-owner+w=401wt.eu-S2993045AbXEBKoq@vger.kernel.org>
Subject: Re: [patch 20/38] Minor fault path optimization.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070428083409.GA22156@infradead.org>
References: <20070427140503.087958775@de.ibm.com>
	 <20070427140516.523272684@de.ibm.com>
	 <17970.53875.506097.699517@cargo.ozlabs.ibm.com>
	 <20070428083409.GA22156@infradead.org>
Content-Type: text/plain
Date: Wed, 02 May 2007 12:45:06 +0200
Message-Id: <1178102706.2440.9.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 2007-04-28 at 09:34 +0100, Christoph Hellwig wrote:
> Well, here's my powerpc patch to do the direct call that I sent out
> a few weeks ago.  It not just speed up the pagefault path a lot, 
> but also is a major code cleanup.  Andi and Anton didn't like it
> because they have ambition for murky debugger code to possibly
> use it one day..

I thought about using a direct call for s390 as well. The advantage of a
direct call is that it avoids the overhead of a notifier call even if
kprobes is running. The disadvantage is that there cannot be a second
consumer of the fault notifications. I choose the middle way: avoid the
overhead if kprobes is not active and use the full notifier if kprobes
is running. It should not hurt the performance too badly since
kprobe_running is only true if the cpu gets a page fault while executing
a kprobe.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
