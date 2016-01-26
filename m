Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 15:18:55 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH/RFC] mm/debug_pagealloc: enable it by default
Message-ID: <20160126061854.GA28254@js1304-P5Q-DELUXE>
References: <1453463080-84320-1-git-send-email-borntraeger@de.ibm.com>
 <20160125064151.GA22557@js1304-P5Q-DELUXE>
 <56A5DB21.2090300@de.ibm.com>
 <20160125192210.GA20919@codemonkey.org.uk>
 <20160125193820.GA22444@codemonkey.org.uk>
 <56A67CDC.6080906@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A67CDC.6080906@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org, peterz@infradead.org, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 25, 2016 at 08:51:56PM +0100, Christian Borntraeger wrote:
> On 01/25/2016 08:38 PM, Dave Jones wrote:
> >  Content preview:  On Mon, Jan 25, 2016 at 02:22:10PM -0500, Dave Jones wrote:
> >     > > A default mode would be ok for me as it makes things obvious. Will send
> >     > > a patch. > > The messaging around changing a default like this was really
> >     poor. > When we do behaviour changes like this, we typically rename the CONFIG
> >     option > to make it obvious that things aren't as they used to be. [...] 
> > 
> >  Content analysis details:   (-2.9 points, 5.0 required)
> > 
> >   pts rule name              description
> >  ---- ---------------------- --------------------------------------------------
> >  -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
> >  -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
> >                              [score: 0.0000]
> > X-ZLA-Header: unknown; 0
> > X-ZLA-DetailInfo: BA=6.00004114; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000; ZH=6.00000000; ZP=6.00000000; ZU=6.00000002; UDB=6.00294159; UTC=2016-01-25 19:38:24
> > x-cbid: 16012519-0041-0000-0000-0000074865D5
> > X-IBM-ISS-SpamDetectors: Score=0.40962; FLB=0; FLI=0; BY=0; FL=0; FP=0; FZ=0;
> >  HX=0; KW=0; PH=0; RB=0; SC=0.40962; ST=0; TS=0; UL=0; ISC=
> > X-IBM-ISS-DetailInfo:  BY=3.00004831; HX=3.00000240; KW=3.00000007;
> >  PH=3.00000004; SC=3.00000137; SDB=6.00650474; UDB=6.00294159; UTC=2016-01-25
> >  19:38:24
> > X-TM-AS-MML: disable
> > 
> > On Mon, Jan 25, 2016 at 02:22:10PM -0500, Dave Jones wrote:
> > 
> >  >  > A default mode would be ok for me as it makes things obvious. Will send
> >  >  > a patch.
> >  > 
> >  > The messaging around changing a default like this was really poor.
> >  > When we do behaviour changes like this, we typically rename the CONFIG option
> >  > to make it obvious that things aren't as they used to be.
> > 
> > Looking at this closer, shouldn't the original diff to make this runtime
> > have also changed the x86 implementation details in arch/x86/mm/pageattr.c ?
> > Even when we don't boot with the enable flag, we're doing the "split 2M page into 4Ks"
> > thing.  It looks like a s/debug_pagealloc/debug_pagealloc_enabled()/ might
> > do the right thing maybe ?
> 
> I have some patches ready, that fix the identity mapping for s390 and x86. sparc
> is hard to do as it allocates the TSB very early. Will send around what I have soon.

Thanks for taking care of this.

I searched other sites using "#ifdef CONFIG_DEBUG_PAGEALLOC" and found
that we can do more. Maybe, powerpc and tile also can get benefit from such
a change. And, could you handle vmap_debug_free_range() and
get_freepointer_safe(), too?

And, when debug_pagealloc is disabled, it's better not to print
DEBUG_PAGEALLOC in some error logs.

Thanks.
