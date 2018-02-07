Return-Path: <schwidefsky@de.ibm.com>
Date: Wed, 7 Feb 2018 12:49:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 4/6] s390: add options to change branch prediction
 behaviour for the kernel
In-Reply-To: <20180207100252.GA31392@amd>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
	<1517986811-27819-5-git-send-email-schwidefsky@de.ibm.com>
	<20180207100252.GA31392@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180207124935.46406c60@mschwideX1>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 7 Feb 2018 11:02:52 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2018-02-07 08:00:09, Martin Schwidefsky wrote:
> > Add the PPA instruction to the system entry and exit path to switch
> > the kernel to a different branch prediction behaviour. The instructions
> > are added via CPU alternatives and can be disabled with the "nospec"
> > or the "nobp=0" kernel parameter. If the default behaviour selected
> > with CONFIG_KERNEL_NOBP is set to "n" then the "nobp=1" parameter can be
> > used to enable the changed kernel branch prediction.
> > 
> > Acked-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > ---
> >  arch/s390/Kconfig                 | 17 ++++++++++++++
> >  arch/s390/include/asm/processor.h |  1 +
> >  arch/s390/kernel/alternative.c    | 23 +++++++++++++++++++
> >  arch/s390/kernel/early.c          |  2 ++
> >  arch/s390/kernel/entry.S          | 48 +++++++++++++++++++++++++++++++++++++++
> >  arch/s390/kernel/ipl.c            |  1 +
> >  arch/s390/kernel/smp.c            |  2 ++
> >  7 files changed, 94 insertions(+)
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 0105ce2..d514e25 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -540,6 +540,23 @@ config ARCH_RANDOM
> >  
> >  	  If unsure, say Y.
> >  
> > +config KERNEL_NOBP
> > +	def_bool n
> > +	prompt "Enable modified branch prediction for the kernel by default"
> > +	help
> > +	  If this option is selected the kernel will switch to a modified
> > +	  branch prediction mode if the firmware interface is available.
> > +	  The modified branch prediction mode improves the behaviour in
> > +	  regard to speculative execution.
> > +
> > +	  With the option enabled the kernel parameter "nobp=0" or "nospec"
> > +	  can be used to run the kernel in the normal branch prediction mode.
> > +
> > +	  With the option disabled the modified branch prediction mode is
> > +	  enabled with the "nobp=1" kernel parameter.
> > +
> > +	  If unsure, say N.
> > +  
> 
> This could use some improvement.
> 
> Afaict the config option only changes the default behaviour? Do we
> need the option in such case? (CONFIG_CMDLINE_APPEND can be useful to
> avoid some options).

# git grep CMDLINE_APPEND

returns nothing. What are you referring to?

The idea of this config option is that a distributor can decide what
default behaviour the system should have if no command line parameter
is specified.
 
> Plus, it is not clear what "modified branch prediction mode is" and if
> "improves behaviour" means "faster" or "safer".

Naturally "improves behaviour in regard to speculative execution" is
indicating that the system is safer. In general that means slower as well
but as always it depends. What exactly is done is up to the machine.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
