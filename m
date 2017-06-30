From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 14:41:20 +0000
Subject: Re: [CRIU][PATCH 0/7] Add architecture support for s390x
Message-Id: <20170630164120.0e1a2aef@TP-holzheu>
In-Reply-To: <0003e239-f4d9-124a-fcd5-591b07b27b7e@virtuozzo.com>
References: <0003e239-f4d9-124a-fcd5-591b07b27b7e@virtuozzo.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am Thu, 29 Jun 2017 17:33:51 +0300
schrieb Pavel Emelyanov <xemul@virtuozzo.com>:

> On 06/29/2017 05:23 PM, Michael Holzheu wrote:
> > Am Thu, 29 Jun 2017 12:48:28 +0300
> > schrieb Pavel Emelyanov <xemul@virtuozzo.com>:
> > 
> >> On 06/28/2017 07:11 PM, Michael Holzheu wrote:
> >>> Hello CRIU mailing list,
> >>>
> >>> This set of patches adds the s390x (64 bit mainframe) backend support to
> >>> the CRIU checkpoint/restore tool.
> >>
> >> That's really cool :) thanks a lot!
> >>
> >> There's one, quite big, thing I'd like to discuss :) So far the most active community
> >> members are x86 guys, but we already have 3 more arches (arm, aarch64 and ppc64le). 
> >> In order not to break non-x86 heavily we've set up travis-ci jobs to constantly check
> >> that criu compiles on non-x64 [1]. Also we have arm box and access to ppc64 VM from 
> >> IBM and a set of jenkins jobs [2] that run tests on them.
> >>
> >> Would you also at least add the former piece, so that we don't break compilation of your
> >> code. And ideally, we'd like to have the latter thing too.
> > 
> > Yesterday we tried to setup the travis qemu stuff, but for some reason
> > this failed. I attached our current patch to this E-mail.
> 
> OK. So we'll at least have the compilation checker :)

I just learned that qemu on s390x can only emulate older z900 mainframe machines.
Very likely the Travis Ubuntu Docker image for s390 uses newer instructions,
which is probably the reason why it currently does not work.

Michael
