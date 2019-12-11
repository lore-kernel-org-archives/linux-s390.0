Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36616 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729298AbfLKMyT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Dec 2019 07:54:19 -0500
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: smp: Setup CRs from cpu 0
References: <20191211115923.9191-1-frankja@linux.ibm.com>
 <20191211115923.9191-3-frankja@linux.ibm.com>
 <75eadbf8-1159-1c3f-12c4-bda518adb2ef@redhat.com>
 <15cd9f10-a56b-949d-dc0f-2d5aa175222a@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <03e80db5-dee7-b646-dd01-f713cdecbc29@redhat.com>
Date: Wed, 11 Dec 2019 13:54:11 +0100
MIME-Version: 1.0
In-Reply-To: <15cd9f10-a56b-949d-dc0f-2d5aa175222a@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

On 11.12.19 13:37, Janosch Frank wrote:
> On 12/11/19 1:32 PM, David Hildenbrand wrote:
>> On 11.12.19 12:59, Janosch Frank wrote:
>>> Grab the CRs (currently only 0, 1, 7, 13) from cpu 0, so we can
>>> bringup the new cpu in DAT mode or set other control options.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  lib/s390x/smp.c  | 5 ++++-
>>>  s390x/cstart64.S | 2 +-
>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>> index e17751a..4dfe7c6 100644
>>> --- a/lib/s390x/smp.c
>>> +++ b/lib/s390x/smp.c
>>> @@ -191,7 +191,10 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>>>  	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4);
>>>  	lc->restart_new_psw.mask = 0x0000000180000000UL;
>>>  	lc->restart_new_psw.addr = (uint64_t)smp_cpu_setup_state;
>>> -	lc->sw_int_crs[0] = 0x0000000000040000UL;
>>> +	lc->sw_int_crs[0] = stctg(0);
>>> +	lc->sw_int_crs[1] = stctg(1);
>>> +	lc->sw_int_crs[7] = stctg(7);
>>> +	lc->sw_int_crs[13] = stctg(13);
>>
>> Wouldn't it be better to also be able to specify the CRs explicitly here?
>>
> 
> Yes, but currently there are no users for something like that and it
> would mean that we might need to add more code to support it.
> 
> As I said in the cover letter, this is a good first step to allow DAT on
> additional cpus without any real setup needed in a test. Later we could
> add a function to specify the CRs explicitly.
> 

Can you clarify why we need this patch now (e.g., DAT)? This patch
sounds like it would make sense in the future only (it is easier to
review with future changes IMHO).

-- 
Thanks,

David / dhildenb
