Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730421AbgLILCk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 06:02:40 -0500
Date: Wed, 9 Dec 2020 12:01:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: Move to GPL 2 and SPDX
 license identifiers
Message-ID: <20201209120102.3d997c86.cohuck@redhat.com>
In-Reply-To: <20201208150902.32383-2-frankja@linux.ibm.com>
References: <20201208150902.32383-1-frankja@linux.ibm.com>
        <20201208150902.32383-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, linux-s390@vger.kernel.org

On Tue,  8 Dec 2020 10:09:01 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

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

Yeah for SPDX!

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
