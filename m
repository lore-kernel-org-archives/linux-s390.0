Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729927AbgLHPQ2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 10:16:28 -0500
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: Move to GPL 2 and SPDX license
 identifiers
References: <20201208150902.32383-1-frankja@linux.ibm.com>
 <20201208150902.32383-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ba6a2c95-480e-a870-a5ba-7f54f55c4488@redhat.com>
Date: Tue, 8 Dec 2020 16:14:49 +0100
MIME-Version: 1.0
In-Reply-To: <20201208150902.32383-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 08/12/2020 16.09, Janosch Frank wrote:
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
>  s390x/cmm.c       | 4 +---
>  s390x/cpumodel.c  | 4 +---
>  s390x/css.c       | 4 +---
>  s390x/cstart64.S  | 4 +---
>  s390x/diag10.c    | 4 +---
>  s390x/diag288.c   | 4 +---
>  s390x/diag308.c   | 5 +----
>  s390x/emulator.c  | 4 +---
>  s390x/gs.c        | 4 +---
>  s390x/iep.c       | 4 +---
>  s390x/intercept.c | 4 +---
>  s390x/pfmf.c      | 4 +---
>  s390x/sclp.c      | 4 +---
>  s390x/selftest.c  | 4 +---
>  s390x/skey.c      | 4 +---
>  s390x/skrf.c      | 4 +---
>  s390x/smp.c       | 4 +---
>  s390x/sthyi.c     | 4 +---
>  s390x/sthyi.h     | 4 +---
>  s390x/stsi.c      | 4 +---
>  s390x/uv-guest.c  | 4 +---
>  s390x/vector.c    | 4 +---
>  22 files changed, 22 insertions(+), 67 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
