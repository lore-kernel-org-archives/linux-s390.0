Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388574AbfJVMQT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Oct 2019 08:16:19 -0400
Subject: Re: [kvm-unit-tests PATCH v1 3/5] s390x: sclp: expose ram_size and
 max_ram_size
References: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com>
 <1571741584-17621-4-git-send-email-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4123dae6-bc6c-6177-3465-828f2cca086d@redhat.com>
Date: Tue, 22 Oct 2019 14:16:06 +0200
MIME-Version: 1.0
In-Reply-To: <1571741584-17621-4-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 22/10/2019 12.53, Claudio Imbrenda wrote:
> Expose ram_size and max_ram_size through accessor functions.
>=20
> We only use get_ram_size in an upcoming patch, but having an accessor
> for the other one does not hurt.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  lib/s390x/sclp.h | 2 ++
>  lib/s390x/sclp.c | 9 +++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index f00c3df..6d40fb7 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -272,5 +272,7 @@ void sclp_console_setup(void);
>  void sclp_print(const char *str);
>  int sclp_service_call(unsigned int command, void *sccb);
>  void sclp_memory_setup(void);
> +uint64_t get_ram_size(void);
> +uint64_t get_max_ram_size(void);
> =20
>  #endif /* SCLP_H */
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 56fca0c..a57096c 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -167,3 +167,12 @@ void sclp_memory_setup(void)
> =20
>  =09mem_init(ram_size);
>  }
> +
> +uint64_t get_ram_size(void)
> +{
> +=09return ram_size;
> +}
> +uint64_t get_max_ram_size(void)
> +{
> +=09return max_ram_size;
> +}

In case you respin, please add an empty line between the two functions.

Reviewed-by: Thomas Huth <thuth@redhat.com>
