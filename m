Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728962AbgLIJr0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 04:47:26 -0500
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: lib: Move to GPL 2 and SPDX
 license identifiers
References: <20201208150902.32383-1-frankja@linux.ibm.com>
 <20201208150902.32383-3-frankja@linux.ibm.com>
 <c236052c-598b-0d88-c80b-4bb2a999ec46@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <c08d511f-f9c0-5087-4e08-0c4ccbc4ebbf@linux.ibm.com>
Date: Wed, 9 Dec 2020 10:46:39 +0100
MIME-Version: 1.0
In-Reply-To: <c236052c-598b-0d88-c80b-4bb2a999ec46@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 12/9/20 10:15 AM, David Hildenbrand wrote:
> On 08.12.20 16:09, Janosch Frank wrote:
>> In the past we had some issues when developers wanted to use code
>> snippets or constants from the kernel in a test or in the library. To
>> remedy that the s390x maintainers decided to move all files to GPL 2
>> (if possible).
>>
>> At the same time let's move to SPDX identifiers as they are much nicer
>> to read.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/asm-offsets.c     | 4 +---
>>  lib/s390x/asm/arch_def.h    | 4 +---
>>  lib/s390x/asm/asm-offsets.h | 4 +---
>>  lib/s390x/asm/barrier.h     | 4 +---
>>  lib/s390x/asm/cpacf.h       | 1 +
>>  lib/s390x/asm/facility.h    | 4 +---
>>  lib/s390x/asm/float.h       | 4 +---
>>  lib/s390x/asm/interrupt.h   | 4 +---
>>  lib/s390x/asm/io.h          | 4 +---
>>  lib/s390x/asm/mem.h         | 4 +---
>>  lib/s390x/asm/page.h        | 4 +---
>>  lib/s390x/asm/pgtable.h     | 4 +---
>>  lib/s390x/asm/sigp.h        | 4 +---
>>  lib/s390x/asm/spinlock.h    | 4 +---
>>  lib/s390x/asm/stack.h       | 4 +---
>>  lib/s390x/asm/time.h        | 4 +---
>>  lib/s390x/css.h             | 4 +---
>>  lib/s390x/css_dump.c        | 4 +---
>>  lib/s390x/css_lib.c         | 4 +---
>>  lib/s390x/interrupt.c       | 4 +---
>>  lib/s390x/io.c              | 4 +---
>>  lib/s390x/mmu.c             | 4 +---
>>  lib/s390x/mmu.h             | 4 +---
>>  lib/s390x/sclp-console.c    | 5 +----
>>  lib/s390x/sclp.c            | 4 +---
>>  lib/s390x/sclp.h            | 5 +----
>>  lib/s390x/smp.c             | 4 +---
>>  lib/s390x/smp.h             | 4 +---
>>  lib/s390x/stack.c           | 4 +---
>>  lib/s390x/vm.c              | 3 +--
>>  lib/s390x/vm.h              | 3 +--
>>  31 files changed, 31 insertions(+), 90 deletions(-)
>>
>> diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
>> index 61d2658..ee94ed3 100644
>> --- a/lib/s390x/asm-offsets.c
>> +++ b/lib/s390x/asm-offsets.c
>> @@ -1,11 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>>   * Copyright (c) 2017 Red Hat Inc
>>   *
>>   * Authors:
>>   *  David Hildenbrand <david@redhat.com>
>> - *
>> - * This code is free software; you can redistribute it and/or modify it
>> - * under the terms of the GNU Library General Public License version 2.
>>   */
>>  #include <libcflat.h>
>>  #include <kbuild.h>
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index edc06ef..f3ab830 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -1,11 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>>   * Copyright (c) 2017 Red Hat Inc
>>   *
>>   * Authors:
>>   *  David Hildenbrand <david@redhat.com>
>> - *
>> - * This code is free software; you can redistribute it and/or modify it
>> - * under the terms of the GNU Library General Public License version 2.
>>   */
>>  #ifndef _ASM_S390X_ARCH_DEF_H_
>>  #define _ASM_S390X_ARCH_DEF_H_
>> diff --git a/lib/s390x/asm/asm-offsets.h b/lib/s390x/asm/asm-offsets.h
>> index a6d7af8..bed7f8e 100644
>> --- a/lib/s390x/asm/asm-offsets.h
>> +++ b/lib/s390x/asm/asm-offsets.h
>> @@ -1,10 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>>   * Copyright (c) 2017 Red Hat Inc
>>   *
>>   * Authors:
>>   *  David Hildenbrand <david@redhat.com>
>> - *
>> - * This code is free software; you can redistribute it and/or modify it
>> - * under the terms of the GNU Library General Public License version 2.
>>   */
>>  #include <generated/asm-offsets.h>
>> diff --git a/lib/s390x/asm/barrier.h b/lib/s390x/asm/barrier.h
>> index d862e78..8e2fd6d 100644
>> --- a/lib/s390x/asm/barrier.h
>> +++ b/lib/s390x/asm/barrier.h
>> @@ -1,12 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>>   * Copyright (c) 2017 Red Hat Inc
>>   *
>>   * Authors:
>>   *  Thomas Huth <thuth@redhat.com>
>>   *  David Hildenbrand <david@redhat.com>
>> - *
>> - * This code is free software; you can redistribute it and/or modify it
>> - * under the terms of the GNU Library General Public License version 2.
>>   */
>>  #ifndef _ASM_S390X_BARRIER_H_
>>  #define _ASM_S390X_BARRIER_H_
>> diff --git a/lib/s390x/asm/cpacf.h b/lib/s390x/asm/cpacf.h
>> index 2146a01..805fcf1 100644
>> --- a/lib/s390x/asm/cpacf.h
>> +++ b/lib/s390x/asm/cpacf.h
>> @@ -1,3 +1,4 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>  /*
>>   * CP Assist for Cryptographic Functions (CPACF)
>>   *
> 
> This file was originally copied from Linux v4.13. So I'm wondering if
> this should be
> 
> SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> 
> instead. Doesn't make a real difference in practice I guess?
> 
Linux's arch/s390/include/asm/cpacf.h has the GPL-2.0 identifier, so why
do you want the syscall note?
