From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
Date: Tue, 13 Feb 2018 09:51:09 -0800
Message-ID: <1f96a3c7-0bb3-6c06-0b44-ca47e5a5d127@infradead.org>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
 <87zi4ev1d2.fsf@concordia.ellerman.id.au>
 <f119a273-2e86-1b7f-346f-7627ad8b51ed@infradead.org>
 <87fu652oce.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <87fu652oce.fsf@concordia.ellerman.id.au>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, John Johansen <john.johansen@canonical.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Dmitry Kasatkin <dmitry.kasatkin@intel.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/13/2018 02:09 AM, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 02/12/2018 04:28 AM, Michael Ellerman wrote:
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
>>>> reason. It looks like it's only a convenience, so remove kmemleak.h
>>>> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
>>>> that don't already #include it.
>>>> Also remove <linux/kmemleak.h> from source files that do not use it.
>>>>
>>>> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
>>>> would be good to run it through the 0day bot for other $ARCHes.
>>>> I have neither the horsepower nor the storage space for the other
>>>> $ARCHes.
>>>>
>>>> [slab.h is the second most used header file after module.h; kernel.h
>>>> is right there with slab.h. There could be some minor error in the
>>>> counting due to some #includes having comments after them and I
>>>> didn't combine all of those.]
>>>>
>>>> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
>>>> header files).
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> I threw it at a random selection of configs and so far the only failures
>>> I'm seeing are:
>>>
>>>   lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]                                                                                                          
>>>   lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>>   lib/test_firmware.c:620:2: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>>   security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
>>
>> Both of those source files need to #include <linux/vmalloc.h>.
> 
> Yep, I added those and rebuilt. I don't see any more failures that look
> related to your patch.

Great, thanks.

I also sent patches for both of those.

>   http://kisskb.ellerman.id.au/kisskb/head/13399/
> 
> 
> I haven't gone through the defconfigs I have enabled for a while, so
> it's possible I have some missing but it's still a reasonable cross
> section.


-- 
~Randy

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
