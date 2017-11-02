From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 02 Nov 2017 20:55:53 +0000
Subject: Re: [PATCH] s390: pass endianness info to sparse
Message-Id: <b6960945-db88-84e9-d2da-b4ab96e3baf7@oracle.com>
In-Reply-To: <CAMHZB6ErvKcGzEmz-Zp9W2oNbZjRZsGf_MaKm32jSpRndiCiyg@mail.gmail.com>
References: <CAMHZB6ErvKcGzEmz-Zp9W2oNbZjRZsGf_MaKm32jSpRndiCiyg@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On 11/2/2017 3:37 PM, Luc Van Oostenryck wrote:
> On Thu, Nov 2, 2017 at 9:17 PM, Babu Moger <babu.moger@oracle.com> wrote:
>> On 11/2/2017 3:11 AM, Arnd Bergmann wrote:
>>> On Thu, Nov 2, 2017 at 7:25 AM, Luc Van Oostenryck
>>> <luc.vanoostenryck@gmail.com> wrote:
>>>> On Thu, Nov 2, 2017 at 7:04 AM, Heiko Carstens
>>>> <heiko.carstens@de.ibm.com> wrote:
>>>>> On Tue, Oct 31, 2017 at 06:22:08PM +0100, Luc Van Oostenryck wrote:
>>>>>
>>>>>> -CHECKFLAGS   += -D__s390__ -D__s390x__
>>>>>> +CHECKFLAGS   += -D__s390__ -D__s390x__ -mbig-endian
>>>>> Applied, thanks!
>>>>>
>>>>> However something similar is required for _all_ architectures, e.g.
>>>>> setting
>>>>> -mlittle-endian for the same reason on big endian build machines.
>>>>>
>>>>> Therefore I would have expected to add the -m flag in the top-level
>>>>> Makefile depending on CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_KITTLE_ENDIAN.
>>>>> However it seems that not all architectures set any of these config
>>>>> options
>>>>> at all.
>>>>>
>>>>> If I remember correctly Arnd Bergmann was looking into this a couple of
>>>>> months ago(?)...
>>>> I'm not aware of Arnd's work for this but I checked all architectures and
>>>> sent
>>>> patches for those which needed it (for endianness and machine size).
>>> I think the patch series in question was from Babu Moger (added to Cc
>>> here),
>>> see https://lkml.org/lkml/2017/7/6/583
>>>
>>> The patches got merged into v4.14-rc1, but had a different goal, so
>>> I don't think Babu was trying to solve the problem for sparse. Adding it
>>
>> Yes. Correct. I was not trying to solve this sparse problem.
>>
>>> to the top-level CHECKFLAGS sounds appropriate, we just can't do
>>> it for the general CFLAGS.
>> Interesting..
>> Do you think we should add these definitions(-mbig-endian) all the fixed big
>> endian architectures?  Here is the list:
>> arch/frv/include/uapi/asm/byteorder.h
>> arch/h8300/include/asm/byteorder.h
>> arch/h8300/include/uapi/asm/byteorder.h
>> arch/m68k/include/uapi/asm/byteorder.h
>> arch/openrisc/include/uapi/asm/byteorder.h
>> arch/parisc/include/uapi/asm/byteorder.h
>> arch/s390/include/uapi/asm/byteorder.h
>> arch/sparc/include/uapi/asm/byteorder.h
> I've sent CHECKFLAGS patches for m68k, openrisc, parisc, s390 & sparc
Ok. Cool.� We are good then. Thanks.
> (I don't remember why I concluded it wasn't needed for frv & h8300,
> probably because I didn't saw any dependencies with something like
> __BYTE_ORDER__ or __{BIG,LITTLE}_ENDIAN__).
> But yes, adding the right -m flag at top-level would be slightly simpler.
> However, it should be noted that this is not always enough
> (for example, ARM need __ARMEL__/__ARMEB__).
>
> -- Luc
