Return-Path: <linux-kernel-owner+w=401wt.eu-S1755837AbYBSPmA@vger.kernel.org>
Date: Tue, 19 Feb 2008 16:41:50 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 07/13] Initialize per cpu lowcores on cpu hotplug.
Message-ID: <20080219154149.GB11599@osiris.boeblingen.de.ibm.com>
References: <20080219144047.587547541@de.ibm.com> <20080219144504.392301782@de.ibm.com> <20080219151355.GA24547@wavehammer.waldi.eu.org> <20080219153855.GA11599@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080219153855.GA11599@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bastian Blank <bastian@waldi.eu.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 19, 2008 at 04:38:56PM +0100, Heiko Carstens wrote:
> On Tue, Feb 19, 2008 at 04:13:55PM +0100, Bastian Blank wrote:
> > On Tue, Feb 19, 2008 at 03:40:54PM +0100, Martin Schwidefsky wrote:
> > > +	/*
> > > +	 * Only need to copy the first 512 bytes from address 0. But since
> > > +	 * the compiler emits a warning if src == NULL for memcpy use copy_page
> > > +	 * instead. Copies more than needed but this code is not performance
> > > +	 * critical.
> > > +	 */
> > > +	copy_page(lowcore, &S390_lowcore);
> > 
> > Boah, workaround alert. Why do you not fix the compiler?
> 
> We need to copy from address 0 (that's where the lowcore resides). But gcc
> insists to complain if memcpy is used with src == NULL.. Now what?

Erm sorry, misread your question. Usually it's a bug to use memcpy with
src == NULL. In this case it's ok. So I think it's perfectly ok if gcc
emits a warning.
If you know of a better way to get around this please let me know.
