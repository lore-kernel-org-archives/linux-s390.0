Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 8 Nov 2016 09:21:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: remove unneeded dependency for gen_facilities
In-Reply-To: <20161108074528.GB3528@osiris>
References: <1478570147-30873-1-git-send-email-yamada.masahiro@socionext.com>
        <20161108074528.GB3528@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161108092144.48efba1f@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-s390@vger.kernel.org, Paul Bolle <pebolle@tiscali.nl>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 8 Nov 2016 08:45:28 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Tue, Nov 08, 2016 at 10:55:47AM +0900, Masahiro Yamada wrote:
> > The dependency between the object and the source is handled by
> > scripts/Makefile.host, so only "hostprogs-y += gen_facilities"
> > is fine.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> >  arch/s390/tools/Makefile | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> > index 6d9814c..4b5e1e4 100644
> > --- a/arch/s390/tools/Makefile
> > +++ b/arch/s390/tools/Makefile
> > @@ -9,7 +9,5 @@ define filechk_facilities.h
> >  	$(obj)/gen_facilities
> >  endef
> >  
> > -$(obj)/gen_facilities.o: $(srctree)/arch/s390/tools/gen_facilities.c
> > -
> >  include/generated/facilities.h: $(obj)/gen_facilities FORCE
> >  	$(call filechk,facilities.h)
> 
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Martin, can you pick this one up too, please?

Done.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
