From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 2/5] powerpc: Fix vDSO clock_getres()
Date: Tue, 2 Apr 2019 10:00:25 +0100
Message-ID: <f4919c8a-e0dd-ab78-d6a3-b792fa388aa9@arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-3-vincenzo.frascino@arm.com>
 <f54a24fe-f893-10c9-9177-4985bad2e745@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f54a24fe-f893-10c9-9177-4985bad2e745@c-s.fr>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Christophe,

thank you for your review.

On 02/04/2019 06:54, Christophe Leroy wrote:
> 
> 
> On 04/01/2019 11:51 AM, Vincenzo Frascino wrote:
>> clock_getres in the vDSO library has to preserve the same behaviour
>> of posix_get_hrtimer_res().
>>
>> In particular, posix_get_hrtimer_res() does:
>>      sec = 0;
>>      ns = hrtimer_resolution;
>> and hrtimer_resolution depends on the enablement of the high
>> resolution timers that can happen either at compile or at run time.
>>
>> Fix the powerpc vdso implementation of clock_getres keeping a copy of
>> hrtimer_resolution in vdso data and using that directly.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   arch/powerpc/include/asm/vdso_datapage.h  |  2 ++
> 
> Conflicts with commit b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC 
> inconsistencies across Y2038")
> 

Thanks for pointing this out, I will rebase my code on top of the latest version
before reissuing v2.

...

-- 
Regards,
Vincenzo
