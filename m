From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/10] zfcp: restore: Dont use 0 to indicate invalid LUN
 in rec trace
Date: Thu, 11 Aug 2016 13:22:24 +0200
Message-ID: <bdd945f4-2ce6-3fd0-3ea8-1e12fb8d7d51@suse.de>
References: <1470846653-90691-1-git-send-email-maier@linux.vnet.ibm.com>
 <1470846653-90691-6-git-send-email-maier@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1470846653-90691-6-git-send-email-maier@linux.vnet.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "#2 . 6 . 38+" <stable@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 08/10/2016 06:30 PM, Steffen Maier wrote:
> bring back
> commit d21e9daa63e009ce5b87bbcaa6d11ce48e07bbbe
> ("[SCSI] zfcp: Dont use 0 to indicate invalid LUN in rec trace")
> which was lost with
> commit ae0904f60fab7cb20c48d32eefdd735e478b91fb
> ("[SCSI] zfcp: Redesign of the debug tracing for recovery actions.")
>=20
> Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
> Fixes: ae0904f60fab ("[SCSI] zfcp: Redesign of the debug tracing for reco=
very actions.")
> Cc: <stable@vger.kernel.org> #2.6.38+
> Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
> ---
>  drivers/s390/scsi/zfcp_dbf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index 2308253ddddc..e6ff199f7572 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c
> @@ -241,7 +241,8 @@ static void zfcp_dbf_set_common(struct zfcp_dbf_rec *=
rec,
>  	if (sdev) {
>  		rec->lun_status =3D atomic_read(&sdev_to_zfcp(sdev)->status);
>  		rec->lun =3D zfcp_scsi_dev_lun(sdev);
> -	}
> +	} else
> +		rec->lun =3D ZFCP_DBF_INVALID_LUN;
>  }
> =20
>  /**
>=20
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
