From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal
 return
Date: Thu, 5 May 2016 11:22:37 +0300
Message-ID: <20160505082237.GA32190@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1554541.oDP7Ro5zB2@wuerfel>
 <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
 <3846428.6xx69KGEja@wuerfel>
 <57288660.9030607@huawei.com>
 <57289C75.50904@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57289C75.50904@huawei.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, joseph@codesourcery.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com, Hanjun Guo <guohanjun@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 03, 2016 at 08:41:25PM +0800, Zhangjian (Bamvor) wrote:
[...]

> After apply this patch with my small testcase, the vsyscall of gettimeofday in
> ilp32 works in both big endian and small endian. In this patch, I use the
> different register and offset for ilp32 and lp64. Actually, the
> COMPAT_TVAL_TV_SEC is same as TVAL_TV_SEC(so as to COMPAT_TSPEC_TV_SEC and
> TSPEC_TV_SEC). I add it to keep the logic clear. I also change the version
> of vdso to 4.6. It should change to 2.6.39 if glibc is not update.
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 574081f..c8e32eb 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -101,6 +101,11 @@ int main(void)
>    DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
>    DEFINE(TSPEC_TV_NSEC,		offsetof(struct timespec, tv_nsec));
>    BLANK();
> +  DEFINE(COMPAT_TVAL_TV_SEC,	offsetof(struct compat_timeval, tv_sec));
> +  DEFINE(COMPAT_TVAL_TV_USEC,	offsetof(struct compat_timeval, tv_usec));
> +  DEFINE(COMPAT_TSPEC_TV_SEC,	offsetof(struct compat_timespec, tv_sec));
> +  DEFINE(COMPAT_TSPEC_TV_NSEC,	offsetof(struct compat_timespec, tv_nsec));
> +  BLANK();

Hi Bamvor,

We just found this lines break build if ILP32 is disabled. I think we
need to wrap them with #ifdef CONFIG_ARM64_ILP32

Yury
