Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53CAC48BDF
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 18:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C1361042
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 18:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhFRSNh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:13:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12794 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230024AbhFRSNh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 14:13:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15II2Yud118785;
        Fri, 18 Jun 2021 14:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LDeXJAMIrd7Bzszgl+66ueq612J8mydZvMkXyfHiR/c=;
 b=hVSrh+Jht8KCJPKS3LnXXjyez+P+NqEzSEo4TGrZrVSso1gmK1wCxEQ6XfBg+s7j6qlk
 0dDPbbvEbVaCnHgosefb4PfUA0vYQxor+Pm1cU/4vWxDf6qriDoF0QdSCfpwb/SLLWP/
 p76DsN/MmtLh5Ro9bEL/tuMprsSzPBD7HSFxCsPV+F5+wzNl4sT/jL8kNbJvfKMD0TdH
 sb6S2IDWLT/oTDNuiV8gK56KWsVCSwTHYYOugyU1YTexh2BQuLCpjTAMyKds/Dp4ogYw
 dzlMoHXDXIp0wIJwnVioQvTcqQi+Zh+LqcfbrcEvFROOytXS8Z0f0dxBIrPIHFhQuADC UA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398xtp2wbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 14:11:25 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15II8SsV001921;
        Fri, 18 Jun 2021 18:11:24 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3980b9rfhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 18:11:24 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IIBNNI12518384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 18:11:23 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4307AE060;
        Fri, 18 Jun 2021 18:11:23 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9295DAE05C;
        Fri, 18 Jun 2021 18:11:23 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 18:11:23 +0000 (GMT)
Subject: Re: [PATCH v2] s390/vfio-ap: Fix module unload memory leak of
 matrix_dev
To:     "Jason J. Herne" <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com, jgg@nvidia.com
References: <20210618171255.2025-1-jjherne@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <af3d6c67-e045-770f-82ff-dd8e691c1317@linux.ibm.com>
Date:   Fri, 18 Jun 2021 14:11:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618171255.2025-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OGz9te48wsybWvLCzreZE7cm2VZGxwly
X-Proofpoint-GUID: OGz9te48wsybWvLCzreZE7cm2VZGxwly
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_10:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106180104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/18/21 1:12 PM, Jason J. Herne wrote:
> vfio_ap_matrix_dev_release is shadowing the global matrix_dev with a NULL
> pointer. Driver data for the matrix device is never set and so
> dev_get_drvdata() always returns NULL. When release is called we end up
> not freeing matrix_dev. The fix is to remove the shadow variable and get
> the correct pointer from the device using container_of. We'll also NULL
> the global to prevent any future use.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 7dc72cb718b0..40e66cb363d1 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -82,9 +82,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>   
>   static void vfio_ap_matrix_dev_release(struct device *dev)
>   {
> -	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
> -
> -	kfree(matrix_dev);
> +	kfree(container_of(dev, struct ap_matrix_dev, device));

I suppose if we're not going to assume that the release is being
called to free the global matrix_dev, then if you are going to
retrieve it using container_of(), then maybe we should verify
the retrieved pointer is the same as the global matrix_dev?

> +	matrix_dev = NULL;
>   }
>   
>   static int matrix_bus_match(struct device *dev, struct device_driver *drv)

