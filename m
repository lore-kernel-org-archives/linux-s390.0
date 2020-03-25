Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727297AbgCYJiz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:38:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9Wugv121878
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:38:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywchy0182-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:38:54 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 25 Mar 2020 09:38:49 -0000
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
 <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
 <5ea6313e-ec4f-a043-632b-ef2901ce2cc9@huawei.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Mar 2020 10:38:40 +0100
MIME-Version: 1.0
In-Reply-To: <5ea6313e-ec4f-a043-632b-ef2901ce2cc9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <505b3d0a-b754-ba56-0b98-b7551ef414be@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>, Mike Kravetz <mike.kravetz@oracle.com>, Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>



On 25.03.20 03:58, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
[...]
> Hi Mike,
> 
> Inspired by Dave's opinion, it seems the x86-specific hugepages_supported should
> also need to use cpu_feature_enabled instead.
> 
> Also, I wonder if the hugepages_supported is correct ? There're two arch
> specific hugepages_supported:
> x86:
> #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> and
> s390:
> #define hugepages_supported() (MACHINE_HAS_EDAT1)
> 
> Is it possible that x86 has X86_FEATURE_GBPAGES but hasn't X86_FEATURE_GBPAGES
> or s390 has MACHINE_HAS_EDAT2 but hasn't MACHINE_HAS_EDAT1 ?

The s390 architecture says that 

When EDAT-2 applies, the following function is available in the DAT process:
 - EDAT-1 applies.
[..]

So if the machine has EDAT-2 it also has EDAT-1.
