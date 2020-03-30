Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgC3OOH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 10:14:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UE4OJD045620
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 10:14:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 301yfepv4b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 10:14:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 30 Mar 2020 15:13:54 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Add stsi 3.2.2 tests
References: <20200330122035.19607-1-frankja@linux.ibm.com>
 <df745d0c-5d24-ee03-8600-ec495f1a5af6@redhat.com>
 <d42ac187-9f8f-81eb-c9b4-4d585fdef236@linux.ibm.com>
 <727e1ed5-99ea-e559-ca9c-0f067cbcc153@linux.ibm.com>
 <ab811a78-fe3c-1c6b-bb6d-85466e040ac6@redhat.com>
 <2104b9a7-2ae0-6964-0eef-25ba7cca3119@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Mar 2020 16:13:59 +0200
MIME-Version: 1.0
In-Reply-To: <2104b9a7-2ae0-6964-0eef-25ba7cca3119@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2dcbdfed-d51d-1b21-87fc-78ab7f10c945@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com



On 30.03.20 15:30, Janosch Frank wrote:
> On 3/30/20 3:15 PM, David Hildenbrand wrote:
>> On 30.03.20 15:09, Janosch Frank wrote:
>>> On 3/30/20 3:03 PM, Janosch Frank wrote:
>>>> On 3/30/20 2:50 PM, David Hildenbrand wrote:
>>>>> On 30.03.20 14:20, Janosch Frank wrote:
>>>>>> +	report(data->vm[0].total_cpus == smp_query_num_cpus(), "cpu # total");
>>>>>> +	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu # configured");
>>>>>> +	report(data->vm[0].standby_cpus == 0, "cpu # standby");
>>>>>> +	report(data->vm[0].reserved_cpus == 0, "cpu # reserved");
>>>>>
>>>>> IIRC, using -smp 1,maxcpus=X, you could also test the reported reserved
>>>>> CPUs.
>>>>
>>>> Will try that
>>>
>>> Just like I thought, QEMU does not manipulate cpu counts and KVM
>>> pre-sets standby and reserved to 0. So we have absolutely no change when
>>> adding the smp parameter.
>>
>> Well, for TCG it is properly implemented. Is this a BUG in KVM's STSI code?
>>
> 
> KVM tracks online cpus and created cpus, but only reports the online
> ones in stsi.
> Will QEMU register/create a reserved CPU with KVM?
> 
> To fix this we could also fix-up the cpu reporting in QEMU after KVM
> wrote its results.
> 
> @Christian: Guidance?

The standby only make sense if we implement the sclp cpu configure things,
which we do not. So this can be considered reserved, while standby
must be 0.

I think we could implement this in QEMUs insert_stsi_3_2_2 function in kvm.c
