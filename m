Return-Path: <linux-kernel-owner+w=401wt.eu-S1752614AbYJ0Pzz@vger.kernel.org>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
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
Content-Type: text/plain
Date: Mon, 27 Oct 2008 16:52:06 +0100
Message-Id: <1225122726.15777.42.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-10-27 at 08:05 -0700, Linus Torvalds wrote:
> 
> On Mon, 27 Oct 2008, Martin Schwidefsky wrote:
> > 
> > Ok, understood. Not that the reaction surprises me, seems like nobody
> > likes documentation (including me).
> 
> It's that I don't like out-of-line documentation. It's a damn pain to 
> maintain, and it's _especially_ so when it's for small details rather than 
> "big picture" issues.

Yes, indeed. The farther away the documentation is from the source code
the harder it will be to maintain. That is why I would like to see it in
the linux source tree.

> I also consider this to be _exactly_ the same issue as translating kernel 
> messages into another language (which people have also wanted to do), 
> except the "other language" is a S390-specific "odd-speak" rather than a 
> real language.

The message tag would be the way to find the translation in some
database from the plain english output you'll find on the screen.

> I have to say that I also dislike the technical implementation. I don't 
> like having yet another printk() wrapper - your "kmsg_warn()" won't play 
> well with people who have messages they want to print, but that use helper 
> routines - or then you'd need to essentially change _every_ printk to a 
> kmsg_xyz(). 

Today I've replaced kmsg_xyz() with pr_xyz(). The current code now plays
tricks with two families of printk macros: dev_xyz() and pr_xyz().
If you ask Greg every device driver should be using dev_xyz() for its
printks anyway..

> So if you want to have a hash (so that you can identify the _format_ 
> string rather than the printed out message), I personally think you'd be 
> better off thinking of it purely the same way as CONFIG_PRINTK_TIME, and 
> just have a config option that disables or enables the hashing of the 
> format string, the same way we have an option for disabling or enabling of 
> the timestamping of the printk.

In that case ALL printk messages would suddenly grow a hash. Which
precludes the use of the component name as part of the message since we
would need to add a component name for every single printk - that won't
happen.
Without a component name we are forced to use a larger number of bits
for the hash to avoid collisions. For 10,000 printks and a 32 bit hash
the likelyhood of a collision is already bigger than 2%, so we'd need
something bigger than 32 bit. With a component name in addition to the
hash you can split the printks into groups which greatly reduces the
danger of a collision.

> I also suspect that it would be better to not _print_ it, but only put it 
> into the dmesg logs (the same way we do with the urgency level marker).
> 
> IOW, I think we could put a few lines of code in "vprintk" that just 
> hashes ove 'fmt' and then adds that to the output.

A dev_xyz() message would then look like this:

<level> <hash>: <driver-name> <device-name>: <the message text>

The prefix is rather lengthy, no ?

> And as for the actual explanations: either they need to be totally outside 
> the kernel (in a project of their own), or they'd need to be "kernel-doc" 
> style things that are _in_ the source code. Not in Documentation/. Not 
> separate from the printk() that they are associated with.

The kmsg comments are already formatted in the kernel-doc style and you
can put the comment anywhere in the source file that contains the
printk. The Documentation/ is an extra path where the script looks for
the comments. I can easily drop that part. So yes, the concept is that
you can keep the message comment close to the printk.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
