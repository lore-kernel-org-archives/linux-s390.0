Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728652AbgDQHUH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 03:20:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H73hlV016656
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 03:20:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30f70m1jda-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 03:20:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 17 Apr 2020 08:19:34 +0100
Subject: Re: linux-next: Tree for Apr 17
References: <20200417145017.3932443d@canb.auug.org.au>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 17 Apr 2020 09:19:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200417145017.3932443d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aeedbf33-2dc1-0577-301d-535f49ba287e@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>



On 17.04.20 06:50, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200416:
> 
> My fixes tree contains:
> 
>   6b038bdcd3d1 sh: mm: Fix build error
> 
> The qcom tree still had its build failure for which I reverted a commit.
> 
> The sound-asoc tree still has its failures so I used the version from
> next-20200414.
> 
> The crypto tree gained a build failure for which I reverted 5 commits.
> 
> Non-merge commits (relative to Linus' tree): 2255
>  3007 files changed, 64848 insertions(+), 29193 deletions(-)
> 


This fails for s390 already in kconfig

$ make defconfig
*** Default configuration is based on 'defconfig'
drivers/pci/Kconfig:16:error: recursive dependency detected!
drivers/pci/Kconfig:16:	symbol PCI is selected by CEC_SECO
drivers/media/cec/platform/Kconfig:100:	symbol CEC_SECO depends on MEDIA_CEC_SUPPORT
drivers/media/cec/Kconfig:27:	symbol MEDIA_CEC_SUPPORT default is visible depending on MEDIA_SUPPORT_FILTER
drivers/media/Kconfig:25:	symbol MEDIA_SUPPORT_FILTER depends on MEDIA_SUPPORT
drivers/media/Kconfig:12:	symbol MEDIA_SUPPORT depends on HAS_IOMEM
arch/s390/Kconfig:722:	symbol HAS_IOMEM default value contains PCI
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"


bisect points to

commit 4be5e8648b0c287aefc6ac3f3a0b12c696054f43
Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Wed Apr 15 11:03:40 2020 +0200

    media: move CEC platform drivers to a separate directory



> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig and htmldocs. And finally, a simple boot test
> of the powerpc pseries_le_defconfig kernel in qemu (with and without
> kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 318 trees (counting Linus' and 78 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 
