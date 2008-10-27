Return-Path: <linux-kernel-owner+w=401wt.eu-S1752731AbYJ0Qf6@vger.kernel.org>
Date: Mon, 27 Oct 2008 16:35:18 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
Message-ID: <20081027163518.50b6ddfb@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.LFD.2.00.0810270906520.3386@nehalem.linux-foundation.org>
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
	<20081027160359.37db885c@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.00.0810270906520.3386@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> Which is why I think for something like this, it really needs to be 
> entirely outside. Because putting it inside the kernel simply isn't going 
> to result in anything really useful. Either it can be close to the message 
> and be updated reasonably (never mind that if we really do support 
> multiple languages, that's not going to happen anyway, even if it's 
> close), or it's going to be somewhere else and not be updated when changes 
> happen - and then it migth as well be a separate project.

Small bits of it have to be inside the kernel
- Markup (_("Hello") To extract the strings)
- To format the data in a way that can be recovered by ksyslogd and
translated.

Alan
