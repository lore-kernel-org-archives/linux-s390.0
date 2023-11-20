Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3877C2BB3F
	for <linux-s390@archiver.kernel.org>; Mon, 20 Nov 2023 14:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjKTOEb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Nov 2023 09:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjKTOES (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Nov 2023 09:04:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3A10C0;
        Mon, 20 Nov 2023 06:03:43 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDMaJR022494;
        Mon, 20 Nov 2023 14:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ayQvgFthRJNPJhY6OnvpeIv7utMhV9IsMNfSqwniqng=;
 b=CF0ScI1sI+S3fLP8hfsWERlOiURR+RTJDO5UbNXSKFbA3g3EdedndSYLIEsUQIotSkOx
 3FSDVAE1unxRTnKZqynF8gy0uCg80I8wJyev3AllvYrRp7F5zxsk2lfymPSdjEwvXHpG
 0KyQGFvvN9gotqziAKZ4z72+3jaxTxzBzdJ71bSq5tFUwb9kjMpkeuamtdV2wDxzWK+k
 lwimXGKMzzeWjyPFHxavg6lYM0XUNhuqAl5oZ3e99+npSqtWpxzrH1NgK/wpAAfbvjl1
 7CcFtYHdqxSg4WPxIY9efjedAUv9MTokc8l8awDFE9XMlpP8TZTDJny5va4kxtZYDyHs Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89eh4t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:03:41 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKDRSh9003048;
        Mon, 20 Nov 2023 14:03:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89eh4s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:03:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDPFo0010137;
        Mon, 20 Nov 2023 14:03:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knhha7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:03:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKE3cbK10224320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:03:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B8E58063;
        Mon, 20 Nov 2023 14:03:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC76A58057;
        Mon, 20 Nov 2023 14:03:36 +0000 (GMT)
Received: from [9.179.19.4] (unknown [9.179.19.4])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 14:03:36 +0000 (GMT)
Message-ID: <ffdd12e0-22fa-d8b8-9862-c440d9cedf59@linux.ibm.com>
Date:   Mon, 20 Nov 2023 15:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] s390/dasd: fix kernel panic with statistics
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
References: <20231025132437.1223363-1-sth@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20231025132437.1223363-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: slNPZYT41be9aMYSsNoPGjTNYh6FXW4M
X-Proofpoint-ORIG-GUID: 3o09iHnDC8TKI-a6AqaV_9jlfmpnBkM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_13,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=870 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 25.10.23 um 15:24 schrieb Stefan Haberland:
> Hi Jens,
>
> please apply the following patch for the upcomming merge window that
> fixes a kernel panic that can be triggered by using dasd statistics.
> Also there is a typo fix for a comment.
>
> Thanks.
>
> Jan Höppner (1):
>    s390/dasd: protect device queue against concurrent access
>
> Muhammad Muzammil (1):
>    s390/dasd: resolve spelling mistake
>
>   drivers/s390/block/dasd.c     | 24 +++++++++++++-----------
>   drivers/s390/block/dasd_int.h |  2 +-
>   2 files changed, 14 insertions(+), 12 deletions(-)
>

Hi Jens,

polite ping.
