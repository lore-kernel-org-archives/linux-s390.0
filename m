Return-Path: <stable-owner@vger.kernel.org>
Date: Wed, 20 Sep 2017 23:54:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] s390: Fix perf event init
Message-ID: <20170920205433.GA1955@avx2>
References: <20170920050757.22857-1-paul.burton@imgtec.com>
 <20170920085100.6adb0e0d@mschwideX1>
 <20170920121517.GE3583@osiris>
 <2025443.x60lSU25Yf@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025443.x60lSU25Yf@np-p-burton>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/stable/>
List-Post: <mailto:stable@vger.kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 20, 2017 at 09:04:38AM -0700, Paul Burton wrote:
> Hi Heiko,
> 
> On Wednesday, 20 September 2017 05:15:17 PDT Heiko Carstens wrote:
> > On Wed, Sep 20, 2017 at 08:51:00AM +0200, Martin Schwidefsky wrote:
> > > Hi Paul,
> > > 
> > > On Tue, 19 Sep 2017 22:07:57 -0700
> > > 
> > > Paul Burton <paul.burton@imgtec.com> wrote:
> > > > Commit c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
> > > > modified cpumsf_pmu_event_init() to cast the struct perf_event cpu field
> > > > to an unsigned integer before it is compared with nr_cpumask_bits. This
> > > > is broken because the cpu field may be -1 for events which follow a
> > > > process rather than being affine to a particular CPU. When this is the
> > > > case the cast to an unsigned int results in a value equal to ULONG_MAX,
> > > > which is always greater than nr_cpumask_bits so we always fail
> > > > cpumsf_pmu_event_init() and return -ENODEV.
> > > > 
> > > > The check against nr_cpumask_bits seems nonsensical anyway, so this
> > > > patch simply removes it. The cpu field is going to either be 0 or a
> > 
> > I assume you meant to write "...either be -1..."?
> 
> Indeed I did... and I wrote -1 in the MIPS patch which I then copied this 
> from, so I'm not sure how it became 0. Oops!
> 
> > > > valid CPU number. Comparing it with nr_cpumask_bits is effectively
> > > > checking that it's a valid cpu number, but it seems safe to rely on the
> > > > core perf events code to ensure that's the case.
> > 
> > Looks like you are right and the nr_cpumask_bits check is not needed. The
> > sanity check is done at the beginning of perf_event_alloc() and everything
> > else can rely on a sane cpu number (-1 or within bounds of nr_cpumask_bits).
> > > Thanks for the patch, there is indeed an issue with nr_cpumask_bits.
> > > But we already have a slightly different fix for this queued on the
> > > fixes branch of s390/linux:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=f
> > > ixes&id=fc3100d64f0ae383ae8d845989103da06d62763b
> > So we should either use your patch or remove the superfluous check with an
> > addon patch. Martin's call ;)
> 
> Glad the patch is of use either way.

First, sorry for the breakage.

Second, if you write code like this:

	if (event->cpu >= 0) {
		if ((unsigned int)event->cpu >= nr_cpumask_bits)
			return -ENODEV;

then cast is unnecessary as comparison is unsigned and non-negative
values will remain themselves.
