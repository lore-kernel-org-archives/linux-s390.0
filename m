Return-Path: <linux-kernel-owner+w=401wt.eu-S1754594AbYCMJrX@vger.kernel.org>
Subject: Re: [patch 0/6] Guest page hinting version 6.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200803130941.48480.rusty@rustcorp.com.au>
References: <20080312132132.520833247@de.ibm.com>
	 <200803130941.48480.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 10:47:07 +0100
Message-Id: <1205401627.26537.40.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-03-13 at 09:41 +1100, Rusty Russell wrote:
> On Thursday 13 March 2008 00:21:32 Martin Schwidefsky wrote:
> > My question now is how to proceed with the code. I sure
> > would love to see the code going upstream some day but that depends on
> > the mm developers as the code adds complexity that needs to be supported.
> 
> Well, I want this feature, but I agree about complexity.
> 
> AFAICT, the trivial subset of this is the hinting of Unused pages.  It seems 
> that would buy us something, and perhaps be a stepping stone to full page 
> hinting?

I've been there but the unused page thing is so small that it doesn't
make sense to separate it from the patches. If I don't see any progress
then I will come up with a patch that adds the Unused state transitions
to the arch files of s390.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
