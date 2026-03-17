Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25F3BBA1A;
	Tue, 17 Mar 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761058; cv=none; b=cpuSf0qhpmaf0tVQ94oy7ct1MYapqjC4eTu0FoIEyyO90BOgWJqY+SbjA87/PYHkV6xuYOv8nUqYXlu5ZQhwkaEH4pQbe0wCBX9R0gw9E6srXvXKLSxszxmbNynH3gqv5H1LA9HKkWuRBN0WHofGWDs2s5II8TL88l1mdJ4sOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761058; c=relaxed/simple;
	bh=rawTxtgvvbkzzbH2UV4s1WHUqEhvtXowvJ2A1NK5Dfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=FomyTtMDGn6SFgxzRPcsnCUl5fUEcEmUgruGkKWyazUuyyEeZKH4mfRfHzQMtEdbfqpLFzkSw9lHzqlNQeiS4wp0Uq8mjvh8rEh3+qVJty8xSNB85kwP+FQxFR9BbdMBMcJgXVimES67JJYnxBv7A2JhSM7PD2rk0sFznB8sa1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AoIs2DBU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AoIs2DBU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8D1ECC5505A;
	Tue, 17 Mar 2026 15:24:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C52B60050;
	Tue, 17 Mar 2026 15:24:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4159410450618;
	Tue, 17 Mar 2026 16:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773761051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rawTxtgvvbkzzbH2UV4s1WHUqEhvtXowvJ2A1NK5Dfo=;
	b=AoIs2DBUSiP3+bDh8ceDZ5pucIsCr73r049SuZ/HJKLAXGmyad7NTpfKNSaNVk51NUvTIH
	BgPqPlr1rDNIoyNmYsJc8ISuC3ycIUVQBissA6PEINJzL6N8BH0o8JqMgWYQdBCgi49zvl
	Rl36ZnNiln6rG+QQTga+S6KU/OOWAfvfLuGWL19TZHwCliPsRxvb67701TK9QVVKGnTpoa
	j3Xvy3JqNEig/PiitIwS73AwutDLx9LIw9v/asnkWmeV/tuNISa5PJ8YUSBzapnrkc2NV+
	NRS8gndZVMreSkSC8PDnKgeiyjCRU66WdvwKgyQf+/ugl+MnQb1DhlIwJ0DqHw==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:23:45 +0100
Message-Id: <DH55T20W6ZID.1O0R8EFW6R5G3@bootlin.com>
Cc: "Alexandre Gonzalo" <alexandre.gonzalo@arm.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-alpha@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-omap@vger.kernel.org>, <loongarch@lists.linux.dev>,
 <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <linux-samsung-soc@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-renesas-soc@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
 <openbmc@lists.ozlabs.org>
To: "Vincent Mailhol (Arm)" <mailhol@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Mikko Rapeli"
 <mikko.rapeli@linaro.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Matt Turner" <mattst88@gmail.com>, "Magnus
 Lindholm" <linmag7@gmail.com>, "Russell King" <linux@armlinux.org.uk>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>, "Andreas Kemnade"
 <andreas@kemnade.info>, "Kevin Hilman" <khilman@baylibre.com>, "Roger
 Quadros" <rogerq@kernel.org>, "Tony Lindgren" <tony@atomide.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle"
 <svens@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz"
 <glaubitz@physik.fu-berlin.de>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Clark Williams" <clrkwllms@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Vladimir
 Zapolskiy" <vz@mleia.com>, "Piotr Wojtaszczyk"
 <piotr.wojtaszczyk@timesys.com>, "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Helge Deller" <deller@gmx.de>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, "Chris
 Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Arnd Bergmann" <arnd@arndb.de>, "Heiko
 Stuebner" <heiko@sntech.de>, "Kuninori Morimoto"
 <kuninori.morimoto.gx@renesas.com>, "Mark Brown" <broonie@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Sricharan Ramabadhran" <quic_srichara@quicinc.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Guenter
 Roeck" <linux@roeck-us.net>, "Srinivas Kandagatla"
 <srinivas.kandagatla@oss.qualcomm.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Anna Schumaker"
 <anna.schumaker@oracle.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/9] configs: remove obsolete assignments to
 CONFIG_NFS_V4_1
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
 <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
In-Reply-To: <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vincent,

On Tue Mar 17, 2026 at 10:13 AM CET, Vincent Mailhol (Arm) wrote:
> CONFIG_NFS_V4_1 was revomed in commit 7537db24806f ("NFS: Merge
> CONFIG_NFS_V4_1 with CONFIG_NFS_V4"). However, some defconfigs are
> still referring the old configuration.

typo: revomed -> removed
otherwise, thanks:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

