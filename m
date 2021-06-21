Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D8C4743C
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC4C60FDA
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUKHJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:07:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229621AbhFUKHJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 06:07:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LA4k69039573;
        Mon, 21 Jun 2021 06:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=YeQ6G+Xiv94s6yau5B40Z1/XrGaewAAJ4ZmFfwdOEgE=;
 b=jE+28dvyg6ZxmW0w2B13PT8OjHCfVgMv8RUo9mz+/ESrxay34l1s0NIGpnMWQSJxH9D1
 WrZEGhkInTLYgTwo9Y2sjuWjKX3oFPm4zziqoeoXAjoWfnbuV2PPh0C/TxXTbJATRk0M
 +4HLsoJFwAeZ+cQe7AqqllwBf0aK5m0AOMqokGmpFU3GelJpHZBYSeqLL8kUg4z7RsSH
 4k1ot/ykgZnwEzE2WvCKtOK3vZLvVQccQEUpEpJd5HsVK1XCSGmWaUOuHGVKcv1RhmXJ
 TWQxw3ciqZdTSX/SGxeWS6VvpQmDuh5pxBnD4Cbj9expvE6Tm7dtZCPTg+DeoRM/6ipJ ZQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39aqrpsnvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 06:04:49 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LA4P9l002485;
        Mon, 21 Jun 2021 10:04:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3998788eg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 10:04:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LA4YqK32375048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 10:04:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9878E4204C;
        Mon, 21 Jun 2021 10:04:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314AE4203F;
        Mon, 21 Jun 2021 10:04:34 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.30.36])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 21 Jun 2021 10:04:34 +0000 (GMT)
Date:   Mon, 21 Jun 2021 12:04:32 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Jason J. Herne" <jjherne@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        akrowiak@linux.ibm.com, jgg@nvidia.com
Subject: Re: [PATCH v2] s390/vfio-ap: Fix module unload memory leak of
 matrix_dev
Message-ID: <20210621120432.0e6d2839.pasic@linux.ibm.com>
In-Reply-To: <20210618171255.2025-1-jjherne@linux.ibm.com>
References: <20210618171255.2025-1-jjherne@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oZ_td83_RAcwouGfS2-U13mHpY-kgWek
X-Proofpoint-ORIG-GUID: oZ_td83_RAcwouGfS2-U13mHpY-kgWek
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_03:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210059
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 18 Jun 2021 13:12:55 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> vfio_ap_matrix_dev_release is shadowing the global matrix_dev with a NULL
> pointer. Driver data for the matrix device is never set and so
> dev_get_drvdata() always returns NULL. When release is called we end up
> not freeing matrix_dev. The fix is to remove the shadow variable and get
> the correct pointer from the device using container_of. We'll also NULL
> the global to prevent any future use.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 7dc72cb718b0..40e66cb363d1 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -82,9 +82,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>  
>  static void vfio_ap_matrix_dev_release(struct device *dev)
>  {
> -	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
> -
> -	kfree(matrix_dev);
> +	kfree(container_of(dev, struct ap_matrix_dev, device));
> +	matrix_dev = NULL;

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

I'm not sure nulling the global here buys us anything (especially after
the kfree()). But it does not hurt either, so I'm fine with it. Style
wise I think vfio_ap_matrix_dev_destroy() is a better place for the
nulling IMHO, as it is dealing with module global state.

Regards,
Halil


>  }
>  
>  static int matrix_bus_match(struct device *dev, struct device_driver *drv)

