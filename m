Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727683AbfJJKE7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 06:04:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9A9a4lq002834
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 06:04:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vj1t49ma9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 06:04:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 10 Oct 2019 11:04:55 +0100
Subject: Re: [PATCH] selftests: kvm: make syncregs more reliable on s390
References: <20191010075236.100247-1-borntraeger@de.ibm.com>
 <8c8235e0-7502-c2be-179e-ba0303cb2ca9@redhat.com>
 <c2555ca7-62b2-ee81-fc32-689740754f98@de.ibm.com>
 <e5f83fc6-1d5e-85fa-f4ed-0266e5402ef5@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 10 Oct 2019 12:04:51 +0200
MIME-Version: 1.0
In-Reply-To: <e5f83fc6-1d5e-85fa-f4ed-0266e5402ef5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <036868cd-e6ce-69c8-ba9d-0a307897bc27@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>



On 10.10.19 11:15, Thomas Huth wrote:
> On 10/10/2019 11.12, Christian Borntraeger wrote:
>>
>>
>> On 10.10.19 10:20, Thomas Huth wrote:
>>> On 10/10/2019 09.52, Christian Borntraeger wrote:
>>>> similar to commit 2c57da356800 ("selftests: kvm: fix sync_regs_test with
>>>> newer gccs") and commit 204c91eff798a ("KVM: selftests: do not blindly
>>>> clobber registers in guest asm") we better do not rely on gcc leaving
>>>> r11 untouched.  We can write the simple ucall inline and have the guest
>>>> code completely as small assembler function.
>>>>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>>>  .../testing/selftests/kvm/s390x/sync_regs_test.c  | 15 +++++++++------
>>>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>>>> index d5290b4ad636..04d6abe68961 100644
>>>> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>>>> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>>>> @@ -25,12 +25,15 @@
>>>>  
>>>>  static void guest_code(void)
>>>>  {
>>>> -	register u64 stage asm("11") = 0;
>>>> -
>>>> -	for (;;) {
>>>> -		GUEST_SYNC(0);
>>>> -		asm volatile ("ahi %0,1" : : "r"(stage));
>>>> -	}
>>>> +	/*
>>>> +	 * we embed diag 501 here instead of a ucall as the called function
>>>> +	 * could mess with the content of r11 when doing the hypercall
>>>
>>> As far as I understood the issue on x86, it's not the called function
>>> that is messing with the counter register (since r11 is not volatile
>>> between function calls), but the compiler shuffled it around here
>>> between the GUEST_SYNC and the inline assembler code. So I'd prefer a
>>> comment like in the x86 version:
>>
>> It is actually both.
>> The called function is GUEST_SYNC  (which is ucall). 
>> r11 is call-saved, so when we return from GUEST_SYNC r11 is as it is supposed
>> to be. The problem is that this function (ucall) is allowed to use r11 for anything
>> as long as it restores it before returning. As we do the guest exit in ucall
>> then the test code could see some random value for r11.
> 
> Oh, right!
> 
>>>  /*
>>>   * We embed diag 501 here instead of doing a ucall to avoid that
>>>   * the compiler reshuffles registers before calling the function.
>>>   */
>>>
>>> ?
>>
>> What about
>>>  /*
>>>   * We embed diag 501 here instead of doing a ucall to avoid that
>>>   * the compiler has messed with r11 at the time of the ucall.
>>>   */
> 
> Sounds good!

applied.
