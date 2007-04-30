Return-Path: <linux-kernel-owner+w=401wt.eu-S1422717AbXD3BNN@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17973.16109.113219.634346@cargo.ozlabs.ibm.com>
Date: Mon, 30 Apr 2007 10:57:17 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 20/38] Minor fault path optimization.
In-Reply-To: <20070428083409.GA22156@infradead.org>
References: <20070427140503.087958775@de.ibm.com>
	<20070427140516.523272684@de.ibm.com>
	<17970.53875.506097.699517@cargo.ozlabs.ibm.com>
	<20070428083409.GA22156@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Christoph Hellwig writes:

> Well, here's my powerpc patch to do the direct call that I sent out
> a few weeks ago.  It not just speed up the pagefault path a lot, 
> but also is a major code cleanup.  Andi and Anton didn't like it
> because they have ambition for murky debugger code to possibly
> use it one day..

Looks good.  Could you resend it to me with a proper description and a
sign-off?

Thanks,
Paul.
