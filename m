Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF13B05AB;
	Fri, 31 Jul 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507945; cv=none; b=I6AclccQm5xBRBBYf10n6ww2FMOIGW4xiHBRm/lKhhevtwlZWo1RPlzxAH15ZyZGdacgu5pUaX9CXypW1hLx5YVFS8aSVxXr/UZAsNb1zUMEr4Q2hMSUtLPqLlTU+tCgsemWkKX9jOeJbSo63Syeb4e5+s6x4j75ESQVJyKKkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507945; c=relaxed/simple;
	bh=6jgJINs6Tt1dNckPgfIzS+USzWrjFh4HSIcAcZP5DmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nmm1N88FmWgFmtTubQ0s6OZPP8c9+wnYkzhJEi+Rc8KjS0BsDm0iPZlbbo5lY7xPuOscGG7tnFchL5Syh5Ob5h2pujkn7TfY4NBQQOnYz0e5mixgWsLVq9UgWl3C+UX6teDQ1VVs/PBw0jXbzfI2NLN5ExbDukBUmr1d0qrVWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZTvddFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZTvddFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42B91F000E9;
	Fri, 31 Jul 2026 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507944;
	bh=G9/UKtaQ7R4m+2JLDkju2rtHZrNQUyU5P6SXDg1joPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZTvddFqcgePJxgrJw79Ooa2GjEpjZLD8DeoB7tXywhOUjYSMPFUf/9NT8JuuKk7P
	 MF+z7gVmi+ceafBIChWh/0cnOmzcbwZQ4AHHuu7XtgDibyY94ub1U+zGw4Iw4NgBY7
	 ilvbmrnc+pLc/ppdqAf0oL3wBqDC5/NuXPXHwovzT69+rvSuWz6AeMSntbjNdTyQNu
	 uXqJks7gLzVddtdFs9SxLfuqlwjE7BeU0bCN3djCP4NFN62jCBs1F2lLRAig3w6Uhp
	 oo+z2HXHWmFQDeT6kxqqnyupKwkJ32u07fjTqkDRveKEtHPZbhcasMmd+3EcJQgiIK
	 TdxUoVz5a2qWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 31/31] KVM: s390: arm64: Enable KVM_ARM64 config and
 Kbuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731130902.654679-32-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-32-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:25:43 +0000
Message-Id: <20260731142543.D42B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The namespace-mangling logic for built-in compilation (CONFIG_KVM_A=
RM64=3Dy) uses invalid toolchain flags and incorrectly localizes exported s=
ymbols, breaking the build.
- [Low] Duplicate exported symbols cause a fatal modpost failure when both =
KVM modules are compiled as loadable modules (CONFIG_KVM_ARM64=3Dm and CONF=
IG_KVM_S390=3Dm).
--

--- Patch [31]: [PATCH v5 31/31] KVM: s390: arm64: Enable KVM_ARM64 config =
and Kbuild ---
commit c83e4eeb21e3c1207840240024b39a24634ecae4
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

Add all Kbuild/Makefile configurations to build a second KVM module on
s390 implementing the arm64-KVM API. To prevent symbol conflicts with
kvm-s390 all internal symbols in kvm-arm64 are mangled if compiled as
built-in.

> diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
> new file mode 100644
> index 0000000000000..a102c35664cae
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/Makefile
[ ... ]
> +ifeq ($(CONFIG_KVM_ARM64),m)
> +
> +kvm-arm64-y =3D $(kvm-arm64-obj)

[Severity: Low]
Does this module build lead to identical global exported symbols?

If both CONFIG_KVM_ARM64=3Dm and CONFIG_KVM_S390=3Dm are selected, both mod=
ules
include the core virt/kvm files without symbol localization, which causes a
fatal modpost failure due to duplicate EXPORT_SYMBOL definitions.

> +
> +else ifeq ($(CONFIG_KVM_ARM64),y)
[ ... ]
> +quiet_cmd_nm_filter =3D NMFLTR  $@
> +	cmd_nm_filter =3D $(NM) -jU $< | sort -u > $@

[Severity: Low]
Are the -jU flags supported by GNU nm? Using unsupported flags causes a
fatal build error here.

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
Is -O default a valid objcopy flag?

Additionally, does this incorrectly localize exported symbols? This breaks
the build by causing modpost to abort.

> +$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_lis=
t FORCE
> +	$(call if_changed_rule,oc_o_o)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D31
