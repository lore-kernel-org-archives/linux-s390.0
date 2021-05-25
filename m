Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60849C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C5E61420
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhEYN1f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 09:27:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233369AbhEYN0e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 09:26:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PD3k5k103406;
        Tue, 25 May 2021 09:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=reply-to : subject :
 from : to : cc : references : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=Z/f4fUIjz0PIIVzSsMU8XWaPBNMkBh5Im2Zs7tFsMa4=;
 b=aDNHgaQgBUzZNwHAXaUF4rQowyn6W7578U6sfbWRIQ/IAxG+mThSjFiJLSimOvPByNDQ
 O2RZFYrUwSYlnffZ5sPdNfNDvOB1FGKiM1U8xSZMQJsvsu7is/32x1k6judFd1JMJLiw
 lEWkzmO/DPIHIPdaguTnn2NYWhG65w31E8BzHk2tT7YgNWUORHFV1OYp7NRQt4/N2CDx
 s0fBvNr2idx+BC89/G1jZtlTea9Yvu2czzzRhdnwwXOdpJDzuL3m8AjK96bBWCCfemKT
 A9fzlJTk1xqd9mB7eL97SOMcPwh81JCQtCjcTsnT0nO06K/sypEg8txAEVLC5652khh7 Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s1adsvwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:25:03 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PD6fpP124940;
        Tue, 25 May 2021 09:25:03 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s1adsvwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:25:03 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PDDfAa025159;
        Tue, 25 May 2021 13:25:02 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 38s1n3g7te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 13:25:02 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PDP1jg11928034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:25:01 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 166BB78060;
        Tue, 25 May 2021 13:25:01 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8C217805F;
        Tue, 25 May 2021 13:24:59 +0000 (GMT)
Received: from [9.85.129.37] (unknown [9.85.129.37])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 13:24:59 +0000 (GMT)
Reply-To: jjherne@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
Organization: IBM
Message-ID: <20df4cd0-7859-4727-42bd-9ef419455039@linux.ibm.com>
Date:   Tue, 25 May 2021 09:24:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jGAtmfNck1hlLQSIgAFph7VO04yMQZ0S
X-Proofpoint-GUID: KXlv49PJCyVIRvKk7lCVdDgIzcV7VaFw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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
>> * The kvm_arch_crypto_register_hook() function registers a function pointer
>>    for processing intercepted crypto instructions.
>> * The kvm_arch_crypto_register_hook() function un-registers a function
>>    pointer that was previously registered.
> 
> Typo: You meant kvm_arch_crypto_UNregister_hook() in the second bullet.
> 
> 
> Just one overall observation on this one. The whole hook system seems kind of 
> over-engineered if this is our only use for it. It looks like a kvm_s390_crypto_hook is 
> meant to link a specific module with a function pointer. Do we really need this concept?
> 
> I think a simpler design could be to just place a mutex and a function pointer in the 
> kvm_s390_crypto struct. Then you can grab the mutex in vfio_ap_ops.c when 
> registering/unregistering. You would also grab the mutex in priv.c when calling the 
> function pointer. What I am suggesting is essentially the exact same scheme you have 
> implemented here, but simpler and with less infrastructure.
> 
> With that said, I'll point out that I am relative new to this code (and this patch series) 
> so maybe I've missed something and the extra complexity is needed for some reason. But if 
> it is not, I'm all in favor of keeping things simple.
> 

After thinking about this problem a bit more, I'm wondering if we can remove the lock 
entirely. How about we store a function pointer in kvm_s390_crypto? Initially that 
function pointer will point to a stub function that handles the error case, exactly like 
it is done in priv.c:handle_pqap() today when the function pointer would be NULL. When the 
ap module loads, we can simply change the function pointer to point to 
vfio_ap_ops:handle_pqap(). When we unload the module we change the function pointer back 
to the stub.  The updates should be atomic operations so no lock needed, right?

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
