Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DDC07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 11:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A236961CBE
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 11:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhGGLfB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 07:35:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhGGLfB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Jul 2021 07:35:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167B5aLW186267;
        Wed, 7 Jul 2021 07:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NJ8tcuv5l8JY0wkLfzi5PvGflZ2VNsIY+jVzHpsSsuk=;
 b=H8Hg+y54g6DMoU61Cz9nORnHlhOAxK1ar+1eV93VDfErRDytq73mcYalfnPGP2+l7S3/
 mmYlRN18tlm+s5j/Z/hAgatN9ovrv9QFzbXGEZ5206cn7R37UZ6wJo6NiGTQvk5KLk0P
 Nnm/zz0ziAuRHHYdJrWzuAJIuZ9Jv4CeZ8qzVoneksWavdQVD6TTVvHc5hisJdiVwrrS
 VB5Ed/Q8WeiF9gZROgwOivaGTl0+bBNhqi3z0asoLEjJy8ysaTXYop8OgLu9wgijg+1C
 VhCjOVZer1+Xf+/WxL6lOIxes9Wu0kjwYL0OlbWPlGYUmHDWRCtQhn65E2s2v/7YIOyb tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39naym8ur1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 07:32:17 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 167B5acp186285;
        Wed, 7 Jul 2021 07:32:17 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39naym8uq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 07:32:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167BPHe6012699;
        Wed, 7 Jul 2021 11:32:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 39jf5h9qau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 11:32:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167BUHKl31326678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 11:30:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE2644C046;
        Wed,  7 Jul 2021 11:32:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55D794C052;
        Wed,  7 Jul 2021 11:32:11 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.152.212.90])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 11:32:11 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] s390/scm: Make struct scm_driver::remove return
 void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-4-u.kleine-koenig@pengutronix.de>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <b023ee41-3b86-bbe2-ac62-6cbf37992947@linux.ibm.com>
Date:   Wed, 7 Jul 2021 13:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706154803.1631813-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VaGoYi_8ePeZi5eS8Nw4ewNQgdDDAWEs
X-Proofpoint-GUID: ZoIRRP4qg58y_lpe_ZsHi6cqeKEMJHlo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_06:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070067
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks sane to me.
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Vasily/Heiko will pick this up for the next-s390-tree.


On 7/6/21 5:48 PM, Uwe Kleine-König wrote:
> The driver core ignores the return value of scmdev_remove()
> (because there is only little it can do when a device disappears).
>
> So make it impossible for future drivers to return an unused error code
> by changing the remove prototype to return void.
>
> The real motivation for this change is the quest to make struct
> bus_type::remove return void, too.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   arch/s390/include/asm/eadm.h | 2 +-
>   drivers/s390/block/scm_drv.c | 4 +---
>   drivers/s390/cio/scm.c       | 5 ++++-
>   3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/s390/include/asm/eadm.h b/arch/s390/include/asm/eadm.h
> index bb63b2afdf6f..445fe4c8184a 100644
> --- a/arch/s390/include/asm/eadm.h
> +++ b/arch/s390/include/asm/eadm.h
> @@ -105,7 +105,7 @@ enum scm_event {SCM_CHANGE, SCM_AVAIL};
>   struct scm_driver {
>   	struct device_driver drv;
>   	int (*probe) (struct scm_device *scmdev);
> -	int (*remove) (struct scm_device *scmdev);
> +	void (*remove) (struct scm_device *scmdev);
>   	void (*notify) (struct scm_device *scmdev, enum scm_event event);
>   	void (*handler) (struct scm_device *scmdev, void *data,
>   			blk_status_t error);
> diff --git a/drivers/s390/block/scm_drv.c b/drivers/s390/block/scm_drv.c
> index 3134fd6e058e..69a845eb8b1f 100644
> --- a/drivers/s390/block/scm_drv.c
> +++ b/drivers/s390/block/scm_drv.c
> @@ -60,15 +60,13 @@ static int scm_probe(struct scm_device *scmdev)
>   	return ret;
>   }
>   
> -static int scm_remove(struct scm_device *scmdev)
> +static void scm_remove(struct scm_device *scmdev)
>   {
>   	struct scm_blk_dev *bdev = dev_get_drvdata(&scmdev->dev);
>   
>   	scm_blk_dev_cleanup(bdev);
>   	dev_set_drvdata(&scmdev->dev, NULL);
>   	kfree(bdev);
> -
> -	return 0;
>   }
>   
>   static struct scm_driver scm_drv = {
> diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
> index 9f26d4310bb3..b31711307e5a 100644
> --- a/drivers/s390/cio/scm.c
> +++ b/drivers/s390/cio/scm.c
> @@ -33,7 +33,10 @@ static int scmdev_remove(struct device *dev)
>   	struct scm_device *scmdev = to_scm_dev(dev);
>   	struct scm_driver *scmdrv = to_scm_drv(dev->driver);
>   
> -	return scmdrv->remove ? scmdrv->remove(scmdev) : -ENODEV;
> +	if (scmdrv->remove)
> +		scmdrv->remove(scmdev);
> +
> +	return 0;
>   }
>   
>   static int scmdev_uevent(struct device *dev, struct kobj_uevent_env *env)
