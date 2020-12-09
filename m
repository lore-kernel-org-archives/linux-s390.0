Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730329AbgLILFQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 06:05:16 -0500
Date: Wed, 9 Dec 2020 12:03:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: lib: Move to GPL 2 and SPDX
 license identifiers
Message-ID: <20201209120340.342f9993.cohuck@redhat.com>
In-Reply-To: <20201208150902.32383-3-frankja@linux.ibm.com>
References: <20201208150902.32383-1-frankja@linux.ibm.com>
        <20201208150902.32383-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, linux-s390@vger.kernel.org

On Tue,  8 Dec 2020 10:09:02 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

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
>  lib/s390x/asm-offsets.c     | 4 +---
>  lib/s390x/asm/arch_def.h    | 4 +---
>  lib/s390x/asm/asm-offsets.h | 4 +---
>  lib/s390x/asm/barrier.h     | 4 +---
>  lib/s390x/asm/cpacf.h       | 1 +
>  lib/s390x/asm/facility.h    | 4 +---
>  lib/s390x/asm/float.h       | 4 +---
>  lib/s390x/asm/interrupt.h   | 4 +---
>  lib/s390x/asm/io.h          | 4 +---
>  lib/s390x/asm/mem.h         | 4 +---
>  lib/s390x/asm/page.h        | 4 +---
>  lib/s390x/asm/pgtable.h     | 4 +---
>  lib/s390x/asm/sigp.h        | 4 +---
>  lib/s390x/asm/spinlock.h    | 4 +---
>  lib/s390x/asm/stack.h       | 4 +---
>  lib/s390x/asm/time.h        | 4 +---
>  lib/s390x/css.h             | 4 +---
>  lib/s390x/css_dump.c        | 4 +---
>  lib/s390x/css_lib.c         | 4 +---
>  lib/s390x/interrupt.c       | 4 +---
>  lib/s390x/io.c              | 4 +---
>  lib/s390x/mmu.c             | 4 +---
>  lib/s390x/mmu.h             | 4 +---
>  lib/s390x/sclp-console.c    | 5 +----
>  lib/s390x/sclp.c            | 4 +---
>  lib/s390x/sclp.h            | 5 +----
>  lib/s390x/smp.c             | 4 +---
>  lib/s390x/smp.h             | 4 +---
>  lib/s390x/stack.c           | 4 +---
>  lib/s390x/vm.c              | 3 +--
>  lib/s390x/vm.h              | 3 +--
>  31 files changed, 31 insertions(+), 90 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
