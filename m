Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07460C48BE5
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 07:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E553161407
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 07:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFOHqE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 03:46:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229613AbhFOHqD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Jun 2021 03:46:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15F7Y2cs021359;
        Tue, 15 Jun 2021 03:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=adpqRCpixsBPI3Dmqt4EnbXaGR6Lwwm/ncIPBJTljRo=;
 b=K8fqDSWkY3SpbX0evoEuUWYMCGpLpFWAtXcDoD2vN9A1n18L5rJfS82np778hm04yJyD
 mClIe8SUWmiwvzjG0yhHtW2ab6rYLdTTiI/tkW771PAWRwZq5ggXqYxwajBwVkAfmgWa
 vpZ4sPPAL5C8ZXWfIUOtxrgV2iTdAFOMNLW/gCGRmDWCPIr+ne5rWpjTCtGt8x6uvunq
 cLEp4UMFlUZJKlK0lNjSnmyHeP2pfOvpb5hCObO3BOIuHcTdgaHUpekmTi6pL0Mv/nGS
 B27lR2Z31SRRT8tDV9DFAow/kVpVsXWWBjjuCvRAs9aYPLWRhS8/ReZmyIVAANEbwnSz OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396qn48rpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 03:43:55 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15F7Z26T024989;
        Tue, 15 Jun 2021 03:43:55 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396qn48rnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 03:43:55 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15F7giQN022028;
        Tue, 15 Jun 2021 07:43:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 394mj90qtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 07:43:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15F7hogq33882496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 07:43:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 334264C04A;
        Tue, 15 Jun 2021 07:43:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 957CD4C04E;
        Tue, 15 Jun 2021 07:43:49 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.85.205])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jun 2021 07:43:49 +0000 (GMT)
Subject: Re: [PATCH 1/3] s390/vfio-ap: clean up mdev resources when remove
 callback invoked
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-2-akrowiak@linux.ibm.com>
 <20210611164854.GT1002214@nvidia.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <fb6a3aa4-c12b-5b38-54a5-36941d5d8dbd@de.ibm.com>
Date:   Tue, 15 Jun 2021 09:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210611164854.GT1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zMOFSxYXPb8cCdSg2C0a_8mZ9PkHfm_L
X-Proofpoint-ORIG-GUID: Mfu71SqRO_FJkulYxDIM_5DwDDXPDnMY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_04:2021-06-14,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150045
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 11.06.21 18:48, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 06:46:32PM -0400, Tony Krowiak wrote:
>> The mdev remove callback for the vfio_ap device driver bails out with
>> -EBUSY if the mdev is in use by a KVM guest (i.e., the KVM pointer in the
>> struct ap_matrix_mdev is not NULL). The intended purpose was
>> to prevent the mdev from being removed while in use. There are two
>> problems with this scenario:
>>
>> 1. Returning a non-zero return code from the remove callback does not
>>     prevent the removal of the mdev.
>>
>> 2. The KVM pointer in the struct ap_matrix_mdev will always be NULL because
>>     the remove callback will not get invoked until the mdev fd is closed.
>>     When the mdev fd is closed, the mdev release callback is invoked and
>>     clears the KVM pointer from the struct ap_matrix_mdev.
>>
>> Let's go ahead and remove the check for KVM in the remove callback and
>> allow the cleanup of mdev resources to proceed.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 10 ----------
>>   1 file changed, 10 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason, I guess you want this patch still in 5.13, the other 2 can be 5.14?
