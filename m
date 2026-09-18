Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB01480948;
	Fri, 18 Sep 2026 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755074; cv=none; b=toXF3d6RiUZ9NbjkGG8nUK45orZKlob22hjBuoh0I+gvNkv+NBKxoGsFCfXB9RuyVKdxts9Oswfakgcp3XS8KlO5YqGcaFGXj+2g5acfQix3k4jH132KfIxt5JIx9pFj9LAkmFoxhgdlCuxOaVZpBYZ/tkmGgcUFG5wGZg8bas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755074; c=relaxed/simple;
	bh=FqivIko67r9HaUg4e8difXO7wjgrRB8BEV3sB1a0kyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pGevAI8hFiPpXdPtzKRDigNrHLoVFVNeIG6FWUaje6QaRnmHm3Zm+NnBb9sP3rvcja4dK+8kD/CSjqxqBLybNNK65m7chlBykmp1qd8RuTffJESw+9b+2oL8NhSZUKCS/IYzvcyKx18HTT9T7PDtmBryEO631VtMgLpA2fZ3rRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixslY9BT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixslY9BT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959AC1F000FF;
	Fri, 18 Sep 2026 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755072;
	bh=MKp/x2a2D1xPBWMbbhAH8CyguAqsEsyzIV8pAqbSE/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixslY9BT7Eoq24ddQNfHyAyK2A658FxGXSit6rUOBUVhlxYNyntD/Cktn9gE/DXGx
	 PLQ5/sdz0JxdZ6FjeVXrtNRD5GgYOM6YooPQ9vndCLj7XcPNRIXCO7AsBbrgIqBU4C
	 82HujOcm6pC9fyyAczOo/4+YCf+TOUgTVZDhuvie7S7LiLQ9NZWVs9oTajo5/ChvlM
	 91ZL6NwaBBlOL/90LLTQ8/fAAg1wGO0JKOLpPTYqmIfT9Ahjw9c3oAiNrbCykD1cq0
	 ehQ/t+C34kLXQBTZo559nK6dwW7EGb1stKoIebxlpAZ6W1hBO9223urgD4FO/qwZL7
	 bu/hvXG4QGb8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 28/29] KVM: s390: arm64: Integrate arm on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260918133107.1042730-29-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-29-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:11:11 +0000
Message-Id: <20260918181111.959AC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kconfig: HAS_IOMEM dependency unintentionally breaks native s390 K=
VM
- [Low] kbuild: duplicate symbol exports and tracepoint conflicts in kvm-ar=
m64
--

commit 884410e372d8436737ad12a739eafeab45f8d49c
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Integrate arm on s390

This commit adds the Kbuild and Makefile configurations necessary to build a
second KVM module on s390 that implements the arm64-KVM API. It introduces
symbol mangling for built-in compilation to prevent conflicts with kvm-s390,
and it forces the KBUILD_MODNAME to kvm-arm64 to handle module parameters
correctly.

> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index a6ff2e5aa19b7..4e060185c2fb3 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -19,6 +19,7 @@ if VIRTUALIZATION
>  config KVM
>  	def_tristate y
>  	prompt "Kernel-based Virtual Machine (KVM) support"
> +	depends on HAS_IOMEM

[Severity: High]
Could this new dependency on HAS_IOMEM unintentionally break backwards
compatibility for native s390 KVM?

On the s390 architecture, HAS_IOMEM is defined strictly as PCI support.

If a user disables PCI, HAS_IOMEM evaluates to false, making the entire KVM
subsystem unselectable.

Native s390 KVM does not actually require PCI support to function properly.

>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select KVM_ASYNC_PF
=20
[ ... ]

> diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
> new file mode 100644
> index 0000000000000..bd78d64939d1a
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/Makefile
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +KVM :=3D ../../../../virt/kvm

[ ... ]

> +kvm-arm64-obj :=3D \
> +	arm.o \
> +	guest.o \
> +	handle_exit.o \
> +	inject_fault.o \
> +	mmio.o \
> +	mmu.o \
> +	reset.o \
> +
> +kvm-arm64-obj +=3D $(patsubst %.o,%-arm64.o,$(kvm-y))

[Severity: Low]
Will this pattern force generic kvm files, which contain exported macros and
tracepoint definitions, to be compiled a second time?

This can lead to the kernel build failing during the modpost phase due to
duplicate exported symbols.

> +kvm-arm64-obj +=3D $(patsubst %.o,%-arm64.o,$(gmap-y))
> +
> +targets +=3D $(kvm-arm64-obj)
> +
> +$(obj)/%-arm64.o: $(src)/%.c FORCE
> +	@mkdir -p $(dir $@)
> +	$(call if_changed_rule,cc_o_c)
> +
> +ifeq ($(CONFIG_KVM),m)
> +
> +kvm-arm64-y =3D $(kvm-arm64-obj)

[Severity: Low]
Is it intentional that no symbol localization is attempted here for the
module case?

This seems to guarantee a module namespace conflict. Both kvm.ko and
kvm-arm64.ko will globally export the same tracepoints.

> +
> +else ifeq ($(CONFIG_KVM),y)

[ ... ]

> +define rule_oc_o_o
> +	$(call cmd_and_savecmd,objcopy)
> +	$(call cmd,gen_objtooldep)
> +	$(call cmd,gen_symversions_o)
> +endef
> +
> +OBJCOPYFLAGS_kvm-namespaced.o :=3D -O $(LD_BFD) --localize-symbols=3D$(o=
bj)/kvm_symbol_list
> +$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_lis=
t FORCE
> +	$(call if_changed_rule,oc_o_o)

[Severity: Low]
Can this objcopy command create a state that modpost will reject when
checking the vmlinux binary?

While this transforms target symbols to local, it preserves the
.export_symbol structures.

Modpost intentionally terminates the build when it encounters local symbols
that have .export_symbol sections.

> +
> +kvm-arm64-y =3D kvm-namespaced.o
> +
> +targets +=3D kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
> +
> +endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D28
