From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
Date: Fri, 6 Apr 2018 15:20:40 +0200
Message-ID: <CAK8P3a3qpbPZuEhW=pYnadDtg5UGRpiD_k2=XiJanqmmTL5VzA@mail.gmail.com>
References: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
 <CAK8P3a0Ahf9uuXYy0fxdC5_O84gmSqTUsP6xjpGQFE8n1Tw7HA@mail.gmail.com> <fa0b02f16cb4cb993775518fabccfb2d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa0b02f16cb4cb993775518fabccfb2d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ley Foon Tan <lftan@altera.com>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 6, 2018 at 2:50 PM,  <okaya@codeaurora.org> wrote:
> On 2018-04-06 06:19, Arnd Bergmann wrote:
>>
>> On Thu, Apr 5, 2018 at 3:09 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>
>>
>> I would guess that at least s390 doesn't need the barriers
>> (maintainers on Cc now), but there may be others that want to
>> override the new barriers with weaker ones where an MMIO
>> access is guaranteed to serialize against DMA, or where
>> a specialized barrier for this case exists.
>>
>> Looking over the asm-generic implementation once more now,
>> I wonder if we should change the relaxed accessors to not have
>> any barriers (back to the version before your series) rather than
>> defaulting them to having the same barriers as the regular
>> readl/writel.
>
>
> I can do a follow up patch. You want to map them to raw api without any
> barriers as before. Right?

Right, but of course with the byteswap.

      Arnd
