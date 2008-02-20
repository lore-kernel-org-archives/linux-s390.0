Return-Path: <linux-kernel-owner+w=401wt.eu-S1762079AbYBTKZH@vger.kernel.org>
Date: Wed, 20 Feb 2008 11:24:30 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 07/13] Initialize per cpu lowcores on cpu hotplug.
Message-ID: <20080220102430.GB12635@osiris.boeblingen.de.ibm.com>
References: <20080219144047.587547541@de.ibm.com> <20080219144504.392301782@de.ibm.com> <20080219151355.GA24547@wavehammer.waldi.eu.org> <20080219153855.GA11599@osiris.boeblingen.de.ibm.com> <20080219154149.GB11599@osiris.boeblingen.de.ibm.com> <0d276daad249ac20ae922f4aa9a6e88b@kernel.crashing.org> <20080220094552.GA12635@osiris.boeblingen.de.ibm.com> <20080220100933.GA20162@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080220100933.GA20162@wavehammer.waldi.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bastian Blank <bastian@waldi.eu.org>, Segher Boessenkool <segher@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 20, 2008 at 11:09:33AM +0100, Bastian Blank wrote:
> On Wed, Feb 20, 2008 at 10:45:52AM +0100, Heiko Carstens wrote:
> > -	copy_page(lowcore, &S390_lowcore);
> > +	memcpy(lowcore, &S390_lowcore, 512);
> 
> Okay
> 
> >  	memset((void *)lowcore + 512, 0, sizeof(*lowcore) - 512);
> 
> Not completely okay. void pointer are not allowed in arithmetic. gcc
> handles void * as char * in this case, but I think it should usualy be
> avoided.

There are many places all over the kernel that assume sizeof(void) == 1.
That's yet another gcc extension we use... but I'm going to change that
to a char * cast anyway.

Thanks for commenting!
