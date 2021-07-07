Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81452C07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9C961C91
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 11:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhGGLS0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 07:18:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhGGLS0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Jul 2021 07:18:26 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167B5XQ6099634;
        Wed, 7 Jul 2021 07:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YTpvN3xMP4VN03q+XIheFnsjHQA+EPlNiyfOw7DVRBw=;
 b=G8byYwsirQXWa+0YXSum/4A6llk2IREO9F+E81K+Nekk6mhWcp9nDIA6kqHEP0E80p/w
 UKhZCCTsNtD0KC2C5NIIpIBVNEPJFpU5juiq7uphpYQD0D0HJwcwrkdhFxLBNtuBBN2r
 HFssp6xLHfuLq6RiJasIAfpPObgK7RNs2eToUrzYowQ/iw8CK65giYRj/7PtgFDlpAty
 xEH14bwWcKjsLQrVShPnmBglJ4sB0CHNJDrsk6isMUntAKdhOy14z0cghIjjkm7QbdhC
 k5JH19eUBWWtjLqecGB5au8kIgGEZmzuyAJzO4BQhxsdgAi/i7YOWXm9JTDalDd6ogOh oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39n28jcy5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 07:15:38 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 167B5snn100480;
        Wed, 7 Jul 2021 07:15:38 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39n28jcy52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 07:15:38 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167B8aKm010362;
        Wed, 7 Jul 2021 11:15:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8sq5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 11:15:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167BFXjJ30736642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 11:15:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7C1C4C06A;
        Wed,  7 Jul 2021 11:15:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 847EB4C058;
        Wed,  7 Jul 2021 11:15:32 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.152.212.90])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 11:15:32 +0000 (GMT)
Subject: Re: [PATCH v2 2/4] s390/ccwgroup: Drop if with an always false
 condition
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Cornelia Huck <cohuck@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-3-u.kleine-koenig@pengutronix.de>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <d2a0875f-f6e5-e3e7-82d6-032bc1c431f4@linux.ibm.com>
Date:   Wed, 7 Jul 2021 13:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706154803.1631813-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ll1391y-NxNWkLTq1m5PjyE09BjY5P9f
X-Proofpoint-ORIG-GUID: e279E6yT3-ghrhk8eTmtJqrfvqZSZ-VP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_06:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070067
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thank you. Looks good to me.
Heiko/Vasily will pick this up and will be part of the next s390-tree 
patchset.

Also,

Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>


On 7/6/21 5:48 PM, Uwe Kleine-König wrote:
> The driver core only calls a bus remove callback when there is a driver.
> So dev->driver is never NULL and the check can safely be removed.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/s390/cio/ccwgroup.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
> index 9748165e08e9..a6aeab1ea0ae 100644
> --- a/drivers/s390/cio/ccwgroup.c
> +++ b/drivers/s390/cio/ccwgroup.c
> @@ -444,8 +444,6 @@ static int ccwgroup_remove(struct device *dev)
>   	struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
>   	struct ccwgroup_driver *gdrv = to_ccwgroupdrv(dev->driver);
>   
> -	if (!dev->driver)
> -		return 0;
>   	if (gdrv->remove)
>   		gdrv->remove(gdev);
>   
