Return-Path: <linux-kernel-owner+w=401wt.eu-S1755929AbXD0PYK@vger.kernel.org>
Subject: Re: [patch 18/38] Improved oops output.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070427142506.GA12738@infradead.org>
References: <20070427140503.087958775@de.ibm.com>
	 <20070427140516.013904506@de.ibm.com>
	 <20070427142506.GA12738@infradead.org>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 17:24:25 +0200
Message-Id: <1177687465.23773.2.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2007-04-27 at 15:25 +0100, Christoph Hellwig wrote:
> On Fri, Apr 27, 2007 at 04:05:21PM +0200, Martin Schwidefsky wrote:
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > This patch adds two improvements to the oops output. First it adds an
> > additional line after the PSW which decodes the different fields of it.
> > Second a disassembler is added that decodes the instructions surrounding
> > the faulting PSW. The output of a test oops now looks like this:
> 
> So we're growing in-kernel disassemblers now? :)
> 
> I wonder whether this is really worth it, but at least your handwritten
> one is much nicer than the copy & paste from gdb in the kdb patches.

The disassembler uses about 8K of memory and it really helps in
debugging. For me it is worth the cost.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
