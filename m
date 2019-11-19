Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57487 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfKSNOd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 08:14:33 -0500
Subject: Re: [kvm-unit-tests PATCH v4 1/3] s390x: export sclp_setup_int
References: <1574157219-22052-1-git-send-email-imbrenda@linux.ibm.com>
 <1574157219-22052-2-git-send-email-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ddea0bc-df5a-6af6-a7b4-494565ea0005@redhat.com>
Date: Tue, 19 Nov 2019 14:14:20 +0100
MIME-Version: 1.0
In-Reply-To: <1574157219-22052-2-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 19/11/2019 10.53, Claudio Imbrenda wrote:
> Export sclp_setup_int() so that it can be used from outside.
>=20
> Needed for an upocoming unit test.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/sclp.h | 1 +
>  lib/s390x/sclp.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 6d40fb7..675f07e 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -265,6 +265,7 @@ typedef struct ReadEventData {
>  } __attribute__((packed)) ReadEventData;
> =20
>  extern char _sccb[];
> +void sclp_setup_int(void);
>  void sclp_handle_ext(void);
>  void sclp_wait_busy(void);
>  void sclp_mark_busy(void);
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 7798f04..123b639 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -45,7 +45,7 @@ static void mem_init(phys_addr_t mem_end)
>  =09page_alloc_ops_enable();
>  }
> =20
> -static void sclp_setup_int(void)
> +void sclp_setup_int(void)
>  {
>  =09uint64_t mask;

Reviewed-by: Thomas Huth <thuth@redhat.com>
