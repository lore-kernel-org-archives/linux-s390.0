From: David Hildenbrand <david@redhat.com>
Date: Thu, 10 Jan 2019 13:24:08 +0000
Subject: Re: [kvm-unit-tests PATCH v4 08/13] s390x: Add linemode console
Message-Id: <fbacd28b-e7d0-3811-b442-ef2e976bf32a@redhat.com>
In-Reply-To: <9039d9b9-0c55-1873-58c5-bbabae75fbf2@linux.ibm.com>
References: <9039d9b9-0c55-1873-58c5-bbabae75fbf2@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 10.01.19 14:20, Janosch Frank wrote:
> On 10.01.19 13:39, David Hildenbrand wrote:
>> On 10.01.19 13:34, Janosch Frank wrote:
>>> On 10.01.19 13:23, David Hildenbrand wrote:
>>>> On 03.01.19 11:08, Janosch Frank wrote:
>>>>> z/VM isn't fond of vt220, so we need line mode when running under z/VM.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>  lib/s390x/sclp-console.c | 178 ++++++++++++++++++++++++++++++++++++++++++-----
>>>>>  lib/s390x/sclp.h         |  67 ++++++++++++++++++
>>>>>  2 files changed, 228 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
>>>>> index a5ef45f..6b30fab 100644
>>>>> --- a/lib/s390x/sclp-console.c
>>>>> +++ b/lib/s390x/sclp-console.c
>>>>> @@ -11,21 +11,167 @@
>>>>>  #include <libcflat.h>
>>>>>  #include <string.h>
>>>>>  #include <asm/page.h>
>>>>> +#include <asm/arch_def.h>
>>>>> +#include <asm/io.h>
>>>>>  #include "sclp.h"
>>>>>  
>>> [...]
>>>>> +
>>>>> +static void sclp_print_ascii(const char *str)
>>>>> +{
>>>>> +	int len = strlen(str);
>>>>> +	WriteEventData *sccb = (void *)_sccb;
>>>>> +
>>>>> +	sclp_mark_busy();
>>>>> +	memset(sccb, 0, sizeof(*sccb));
>>>>> +	sccb->h.length = sizeof(WriteEventData) + len;
>>>>> +	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
>>>>> +	sccb->ebh.length = sizeof(EventBufferHeader) + len;
>>>>> +	sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
>>>>> +	memcpy(sccb->data, str, len);
>>>>
>>>> Soooo ... what would happen when printing more than 4000 + something
>>>> characters? (same applies to lm below)
>>>
>>> I wouldn't advise on that, because you'll overwrite memory and sclp
>>> might have a length limit. But that wasn't a problem before, was it?
>>>
>>> Do you plan on printing the memory in one go? :-)
>>
>> Won't say it won't happen when somebody debugs/develops tests and gets
>> strange side effects from printing. Wonder if we should simply cut it
>> off to the supported size.
>>
>> (And yes, this is already in existing code)
> 
> As the print functions have different max lengths for user data I'd
> print a warning and return after 2KB in sclp_print. Anything against that?
> 
> It's simple and 2KB ought to be enough for everyone (TM) and nobody
> keeps you from calling print multiple times instead.
> 
> 
> if (strlen(str) > (1 << 11)) {
> 		sclp_print_ascii("Warning: Printing is limited to 2KB of data.");
> 		sclp_print_lm("Warning: Printing is limited to 2KB of data.");
> 		return;
> 	}

Yes, something like that might be the best thing to do!

-- 

Thanks,

David / dhildenb
