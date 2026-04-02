Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B213783A0;
	Thu,  2 Apr 2026 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166661; cv=none; b=kfjU5YT3HAsDFexZIRbtxda8FbmF4jHJ2ob87p2pm/4x3/ZwANean7PZszlgumSGGJrDjPSaXgX2GGZtKwznIiVm8Oz4ZlrbZ19FGVeCuvFe1WJ+uhNaw8mQemb3xKwQyAaJSV9fTeVP4cLHOmU236VajARX/58UGEhACSLmFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166661; c=relaxed/simple;
	bh=+iWo8G+lGLAR0AEWKadkwlt32LjzfIOHKPITuBCakWs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OobjlbgR1l4o7IurPzNLwLvNRkSElKo16sx1D0IiIChSvFcY13dbe2tNDdsqfiCbxp8aXjljdE9jzK1B1o8OgPgkaM5RHjW9RVTyGJIFBcU+YE5D0HgI9/3jg/5wI2SE3GCGaxhv1B70rQ9zSDGJNUBjJQpTTkn+g7uydlO4xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh7N/3FR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh7N/3FR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CFAC116C6;
	Thu,  2 Apr 2026 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775166660;
	bh=+iWo8G+lGLAR0AEWKadkwlt32LjzfIOHKPITuBCakWs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uh7N/3FRUjqua+aPCo/hGr/AdrmusEl1H/a3Cy2K3ax/7zWAaowq7QLQao9luVbWo
	 hhp+ELOy56vNZgWo/30UXJ+R+KNwAUX+g9t5upzBm19UO38qCmclRomH9W9JilFn3g
	 1M3od6tckFksVcXsO4otmEq7oBs2ncVax1WS/48Gk7Y/jRGn5aI6Ty0S32Qrtb3v+N
	 FCfqxPCfuHXXK+tb8kOeAkmUobWREiK7V0IqzM0OnWy9oCVbOYxajs4XGYlWHY2x7t
	 AkBA5ON0TiTxqW6AtiPnUW+DWm5PHRBPUIiBBcwzXpeViYkdJ68cXcODxvoTFEl/DM
	 YZIYLd1IONOQA==
Date: Thu, 2 Apr 2026 15:50:54 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
    Mikko Rapeli <mikko.rapeli@linaro.org>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
    Andreas Kemnade <andreas@kemnade.info>, 
    Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
    Tony Lindgren <tony@atomide.com>, Huacai Chen <chenhuacai@kernel.org>, 
    WANG Xuerui <kernel@xen0n.name>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Clark Williams <clrkwllms@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Pablo Neira Ayuso <pablo@netfilter.org>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, Frank Li <Frank.Li@nxp.com>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
    Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
    Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Magnus Damm <magnus.damm@gmail.com>, 
    Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
    Gregory CLEMENT <gregory.clement@bootlin.com>, 
    =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Helge Deller <deller@gmx.de>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
    =?ISO-8859-15?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, 
    Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
    Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
    Heiko Stuebner <heiko@sntech.de>, 
    Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
    Mark Brown <broonie@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
    Ard Biesheuvel <ardb@kernel.org>, 
    Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
    Bjorn Andersson <andersson@kernel.org>, Michael Walle <mwalle@kernel.org>, 
    Guenter Roeck <linux@roeck-us.net>, 
    Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
    "Rob Herring (Arm)" <robh@kernel.org>, 
    Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Anna Schumaker <anna.schumaker@oracle.com>, 
    Alexandre Gonzalo <alexandre.gonzalo@arm.com>, 
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-omap@vger.kernel.org, loongarch@lists.linux.dev, 
    linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
    linux-sh@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
    linux-renesas-soc@vger.kernel.org, linux-parisc@vger.kernel.org, 
    openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/9] configs: remove orphan dependencies of
 NETFILTER_XTABLES_LEGACY
In-Reply-To: <20260317-arm_defconf_cleanup-v1-2-8eecb7fdd24d@kernel.org>
Message-ID: <576cec38-a5e4-5391-2a57-b164e84a813f@kernel.org>
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org> <20260317-arm_defconf_cleanup-v1-2-8eecb7fdd24d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Mar 2026, Vincent Mailhol (Arm) wrote:

> Since its introduction in commit 9fce66583f06 ("netfilter: Exclude
> LEGACY TABLES on PREEMPT_RT."), the configurations below all depend,
> either directly or indirectly, on CONFIG_NETFILTER_XTABLES_LEGACY:
> 
>   - CONFIG_NETFILTER_XT_TARGET_CHECKSUM
>   - CONFIG_IP_NF_FILTER
>   - CONFIG_IP_NF_TARGET_REJECT
>   - CONFIG_IP_NF_NAT
>   - CONFIG_IP_NF_TARGET_MASQUERADE
>   - CONFIG_IP_NF_MANGLE
>   - CONFIG_IP6_NF_FILTER
>   - CONFIG_IP6_NF_TARGET_REJECT
>   - CONFIG_IP6_NF_MANGLE
>   - CONFIG_IP6_NF_NAT
>   - CONFIG_IP6_NF_TARGET_MASQUERADE
> 
> This new dependency caused many symbols to become orphaned, meaning
> their dependencies are no longer satisfied and Kconfig drops them from
> the final configuration.
> 
> Note that CONFIG_NFT_COMPAT is another parent dependency, so the
> above-listed symbols would not become orphaned as long as NFT_COMPAT
> is present.
> 
> Considering that these are legacy options and that nobody complained
> in recent kernel releases when these options were already missing, it
> is safe to assume they can be removed.
> 
> Suppress all these configuration symbols in all the defconfig files
> that have neither CONFIG_NETFILTER_XTABLES_LEGACY nor
> CONFIG_NFT_COMPAT set.
> 
> FYI, the suppressions were done using:
> 
>   git grep -z -L -E '^CONFIG_(NETFILTER_XTABLES_LEGACY|NFT_COMPAT)=(y|m)$' -- 'arch/*/configs/*defconfig' |\
>     xargs -0 sed -i -E '/^CONFIG_(NETFILTER_XT_TARGET_CHECKSUM|IP_NF_FILTER|IP_NF_TARGET_REJECT|IP_NF_NAT|IP_NF_TARGET_MASQUERADE|IP_NF_MANGLE|IP6_NF_FILTER|IP6_NF_TARGET_REJECT|IP6_NF_MANGLE|IP6_NF_NAT|IP6_NF_TARGET_MASQUERADE)=(y|m)$/d'
> 
> Fixes: 9fce66583f06 ("netfilter: Exclude LEGACY TABLES on PREEMPT_RT.")
> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul
