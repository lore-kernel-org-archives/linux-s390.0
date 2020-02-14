Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59600 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729026AbgBNKfH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 05:35:07 -0500
Subject: Re: [PATCH 04/35] s390/protvirt: add ultravisor initialization
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-5-borntraeger@de.ibm.com>
 <44aa351c-2333-e1df-42ce-6cf3a6808802@redhat.com>
 <81e4d5a1-ec8a-4de8-e136-8e61ad1fc788@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fa6ba72c-0f24-a3c0-442c-ff7613fbf05a@redhat.com>
Date: Fri, 14 Feb 2020 11:34:55 +0100
MIME-Version: 1.0
In-Reply-To: <81e4d5a1-ec8a-4de8-e136-8e61ad1fc788@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>


>>
>>> +	prot_virt_host = 0;> +}
>>> +
>>> +void adjust_to_uv_max(unsigned long *vmax)
>>> +{
>>> +	if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
>>> +		*vmax = uv_info.max_sec_stor_addr;
>>
>> Once you move the prot virt check out of this function
> 
> 
>>
>> 	*vmax = max_t(unsigned long, *vmax, uv_info.max_sec_stor_addr);

actually min_t, sorry :)


-- 
Thanks,

David / dhildenb
