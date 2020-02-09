Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24635 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727514AbgBIQDp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 9 Feb 2020 11:03:45 -0500
Subject: Re: [PATCH 28/35] KVM: s390: protvirt: UV calls diag308 0, 1
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-29-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bc9b1c4f-af9f-8859-79b7-ed232cfd5f6e@redhat.com>
Date: Sun, 9 Feb 2020 17:03:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-29-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> diag 308 subcode 0 and 1 require KVM and Ultravisor interaction, since
> the cpus have to be set into multiple reset states.
> 
> * All cpus need to be stopped
> * The "unshare all" UVC needs to be executed
> * The "perform reset" UVC needs to be executed
> * The cpus need to be reset via the "set cpu state" UVC
> * The issuing cpu needs to set state 5 via "set cpu state"

Is the patch description still accurate here? The patch seems mostly
about adding two new UVCs, and not really about diag 308 ... ?

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
[...]
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 3fb54ec2cf3e..390830385b9f 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -13,6 +13,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/gmap.h>
>  #include <asm/virtio-ccw.h>
> +#include <asm/uv.h>
>  #include "kvm-s390.h"
>  #include "trace.h"
>  #include "trace-s390.h"

This single change to diag.c looks like it could either be removed, or
the hunk should belong to another patch.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4afa44e3d1ed..0be18ac1afb5 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

 Thomas
