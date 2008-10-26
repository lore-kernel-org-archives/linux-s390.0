Return-Path: <linux-kernel-owner+w=401wt.eu-S1752679AbYJZSgU@vger.kernel.org>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org>
References: <1224168620.9617.14.camel@localhost>
	 <1224230354.4631.1.camel@localhost>
	 <20081021092148.GB4980@osiris.boeblingen.de.ibm.com>
	 <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org>
	 <20081023210446.GA12003@osiris.boeblingen.de.ibm.com>
	 <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org>
Content-Type: text/plain
Date: Sun, 26 Oct 2008 20:26:35 +0100
Message-Id: <1225049195.14057.72.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-10-23 at 14:37 -0700, Linus Torvalds wrote:
> On Thu, 23 Oct 2008, Heiko Carstens wrote:
> > The whole point of the patch set is to add documentation for kernel
> > messages that are emitted via printk. The documentation is supposed to
> > help a sys admin to help understand what went wrong.
> 
> I'm still not convinced.

Too bad, let me try. For me there are three aspects to the kernel
messages: the user view, the developers task and what the distributions
have to do with the kernel package.
1) The user view is simple: they see a message on the console, go "wtf?"
and want to know more about the meaning of the message. Our aim is to
tag each message so that the user can cut-copy-paste the message id on a
call to 'man' and find the description which is hopefully useful.
2) The developers task should be as simple as possible. With the current
patches the best case is that the only code changed required is to add
the KMSG_COMPONENT #define to each source file of the driver. This is
the case if the driver exclusively uses the dev_xxx printk macros. If
other printks calls are used as well they should be replaced by the
kmsg_xxx macros. The next step is to do a "make D=1" and the blueprint
of all missing message descriptions is written to stdout. To write the
descriptions is naturally the tedious part, but that can not be helped.
We found with our s390 drivers that the need to provide the message
description actually improved the quality of the message because a lot
of crud has been removed.
3) For each kernel package that comes with the distribution an
additional binary package is supposed to be created from the kernel
source packages. The build rule is a "make D=2" and the install step
copies the man pages generated for this particular kernel build into a
seperate binary package. This way the man pages for the kernel message
will always be consistent with the binary kernel that is running on the
machine.

> > Please note that this was initially an s390 only patch set but we moved
> > the infrastructure to generic code since it looks like others want a
> > facility like this too. iirc Andrew requested the move.
> 
> I do agree that it makes no sense as a s390 feature, but quite frankly, 
> I don't think it makes sense AT ALL. It introduces the notion of fixed 
> messages and people now suddenly need to worry about the hashes of the 
> contents etc. Exactly the kind of thing that I don't personally EVER want 
> to see, and certainly not inside the kernel.

Does it? The developers do need to worry about the text of the message
and the actual meaning of the message, no? If the semantics of a message
is changed the description has to change as well. The hash automatically
changes with the text so you won't get stale message descriptions for
modified messages. The next "make D=1" will find that the message lost
its description. The only text change that are "dangerous" are typo
fixes. The connection between the message and the description gets lost
but the description is actually still valid.

> If somebody really wants this, I seriously believe it would be better done 
> as a separate out-of-kernel package. Because I don't think it's worth 
> maintaining those hashed translations in-kernel, and I'm nto going to ask 
> people to even bother.

There is no question that there are people using Linux on s390 who want
these message descriptions, for them they are valuable. We are not
talking about message translations though, only plain english
explanations about what the message is all about.

> But if it's in-kernel, other people are then going to complain about them 
> not being maintained. And quite frankly, I'm neither willing nor 
> interested in hearing those complaints or making them more "valid".

The usual answer to complaints of this sort is "send a patch", isn't it?
To write a message description is not rocket science, to spot slightly
changed messages where the description needs an update isn't hard as
well, the kmsg-doc script will tell you which messages lack a
description and then it is a simple grep.
As for the "don't bother me" reaction, you are not alone with that. As a
developer I am not interested in the message description, the source
code is good enough for me. But for a user who is not a developer things
are definitly different.

> So please keep the kernel message catalog external. Or try to convince me. 
> But don't send me a "please pull" without any explanation or any relevant 
> convincing argument.

Hmm, for s390 we can certainly keep the message catalog external as
there are not many device drivers who will be using the feature. I can
easily include the "make D=1" in my daily patch monkey business. But I
would like to get the code changes upstream.
For general use I do think that we need to have the message catalog in
the kernel tree to keep it consistent.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
