Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUQNm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 12:13:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LFaSml076204
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 12:13:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30j2xt2fny-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 12:13:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 21 Apr 2020 17:13:00 +0100
Subject: Re: [kvm-unit-tests PATCH v5 00/10] s390x: Testing the Channel
 Subsystem I/O
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
Date: Tue, 21 Apr 2020 18:13:30 +0200
MIME-Version: 1.0
In-Reply-To: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <028ece05-1429-7761-cf4e-6fabc34e6aa0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-02-20 13:00, Pierre Morel wrote:

...snip...

> 
> 
> Pierre Morel (10):
>    s390x: saving regs for interrupts
>    s390x: Use PSW bits definitions in cstart
>    s390x: cr0: adding AFP-register control bit
>    s390x: export the clock get_clock_ms() utility

Please can you consider applying these 4 patches only.
I will send some changes I made for the patches on css tests.

I did not change the interrupt registration but since it is introduced 
for the css test patches I resend it with them.

Thanks,
Pierre

 >    s390x: interrupt registration

>    s390x: Library resources for CSS tests
>    s390x: css: stsch, enumeration test
>    s390x: css: msch, enable test
>    s390x: css: ssch/tsch with sense and interrupt
>    s390x: css: ping pong
> 
>   lib/s390x/asm/arch_def.h |  19 ++-
>   lib/s390x/asm/time.h     |  36 +++++
>   lib/s390x/css.h          | 277 +++++++++++++++++++++++++++++++
>   lib/s390x/css_dump.c     | 157 ++++++++++++++++++
>   lib/s390x/css_lib.c      |  55 +++++++
>   lib/s390x/interrupt.c    |  22 ++-
>   lib/s390x/interrupt.h    |   7 +
>   s390x/Makefile           |   3 +
>   s390x/css.c              | 341 +++++++++++++++++++++++++++++++++++++++
>   s390x/cstart64.S         |  40 +++--
>   s390x/intercept.c        |  11 +-
>   s390x/unittests.cfg      |   4 +
>   12 files changed, 946 insertions(+), 26 deletions(-)
>   create mode 100644 lib/s390x/asm/time.h
>   create mode 100644 lib/s390x/css.h
>   create mode 100644 lib/s390x/css_dump.c
>   create mode 100644 lib/s390x/css_lib.c
>   create mode 100644 lib/s390x/interrupt.h
>   create mode 100644 s390x/css.c
> 

-- 
Pierre Morel
IBM Lab Boeblingen
