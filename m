Return-Path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406010572-13217-1-git-send-email-xerofoify@gmail.com>
References: <1406010572-13217-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] s390: Fix me in dasd_eer.c
From: Stefan Weinhuber <WEIN@de.ibm.com>
Message-ID: <OF27B55084.24F3FB57-ONC1257D23.0054AF74-C1257D23.0058198E@de.ibm.com>
Date: Mon, 28 Jul 2014 18:02:13 +0200
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: BOEBLINGEN LINUX390 <LINUX390@de.ibm.com>, heicars2@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mschwid2@linux.vnet.ibm.com, Stefan Haberland1 <stefan.haberland@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Nicholas Krause <xerofoify@gmail.com> wrote on 2014-07-22 08:29:32:

[..]=20
> Subject:
>=20
> [PATCH] s390: Fix me in dasd_eer.c
>=20
> This patch changes return type to EMEDUIMTYPE in function,=20
dasd_eer_enable
> for when checking if the medium has no errors according to this=20
function.
>=20
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/s390/block/dasd_eer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/s390/block/dasd_eer.c=20
b/drivers/s390/block/dasd_eer.c
> index 21ef63c..08ee040 100644
> --- a/drivers/s390/block/dasd_eer.c
> +++ b/drivers/s390/block/dasd_eer.c
> @@ -462,7 +462,7 @@ int dasd_eer_enable(struct dasd_device *device)
>        return 0;
>=20
>     if (!device->discipline || strcmp(device->discipline->name, "ECKD"))
> -      return -EPERM;   /* FIXME: -EMEDIUMTYPE ? */
> +      return -EMEDIUMTYPE;   /* FIXME: -EMEDIUMTYPE ? */
>=20
>     cqr =3D dasd_kmalloc_request(DASD_ECKD_MAGIC, 1 /* SNSS */,
>                 SNSS_DATA_SIZE, device);
> --=20
> 1.9.1
>

Hm, after some consideration, I have to disagree with your suggestion.
If you try to enable EER on an FBA device, you will get the following
result with current code:

$ echo 1 > eer_enabled
-bash: echo: write error: Operation not permitted

and with your code the following:

$ echo 1 > eer_enabled
-bash: echo: write error: Wrong medium type

When I wrote this code, I was not sure which one is better. But today I=20
say
that the 'Operation not permitted' is more to the point. An FBA device
has no (changable) medium, so what could be wrong about its type?
Could be confusing.

From your patch description I do not really get why you want to change the
return code. Why do you think that EMEDIUMTYPE is better than EPERM?

Mit freundlichen Gr=FC=DFen / Kind regards
=20
Stefan Weinhuber
