Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbfIBN66 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Sep 2019 09:58:58 -0400
Subject: Re: [kvm-unit-tests PATCH 5/6] s390x: Prepare for external calls
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e32aef57-e9a0-032d-3dec-5c3227225918@redhat.com>
Date: Mon, 2 Sep 2019 15:58:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190829121459.1708-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 29/08/2019 14.14, Janosch Frank wrote:
> With SMP we also get new external interrupts like external call and
> emergency call. Let's make them known.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h  |  5 +++++
>  lib/s390x/asm/interrupt.h |  3 +++
>  lib/s390x/interrupt.c     | 24 ++++++++++++++++++++----
>  3 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index d5a7f51..5ece2ce 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -19,6 +19,11 @@ struct psw {
>  #define PSW_MASK_DAT			0x0400000000000000UL
>  #define PSW_MASK_PSTATE			0x0001000000000000UL
>  
> +#define CR0_EXTM_SCLP			0X0000000000000200UL
> +#define CR0_EXTM_EXTC			0X0000000000004000UL
> +#define CR0_EXTM_EMGC			0X0000000000008000UL
> +#define CR0_EXTM_MASK			0X000000000001DD40UL

I think I need more coffee... but if I still count right, the EXTC, EMGC
and some of the mask bits seem to be off-by-one ? Could that be? Please
double-check.

 Thomas
