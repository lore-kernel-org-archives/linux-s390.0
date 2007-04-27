Return-Path: <linux-kernel-owner+w=401wt.eu-S1756055AbXD0QPr@vger.kernel.org>
Subject: Re: [patch 18/38] Improved oops output.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <46321E5E.9010909@redhat.com>
References: <20070427140503.087958775@de.ibm.com>
	 <20070427140516.013904506@de.ibm.com>
	 <20070427142506.GA12738@infradead.org> <1177687465.23773.2.camel@localhost>
	  <46321E5E.9010909@redhat.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 18:15:48 +0200
Message-Id: <1177690548.23773.13.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2007-04-27 at 12:01 -0400, Chuck Ebbert wrote:
> Martin Schwidefsky wrote:
> >> So we're growing in-kernel disassemblers now? :)
> >>
> >> I wonder whether this is really worth it, but at least your handwritten
> >> one is much nicer than the copy & paste from gdb in the kdb patches.
> > 
> > The disassembler uses about 8K of memory and it really helps in
> > debugging. For me it is worth the cost.
> > 
> 
> No ksymoops for your architecture?

There is ksymoops for s390 and it should be able to disassemble the code
as well. But you need all sorts of files to feed into ksymoops to get
something out of it. At least I often get bug reports with the console
output attached and it simply saves time if I can see the disassembly
without an extra step.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
