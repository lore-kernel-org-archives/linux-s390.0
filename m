Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27536 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388964AbgEZSJD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 14:09:03 -0400
Subject: Re: [kvm-unit-tests PATCH v7 04/12] s390x: interrupt registration
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-5-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dcfa518e-ce93-fb71-3e70-b95c12b0b32e@redhat.com>
Date: Tue, 26 May 2020 20:08:52 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-5-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 18/05/2020 18.07, Pierre Morel wrote:
> Let's make it possible to add and remove a custom io interrupt handler,
> that can be used instead of the normal one.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
>  lib/s390x/interrupt.h |  8 ++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 lib/s390x/interrupt.h
...
> diff --git a/lib/s390x/interrupt.h b/lib/s390x/interrupt.h
> new file mode 100644
> index 0000000..323258d
> --- /dev/null
> +++ b/lib/s390x/interrupt.h
> @@ -0,0 +1,8 @@
> +#ifndef __INTERRUPT_H
> +#define __INTERRUPT_H

Looking at this patch again, I noticed another nit: No double
underscores at the beginning of header guards, please! That's reserved
namespace. Simply use INTERRUPT_H or S390X_INTERRUPT_H or something
similar instead.

 Thanks,
  Thomas
