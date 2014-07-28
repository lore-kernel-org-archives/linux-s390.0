Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53D65D53.8000602@linux.vnet.ibm.com>
Date: Mon, 28 Jul 2014 16:25:23 +0200
From: Steffen Maier <maier@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] s390: scsi: zfcp_aux.c:  Cleaning up missing null-terminate
 in conjunction with strncpy
References: <1406385418-3393-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1406385418-3393-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux390@de.ibm.com
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/26/2014 04:36 PM, Rickard Strandqvist wrote:
> Replacing strncpy with strlcpy to avoid strings that lacks null terminate.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>
> ---
>   drivers/s390/scsi/zfcp_aux.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index 8004b07..a23ba76 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -101,7 +101,7 @@ static void __init zfcp_init_device_setup(char *devst=
r)
>   	token =3D strsep(&str, ",");
>   	if (!token || strlen(token) >=3D ZFCP_BUS_ID_SIZE)
>   		goto err_out;

Due to the check for strlen(token) >=3D ZFCP_BUS_ID_SIZE we should be safe =

even with strlcpy because we would reject any user string that does not=20
fit into busid including the trailing zero character.

Since it works either way, we can change it though,

Acked-by: Steffen Maier <maier@linux.vnet.ibm.com>

> -	strncpy(busid, token, ZFCP_BUS_ID_SIZE);
> +	strlcpy(busid, token, ZFCP_BUS_ID_SIZE);
>
>   	token =3D strsep(&str, ",");
>   	if (!token || kstrtoull(token, 0, (unsigned long long *) &wwpn))
>

--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on System z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
