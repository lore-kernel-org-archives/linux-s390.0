Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD9C54E94
	for <linux-s390@archiver.kernel.org>; Tue, 24 Jan 2023 13:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjAXNlx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Jan 2023 08:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjAXNls (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Jan 2023 08:41:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ECB4588E;
        Tue, 24 Jan 2023 05:41:46 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OCePeZ021804;
        Tue, 24 Jan 2023 13:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SOYnKhD5dQT63yZmrzh4+hpWYPFBvl/pDlnfVZmuzFI=;
 b=hAO/G/p+YhzIVLJmKM5GyU608jh0oQeUlIr2aRd8g6cXLdCIR9cvmFbwDLfqutK7xpdy
 nHCkc7XUwczHF6D9sFk3btqRh/rrZMF8uQCa2jYeWkqLtZ8FcHd1yZx4p2Qc/PolxKrj
 t4AgQnob+ydJG2GQJ1/KMgDZs821XlT5bpTsDULyq3+RM/LLOEpP2JqbrZ9AaWajEjF9
 ODY4LhcDd9GK5TzdMal5xngzpai6Qq3q0niuizWcud8WuhYCN91PoCSHPB1ESPtj5QxF
 PpdBISxJ3cRzbh3QHVWUgpF1EH6TGL0lNZF3jOnfNHCV2WKpjPm/u+BHNncS0VBm9tVB Ug== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naagtrqn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:41:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30O559QO027489;
        Tue, 24 Jan 2023 13:41:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6bv7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:41:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30ODfbLE52101516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:41:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36BBE20043;
        Tue, 24 Jan 2023 13:41:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F59420040;
        Tue, 24 Jan 2023 13:41:36 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.94.199])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Jan 2023 13:41:36 +0000 (GMT)
Date:   Tue, 24 Jan 2023 14:41:34 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] s390/dcssblk:: don't call bio_split_to_limits
Message-ID: <Y8/gDgQfQA7++8tw@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230123075356.60847-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123075356.60847-1-hch@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RXwsrWpnsBnBhgap0qJ9PJEH_ZBlGWbf
X-Proofpoint-GUID: RXwsrWpnsBnBhgap0qJ9PJEH_ZBlGWbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=900 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301240124
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jan 23, 2023 at 08:53:56AM +0100, Christoph Hellwig wrote:

Hi Christoph,

> s390 iterates over the bio using bio_for_each_segment and doesn't need
> any bio splitting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/s390/block/dcssblk.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index c0f85ffb2b62de..c09f2e053bf863 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -864,10 +864,6 @@ dcssblk_submit_bio(struct bio *bio)
>  	unsigned long source_addr;
>  	unsigned long bytes_done;
>  
> -	bio = bio_split_to_limits(bio);
> -	if (!bio)
> -		return;
> -
>  	bytes_done = 0;
>  	dev_info = bio->bi_bdev->bd_disk->private_data;
>  	if (dev_info == NULL)

If my understanding is correct that this change was as good as
early as commit 54efd50bfd87 ("block: make generic_make_request
handle arbitrarily sized bios") took place and simply fell into
the second category?

	...
	Some make_request_fn() callbacks were simple enough to audit and verify     
	they don't need blk_queue_split() calls. The skipped ones are:              
	...
	Some others are almost certainly safe to remove now, but will be left       
	for future patches.                                                         
	...

Thanks!
