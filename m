Return-Path: <linux-kernel-owner+w=401wt.eu-S1754021AbYCMJgZ@vger.kernel.org>
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <47D840E3.5090902@goop.org>
References: <20080312132132.520833247@de.ibm.com>
	 <20080312132704.474209626@de.ibm.com> <47D802A2.1030406@goop.org>
	 <1205339285.8851.13.camel@localhost> <47D8085E.9030701@goop.org>
	 <1205341164.8851.44.camel@localhost> <47D81771.5070400@goop.org>
	 <47D8373C.40105@codemonkey.ws>  <47D840E3.5090902@goop.org>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 10:36:08 +0100
Message-Id: <1205400968.26537.25.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Anthony Liguori <anthony@codemonkey.ws>, akpm@osdl.org, linux-s390@vger.kernel.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 13:45 -0700, Jeremy Fitzhardinge wrote:
> Vp should never happen, since you'd never preserve a V page.  And surely 
> it would be Pr -> Sr, since the hypervisor wouldn't push the page to 
> backing store when you change the client state.

Vp does not happen in the current implementation. But it actually may be
useful. z/VM has multiple layers of paging, the first goes to expanded
storage which is very fast. If you make the page Vz and the guests needs
it you have to do a standard Linux I/O to get retrieve the page. This
can be slower than a read and a write to expanded storage.

> > Do the host states even really need visibility to the guest at all?  It 
> > may be useful for the guest to be able to distinguish between Ur and Uz 
> > but it doesn't seem necessary.
> 
> Well, you implicitly see the hypervisor state.  If you touch a [UV]z 
> page then you get a fault telling you that the page has been taken away 
> from you (I think).  And it would definitely help with debugging (seems 
> likely there's lots of scope for race conditions if you prematurely tell 
> the hypervisor you don't need the page any more...).

You get an addressing exception if you touch a Uz page. This indicates a
BUG in the Linux code because this is a use after free. If the guests
touches a Vz page you get a discard fault.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
