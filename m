Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbfGCAkn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 20:40:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62K7Okj079714
        for <linux-s390@vger.kernel.org>; Tue, 2 Jul 2019 16:08:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgdxqg5ha-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 02 Jul 2019 16:08:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 2 Jul 2019 21:08:18 +0100
Subject: Re: [PATCH v5 2/2] s390/kvm: diagnose 318 handling
References: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
 <1561475022-18348-3-git-send-email-walling@linux.ibm.com>
 <19c73246-48dd-ddc6-c5b1-b93f15cbf2f0@redhat.com>
 <17fe3423-91b1-2351-54cb-26cd9e1b0e3f@de.ibm.com>
 <dd1f4c39-9937-b223-adc8-01a764cf9462@linux.ibm.com>
 <a7f4b3aa-b9d8-59b3-22c4-251acc2ef20f@redhat.com>
 <ae6e3725-2d5e-3fc6-96bf-7875fb14d919@linux.ibm.com>
 <78617ca5-d822-ea4e-60ef-7a545b23ef15@de.ibm.com>
 <3bc397ef-990e-a35f-b619-a60c526dd39e@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 2 Jul 2019 22:08:13 +0200
MIME-Version: 1.0
In-Reply-To: <3bc397ef-990e-a35f-b619-a60c526dd39e@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <cb46a253-2df7-6349-63f8-bcf230989649@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, David Hildenbrand <david@redhat.com>, cohuck@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org



On 02.07.19 22:04, Collin Walling wrote:
> On 7/2/19 4:00 PM, Christian Borntraeger wrote:
>>
>>
>> On 02.07.19 21:50, Collin Walling wrote:
>>> On 6/26/19 10:31 AM, David Hildenbrand wrote:
>>>> On 26.06.19 16:30, Collin Walling wrote:
>>>>> On 6/26/19 6:28 AM, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 26.06.19 11:45, David Hildenbrand wrote:
>>>>>>
>>>>>>>
>>>>>>> BTW. there is currently no mechanism to fake absence of diag318. Should
>>>>>>> we have one? (in contrast, for CMMA we have, which is also a CPU feature)
>>>>>>
>>>>>> Yes, we want to be able to disable diag318 via a CPU model feature. That actually
>>>>>> means that the kernel must not answer this if we disable it.
>>>>>>
>>>>> Correct. If the guest specifies diag318=off, then the instruction
>>>>> shouldn't be executed (it is fenced off in the kernel by checking the
>>>>> Read SCP Info bit).
>>>>
>>>> But the guest *could* execute it and not get an exception.
>>>>
>>>
>>> IIUC, you're talking about the situation where QEMU supports diag318,
>>> but KVM does not. The worst case is the guest specifies diag318=on, and
>>> nothing will stop the guest from attempting to execute the instruction.
>>>
>>> However, this is fenced in my QEMU patches. In (v5), I have this
>>> following snippet:
>>>
>>> @@ -2323,6 +2345,13 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>>           KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
>>>           set_bit(S390_FEAT_AP, model->features);
>>>       }
>>> +
>>> +    /* if KVM supports interception of diag318, then let's provide the bit */
>>> +    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_MISC,
>>> +        KVM_S390_VM_MISC_DIAG318)) {
>>> +        set_bit(S390_FEAT_DIAG318, model->features);
>>> +    }
>>> +
>>>       /* strip of features that are not part of the maximum model */
>>>       bitmap_and(model->features, model->features, model->def->full_feat,
>>>                  S390_FEAT_MAX);
>>>
>>> If the guest specifies diag318=on, and KVM does *not* support emulation,
>>> then the following message will be observed:
>>>
>>> qemu-system-s390x: Some features requested in the CPU model are not
>>> available in the configuration: diag318
>>>
>>> and the guest will fail to start. Does this suffice?
>>
>> But what happens if the guest ignores read scp info and executes diag318 anyway.
>> It should get a specification exception, but it does not instead diag318 is
>> executed.
>>

> 
> Hmm... I'm not following the logic here. When or how could diag318 be
> executed without checking the feature bit? Are we concerned about other
> hypervisors running a linux guest with diag318 enabled? Understanding
> the scenario will help me follow along with this issue.

A malicious or broken guest could just ignore the scp info bit.

In the end it is just architectural compliance. If the scp info bit is off, diag318 must
result in a specification exception, which is does not right now.
