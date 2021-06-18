Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE5C48BDF
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 14:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E7B61154
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 14:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhFROhf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:37:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234482AbhFROhf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 10:37:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IEXZ3M138915;
        Fri, 18 Jun 2021 10:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=reply-to : subject : to
 : cc : references : from : message-id : date : mime-version : in-reply-to
 : content-type : content-transfer-encoding; s=pp1;
 bh=utnCngW3hDrD4dCnqL9kmi0H9czRh3hOkfrGpGF5KN8=;
 b=aLWmMfu9XvFY7G49Ib3A3Rfm4r06nmF9x8ZNA+TgsWT7SIRtqolBN7pr1MNsVqAlHlsG
 vD7JLVohuChCrn6pet0oW+g1qeQ2ReB7ZyeU7ZJtVWZ8WJhUlI+KoJThG7ho086WRe6s
 MKYeUEyRmA9RGAFYDzjV3mduXPFjZXQTtzeeDPkwhXMX6mCPIu02J7qIi499FNkq7Ev8
 vfqkEl++LFUwEHj3AFGSQHOpL5q/OHTUmNAbeu16W6Xx4zcCQcZUnkOP8kphgBTTL2qz
 Zrr0dCnplCd0UYCLEtj5TEzoHYyNZId2ytfxFar3qmZX7RmcmYYXtnaTQHNLB2qtMtzZ VA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 398veu24vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 10:35:23 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IEWG8R018849;
        Fri, 18 Jun 2021 14:35:22 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 394mjahxtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 14:35:22 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IEZLpb29294938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 14:35:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2B6FAE060;
        Fri, 18 Jun 2021 14:35:21 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75FBEAE05C;
        Fri, 18 Jun 2021 14:35:21 +0000 (GMT)
Received: from [9.85.129.236] (unknown [9.85.129.236])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 14:35:21 +0000 (GMT)
Reply-To: jjherne@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: Fix module unload memory leak of matrix_dev
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com
References: <20210618133524.22386-1-jjherne@linux.ibm.com>
 <20210618141018.GE1002214@nvidia.com>
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <4ea3de71-9d68-59c6-bfb8-d8258019e585@linux.ibm.com>
Date:   Fri, 18 Jun 2021 10:35:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20210618141018.GE1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zwht2JWtS1X4ZwQIcekUVNTpqdQuDKLG
X-Proofpoint-ORIG-GUID: zwht2JWtS1X4ZwQIcekUVNTpqdQuDKLG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 6/18/21 10:10 AM, Jason Gunthorpe wrote:
> On Fri, Jun 18, 2021 at 09:35:24AM -0400, Jason J. Herne wrote:
>> vfio_ap_matrix_dev_release is shadowing the global matrix_dev with driver
>> data that never gets set. So when release is called we end up not freeing
>> matrix_dev. The fix is to remove the shadow variable and just free the
>> global.
> 
> I would clarify this commit message to say that the drv_data of the
> matrix_dev is never set and so dev_get_drvdata() always returns NULL
> 
> And I would suggest to use
> 
>    container_of(dev, struct ap_matrix_dev, dev)
> 
> instead of the global variable, and probably NULL the global
> too..
> 

The use of driver_data seems to have been completely erroneous here. In this
case the global matrix_dev is the top level struct. It is not contained in
anything. matrix_dev is created upon module load, and it is freed when the
module exits.

So I don't think using container_of makes sense. Unless I've
misunderstood your suggestion?

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
