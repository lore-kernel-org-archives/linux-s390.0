Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731525AbfJVPo0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Oct 2019 11:44:26 -0400
Subject: Re: [kvm-unit-tests PATCH v1 2/5] s390x: improve error reporting for
 interrupts
References: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com>
 <1571741584-17621-3-git-send-email-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <664db049-3715-64d3-66dc-a61d9228c515@redhat.com>
Date: Tue, 22 Oct 2019 17:44:20 +0200
MIME-Version: 1.0
In-Reply-To: <1571741584-17621-3-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 22.10.19 12:53, Claudio Imbrenda wrote:
> Improve error reporting for unexpected external interrupts to also
> print the received external interrupt code.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   lib/s390x/interrupt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 5cade23..1636207 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -118,8 +118,8 @@ void handle_ext_int(void)
>   {
>   =09if (!ext_int_expected &&
>   =09    lc->ext_int_code !=3D EXT_IRQ_SERVICE_SIG) {
> -=09=09report_abort("Unexpected external call interrupt: at %#lx",
> -=09=09=09     lc->ext_old_psw.addr);
> +=09=09report_abort("Unexpected external call interrupt (code %#x): at %#=
lx",
> +=09=09=09     lc->ext_int_code, lc->ext_old_psw.addr);
>   =09=09return;
>   =09}
>  =20
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
