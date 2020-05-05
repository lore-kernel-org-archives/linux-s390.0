Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728481AbgEEIr7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 04:47:59 -0400
Subject: Re: [PATCH v2] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
References: <20200505083515.2720-1-borntraeger@de.ibm.com>
 <20200505104610.469be44e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <38cf6dda-3118-8e72-a246-4371c1549995@redhat.com>
Date: Tue, 5 May 2020 10:47:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200505104610.469be44e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Qian Cai <cailca@icloud.com>, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>

On 05.05.20 10:46, Cornelia Huck wrote:
> On Tue,  5 May 2020 10:35:15 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> In LPAR we will only get an intercept for FC==3 for the PQAP
>> instruction. Running nested under z/VM can result in other intercepts as
>> well as ECA_APIE is an effective bit: If one hypervisor layer has
>> turned this bit off, the end result will be that we will get intercepts for
>> all function codes. Usually the first one will be a query like PQAP(QCI).
>> So the WARN_ON_ONCE is not right. Let us simply remove it.
> 
> Thanks, that is helpful to describe.
> 
> Fixes: e5282de93105 ("s390: ap: kvm: add PQAP interception for AQIC")

And maybe add a # v5.3+ to the stable-cc.

-- 
Thanks,

David / dhildenb
