Return-Path: <linux-kernel-owner+w=401wt.eu-S1752777AbYJ0JMW@vger.kernel.org>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <alpine.LFD.2.00.0810261212290.5200@nehalem.linux-foundation.org>
References: <1224168620.9617.14.camel@localhost>
	 <1224230354.4631.1.camel@localhost>
	 <20081021092148.GB4980@osiris.boeblingen.de.ibm.com>
	 <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org>
	 <20081023210446.GA12003@osiris.boeblingen.de.ibm.com>
	 <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org>
	 <1225049195.14057.72.camel@localhost>
	 <alpine.LFD.2.00.0810261212290.5200@nehalem.linux-foundation.org>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 11:01:28 +0100
Message-Id: <1225101688.15777.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2008-10-26 at 12:12 -0700, Linus Torvalds wrote:
> On Sun, 26 Oct 2008, Martin Schwidefsky wrote:
> > > But if it's in-kernel, other people are then going to complain about them 
> > > not being maintained. And quite frankly, I'm neither willing nor 
> > > interested in hearing those complaints or making them more "valid".
> > 
> > The usual answer to complaints of this sort is "send a patch", isn't it?
> 
> Yes. And why don't you do all that, and not involve me at all, and keep 
> all of this entirely out of the kernel?

Ok, understood. Not that the reaction surprises me, seems like nobody
likes documentation (including me). What I will do is to replace the
kmsg_xxx macros with the pr_xxx macros in the device drivers patches and
request the pull as a cleanup for 2.6.29. The out-of-tree kmsg patches
will then play tricks with pr_xxx analog to dev_xxx. That way the patch
should be minimal.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
