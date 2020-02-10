Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727597AbgBJMOL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:14:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ACA9nK118546
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:14:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ubqass4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:14:10 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 12:14:08 -0000
Subject: Re: [PATCH 03/35] s390/protvirt: introduce host side setup
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-4-borntraeger@de.ibm.com>
 <20200210125452.7f66706d.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 13:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <20200210125452.7f66706d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f8175088-2041-46ac-dee7-8d0e7b22863d@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 10.02.20 12:54, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:26 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Vasily Gorbik <gor@linux.ibm.com>
>>
>> Add "prot_virt" command line option which controls if the kernel
>> protected VMs support is enabled at early boot time. This has to be
>> done early, because it needs large amounts of memory and will disable
>> some features like STP time sync for the lpar.
>>
>> Extend ultravisor info definitions and expose it via uv_info struct
>> filled in during startup.
>>
>> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  5 ++
>>  arch/s390/boot/Makefile                       |  2 +-
>>  arch/s390/boot/uv.c                           | 21 +++++++-
>>  arch/s390/include/asm/uv.h                    | 46 +++++++++++++++--
>>  arch/s390/kernel/Makefile                     |  1 +
>>  arch/s390/kernel/setup.c                      |  4 --
>>  arch/s390/kernel/uv.c                         | 49 +++++++++++++++++++
>>  7 files changed, 119 insertions(+), 9 deletions(-)
>>  create mode 100644 arch/s390/kernel/uv.c
> 
> (...)
> 
>> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
>> index e2c47d3a1c89..30f1811540c5 100644
>> --- a/arch/s390/boot/Makefile
>> +++ b/arch/s390/boot/Makefile
>> @@ -37,7 +37,7 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
>>  obj-y	:= head.o als.o startup.o mem_detect.o ipl_parm.o ipl_report.o
>>  obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
>>  obj-y	+= version.o pgm_check_info.o ctype.o text_dma.o
>> -obj-$(CONFIG_PROTECTED_VIRTUALIZATION_GUEST)	+= uv.o
>> +obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))	+= uv.o
> 
> I'm wondering why you're checking CONFIG_PGSTE here...

It was just simpler for a Makefile, because CONFIG_KVM can be m or y.
PGSTE is always y when CONFIG_KVM is set. Suggestions welcome.

[...]

>> +		prot_virt_host = 0;
>> +		pr_info("Running as protected virtualization guest.");
>> +	}
>> +
>> +	if (prot_virt_host && !test_facility(158)) {
>> +		prot_virt_host = 0;
>> +		pr_info("The ultravisor call facility is not available.");
>> +	}
> 
> What about prefixing these two with 'prot_virt:'? It seems the name is
> settled now?

It is not settled, but I can certainly do something like

#define KMSG_COMPONENT "prot_virt"
#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt


to prefix all pr_* calls in this file.
