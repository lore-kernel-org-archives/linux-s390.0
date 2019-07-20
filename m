Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728850AbfGTAWx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 20:22:53 -0400
References: <20190712053631.9814-3-bauerman@linux.ibm.com> <201907191711.8BlpwBo2%lkp@intel.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific files
In-reply-to: <201907191711.8BlpwBo2%lkp@intel.com>
Date: Fri, 19 Jul 2019 21:22:09 -0300
Message-ID: <87ef2lh7wu.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>


kbuild test robot <lkp@intel.com> writes:

> Hi Thiago,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.2 next-20190718]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Thiago-Jung-Bauermann/Remove-x86-specific-code-from-generic-headers/20190715-063006
> config: s390-allnoconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=s390
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
>>> kernel/dma/swiotlb.c:461:6: error: implicit declaration of function 'mem_encrypt_active'; did you mean 'set_cpu_active'? [-Werror=implicit-function-declaration]
>      if (mem_encrypt_active())
>          ^~~~~~~~~~~~~~~~~~
>          set_cpu_active
>    cc1: some warnings being treated as errors

This error was reported for v1 of the patch series. I wasn't able to
reproduce this problem on v1 but found a similar issue on v2.

I just did a build test of each patch of the latest version (v3) with an
s390 cross-toolchain and the config file from this report and didn't
find any build issues, so I believe this problem is solved.

--
Thiago Jung Bauermann
IBM Linux Technology Center
