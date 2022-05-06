Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFBC433FE
	for <linux-s390@archiver.kernel.org>; Fri,  6 May 2022 12:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390636AbiEFNDD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 May 2022 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356442AbiEFNDC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 May 2022 09:03:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175EA6338E;
        Fri,  6 May 2022 05:59:20 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246Bhqsi032725;
        Fri, 6 May 2022 12:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=evV7zW0Pkptdgxryp8q/nhaiY9RbM7s7Y7FBYLM1+3A=;
 b=Jpd/LqQ8qRyc1xkIsreNzVu3YNJxk4TaXrlRk5EXzrQXl5UeIjcnnMKpZQPsVJ0GWk+H
 4OO+eKdI0ysFLbuy272CQquw7xLwkRQ1s5GUWbXY8kFuS71Ceev4HZ45AsEQ8oZBvzjh
 vj9ZT2cWF915zG+QEbX57A1GZjGTBqhBXVby9LhxAVMXfdHc8D2HNV+6fPiIWZDjoX8J
 xQc3nUSMfgk+A0yFcqxH7BuTTwMYt5urI5Cc5SR3b708MtZCLHe7iDRxY/w+5R6s+qyZ
 89+99+cfayWa/722v5Fz4JyhE/P1cqJ/2euDxDC5GLt/zC7591d5SNeke9efRBlC4wae 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw3279f16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:57:05 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246C6GE1009740;
        Fri, 6 May 2022 12:57:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw3279f0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:57:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246CrK4Z028206;
        Fri, 6 May 2022 12:57:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fwgbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:57:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246Cv0dI39256422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 12:57:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2900A4053;
        Fri,  6 May 2022 12:56:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CD1EA4040;
        Fri,  6 May 2022 12:56:59 +0000 (GMT)
Received: from [9.145.54.141] (unknown [9.145.54.141])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 12:56:59 +0000 (GMT)
Message-ID: <1f26f6b4-4d33-6291-31c2-5cb68a5be829@linux.ibm.com>
Date:   Fri, 6 May 2022 14:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 07/11] dasd: don't set the discard_alignment queue limit
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        dm-devel@redhat.com
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-8-hch@lst.de>
From:   =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
In-Reply-To: <20220418045314.360785-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8a7-K9CSYxb93olkIOkZv_aoAnTW7JGG
X-Proofpoint-GUID: eBrk8yaxusH63MjrlJz40h5tJPgmJePg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060070
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/04/2022 06:53, Christoph Hellwig wrote:
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to PAGE_SIZE while the discard granularity is the block size
> that is smaller or the same as PAGE_SIZE as done by dasd is mostly
> harmless but also useless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Jan Höppner <hoeppner@linux.ibm.com>

Sorry for a rather late answer. I saw that Jens already applied
the patches so it's fine when the Ack isn't added anymore.
Wanted to send it anyway so that you know we're aware of it.

> ---
>  drivers/s390/block/dasd_fba.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index 8bd5665db9198..60be7f7bf2d16 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
> @@ -782,7 +782,6 @@ static void dasd_fba_setup_blk_queue(struct dasd_block *block)
>  	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
>  
>  	q->limits.discard_granularity = logical_block_size;
> -	q->limits.discard_alignment = PAGE_SIZE;
>  
>  	/* Calculate max_discard_sectors and make it PAGE aligned */
>  	max_bytes = USHRT_MAX * logical_block_size;

