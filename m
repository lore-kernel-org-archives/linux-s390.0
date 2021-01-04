Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbhADPiW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jan 2021 10:38:22 -0500
Subject: Re: [PATCH v1 1/4] s390/kvm: VSIE: stop leaking host addresses
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
 <20201218141811.310267-2-imbrenda@linux.ibm.com>
 <b1a31982-a967-7439-1a7c-3c948deeb79d@redhat.com>
 <20210104145802.7a2274a2@ibm-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4d7ea3de-61b7-af89-a3d4-5a4b5749f667@redhat.com>
Date: Mon, 4 Jan 2021 16:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <20210104145802.7a2274a2@ibm-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

>> In that case, it's pretty much a random number (of a random page used
>> as a leave page table) and does not let g1 identify locations of
>> symbols etc. If so, I don't think this is a "clear security issue"
>> and suggest squashing this into the actual fix (#p4 I assume).
> 
> yeah __maybe__ I overstated the importance ;)
> 
> But I would still like to keep it as a separate patch, looks more
> straightforward to me
>  

I don't see a need to split this up. Just fix it right away.


-- 
Thanks,

David / dhildenb
