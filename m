Return-Path: <linux-kernel-owner+w=401wt.eu-S1752794AbYCLQ7j@vger.kernel.org>
Subject: Re: [patch 6/6] Guest page hinting: s390 support.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <47D8085E.9030701@goop.org>
References: <20080312132132.520833247@de.ibm.com>
	 <20080312132704.474209626@de.ibm.com>  <47D802A2.1030406@goop.org>
	 <1205339285.8851.13.camel@localhost>  <47D8085E.9030701@goop.org>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 17:59:24 +0100
Message-Id: <1205341164.8851.44.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 09:44 -0700, Jeremy Fitzhardinge wrote:
> Martin Schwidefsky wrote:
> > That is the first block of state transitions: {Ur,Sr,Vr,Pr}
> > You can go from any of the four states to any of the remaining three.
> >   
> 
> You only mention page_set_{unused,stable,volatile}.  Is 
> page_set_stable_if_present() the fourth.  And shouldn't that be 
> "stable_if_clean":

page_set_volatile has a "writable" argument. For writable==0 you get a
Vx page, for writable==1 you get a Px page.

With stable_if_clean you are refering to stable_if_present? If yes the
answer is that this operation is used to get a page from Vx/Px back to
Sx but only if the page has not been discarded. The operation will fail
if the page state is Vz/Pz. The dirty bit only matters for the hosts
decision to discard the page, these are the state transitions from Vr/Pr
to Vz.

>      - potential volatile (P): the page has useful content. The host system
>        is allowed to discard the content after it has checked the dirty bit
>        of the page. It has to deliver a discard fault with the absolute
>        address of the page if the guest tries to access it.
>       
> 
> The use of "stable" in the function call and "volatile" in this 
> description is a bit confusing.  My understanding is that a page in this 
> state is either stable or volatile depending on whether its dirty, which 
> makes sense, but it would be good to consistently refer to it in the 
> same way.

Your understanding is good, but how can I make this less confusing? A Px
page that is dirty may not be discarded which makes it basically stable.
The guest state still is potential volatile though as it does not have a
state of Sx.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
