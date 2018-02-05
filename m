Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 5 Feb 2018 07:56:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 08/20] s390/kconfig: Remove
 ARCH_WANTS_PROT_NUMA_PROT_NONE select
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-9-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205012146.23981-9-ulfalizer@gmail.com>
Message-Id: <20180205065651.GA4415@osiris>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com, egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com, yamada.masahiro@socionext.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 05, 2018 at 02:21:20AM +0100, Ulf Magnusson wrote:
> The ARCH_WANTS_PROT_NUMA_PROT_NONE symbol was removed by
> commit 6a33979d5bd7 ("mm: remove misleading ARCH_USES_NUMA_PROT_NONE"),
> but S390 still selects it.
> 
> Remove the ARCH_WANTS_PROT_NUMA_PROT_NONE select from the S390 symbol.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks!
