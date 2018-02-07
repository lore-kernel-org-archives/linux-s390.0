Return-Path: <schwidefsky@de.ibm.com>
Date: Wed, 7 Feb 2018 12:51:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
In-Reply-To: <20180207100726.GB31392@amd>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
	<1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
	<20180207100726.GB31392@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180207125148.2c657e58@mschwideX1>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 7 Feb 2018 11:07:26 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2018-02-07 08:00:11, Martin Schwidefsky wrote:
> > Add CONFIG_EXPOLINE to enable the use of the new -mindirect-branch= and
> > -mfunction_return= compiler options to create a kernel fortified against
> > the specte v2 attack.
> > 
> > With CONFIG_EXPOLINE=y all indirect branches will be issued with an
> > execute type instruction. For z10 or newer the EXRL instruction will
> > be used, for older machines the EX instruction. The typical indirect
> > call
> > 
> > 	basr	%r14,%r1
> > 
> > is replaced with a PC relative call to a new thunk
> > 
> > 	brasl	%r14,__s390x_indirect_jump_r1
> > 
> > The thunk contains the EXRL/EX instruction to the indirect branch
> > 
> > __s390x_indirect_jump_r1:
> > 	exrl	0,0f
> > 	j	.
> > 0:	br	%r1
> > 
> > The detour via the execute type instruction has a performance impact.
> > To get rid of the detour the new kernel parameter "nospectre_v2" and
> > "spectre_v2=[on,off,auto]" can be used. If the parameter is specified
> > the kernel and module code will be patched at runtime.  
> 
> This is really unfortunate naming of kernel option.
> 
> spectre_v2=off sounds like we are turning the "bug" off, but i somehow
> suspect you are turning the bug _workaround_ off.
 
Well, that is the 1:1 copy of the x86 option. Do you want to change that
one as well?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
