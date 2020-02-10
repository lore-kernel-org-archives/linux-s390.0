Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726991AbgBJSv6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:51:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AIoGTV021186
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:51:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u80jtum-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:51:57 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 18:51:55 -0000
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
 <d8622308-6089-50a4-54e0-277dc7c8c74b@redhat.com>
 <f7065c72-0487-9d03-a286-f75a60b4ac5f@de.ibm.com>
 <b2599c29-a074-706e-c74e-3f445d65b6f7@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 19:51:48 +0100
MIME-Version: 1.0
In-Reply-To: <b2599c29-a074-706e-c74e-3f445d65b6f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ec70cc9c-180d-9740-580b-0ec26331cfd8@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>



On 10.02.20 19:43, David Hildenbrand wrote:
> On 10.02.20 19:28, Christian Borntraeger wrote:
>>
>>
>> On 10.02.20 19:17, David Hildenbrand wrote:
>>> On 07.02.20 12:39, Christian Borntraeger wrote:
>>>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>>>
>>>> With the introduction of protected KVM guests on s390 there is now a
>>>> concept of inaccessible pages. These pages need to be made accessible
>>>> before the host can access them.
>>>>
>>>> While cpu accesses will trigger a fault that can be resolved, I/O
>>>> accesses will just fail.  We need to add a callback into architecture
>>>> code for places that will do I/O, namely when writeback is started or
>>>> when a page reference is taken.
>>>
>>> My question would be: What guarantees that the page will stay accessible
>>> (for I/O)? IIRC, pages can be converted back to secure/inaccessible
>>> whenever the guest wants to access them. How will that be dealt with?
>>
>> Yes, in patch 5 we do use the page lock, PageWriteBack and page_ref_freeze
>> to only make the page secure again if no I/O is going to be started or
>> still running.
>>
>> We have minimized the common code impact (just these 3 callbacks) so that 
>> architecture code can do the right thing.
> 
> So the magic is
> 
> +static int expected_page_refs(struct page *page)
> +{
> +	int res;
> +
> +	res = page_mapcount(page);
> +	if (PageSwapCache(page))
> +		res++;
> +	else if (page_mapping(page)) {
> +		res++;
> +		if (page_has_private(page))
> +			res++;
> +	}
> +	return res;
> +}
> [...]
> +static int make_secure_pte(pte_t *ptep, unsigned long addr, void *data)
> [...]
> +	if (PageWriteback(page))
> +		return -EAGAIN;
> +	expected = expected_page_refs(page);
> +	if (!page_ref_freeze(page, expected))
> +		return -EBUSY;
> [...]
> +	rc = uv_call(0, (u64)params->uvcb);
> +	page_ref_unfreeze(page, expected);
> 
> As long as a page is does not have the expected refcount, it cannot be
> convert to secure and not used by the guest.
> 
> I assume this implies, that if a guest page is pinned somewhere (e.g.,
> in KVM), it won't be usable by the guest.

Yes, but you can always exit QEMU nothing will "block". You you have a permanent
SIE exit. This is something that should not happen for QEMU/KVM and the expected
refcount logic can be found in many common code places. 
> 
> Please add all these details to the patch description. I think they are
> crucial to understand how this is expected to work and to be used.

Makes sense. Will add more explanation to patch 5.
Ulrich also had some idea how to simplify patch 5 in some places.
