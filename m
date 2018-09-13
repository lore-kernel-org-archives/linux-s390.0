From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/8] add support for relative references in jump tables
Date: Thu, 13 Sep 2018 14:40:12 -0700
Message-ID: <CAGXu5jJ9hD8-2ioAKdXKc8uV+OjRSJVUftd9rY9RfW7Tkor=kw@mail.gmail.com>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
 <20180704075923.GF3701@osiris> <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 4, 2018 at 1:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 July 2018 at 09:59, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>> On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
>>> This series implements support for emitting the data structures associated
>>> with jump tables as 32-bit relative references instead of absolute
>>> references, which take up more space on builds that target 64-bit
>>> architectures, or implement self relocation [or both].
>>>
>>> This series enables it for arm64 and x86, although other architectures
>>> might benefit as well.
>>
>> Hello Ard,
>>
>> feel free to add the patch below which adds support for s390 to your series.
>>
>
> Thanks, I will incorporate it into v3 and beyond.

Just a quick status check! :) What're your plans for this series? I'd
still love to see it.

-Kees

-- 
Kees Cook
Pixel Security
