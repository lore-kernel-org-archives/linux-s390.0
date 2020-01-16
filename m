Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46883 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726925AbgAPNTJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 08:19:09 -0500
Subject: Re: [kvm-unit-tests PATCH v2 3/7] s390x: Add cpu id to interrupt
 error prints
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-4-frankja@linux.ibm.com>
 <1bf32ccd-4047-7676-2ef4-a3327bf3995f@redhat.com>
 <95c0a6af-7334-1825-226e-5973a639035a@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7308d55c-eaa8-3b43-12b2-86af7641514a@redhat.com>
Date: Thu, 16 Jan 2020 14:19:01 +0100
MIME-Version: 1.0
In-Reply-To: <95c0a6af-7334-1825-226e-5973a639035a@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 16.01.20 14:04, Janosch Frank wrote:
> On 1/16/20 1:17 PM, David Hildenbrand wrote:
>> On 16.01.20 13:05, Janosch Frank wrote:
>>> It's good to know which cpu broke the test.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  lib/s390x/interrupt.c | 20 ++++++++++----------
>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>>> index 05f30be..773752a 100644
>>> --- a/lib/s390x/interrupt.c
>>> +++ b/lib/s390x/interrupt.c
>>> @@ -107,8 +107,8 @@ static void fixup_pgm_int(void)
>>>  void handle_pgm_int(void)
>>>  {
>>>  	if (!pgm_int_expected)
>>> -		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
>>> -			     lc->pgm_int_code, lc->pgm_old_psw.addr,
>>> +		report_abort("Unexpected program interrupt: %d on cpu %d at %#lx, ilen %d\n",
>>> +			     lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
>>>  			     lc->pgm_int_id);
>>
>> nit: "cpu: %d"
>>
>>>  
>>>  	pgm_int_expected = false;
>>> @@ -119,8 +119,8 @@ void handle_ext_int(void)
>>>  {
>>>  	if (!ext_int_expected &&
>>>  	    lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
>>> -		report_abort("Unexpected external call interrupt (code %#x): at %#lx",
>>> -			     lc->ext_int_code, lc->ext_old_psw.addr);
>>> +		report_abort("Unexpected external call interrupt (code %#x): on cpu %d at %#lx",
>>> +			     stap(), lc->ext_int_code, lc->ext_old_psw.addr);
>>
>> nit: "(code %#x) on cpu: %d" ...
> 
> So, should I move the old : or add a second one?

No strong feelings, whatever you prefer. (you can also keep it
unchanged, it's just a test error output after all)


-- 
Thanks,

David / dhildenb
