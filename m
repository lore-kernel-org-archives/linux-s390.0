Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727899AbgGHJN0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 05:13:26 -0400
Subject: Re: [PATCH][next] s390/dasd: Use struct_size() helper
References: <20200619165600.GA8668@embeddedor>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <47a86753-fd4d-9a7a-c808-5f387c872ab3@linux.ibm.com>
Date: Wed, 8 Jul 2020 11:13:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200619165600.GA8668@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Am 19.06.20 um 18:56 schrieb Gustavo A. R. Silva:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> variable _datasize_.
>
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for the patch.
Tested and applied.

> ---
>  drivers/s390/block/dasd_diag.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
> index facb588d09e4..7f53ba015300 100644
> --- a/drivers/s390/block/dasd_diag.c
> +++ b/drivers/s390/block/dasd_diag.c
> @@ -506,7 +506,7 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
>  	struct req_iterator iter;
>  	struct bio_vec bv;
>  	char *dst;
> -	unsigned int count, datasize;
> +	unsigned int count;
>  	sector_t recid, first_rec, last_rec;
>  	unsigned int blksize, off;
>  	unsigned char rw_cmd;
> @@ -534,10 +534,8 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
>  	if (count != last_rec - first_rec + 1)
>  		return ERR_PTR(-EINVAL);
>  	/* Build the request */
> -	datasize = sizeof(struct dasd_diag_req) +
> -		count*sizeof(struct dasd_diag_bio);
> -	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, datasize, memdev,
> -				   blk_mq_rq_to_pdu(req));
> +	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, struct_size(dreq, bio, count),
> +				   memdev, blk_mq_rq_to_pdu(req));
>  	if (IS_ERR(cqr))
>  		return cqr;
>  
