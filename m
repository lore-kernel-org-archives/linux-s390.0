Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727792AbgEFMXU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 08:23:20 -0400
Subject: Re: [GIT PULL 1/1] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
 <20200506115945.13132-2-borntraeger@de.ibm.com>
 <bcd98cbd-1e28-47a2-6cbd-668da4ddb9f5@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <fe991071-25d0-3842-73cc-23cb365850f3@de.ibm.com>
Date: Wed, 6 May 2020 14:23:12 +0200
MIME-Version: 1.0
In-Reply-To: <bcd98cbd-1e28-47a2-6cbd-668da4ddb9f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Qian Cai <cailca@icloud.com>



On 06.05.20 14:12, Paolo Bonzini wrote:
> On 06/05/20 13:59, Christian Borntraeger wrote:
>> Running nested under z/VM can result in other intercepts as
>> well as ECA_APIE is an effective bit: If one hypervisor layer has
>> turned this bit off, the end result will be that we will get intercepts for
>> all function codes. Usually the first one will be a query like PQAP(QCI).
>> So the WARN_ON_ONCE is not right. Let us simply remove it.
> 
> Possibly stupid question since I can only recognize some words here. :)
> But anyway... shouldn't z/VM trap this intercept when the guest has
> turned off the bit, and only reflect the SIE exit based on the function
> code?

So here is my theory.

the problem is that z/VM seems to have disabled that bit. The interpretion
only works when all layers have this bit set. (Its called an effective bit). 
So we have
LPAR -> ECA_APIE = 1
Z/VM -> ECA_APIE = 0
KVM  -> ECA_APIE = 1
nested KVM guest --> does during boot in ap_instructions_available PQAP with
FC==0 to test if crypto is available.

As the nested guest is in fact a shadow guest of z/VM
this will now intercept to z/VM, which will forward that to KVM.

As PQAP with FC==0 DOES work in the KVM, KVM believes that we have crypto
support and we will enable it for our guests. So all the early checks in
handle_pqap will succeed until we run in the check for fc!=3.

In the end this is obviously a case how this warning can trigger. So we better
remove it and rely on the error path to clean up.
