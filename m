Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DB35674E
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231706; cv=none; b=TZOkhlUCh0LwJRqWKctL2N3PuuzdGXku3RpGmnQXaJ0vHQhkWqDNKRiQIhBa4/RywMeMJh+e4YPCT6I7yTgGcy+VPSmlYtQdyny9T/3Aa/1A/77ukePfgDxz0y5MaFXRu3luuF0sUdexm+cKGUvI1/aAx86EcZUPlw7YZt38Mm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231706; c=relaxed/simple;
	bh=MwS54pwOVnwWgMatoTW+seWe94sR7xx/zx9by6IlTFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nk0/c4/ZfMrsZKWW1KKyiKurc4AIhG893GVo8WWRHKEKc7biCbuy1rY/SUoPVjNV8GPZsZ1ndmksdhNzh5l7KpvN4sufA2pSvU5+1zZeej7bQKR73CXXPjnPmEHu8qd7Op7Il+Shg5YdlwETaID/eGdtgJNqRpVHgOoVuEGeUZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw91FujK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw91FujK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6331F000FF;
	Thu, 24 Sep 2026 06:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231704;
	bh=Ih+xRxvtcbOWl3eKF+dDraCYNdGV/OMWUk3KK3PBYds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kw91FujKyRzriKyWB40Pe8a0t9nyBDkonY9e5Jj4JKytGf+PhN9G4TFMroalkOfnt
	 PlwKK7rNBrzjBBZsQUYJIKY1RcCR7m5Q6D+YensWFYASSCr4qwHds/ZSBNtfXyyhmN
	 Y0/tXuhGrBZUKje/X7ZibsSUrlWqzl5AYo19dKlM+censuZrwZJzFCTQ+tlATn19bc
	 tRUTSsZIGwfTz0o454iJRJmxNx8uENY8boPlU8LCgtQ/qg7a1smfx6F32BAdynhpVC
	 WpkJOyxrzMinwHtdRIIcLuHSQuSa9dS2UcdBmi9jBuI80pajg1TZe8sKzIbY4C6rps
	 HLg1GMOrWpgHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/2] zfcp: Use DMA streaming API to map I/O
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260924060923.3076902-3-nikh1092@linux.ibm.com>
References: <20260924060923.3076902-1-nikh1092@linux.ibm.com>
 <20260924060923.3076902-3-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:35:03 +0000
Message-Id: <20260924063504.2E6331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] scsi: NULL pointer dereference in DMA mapping of SCSI scatterl=
ists
- [High] scsi: corrupted QDIO request queue on DMA mapping failure
- [High] scsi: hardware protocol error due to CPU/DMA segment count mismatch
- [High] scsi: transmission of stale data due to QTCB population after DMA =
mapping
- [High] scsi: permanent DMA mapping leak on aborted or forgotten SCSI comm=
ands
--

commit 2b39704cf1d28c9469faf5ad32bab284b1cbd1c2
Author: M Nikhil <nikh1092@linux.ibm.com>

zfcp: Use DMA streaming API to map I/O

This commit converts all I/O buffer mappings in the zFCP driver to use the
DMA streaming API. This ensures device DMA addresses are restricted to
non-guest-private, page-sized memory blocks, which is necessary for secure
execution environments. All I/O buffers are now represented using
scatter-gather lists.

> diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
> index a3b99839da9ec..371ef231d87b6 100644
> --- a/drivers/s390/scsi/zfcp_fsf.c
> +++ b/drivers/s390/scsi/zfcp_fsf.c
[ ... ]
> @@ -84,6 +85,60 @@ static void zfcp_fsf_class_not_supp(struct zfcp_fsf_re=
q *req)
>  	req->status |=3D ZFCP_STATUS_FSFREQ_ERROR;
>  }
> =20
> +/**
> + * zfcp_fsf_req_map_sg - map the scattergather list for DMA transfer
> + * @req: pointer to zfcp_fsf_req
> + * @sgt: pointer to scattergather list table
> + * @dma_dir: DMA data direction
> + * Returns: 0 on success, -EIO otherwise
> + */
> +int zfcp_fsf_req_map_sg(struct zfcp_fsf_req *req, struct sg_table *sgt,
> +			enum dma_data_direction dma_dir)
> +{
> +	if (valid_dma_direction(dma_dir) && sgt->orig_nents) {
> +		if (dma_map_sgtable(&req->adapter->ccw_device->dev, sgt,
> +				    dma_dir, 0))

[Severity: Critical]
Will dma_map_sgtable() crash here if the scatterlist has coalesced segments?

In the block/SCSI layer, orig_nents represents the allocated capacity, while
the actual number of populated/initialized segments is stored in nents after
blk_rq_map_sg() merges segments and marks the final initialized segment with
sg_mark_end().

Because dma_map_sgtable() relies on orig_nents to iterate, it will iterate
past the sg_mark_end() terminator if the initialized segment count is
smaller than the allocated capacity. This causes sg_next() to return NULL,
leading to a fatal NULL pointer dereference inside the architecture's DMA
mapping implementation.

> +			return -EIO;
> +	} else if ((dma_dir =3D=3D DMA_NONE) && sgt->orig_nents) {
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * zfcp_fsf_req_unmap_sg - unmap the scattergather list after DMA transf=
er
> + * @req: pointer to zfcp_fsf_req
> + * @sgt: pointer to scattergather list table
> + * @dma_dir: DMA direction of the sg
> + */
> +void zfcp_fsf_req_unmap_sg(struct zfcp_fsf_req *req, struct sg_table *sg=
t,
> +			   enum dma_data_direction dma_dir)
> +{
> +	/*
> +	 * We still need the check for mapped sg count here to not perform
> +	 * unmap for SCSI commands which have zero payload.
> +	 */
> +	if (!sgt->nents)
> +		return;
> +
> +	dma_unmap_sgtable(&req->adapter->ccw_device->dev, sgt, dma_dir, 0);

[Severity: Critical]
Does the unmap path suffer from the identical issue?

If the initialized segment count is smaller than the allocated capacity,
dma_unmap_sgtable() could also iterate past the sg_mark_end() terminator
and trigger a NULL pointer dereference.

> +}
> +
[ ... ]
> @@ -870,10 +928,27 @@ static struct zfcp_fsf_req *zfcp_fsf_req_create(str=
uct zfcp_qdio *qdio,
>  		req->qtcb->prefix.qtcb_version =3D FSF_QTCB_CURRENT_VERSION;
>  		req->qtcb->header.req_handle =3D req->req_id;
>  		req->qtcb->header.fsf_command =3D fsf_cmd;
> -	}
> =20
> -	zfcp_qdio_req_init(adapter->qdio, &req->qdio_req, req->req_id, sbtype,
> -			   req->qtcb, sizeof(struct fsf_qtcb));
> +		sg_init_one(&req->metadata_sg, req->qtcb,
> +			    sizeof(struct fsf_qtcb));
> +		req->metadata_sgt.sgl =3D &req->metadata_sg;
> +		req->metadata_sgt.orig_nents =3D 1;
> +
> +		if (zfcp_fsf_req_map_sg(req, &req->metadata_sgt,
> +					DMA_BIDIRECTIONAL)) {

[Severity: High]
Could this DMA mapping snapshot the QTCB before critical fields are populat=
ed?

The metadata SG table is mapped for DMA here. However, callers of
zfcp_fsf_req_create() (such as zfcp_fsf_fcp_cmnd) proceed to populate
critical fields of the QTCB via normal CPU memory writes after this function
returns.

In systems using SWIOTLB (such as s390x Secure Execution environments), the
DMA mapping copies the initial state of the buffer into a bounce buffer at
mapping time.

Because there is no dma_sync_sgtable_for_device() following the CPU writes,
the bounce buffer retains the uninitialized state, and the FCP adapter will
process an empty or stale command.

> +			zfcp_fsf_req_free(req);
> +			return ERR_PTR(-EIO);
> +		}
[ ... ]
> @@ -1150,57 +1263,70 @@ static int zfcp_fsf_setup_ct_els_sbals(struct zfc=
p_fsf_req *req,
>  	u32 feat =3D adapter->adapter_features;
> =20
>  	if (zfcp_adapter_multi_buffer_active(adapter)) {
> -		if (zfcp_qdio_sbals_from_sg(qdio, &req->qdio_req, sg_req))
> +		if (zfcp_qdio_sbals_from_sg(qdio, sgt_req, req, DMA_TO_DEVICE))
>  			return -EIO;
> +
>  		qtcb->bottom.support.req_buf_length =3D
> -			zfcp_qdio_real_bytes(sg_req);
> -		if (zfcp_qdio_sbals_from_sg(qdio, &req->qdio_req, sg_resp))
> -			return -EIO;
> +			zfcp_qdio_real_bytes(sgt_req->sgl);
> +
> +		if (zfcp_qdio_sbals_from_sg(qdio, sgt_resp, req, DMA_FROM_DEVICE))
> +			goto err_unmap;

[Severity: High]
When chaining multiple SG tables, what happens if the second mapping call
fails?

The first zfcp_qdio_sbals_from_sg() call populates the SBALs successfully
using sgt_req. If the second mapping call for sgt_resp fails, the error path
aborts the request without clearing the SBAL elements dirtied by the first
call.

These SBALs retain stale descriptors. When the next request reuses these SB=
AL
positions, the QDIO hardware might read the corrupted boundary flags,
prematurely terminating scatter-gather list processing and dropping payload=
s.

> +
>  		qtcb->bottom.support.resp_buf_length =3D
> -			zfcp_qdio_real_bytes(sg_resp);
> +			zfcp_qdio_real_bytes(sgt_resp->sgl);
> =20
> -		zfcp_qdio_set_data_div(qdio, &req->qdio_req, sg_nents(sg_req));
> +		zfcp_qdio_set_data_div(qdio, &req->qdio_req,
> +				       sg_nents(sgt_req->sgl));

[Severity: High]
Is it safe to set the data division using the pre-mapped CPU segment count
rather than the DMA-mapped segment count?

The FCP adapter hardware expects the Data Division descriptor to specify the
number of hardware SBALEs mapped for the first buffer sequence. The code se=
ts
this count using sg_nents(sgt_req->sgl).

However, zfcp_qdio_sbals_from_sg() populates the SBALEs using
for_each_sgtable_dma_sg(), which iterates only sgt->nents times (the actual
number of coalesced DMA segments).

If the IOMMU coalesces segments, the Data Division count will be larger than
the actual number of SBALEs appended. The hardware could consume subsequent,
unrelated SBALEs as part of the request payload, causing silent data
corruption and hardware protocol violations.

>  		zfcp_qdio_set_sbale_last(qdio, &req->qdio_req);
>  		zfcp_qdio_set_scount(qdio, &req->qdio_req);
>  		return 0;
>  	}
[ ... ]
> @@ -2474,6 +2626,13 @@ static void zfcp_fsf_fcp_cmnd_handler(struct zfcp_=
fsf_req *req)
>  		return;
>  	}
> =20
> +	if ((scsi_get_prot_op(scpnt) !=3D SCSI_PROT_NORMAL) &&
> +	    scsi_prot_sg_count(scpnt))
> +		zfcp_fsf_req_unmap_sg(req, &scpnt->prot_sdb->table,
> +				      scpnt->sc_data_direction);
> +
> +	zfcp_fsf_req_unmap_sg(req, &scpnt->sdb.table, scpnt->sc_data_direction);
> +

[Severity: High]
Can aborted SCSI commands cause a permanent DMA mapping leak?

When a SCSI command times out, the error handling path (such as
zfcp_scsi_eh_abort_handler) detaches the FSF request from the SCSI command
by setting req->data =3D NULL.

When the hardware eventually completes the aborted request, this handler
is invoked. Because req->data is NULL, the handler returns early (just above
the added unmap lines), completely bypassing the calls to
zfcp_fsf_req_unmap_sg() for the SCSI data buffers.

Since the DMA mapping is now fully managed within zfcp, these IOVAs and
bounce buffer allocations would be leaked permanently, potentially exhausti=
ng
the IOMMU translation table under load.

>  	zfcp_fsf_fcp_handler_common(req, scpnt->device);
> =20
>  	if (unlikely(req->status & ZFCP_STATUS_FSFREQ_ERROR)) {
> @@ -2619,18 +2778,20 @@ int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *scsi_cmnd)
>  	    scsi_prot_sg_count(scsi_cmnd)) {
>  		zfcp_qdio_set_data_div(qdio, &req->qdio_req,
>  				       scsi_prot_sg_count(scsi_cmnd));
> -		retval =3D zfcp_qdio_sbals_from_sg(qdio, &req->qdio_req,
> -						 scsi_prot_sglist(scsi_cmnd));
> +		retval =3D zfcp_qdio_sbals_from_sg(qdio,
> +						 &scsi_cmnd->prot_sdb->table,
> +						 req,
> +						 scsi_cmnd->sc_data_direction);

[Severity: High]
Could the same CPU/DMA segment count mismatch occur here?

The code sets the data division using scsi_prot_sg_count() (the unmapped
protection segment count), while zfcp_qdio_sbals_from_sg() populates SBALEs
using the coalesced DMA segments.

>  		if (retval)
>  			goto failed_scsi_cmnd;
[ ... ]
> diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
> index bac8385e069fa..7e15b1a470e70 100644
> --- a/drivers/s390/scsi/zfcp_qdio.c
> +++ b/drivers/s390/scsi/zfcp_qdio.c
> @@ -233,31 +233,40 @@ zfcp_qdio_sbale_next(struct zfcp_qdio *qdio, struct=
 zfcp_qdio_req *q_req)
>  }
> =20
>  /**
> - * zfcp_qdio_sbals_from_sg - fill SBALs from scatter-gather list
> + * zfcp_qdio_sbals_from_sg - DMA map scatter-gather list and fill SBALs =
from it
>   * @qdio: pointer to struct zfcp_qdio
> - * @q_req: pointer to struct zfcp_qdio_req
> - * @sg: scatter-gather list
> - * Returns: zero or -EINVAL on error
> + * @sgt: pointer to scattergather list table
> + * @req: pointer to zfcp_fsf_req
> + * @dma_dir: DMA direction of I/O
> + * Returns: zero on success, -EINVAL or -EIO otherwise
>   */
> -int zfcp_qdio_sbals_from_sg(struct zfcp_qdio *qdio, struct zfcp_qdio_req=
 *q_req,
> -			    struct scatterlist *sg)
> +int zfcp_qdio_sbals_from_sg(struct zfcp_qdio *qdio, struct sg_table *sgt,
> +			    struct zfcp_fsf_req *req,
> +			    enum dma_data_direction dma_dir)
>  {
>  	struct qdio_buffer_element *sbale;
> +	int i;
> +	struct scatterlist *sg_element;
> +
> +	if (zfcp_fsf_req_map_sg(req, sgt, dma_dir))
> +		return -EIO;

[Severity: High]
Can this early return corrupt the QDIO request queue?

If zfcp_fsf_req_map_sg() fails here, the function returns -EIO immediately
without calling zfcp_qdio_zero_sbals() to zero the reserved SBALs in the
queue.

> =20
>  	/* set storage-block type for this request */
> -	sbale =3D zfcp_qdio_sbale_req(qdio, q_req);
> -	sbale->sflags |=3D q_req->sbtype;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060923.3076=
902-1-nikh1092@linux.ibm.com?part=3D2
