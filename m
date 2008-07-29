Return-Path: <linux-kernel-owner+w=401wt.eu-S1756501AbYG2IrG@vger.kernel.org>
Date: Tue, 29 Jul 2008 10:45:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 02/15] kmsg: Kernel message catalog script.
Message-ID: <20080729084536.GA29659@uranus.ravnborg.org>
References: <20080728175355.734299984@de.ibm.com> <20080728175511.260174666@de.ibm.com> <20080728192828.GA11431@uranus.ravnborg.org> <1217320950.10259.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1217320950.10259.15.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 29, 2008 at 10:42:30AM +0200, Martin Schwidefsky wrote:
> On Mon, 2008-07-28 at 21:28 +0200, Sam Ravnborg wrote:
> > > 
> > > The kmsg man page creation is invoked with "make K=2" and reads the source
> > > files for all built objects, looks up the message description and writes
> > > a man page to $(objtree)/man.
> > Can we use M=2 instead of K=?
> > I have sort of reserved 'K' for Kconfig usage.
> 
> Ok, K= is taken but I can't use M= either because that is used for KBUILD_EXTMOD.
> If tested with D= for "documentation", would that be okay ?

D sounds fine with me.

Dunno what drugs I was on when I suggested M :-(

	Sam
