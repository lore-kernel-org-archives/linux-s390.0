Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D3C04FF3
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 14:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0BE613B6
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 14:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhEXOjD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 May 2021 10:39:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232662AbhEXOjD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 May 2021 10:39:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OEXnOI069039;
        Mon, 24 May 2021 10:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=reply-to : subject : to
 : cc : references : from : message-id : date : mime-version : in-reply-to
 : content-type : content-transfer-encoding; s=pp1;
 bh=qiGLtExK2d9UEaFhiSzXGydhB/xUyM2qKG7kqm1Po7A=;
 b=nVdJF9PKah3fmlWlmGtqQhOYWETzWz+0S3IHiaa3tv4wIJFnpoox2r1dzmGRMxfVCw2s
 ym498pkS+2J+BxUu1vUh8JAfHA7Il8qEKGin9JyC2JiGanNFBfPPhB7g/Vu8/Cy/0HaO
 JVji4g7BTAE5M+Z6pCl6p1GgUiAzJk9rUrRSuiVTIJYsHt9BJSuKWVWXZIr33EcP1IrB
 H2t3yzY4w79lix0YcJwTHPS1LHxbEZUo1P+PuZmzjJuqetIIqsS8rG5rnkJDPH32+gF0
 J3Y4+7B2xP32lBH9c0PAG1hXA3g143iaR5VccjjJ//uc8opZIngQjF1xMI+SUk7GgPa8 JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rcp6jq8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 10:37:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14OEZQak078053;
        Mon, 24 May 2021 10:37:32 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rcp6jq7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 10:37:32 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14OES4ph004652;
        Mon, 24 May 2021 14:37:31 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 38psk8uhpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 14:37:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14OEbURt32178562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 14:37:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1E42AC05B;
        Mon, 24 May 2021 14:37:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C278AC059;
        Mon, 24 May 2021 14:37:30 +0000 (GMT)
Received: from [9.85.129.37] (unknown [9.85.129.37])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 May 2021 14:37:30 +0000 (GMT)
Reply-To: jjherne@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
Date:   Mon, 24 May 2021 10:37:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20210521193648.940864-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gh3eRF05AJL4dIKt3kY4Me_bNdevfKmh
X-Proofpoint-ORIG-GUID: E73HcYud6QteG_CBEWq1GhvSGDbV1Fi6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/21/21 3:36 PM, Tony Krowiak wrote:
> The function pointer to the handler that processes interception of the
> PQAP instruction is contained in the mdev. If the mdev is removed and
> its storage de-allocated during the processing of the PQAP instruction,
> the function pointer could get wiped out before the function is called
> because there is currently nothing that controls access to it.
> 
> This patch introduces two new functions:
> * The kvm_arch_crypto_register_hook() function registers a function pointer
>    for processing intercepted crypto instructions.
> * The kvm_arch_crypto_register_hook() function un-registers a function
>    pointer that was previously registered.

Typo: You meant kvm_arch_crypto_UNregister_hook() in the second bullet.


Just one overall observation on this one. The whole hook system seems kind of 
over-engineered if this is our only use for it. It looks like a kvm_s390_crypto_hook is 
meant to link a specific module with a function pointer. Do we really need this concept?

I think a simpler design could be to just place a mutex and a function pointer in the 
kvm_s390_crypto struct. Then you can grab the mutex in vfio_ap_ops.c when 
registering/unregistering. You would also grab the mutex in priv.c when calling the 
function pointer. What I am suggesting is essentially the exact same scheme you have 
implemented here, but simpler and with less infrastructure.

With that said, I'll point out that I am relative new to this code (and this patch series) 
so maybe I've missed something and the extra complexity is needed for some reason. But if 
it is not, I'm all in favor of keeping things simple.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
