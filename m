Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EA12DD8A;
	Mon, 26 Feb 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966187; cv=none; b=FJ9G61Fis5Aq2vfQzbJOnXBe6gcfcQVryyA3E9HbfnboVGDHV4Za2/ciLWMGsgm2oGl+M64bKTS/SeGjTEQhOGTyzM1BJ+E/egvJjP8X/wztk2hXgwuaaJDyH7vaRKN8boGhWnXZPdzMT2UiC3uwW9g4UvJzvcauyjqHCMeU1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966187; c=relaxed/simple;
	bh=rRwp3y1UoEUs1ENBOBzN6Gkda+Yxv9jf7eRMUiz/BEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEwWN68j7tfFkXir6ypko+eW2oIkBLzPCKcugro2vAsoD7sWb3fdaU3FJ7F2/hr38wHJBD74ZGv6JCOjHCKPAgAJu/ez4+2513hRz5r5wvXTWqLM31ozf8C4PFtT8MxF7Jfk5c+tgL59s6aNRDRSpMDXqO28kKJ7MPb9tYIhdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cz2sY0Ch; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cz2sY0Ch"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGgaeQ003155;
	Mon, 26 Feb 2024 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3G6oUB+OUrj8xjbE8pP7v+uZ/8Jkd4n2ak6J1iB/nos=;
 b=Cz2sY0ChQkuVSZBdEEsgZ9WPeck2WQ2x5E9Kyju0LfE1FEyOoT3JsZiTE2Os8jkcpK8w
 X6XHMt9HOy5OYrnrIJ3qXpBs96XOu9S7+na8P1QzOLEZqBtw+940SS+of2lP5M3zI0CE
 94g6koaTqD9ZH930MmgOd74z5m8Nj/6aj/XMiTX8UAMM3ItRcFElSMbQCJaVGQdo47da
 r8fdE57ABEX4iBRvX817D69T5dxGuPNwZfXyZ8IZixv8X7xgdsm0GQ20UvppzE0GR0s2
 4J1lGwhJRKSz31n5G9DWnoEX5R6djRtTPo5+oeENlE/fqAvbEKjubZpuskgSmmoI537r sQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxd4g683-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:49:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFAF2q008170;
	Mon, 26 Feb 2024 16:49:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9m299r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:49:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QGnXqY18743628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 16:49:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E402F5805D;
	Mon, 26 Feb 2024 16:49:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5519058061;
	Mon, 26 Feb 2024 16:49:31 +0000 (GMT)
Received: from [9.171.88.168] (unknown [9.171.88.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 16:49:31 +0000 (GMT)
Message-ID: <14bad51d-734e-4d4e-b47a-3f6af6794a40@linux.ibm.com>
Date: Mon, 26 Feb 2024 17:49:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dasd: move queue setup to common code
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20240221125438.3609762-1-hch@lst.de>
 <20240221125438.3609762-3-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240221125438.3609762-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nz_7OR4cA67KLw0xPcCFlhsi_An089km
X-Proofpoint-ORIG-GUID: Nz_7OR4cA67KLw0xPcCFlhsi_An089km
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260127

Please see comments below.

Am 21.02.24 um 13:54 schrieb Christoph Hellwig:
> Most of the code in setup_blk_queue is shared between all disciplines.
> Move it to common code and leave a method to query the maximum number
> of transferable blocks, and a flag to indicate discard support.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/s390/block/dasd.c      | 29 +++++++++++++++++++++++++++--
>   drivers/s390/block/dasd_diag.c | 22 +++-------------------
>   drivers/s390/block/dasd_eckd.c | 29 ++++++-----------------------
>   drivers/s390/block/dasd_fba.c  | 33 ++++-----------------------------
>   drivers/s390/block/dasd_int.h  |  6 ++----
>   5 files changed, 42 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index e754e4f81b2dff..665f69dbb9eab1 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -308,6 +308,7 @@ static int dasd_state_basic_to_known(struct dasd_device *device)
>   static int dasd_state_basic_to_ready(struct dasd_device *device)
>   {
>   	struct dasd_block *block = device->block;
> +	struct request_queue *q;
>   	int rc = 0;
>   
>   	/* make disk known with correct capacity */
> @@ -327,8 +328,32 @@ static int dasd_state_basic_to_ready(struct dasd_device *device)
>   		goto out;
>   	}
>   
> -	if (device->discipline->setup_blk_queue)
> -		device->discipline->setup_blk_queue(block);
> +	q = block->gdp->queue;
> +	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> +	q->limits.max_dev_sectors = device->discipline->max_transfer(block);
> +	blk_queue_max_hw_sectors(q, q->limits.max_dev_sectors);
> +	blk_queue_logical_block_size(q, block->bp_block);
> +	blk_queue_max_segments(q, USHRT_MAX);
> +
> +	/* With page sized segments each segment can be translated into one idaw/tidaw */
> +	blk_queue_max_segment_size(q, PAGE_SIZE);
> +	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
> +	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
> +
> +	if (device->discipline->has_discard) {
> +		unsigned int max_bytes, max_discard_sectors;
> +
> +		q->limits.discard_granularity = block->bp_block;
> +
> +		/* Calculate max_discard_sectors and make it PAGE aligned */
> +		max_bytes = USHRT_MAX * block->bp_block;
> +		max_bytes = ALIGN_DOWN(max_bytes, PAGE_SIZE);
> +		max_discard_sectors = max_bytes / block->bp_block;
> +
> +		blk_queue_max_discard_sectors(q, max_discard_sectors);
> +		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
> +	}
> +
>   	set_capacity(block->gdp, block->blocks << block->s2b_shift);
>   	device->state = DASD_STATE_READY;
>   
> diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
> index 041088c7e90915..688097036c6a37 100644
> --- a/drivers/s390/block/dasd_diag.c
> +++ b/drivers/s390/block/dasd_diag.c
> @@ -617,25 +617,9 @@ dasd_diag_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
>   		    "dump sense not available for DIAG data");
>   }
>   
> -/*
> - * Initialize block layer request queue.
> - */
> -static void dasd_diag_setup_blk_queue(struct dasd_block *block)
> +static unsigned int dasd_diag_max_transfer(struct dasd_block *block)

Could we call this dasd_*_max_sectors() or something like this?
We have a storage server value 'transfer length factor' (referred as 
'unsigned int tlf' in the code).
This might be a little bit misleading for someone reading it with this 
background.

>   {
> -	unsigned int logical_block_size = block->bp_block;
> -	struct request_queue *q = block->gdp->queue;
> -	int max;
> -
> -	max = DIAG_MAX_BLOCKS << block->s2b_shift;
> -	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> -	q->limits.max_dev_sectors = max;
> -	blk_queue_logical_block_size(q, logical_block_size);
> -	blk_queue_max_hw_sectors(q, max);
> -	blk_queue_max_segments(q, USHRT_MAX);
> -	/* With page sized segments each segment can be translated into one idaw/tidaw */
> -	blk_queue_max_segment_size(q, PAGE_SIZE);
> -	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
> -	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
> +	return DIAG_MAX_BLOCKS;

You are dropping the shift here (and in the other discipline cases). 
This might lead to smaller request sizes and decreased performance.
Should be:

return DIAG_MAX_BLOCKS << block->s2b_shift;


>   }
>   
>   static int dasd_diag_pe_handler(struct dasd_device *device,
> @@ -648,10 +632,10 @@ static struct dasd_discipline dasd_diag_discipline = {
>   	.owner = THIS_MODULE,
>   	.name = "DIAG",
>   	.ebcname = "DIAG",
> +	.max_transfer = dasd_diag_max_transfer,
>   	.check_device = dasd_diag_check_device,
>   	.pe_handler = dasd_diag_pe_handler,
>   	.fill_geometry = dasd_diag_fill_geometry,
> -	.setup_blk_queue = dasd_diag_setup_blk_queue,
>   	.start_IO = dasd_start_diag,
>   	.term_IO = dasd_diag_term_IO,
>   	.handle_terminated_request = dasd_diag_handle_terminated_request,
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index 8aade17d885cc9..8574516bf66e01 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -6826,17 +6826,9 @@ static void dasd_eckd_handle_hpf_error(struct dasd_device *device,
>   	dasd_schedule_requeue(device);
>   }
>   
> -/*
> - * Initialize block layer request queue.
> - */
> -static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
> +static unsigned int dasd_eckd_max_transfer(struct dasd_block *block)
>   {
> -	unsigned int logical_block_size = block->bp_block;
> -	struct request_queue *q = block->gdp->queue;
> -	struct dasd_device *device = block->base;
> -	int max;
> -
> -	if (device->features & DASD_FEATURE_USERAW) {
> +	if (block->base->features & DASD_FEATURE_USERAW) {
>   		/*
>   		 * the max_blocks value for raw_track access is 256
>   		 * it is higher than the native ECKD value because we
> @@ -6844,19 +6836,10 @@ static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
>   		 * so the max_hw_sectors are
>   		 * 2048 x 512B = 1024kB = 16 tracks
>   		 */
> -		max = DASD_ECKD_MAX_BLOCKS_RAW << block->s2b_shift;
> -	} else {
> -		max = DASD_ECKD_MAX_BLOCKS << block->s2b_shift;
> +		return DASD_ECKD_MAX_BLOCKS_RAW;
>   	}
> -	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> -	q->limits.max_dev_sectors = max;
> -	blk_queue_logical_block_size(q, logical_block_size);
> -	blk_queue_max_hw_sectors(q, max);
> -	blk_queue_max_segments(q, USHRT_MAX);
> -	/* With page sized segments each segment can be translated into one idaw/tidaw */
> -	blk_queue_max_segment_size(q, PAGE_SIZE);
> -	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
> -	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
> +
> +	return DASD_ECKD_MAX_BLOCKS;

same here

>   }
>   
>   static struct ccw_driver dasd_eckd_driver = {
> @@ -6888,7 +6871,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
>   	.basic_to_ready = dasd_eckd_basic_to_ready,
>   	.online_to_ready = dasd_eckd_online_to_ready,
>   	.basic_to_known = dasd_eckd_basic_to_known,
> -	.setup_blk_queue = dasd_eckd_setup_blk_queue,
> +	.max_transfer = dasd_eckd_max_transfer,
>   	.fill_geometry = dasd_eckd_fill_geometry,
>   	.start_IO = dasd_start_IO,
>   	.term_IO = dasd_term_IO,
> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index 045e548630dfb1..d075e70d3796bd 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
> @@ -748,35 +748,9 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
>   	free_page((unsigned long) page);
>   }
>   
> -/*
> - * Initialize block layer request queue.
> - */
> -static void dasd_fba_setup_blk_queue(struct dasd_block *block)
> +static unsigned int dasd_fba_max_transfer(struct dasd_block *block)
>   {
> -	unsigned int logical_block_size = block->bp_block;
> -	struct request_queue *q = block->gdp->queue;
> -	unsigned int max_bytes, max_discard_sectors;
> -	int max;
> -
> -	max = DASD_FBA_MAX_BLOCKS << block->s2b_shift;
> -	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> -	q->limits.max_dev_sectors = max;
> -	blk_queue_logical_block_size(q, logical_block_size);
> -	blk_queue_max_hw_sectors(q, max);
> -	blk_queue_max_segments(q, USHRT_MAX);
> -	/* With page sized segments each segment can be translated into one idaw/tidaw */
> -	blk_queue_max_segment_size(q, PAGE_SIZE);
> -	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
> -
> -	q->limits.discard_granularity = logical_block_size;
> -
> -	/* Calculate max_discard_sectors and make it PAGE aligned */
> -	max_bytes = USHRT_MAX * logical_block_size;
> -	max_bytes = ALIGN_DOWN(max_bytes, PAGE_SIZE);
> -	max_discard_sectors = max_bytes / logical_block_size;
> -
> -	blk_queue_max_discard_sectors(q, max_discard_sectors);
> -	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
> +	return DASD_FBA_MAX_BLOCKS;

and here

[...]

