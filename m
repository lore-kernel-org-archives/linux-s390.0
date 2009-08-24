Return-Path: <linux-kernel-owner+w=401wt.eu-S1752576AbZHXNx7@vger.kernel.org>
Date: Mon, 24 Aug 2009 15:53:44 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [GIT PULL] s390 patches for v2.6.31-rc7
Message-ID: <20090824135344.GC4639@cetus.boeblingen.de.ibm.com>
References: <20090823213714.11757b14@skybase> <20090823201526.GA30461@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090823201526.GA30461@wavehammer.waldi.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Bastian,

thanks for your feedback.

On Sun, Aug 23, 2009 at 10:15:26PM +0200, Bastian Blank wrote:
> On Sun, Aug 23, 2009 at 09:37:14PM +0200, Martin Schwidefsky wrote:
> > +static void __init set_preferred_console(void)
> > +{
> > +	if (MACHINE_IS_KVM) {
> > +		add_preferred_console("hvc", 0, NULL);
> > +		s390_virtio_console_init();
> > +		return;
> > +	}
> 
> Why this early return instead of else if as all options are mutually
> exclusive? Also why do you init the virtio console here instead of an
> console_initcall?
This is a bug fix to set the respective preferred console device for
conmode=3270. To make as few changes as possible for -rc7, the console
initialization for kvm has been moved to the new function.

You are right that s390_virtio_console_init() should be called from a 
console_initcall().  I started working on another patch to solve this
issue for the next kernel release.

Best regards,
  Hendrik
