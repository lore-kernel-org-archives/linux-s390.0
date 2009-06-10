Return-Path: <linux-kernel-owner+w=401wt.eu-S1758522AbZFJJso@vger.kernel.org>
Date: Wed, 10 Jun 2009 11:48:09 +0200
From: Hans-Joachim Picht <hans@linux.vnet.ibm.com>
Subject: Re: [patch 05/38] s390: hibernation support for s390
Message-ID: <20090610114809.2c96d243@blc4eb509856389.ibm.com>
In-Reply-To: <20090609195903.GB1388@ucw.cz>
References: <20090604161847.513682672@de.ibm.com>
	<20090604161900.659762303@de.ibm.com>
	<20090608064451.GD1444@ucw.cz>
	<20090609153402.58e6b841@blc4eb509856389.ibm.com>
	<20090609195903.GB1388@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Jun 2009 21:59:03 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > > > +/*
> > > > + * save CPU registers before creating a hibernation image and
> > > > before
> > > > + * restoring the memory state from it
> > > > + */
> > > > +void save_processor_state(void)
> > > > +{
> > > > +}
> > > > +
> > > > +/*
> > > > + * restore the contents of CPU registers
> > > > + */
> > > > +void restore_processor_state(void)
> > > > +{
> > > > +}
> > > 
> > > ...and explaining why the functions can be emmpty would be nice.
> > 
> > I integrated the code for this in the assembly backend in the
> > swsusp_arch_suspend & swsusp_arch_resume functions.
> 
> I guessed so. Maybe it is worth a comment?

Sure ;-)
