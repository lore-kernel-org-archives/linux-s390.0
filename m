Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Jun 2013 09:16:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for the 3.9-rc6
Message-ID: <20130628091614.1fb04baa@mschwide>
In-Reply-To: <CACxGe6ujRoZkB9V6L_Zi1pVoaRganMDfZ70RKJJP1pF-NGNv=A@mail.gmail.com>
References: <20130403172534.528d04c5@mschwide>
	<CACxGe6sYM8QPB-ZZkgB0+f81CZHULPi5zPAsWb5dzHiRgU+w6Q@mail.gmail.com>
	<20130625141508.6c391fd8@mschwide>
	<CACxGe6s3RqOkf=M4zwpJGEEVa9XjJvP2q5xeLKewGo6np5C-3g@mail.gmail.com>
	<20130625151151.73aaba28@mschwide>
	<CACxGe6uOf+TONiCu27w9TsXmo2VVYXKS1+RZckAtxAdshtPDgQ@mail.gmail.com>
	<20130625161202.4d0a0075@mschwide>
	<CACxGe6ujRoZkB9V6L_Zi1pVoaRganMDfZ70RKJJP1pF-NGNv=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Grant,

On Tue, 25 Jun 2013 15:18:21 +0100
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Jun 25, 2013 at 3:12 PM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Tue, 25 Jun 2013 14:30:20 +0100
> > Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> >> Have you looked at irq_domain? It was created to solve that exact
> >> problem. irq_descs can get allocated dynamically as irqs are
> >> requested.
> >
> > That is one option I am considering. The PCI support for System z can have multiple
> > PCI function groups, each with up to 2048 MSI interrupts. It is quite a good match.
> 
> :-) It was designed to support exactly that use-case on PowerPC.

I decided against irq_domains after all. The reason is that on s390 the same
MSI interrupt numbers are used for multiple devices but without actually
sharing them. The PCI root complex uses the adapter id and the MSI interrupt
number to set two indicators for the target device (adapter interrupt summary
bit and the MSI interrupt bit in the adapter interrupt vector). That would
give me two options for irq_domains: 1) allocate an irq_domain for each
device, or 2) encode the adapter id in the hwirq number and create a sparsely
populated irq_domain. It is simpler to just use the irq_alloc_desc and
irq_free_desc calls directly.

The preliminary result of this can be gawked at 
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git genirq

Test and performance analysis is to-be-done and will take some time.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
