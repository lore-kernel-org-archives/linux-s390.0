From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 07/10] zfcp: restore tracing of handle for port and LUN
 with HBA records
Date: Thu, 11 Aug 2016 13:23:23 +0200
Message-ID: <315328c1-cbce-f97a-a035-17aea2643b56@suse.de>
References: <1470846653-90691-1-git-send-email-maier@linux.vnet.ibm.com>
 <1470846653-90691-8-git-send-email-maier@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1470846653-90691-8-git-send-email-maier@linux.vnet.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "#2 . 6 . 38+" <stable@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 08/10/2016 06:30 PM, Steffen Maier wrote:
> This information was lost with
> commit a54ca0f62f953898b05549391ac2a8a4dad6482b
> ("[SCSI] zfcp: Redesign of the debug tracing for HBA records.")
> but is required to debug e.g. invalid handle situations.
>=20
> Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
> Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA =
records.")
> Cc: <stable@vger.kernel.org> #2.6.38+
> Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
> ---
>  drivers/s390/scsi/zfcp_dbf.c | 2 ++
>  drivers/s390/scsi/zfcp_dbf.h | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index df68a4df8cdb..ceb934c93232 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c
> @@ -85,6 +85,8 @@ void zfcp_dbf_hba_fsf_res(char *tag, int level, struct =
zfcp_fsf_req *req)
>  	rec->u.res.req_issued =3D req->issued;
>  	rec->u.res.prot_status =3D q_pref->prot_status;
>  	rec->u.res.fsf_status =3D q_head->fsf_status;
> +	rec->u.res.port_handle =3D q_head->port_handle;
> +	rec->u.res.lun_handle =3D q_head->lun_handle;
> =20
>  	memcpy(rec->u.res.prot_status_qual, &q_pref->prot_status_qual,
>  	       FSF_PROT_STATUS_QUAL_SIZE);
> diff --git a/drivers/s390/scsi/zfcp_dbf.h b/drivers/s390/scsi/zfcp_dbf.h
> index c879b54046ee..6ee46f1f9e43 100644
> --- a/drivers/s390/scsi/zfcp_dbf.h
> +++ b/drivers/s390/scsi/zfcp_dbf.h
> @@ -131,6 +131,8 @@ struct zfcp_dbf_hba_res {
>  	u8  prot_status_qual[FSF_PROT_STATUS_QUAL_SIZE];
>  	u32 fsf_status;
>  	u8  fsf_status_qual[FSF_STATUS_QUALIFIER_SIZE];
> +	u32 port_handle;
> +	u32 lun_handle;
>  } __packed;
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
