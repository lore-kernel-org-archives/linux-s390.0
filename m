Return-Path: <linux-kernel-owner+w=401wt.eu-S1752518AbYJ0QNO@vger.kernel.org>
Date: Mon, 27 Oct 2008 09:10:56 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
In-Reply-To: <20081027160359.37db885c@lxorguk.ukuu.org.uk>
Message-ID: <alpine.LFD.2.00.0810270906520.3386@nehalem.linux-foundation.org>
References: <1224168620.9617.14.camel@localhost> <1224230354.4631.1.camel@localhost> <20081021092148.GB4980@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org> <20081023210446.GA12003@osiris.boeblingen.de.ibm.com>
 <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org> <1225049195.14057.72.camel@localhost> <alpine.LFD.2.00.0810261212290.5200@nehalem.linux-foundation.org> <1225101688.15777.6.camel@localhost> <alpine.LFD.2.00.0810270750100.3386@nehalem.linux-foundation.org>
 <20081027160359.37db885c@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On Mon, 27 Oct 2008, Alan Cox wrote:
>
> > And as for the actual explanations: either they need to be totally outside 
> > the kernel (in a project of their own), or they'd need to be "kernel-doc" 
> > style things that are _in_ the source code. Not in Documentation/. Not 
> > separate from the printk() that they are associated with.
> 
> You really don't want 32 languages in mixed left/right rendering with
> multiple fonts in your kernel source. At least not with most editing and
> viewing tools....

I do agree. Another issue is that quite often the actual line to be 
printed is likely fairly short, and often in an error path (so it's 
indented and in an inconvenient place), but the explanation - even for a 
_single_ language - may well be pretty involved and long.

Which is why I think for something like this, it really needs to be 
entirely outside. Because putting it inside the kernel simply isn't going 
to result in anything really useful. Either it can be close to the message 
and be updated reasonably (never mind that if we really do support 
multiple languages, that's not going to happen anyway, even if it's 
close), or it's going to be somewhere else and not be updated when changes 
happen - and then it migth as well be a separate project.

The 'separate project' is especially appropriate since any parsing won't 
be done by the kernel anyway, but by some ksyslog thing.

			Linus
