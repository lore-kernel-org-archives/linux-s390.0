Return-Path: <linux-kernel-owner+w=401wt.eu-S1752825AbYJ0QFb@vger.kernel.org>
Date: Mon, 27 Oct 2008 16:03:59 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
Message-ID: <20081027160359.37db885c@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.LFD.2.00.0810270750100.3386@nehalem.linux-foundation.org>
References: <1224168620.9617.14.camel@localhost>
	<1224230354.4631.1.camel@localhost>
	<20081021092148.GB4980@osiris.boeblingen.de.ibm.com>
	<alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org>
	<20081023210446.GA12003@osiris.boeblingen.de.ibm.com>
	<alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org>
	<1225049195.14057.72.camel@localhost>
	<alpine.LFD.2.00.0810261212290.5200@nehalem.linux-foundation.org>
	<1225101688.15777.6.camel@localhost>
	<alpine.LFD.2.00.0810270750100.3386@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> And as for the actual explanations: either they need to be totally outside 
> the kernel (in a project of their own), or they'd need to be "kernel-doc" 
> style things that are _in_ the source code. Not in Documentation/. Not 
> separate from the printk() that they are associated with.

You really don't want 32 languages in mixed left/right rendering with
multiple fonts in your kernel source. At least not with most editing and
viewing tools....

User space uses message catalogues and has tools for maintaining them
which make using any other format somewhat dumb. They extract strings
using _("hello") type wrappers to identify what are translatable strings
so if the kernel source has _() macros all the tooling just works and can
live outside and way from the kernel.

Just needs _() to do the right thing compiled into the kernel and a
printk formatting to do the right thing with the result. In truth you
don't even need a hash in printk just the ability to make it produce
either

	"Hello my name is 'fred3'"

and something like

	"Hello my name is '%s%d'\0Fred\0\000\000\000\003"

The kernel contains the English which should be a pretty passable hash.

Alan
