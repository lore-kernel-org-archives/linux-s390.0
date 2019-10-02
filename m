Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfJBGuG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 02:50:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x926gqbX051259
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 02:50:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vcpb3h28x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 02:50:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 2 Oct 2019 07:50:03 +0100
Date: Wed, 2 Oct 2019 08:49:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
 <20191002064605.GA7405@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002064605.GA7405@osiris>
Message-Id: <20191002064956.GB7405@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 08:46:05AM +0200, Heiko Carstens wrote:
> On Tue, Oct 01, 2019 at 10:08:01PM +0200, Jiri Kosina wrote:
> > I am wondering how is it possible that none of the build-testing 
> > infrastructure we have running against linux-next caught this? Not enough 
> > non-x86 coverage?
> 
> Well, there is plenty of s390 coverage with respect to daily builds
> (also here). It doesn't fail for me with gcc 9.1; so you may either
> have a different gcc version or different config options(?) so the
> compiler decided to not inline the function. I'll apply this in any
> case, since your patch is obviously fine.
> 
> Thanks!

Ok, Christian applied this already a couple of minutes earlier ;)
