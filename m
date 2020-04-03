Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728154AbgDCNJb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 09:09:31 -0400
Subject: Re: [PATCH v1 5/5] KVM: s390: vsie: gmap_table_walk() simplifications
References: <20200402184819.34215-1-david@redhat.com>
 <20200402184819.34215-6-david@redhat.com>
 <99c824d1-88ca-c98d-c4e9-75a97c2a8a7b@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <867be74b-0ff2-23e1-3d02-3803c478e205@redhat.com>
Date: Fri, 3 Apr 2020 15:09:22 +0200
MIME-Version: 1.0
In-Reply-To: <99c824d1-88ca-c98d-c4e9-75a97c2a8a7b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 03.04.20 15:03, Janosch Frank wrote:
> On 4/2/20 8:48 PM, David Hildenbrand wrote:
>> Let's use asce_type where applicable. Also, simplify our sanity check for
>> valid table levels and convert it into a WARN_ON_ONCE(). Check if we even
>> have a valid gmap shadow as the very first step.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/mm/gmap.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index fd32ab566f57..3c801dae7988 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -790,17 +790,18 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
>>  	const int asce_type = gmap->asce & _ASCE_TYPE_MASK;
>>  	unsigned long *table;
>>  
>> -	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
>> -		return NULL;
>>  	if (gmap_is_shadow(gmap) && gmap->removed)
>>  		return NULL;
>>  
>> +	if (WARN_ON_ONCE(level > (asce_type >> 2) + 1))
>> +		return NULL;
>> +
>>  	if (WARN_ON_ONCE(asce_type != _ASCE_TYPE_REGION1) &&
>>  			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
>>  		return NULL;
>>  
>>  	table = gmap->table;
> 
> We could also initialize this variable at the top, no?

very right, add that.


-- 
Thanks,

David / dhildenb
