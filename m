Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA52C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA51610A1
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 13:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhHSNhS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:37:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238488AbhHSNhR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Aug 2021 09:37:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JDY4KA094420;
        Thu, 19 Aug 2021 09:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FX9cqd2zeAbF63/P2BBKPXN9TyM96zKyu+g9iYDCKwY=;
 b=TtvaTaC8kzLd4WIAARyS8MGcaQQUWB2KzmED0r1GX0J0nAjhxBI3T+ryGIcRsUyMdL04
 cRnqagcuSkjOt8xzWvGDqYSsy0D07gVq5vQdGxbKx4yxBVS/Ic/0zgybpFyEJvGoCluQ
 hIjcxEA2R//JfnnM+XFIBl3hLKTk3qc5TqbCnuwq2nrY7g6lfHZQs3ULRsDm1sxg/DKE
 i1PDQzFscZ0tadTAN/cpzBpkONeU70EVkn++Uo5rUYH85Ds3NhuhWQy533qhvc8Bilut
 4L5JGr5YCXrUNFVvTMmeL6iQavdeZYkjVdNMWoaNZz2G+gVaksVN6kPS92GTwFr/tZ1e DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3agp2cx235-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:36:39 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JDacaU110490;
        Thu, 19 Aug 2021 09:36:38 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3agp2cx22w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:36:38 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JDQUGa017137;
        Thu, 19 Aug 2021 13:36:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3aeexy5jcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 13:36:37 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JDaZ8G53281186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:36:36 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C59AB136055;
        Thu, 19 Aug 2021 13:36:35 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCD2613604F;
        Thu, 19 Aug 2021 13:36:34 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Aug 2021 13:36:34 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
 <20210819012532.0e9c443c.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <8df389f7-44aa-978e-84d8-96c625b0470b@linux.ibm.com>
Date:   Thu, 19 Aug 2021 09:36:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819012532.0e9c443c.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dC_GBF5zJjjm9JojMCJ3wYXRm4HpLBBI
X-Proofpoint-GUID: z9oeVDuXijct1ftp08dJErYeU0wxAZV_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_04:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/18/21 7:25 PM, Halil Pasic wrote:
> On Wed, 18 Aug 2021 19:03:33 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> On 19.07.21 21:35, Tony Krowiak wrote:
>>> The function pointer to the interception handler for the PQAP instruction
>>> can get changed during the interception process. Let's add a
>>> semaphore to struct kvm_s390_crypto to control read/write access to the
>>> function pointer contained therein.
>>>
>>> The semaphore must be locked for write access by the vfio_ap device driver
>>> when notified that the KVM pointer has been set or cleared. It must be
>>> locked for read access by the interception framework when the PQAP
>>> instruction is intercepted.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> ---
>>>    arch/s390/include/asm/kvm_host.h      |  8 +++-----
>>>    arch/s390/kvm/kvm-s390.c              |  1 +
>>>    arch/s390/kvm/priv.c                  | 10 ++++++----
>>>    drivers/s390/crypto/vfio_ap_ops.c     | 23 +++++++++++++++++------
>>>    drivers/s390/crypto/vfio_ap_private.h |  2 +-
>>>    5 files changed, 28 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>> index 9b4473f76e56..f18849d259e6 100644
>>> --- a/arch/s390/include/asm/kvm_host.h
>>> +++ b/arch/s390/include/asm/kvm_host.h
>>> @@ -798,14 +798,12 @@ struct kvm_s390_cpu_model {
>>>    	unsigned short ibc;
>>>    };
>>>    
>>> -struct kvm_s390_module_hook {
>>> -	int (*hook)(struct kvm_vcpu *vcpu);
>>> -	struct module *owner;
>>> -};
>>> +typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
>>>    
>>>    struct kvm_s390_crypto {
>>>    	struct kvm_s390_crypto_cb *crycb;
>>> -	struct kvm_s390_module_hook *pqap_hook;
>>> +	struct rw_semaphore pqap_hook_rwsem;
>>> +	crypto_hook *pqap_hook;
>>>    	__u32 crycbd;
>>>    	__u8 aes_kw;
>>>    	__u8 dea_kw;
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index b655a7d82bf0..a08f242a9f27 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -2630,6 +2630,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>>>    {
>>>    	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>>>    	kvm_s390_set_crycb_format(kvm);
>>> +	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
>>>    
>>>    	if (!test_kvm_facility(kvm, 76))
>>>    		return;
>>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>>> index 9928f785c677..6bed9406c1f3 100644
>>> --- a/arch/s390/kvm/priv.c
>>> +++ b/arch/s390/kvm/priv.c
>>> @@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>>    static int handle_pqap(struct kvm_vcpu *vcpu)
>>>    {
>>>    	struct ap_queue_status status = {};
>>> +	crypto_hook pqap_hook;
>>>    	unsigned long reg0;
>>>    	int ret;
>>>    	uint8_t fc;
>>> @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>>    	 * Verify that the hook callback is registered, lock the owner
>>>    	 * and call the hook.
>>>    	 */
>>> +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>>>    	if (vcpu->kvm->arch.crypto.pqap_hook) {                     <--- HERE
>>> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
>>> -			return -EOPNOTSUPP;
>>> -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
>>> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>>> +		pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;
>> Dont we have to check for NULL here? If not can you add a comment why?
> I believe we did the necessary check on the line I just marked with
> "<--- HERE".
>
> I find that "*" operator confusing in this context as it doesn't do
> any good for us. I believe this situation is described in 6.5.3.2.4 of
> the c11 standard. For convenience I will cite from the corresponding
> draft:
> "The unary * operator denotes indirection. If the operand points to a
> function, the result is a function designator; if it points to an
> object, the result is an lvalue designating the object. If the operand
> has type ‘‘pointer to type’’, the result has type ‘‘type’’. If an
> invalid value has been assigned to the pointer, the behavior of the
> unary * operator is undefined."
>
> Frankly I also fail to see the benefit of introducing the local variable
> named "pqap_hook", but back then I decided to not complain about style.

The vcpu->kvm->arch.crypto.pqap_hook is a pointer to a function
pointer. The actual function pointer is stored in matrix_mdev->pqap_hook,
the reason being that the handle_pqap function in vfio_ap_ops.c
retrieves the matrix_mdev via a container_of macro. The dereferencing
of the vcpu->kvm->arch.crypto.pqap_hook into a local variable was
to get the function pointer. There may have been a more stylish
way of doing this, but the functionality is there.

>
> Regards,
> Halil
>
>>
>>> +		ret = pqap_hook(vcpu);
>> [...]

