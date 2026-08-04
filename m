Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C6443AB3;
	Tue,  4 Aug 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839882; cv=none; b=kXfXGInjVoVIi2yxIgIVCMlq6aaP1n2rCiudlf87IcqtMfO2fdzj6MX14hSpnvlIuAOz2wSYs0Zq2L9gOb/pKqTnRC4VrNVzkXTgoeZrrjvS4juLKg61tIjUbMR8xWtlhnDq5LCIVCqttYw/ZTXM39/SOEXt6wL2BM+6palac4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839882; c=relaxed/simple;
	bh=OrxO8UMvnRmqyE88a6CFXNXz3h4yiX9451oSEJ4OxQw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XViNcVYVQZT8YfcyYfsvKDueVmgEBDzxBPfsCfYhm3witt62h2b/UL9fXfteTNTWAGUCOTiOa8zcRBN7twAHfkhJ6EauzYoQ+RHDOg3FktAL1MmRAp2YxRW1+xUr24I7FYHVRH49AKLueowL+toHq11wq6FbVvnMtycQ/njYC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hcOP2sL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKmh0jv1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hcOP2sL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKmh0jv1"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC34F7A015C;
	Tue,  4 Aug 2026 06:37:56 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 04 Aug 2026 06:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785839875;
	 x=1785926275; bh=F4TNC91ioxOgNojCv765eiTbs22V5ZqIXXQg2UnPWNE=; b=
	hcOP2sL0DOuM/T8+IQO1srl/9Nn67kOI+dItr5bYPEcLuZSANNE08vAxqgK9eHjY
	UwQao2g7lLVrCooo6Xl8OeqM2BoC+o4cIdZL2245TOdMwV6hbNx1zkuah69qv4MR
	mH2rlQBYkvHnrjfgwdBYoAUNGyIluknj2ts5wmjYhrdU+4Baphy1lEY5oM08z8/J
	ddoERL9iCmKKgmQRrYzD0T8NUa83M2W5nngfD2pm14vMZcU/Htt1KZxH6RQXSZCM
	xaHh3/eucDyfmQJQjwHHbnaSLBmb8nemkUq93tll/Q7wHx+hsJtdH/trWSNZLiWl
	UzLVLFKwao9c4x24P3SBtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785839875; x=
	1785926275; bh=F4TNC91ioxOgNojCv765eiTbs22V5ZqIXXQg2UnPWNE=; b=S
	Kmh0jv1MklLUpLLqEGoqrZjKuNqLkvIoKPnSOlegZYxLQqDvkWDauKWD5uBJzGPN
	rvGL9kpgSTVufehNl4m4Z39b2/zBbruMDWjy3smuqns0lo+OrqxQNopzeZIyaitK
	4V4dI1BljoJBYmDFP+mfnIm683VF6sc/c3BaldHhV1gSi6Dk+u2nrK1QoinyvQL0
	JCG0EzG1Xl7ESfFFMgLd9FGCyaHJM2KLD0PCWJT+0wnAH9u1fPvz1M8+GxyaTxTC
	z/MFkWBvMLQbw6E53TAJwN2q2VCvp2Wrhqa8NrqKFzFCcKWEbU8GiAJGRarprxRJ
	vDDx4OPp0GwC3ZMJqPV1A==
X-ME-Sender: <xms:-8BxakgbdoVssp9VyX3satUcncJNssTNEXomIqjLhco0dTAt6aWqZw>
    <xme:-8Bxan0hu2HwexDEIvVkKuVK6OylYAbt7eyPxH2MsmAYw_48FhqLZYjCGTK_5J5Vk
    NV_Z1hMQlSMEaAPvZPieoARY0bibyzQ8bPfWIHDXKyPi4CoCvwYLfvI>
X-ME-Proxy-Cause: dmFkZTEzWoc1rRS2QGP5Ror8Me2RezHRZNOW5bRyQijA6olHMpglaJSjZpBcJfpt9+aVy5
    jGcl71RdlVGMk6ztaFwER71xCKHvpSFL9cN05e1ig2PrttXiQBvhIVkeErkqhZkHUXZkCD
    dhbyCYQp+QnRXmFwTny8PbiSiD5NupnCAfSYA7dxRhuVRur+uM58cNjrL19FFTzQh/9Cc6
    t+8uWbk9B5cP6x58jjTXywc1cFXLwuyhiDW7bBqTpnTj8s+kWRD3SvFx5qpAkVdVewVFhV
    JbHle7kOIXw8iZYcKQFWZhE+3ccjjXIarD9OycjQXrO/Fa/DDPqDdSNHjp3BMpLYfvXfre
    /Ejk+vIfIheLDjxxY1MSjLid1BuHvYydVEKMvJbYjYwd/XEoUO9Im1bmEmk9RRXOdhn0BU
    9o7X+TNLmlMt/yCgSpr6uQh5R0fRBcNbX74Uy5ZkdXXufvlygdrBCc6KF06JTsO+O+poVP
    /w50emSMTKMuSiaULLPQzrATJVSBMw/CdsKjSnK0U3kvwbit8qVSfIsXqS7QuG5hIfco3t
    3Fs1SBjZo9bB7owVBvW74PVaMFAGUcgD6Bd0ON/S8Tp4dF/zQSbTsEXhxipsc2TFCcr4r0
    AkmkZyPeqJdpCySz+iHzRODQ4Tg/JoDbR679E98or4vCcMrO2/PpveZVc4pg
X-ME-Proxy: <xmx:_8BxanRcay9-nq3bb8ocIFDodOTaUUiaVIECPhc4wW23bbI5BC6iYg>
    <xmx:AMFxamPbkMvnMXkKZYT4LrSvj8H1tqizoRrRe4IcLo11r8k7ANOVFg>
    <xmx:AMFxaswWXQkWEYXGCUd4M9-7T7KyeLCOHPzhw9k1KEZs2Vm6eTCkPw>
    <xmx:AMFxaoqVcvVwdwzk93aYwPlHvOH47D31aNL0J5YwAjDRB0_oZ6-25w>
    <xmx:A8FxatSn_KNlSmS-NtACd7V5STkdfaaWCQ-C6aN2sg0wkGlEz9mNt_uG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DFC5132A0065; Tue,  4 Aug 2026 06:37:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag8nwV6tN_57
Date: Tue, 04 Aug 2026 12:36:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, driver-core@lists.linux.dev,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org
Message-Id: <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
In-Reply-To: <20260804071330.24760Aaf-hca@linux.ibm.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 4, 2026, at 09:13, Heiko Carstens wrote:
> On Mon, Aug 03, 2026 at 10:09:08PM +0200, Danilo Krummrich wrote:
>> On Mon Aug 3, 2026 at 9:56 PM CEST, Arnd Bergmann wrote:
>> > In theory you should be able to use rust code without PCI MMIO
>> > support, but I can't see any practical downsides to making rust
>> > 'depends on HAS_MMIO' to avoid having to add those #ifdef.
>> 
>> I think the implications should be minor without making Rust depend on
>> CONFIG_HAS_IOMEM.
>> 
>> I just sent out a fix [1]; the only annoying part is [2], but we should change
>> those doc-tests anyway. For the one in rust/kernel/io.rs we already did in
>> driver-core-next.
>> 
>> [1] https://lore.kernel.org/driver-core/20260803200249.3494259-1-dakr@kernel.org/

This looks like you still provide the rust version of ioremap(),
turning what is supposed to be a link failure into a runtime
error.

> I'm wondering if it would make sense to make HAS_IOMEM always available
> on s390, even though it doesn't make too much sense without PCI.
> But at least it would make s390 again a bit less special.

I see that with CONFIG_PCI=y, s390 already falls back to
generic_ioremap_prot() and just maps any phys_addr_t into the
page table as PAGE_KERNEL, regardless of whether this is an MMIO
address or not.

The simple change below would just extend that behavior to !PCI
and make that consistent with CONFIG_PCI=y on machines without
actual PCI hardware. Of course any code that might rely on this
is now a bug that likely never gets caught at build time.

This still relies on implementing the __raw_* helpers as nop
to have the same behavior as the PCI=y version, as the generic
version would just end up dereferencing the invalid pointers.

     Arnd

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..806782acf6f6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -173,7 +173,7 @@ config S390
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_IOREMAP if PCI
+	select GENERIC_IOREMAP
 	select GLOB
 	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
@@ -756,9 +756,6 @@ config PCI_NR_FUNCTIONS
 
 endif # PCI
 
-config HAS_IOMEM
-	def_bool PCI
-
 config CHSC_SCH
 	def_tristate m
 	prompt "Support for CHSC subchannels"
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index faddb9aef3b8..fa5a9dd1c47f 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -22,30 +22,16 @@ void *xlate_dev_mem_ptr(phys_addr_t phys);
 #define kc_unxlate_dev_mem_ptr unxlate_dev_mem_ptr
 void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
-#define IO_SPACE_LIMIT 0
-
-/*
- * I/O memory mapping functions.
- */
-#define ioremap_prot ioremap_prot
-#define iounmap iounmap
-
 #define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
 
 #define ioremap_wc(addr, size)  \
 	ioremap_prot((addr), (size), pgprot_writecombine(PAGE_KERNEL))
 
-static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
-{
-	return NULL;
-}
-
-static inline void ioport_unmap(void __iomem *p)
-{
-}
-
 #ifdef CONFIG_PCI
 
+#define ioremap_prot ioremap_prot
+#define iounmap iounmap
+
 /*
  * s390 needs a private implementation of pci_iomap since ioremap with its
  * offset parameter isn't sufficient. That's because BAR spaces are not
@@ -88,6 +74,49 @@ static inline void __iowrite64_copy(void __iomem *to, const void *from,
 }
 #define __iowrite64_copy __iowrite64_copy
 
+#else
+/*
+ * ioremap_prot() without PCI behaves like memremap(),
+ * MMIO accessors do nothing
+ */
+#define ioremap_prot generic_ioremap_prot
+#define iounmap generic_iounmap
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	return 0xff;
+}
+#define __raw_readb __raw_readb
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	return 0xffff;
+}
+#define __raw_readw __raw_readw
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	return 0xffffffffu;
+}
+#define __raw_readl __raw_readl
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	return 0xffffffffffffffffull;
+}
+#define __raw_readq __raw_readq
+static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+{
+}
+#define __raw_writeb __raw_writeb
+static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+}
+#define __raw_writew __raw_writew
+static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+{
+}
+#define __raw_writel __raw_writel
+static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+{
+}
+#define __raw_writeq __raw_writeq
 #endif /* CONFIG_PCI */
 
 #include <asm-generic/io.h>
diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c..2a4e3ecbfddd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -237,7 +237,6 @@ config INIT_ENV_ARG_LIMIT
 
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
-	depends on HAS_IOMEM
 	help
 	  Some drivers can be compiled on a different platform than they are
 	  intended to be run on. Despite they cannot be loaded there (or even
