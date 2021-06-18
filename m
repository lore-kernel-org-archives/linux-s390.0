Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C154C48BDF
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFE261351
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 15:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhFRPfG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:35:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58464 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233169AbhFRPdp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 11:33:45 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IF3ZID103031;
        Fri, 18 Jun 2021 11:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XqU0A+B1ac7tNPPHpM0nczn7qj190C/lKCLTI9PXato=;
 b=jmPWBFACy9e/94TEzQj6tTpj/iV0FC+pfFNK9DHnb3J6QwzqxxGJh5XtoRd4N+Xp0vGI
 AF/bV1tgQdLgcHYzxY/aHYlFyv2DtUR4OzfA+/5Q3W8eenOMh8pnqioL2rBXqs5c6kCJ
 pm8mFaNOL1DlYoSvh5AmQpy/FMOgdXgah3qjZZSC7Cs5XKJ6i1I+9mOHsa26pqSrMuLx
 RMAyEejgfqGsdBtxxqtGfGANEBHTgIIh9r7I6DUq1qchTwInkPiXPZl/liOMGHkdwQIE
 2EjVJ14UvIWC47/k0d8JCBA/GNvcMzs01PN6lZZ3R1ZwIiTzkOcbr7+gxo1dqDZDmgxv 3g== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398u3ay3jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:31:32 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IFIGum013032;
        Fri, 18 Jun 2021 15:31:31 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 394mjaaa0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 15:31:31 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IFVVuM27132274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 15:31:31 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24E2DAE06D;
        Fri, 18 Jun 2021 15:31:31 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC713AE062;
        Fri, 18 Jun 2021 15:31:30 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 15:31:30 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: Fix module unload memory leak of matrix_dev
To:     "Jason J. Herne" <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com, jgg@nvidia.com
References: <20210618133524.22386-1-jjherne@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <1eb41038-b732-7498-687e-1e8489ab04be@linux.ibm.com>
Date:   Fri, 18 Jun 2021 11:31:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618133524.22386-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -xnqTyW0znWGWReU7Bgf0pmk0HWDNUOI
X-Proofpoint-ORIG-GUID: -xnqTyW0znWGWReU7Bgf0pmk0HWDNUOI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

On 6/18/21 9:35 AM, Jason J. Herne wrote:
> vfio_ap_matrix_dev_release is shadowing the global matrix_dev with driver
> data that never gets set. So when release is called we end up not freeing
> matrix_dev. The fix is to remove the shadow variable and just free the
> global.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 7dc72cb718b0..6d3eea838e18 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -82,8 +82,6 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>   
>   static void vfio_ap_matrix_dev_release(struct device *dev)
>   {
> -	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
> -
>   	kfree(matrix_dev);
>   }
>   

