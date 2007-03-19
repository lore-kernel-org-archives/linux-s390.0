Return-Path: <linux-arch-owner@vger.kernel.org>
From: Andi Kleen <ak@suse.de>
Subject: Re: [S390] minor fault path optimization.
Date: Mon, 19 Mar 2007 15:00:34 +0100
References: <20070319133149.GA5781@infradead.org>
In-Reply-To: <20070319133149.GA5781@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703191500.34563.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Monday 19 March 2007 14:31, Christoph Hellwig wrote:
> On Mon, Mar 19, 2007 at 02:02:06PM +0100, Martin Schwidefsky wrote:
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > [S390] minor fault path optimization.
> > 
> > The minor fault path has grown a lot in terms of cycles. In particular
> > the kprobes hook is very costly. Optimize the path to save a couple of
> > cycles. If kprobes is enabled more than 300 cycles can be avoided if 
> > kprobes_running() is false.
> 
> Actually there is a lot more fishy here.  This code is duplicated over
> every single architecture.  It uses a notifier chain that only ever has
> one actual uaesr.  It exports interfaces that are potential harmful.

Agreed, it should be fixed generically.

I think the right fix would be to make the notifier call an inline
that checks the call chain in the caller. That would be cheap enough,
except for the cache line that might need to be referenced.

For the cache line the short term fix would be to find some other
global cache line that is referenced in the fault path anyways and put
it on the same (e.g. by just putting the variable next to it or
using a shared structure) 

Longer term might be something like Ben LaHaise's patch that can patch
code inline for rarely-read globals.

> Please do the right thing to optimize this instead and rip out the brandead
> notifier chain mechanisms and directly call into the krobes handler if
> kprobes are active, 

No, we should keep the debugger hooks here. Otherwise there will be a zillion
external patches patches code in at these places for the various debuggers,
resulting in a merge nightmare for lots of people.

-Andi
