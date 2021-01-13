Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbhAMMq3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 07:46:29 -0500
Subject: Re: [kvm-unit-tests PATCH v4 5/9] s390x: sie: Add SIE to lib
References: <20210112132054.49756-1-frankja@linux.ibm.com>
 <20210112132054.49756-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <85cd46f1-fd09-752d-a85f-2a5907ee0802@redhat.com>
Date: Wed, 13 Jan 2021 13:44:53 +0100
MIME-Version: 1.0
In-Reply-To: <20210112132054.49756-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 12/01/2021 14.20, Janosch Frank wrote:
> This commit adds the definition of the SIE control block struct and
> the assembly to execute SIE and save/restore guest registers.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm-offsets.c  |  11 +++
>   lib/s390x/asm/arch_def.h |   9 ++
>   lib/s390x/interrupt.c    |   7 ++
>   lib/s390x/sie.h          | 197 +++++++++++++++++++++++++++++++++++++++
>   s390x/lib.S              |  56 +++++++++++
>   5 files changed, 280 insertions(+)
>   create mode 100644 lib/s390x/sie.h
[...]
> diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
> new file mode 100644
> index 0000000..66aa3b8
> --- /dev/null
> +++ b/lib/s390x/sie.h
> @@ -0,0 +1,197 @@
> +#ifndef SIE_H
> +#define SIE_H

Add a SPDX license identifier at the top of the new file?

Apart from that looks ok to me.

Acked-by: Thomas Huth <thuth@redhat.com>
