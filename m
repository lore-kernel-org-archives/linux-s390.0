Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F84C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E446128D
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEYNSG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 09:18:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233039AbhEYNSG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 09:18:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PD2iP8014881;
        Tue, 25 May 2021 09:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/qcBuWJwmYiC16r8ziTKCHCve1Yk+AgfGfU6xdbXpvs=;
 b=tqXsqtnXg7jHfgWnZsnhWytihZnMcENvB/Pm+3uWQkNVm+YSTiB3/u7rD/12VGwUQ+Lp
 7ocZSkrwpvxzpmOGo7SGY4tXVi0StspQ+bQ147c/VRhVcR6bkPfb89+BXO7+VIKN4E39
 AgXjKGrlNVZzVOBc+4OtVWt/GNTgM7i9dH1og+I4UiVJNS1XnxlLYmlQjaZZZtC3Vnak
 KDj0EjjBg+3eTh6BpRGeU3g1tZN9Nb8D6eAMg0ZJ6QFuOCg+dlbyG3hzruesraUKV5Xk
 RFY0RM9uK6SOxzgwdaw7FUNK4qAWgXzd+8UYeKSFcVc9sFFKpWX3BlDOJaz3KsLSs3Y4 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s1g69633-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:16:34 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PD2sRN016756;
        Tue, 25 May 2021 09:16:34 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s1g6962m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:16:34 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PDF1kO009146;
        Tue, 25 May 2021 13:16:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 38s1m208bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 13:16:33 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PDGVGC27918608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:16:32 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC5313606E;
        Tue, 25 May 2021 13:16:31 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF75F136053;
        Tue, 25 May 2021 13:16:30 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 13:16:30 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
Date:   Tue, 25 May 2021 09:16:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1LsBpQtMWwXf_3q_6G8F4ikH0DPQJZPk
X-Proofpoint-ORIG-GUID: hpRYyVtOsdTXCrFB4M7UiD-1mZbdeWei
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/24/21 10:37 AM, Jason J. Herne wrote:
> On 5/21/21 3:36 PM, Tony Krowiak wrote:
>> The function pointer to the handler that processes interception of the
>> PQAP instruction is contained in the mdev. If the mdev is removed and
>> its storage de-allocated during the processing of the PQAP instruction,
>> the function pointer could get wiped out before the function is called
>> because there is currently nothing that controls access to it.
>>
>> This patch introduces two new functions:
>> * The kvm_arch_crypto_register_hook() function registers a function 
>> pointer
>>    for processing intercepted crypto instructions.
>> * The kvm_arch_crypto_register_hook() function un-registers a function
>>    pointer that was previously registered.
>
> Typo: You meant kvm_arch_crypto_UNregister_hook() in the second bullet.
>
>
> Just one overall observation on this one. The whole hook system seems 
> kind of over-engineered if this is our only use for it. It looks like 
> a kvm_s390_crypto_hook is meant to link a specific module with a 
> function pointer. Do we really need this concept?
>
> I think a simpler design could be to just place a mutex and a function 
> pointer in the kvm_s390_crypto struct. Then you can grab the mutex in 
> vfio_ap_ops.c when registering/unregistering. You would also grab the 
> mutex in priv.c when calling the function pointer. What I am 
> suggesting is essentially the exact same scheme you have implemented 
> here, but simpler and with less infrastructure.

That would be great, however; when I implemented something similar, it 
resulted in a
lockdep splat between the lock used to protect the hook and the 
matrix_dev->lock used to
protect updates to matrix_mdev (including the freeing thereof). After 
pulling what little hair
I have left out, this seemed like a reasonable solution, over-engineered 
though it may be.
If somebody has a simpler solution, I'm all ears.

>
> With that said, I'll point out that I am relative new to this code 
> (and this patch series) so maybe I've missed something and the extra 
> complexity is needed for some reason. But if it is not, I'm all in 
> favor of keeping things simple.
>

