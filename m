Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2474 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgG2Nvc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Jul 2020 09:51:32 -0400
Date: Wed, 29 Jul 2020 15:51:22 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: linux plumbers + clang + s390 virtualized testing
Message-ID: <your-ad-here.call-01596030682-ext-1369@work.hours>
References: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
 <20200716112840.GC8484@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716112840.GC8484@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jul 16, 2020 at 01:28:40PM +0200, Heiko Carstens wrote:
> Hi Nick,
> 
> > We were very excited to see your patches going by for enabling Clang
> > support for s390.  Since then, we've added s390 builds to our
> > continuous integration setup.
> > 
> > We've been running into a few issues with doing virtualized boot tests
> > of our kernels on s390.
> > 
> > I was curious if you'll both be attending Linux plumbers conf?  If we
> > carve out time for an s390+clang talk, would this be of interest to
> > you to attend?
> 
> I will not attend, however cannot speak for Vasily. He will have to
> answer as soon as he returns - besides that enabling Clang support for
> s390 was done by Vasily anyway :)

I will attend and it would surely be interesting to me and other
s390 folks. Your efforts are greatly appreciated!

BTW I believe basic Clang support for s390 came earlier in 5.2 with
a lot of efforts from Arnd Bergmann.

My part was fixing recent breakages and bugging our s390 clang team
(which did all the great work) to get kernel specific features support
in clang 10 and 11 to reach features parity with gcc. And eventually
doing few adjustments so that features which came with clang 10 and
11 are working smoothly. That is s390 "asm goto" support and specific
compiler flags for ftrace support and stack packing.
