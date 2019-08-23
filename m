Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbfHWOND (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 10:13:03 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Add diag308 subcode 0 testing
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190822111100.4444-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ffc7de14-7960-5423-d984-c18ab1dfa4b2@redhat.com>
Date: Fri, 23 Aug 2019 16:12:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190822111100.4444-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 8/22/19 1:11 PM, Janosch Frank wrote:
> By adding a load reset routine to cstart.S we can also test the clear
> reset done by subcode 0, as we now can restore our registers again.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> I managed to extract this from another bigger test, so let's add it to the bunch.
> I'd be very happy about assembly review :-)

FWIW, the assembly code looks fine to me.

> ---
>  s390x/cstart64.S | 27 +++++++++++++++++++++++++++
>  s390x/diag308.c  | 31 ++++++++++---------------------
>  2 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index dedfe80..47045e1 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -145,6 +145,33 @@ memsetxc:
>  	.endm
>  
>  .section .text
> +/*
> + * load_reset calling convention:
> + * %r2 subcode (0 or 1)
> + */
> +.globl load_reset
> +load_reset:

Maybe rather name the function diag308_load_reset so that it is clear
that it belongs to the diag308 test?
Or are you going to re-use this function in other tests later?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>
