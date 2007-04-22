Return-Path: <linux-kernel-owner+w=401wt.eu-S1754173AbXDVJrT@vger.kernel.org>
From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
Date: Sun, 22 Apr 2007 11:46:11 +0200
References: <20070420113505.GH3738@skybase> <200704220119.32729.arnd@arndb.de> <1177228423.8046.5.camel@localhost>
In-Reply-To: <1177228423.8046.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704221146.11439.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Sunday 22 April 2007 09:53, Martin Schwidefsky wrote:
> On Sun, 2007-04-22 at 01:19 +0200, Arnd Bergmann wrote:
> > > diff -urpN linux-2.6/drivers/ssb/Kconfig linux-2.6-patched/drivers/ssb/Kconfig
> > > --- linux-2.6/drivers/ssb/Kconfig       2007-04-19 15:24:40.000000000 +0200
> > > +++ linux-2.6-patched/drivers/ssb/Kconfig       2007-04-19 15:55:44.000000000 +0200
> > > @@ -1,4 +1,5 @@
> > >  menu "Sonics Silicon Backplane"
> > > +       depends on PCI || PCMCIA
> > 
> > No, this doesn't look right. There are other devices that come with
> > SiliconBackplane but are not PCI or PCMCIA style devices.
> 
> Yes, Michael already told me about that. The current solution is to use
> !S390, could we use HAS_IOMEM instead ?

I'd think either should be fine.

-- 
Greetings Michael.
