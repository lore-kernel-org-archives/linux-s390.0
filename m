Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 26 Jul 2017 09:26:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Qemu problems in -next with 's390/spinlock: add niai spinlock
 hints'
References: <20170726011451.GA24947@roeck-us.net>
 <20170726050033.GA3218@osiris>
 <20170726074044.41bdc796@mschwideX1>
 <20170726060527.GD3218@osiris>
 <20170726083100.0146e84a@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726083100.0146e84a@mschwideX1>
Message-Id: <20170726072654.GE3218@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> > > Hmm, I though that NIAI is a NOP on older machines. A runtime check for
> > > the facility bit is out of the question as the NIAI-7 gets inlined in
> > > the spin_unlock code. So yes, the only available fix is to make the
> > > NIAI hinting conditional on zEC12. Which is quite ugly as we would need
> > > an architecture level set to zEC12 for the distribution kernel to make
> > > use of NIAI.  
> > 
> > Alternatively you could generate a four-byte nop, and replace that at IPL
> > time with the needed NIAI instruction, if the facility is available. Some
> > sort of "alternative" code patching infrastructure that x86 already has.
> > Not sure if it is worth it, however...
> 
> Patching all spin_unlock inlines? There are a lot of callers for this
> function. We could think about an out-of-line spin_unlock and patch this
> single function but then we'd loose the advantage of inlining.
> I do not think it is worthwhile.
> 
> I pushed an updated patch to the features branch of s390/linux. Should
> be in linux-next tomorroy. Thanks. 

The idea would be to generate an extra section that contains the addresses
of the to be patched instructions, and how they need to be patched.  That
section, plus the code that will do the patching could reside in init
data/code sections and would be discarded after. So the additional memory
overhead after initialization would be close to zero.

However an ifdef is fine as well ;)
