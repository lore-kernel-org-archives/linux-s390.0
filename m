From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Is THREAD_INFO_IN_TASK appropriate for -mm for 4.8?
Date: Mon, 25 Jul 2016 16:26:40 +0200
Message-ID: <20160725142640.GA4337@osiris>
References: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
 <578DE406.9060902@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <578DE406.9060902@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, x86 <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 19, 2016 at 10:25:42AM +0200, Christian Borntraeger wrote:
> On 07/19/2016 01:47 AM, Andy Lutomirski wrote:
> > Hi all-
> > 
> > There are four core patches needed for the THREAD_INFO_IN_TASK thing,
> > and they apply cleanly to -mm now.  The x86 patch to flip the feature
> > on does not apply cleanly anywhere because it depends on changes in
> > -tip *and* in -mm.  I'd like to get all of this as well as the rest of
> > the vmap-stacks stuff in by 4.9, but I'm wondering if it might make
> > sense to get the core THREAD_INFO_IN_TASK stuff into -mm for 4.8
> > instead.
> > 
> > Pros:
> >  - It reduces the amount of core code that -tip will have to carry until 4.9.
> >  - It may benefit other architectures.  Christian Borntraeger
> > expressed an interest in enabling the feature for s390, but it'll be
> > awkward for him until the core bit landed.  Similarly, arm64 seems to
> > be interested.
> 
> I have not yet talked to Martin/Heiko about this, so not sure yet if and when
> s390 is going to use this - so no pressure from our side yet.

I wrote a patch four weeks ago which converts s390 based on Linus' orginal
patches. So yes, we will convert s390 as soon as this hits upstream.
