Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40912 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbgEZSLK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 14:11:10 -0400
Subject: Re: [kvm-unit-tests PATCH v7 05/12] s390x: export the clock
 get_clock_ms() utility
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-6-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <80ccd983-df12-a6ee-239e-b367ebc9dded@redhat.com>
Date: Tue, 26 May 2020 20:10:51 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-6-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 18/05/2020 18.07, Pierre Morel wrote:
> To serve multiple times, the function get_clock_ms() is moved
> from intercept.c test to the new file asm/time.h.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/asm/time.h | 26 ++++++++++++++++++++++++++
>  s390x/intercept.c    | 11 +----------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/time.h
> 
> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
> new file mode 100644
> index 0000000..25c7a3c
> --- /dev/null
> +++ b/lib/s390x/asm/time.h
> @@ -0,0 +1,26 @@
> +/*
> + * Clock utilities for s390
> + *
> + * Authors:
> + *  Thomas Huth <thuth@redhat.com>
> + *
> + * Copied from the s390/intercept test by:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + */
> +#ifndef _ASM_S390X_TIME_H_
> +#define _ASM_S390X_TIME_H_

Please also remove the underscores at the beginning (and preferably also
at the end) here.

 Thanks,
  Thomas
