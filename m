Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728051AbgBTNe7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Feb 2020 08:34:59 -0500
Subject: Re: [PATCH v2 02/42] KVM: s390/interrupt: do not pin adapter
 interrupt pages
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-3-borntraeger@de.ibm.com>
 <073d3666-480e-5ba5-a46b-4cbd615f4174@redhat.com>
 <45954200-ccfe-cfac-200d-d1b903d9fc39@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7f4c303f-a5e4-7e5b-1af9-72e3e256992d@redhat.com>
Date: Thu, 20 Feb 2020 14:34:45 +0100
MIME-Version: 1.0
In-Reply-To: <45954200-ccfe-cfac-200d-d1b903d9fc39@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

>> AFAIK, leaving e->adapter.summary_addr set is not an issue.
>>
>> Interesting, in kvm_s390_adapter_map(), we didn't synchronize again slot
>> updates when doing the gmap_translate(), which looks wrong to me ...
>>
>> It seems to be the same thing here. I do wonder if it is safe to do a
>> gmap_translate() here, looks like this can race with
>> kvm_arch_commit_memory_region().
>>
>> I would have assumed we need e.g., the slots_lock while doing the
>> gmap_translate() - or a srcu_read_lock(&vcpu->kvm->srcu) or similar ...
> 
> gmap_translate does this via the gmap and it holds the mm sem. gmap_unmap_segment
> takes the same lock. So I think we are ok here.

Ahh, I was looking at __gmap_translate(). Makes sense.

-- 
Thanks,

David / dhildenb
