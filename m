From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 25/25] arm64:ilp32: add ARM64_ILP32 to Kconfig
Date: Fri, 29 Apr 2016 17:03:34 +0100
Message-ID: <20160429160334.GD30316@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-26-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459894127-17698-26-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 06, 2016 at 01:08:47AM +0300, Yury Norov wrote:
> +config ARM64_ILP32
> +	bool "Kernel support for ILP32"
> +	select COMPAT_WRAPPER
> +	help
> +	  This option enables support for AArch64 ILP32 user space.  ILP32
> +	  is an ABI where long and pointers are 32bits but it uses the AARCH64
> +	  instruction set.

Is there any penalty for AArch32 tasks when selecting COMPAT_WRAPPER?

-- 
Catalin
