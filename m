Return-Path: <linux-kernel-owner+w=401wt.eu-S1752827AbYJ0PMp@vger.kernel.org>
Date: Mon, 27 Oct 2008 08:05:29 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
In-Reply-To: <1225101688.15777.6.camel@localhost>
Message-ID: <alpine.LFD.2.00.0810270750100.3386@nehalem.linux-foundation.org>
References: <1224168620.9617.14.camel@localhost>  <1224230354.4631.1.camel@localhost>  <20081021092148.GB4980@osiris.boeblingen.de.ibm.com>  <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org>  <20081023210446.GA12003@osiris.boeblingen.de.ibm.com>
  <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org>  <1225049195.14057.72.camel@localhost>  <alpine.LFD.2.00.0810261212290.5200@nehalem.linux-foundation.org> <1225101688.15777.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On Mon, 27 Oct 2008, Martin Schwidefsky wrote:
> 
> Ok, understood. Not that the reaction surprises me, seems like nobody
> likes documentation (including me).

It's that I don't like out-of-line documentation. It's a damn pain to 
maintain, and it's _especially_ so when it's for small details rather than 
"big picture" issues.

I also consider this to be _exactly_ the same issue as translating kernel 
messages into another language (which people have also wanted to do), 
except the "other language" is a S390-specific "odd-speak" rather than a 
real language.

I have to say that I also dislike the technical implementation. I don't 
like having yet another printk() wrapper - your "kmsg_warn()" won't play 
well with people who have messages they want to print, but that use helper 
routines - or then you'd need to essentially change _every_ printk to a 
kmsg_xyz(). 

So if you want to have a hash (so that you can identify the _format_ 
string rather than the printed out message), I personally think you'd be 
better off thinking of it purely the same way as CONFIG_PRINTK_TIME, and 
just have a config option that disables or enables the hashing of the 
format string, the same way we have an option for disabling or enabling of 
the timestamping of the printk.

I also suspect that it would be better to not _print_ it, but only put it 
into the dmesg logs (the same way we do with the urgency level marker).

IOW, I think we could put a few lines of code in "vprintk" that just 
hashes ove 'fmt' and then adds that to the output.

And as for the actual explanations: either they need to be totally outside 
the kernel (in a project of their own), or they'd need to be "kernel-doc" 
style things that are _in_ the source code. Not in Documentation/. Not 
separate from the printk() that they are associated with.

			Linus
