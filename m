Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbfJBGo1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 02:44:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x926gtna007532
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 02:44:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vchwkfd77-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 02:44:26 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 2 Oct 2019 07:44:24 +0100
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 2 Oct 2019 08:44:20 +0200
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dc7f77bd-18d4-5f0e-6749-b00b23647f53@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, linux-kernel@vger.kernel.org


On 01.10.19 22:08, Jiri Kosina wrote:
> arch/s390/kvm/kvm-s390.c calls on several places __cpacf_query() directly, 
> which makes it impossible to meet the "i" constraint for the asm operands 
> (opcode in this case).
> 
> As we are now force-enabling CONFIG_OPTIMIZE_INLINING on all 
> architectures, this causes a build failure on s390:
> 
>    In file included from arch/s390/kvm/kvm-s390.c:44:
>    ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
>    ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
>      179 |  asm volatile(
>          |  ^~~
>    ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'
> 
> Mark __cpacf_query() as __always_inline in order to fix that, analogically 
> how we fixes __cpacf_check_opcode(), cpacf_query_func() and scpacf_query() 
> already.
> 
> Reported-and-tested-by: Michal Kubecek <mkubecek@suse.cz>
> Fixes: d83623c5eab2 ("s390: mark __cpacf_check_opcode() and cpacf_query_func() as __always_inline")
> Fixes: e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Thanks applied. 


> 
> I am wondering how is it possible that none of the build-testing 
> infrastructure we have running against linux-next caught this? Not enough 
> non-x86 coverage?

We do build-test linux-next daily. Maybe our compiler just made a different
inlining decision.
