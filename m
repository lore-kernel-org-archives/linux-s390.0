Return-Path: <linux-kernel-owner+w=401wt.eu-S1754918AbYCMJp1@vger.kernel.org>
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <47D84CEB.6050300@goop.org>
References: <20080312132132.520833247@de.ibm.com>
	 <20080312132704.474209626@de.ibm.com>	<47D802A2.1030406@goop.org>
	 <1205339285.8851.13.camel@localhost>	<47D8085E.9030701@goop.org>
	 <1205341164.8851.44.camel@localhost>	<47D81771.5070400@goop.org>
	 <47D8373C.40105@codemonkey.ws>	<47D840E3.5090902@goop.org>
	 <47D8436F.9080901@codemonkey.ws>  <47D84CEB.6050300@goop.org>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 10:45:08 +0100
Message-Id: <1205401508.26537.37.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Anthony Liguori <anthony@codemonkey.ws>, akpm@osdl.org, linux-s390@vger.kernel.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 14:36 -0700, Jeremy Fitzhardinge wrote:
> Anthony Liguori wrote:
> >> Vp should never happen, since you'd never preserve a V page.  And 
> >> surely it would be Pr -> Sr, since the hypervisor wouldn't push the 
> >> page to backing store when you change the client state.
> >>     
> >
> > You're right, I meant Vp/Pp but they are invalid states.  I think one of 
> > the things that keeps tripping me up is that the host can change both 
> > the host and guest page states.  My initial impression was that the host 
> > handled the host state and the guest handled the guest state.
> >   
> 
> Yes.  And it seems to me that you get unfortunate outcomes if you have a 
> Pr->Vz->Vr transition.

Vz->Vr cannot happen. This would be a bug in the host.

> > I was thinking that it may be useful to know a Ur verses a Uz when 
> > allocating memory.  In this case, you'd rather allocate Ur pages verses 
> > Uz to avoid the fault.  I don't read s390 arch code well, is the host 
> > state explicit to the guest?
> >   
> 
> Yes, reusing Ur pages might well be better, but who knows - they've 
> probably got an instruction which makes Uz cheap...

Yes, faulting in a Uz page is cheap on s390. Isn't it a lovely
architecture :-)

> Stuff like this suggets that both parts of the state are packed 
> together, and are guest-visible:
> 
> +	return (state & ESSA_USTATE_MASK) == ESSA_USTATE_VOLATILE &&
> +		(state & ESSA_CSTATE_MASK) == ESSA_CSTATE_ZERO;
> 

Yes, the return value of the ESSA instruction has both the guest state
and the host state.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
