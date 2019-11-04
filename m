Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729236AbfKDOFS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:05:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4Dqxdf028813
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 09:05:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w2n8rrndd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 09:05:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 4 Nov 2019 14:05:14 -0000
Subject: Re: [RFC 14/37] KVM: s390: protvirt: Implement interruption injection
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-15-frankja@linux.ibm.com>
 <f51f2146-834c-ba48-1015-b83c4fe6cd54@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Nov 2019 15:05:08 +0100
MIME-Version: 1.0
In-Reply-To: <f51f2146-834c-ba48-1015-b83c4fe6cd54@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b48afe44-8195-e9ed-d005-bfecbcebb1ca@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 04.11.19 11:29, David Hildenbrand wrote:
> On 24.10.19 13:40, Janosch Frank wrote:
>> From: Michael Mueller <mimu@linux.ibm.com>
>>
>> The patch implements interruption injection for the following
>> list of interruption types:
>>
>>    - I/O
>>      __deliver_io (III)
>>
>>    - External
>>      __deliver_cpu_timer (IEI)
>>      __deliver_ckc (IEI)
>>      __deliver_emergency_signal (IEI)
>>      __deliver_external_call (IEI)
>>      __deliver_service (IEI)
>>
>>    - cpu restart
>>      __deliver_restart (IRI)
> 
> What exactly is IRQ_PEND_EXT_SERVICE_EV? Can you add some comments whet the new interrupt does and why it is needed in this context? Thanks

I did that code. What about the following add-on description.

The ultravisor does several checks on injected interrupts. For example it will
check that for an sclp interrupt with an sccb address we had an servc exit
and exit with a validity intercept. 
As the hypervisor must avoid valitity intercepts we now mask invalid interrupts.

There are also sclp interrupts that only inject an event (e.g. an input event
on the sclp consoles) those interrupts must not be masked.
Let us split out these "event interupts" from the normal sccb interrupts into
IRQ_PEND_EXT_SERVICE_EV. 
