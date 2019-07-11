Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbfGKVtF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Jul 2019 17:49:05 -0400
References: <20190612111236.99538-1-pasic@linux.ibm.com> <20190612111236.99538-2-pasic@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v5 1/8] s390/mm: force swiotlb for protected virtualization
In-reply-to: <20190612111236.99538-2-pasic@linux.ibm.com>
Date: Thu, 11 Jul 2019 18:48:40 -0300
Message-ID: <87k1codyyv.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>


Hello Halil,

Halil Pasic <pasic@linux.ibm.com> writes:

> On s390, protected virtualization guests have to use bounced I/O
> buffers.  That requires some plumbing.
>
> Let us make sure, any device that uses DMA API with direct ops correctly
> is spared from the problems, that a hypervisor attempting I/O to a
> non-shared page would bring.
>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/Kconfig                   |  4 +++
>  arch/s390/include/asm/mem_encrypt.h | 18 +++++++++++
>  arch/s390/mm/init.c                 | 47 +++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 arch/s390/include/asm/mem_encrypt.h
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 109243fdb6ec..88d8355b7bf7 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +config ARCH_HAS_MEM_ENCRYPT
> +        def_bool y
> +
>  config MMU
>  	def_bool y
>  

ARCH_HAS_MEM_ENCRYPT is already defined in arch/Kconfig, so I think you
can just select it in config S390 like you do with SWIOTLB.

> @@ -187,6 +190,7 @@ config S390
>  	select VIRT_CPU_ACCOUNTING
>  	select ARCH_HAS_SCALED_CPUTIME
>  	select HAVE_NMI
> +	select SWIOTLB
>  
>  
>  config SCHED_OMIT_FRAME_POINTER

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
