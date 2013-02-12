Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Feb 2013 10:40:11 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: Add missing PAGE_SHARED as an alias for PAGE_RW
Message-ID: <20130212094011.GB4232@osiris>
References: <1360432485-25726-1-git-send-email-geert@linux-m68k.org>
 <20130211091109.GA3890@osiris>
 <CAMuHMdWm+VfBFN8fqL+Nkt7h5-+xv5EeeknhtkroAk4FhiRMnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWm+VfBFN8fqL+Nkt7h5-+xv5EeeknhtkroAk4FhiRMnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 12, 2013 at 10:20:22AM +0100, Geert Uytterhoeven wrote:
> Hi Heiko,
> 
> On Mon, Feb 11, 2013 at 10:11 AM, Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > Thanks Geert. A similar patch however is already in linux-next, together
> > with a whole bunch of other patches which try to make s390's allmodconfig
> > compile again after PCI, HAS_DMA and HAS_IOMEM got enabled by our new PCI
> > code.
> 
> Cool!
> 
> Will you select HAVE_GENERIC_HARDIRQS soon, too?

I discussed that just with Martin, and looking at the code it doesn't look
like we want to have GENERIC_HARDIRQS.
If we would select that option it looks like we need to special case the
common generic hardirqs code quite a lot, which is something we certainly
do not want.
However that's our result after looking 5 minutes into the code ;)
So, if at all, it's not going to happen soon.
