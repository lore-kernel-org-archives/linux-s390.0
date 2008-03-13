Return-Path: <linux-kernel-owner+w=401wt.eu-S1755570AbYCMQzz@vger.kernel.org>
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <47D953AB.1030901@goop.org>
References: <20080312132132.520833247@de.ibm.com>
	 <20080312132704.474209626@de.ibm.com>	<47D802A2.1030406@goop.org>
	 <1205339285.8851.13.camel@localhost>	<47D8085E.9030701@goop.org>
	 <1205341164.8851.44.camel@localhost>	<47D81771.5070400@goop.org>
	 <47D8373C.40105@codemonkey.ws>	<47D840E3.5090902@goop.org>
	 <47D8436F.9080901@codemonkey.ws>  <47D84CEB.6050300@goop.org>
	 <1205401508.26537.37.camel@localhost> <47D95134.6030503@goop.org>
	 <47D953AB.1030901@goop.org>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 17:55:38 +0100
Message-Id: <1205427338.5920.12.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: akpm@osdl.org, linux-s390@vger.kernel.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Anthony Liguori <anthony@codemonkey.ws>, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-03-13 at 09:17 -0700, Jeremy Fitzhardinge wrote:
> Jeremy Fitzhardinge wrote:
> > Martin Schwidefsky wrote:
> >> Vz->Vr cannot happen. This would be a bug in the host.
> >>   
> >
> > Does that mean that Vz is effectively identical to Uz? 
> 
> Hm, on further thought:
> 
> If guests writes to Vz pages are disallowed, then the only way out of Vz 
> is if the guest sets it to something else (Uz,Sz).  If so, what's the 
> point of using that state?  Why not make:
>
>     Vr -> Uz      host discard
>     Pr -> Uz      host discard clean
>     Sp -> Uz      set volatile
>     Uz -> Uz      set volatile

Vz is the page discarded state. The difference to Uz is slim, both
states will cause a program check on access. Vz generates a discard
fault, Uz generates an addressing exception which is nice for debugging.
But I don't see a reason why an implementation that uses Uz instead of
Vz shouldn't work.

> But given how you've described V-state pages, I really would expect 
> writes to a Vz to work, or alternatively, all writes to V-state pages to 
> be disallowed.  Are there any real uses for a writable Vr page?

You mean in the section that speaks about the guests states S/U/V/P ?
Always keep in mind that you can access a V/P page only until it gets
discarded. Then the useful content of the page frame is lost and any
read of write to the not Vz page will be answered with a discard fault.

A Vr page is read-only. If a page gets mapped for writing it needs to
get into the Pr state. This is the hint for the host to look at the
dirty bit before it discards a page.
So yes, there is no use for a writable Vr page.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
