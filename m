Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727922AbgBJRcM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 Feb 2020 12:32:12 -0500
Date: Mon, 10 Feb 2020 18:31:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390/uv: Fix handling of length extensions
Message-ID: <20200210183152.40bfae24.cohuck@redhat.com>
In-Reply-To: <20200210165439.3767-2-borntraeger@de.ibm.com>
References: <20200210165439.3767-1-borntraeger@de.ibm.com>
        <20200210165439.3767-2-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>

On Mon, 10 Feb 2020 11:54:39 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The query parameter block might contain additional information and can
> be extended in the future. If the size of the block does not suffice we
> get an error code of rc=0x100.  The buffer will contain all information
> up to the specified size and the hypervisor/guest simply do not need the
> additional information as they do not know about the new data.  That
> means that we can (and must) accept rc=0x100 as success.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5abb9351dfd9 ("s390/uv: introduce guest side ultravisor code")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/boot/uv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index af9e1cc93c68..c003593664cd 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -21,7 +21,7 @@ void uv_query_info(void)
>  	if (!test_facility(158))
>  		return;
>  
> -	if (uv_call(0, (uint64_t)&uvcb))
> +	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != 0x100)

Add a comment like

/* rc==0x100 means that there is additional data we do not process */

to avoid headscratching in the future?

>  		return;
>  
>  	if (IS_ENABLED(CONFIG_KVM)) {

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
