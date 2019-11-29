Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfK2Ojm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 09:39:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATEbIkM116932
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:39:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjvaua2f9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:39:41 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 29 Nov 2019 14:39:39 -0000
Subject: Re: [PATCH] KVM: s390: Add new reset vcpu API
References: <20191129142122.21528-1-frankja@linux.ibm.com>
 <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
 <8e1aa1af-d929-e36b-f341-aa7dbe27f6a4@linux.ibm.com>
 <227a8fce-7e14-030e-b0a4-17e4521eed98@redhat.com>
 <dedd1d55-bebb-059e-c8c9-7c2771afa157@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 29 Nov 2019 15:39:35 +0100
MIME-Version: 1.0
In-Reply-To: <dedd1d55-bebb-059e-c8c9-7c2771afa157@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <708d16c2-fa18-8ab9-afb5-44b5af638cb4@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 29.11.19 15:38, Janosch Frank wrote:
[...]
>>>> As we now have two interfaces to achieve the same thing (initial reset),
>>>> I do wonder if we should simply introduce
>>>>
>>>> KVM_S390_NORMAL_RESET
>>>> KVM_S390_CLEAR_RESET
>>>>
>>>> instead ...
>>>>
>>>> Then you can do KVM_S390_NORMAL_RESET for the bugfix and
>>>> KVM_S390_CLEAR_RESET later for PV.
>>>>
>>>> Does anything speak against that?
>>>
>>> Apart from loosing one more ioctl number probably not
>>
>> Do we care? (I think not, but maybe I am missing something :) )
>>
> 
> I don't, maybe somebody else does
> Btw. I'm struggling to find a good name for the capability:
> KVM_CAP_S390_VCPU_ADDITIONAL_RESETS ?

KVM_CAP_S390_VCPU_RESETS ?
