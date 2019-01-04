From: Jens Remus <jremus@linux.ibm.com>
Date: Fri, 04 Jan 2019 14:55:01 +0000
Subject: Re: [kvm-unit-tests PATCH v4 04/13] s390x: Switch to z/Arch
Message-Id: <6b342b0a-e75a-ef02-07cd-2e12755068ec@linux.ibm.com>
In-Reply-To: <ea43579c-5b9f-2d31-acc3-f145c907fa00@linux.ibm.com>
References: <ea43579c-5b9f-2d31-acc3-f145c907fa00@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Janosch!

On 04.01.2019 11:15, Janosch Frank wrote:
> On 04.01.19 09:56, Jens Remus wrote:
>> Hi Janosch,
>>
>> happy new year!
> 
> Thanks, same to you.
> 
>>
>> On 03.01.2019 11:07, Janosch Frank wrote:
>>> LPAR and z/VM start in esam mode depending on the hardware, so we need
>>
>> Did you consider the CZAM facility? You already use a so called "short
>> PSW" (which is compatible to the ESA/390 PSW, as you did not set bit 31).
>>
>> LPAR and z/VM start in esam or esame mode, depending on the hardware
>> CZAM facility and z/VM MACHINE setting.
>>
>> See POP section "Load State":
>>
>> "When neither the configuration-z/Architecture-architectural-mode (CZAM)
>> facility nor the ESA/390-compatibility-mode facility are installed, this
>> sets the architectural mode to the ESA/390 mode. When the
>> ESA/390-compatibility-mode facility is installed, this sets the
>> architecture mode to the ESA/390-compatibility mode. When the CZAM
>> facility is installed, the architectural mode is unchanged (that is, it
>> remains in the z/Architecture architectural mode)."
>>
>>> to switch to z/Arch and set 64 bit addressing.
> 
> I don't really want to test in which state I am and blindly setting
> z/Arch and 64 bit is a valid course of action according to the AR.

I completely agree with you. I was rather thinking of enhancing the 
commit message to make clear that LPAR and z/VM start either in esam or 
esame mode, depending on the hardware CZAM facility and z/VM MACHINE 
setting. Re-reading your commit message I must admit that it kind of 
already contains this with "depending on the hardware" and one may then 
deduct from the commit subject that it must be z/Arch (esame) otherwise.

>> Wouldn't it be nice to mention this in the commit subject:
>>
>> s390x: Switch to z/Arch and 64-bit addressing [mode]
> 
> As commented yesterday (Message-ID:
> <9644d7ab-d815-720d-f1a1-eee1a6a0c253@linux.ibm.com>):
> The title will be changed to:
> s390x: Switch to z/Arch and enable 64 bit addressing mode
> 
> Also I will move the sam64 from the previous patch into this one.
> 
> 
> I might add to the comment that we do this no matter what configuration
> we start out in, because it doesn't produce an exception.

That would be nice. Thanks!

Regards,
Jens
-- 
Linux on Z and z/VSE Development & Service (D3229)
IBM Systems & Technology Group, Pure Systems & Modular Software Development

IBM Data Privacy Statement: https://www.ibm.com/privacy/us/en/

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
