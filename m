Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405469AbhARO5L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 09:57:11 -0500
Subject: Re: [PATCH 1/1] KVM: s390: diag9c forwarding
References: <20210118131739.7272-1-borntraeger@de.ibm.com>
 <20210118131739.7272-2-borntraeger@de.ibm.com>
 <db1d2a6e-1947-321b-bdc2-019eee5780f4@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <e6622462-cbdc-2aee-6e51-4a382b73808a@linux.ibm.com>
Date: Mon, 18 Jan 2021 15:56:23 +0100
MIME-Version: 1.0
In-Reply-To: <db1d2a6e-1947-321b-bdc2-019eee5780f4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>



On 1/18/21 2:45 PM, Janosch Frank wrote:
> On 1/18/21 2:17 PM, Christian Borntraeger wrote:
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> When we receive intercept a DIAG_9C from the guest we verify
>> that the target real CPU associated with the virtual CPU
>> designated by the guest is running and if not we forward the
>> DIAG_9C to the target real CPU.
>>
>> To avoid a diag9c storm we allow a maximal rate of diag9c forwarding.
>>
>> The rate is calculated as a count per second defined as a
>> new parameter of the s390 kvm module: diag9c_forwarding_hz .
>>
>> The default value is to not forward diag9c.
> 
> Before Conny starts yelling I'll do it myself:
> Documentation

yes, it comes soon.


-- 
Pierre Morel
IBM Lab Boeblingen
