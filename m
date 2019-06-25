Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59970 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfFYCBa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jun 2019 22:01:30 -0400
Date: Tue, 25 Jun 2019 12:01:24 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH V5 10/16] s390: zfcp_fc: use sg helper to operate
 scatterlist
In-Reply-To: <20190625011902.GA23777@ming.t460p>
Message-ID: <alpine.LNX.2.21.1906251157160.8@nippy.intranet>
References: <20190618013757.22401-1-ming.lei@redhat.com> <20190618013757.22401-11-ming.lei@redhat.com> <95bfa1fb-d0eb-fc61-ecc0-001ae52a326f@linux.ibm.com> <20190625011902.GA23777@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Steffen Maier <maier@linux.ibm.com>, linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>, Cathy Avery <cavery@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>, Brian King <brking@us.ibm.com>, James Smart <james.smart@broadcom.com>, "Juergen E . Fischer" <fischer@norbit.de>, Michael Schmitz <schmitzmic@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Block <bblock@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

> diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
> index dccdb41bed8c..c7129f5234f0 100644
> --- a/drivers/s390/scsi/zfcp_dbf.c
> +++ b/drivers/s390/scsi/zfcp_dbf.c
> @@ -552,7 +552,7 @@ static u16 zfcp_dbf_san_res_cap_len_if_gpn_ft(char *tag,
>  		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
>  			acc++;
>  		else
> -			acc = sg_virt(++resp_entry);
> +			acc = sg_virt(resp_entry = sg_next(resp_entry));

Shouldn't that be,

			acc = sg_virt(sg_next(resp_entry));

>  
>  		last = acc->fp_flags & FC_NS_FID_LAST;
>  	}
> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index b018b61bd168..5048812ce660 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -742,7 +742,7 @@ static int zfcp_fc_eval_gpn_ft(struct zfcp_fc_req *fc_req,
>  		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
>  			acc++;
>  		else
> -			acc = sg_virt(++sg);
> +			acc = sg_virt(sg = sg_next(sg));

and

			acc = sg_virt(sg_next(sg));

?

-- 

>  
>  		last = acc->fp_flags & FC_NS_FID_LAST;
>  		d_id = ntoh24(acc->fp_fid);
> -- 
> 2.20.1
> 
> 
> Thanks,
> Ming
> 
