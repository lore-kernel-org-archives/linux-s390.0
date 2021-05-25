Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F29C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DBE61249
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhEYPKE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 11:10:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229685AbhEYPJ7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 11:09:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PF4LSY013672;
        Tue, 25 May 2021 11:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qRLgRSBBx/nSGA2WNSV/2YEj8rZP4C8EO+a+X5TvN9s=;
 b=cmKWne6cKQR3346roL5fqGZ3c+rVgaRanUI4MWXMauWCnG2J4hhSukIUUwOsTVe5/+Fc
 qd0ef53PDjdiybN9m/fj8M7N4nl+cKqIQPOkGKuPiAJKYD/WTMSZlPk2s5AFIUXYgmEO
 P8SfJpAiqct6XoHRu5+OQAxElDegnICVjx46Tmw8gs2gwesRP6sgSQEqzj5l7mxSisZo
 V86uKEfuKntnBizk3v7DISXFs4CUDRayY3jFaWSY0QT9uR3xPxRg3dywYMISw+eOQ6jg
 awypFLHFg4EPP/agrCFtc/AezBHhPKUfpPdG6lfHQQ0FNSMn6YRo7lP7rRV+Orm/hk9e 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s3ja88xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 11:08:27 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PF4TPh014519;
        Tue, 25 May 2021 11:08:27 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s3ja88wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 11:08:26 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PF49x7027031;
        Tue, 25 May 2021 15:08:25 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 38s1qd0yw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 15:08:25 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PF8Oov27984154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 15:08:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8916613604F;
        Tue, 25 May 2021 15:08:24 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 623EF13605D;
        Tue, 25 May 2021 15:08:23 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 15:08:23 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
 <20210525131912.GW1002214@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <6542986f-b20e-3f41-b96c-70f0ce42af2d@linux.ibm.com>
Date:   Tue, 25 May 2021 11:08:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525131912.GW1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RzmDespSX7uDTLuxpy86PIMrhSf-_JWy
X-Proofpoint-GUID: cpYkhIxpjJys3-oaXi3DyEEXFQtvxcAv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/25/21 9:19 AM, Jason Gunthorpe wrote:
> On Tue, May 25, 2021 at 09:16:30AM -0400, Tony Krowiak wrote:
>>
>> On 5/24/21 10:37 AM, Jason J. Herne wrote:
>>> On 5/21/21 3:36 PM, Tony Krowiak wrote:
>>>> The function pointer to the handler that processes interception of the
>>>> PQAP instruction is contained in the mdev. If the mdev is removed and
>>>> its storage de-allocated during the processing of the PQAP instruction,
>>>> the function pointer could get wiped out before the function is called
>>>> because there is currently nothing that controls access to it.
>>>>
>>>> This patch introduces two new functions:
>>>> * The kvm_arch_crypto_register_hook() function registers a function
>>>> pointer
>>>>     for processing intercepted crypto instructions.
>>>> * The kvm_arch_crypto_register_hook() function un-registers a function
>>>>     pointer that was previously registered.
>>> Typo: You meant kvm_arch_crypto_UNregister_hook() in the second bullet.
>>>
>>>
>>> Just one overall observation on this one. The whole hook system seems
>>> kind of over-engineered if this is our only use for it. It looks like a
>>> kvm_s390_crypto_hook is meant to link a specific module with a function
>>> pointer. Do we really need this concept?
>>>
>>> I think a simpler design could be to just place a mutex and a function
>>> pointer in the kvm_s390_crypto struct. Then you can grab the mutex in
>>> vfio_ap_ops.c when registering/unregistering. You would also grab the
>>> mutex in priv.c when calling the function pointer. What I am suggesting
>>> is essentially the exact same scheme you have implemented here, but
>>> simpler and with less infrastructure.
>> That would be great, however; when I implemented something similar, it
>> resulted in a
>> lockdep splat between the lock used to protect the hook and the
>> matrix_dev->lock used to
>> protect updates to matrix_mdev (including the freeing thereof). After
>> pulling what little hair
>> I have left out, this seemed like a reasonable solution, over-engineered
>> though it may be.
>> If somebody has a simpler solution, I'm all ears.
> Why can't you put the locks in the right order? It looked trivial, I'm confused.

Because the handle_pqap() function in priv.c does not have access to the
matrix_dev lock.

>
> Jason

