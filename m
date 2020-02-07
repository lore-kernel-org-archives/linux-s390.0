Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42239 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726899AbgBGQct (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 11:32:49 -0500
Subject: Re: [PATCH 08/35] KVM: s390: protvirt: Add initial lifecycle handling
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-9-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c4949664-c6fd-f4d9-d42d-f2fa9426db00@redhat.com>
Date: Fri, 7 Feb 2020 17:32:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-9-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
>=20
> This contains 3 main changes:
> 1. changes in SIE control block handling for secure guests
> 2. helper functions for create/destroy/unpack secure guests
> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
> machines
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
[...]
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index e1cef772fde1..7c21d55d2e49 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -23,11 +23,19 @@
>  #define UVC_RC_INV_STATE	0x0003
>  #define UVC_RC_INV_LEN		0x0005
>  #define UVC_RC_NO_RESUME	0x0007
> +#define UVC_RC_NEED_DESTROY	0x8000

This define is never used. I'd suggest to drop it.

The rest of the patch looks ok to me.

 Thomas
