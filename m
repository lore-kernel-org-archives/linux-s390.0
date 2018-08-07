Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390x/mm: avoid taking the table lock in
 gmap_pmd_op_walk()
References: <20180806155407.15252-1-david@redhat.com>
 <d3e543bc-d0ff-c8ef-f097-eeba2bde6971@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <85e72251-fa72-9a3f-e2b0-6bc7d9482908@redhat.com>
Date: Tue, 7 Aug 2018 10:35:56 +0200
MIME-Version: 1.0
In-Reply-To: <d3e543bc-d0ff-c8ef-f097-eeba2bde6971@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07.08.2018 09:26, Janosch Frank wrote:
> On 06.08.2018 17:54, David Hildenbrand wrote:
>> Right now we temporarily take the page table lock in gmap_pmd_op_walk()
>> even though we know we won't need it (if we can never have 1mb pages
>> mapped into the gmap).
>>
>> So let's special case this, so
>> gmap_protect_range()/gmap_sync_dirty_log_pmd() will not take the lock in
>> case huge pages are not allowed.
> 
> So, let's make this a special case
> 
>>
>> gmap_protect_range() is called quite frequently for managing shadow
>> page tables in vSIE environments.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> If you make the patch title more specific:
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


"s390/mm: optimize locking without huge pages in gmap_pmd_op_walk()"

Thanks!

-- 

Thanks,

David / dhildenb
