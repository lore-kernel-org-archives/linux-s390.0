Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbgLIMwY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 07:52:24 -0500
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: lib: Move to GPL 2 and SPDX
 license identifiers
References: <20201208150902.32383-1-frankja@linux.ibm.com>
 <20201208150902.32383-3-frankja@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <b385350a-5946-f3cd-b04c-a7eee2df52bf@linux.ibm.com>
Date: Wed, 9 Dec 2020 13:50:23 +0100
MIME-Version: 1.0
In-Reply-To: <20201208150902.32383-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 12/8/20 4:09 PM, Janosch Frank wrote:
> In the past we had some issues when developers wanted to use code
> snippets or constants from the kernel in a test or in the library. To
> remedy that the s390x maintainers decided to move all files to GPL 2
> (if possible).
> 
> At the same time let's move to SPDX identifiers as they are much nicer
> to read.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm-offsets.c     | 4 +---
>   lib/s390x/asm/arch_def.h    | 4 +---
>   lib/s390x/asm/asm-offsets.h | 4 +---
>   lib/s390x/asm/barrier.h     | 4 +---
>   lib/s390x/asm/cpacf.h       | 1 +
>   lib/s390x/asm/facility.h    | 4 +---
>   lib/s390x/asm/float.h       | 4 +---
>   lib/s390x/asm/interrupt.h   | 4 +---
>   lib/s390x/asm/io.h          | 4 +---
>   lib/s390x/asm/mem.h         | 4 +---
>   lib/s390x/asm/page.h        | 4 +---
>   lib/s390x/asm/pgtable.h     | 4 +---
>   lib/s390x/asm/sigp.h        | 4 +---
>   lib/s390x/asm/spinlock.h    | 4 +---
>   lib/s390x/asm/stack.h       | 4 +---
>   lib/s390x/asm/time.h        | 4 +---
>   lib/s390x/css.h             | 4 +---
>   lib/s390x/css_dump.c        | 4 +---
>   lib/s390x/css_lib.c         | 4 +---
>   lib/s390x/interrupt.c       | 4 +---
>   lib/s390x/io.c              | 4 +---
>   lib/s390x/mmu.c             | 4 +---
>   lib/s390x/mmu.h             | 4 +---
>   lib/s390x/sclp-console.c    | 5 +----
>   lib/s390x/sclp.c            | 4 +---
>   lib/s390x/sclp.h            | 5 +----
>   lib/s390x/smp.c             | 4 +---
>   lib/s390x/smp.h             | 4 +---
>   lib/s390x/stack.c           | 4 +---
>   lib/s390x/vm.c              | 3 +--
>   lib/s390x/vm.h              | 3 +--
>   31 files changed, 31 insertions(+), 90 deletions(-)
> 

Acked-by: Pierre Morel <pmorel@linux.ibm.com>

-- 
Pierre Morel
IBM Lab Boeblingen
