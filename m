Return-Path: <linux-kernel-owner+w=401wt.eu-S1762021AbYD3Jdc@vger.kernel.org>
Subject: Re: [patch] s390: Remove self ptrace IEEE_IP hack.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080430091900.GA13743@infradead.org>
References: <1209546896.10954.28.camel@localhost>
	 <20080430091900.GA13743@infradead.org>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 11:33:05 +0200
Message-Id: <1209547985.10954.29.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-04-30 at 05:19 -0400, Christoph Hellwig wrote:
> On Wed, Apr 30, 2008 at 11:14:56AM +0200, Martin Schwidefsky wrote:
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > The self referential PT_IEEE_IP ptrace peek & poke calls have been
> > broken for that last 6 years. For peek the code always returns 0
> > instead of the last ieee fault and for poke the code does nothing.
> > Since nobody noticed the code seems to be superfluous. So lets
> > remove it.
> 
> After this the switch to the generic sys_ptrace is trivial.  Care to
> submit a patch for that aswell?

True, that makes sense. I'll do that right after lunch.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
