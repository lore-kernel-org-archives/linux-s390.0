Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
 <20200716112840.GC8484@osiris> <your-ad-here.call-01596030682-ext-1369@work.hours>
In-Reply-To: <your-ad-here.call-01596030682-ext-1369@work.hours>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 6 Aug 2020 12:02:52 -0700
Message-ID: <CAKwvOd=1E+90VHwzh9cYGz9YKy_ECMJuK6gZhzLqBFw9kS4Cww@mail.gmail.com>
Subject: Re: linux plumbers + clang + s390 virtualized testing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jul 29, 2020 at 6:51 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> > > We were very excited to see your patches going by for enabling Clang
> > > support for s390.  Since then, we've added s390 builds to our
> > > continuous integration setup.
> > >
> > > We've been running into a few issues with doing virtualized boot tests
> > > of our kernels on s390.
> > >
> > > I was curious if you'll both be attending Linux plumbers conf?  If we
> > > carve out time for an s390+clang talk, would this be of interest to
> > > you to attend?
> I will attend and it would surely be interesting to me and other
> s390 folks. Your efforts are greatly appreciated!

Cool, so our MC has been approved:
https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#llvm-cr

But we're super tight on time and probably won't be able to do a
session on s390 at the MC.  That said, I have just submitted a BoF
proposal since we have more topics internal to our group we'd like to
have more time to discuss.  I've added s390 testing to the list of
potential topics, too.  I'll re-ping this thread once I hear back
about whether it gets approved or not.

That said, we do meet once every other week virtually online, see
links: https://clangbuiltlinux.github.io/.

>
> BTW I believe basic Clang support for s390 came earlier in 5.2 with
> a lot of efforts from Arnd Bergmann.
>
> My part was fixing recent breakages and bugging our s390 clang team
> (which did all the great work) to get kernel specific features support
> in clang 10 and 11 to reach features parity with gcc. And eventually
> doing few adjustments so that features which came with clang 10 and
> 11 are working smoothly. That is s390 "asm goto" support and specific
> compiler flags for ftrace support and stack packing.

That's awesome; I'd love to get the chance to meet your s390 LLVM
team; in general it can take a while to get bugs routed to folks most
empowered to fix them until you know who they are.

Would you, any fellow s390 kernel and LLVM folks be interested in
attending one of our virtual meetings, even if it's just to say "hi"
quickly? Next one is next Wednesday.

Usually we go over whatever firedrills we've been running the past two
weeks, but sometimes have presentations of folks projects and
research.  I think it would be cool to get more background on s390 and
work out the issues we're running into with testing.
-- 
Thanks,
~Nick Desaulniers
