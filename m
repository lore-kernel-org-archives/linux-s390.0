Return-Path: <linux-kernel-owner+w=401wt.eu-S1759632AbYD3JTS@vger.kernel.org>
Date: Wed, 30 Apr 2008 05:19:00 -0400
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch] s390: Remove self ptrace IEEE_IP hack.
Message-ID: <20080430091900.GA13743@infradead.org>
References: <1209546896.10954.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1209546896.10954.28.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 30, 2008 at 11:14:56AM +0200, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> The self referential PT_IEEE_IP ptrace peek & poke calls have been
> broken for that last 6 years. For peek the code always returns 0
> instead of the last ieee fault and for poke the code does nothing.
> Since nobody noticed the code seems to be superfluous. So lets
> remove it.

After this the switch to the generic sys_ptrace is trivial.  Care to
submit a patch for that aswell?
