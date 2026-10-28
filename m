Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169345;
	b=x4UHd2/qr2mnlqCvysE/ohuGxK9CEPKC4pAlrnaE9ufv88LDUnVsF+69dz8zFhjZ+9fP
	 /dEvUW/yB6wyM/nEgsns7IL9MFj9BJLjm4sSchRJlA1z1A7BhcaVJpXUxvtjqqPPDuMX5
	 eGYnWCBc5APr3+DvtwyLNhCap5GK/9P4SESga7dP0tVGgmT9TwjE5k9BleXo6zbv5nuFH
	 WRsdB1XDjRqmXjMKiWto7qVpeFmRmFaCxwE5WqsaAQ4pYfh1qcCFDctFvRqUotdixb1FH
	 VZmd8PU/WLSOJ3aD+n3mFkHM8W1tvYOyZsVGFmgtCvVu3ML/c9wnsQzZV8fa6LTQ/Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169345;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9eE1/a8yssEvbe7X1f4l/fXYrb2YdYtQP60xm7pnU4s=;
	b=F5OlgVuPQ6u7I01hWKfWJ8AxTkPle4n0QMr98SrYUPFvgOo3xTlLzbYgbZjP5xllkUTO
	 //P+RqN2MGE40wiBrIcSRGEUFR3kYP365jpsUpZKk4zxFJSGK55m9LuTNnhQA9KPqpYB5
	 m67AysZo0Y3PHdu7f5T3c9uc4mqL8WgH2Z48HqsA3nmpiyg7EcCbDy3P8trJ+QbAtM0vA
	 WWApTR8ZGgR7BRmhqASh/9oI7tv52GAOoEsuisiCPKA1gJQFIK7IpOeu5mQjHn7FGzk/k
	 xdEQ5UuB6pcYP6NRHh94mC5hKjpJ8oj2wOhWVDbtNbNaBGriWajMOGQHi+0w49j3/Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.212
Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916E606A323
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 06:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C916E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OYZNtd/UehHMy4rTfJmNcdZ8v55wgobvj59OuDZbVqk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793169341; v=1; x=1793774141;
 b=xujfQyHJ4+4GqVoY7lmH/XKB7oROyHuT3A5OyEw/6zXhnfLUKtZPN75kQKEpmLCAH8677Gr1
 N8GVt1mFNVZvsVSEumneJOA3dPNSAgAxKDyHlRzVY51cYKwtWnEKIAUpg0M2Av5bz3H6W9tqMGy
 9JwxiqwVERYMsjjc5PAxmylo=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 15953ea224fc9372;
	Wed, 28 Oct 2026 06:35:23 +0000
X-Mizu-Trace-ID: 15953ea224fc9372
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Russell King <linux@armlinux.org.uk>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryota Sakamoto <sakamo.ryota@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Paolo Pisati <p.pisati@gmail.com>,
	Kir Chou <note351@hotmail.com>,
	Jan Kara <jack@suse.cz>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Catalin Iacob <iacobcatalin@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	David Christensen <drc@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Julian Braha <julianbraha@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Taegu Ha <hataegu0826@gmail.com>,
	Norbert Szetei <norbert@doyensec.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
	Julius Bairaktaris <julius@bairaktaris.de>,
	Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Linux Verification Center <lvc-project@linuxtesting.org>
Subject: [RFC net-next] ppp: remove BSD-Compress support
Date: Wed, 28 Oct 2026 14:33:44 +0800
Message-ID: <20261028063452.25812-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BSD-Compress decoder assumes that accm is 32 bits, but declares it
as unsigned long. On 64-bit systems, consumed code bits survive the
left shift and corrupt the next code. An x86-64 PPP-over-PTY loopback
test reproduces a fatal bad-code error on the first compressed packet.

pppd normally requests Deflate in preference to BSD-Compress when both
methods can be negotiated. If BSD-Compress is selected and encounters
this fatal error, pppd disables compression and logs:

  Lost compression sync: disabling compression

The link remains up and traffic can continue uncompressed.

The core compression routine has remained unchanged since Linux 2.1.67
(1997), and the decompression routine since its introduction in Linux
1.3.33 (1995). Later changes have updated module integration and
lifetime handling, kernel APIs, allocation hardening, metadata and code
organization, without correcting the decoder's accumulator width.

A related problem was reported in 2024, when review suggested using
unsigned int. The decoder still uses unsigned long. The PPP protocol
drivers and compressors are orphaned.

Retire the optional and unmaintained BSD-Compress codec and remove its
Kconfig and Kbuild entries and defconfig/selftest selections. Remove the
unused internal DO_BSD_COMPRESS definition. Preserve the UAPI protocol
definitions and generic compressor interface. Deflate and MPPE support
are unchanged.

With the optional BSD codec absent, PPPIOCSCOMPRESS returns -EINVAL.
pppd already probes kernel support and disables BSD-Compress negotiation
when the probe fails.

OpenAI Codex assisted with the commit message, cleanup, and PTY testing.

Link: https://lore.kernel.org/netdev/20240812084312.14127-1-r.smirnov@omp.ru/
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Julius Bairaktaris <julius@bairaktaris.de>
Cc: Roman Smirnov <r.smirnov@omp.ru>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Linux Verification Center <lvc-project@linuxtesting.org>
---
 arch/arm/configs/footbridge_defconfig        |    1 -
 arch/arm/configs/h3600_defconfig             |    1 -
 arch/arm/configs/nhk8815_defconfig           |    1 -
 arch/arm/configs/omap1_defconfig             |    1 -
 arch/arm/configs/omap2plus_defconfig         |    1 -
 arch/arm/configs/pxa_defconfig               |    1 -
 arch/arm/configs/spitz_defconfig             |    1 -
 arch/loongarch/configs/loongson32_defconfig  |    1 -
 arch/loongarch/configs/loongson64_defconfig  |    1 -
 arch/m68k/configs/amiga_defconfig            |    1 -
 arch/m68k/configs/apollo_defconfig           |    1 -
 arch/m68k/configs/atari_defconfig            |    1 -
 arch/m68k/configs/bvme6000_defconfig         |    1 -
 arch/m68k/configs/hp300_defconfig            |    1 -
 arch/m68k/configs/mac_defconfig              |    1 -
 arch/m68k/configs/multi_defconfig            |    1 -
 arch/m68k/configs/mvme147_defconfig          |    1 -
 arch/m68k/configs/mvme16x_defconfig          |    1 -
 arch/m68k/configs/q40_defconfig              |    1 -
 arch/m68k/configs/sun3_defconfig             |    1 -
 arch/m68k/configs/sun3x_defconfig            |    1 -
 arch/mips/configs/bigsur_defconfig           |    1 -
 arch/mips/configs/fuloong2e_defconfig        |    1 -
 arch/mips/configs/gpr_defconfig              |    1 -
 arch/mips/configs/loongson2k_defconfig       |    1 -
 arch/mips/configs/loongson3_defconfig        |    1 -
 arch/mips/configs/mtx1_defconfig             |    1 -
 arch/mips/configs/rb532_defconfig            |    1 -
 arch/parisc/configs/generic-32bit_defconfig  |    1 -
 arch/powerpc/configs/85xx/ge_imp3a_defconfig |    1 -
 arch/powerpc/configs/amigaone_defconfig      |    1 -
 arch/powerpc/configs/chrp32_defconfig        |    1 -
 arch/powerpc/configs/g5_defconfig            |    1 -
 arch/powerpc/configs/pmac32_defconfig        |    1 -
 arch/powerpc/configs/ppc64_defconfig         |    1 -
 arch/powerpc/configs/ppc64e_defconfig        |    1 -
 arch/s390/configs/debug_defconfig            |    1 -
 arch/s390/configs/defconfig                  |    1 -
 arch/sh/configs/titan_defconfig              |    1 -
 arch/sparc/configs/sparc64_defconfig         |    1 -
 drivers/net/Makefile                         |    1 -
 drivers/net/ppp/Kconfig                      |   18 -
 drivers/net/ppp/Makefile                     |    1 -
 drivers/net/ppp/bsd_comp.c                   | 1170 ------------------
 drivers/net/ppp/ppp_generic.c                |    2 +-
 include/linux/ppp-comp.h                     |    3 -
 tools/testing/selftests/net/ppp/config       |    1 -
 47 files changed, 1 insertion(+), 1235 deletions(-)
 delete mode 100644 drivers/net/ppp/bsd_comp.c

diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 7fa556fb6cf4..79f7304cb718 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -62,7 +62,6 @@ CONFIG_VORTEX=y
 CONFIG_NET_PCI=y
 CONFIG_NE2K_PCI=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 3e8da62d959d..b27977c0f923 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -38,7 +38,6 @@ CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
 CONFIG_PCMCIA_PCNET=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_ASYNC=m
 # CONFIG_WLAN is not set
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 7a307bd93730..66e4e5a7288f 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -65,7 +65,6 @@ CONFIG_NETCONSOLE=m
 CONFIG_TUN=y
 CONFIG_SMC91X=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_MPPE=m
 CONFIG_PPPOE=m
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index fcbaaf37bc9b..c2cbdf931311 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -90,7 +90,6 @@ CONFIG_TUN=y
 CONFIG_PHYLIB=y
 CONFIG_SMC91X=y
 CONFIG_PPP=y
-CONFIG_PPP_BSDCOMP=y
 CONFIG_PPP_DEFLATE=y
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MULTILINK=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5791953b75ff..1f344ad0aac8 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -338,7 +338,6 @@ CONFIG_DP83867_PHY=y
 CONFIG_CAN_C_CAN=m
 CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index e7a7ed2b7ef7..972a0610ef7a 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -186,7 +186,6 @@ CONFIG_MARVELL_PHY=m
 CONFIG_AT803X_PHY=m
 CONFIG_MDIO_BITBANG=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index c7cf089001bf..5c8d875e5d38 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -85,7 +85,6 @@ CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
 CONFIG_PCMCIA_PCNET=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
index dbef879935f3..6e1c92811d37 100644
--- a/arch/loongarch/configs/loongson32_defconfig
+++ b/arch/loongarch/configs/loongson32_defconfig
@@ -627,7 +627,6 @@ CONFIG_TXGBE=y
 # CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_MOTORCOMM_PHY=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
index 4f8bb77b8a1e..eadf21dc5c47 100644
--- a/arch/loongarch/configs/loongson64_defconfig
+++ b/arch/loongarch/configs/loongson64_defconfig
@@ -643,7 +643,6 @@ CONFIG_TXGBE=y
 # CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_MOTORCOMM_PHY=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index fefcaa5ad44c..e65fa343ed09 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -339,7 +339,6 @@ CONFIG_HYDRA=y
 CONFIG_APNE=y
 CONFIG_ZORRO8390=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 84d4a6ed1707..9980a7904811 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -312,7 +312,6 @@ CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 22d8a8581601..41b9104d644a 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -332,7 +332,6 @@ CONFIG_NE2000=y
 CONFIG_ETHOC=y
 CONFIG_SMC91X=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 0f79c6382d35..acfd8624e4ca 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -311,7 +311,6 @@ CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_BVME6000_NET=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 2bf412a1713c..cbe21fd75c1d 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -312,7 +312,6 @@ CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_HPLANCE=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 5496f1b60531..d9868e39ab7f 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -327,7 +327,6 @@ CONFIG_MAC89x0=y
 CONFIG_MACSONIC=y
 CONFIG_MAC8390=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index a8f593b4fc6a..805afac5a666 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -388,7 +388,6 @@ CONFIG_ETHOC=y
 CONFIG_SMC91X=y
 CONFIG_PLIP=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index bbce43b8f7aa..fd4eceb5eb17 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -310,7 +310,6 @@ CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_MVME147_NET=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index a63d09dc8dbd..967a91a28223 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -311,7 +311,6 @@ CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_MVME16x_NET=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index d6b7cbab1700..fea2a67e2cca 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -318,7 +318,6 @@ CONFIG_VETH=m
 CONFIG_NE2000=y
 CONFIG_PLIP=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index bee5cdd20637..633fc011ccb5 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -308,7 +308,6 @@ CONFIG_VETH=m
 CONFIG_SUN3LANCE=y
 CONFIG_SUN3_82586=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index ef2b76a06439..38543ccf26c6 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -308,7 +308,6 @@ CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_SUN3LANCE=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index d2b18d5033be..e53902055ddc 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -106,7 +106,6 @@ CONFIG_SB1250_MAC=y
 CONFIG_CHELSIO_T3=m
 CONFIG_NETXEN_NIC=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 8c80c690624c..35ef851ef803 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -112,7 +112,6 @@ CONFIG_LXT_PHY=m
 CONFIG_MARVELL_PHY=m
 CONFIG_QSEMI_PHY=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 718a04dbe88d..2bbc03a87d39 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -159,7 +159,6 @@ CONFIG_QSEMI_PHY=m
 CONFIG_SMSC_PHY=m
 CONFIG_VITESSE_PHY=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 8fd863f4f7b0..323fe69bf818 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -189,7 +189,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 12cb1a6a1360..a9b2dd7b2974 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -224,7 +224,6 @@ CONFIG_R8169=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 095176c3dbee..b1927fb50e2c 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -273,7 +273,6 @@ CONFIG_QSEMI_PHY=m
 CONFIG_SMSC_PHY=m
 CONFIG_VITESSE_PHY=m
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index e2f7d01f4d10..eca70fc35051 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -108,7 +108,6 @@ CONFIG_IFB=m
 CONFIG_KORINA=y
 CONFIG_VIA_RHINE=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MULTILINK=y
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 3550250e8b87..c6554d1e9bae 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -106,7 +106,6 @@ CONFIG_LASI_82596=y
 # CONFIG_NET_VENDOR_TI is not set
 # CONFIG_NET_VENDOR_VIA is not set
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 # CONFIG_WLAN is not set
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index 7beb36a41d45..47465017a5fd 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -94,7 +94,6 @@ CONFIG_FS_ENET=y
 CONFIG_UCC_GETH=y
 CONFIG_GIANFAR=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MULTILINK=y
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index 11dfd964465a..4a1aa66d54ff 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -59,7 +59,6 @@ CONFIG_8139CP=y
 CONFIG_8139TOO=y
 CONFIG_PHYLIB=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 36662f293587..e9a517bfe98a 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -59,7 +59,6 @@ CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_VIA_RHINE=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 04afb1594890..125751409583 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -98,7 +98,6 @@ CONFIG_TIGON3=y
 CONFIG_E1000=y
 CONFIG_SUNGEM=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 728c8cabfb83..bec560cc6317 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -157,7 +157,6 @@ CONFIG_MACE=y
 CONFIG_BMAC=y
 CONFIG_SUNGEM=y
 CONFIG_PPP=y
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=y
 CONFIG_PPP_MULTILINK=y
 CONFIG_PPP_ASYNC=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 1eb8e3457e8b..098608390ab0 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -226,7 +226,6 @@ CONFIG_GELIC_WIRELESS=y
 CONFIG_BROADCOM_PHY=m
 CONFIG_MARVELL_PHY=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index f365b79c7802..f783d15c3548 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -104,7 +104,6 @@ CONFIG_SUNGEM=y
 CONFIG_BROADCOM_PHY=m
 CONFIG_MARVELL_PHY=y
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 3892d9dd75d9..eaeebe8f918c 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -609,7 +609,6 @@ CONFIG_MLX5_SF=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 95720e8ad80d..86a5f24e6c6c 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -599,7 +599,6 @@ CONFIG_MLX5_SF=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_MPPE=m
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 00863ecb228e..0d603c4fbd9e 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -184,7 +184,6 @@ CONFIG_PPP_FILTER=y
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
 CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_MPPE=m
 CONFIG_PPPOE=m
 CONFIG_SLIP=m
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 34a6a31e6e14..6972b72c3ab7 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -107,7 +107,6 @@ CONFIG_PPP_FILTER=y
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
 CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_MPPE=m
 CONFIG_PPPOE=m
 CONFIG_INPUT_EVDEV=y
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 88e4c485d6b2..18db7d4c9aab 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_QCOM_IPA) += ipa/
 obj-$(CONFIG_PLIP) += plip/
 obj-$(CONFIG_PPP) += ppp/
 obj-$(CONFIG_PPP_ASYNC) += ppp/
-obj-$(CONFIG_PPP_BSDCOMP) += ppp/
 obj-$(CONFIG_PPP_DEFLATE) += ppp/
 obj-$(CONFIG_PPP_MPPE) += ppp/
 obj-$(CONFIG_PPP_SYNC_TTY) += ppp/
diff --git a/drivers/net/ppp/Kconfig b/drivers/net/ppp/Kconfig
index 4047f13b83dc..be76d645aa78 100644
--- a/drivers/net/ppp/Kconfig
+++ b/drivers/net/ppp/Kconfig
@@ -34,24 +34,6 @@ config PPP
 
 if PPP
 
-config PPP_BSDCOMP
-	tristate "PPP BSD-Compress compression"
-	help
-	  Support for the BSD-Compress compression method for PPP, which uses
-	  the LZW compression method to compress each PPP packet before it is
-	  sent over the wire. The machine at the other end of the PPP link
-	  (usually your ISP) has to support the BSD-Compress compression
-	  method as well for this to be useful. Even if they don't support it,
-	  it is safe to say Y here.
-
-	  The PPP Deflate compression method ("PPP Deflate compression",
-	  above) is preferable to BSD-Compress, because it compresses better
-	  and is patent-free.
-
-	  Note that the BSD compression code will always be compiled as a
-	  module; it is called bsd_comp and will show up in the directory
-	  modules once you have said "make modules". If unsure, say N.
-
 config PPP_DEFLATE
 	tristate "PPP Deflate compression"
 	select ZLIB_INFLATE
diff --git a/drivers/net/ppp/Makefile b/drivers/net/ppp/Makefile
index a815e1497179..7257df727217 100644
--- a/drivers/net/ppp/Makefile
+++ b/drivers/net/ppp/Makefile
@@ -5,7 +5,6 @@
 
 obj-$(CONFIG_PPP) += ppp_generic.o
 obj-$(CONFIG_PPP_ASYNC) += ppp_async.o
-obj-$(CONFIG_PPP_BSDCOMP) += bsd_comp.o
 obj-$(CONFIG_PPP_DEFLATE) += ppp_deflate.o
 obj-$(CONFIG_PPP_MPPE) += ppp_mppe.o
 obj-$(CONFIG_PPP_SYNC_TTY) += ppp_synctty.o
diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
deleted file mode 100644
index 63a6d251c746..000000000000
--- a/drivers/net/ppp/bsd_comp.c
+++ /dev/null
@@ -1,1170 +0,0 @@
-/*
- * Update: The Berkeley copyright was changed, and the change
- * is retroactive to all "true" BSD software (ie everything
- * from UCB as opposed to other peoples code that just carried
- * the same license). The new copyright doesn't clash with the
- * GPL, so the module-only restriction has been removed..
- */
-
-/* Because this code is derived from the 4.3BSD compress source:
- *
- * Copyright (c) 1985, 1986 The Regents of the University of California.
- * All rights reserved.
- *
- * This code is derived from software contributed to Berkeley by
- * James A. Woods, derived from original work by Spencer Thomas
- * and Joseph Orost.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. All advertising materials mentioning features or use of this software
- *    must display the following acknowledgement:
- *	This product includes software developed by the University of
- *	California, Berkeley and its contributors.
- * 4. Neither the name of the University nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- */
-
-/*
- * This version is for use with contiguous buffers on Linux-derived systems.
- *
- *  ==FILEVERSION 20000226==
- *
- *  NOTE TO MAINTAINERS:
- *     If you modify this file at all, please set the number above to the
- *     date of the modification as YYMMDD (year month day).
- *     bsd_comp.c is shipped with a PPP distribution as well as with
- *     the kernel; if everyone increases the FILEVERSION number above,
- *     then scripts can do the right thing when deciding whether to
- *     install a new bsd_comp.c file. Don't change the format of that
- *     line otherwise, so the installation script can recognize it.
- *
- * From: bsd_comp.c,v 1.3 1994/12/08 01:59:58 paulus Exp
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/string.h>
-
-#include <linux/ppp_defs.h>
-
-#undef   PACKETPTR
-#define  PACKETPTR 1
-#include <linux/ppp-comp.h>
-#undef   PACKETPTR
-
-#include <asm/byteorder.h>
-
-/*
- * PPP "BSD compress" compression
- *  The differences between this compression and the classic BSD LZW
- *  source are obvious from the requirement that the classic code worked
- *  with files while this handles arbitrarily long streams that
- *  are broken into packets.  They are:
- *
- *	When the code size expands, a block of junk is not emitted by
- *	    the compressor and not expected by the decompressor.
- *
- *	New codes are not necessarily assigned every time an old
- *	    code is output by the compressor.  This is because a packet
- *	    end forces a code to be emitted, but does not imply that a
- *	    new sequence has been seen.
- *
- *	The compression ratio is checked at the first end of a packet
- *	    after the appropriate gap.	Besides simplifying and speeding
- *	    things up, this makes it more likely that the transmitter
- *	    and receiver will agree when the dictionary is cleared when
- *	    compression is not going well.
- */
-
-/*
- * Macros to extract protocol version and number of bits
- * from the third byte of the BSD Compress CCP configuration option.
- */
-
-#define BSD_VERSION(x)	((x) >> 5)
-#define BSD_NBITS(x)	((x) & 0x1F)
-
-#define BSD_CURRENT_VERSION	1
-
-/*
- * A dictionary for doing BSD compress.
- */
-
-struct bsd_dict {
-    union {				/* hash value */
-	unsigned long	fcode;
-	struct {
-#if defined(__LITTLE_ENDIAN)		/* Little endian order */
-	    unsigned short	prefix;	/* preceding code */
-	    unsigned char	suffix; /* last character of new code */
-	    unsigned char	pad;
-#elif defined(__BIG_ENDIAN)		/* Big endian order */
-	    unsigned char	pad;
-	    unsigned char	suffix; /* last character of new code */
-	    unsigned short	prefix; /* preceding code */
-#else
-#error Endianness not defined...
-#endif
-	} hs;
-    } f;
-    unsigned short codem1;		/* output of hash table -1 */
-    unsigned short cptr;		/* map code to hash table entry */
-};
-
-struct bsd_db {
-    int	    totlen;			/* length of this structure */
-    unsigned int   hsize;		/* size of the hash table */
-    unsigned char  hshift;		/* used in hash function */
-    unsigned char  n_bits;		/* current bits/code */
-    unsigned char  maxbits;		/* maximum bits/code */
-    unsigned char  debug;		/* non-zero if debug desired */
-    unsigned char  unit;		/* ppp unit number */
-    unsigned short seqno;		/* sequence # of next packet */
-    unsigned int   mru;			/* size of receive (decompress) bufr */
-    unsigned int   maxmaxcode;		/* largest valid code */
-    unsigned int   max_ent;		/* largest code in use */
-    unsigned int   in_count;		/* uncompressed bytes, aged */
-    unsigned int   bytes_out;		/* compressed bytes, aged */
-    unsigned int   ratio;		/* recent compression ratio */
-    unsigned int   checkpoint;		/* when to next check the ratio */
-    unsigned int   clear_count;		/* times dictionary cleared */
-    unsigned int   incomp_count;	/* incompressible packets */
-    unsigned int   incomp_bytes;	/* incompressible bytes */
-    unsigned int   uncomp_count;	/* uncompressed packets */
-    unsigned int   uncomp_bytes;	/* uncompressed bytes */
-    unsigned int   comp_count;		/* compressed packets */
-    unsigned int   comp_bytes;		/* compressed bytes */
-    unsigned short  *lens;		/* array of lengths of codes */
-    struct bsd_dict *dict;		/* dictionary */
-};
-
-#define BSD_OVHD	2		/* BSD compress overhead/packet */
-#define MIN_BSD_BITS	9
-#define BSD_INIT_BITS	MIN_BSD_BITS
-#define MAX_BSD_BITS	15
-
-static void	bsd_free (void *state);
-static void	*bsd_alloc(unsigned char *options, int opt_len, int decomp);
-static void	*bsd_comp_alloc (unsigned char *options, int opt_len);
-static void	*bsd_decomp_alloc (unsigned char *options, int opt_len);
-
-static int	bsd_init        (void *db, unsigned char *options,
-			         int opt_len, int unit, int debug, int decomp);
-static int	bsd_comp_init   (void *state, unsigned char *options,
-			         int opt_len, int unit, int opthdr, int debug);
-static int	bsd_decomp_init (void *state, unsigned char *options,
-				 int opt_len, int unit, int opthdr, int mru,
-				 int debug);
-
-static void	bsd_reset (void *state);
-static void	bsd_comp_stats (void *state, struct compstat *stats);
-
-static int	bsd_compress (void *state, unsigned char *rptr,
-			      unsigned char *obuf, int isize, int osize);
-static void	bsd_incomp (void *state, unsigned char *ibuf, int icnt);
-
-static int	bsd_decompress (void *state, unsigned char *ibuf, int isize,
-				unsigned char *obuf, int osize);
-
-/* These are in ppp_generic.c */
-extern int  ppp_register_compressor   (struct compressor *cp);
-extern void ppp_unregister_compressor (struct compressor *cp);
-
-/*
- * the next two codes should not be changed lightly, as they must not
- * lie within the contiguous general code space.
- */
-#define CLEAR	256			/* table clear output code */
-#define FIRST	257			/* first free entry */
-#define LAST	255
-
-#define MAXCODE(b)	((1 << (b)) - 1)
-#define BADCODEM1	MAXCODE(MAX_BSD_BITS)
-
-#define BSD_HASH(prefix,suffix,hshift) ((((unsigned long)(suffix))<<(hshift)) \
-					 ^ (unsigned long)(prefix))
-#define BSD_KEY(prefix,suffix)		((((unsigned long)(suffix)) << 16) \
-					 + (unsigned long)(prefix))
-
-#define CHECK_GAP	10000		/* Ratio check interval */
-
-#define RATIO_SCALE_LOG	8
-#define RATIO_SCALE	(1<<RATIO_SCALE_LOG)
-#define RATIO_MAX	(0x7fffffff>>RATIO_SCALE_LOG)
-
-/*
- * clear the dictionary
- */
-
-static void
-bsd_clear(struct bsd_db *db)
-{
-    db->clear_count++;
-    db->max_ent      = FIRST-1;
-    db->n_bits       = BSD_INIT_BITS;
-    db->bytes_out    = 0;
-    db->in_count     = 0;
-    db->ratio	     = 0;
-    db->checkpoint   = CHECK_GAP;
-}
-
-/*
- * If the dictionary is full, then see if it is time to reset it.
- *
- * Compute the compression ratio using fixed-point arithmetic
- * with 8 fractional bits.
- *
- * Since we have an infinite stream instead of a single file,
- * watch only the local compression ratio.
- *
- * Since both peers must reset the dictionary at the same time even in
- * the absence of CLEAR codes (while packets are incompressible), they
- * must compute the same ratio.
- */
-
-static int bsd_check (struct bsd_db *db)	/* 1=output CLEAR */
-  {
-    unsigned int new_ratio;
-
-    if (db->in_count >= db->checkpoint)
-      {
-	/* age the ratio by limiting the size of the counts */
-	if (db->in_count >= RATIO_MAX || db->bytes_out >= RATIO_MAX)
-	  {
-	    db->in_count  -= (db->in_count  >> 2);
-	    db->bytes_out -= (db->bytes_out >> 2);
-	  }
-
-	db->checkpoint = db->in_count + CHECK_GAP;
-
-	if (db->max_ent >= db->maxmaxcode)
-	  {
-	    /* Reset the dictionary only if the ratio is worse,
-	     * or if it looks as if it has been poisoned
-	     * by incompressible data.
-	     *
-	     * This does not overflow, because
-	     *	db->in_count <= RATIO_MAX.
-	     */
-
-	    new_ratio = db->in_count << RATIO_SCALE_LOG;
-	    if (db->bytes_out != 0)
-	      {
-		new_ratio /= db->bytes_out;
-	      }
-
-	    if (new_ratio < db->ratio || new_ratio < 1 * RATIO_SCALE)
-	      {
-		bsd_clear (db);
-		return 1;
-	      }
-	    db->ratio = new_ratio;
-	  }
-      }
-    return 0;
-  }
-
-/*
- * Return statistics.
- */
-
-static void bsd_comp_stats (void *state, struct compstat *stats)
-  {
-    struct bsd_db *db = (struct bsd_db *) state;
-
-    stats->unc_bytes    = db->uncomp_bytes;
-    stats->unc_packets  = db->uncomp_count;
-    stats->comp_bytes   = db->comp_bytes;
-    stats->comp_packets = db->comp_count;
-    stats->inc_bytes    = db->incomp_bytes;
-    stats->inc_packets  = db->incomp_count;
-    stats->in_count     = db->in_count;
-    stats->bytes_out    = db->bytes_out;
-  }
-
-/*
- * Reset state, as on a CCP ResetReq.
- */
-
-static void bsd_reset (void *state)
-  {
-    struct bsd_db *db = (struct bsd_db *) state;
-
-    bsd_clear(db);
-
-    db->seqno       = 0;
-    db->clear_count = 0;
-  }
-
-/*
- * Release the compression structure
- */
-
-static void bsd_free (void *state)
-{
-	struct bsd_db *db = state;
-
-	if (!db)
-		return;
-
-/*
- * Release the dictionary
- */
-	vfree(db->dict);
-	db->dict = NULL;
-/*
- * Release the string buffer
- */
-	vfree(db->lens);
-	db->lens = NULL;
-/*
- * Finally release the structure itself.
- */
-	kfree(db);
-}
-
-/*
- * Allocate space for a (de) compressor.
- */
-
-static void *bsd_alloc (unsigned char *options, int opt_len, int decomp)
-  {
-    int bits;
-    unsigned int hsize, hshift, maxmaxcode;
-    struct bsd_db *db;
-
-    if (opt_len != 3 || options[0] != CI_BSD_COMPRESS || options[1] != 3
-	|| BSD_VERSION(options[2]) != BSD_CURRENT_VERSION)
-      {
-	return NULL;
-      }
-
-    bits = BSD_NBITS(options[2]);
-
-    switch (bits)
-      {
-    case 9:			/* needs 82152 for both directions */
-    case 10:			/* needs 84144 */
-    case 11:			/* needs 88240 */
-    case 12:			/* needs 96432 */
-	hsize = 5003;
-	hshift = 4;
-	break;
-    case 13:			/* needs 176784 */
-	hsize = 9001;
-	hshift = 5;
-	break;
-    case 14:			/* needs 353744 */
-	hsize = 18013;
-	hshift = 6;
-	break;
-    case 15:			/* needs 691440 */
-	hsize = 35023;
-	hshift = 7;
-	break;
-    case 16:			/* needs 1366160--far too much, */
-	/* hsize = 69001; */	/* and 69001 is too big for cptr */
-	/* hshift = 8; */	/* in struct bsd_db */
-	/* break; */
-    default:
-	return NULL;
-      }
-/*
- * Allocate the main control structure for this instance.
- */
-    maxmaxcode = MAXCODE(bits);
-    db         = kzalloc_obj(struct bsd_db);
-    if (!db)
-      {
-	return NULL;
-      }
-
-/*
- * Allocate space for the dictionary. This may be more than one page in
- * length.
- */
-    db->dict = vmalloc_array(hsize, sizeof(struct bsd_dict));
-    if (!db->dict)
-      {
-	bsd_free (db);
-	return NULL;
-      }
-
-/*
- * If this is the compression buffer then there is no length data.
- */
-    if (!decomp)
-      {
-	db->lens = NULL;
-      }
-/*
- * For decompression, the length information is needed as well.
- */
-    else
-      {
-        db->lens = vmalloc_array(maxmaxcode + 1, sizeof(db->lens[0]));
-	if (!db->lens)
-	  {
-	    bsd_free (db);
-	    return NULL;
-	  }
-      }
-/*
- * Initialize the data information for the compression code
- */
-    db->totlen     = sizeof (struct bsd_db)   +
-		    (sizeof (struct bsd_dict) * hsize);
-
-    db->hsize      = hsize;
-    db->hshift     = hshift;
-    db->maxmaxcode = maxmaxcode;
-    db->maxbits    = bits;
-
-    return (void *) db;
-  }
-
-static void *bsd_comp_alloc (unsigned char *options, int opt_len)
-  {
-    return bsd_alloc (options, opt_len, 0);
-  }
-
-static void *bsd_decomp_alloc (unsigned char *options, int opt_len)
-  {
-    return bsd_alloc (options, opt_len, 1);
-  }
-
-/*
- * Initialize the database.
- */
-
-static int bsd_init (void *state, unsigned char *options,
-		     int opt_len, int unit, int debug, int decomp)
-  {
-    struct bsd_db *db = state;
-    int indx;
-
-    if ((opt_len != 3) || (options[0] != CI_BSD_COMPRESS) || (options[1] != 3)
-	|| (BSD_VERSION(options[2]) != BSD_CURRENT_VERSION)
-	|| (BSD_NBITS(options[2]) != db->maxbits)
-	|| (decomp && db->lens == NULL))
-      {
-	return 0;
-      }
-
-    if (decomp)
-      {
-	indx = LAST;
-	do
-	  {
-	    db->lens[indx] = 1;
-	  }
-	while (indx-- > 0);
-      }
-
-    indx = db->hsize;
-    while (indx-- != 0)
-      {
-	db->dict[indx].codem1 = BADCODEM1;
-	db->dict[indx].cptr   = 0;
-      }
-
-    db->unit = unit;
-    db->mru  = 0;
-#ifndef DEBUG
-    if (debug)
-#endif
-      db->debug = 1;
-
-    bsd_reset(db);
-
-    return 1;
-  }
-
-static int bsd_comp_init (void *state, unsigned char *options,
-			  int opt_len, int unit, int opthdr, int debug)
-  {
-    return bsd_init (state, options, opt_len, unit, debug, 0);
-  }
-
-static int bsd_decomp_init (void *state, unsigned char *options,
-			    int opt_len, int unit, int opthdr, int mru,
-			    int debug)
-  {
-    return bsd_init (state, options, opt_len, unit, debug, 1);
-  }
-
-/*
- * Obtain pointers to the various structures in the compression tables
- */
-
-#define dict_ptrx(p,idx) &(p->dict[idx])
-#define lens_ptrx(p,idx) &(p->lens[idx])
-
-#ifdef DEBUG
-static unsigned short *lens_ptr(struct bsd_db *db, int idx)
-  {
-    if ((unsigned int) idx > (unsigned int) db->maxmaxcode)
-      {
-	printk ("<9>ppp: lens_ptr(%d) > max\n", idx);
-	idx = 0;
-      }
-    return lens_ptrx (db, idx);
-  }
-
-static struct bsd_dict *dict_ptr(struct bsd_db *db, int idx)
-  {
-    if ((unsigned int) idx >= (unsigned int) db->hsize)
-      {
-	printk ("<9>ppp: dict_ptr(%d) > max\n", idx);
-	idx = 0;
-      }
-    return dict_ptrx (db, idx);
-  }
-
-#else
-#define lens_ptr(db,idx) lens_ptrx(db,idx)
-#define dict_ptr(db,idx) dict_ptrx(db,idx)
-#endif
-
-/*
- * compress a packet
- *
- *	The result of this function is the size of the compressed
- *	packet. A zero is returned if the packet was not compressed
- *	for some reason, such as the size being larger than uncompressed.
- *
- *	One change from the BSD compress command is that when the
- *	code size expands, we do not output a bunch of padding.
- */
-
-static int bsd_compress (void *state, unsigned char *rptr, unsigned char *obuf,
-			 int isize, int osize)
-  {
-    struct bsd_db *db;
-    int hshift;
-    unsigned int max_ent;
-    unsigned int n_bits;
-    unsigned int bitno;
-    unsigned long accm;
-    int ent;
-    unsigned long fcode;
-    struct bsd_dict *dictp;
-    unsigned char c;
-    int hval;
-    int disp;
-    int ilen;
-    int mxcode;
-    unsigned char *wptr;
-    int olen;
-
-#define PUTBYTE(v)			\
-  {					\
-    ++olen;				\
-    if (wptr)				\
-      {					\
-	*wptr++ = (unsigned char) (v);	\
-	if (olen >= osize)		\
-	  {				\
-	    wptr = NULL;		\
-	  }				\
-      }					\
-  }
-
-#define OUTPUT(ent)			\
-  {					\
-    bitno -= n_bits;			\
-    accm |= ((ent) << bitno);		\
-    do					\
-      {					\
-	PUTBYTE(accm >> 24);		\
-	accm <<= 8;			\
-	bitno += 8;			\
-      }					\
-    while (bitno <= 24);		\
-  }
-
-  /*
-   * If the protocol is not in the range we're interested in,
-   * just return without compressing the packet.  If it is,
-   * the protocol becomes the first byte to compress.
-   */
-
-    ent = PPP_PROTOCOL(rptr);
-    if (ent < 0x21 || ent > 0xf9)
-      {
-	return 0;
-      }
-
-    db      = (struct bsd_db *) state;
-    hshift  = db->hshift;
-    max_ent = db->max_ent;
-    n_bits  = db->n_bits;
-    bitno   = 32;
-    accm    = 0;
-    mxcode  = MAXCODE (n_bits);
-
-    /* Initialize the output pointers */
-    wptr  = obuf;
-    olen  = PPP_HDRLEN + BSD_OVHD;
-
-    if (osize > isize)
-      {
-	osize = isize;
-      }
-
-    /* This is the PPP header information */
-    if (wptr)
-      {
-	*wptr++ = PPP_ADDRESS(rptr);
-	*wptr++ = PPP_CONTROL(rptr);
-	*wptr++ = 0;
-	*wptr++ = PPP_COMP;
-	*wptr++ = db->seqno >> 8;
-	*wptr++ = db->seqno;
-      }
-
-    /* Skip the input header */
-    rptr  += PPP_HDRLEN;
-    isize -= PPP_HDRLEN;
-    ilen   = ++isize;	/* Low byte of protocol is counted as input */
-
-    while (--ilen > 0)
-      {
-	c     = *rptr++;
-	fcode = BSD_KEY  (ent, c);
-	hval  = BSD_HASH (ent, c, hshift);
-	dictp = dict_ptr (db, hval);
-
-	/* Validate and then check the entry. */
-	if (dictp->codem1 >= max_ent)
-	  {
-	    goto nomatch;
-	  }
-
-	if (dictp->f.fcode == fcode)
-	  {
-	    ent = dictp->codem1 + 1;
-	    continue;	/* found (prefix,suffix) */
-	  }
-
-	/* continue probing until a match or invalid entry */
-	disp = (hval == 0) ? 1 : hval;
-
-	do
-	  {
-	    hval += disp;
-	    if (hval >= db->hsize)
-	      {
-		hval -= db->hsize;
-	      }
-	    dictp = dict_ptr (db, hval);
-	    if (dictp->codem1 >= max_ent)
-	      {
-		goto nomatch;
-	      }
-	  }
-	while (dictp->f.fcode != fcode);
-
-	ent = dictp->codem1 + 1;	/* finally found (prefix,suffix) */
-	continue;
-
-nomatch:
-	OUTPUT(ent);		/* output the prefix */
-
-	/* code -> hashtable */
-	if (max_ent < db->maxmaxcode)
-	  {
-	    struct bsd_dict *dictp2;
-	    struct bsd_dict *dictp3;
-	    int    indx;
-
-	    /* expand code size if needed */
-	    if (max_ent >= mxcode)
-	      {
-		db->n_bits = ++n_bits;
-		mxcode     = MAXCODE (n_bits);
-	      }
-
-	    /* Invalidate old hash table entry using
-	     * this code, and then take it over.
-	     */
-
-	    dictp2 = dict_ptr (db, max_ent + 1);
-	    indx   = dictp2->cptr;
-	    dictp3 = dict_ptr (db, indx);
-
-	    if (dictp3->codem1 == max_ent)
-	      {
-		dictp3->codem1 = BADCODEM1;
-	      }
-
-	    dictp2->cptr   = hval;
-	    dictp->codem1  = max_ent;
-	    dictp->f.fcode = fcode;
-	    db->max_ent    = ++max_ent;
-
-	    if (db->lens)
-	      {
-		unsigned short *len1 = lens_ptr (db, max_ent);
-		unsigned short *len2 = lens_ptr (db, ent);
-		*len1 = *len2 + 1;
-	      }
-	  }
-	ent = c;
-      }
-
-    OUTPUT(ent);		/* output the last code */
-
-    db->bytes_out    += olen - PPP_HDRLEN - BSD_OVHD;
-    db->uncomp_bytes += isize;
-    db->in_count     += isize;
-    ++db->uncomp_count;
-    ++db->seqno;
-
-    if (bitno < 32)
-      {
-	++db->bytes_out; /* must be set before calling bsd_check */
-      }
-
-    /*
-     * Generate the clear command if needed
-     */
-
-    if (bsd_check(db))
-      {
-	OUTPUT (CLEAR);
-      }
-
-    /*
-     * Pad dribble bits of last code with ones.
-     * Do not emit a completely useless byte of ones.
-     */
-
-    if (bitno != 32)
-      {
-	PUTBYTE((accm | (0xff << (bitno-8))) >> 24);
-      }
-
-    /*
-     * Increase code size if we would have without the packet
-     * boundary because the decompressor will do so.
-     */
-
-    if (max_ent >= mxcode && max_ent < db->maxmaxcode)
-      {
-	db->n_bits++;
-      }
-
-    /* If output length is too large then this is an incomplete frame. */
-    if (wptr == NULL)
-      {
-	++db->incomp_count;
-	db->incomp_bytes += isize;
-	olen              = 0;
-      }
-    else /* Count the number of compressed frames */
-      {
-	++db->comp_count;
-	db->comp_bytes += olen;
-      }
-
-    /* Return the resulting output length */
-    return olen;
-#undef OUTPUT
-#undef PUTBYTE
-  }
-
-/*
- * Update the "BSD Compress" dictionary on the receiver for
- * incompressible data by pretending to compress the incoming data.
- */
-
-static void bsd_incomp (void *state, unsigned char *ibuf, int icnt)
-  {
-    (void) bsd_compress (state, ibuf, (char *) 0, icnt, 0);
-  }
-
-/*
- * Decompress "BSD Compress".
- *
- * Because of patent problems, we return DECOMP_ERROR for errors
- * found by inspecting the input data and for system problems, but
- * DECOMP_FATALERROR for any errors which could possibly be said to
- * be being detected "after" decompression.  For DECOMP_ERROR,
- * we can issue a CCP reset-request; for DECOMP_FATALERROR, we may be
- * infringing a patent of Motorola's if we do, so we take CCP down
- * instead.
- *
- * Given that the frame has the correct sequence number and a good FCS,
- * errors such as invalid codes in the input most likely indicate a
- * bug, so we return DECOMP_FATALERROR for them in order to turn off
- * compression, even though they are detected by inspecting the input.
- */
-
-static int bsd_decompress (void *state, unsigned char *ibuf, int isize,
-			   unsigned char *obuf, int osize)
-  {
-    struct bsd_db *db;
-    unsigned int max_ent;
-    unsigned long accm;
-    unsigned int bitno;		/* 1st valid bit in accm */
-    unsigned int n_bits;
-    unsigned int tgtbitno;	/* bitno when we have a code */
-    struct bsd_dict *dictp;
-    int explen;
-    int seq;
-    unsigned int incode;
-    unsigned int oldcode;
-    unsigned int finchar;
-    unsigned char *p;
-    unsigned char *wptr;
-    int adrs;
-    int ctrl;
-    int ilen;
-    int codelen;
-    int extra;
-
-    db       = (struct bsd_db *) state;
-    max_ent  = db->max_ent;
-    accm     = 0;
-    bitno    = 32;		/* 1st valid bit in accm */
-    n_bits   = db->n_bits;
-    tgtbitno = 32 - n_bits;	/* bitno when we have a code */
-
-    /*
-     * Save the address/control from the PPP header
-     * and then get the sequence number.
-     */
-
-    adrs  = PPP_ADDRESS (ibuf);
-    ctrl  = PPP_CONTROL (ibuf);
-
-    seq   = (ibuf[4] << 8) + ibuf[5];
-
-    ibuf += (PPP_HDRLEN + 2);
-    ilen  = isize - (PPP_HDRLEN + 2);
-
-    /*
-     * Check the sequence number and give up if it differs from
-     * the value we're expecting.
-     */
-
-    if (seq != db->seqno)
-      {
-	if (db->debug)
-	  {
-	    printk("bsd_decomp%d: bad sequence # %d, expected %d\n",
-		   db->unit, seq, db->seqno - 1);
-	  }
-	return DECOMP_ERROR;
-      }
-
-    ++db->seqno;
-    db->bytes_out += ilen;
-
-    /*
-     * Fill in the ppp header, but not the last byte of the protocol
-     * (that comes from the decompressed data).
-     */
-
-    wptr    = obuf;
-    *wptr++ = adrs;
-    *wptr++ = ctrl;
-    *wptr++ = 0;
-
-    oldcode = CLEAR;
-    explen  = 3;
-
-    /*
-     * Keep the checkpoint correctly so that incompressible packets
-     * clear the dictionary at the proper times.
-     */
-
-    for (;;)
-      {
-	if (ilen-- <= 0)
-	  {
-	    db->in_count += (explen - 3); /* don't count the header */
-	    break;
-	  }
-
-	/*
-	 * Accumulate bytes until we have a complete code.
-	 * Then get the next code, relying on the 32-bit,
-	 * unsigned accm to mask the result.
-	 */
-
-	bitno -= 8;
-	accm  |= *ibuf++ << bitno;
-	if (tgtbitno < bitno)
-	  {
-	    continue;
-	  }
-
-	incode = accm >> tgtbitno;
-	accm <<= n_bits;
-	bitno += n_bits;
-
-	/*
-	 * The dictionary must only be cleared at the end of a packet.
-	 */
-
-	if (incode == CLEAR)
-	  {
-	    if (ilen > 0)
-	      {
-		if (db->debug)
-		  {
-		    printk("bsd_decomp%d: bad CLEAR\n", db->unit);
-		  }
-		return DECOMP_FATALERROR;	/* probably a bug */
-	      }
-
-	    bsd_clear(db);
-	    break;
-	  }
-
-	if ((incode > max_ent + 2) || (incode > db->maxmaxcode)
-	    || (incode > max_ent && oldcode == CLEAR))
-	  {
-	    if (db->debug)
-	      {
-		printk("bsd_decomp%d: bad code 0x%x oldcode=0x%x ",
-		       db->unit, incode, oldcode);
-		printk("max_ent=0x%x explen=%d seqno=%d\n",
-		       max_ent, explen, db->seqno);
-	      }
-	    return DECOMP_FATALERROR;	/* probably a bug */
-	  }
-
-	/* Special case for KwKwK string. */
-	if (incode > max_ent)
-	  {
-	    finchar = oldcode;
-	    extra   = 1;
-	  }
-	else
-	  {
-	    finchar = incode;
-	    extra   = 0;
-	  }
-
-	codelen = *(lens_ptr (db, finchar));
-	explen += codelen + extra;
-	if (explen > osize)
-	  {
-	    if (db->debug)
-	      {
-		printk("bsd_decomp%d: ran out of mru\n", db->unit);
-#ifdef DEBUG
-		printk("  len=%d, finchar=0x%x, codelen=%d, explen=%d\n",
-		       ilen, finchar, codelen, explen);
-#endif
-	      }
-	    return DECOMP_FATALERROR;
-	  }
-
-	/*
-	 * Decode this code and install it in the decompressed buffer.
-	 */
-
-	wptr += codelen;
-	p     = wptr;
-	while (finchar > LAST)
-	  {
-	    struct bsd_dict *dictp2 = dict_ptr (db, finchar);
-
-	    dictp = dict_ptr (db, dictp2->cptr);
-#ifdef DEBUG
-	    if (--codelen <= 0 || dictp->codem1 != finchar-1)
-	      {
-		if (codelen <= 0)
-		  {
-		    printk("bsd_decomp%d: fell off end of chain ", db->unit);
-		    printk("0x%x at 0x%x by 0x%x, max_ent=0x%x\n",
-			   incode, finchar, dictp2->cptr, max_ent);
-		  }
-		else
-		  {
-		    if (dictp->codem1 != finchar-1)
-		      {
-			printk("bsd_decomp%d: bad code chain 0x%x "
-			       "finchar=0x%x ",
-			       db->unit, incode, finchar);
-
-			printk("oldcode=0x%x cptr=0x%x codem1=0x%x\n",
-			       oldcode, dictp2->cptr, dictp->codem1);
-		      }
-		  }
-		return DECOMP_FATALERROR;
-	      }
-#endif
-	    *--p    = dictp->f.hs.suffix;
-	    finchar = dictp->f.hs.prefix;
-	  }
-	*--p = finchar;
-
-#ifdef DEBUG
-	if (--codelen != 0)
-	  {
-	    printk("bsd_decomp%d: short by %d after code 0x%x, max_ent=0x%x\n",
-		   db->unit, codelen, incode, max_ent);
-	  }
-#endif
-
-	if (extra)		/* the KwKwK case again */
-	  {
-	    *wptr++ = finchar;
-	  }
-
-	/*
-	 * If not first code in a packet, and
-	 * if not out of code space, then allocate a new code.
-	 *
-	 * Keep the hash table correct so it can be used
-	 * with uncompressed packets.
-	 */
-
-	if (oldcode != CLEAR && max_ent < db->maxmaxcode)
-	  {
-	    struct bsd_dict *dictp2, *dictp3;
-	    unsigned short  *lens1,  *lens2;
-	    unsigned long fcode;
-	    int hval, disp, indx;
-
-	    fcode = BSD_KEY(oldcode,finchar);
-	    hval  = BSD_HASH(oldcode,finchar,db->hshift);
-	    dictp = dict_ptr (db, hval);
-
-	    /* look for a free hash table entry */
-	    if (dictp->codem1 < max_ent)
-	      {
-		disp = (hval == 0) ? 1 : hval;
-		do
-		  {
-		    hval += disp;
-		    if (hval >= db->hsize)
-		      {
-			hval -= db->hsize;
-		      }
-		    dictp = dict_ptr (db, hval);
-		  }
-		while (dictp->codem1 < max_ent);
-	      }
-
-	    /*
-	     * Invalidate previous hash table entry
-	     * assigned this code, and then take it over
-	     */
-
-	    dictp2 = dict_ptr (db, max_ent + 1);
-	    indx   = dictp2->cptr;
-	    dictp3 = dict_ptr (db, indx);
-
-	    if (dictp3->codem1 == max_ent)
-	      {
-		dictp3->codem1 = BADCODEM1;
-	      }
-
-	    dictp2->cptr   = hval;
-	    dictp->codem1  = max_ent;
-	    dictp->f.fcode = fcode;
-	    db->max_ent    = ++max_ent;
-
-	    /* Update the length of this string. */
-	    lens1  = lens_ptr (db, max_ent);
-	    lens2  = lens_ptr (db, oldcode);
-	    *lens1 = *lens2 + 1;
-
-	    /* Expand code size if needed. */
-	    if (max_ent >= MAXCODE(n_bits) && max_ent < db->maxmaxcode)
-	      {
-		db->n_bits = ++n_bits;
-		tgtbitno   = 32-n_bits;
-	      }
-	  }
-	oldcode = incode;
-      }
-
-    ++db->comp_count;
-    ++db->uncomp_count;
-    db->comp_bytes   += isize - BSD_OVHD - PPP_HDRLEN;
-    db->uncomp_bytes += explen;
-
-    if (bsd_check(db))
-      {
-	if (db->debug)
-	  {
-	    printk("bsd_decomp%d: peer should have cleared dictionary on %d\n",
-		   db->unit, db->seqno - 1);
-	  }
-      }
-    return explen;
-  }
-
-/*************************************************************
- * Table of addresses for the BSD compression module
- *************************************************************/
-
-static struct compressor ppp_bsd_compress = {
-	.compress_proto =	CI_BSD_COMPRESS,
-	.comp_alloc =		bsd_comp_alloc,
-	.comp_free =		bsd_free,
-	.comp_init =		bsd_comp_init,
-	.comp_reset =		bsd_reset,
-	.compress =		bsd_compress,
-	.comp_stat =		bsd_comp_stats,
-	.decomp_alloc =		bsd_decomp_alloc,
-	.decomp_free =		bsd_free,
-	.decomp_init =		bsd_decomp_init,
-	.decomp_reset =		bsd_reset,
-	.decompress =		bsd_decompress,
-	.incomp =		bsd_incomp,
-	.decomp_stat =		bsd_comp_stats,
-	.owner =		THIS_MODULE
-};
-
-/*************************************************************
- * Module support routines
- *************************************************************/
-
-static int __init bsdcomp_init(void)
-{
-	int answer = ppp_register_compressor(&ppp_bsd_compress);
-	if (answer == 0)
-		printk(KERN_INFO "PPP BSD Compression module registered\n");
-	return answer;
-}
-
-static void __exit bsdcomp_cleanup(void)
-{
-	ppp_unregister_compressor(&ppp_bsd_compress);
-}
-
-module_init(bsdcomp_init);
-module_exit(bsdcomp_cleanup);
-MODULE_DESCRIPTION("PPP BSD-Compress compression module");
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_ALIAS("ppp-compress-" __stringify(CI_BSD_COMPRESS));
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893b..339b068fe34f 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2591,7 +2591,7 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
 		skb_pull(skb, 2);	/* pull off the A/C bytes */
 
 		/* Don't call __ppp_decompress_proto() here, but instead rely on
-		 * corresponding algo (mppe/bsd/deflate) to decompress it.
+		 * corresponding algo (mppe/deflate) to decompress it.
 		 */
 	} else {
 		/* Uncompressed frame - pass to decompressor so it
diff --git a/include/linux/ppp-comp.h b/include/linux/ppp-comp.h
index fb847e47f148..e63b3fa80d86 100644
--- a/include/linux/ppp-comp.h
+++ b/include/linux/ppp-comp.h
@@ -17,9 +17,6 @@ struct module;
  * various compression methods.
  */
 
-#ifndef DO_BSD_COMPRESS
-#define DO_BSD_COMPRESS	1	/* by default, include BSD-Compress */
-#endif
 #ifndef DO_DEFLATE
 #define DO_DEFLATE	1	/* by default, include Deflate */
 #endif
diff --git a/tools/testing/selftests/net/ppp/config b/tools/testing/selftests/net/ppp/config
index 843545df8f03..b90b5e90d62c 100644
--- a/tools/testing/selftests/net/ppp/config
+++ b/tools/testing/selftests/net/ppp/config
@@ -3,7 +3,6 @@ CONFIG_L2TP=m
 CONFIG_PACKET=y
 CONFIG_PPP=m
 CONFIG_PPP_ASYNC=m
-CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPPOE_HASH_BITS_4=y
-- 
2.43.0

