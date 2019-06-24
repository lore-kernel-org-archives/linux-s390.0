Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729001AbfFXPNg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Jun 2019 11:13:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OExIpR007352
        for <linux-s390@vger.kernel.org>; Mon, 24 Jun 2019 11:13:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb017kucb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 24 Jun 2019 11:13:34 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Mon, 24 Jun 2019 16:13:32 +0100
Subject: Re: [PATCH V5 10/16] s390: zfcp_fc: use sg helper to operate
 scatterlist
References: <20190618013757.22401-1-ming.lei@redhat.com>
 <20190618013757.22401-11-ming.lei@redhat.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 24 Jun 2019 17:13:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190618013757.22401-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <95bfa1fb-d0eb-fc61-ecc0-001ae52a326f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>, Cathy Avery <cavery@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>, Brian King <brking@us.ibm.com>, James Smart <james.smart@broadcom.com>, "Juergen E . Fischer" <fischer@norbit.de>, Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Block <bblock@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

Hi Ming,

On 6/18/19 3:37 AM, Ming Lei wrote:
> Use the scatterlist iterators and remove direct indexing of the
> scatterlist array.
> 
> This way allows us to pre-allocate one small scatterlist, which can be
> chained with one runtime allocated scatterlist if the pre-allocated one
> isn't enough for the whole request.
> 
> Cc: Steffen Maier <maier@linux.ibm.com>
> Cc: Benjamin Block <bblock@linux.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Acked-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/s390/scsi/zfcp_fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index 33eddb02ee30..b018b61bd168 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -620,7 +620,7 @@ static void zfcp_fc_sg_free_table(struct scatterlist *sg, int count)
>   {
>   	int i;
>   
> -	for (i = 0; i < count; i++, sg++)
> +	for (i = 0; i < count; i++, sg = sg_next(sg))
>   		if (sg)
>   			free_page((unsigned long) sg_virt(sg));
>   		else
> @@ -641,7 +641,7 @@ static int zfcp_fc_sg_setup_table(struct scatterlist *sg, int count)
>   	int i;
>   
>   	sg_init_table(sg, count);
> -	for (i = 0; i < count; i++, sg++) {
> +	for (i = 0; i < count; i++, sg = sg_next(sg)) {
>   		addr = (void *) get_zeroed_page(GFP_KERNEL);
>   		if (!addr) {
>   			zfcp_fc_sg_free_table(sg, i);
> 

I'm still catching up with emails that came during my vacation, so I'm not 
fully up-to-date on the current state of this and how to bring in potential 
fixups on top.

I think, we also have two more (not so obvious) places in the corresponding 
response/completion code path, where we might need to introduce the proper 
iterator helper:

zfcp_fsf.c:

static int zfcp_fc_eval_gpn_ft(struct zfcp_fc_req *fc_req,
			       struct zfcp_adapter *adapter, int max_entries)
{
	struct scatterlist *sg = &fc_req->sg_rsp;
...
	/* first entry is the header */
	for (x = 1; x < max_entries && !last; x++) {
...
		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
...
		else
			acc = sg_virt(++sg);
                                       ^^^^

zfcp_dbf.c:

static u16 zfcp_dbf_san_res_cap_len_if_gpn_ft(char *tag,
					      struct zfcp_fsf_req *fsf,
					      u16 len)
{
	struct scatterlist *resp_entry = ct_els->resp;
...
	/* the basic CT_IU preamble is the same size as one entry in the GPN_FT
	 * response, allowing us to skip special handling for it - just skip it
	 */
	for (x = 1; x < max_entries && !last; x++) {
		if (x % (ZFCP_FC_GPN_FT_ENT_PAGE + 1))
...
		else
			acc = sg_virt(++resp_entry);
                                       ^^^^^^^^^^^^


What do you think?

-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
