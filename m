From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal
 return
Date: Thu, 5 May 2016 10:24:18 +0800
Message-ID: <572AAED2.7050604@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1554541.oDP7Ro5zB2@wuerfel>
 <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
 <3846428.6xx69KGEja@wuerfel> <57288660.9030607@huawei.com>
 <57289C75.50904@huawei.com> <20160504214949.GA28217@yury-N73SV>
 <CA+=Sn1ngpaJWHpGDmU+kXBkz56SO+XDW2qzMMLAbbBWnaB0eqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CA+=Sn1ngpaJWHpGDmU+kXBkz56SO+XDW2qzMMLAbbBWnaB0eqw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Pinski <pinskia@gmail.com>, Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, "Joseph S. Myers" <joseph@codesourcery.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nathan Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, christoph.muellner@theobroma-systems.com, Hanjun Guo <guohanjun@huawei.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On 2016/5/5 7:23, Andrew Pinski wrote:
> On Wed, May 4, 2016 at 2:49 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>> On Tue, May 03, 2016 at 08:41:25PM +0800, Zhangjian (Bamvor) wrote:
>>> Hi, all
>>>
>>> After apply this patch with my small testcase, the vsyscall of gettimeofday in
>>> ilp32 works in both big endian and small endian. In this patch, I use the
>>> different register and offset for ilp32 and lp64. Actually, the
>>> COMPAT_TVAL_TV_SEC is same as TVAL_TV_SEC(so as to COMPAT_TSPEC_TV_SEC and
>>> TSPEC_TV_SEC). I add it to keep the logic clear. I also change the version
>>> of vdso to 4.6. It should change to 2.6.39 if glibc is not update.
>>>
>>
>> [...]
>>
>> Hi Bamvor,
>>
>> It works for me as well. Thank you.
>> I'll incorporate it in next submission.
>
> We should add the following so we are complaint to the ILP32 ABI
> dealing with pointers don't have to be zero extended for arguments,
> Note ZERO should most likely be ZERO_PTR or something to do that
> effect, I am not so good with names.
> #ifdef __LP64__
> #define ZERO(n)
> #else
> #define ZERO(n)         mov     w##n, w##n
> #endif
>
> ...
> ENTRY(__kernel_gettimeofday)
>          .cfi_startproc
>          ZERO(0)
>          ZERO(1)
> ...
> ENTRY(__kernel_clock_gettime)
>          .cfi_startproc
>          ZERO(1)
> ...
> ENTRY(__kernel_clock_getres)
>          .cfi_startproc
>          ZERO(1)
Thanks. I will test and send a new version.

Thanks.

Bamvor
> Thanks,
> Andrew Pinski
>
>>
>> Yury.
