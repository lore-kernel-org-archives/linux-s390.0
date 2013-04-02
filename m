From: Fengguang Wu <fengguang.wu@intel.com>
Date: Tue, 02 Apr 2013 13:02:53 +0000
Subject: Re: sound/pci/lx6464es/lx6464es.c:557:2: error: implicit declaration of function 'ioport_unmap'
Message-Id: <20130402130253.GA9127@localhost>
In-Reply-To: <20130402103101.GA4118@osiris>
References: <20130402103101.GA4118@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 02, 2013 at 12:31:01PM +0200, Heiko Carstens wrote:
> On Tue, Apr 02, 2013 at 10:35:21AM +0200, Takashi Iwai wrote:
> > At Fri, 29 Mar 2013 12:29:11 +0100,
> > Tim Blechmann wrote:
> > > 
> > > hi,
> > > >    sound/pci/lx6464es/lx6464es.c:556:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
> > > i'm not really familiar with the s390 architecture. are the specific
> > > functions declared in a different header or are they not available at
> > > all? in the second case, i'd suggest to disable this driver on this
> > > architecture, as it seems highly unlikely that anyone is going to use
> > > this hardware on this architecture (it would not surprise me, if i'm the
> > > only user of this hardware on linux)
> > 
> > Heiko's patch added already the dependency on CONFIG_HAS_IOPORT in
> > sound/pci/Kconfig (commit 262d62eb), and I thought this should have
> > fixed the issue.
> > 
> > Heiko, could you check it again?
> 
> Yes, all is fine. It seems to be a bug in Fengguang's bisect script that
> caused a couple of false positives.

Yeah, sorry for the noise!  I cannot reproduce the problem, either.

Thanks,
Fengguang
