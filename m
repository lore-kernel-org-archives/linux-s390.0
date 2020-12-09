Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731770AbgLIMoB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 07:44:01 -0500
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: Move to GPL 2 and SPDX license
 identifiers
References: <20201208150902.32383-1-frankja@linux.ibm.com>
 <20201208150902.32383-2-frankja@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <414068f0-4bf4-8ccc-a11e-63deb5f01c42@linux.ibm.com>
Date: Wed, 9 Dec 2020 13:43:13 +0100
MIME-Version: 1.0
In-Reply-To: <20201208150902.32383-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 12/8/20 4:09 PM, Janosch Frank wrote:
> In the past we had some issues when developers wanted to use code
> snippets or constants from the kernel in a test or in the library. To
> remedy that the s390x maintainers decided to move all files to GPL
> 2 (if possible).
> 
> At the same time let's move to SPDX identifiers as they are much nicer
> to read.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/cmm.c       | 4 +---
>   s390x/cpumodel.c  | 4 +---
>   s390x/css.c       | 4 +---
>   s390x/cstart64.S  | 4 +---
>   s390x/diag10.c    | 4 +---
>   s390x/diag288.c   | 4 +---
>   s390x/diag308.c   | 5 +----
>   s390x/emulator.c  | 4 +---
>   s390x/gs.c        | 4 +---
>   s390x/iep.c       | 4 +---
>   s390x/intercept.c | 4 +---
>   s390x/pfmf.c      | 4 +---
>   s390x/sclp.c      | 4 +---
>   s390x/selftest.c  | 4 +---
>   s390x/skey.c      | 4 +---
>   s390x/skrf.c      | 4 +---
>   s390x/smp.c       | 4 +---
>   s390x/sthyi.c     | 4 +---
>   s390x/sthyi.h     | 4 +---
>   s390x/stsi.c      | 4 +---
>   s390x/uv-guest.c  | 4 +---
>   s390x/vector.c    | 4 +---
>   22 files changed, 22 insertions(+), 67 deletions(-)
> 

Acked-by: Pierre Morel <pmorel@linux.ibm.com>


-- 
Pierre Morel
IBM Lab Boeblingen
