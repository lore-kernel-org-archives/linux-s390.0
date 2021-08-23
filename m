Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF36FC4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC83613A7
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 13:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhHWNJ0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:09:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236025AbhHWNJZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 09:09:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ND4u8M167866;
        Mon, 23 Aug 2021 09:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uZUulCoH2sI/ukqoZ+v0FPAFTBqWto61ie2WIZfGHCs=;
 b=X3V5MiAyUnecdYLe9jdPvm6F4GwYpBCe5mviSLO8O21+3v+tdyw2BynIZAtmJvp6sNRD
 9uKjZK4sTMHAW2XPik5fObcl/ew4t+juWfG6MppoVcBNWhBhiwg3X5dbQ5WB3U3O4pf3
 IDVdvGkWES4VvKEcYsQ3n+oXIRUC1I9Z9s0CN9MRSQlWUC5GpYfnlDvvV2+tsuForerC
 jYfgxWFMjrx8LYR8WqLnG26uY4Y94u83hNvvqSlwmoz//OK4bQF0wOzGJCF+WOoDT40u
 +XRXpjVsXvrB7mQHEfj5n29eXPLL6WrY4wGpZQ5MhSZguMHNh19X3S9W0mXebi8+LHdJ 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3am73k0x1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 09:08:41 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17ND5IfJ169904;
        Mon, 23 Aug 2021 09:08:41 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3am73k0x0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 09:08:41 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ND7D0v003613;
        Mon, 23 Aug 2021 13:08:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3ajs4bgg3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 13:08:40 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ND8dW752822306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 13:08:39 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECBBC136068;
        Mon, 23 Aug 2021 13:08:38 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C731D13605D;
        Mon, 23 Aug 2021 13:08:37 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 13:08:37 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
 <20210819012532.0e9c443c.pasic@linux.ibm.com>
 <8df389f7-44aa-978e-84d8-96c625b0470b@linux.ibm.com>
 <20210819234212.7e21f699.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <c1ec6ce7-45fe-3fac-8e77-25f40b2a6cad@linux.ibm.com>
Date:   Mon, 23 Aug 2021 09:08:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819234212.7e21f699.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pxUxrydnu0F4FXx4KrPgqvJ2XS4mR0gF
X-Proofpoint-GUID: 40sD3JykgYZPw065XYQv0FWdtSFpBvNZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_02:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108230090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/19/21 5:42 PM, Halil Pasic wrote:
> On Thu, 19 Aug 2021 09:36:34 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>>>>>     static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>>     {
>>>>>     	struct ap_queue_status status = {};
>>>>> +	crypto_hook pqap_hook;
>>>>>     	unsigned long reg0;
>>>>>     	int ret;
>>>>>     	uint8_t fc;
>>>>> @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>>     	 * Verify that the hook callback is registered, lock the owner
>>>>>     	 * and call the hook.
>>>>>     	 */
>>>>> +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>>>>>     	if (vcpu->kvm->arch.crypto.pqap_hook) {                     <--- HERE
>>>>> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
>>>>> -			return -EOPNOTSUPP;
>>>>> -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
>>>>> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>>>>> +		pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;
>>>> Dont we have to check for NULL here? If not can you add a comment why?
>>> I believe we did the necessary check on the line I just marked with
>>> "<--- HERE".
>>>
>>> I find that "*" operator confusing in this context as it doesn't do
>>> any good for us. I believe this situation is described in 6.5.3.2.4 of
>>> the c11 standard. For convenience I will cite from the corresponding
>>> draft:
>>> "The unary * operator denotes indirection. If the operand points to a
>>> function, the result is a function designator; if it points to an
>>> object, the result is an lvalue designating the object. If the operand
>>> has type ‘‘pointer to type’’, the result has type ‘‘type’’. If an
>>> invalid value has been assigned to the pointer, the behavior of the
>>> unary * operator is undefined."
>>>
>>> Frankly I also fail to see the benefit of introducing the local variable
>>> named "pqap_hook", but back then I decided to not complain about style.
>> The vcpu->kvm->arch.crypto.pqap_hook is a pointer to a function
>> pointer. The actual function pointer is stored in matrix_mdev->pqap_hook,
>> the reason being that the handle_pqap function in vfio_ap_ops.c
>> retrieves the matrix_mdev via a container_of macro. The dereferencing
>> of the vcpu->kvm->arch.crypto.pqap_hook into a local variable was
>> to get the function pointer. There may have been a more stylish
>> way of doing this, but the functionality is there.
> You are right, and I was wrong. But then we do have to distinct pointer
> deferences, and we check for NULL only once.
>
> I still do believe we do not have a potential null pointer dereference
> here, but the reason for that is that vfio-ap (the party that manages
> these pointers) guarantees that whenever
> vcpu->kvm->arch.crypto.pqap_hook != NULL is true,
> *vcpu->kvm->arch.crypto.pqap_hook != NULL is also true (and also that
> the function pointer is a valid one). Which is the case, because we
> set matrix_mdev->pqap_hook in vfio_ap_mdev_create() and don't touch
> it any more.
>
> In my opinion it is worth a comment.

Even I had to look at it again to respond to you, so a comment
is probably called for.

>
>
>>> Regards,
>>> Halil
>>>   
>>>>   
>>>>> +		ret = pqap_hook(vcpu);
> BTW the second dereference takes place here.
>
> If we wanted, we could make sure we don't dereference a null pointer
> here but I think that would be an overkill.

I agree, it is overkill.

>
> Regards,
> Halil
>>>> [...]

