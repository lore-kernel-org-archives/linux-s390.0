Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A439A7F4;
	Mon, 31 Aug 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214781; cv=none; b=A6XxJjj0GFbNeK2Y17tiIFvaetRgQWCouAY4rIe6cK12cKXYDkZM1vxXclfl2si9w3O/mWzRQkszNhCWMcvQg4UIIrSa3IS/d4YKpObBqe9V3Eaxg85AtAw144mAxmMAdIc5WBEdVl6X1xjjpoqB67IVZXsoCrR/X3MWSRIZaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214781; c=relaxed/simple;
	bh=fqjk0mwJYfvV11rxuexCInrXAiNdz9vmsGSkQ7EQr4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQ0Hkr1/Kb4gFiOxqT4uzcrmHi7k4qRWzs8+3e5uoCBcdMf9ZLapeejp5u2XpmLAaF/WAUHXjliaMDOxfLwUGUFtiLfAiD4FNr9E9/zxU87yE/+nYliZfRQ69ReWVkJqnDK2GqI3ZtgYgQL/zFjGMFAemz3P6HCIKbea5Yi5rVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKOBpWfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKOBpWfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EC11F00A3D;
	Mon, 31 Aug 2026 22:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214780;
	bh=aXjhS3PyFPOiO+XU2jr/4YySrC9tHFyp/AAgxGzQep0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lKOBpWfPRQK7j3eWusRk5F0UHWjOSGMPnXqw1nbgxOA0JiBpea/x3kI4BBbFx3oPM
	 s3491LPhgf1AMzqXlKkSVXcyQXDjJYGKiJulpwgr2wgVq+gcJKgaHhHMfQU25zaZCK
	 lWXwWRRBMV8ruz8YNK/K4+HLntis42ETpeN9EdwCgOlJx0WmbbhYdpSZDDGQ98baaU
	 PH9X1lrR4HmR3ASr8go8tBNhHIKp2PGxjdQMwCpvO9Sy+CY8Cc0C3DCg0h19TBQX05
	 7W8P7HfUg8o+McMmgcSB8dLpbruwQhhNnheciS6NgT2xmScYZsac9uCOG2oI3yxXmg
	 pa/SHv7404A0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig
 and Makefile
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260831144802.834315-24-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-24-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:19:39 +0000
Message-Id: <20260831221939.A9EC11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Duplicate tracepoint registrations due to unmodified TRACE_SYSTE=
M in `virt/kvm/kvm_main.c`.
- [Low] The kvm-arm64 module will fail to build in modpost under all config=
urations (built-in or module) due to EXPORT_SYMBOL conflicts when compiling=
 KVM core files twice.
--

commit faac05d8e4c537c5a5862961cb0c8e0746920675
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile

This commit adds Kbuild and Makefile configurations to build a second KVM
module on s390 implementing the arm64-KVM API. To prevent symbol conflicts
with kvm-s390, internal symbols in kvm-arm64 are mangled if compiled as
built-in. It also overrides KBUILD_MODNAME to fix module parameter handling.

> diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
> new file mode 100644
> index 0000000000000..ae614a62f7b5f
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/Makefile
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

[Severity: Medium]
Does compiling KVM core files a second time cause duplicate tracepoint
registrations?

When virt/kvm/kvm_main.c is compiled again for the kvm-arm64 module, it
instantiates the tracepoint metadata for CREATE_TRACE_POINTS. The linker
will aggregate the .ftrace_events and __tracepoints_ptrs sections, causing
the trace subsystem to attempt registering identical sets of tracepoints
under the same system and name. This will fail with -EEXIST at boot and
leave the tracepoints broken for the new module.

> +kvm-arm64-obj +=3D $(patsubst %.o,%-arm64.o,$(gmap-y))
> +
> +targets +=3D $(kvm-arm64-obj)
> +
> +$(obj)/%-arm64.o: $(src)/%.c FORCE
> +	@mkdir -p $(dir $@)
> +	$(call if_changed_rule,cc_o_c)
> +
> +ifeq ($(CONFIG_KVM_S390_ARM64),m)
> +
> +kvm-arm64-y =3D $(kvm-arm64-obj)

[Severity: Low]
Will this fail to build in modpost when compiled as a module?

When CONFIG_KVM_S390_ARM64=3Dm, Kbuild processes the EXPORT_SYMBOL macros
natively without symbol mangling. Since kvm-arm64.ko and kvm.ko will both
natively export identical KVM core symbols (such as kvm_init), modpost will
fail with duplicate export errors.

> +
> +else ifeq ($(CONFIG_KVM_S390_ARM64),y)
[ ... ]
> +define rule_oc_o_o
> +	$(call cmd_and_savecmd,objcopy)
> +	$(call cmd,gen_objtooldep)
> +	$(call cmd,gen_symversions_o)
> +endef
> +
> +OBJCOPYFLAGS_kvm-namespaced.o :=3D -O $(LD_BFD) --localize-symbols=3D$(o=
bj)/kvm_symbol_list

[Severity: Low]
Will this localization step cause modpost to fail on built-in code?

When compiled with CONFIG_KVM_S390_ARM64=3Dy, objcopy --localize-symbols
localizes all defined symbols. However, modpost strictly rejects exporting
local symbols via __ksymtab entries, which results in errors like
fatal: local symbol 'kvm_init' was exported.

> +$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_lis=
t FORCE
> +	$(call if_changed_rule,oc_o_o)
> +
> +kvm-arm64-y =3D kvm-namespaced.o
> +
> +targets +=3D kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
> +
> +endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D23
