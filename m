Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20093 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbgDXLXn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 07:23:43 -0400
Subject: Re: [PATCH v2 07/10] s390x: smp: Use full PSW to bringup new cpu
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-8-frankja@linux.ibm.com>
 <f13b31f6-80ef-9cfc-0cde-fe1c1601cf1f@redhat.com>
 <0f4ceb74-4ac4-4e26-3d2c-d8572b970cc8@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <03965ad8-c1e0-005a-b77a-9af740f0aa59@redhat.com>
Date: Fri, 24 Apr 2020 13:23:37 +0200
MIME-Version: 1.0
In-Reply-To: <0f4ceb74-4ac4-4e26-3d2c-d8572b970cc8@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 24.04.20 13:16, Janosch Frank wrote:
> On 4/24/20 12:09 PM, David Hildenbrand wrote:
>> On 23.04.20 11:10, Janosch Frank wrote:
>>> Up to now we ignored the psw mask and only used the psw address when
>>> bringing up a new cpu. For DAT we need to also load the mask, so let's
>>> do that.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  lib/s390x/smp.c  | 2 ++
>>>  s390x/cstart64.S | 3 ++-
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>> index 3f86243..6ef0335 100644
>>> --- a/lib/s390x/smp.c
>>> +++ b/lib/s390x/smp.c
>>> @@ -202,6 +202,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>>>  	cpu->stack = (uint64_t *)alloc_pages(2);
>>>  
>>>  	/* Start without DAT and any other mask bits. */
>>> +	cpu->lowcore->sw_int_psw.mask = psw.mask;
>>> +	cpu->lowcore->sw_int_psw.addr = psw.addr;
>>>  	cpu->lowcore->sw_int_grs[14] = psw.addr;
>>
>> Do we still have to set sw_int_grs[14] ?
>>
> r14 is saved to restart_new so we don't go through setup twice.
> We could instead copy cpu->lowcore->sw_int_psw.addr to restart new, but
> that means more changes than the removal of one line.
> 
> Also, what about backtraces or plain old debug?
> Having r14 is a good backup to have IMHO.
> 

Fine with me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
