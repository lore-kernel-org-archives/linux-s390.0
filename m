Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA249C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A9F61413
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhEYPBQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 11:01:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231182AbhEYPBO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 11:01:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PExFOU107432;
        Tue, 25 May 2021 10:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ilqadP6miyG2ucaJRNhnH2nqbLOFKkZD7gQ8vrkxgcQ=;
 b=MZC9s1Pp4IsgjiDys5ewtgn+hG0oMLpezxWhIamRNIhIMiVzvLPCerGXbcbIcwu7qV2i
 wzkzHQms/4PfDtAtvwXxM/6Z8KRHYfDKv4NnUS/kSKD88RCDevsENj4TgPyfKWh/+2Cs
 I4Uok5RkqHlyAfeSu/Ekdl11VmycM6Q21ZvQ4g3t7plYAYkIOhlZQfNubgtaSS9VZmSb
 NaZhc4V3jv6z7wTfstC0b1HUMT58HzYUN880C9l2rfBUzDS9et68dbkupK2ty94EIweX
 WqC81V3Tb1nE5Veh8bSx/0gF6oOPYrETdDLOLNakBxuC00WbNqFS+ZDKXH+yPOmTxAEl Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s38r0nav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 10:59:42 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PExehG111005;
        Tue, 25 May 2021 10:59:40 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s38r0mxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 10:59:39 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PErumP024386;
        Tue, 25 May 2021 14:59:29 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 38s1ghh104-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 14:59:28 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PExRhj31916494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 14:59:27 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9012213604F;
        Tue, 25 May 2021 14:59:27 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6347A13605D;
        Tue, 25 May 2021 14:59:26 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 14:59:26 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <20210523225746.GF1002214@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <ac5cfe4a-a61b-2226-58aa-a5ea761180be@linux.ibm.com>
Date:   Tue, 25 May 2021 10:59:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210523225746.GF1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TaWADBqqPkb5YFjg1MtBJSc2-BGjm6FM
X-Proofpoint-GUID: KRxNCKyuKPDOFaxatL_YT-HVr9VjXiTI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/23/21 6:57 PM, Jason Gunthorpe wrote:
> On Fri, May 21, 2021 at 03:36:48PM -0400, Tony Krowiak wrote:
>> +static struct kvm_s390_crypto_hook
>> +*kvm_arch_crypto_find_hook(enum kvm_s390_crypto_hook_type type)
>> +{
>> +	struct kvm_s390_crypto_hook *crypto_hook;
>> +
>> +	list_for_each_entry(crypto_hook, &crypto_hooks, node) {
>> +		if (crypto_hook->type == type)
>> +			return crypto_hook;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +int kvm_arch_crypto_register_hook(struct kvm_s390_crypto_hook *hook)
>> +{
>> +	struct kvm_s390_crypto_hook *crypto_hook;
>> +
>> +	mutex_lock(&crypto_hooks_lock);
>> +	crypto_hook = kvm_arch_crypto_find_hook(hook->type);
>> +	if (crypto_hook) {
>> +		if (crypto_hook->owner != hook->owner)
>> +			return -EACCES;
>> +		list_replace(&crypto_hook->node, &hook->node);
> This is all dead code right? This is only called from a module init
> function so it can't be called twice.

That is true only if you are considering the current case.
Is it guaranteed that only the vfio_ap module
will call this function and is there a guarantee that it will
always and only be called from the vfio_ap module init
function? For example, suppose a hook is added to
intercept the AP NQAP or DQAP instruction? We don't
know how or when those handlers will be registered
or unregistered. We don't even know if the handlers
will be part of the vfio_ap module or not.

> Just always fail if the hook is
> already used and delete the owner stuff.

I suppose that is reasonable and simpler.

>
> But this is alot of complicated and unused code to solve a lock
> ordering problem..

If you have a better solution, I'm all ears. I've been down this
road a couple of times now and solving lock ordering for
multiple asynchronous processes is not trivial. This seems like
a reasonable solution and provides for flexibility for including
additional hooks to handle interception of other AP instructions.

>
> Jason

