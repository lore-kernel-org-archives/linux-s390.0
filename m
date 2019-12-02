Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55143 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727418AbfLBLRY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 06:17:24 -0500
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-3-git-send-email-pmorel@linux.ibm.com>
 <489b43a4-6f71-71bf-b936-e4c94e52387b@redhat.com>
 <7daddc03-35ec-f376-c80a-a849f9e11714@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3ce5d72d-ed1d-c689-a13f-6f409d085df7@redhat.com>
Date: Mon, 2 Dec 2019 12:17:17 +0100
MIME-Version: 1.0
In-Reply-To: <7daddc03-35ec-f376-c80a-a849f9e11714@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com

On 02.12.19 12:11, Janosch Frank wrote:
> On 11/28/19 3:36 PM, David Hildenbrand wrote:
>> On 28.11.19 13:46, Pierre Morel wrote:
>>> Let's define the PSW bits  explicitly, it will clarify their
>>> usage.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>  lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>>>  lib/s390x/asm/arch_def.h  |  6 ++----
>>
>> I'm sorry, but I don't really see a reason to move these 4/5 defines to
>> a separate header. Can you just keep them in arch_def.h and extend?
>>
>> (none of your other patches touch arch_bits.h - and it is somewhat a
>> weird name. Where to put something new: arch_def.h or arch_bits.h? I
>> would have understood "psw.h", but even that, I don't consider necessary)
>>
> 
> On a related note:
> I'd still like to split up the file soonish, maybe moving the functions
> into a new file?
> 
> @Thomas/David: What's your opinion on that?

Sure, as long as the file header is not longer as its actual content :D

-- 
Thanks,

David / dhildenb
