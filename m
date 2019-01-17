Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 17 Jan 2019 21:19:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/5] s390: rework compat wrapper generation
References: <20190116131527.2071570-1-arnd@arndb.de>
 <20190117133619.GD18351@osiris>
 <CAK8P3a2KvCwAa5yp+f_cZOX4Osd_tvwfBto=aMEMW9TNbePQ9w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2KvCwAa5yp+f_cZOX4Osd_tvwfBto=aMEMW9TNbePQ9w@mail.gmail.com>
Message-Id: <20190117201920.GB3687@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 17, 2019 at 05:21:50PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 17, 2019 at 2:36 PM Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> >
> > On Wed, Jan 16, 2019 at 02:15:18PM +0100, Arnd Bergmann wrote:
> 
> > > I did not test the changes at runtime, but I looked at the
> > > generated object code, which seems fine here and includes
> > > the same conversions as before.
> >
> > All looks good and seems to work fine. This is a very nice
> > simplification of our compat code, even if it adds some dead code to
> > the kernel image.
> >
> > I did some tests and it all looks good. Also the generated code looks
> > fine. So, if nothing breaks, this will go upstream with next merge
> > window via the s390 tree.
> >
> > Thanks again for your work!
> 
> Awesome, thanks for testing it so quickly and agreeing to merge it!
> 
> There is a dependency that I now have for my y2038 syscall series
> of course, so I'd need to have those patches on top of the s390 series.
> 
> I think we can either have a shared git branch that gets merged both
> into your s390 tree and my y2038 tree, or we merge it only through
> my tree, with your Ack.
> 
> Does that work for you?

I'll discuss this with Martin tomorrow, however I think a shared git
branch would be the best solution. I want to get as much testing as
possible for this patch set, which means this must also be in the s390
tree.
