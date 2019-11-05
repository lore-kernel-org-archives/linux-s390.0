Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390560AbfKESP1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 13:15:27 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5IE39W119937
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 13:15:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3dqsh6x4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 13:15:26 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 5 Nov 2019 18:15:24 -0000
Subject: Re: [RFC 12/37] KVM: s390: protvirt: Handle SE notification
 interceptions
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-13-frankja@linux.ibm.com>
 <20191105190407.68992d92.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 5 Nov 2019 19:15:19 +0100
MIME-Version: 1.0
In-Reply-To: <20191105190407.68992d92.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f0837f93-ace8-b4e0-f69c-c1fbe7b95c6a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com



On 05.11.19 19:04, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:34 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> Since KVM doesn't emulate any form of load control and load psw
>> instructions anymore, we wouldn't get an interception if PSWs or CRs
>> are changed in the guest. That means we can't inject IRQs right after
>> the guest is enabled for them.
>>
>> The new interception codes solve that problem by being a notification
>> for changes to IRQ enablement relevant bits in CRs 0, 6 and 14, as
>> well a the machine check mask bit in the PSW.
>>
>> No special handling is needed for these interception codes, the KVM
>> pre-run code will consult all necessary CRs and PSW bits and inject
>> IRQs the guest is enabled for.
> 
> Just to clarify: The hypervisor can still access the relevant bits for
> pv guests, this is only about the notification, right?
> 

Yes, the hypervisor (KVM) can always read the relevant PSW bits (I,E,M) and
CR bits to decide if an interrupt can be delivered. All other bits of PSW
and CRx are masked though.
This is a new intercept for notification as we do no longer get an IC4 (instruction
to handle) for load control and friends so that we can re-check the bits. 
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  2 ++
>>  arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
>>  2 files changed, 20 insertions(+)
> 
