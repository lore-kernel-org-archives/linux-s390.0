Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726717AbfKOHMs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 02:12:48 -0500
Subject: Re: [PATCH v1 3/4] s390x:irq: make IRQ handler weak
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-4-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5fc6450e-ec88-d500-7fc9-9e17e41f2dd0@redhat.com>
Date: Fri, 15 Nov 2019 08:12:38 +0100
MIME-Version: 1.0
In-Reply-To: <1573647799-30584-4-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com

On 13/11/2019 13.23, Pierre Morel wrote:
> Having a weak function allows the tests programm to declare its own IRQ
> handler.
> This is helpfull when developping I/O tests.
> ---
>  lib/s390x/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 7aecfc5..0049194 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -140,7 +140,7 @@ void handle_mcck_int(sregs_t *regs)
>  =09=09     lc->mcck_old_psw.addr);
>  }
> =20
> -void handle_io_int(sregs_t *regs)
> +__attribute__((weak)) void handle_io_int(sregs_t *regs)
>  {
>  =09report_abort("Unexpected io interrupt: at %#lx",
>  =09=09     lc->io_old_psw.addr);
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
