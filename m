Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 7 Apr 2016 14:18:38 +0200
From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Message-ID: <20160407121838.GA22098@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160407121838.DrMw3MZSS4AtJoW2ircvDohxMUSkVkactqKD-7go4pI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Pinski <pinskia@gmail.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Nathan Lynch <Nathan_Lynch@mentor.com>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 6 Apr 2016, Geert Uytterhoeven wrote:
> On Wed, Apr 6, 2016 at 12:08 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>>  v6:
>>  - time_t, __kenel_off_t and other types turned to be 32-bit
>>    for compatibility reasons (after v5 discussion);

Introducing a new arch today with y2038 problems is not a good idea.
Linus said so with appropriately pointy words in 2011.

> What makes you think these "applications that can’t readily be migrated to LP64
> because they were written assuming an ILP32 data model, and that will never
> become suitable for a LP64 data model and will remain locked into ILP32
> operating environments" are more likely to be fixed for y2038 later, than for
> LP64 now?

Such broken applications already have plenty of bogus architecture detection
code so you need porting anyway...

> We're already closer to the (future) y2038 than to the (past) introduction of
> LP64...
>
> These unfixable legacy applications have been spreading through x32 to
> the shiny new arm64 server architecture (does ppc64el also have an ILP32 mode,
> or is it planned)? Lots of resources are spent on maintaining the status quo,
> instead of on fixing the real problems.
          
As an x32 (userland) porter, I can tell you that time_t!=long _did_ cause
non-trivial amounts of work.  But that work is already done (at least in
Debian), so you might as well benefit from it.


-- 
A tit a day keeps the vet away.
