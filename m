Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C183ACF04;
	Wed, 12 Aug 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553955; cv=none; b=Ms4vE8LMPhwBHl5eJ2x5XyXHAh7kmre3c4mI4pKCjBQSr19fNkh2jOIpaTYt5tpbV3pnnnA27IcAVCHy64kiv7Lh97AEktVgiJFvlgLlPE+nLX5pPOv3/aFMblc8qFIVusTaF1gpl70c0Z5Wz/FtJWn8f2EOrFhNjxynyV6VruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553955; c=relaxed/simple;
	bh=E3vInNis2xJIkjOjFjpgtJI9yDD7vXEo4llG/3S6xYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8gS5PwSyfc7KFITOVnID/4pX7wv9Euly9r/Cw3bSZY0Jj3+vpyirYHs+DsBl4pNX/NarE/cCIO+pekrRh4R2M5zi1DrQfCqr590aN3WsN+yO8PtV1rs/dZOdeud9D05J3sE/pKaiyR628QG9vn3qrk+ScKYm3aqCKnDOx8cRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH0qmu4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH0qmu4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7351F000E9;
	Wed, 12 Aug 2026 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553951;
	bh=3V0itp+OJ0kUUqTzHdPrFG5f0jqkDgW+cSWJ4Nzqk88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SH0qmu4BuxQfRTkpLfJh5QIBjR1PpSgRjj6btY05d3f1nHzFoJylIKgykz7VYOMUg
	 3yWfKV9aT6F/y+IBXyhWvVr/pjBuo4Q/6iAHnsOS21eUwyyr77zPpwMqnNHyMlXRdT
	 9iOdptDSpZyj36Cs9BXOoL+K+ZZOq9s40ue4IYUAceKr7bym9KqGQWfMByGzdVYKRf
	 QxpxHO97zYh8WwKMGdiNMrJAmpiOLURUTAVV37PRR4vpCVwFBeoye6Cj6lIiATDeeW
	 yW9ltEf+R2Wfx883xTDlAKQijiLljd5x/9UHmG/FvcvdT7xjjZe9Pu0qEUZyAOFCtC
	 N2rN7z7D+ayIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 33/33] KVM: s390: arm64: Enable KVM_ARM64 config and
 Kbuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260812153631.3376090-34-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-34-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:59:10 +0000
Message-Id: <20260812165910.AB7351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Trace event name collisions completely break tracing for the kvm=
-arm64 subsystem.
- [Low] The `$(NM) -jU` command is incompatible with GNU nm, causing build =
failures.
- [Low] The Makefile passes `-O default` to `objcopy`, which is an invalid =
BFD target.
--

--- Patch [33]: [PATCH v6 33/33] KVM: s390: arm64: Enable KVM_ARM64 config =
and Kbuild ---
commit 9d8a545589b9d6b384f0fa20e8bcb8b16fc11bd1
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

Adds Kbuild/Makefile configurations to build a second KVM module on s390
implementing the arm64-KVM API. To prevent symbol conflicts with kvm-s390,
internal symbols in kvm-arm64 are mangled if compiled as built-in.

> diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
> new file mode 100644
> index 0000000000000..2ae4a5624151d
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/Makefile
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +KVM :=3D ../../../../virt/kvm
> +include $(srctree)/virt/kvm/Makefile.kvm
> +include $(srctree)/arch/s390/kvm/gmap/Makefile
> +include $(src)/Makefile.gen
> +
> +ccflags-y +=3D -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/s390/kvm=
/gmap -DKVM_S390_ARM64
> +
> +kvm-arm64-obj :=3D \
> +	arm.o \
> +	guest.o \
> +	handle_exit.o \
> +	inject_fault.o \
> +	mmu.o \
> +	mmio.o \
> +	reset.o \
> +
> +kvm-arm64-obj +=3D $(patsubst %.o,%-arm64.o,$(kvm-y))

[Severity: Medium]
Because kvm_main.c is compiled into both the s390 kvm.ko and kvm-arm64.ko
modules, it includes the trace headers with TRACE_SYSTEM kvm. Does this mean
both modules will generate trace event structures mapped to the exact same
system and event names? If eventfs processes these tracepoints during module
load, could the kvm-arm64 trace events be permanently shadowed by the kvm
subsystem's events?

[ ... ]
> +prereq-o-cmd =3D $(foreach o, $(filter %.o, $^), $(dir $(o)).$(notdir $(=
o)).cmd)
> +cmd_gen_symversions_o =3D \
> +	grep --no-filename "^\#SYMVER" $(prereq-o-cmd) >> $(dot-target).cmd || =
true
> +
> +define rule_ld_o_o
> +	$(call cmd_and_savecmd,ld)
> +	$(call cmd,gen_symversions_o)
> +endef
> +
> +LDFLAGS_kvm-unnamespaced.o :=3D -r --whole-archive
> +$(obj)/kvm-unnamespaced.o: $(addprefix $(obj)/,$(kvm-arm64-obj)) FORCE
> +	$(call if_changed_rule,ld_o_o)
> +
> +quiet_cmd_nm_filter =3D NMFLTR  $@
> +	cmd_nm_filter =3D $(NM) -jU $< | sort -u > $@

[Severity: Low]
Are the -j and -U flags compatible with standard GNU nm? GNU nm does not
support these flags natively and requires --defined-only instead. Will this
cause a build failure on systems using standard GCC/binutils toolchains?

> +
> +$(obj)/kvm_symbol_list: $(obj)/kvm-unnamespaced.o FORCE
> +	$(call if_changed,nm_filter)
> +
> +define rule_oc_o_o
> +	$(call cmd_and_savecmd,objcopy)
> +	$(call cmd,gen_objtooldep)
> +	$(call cmd,gen_symversions_o)
> +endef
> +
> +OBJCOPYFLAGS_kvm-namespaced.o :=3D -O default --localize-symbols=3D$(obj=
)/kvm_symbol_list

[Severity: Low]
Is default a valid BFD architecture/target name for objcopy? GNU objcopy
strictly requires a recognized target like elf64-s390, or for the -O flag to
be omitted entirely to preserve the input format. Could this cause a fatal
invalid bfd target error?

> +$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_lis=
t FORCE
> +	$(call if_changed_rule,oc_o_o)
> +
> +kvm-arm64-y =3D kvm-namespaced.o
> +
> +targets +=3D kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
> +
> +endif
> +
> +obj-$(CONFIG_KVM_ARM64) +=3D kvm-arm64.o

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D33
