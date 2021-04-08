Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606FC433ED
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92D9610C7
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 14:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhDHOcE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:32:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhDHOcD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Apr 2021 10:32:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138E4LDn030580;
        Thu, 8 Apr 2021 10:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CBBpirbqpmQUbCUyT7tQO7YdvanznqRwqjg8mIH7Eg0=;
 b=rEUF7zF0GFKuanB/Kvqa14QVXvaHvUNM1w4IvuLxhmMYc2a97NB2NMSv/0EgAI9LoOv6
 goXk5zYpnku+EI5SvQXVAb9hkTG9G9Gpcv9YV3pYmS4FFfSvS1w6FksQzBuqQe/wWgvA
 KM6JT/W4TwK51nb77SIjmfvlE73gMWoHEZ9yWbG4U18WDpB89vkU3CUhNUtBrATYkFy2
 K6txA6p6rlgzviPa+os+k78ubxXVc6ojBnw7OTfFBNa5nVtSKsmb4hi3YubENdXkTxpw
 bOgJFzK5zB7Hb/2CyAF4G95JuEcsQApI+UD5tHNgPtlSj5BerOiNl45GXPao5Rw++dxj 0Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvn1kudk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 10:31:47 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138EQEdU002111;
        Thu, 8 Apr 2021 14:31:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 37t3h8g07g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 14:31:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138EVglV43974936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 14:31:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD981AE04D;
        Thu,  8 Apr 2021 14:31:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C3F8AE059;
        Thu,  8 Apr 2021 14:31:42 +0000 (GMT)
Received: from linux-2.fritz.box (unknown [9.145.26.3])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 14:31:42 +0000 (GMT)
Subject: Re: [PATCH 01/11] dasd: use bdev_disk_changed instead of
 blk_drop_partitions
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210406062303.811835-1-hch@lst.de>
 <20210406062303.811835-2-hch@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
Message-ID: <6728854d-764c-cb15-ba42-1598204a8d9e@linux.ibm.com>
Date:   Thu, 8 Apr 2021 16:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210406062303.811835-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o-p-OvvJ5R1H-XD2W1FL-xeLvAUgClv5
X-Proofpoint-ORIG-GUID: o-p-OvvJ5R1H-XD2W1FL-xeLvAUgClv5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_03:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 06.04.21 um 08:22 schrieb Christoph Hellwig:
> Use the more general interface - the behavior is the same except
> that now a change uevent is sent, which is the right thing to do
> when the device becomes unusable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/core.c         | 4 ----
>  drivers/s390/block/dasd_genhd.c | 3 +--
>  2 files changed, 1 insertion(+), 6 deletions(-)

Acked-by: Stefan Haberland <sth@linux.ibm.com>

Thanks,
Stefan


