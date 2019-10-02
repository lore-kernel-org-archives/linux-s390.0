Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfJBIWH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 04:22:07 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x928HFrQ118040
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 04:22:06 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcnhs4nb6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 04:22:05 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 2 Oct 2019 09:22:04 +0100
Date: Wed, 2 Oct 2019 10:21:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
 <20191002064605.GA7405@osiris>
 <20191002070333.GE24815@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002070333.GE24815@unicorn.suse.cz>
Message-Id: <20191002082157.GA9535@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-s390@vger.kernel.org

On Wed, Oct 02, 2019 at 09:03:33AM +0200, Michal Kubecek wrote:
> On Wed, Oct 02, 2019 at 08:46:05AM +0200, Heiko Carstens wrote:
> > On Tue, Oct 01, 2019 at 10:08:01PM +0200, Jiri Kosina wrote:
> > > 
> > >    In file included from arch/s390/kvm/kvm-s390.c:44:
> > >    ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
> > >    ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
> > >      179 |  asm volatile(
> > >          |  ^~~
> > >    ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'
> > > 
> > > ...
> > > 
> > > I am wondering how is it possible that none of the build-testing 
> > > infrastructure we have running against linux-next caught this? Not enough 
> > > non-x86 coverage?
> > 
> > Well, there is plenty of s390 coverage with respect to daily builds
> > (also here). It doesn't fail for me with gcc 9.1; so you may either
> > have a different gcc version or different config options(?) so the
> > compiler decided to not inline the function.
> 
> I think I found the reason: we only hit the build failure with one
> special config used for zfcpdump which has
> 
>   CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> 
> When I switched to CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y (which we have
> in other s390x configs and which most people probably prefer), the build
> does not fail even without the patch.

Yes, with CONFIG_CC_OPTIMIZE_FOR_SIZE=y I can see plenty of _additional_
compile failures on s390 with "defconfig". Will fix them all...

Thanks for reporting!
