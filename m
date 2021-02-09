Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232401AbhBIPQX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 10:16:23 -0500
Subject: Re: [kvm-unit-tests PATCH 1/8] s390x: Fix fpc store address in
 RESTORE_REGS_STACK
References: <20210209134925.22248-1-frankja@linux.ibm.com>
 <20210209134925.22248-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eff04587-8499-b987-d4a8-a7a2e20fb63a@redhat.com>
Date: Tue, 9 Feb 2021 16:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <20210209134925.22248-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, pmorel@linux.ibm.com, imbrenda@linux.ibm.com

On 09/02/2021 14.49, Janosch Frank wrote:
> The efpc stores in bits 32-63 of a register and we store a full 8
> bytes to have the stack 8 byte aligned. This means that the fpc is
> stored at offset 4 but we load it from offset 0. Lets replace efpc
> with stfpc and get rid of the stg to store at offset 0.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   s390x/macros.S | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/s390x/macros.S b/s390x/macros.S
> index 37a6a63e..e51a557a 100644
> --- a/s390x/macros.S
> +++ b/s390x/macros.S
> @@ -54,8 +54,7 @@
>   	.endr
>   	/* Save fpc, but keep stack aligned on 64bits */
>   	slgfi   %r15, 8
> -	efpc	%r0
> -	stg	%r0, 0(%r15)
> +	stfpc	0(%r15)
>   	.endm

Reviewed-by: Thomas Huth <thuth@redhat.com>
