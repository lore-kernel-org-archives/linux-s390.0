Return-Path: <linux-kernel-owner+w=401wt.eu-S1752000AbYCLQ2U@vger.kernel.org>
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <47D802A2.1030406@goop.org>
References: <20080312132132.520833247@de.ibm.com>
	 <20080312132704.474209626@de.ibm.com>  <47D802A2.1030406@goop.org>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 17:28:05 +0100
Message-Id: <1205339285.8851.13.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 09:19 -0700, Jeremy Fitzhardinge wrote:
> Martin Schwidefsky wrote:
> > The state transitions (a diagram would be nicer but that is too hard
> > to do in ascii art...):
> > {Ur,Sr,Vr,Pr}: a resident page will change its block usage state if the
> >      guest requests it with page_set_{unused,stable,volatile}.
> > {Uz,Sz,Vz}: a logically zero page will change its block usage state if the
> >      guest requests it with page_set_{unused,stable,volatile}. The
> >      guest can't create the Pz state, the state will be Vz instead.
> > Ur -> Uz: the host system can remove an unused, resident page from memory
> > Sz -> Sr: on first access a stable, logically zero page will become resident
> > Sr -> Sp: the host system can swap a stable page to disk
> > Sp -> Sr: a guest access to a Sp page forces the host to retrieve it
> > Vr -> Vz: the host can discard a volatile page
> > Sp -> Uz: a page preserved by the host will be removed if the guest sets 
> >      the block usage state to unused.
> > Sp -> Vz: a page preserved by the host will be discarded if the guest sets
> >      the block usage state to volatile.
> > Pr -> Sp: the host can move a page from Pr to Sp if it discovers that the
> >      page is dirty while trying to discard the page. The page content is
> >      written to the paging device.
> > Pr -> Vz: the host can discard a Pr page. The Pz state is replaced by the
> >      Vz state.
> 
> I created the attached .dot graph based purely on this description.  It 
> looks reasonable, but I didn't see how a page enters a Pr state.

That is the first block of state transitions: {Ur,Sr,Vr,Pr}
You can go from any of the four states to any of the remaining three.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
