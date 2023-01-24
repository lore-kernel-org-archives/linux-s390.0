Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B73C54E94
	for <linux-s390@archiver.kernel.org>; Tue, 24 Jan 2023 18:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjAXSWk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAXSWj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Jan 2023 13:22:39 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D62728;
        Tue, 24 Jan 2023 10:22:37 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OI0hAs006352;
        Tue, 24 Jan 2023 18:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=A+E0J7K0y1+x02hoEzQXiBb6Dyfu8YLxHB6XbBVI/Gg=;
 b=OHV0FBc6VsIuMlovWJo6UAi5x8Vw6icBgfH6f/Nid0gaZR+x5c6ArK94jhnrTzL1tKVF
 rPrke/36SpaEdf1Ax1iRbO6OL5Wufn0txyqDmKIRO/FcUF5YLOe9SET13jn06L/FQk3e
 kxgbzPu3nMCjsLB+/zHTL02ibE7t1W6onXYGeVnH/0BAkLD4+iMcTg6tb+BHd1gixFPh
 E+bp7Kp/6fdY0034JmisCKWL7XttgElrSYT0wRsJpvUZTya+Ot3WeL7PFKM+JQ8kM6xh
 +5NTzVnHpgwkBdFfKj9WlcfqSLyoCt75Ko79yFLSwGq3ZWXKUHlfRQyB+DM1h5xJ5lSf mQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naaknyya9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 18:22:34 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30O4udZu004576;
        Tue, 24 Jan 2023 18:22:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afb1bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 18:22:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OIMSOU47907262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 18:22:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5E5E20043;
        Tue, 24 Jan 2023 18:22:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 433AF20040;
        Tue, 24 Jan 2023 18:22:28 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.179.26.28])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Jan 2023 18:22:28 +0000 (GMT)
Date:   Tue, 24 Jan 2023 19:22:26 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH] s390/dcssblk:: don't call bio_split_to_limits
Message-ID: <Y9Ah4llCCHR50eGT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230123075356.60847-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123075356.60847-1-hch@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lCeUvfWxMN6ubsSaOCL0Bk6PNQBwGV_V
X-Proofpoint-GUID: lCeUvfWxMN6ubsSaOCL0Bk6PNQBwGV_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=767 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240164
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jan 23, 2023 at 08:53:56AM +0100, Christoph Hellwig wrote:
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

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
