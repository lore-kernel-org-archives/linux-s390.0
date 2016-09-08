From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] atomic64: No need for
 CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
Date: Thu, 8 Sep 2016 11:34:29 -0700
Message-ID: <a37b81a2-9634-255e-b20b-51e75913cb40@synopsys.com>
References: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
 <20160908181905.GY10153@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20160908181905.GY10153@twins.programming.kicks-ass.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo
List-ID: <linux-s390.vger.kernel.org>

On 09/08/2016 11:19 AM, Peter Zijlstra wrote:
> On Thu, Sep 08, 2016 at 09:28:18AM -0700, Vineet Gupta wrote:
>> This came to light when implementing native 64-bit atomics for ARCv2.
>>
>> The atomic64 self-test code uses CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>> to check whether atomic64_dec_if_positive() is available.
>> It seems it was needed when not every arch defined it.
>> However as of current code the Kconfig option seems needless
>>
>> - for CONFIG_GENERIC_ATOMIC64 it is auto-enabled in lib/Kconfig and a
>>   generic definition of API is present lib/atomic64.c
>> - arches with native 64-bit atomics select it in arch/*/Kconfig and
>>   define the API in their headers
>>
>> So I see no point in keeping the Kconfig option
>>
>> Compile tested for 2 representatives:
>>  - blackfin (CONFIG_GENERIC_ATOMIC64)
>>  - x86 (!CONFIG_GENERIC_ATOMIC64)
>>
>> Also logistics wise it seemed simpler to just do this in 1 patch vs.
>> splitting per arch - but I can break it up if maintainer feel that
>> is better to avoid conflicts.
> Works for me; you want me to take this, or do you need it for you ARCv2
> patches?

Please do. ARCv2 patch (following shortly) doesn't need it - I selected the
option in orig patch - which I can just take out.

Thx,
-Vineet
