From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/8] s390: replace zfcp_qdio_sbale_count by sg_nents
Date: Wed, 30 Sep 2015 15:59:16 +0200
Message-ID: <560BEAB4.10702@linux.vnet.ibm.com>
References: <1442581036-23789-1-git-send-email-clabbe.montjoie@gmail.com>
 <1442581036-23789-5-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1442581036-23789-5-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-crypto-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-crypto/>
List-Post: <mailto:linux-crypto@vger.kernel.org>
To: LABBE Corentin <clabbe.montjoie@gmail.com>, herbert@gondor.apana.org.au, davem@davemloft.net, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Thanks, looks good.

I've added it to my queue for sending zfcp patches upstream next time=20
(might take a while).

On 09/18/2015 02:57 PM, LABBE Corentin wrote:
> The zfcp_qdio_sbale_count function do the same work than sg_nents().
> So replace it by sg_nents() for removing duplicate code.
>
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>   drivers/s390/scsi/zfcp_fsf.c  |  3 +--
>   drivers/s390/scsi/zfcp_qdio.h | 15 ---------------
>   2 files changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fs=
f.c
> index 522a633..edc137a 100644
> --- a/drivers/s390/scsi/zfcp_fsf.c
> +++ b/drivers/s390/scsi/zfcp_fsf.c
> @@ -985,8 +985,7 @@ static int zfcp_fsf_setup_ct_els_sbals(struct zfc=
p_fsf_req *req,
>   		if (zfcp_qdio_sbals_from_sg(qdio, &req->qdio_req, sg_resp))
>   			return -EIO;
>
> -		zfcp_qdio_set_data_div(qdio, &req->qdio_req,
> -					zfcp_qdio_sbale_count(sg_req));
> +		zfcp_qdio_set_data_div(qdio, &req->qdio_req, sg_nents(sg_req));
>   		zfcp_qdio_set_sbale_last(qdio, &req->qdio_req);
>   		zfcp_qdio_set_scount(qdio, &req->qdio_req);
>   		return 0;
> diff --git a/drivers/s390/scsi/zfcp_qdio.h b/drivers/s390/scsi/zfcp_q=
dio.h
> index 497cd37..85cdb82 100644
> --- a/drivers/s390/scsi/zfcp_qdio.h
> +++ b/drivers/s390/scsi/zfcp_qdio.h
> @@ -225,21 +225,6 @@ void zfcp_qdio_set_data_div(struct zfcp_qdio *qd=
io,
>   }
>
>   /**
> - * zfcp_qdio_sbale_count - count sbale used
> - * @sg: pointer to struct scatterlist
> - */
> -static inline
> -unsigned int zfcp_qdio_sbale_count(struct scatterlist *sg)
> -{
> -	unsigned int count =3D 0;
> -
> -	for (; sg; sg =3D sg_next(sg))
> -		count++;
> -
> -	return count;
> -}
> -
> -/**
>    * zfcp_qdio_real_bytes - count bytes used
>    * @sg: pointer to struct scatterlist
>    */
>

--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
