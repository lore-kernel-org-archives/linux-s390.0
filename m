Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC23DF008;
	Fri, 18 Sep 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742224; cv=none; b=tKLb8DgK109fVC01UbOfylxKHl3LQH+sHxvM+Cinc1tPDdXSg1i8/cc9f94ffEVMU+4S+CVK7O9rjFPvm+8Z1soI6zY7/WJVn8xFadER65btq6rPT6N4rqC4b+8JEy97UGnOoq+Vq8BFZr8qYbY3u1Gy6h0h6fnava8b2Aj537Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742224; c=relaxed/simple;
	bh=ntPS0z+vV0xUCpyNprGPNVKRsReblUECMKWxCnZx8jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqPCkn1Jf2TOEcBYXa3rZliH0P3vb9GUzjCGxzCaLx2SGUq4ceKCBAjuHSWuIRi6k1c1oc2TfXF4AiZlN+W5DbTXLVk2MBL4ZdMYt3yEW/rYpqFQrLFxJ6kZBq0IoGe27/ECtlHb6q95fldCcFAZW5JEkEb3ov+AZwsR02LNflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnKQj0bN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnKQj0bN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670161F000FF;
	Fri, 18 Sep 2026 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742223;
	bh=n7kP1DCQMHPQrreAhxr3a+3LyX8C/Su2w8QZWEiOw4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnKQj0bNjpR1j4YwR3qLJUuCzmkcVj1f8TD7tBhur7zUBXeVdSPk0kNSvg7xlwZt1
	 dC/b7q24xeDlLsZZ5+VwuJo6dnfO+XapYiZfnpCEGre4dnsd9p6/Ecx2V5Iho7koz6
	 Zbjtysy2hEH8VMkvwgy0FMyK8EEM2OvNYz2thy4aJmdm6CZbAaFDqsuHZAtPRRqlCP
	 Abuxmf583o7KxZxeppn3sWJwyEWBSOQ0hyenjMGK3GbrxtW7zmYOcIc2l2MoQGAO35
	 vV8globw6xQwhXtkIWvIi03/3M0Fnwi0aV6R505FzNtZ2X1ig0DZs8TaNaT+pyysBh
	 P+Ze0N9TWZEpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/29] KVM: Move export symbol check macros to
 Makefile.kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-7-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-7-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:37:01 +0000
Message-Id: <20260918143702.670161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: missing arch export symbol check due to $(ARCH) vs $(SRCARCH)
--

commit df2119cb096c289e1baffa51941e2be7e3687ea1
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Move export symbol check macros to Makefile.kvm

The EXPORT_SYMBOL_GPL/EXPORT_SYMBOL enforcement logic in
arch/x86/kvm/Makefile is useful for any KVM architecture wanting to
restrict the exported symbols. Move the check macros to
virt/kvm/Makefile.kvm so they can be shared.

> diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> index d047d4cf58c9f..dd40544b8ecb1 100644
> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm

[ ... ]

> @@ -13,3 +13,36 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) +=3D $(KVM)/irqchip=
.o
>  kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) +=3D $(KVM)/dirty_ring.o
>  kvm-$(CONFIG_HAVE_KVM_PFNCACHE) +=3D $(KVM)/pfncache.o
>  kvm-$(CONFIG_KVM_GUEST_MEMFD) +=3D $(KVM)/guest_memfd.o
> +
> +# Force grep to emit a goofy group separator that can in turn be replace=
d with
> +# the above newline macro (newlines in Make are a nightmare).  Note, gre=
p only
> +# prints the group separator when N lines of context are requested via -=
C,
> +# a.k.a. --NUM.  Simply request zero lines.  Print the separator only af=
ter
> +# filtering out expected exports to avoid extra newlines in the error me=
ssage.
> +define __kvm_get_exports
> +$(shell grep "$(1)" -C0 --include=3D'*.[ch]' -nrw \
> +	$(srctree)/virt/kvm $(srctree)/arch/$(SRCARCH)/kvm \

[Severity: Low]
Does this hardcoded path create a mismatch between the counting and reporti=
ng
phases?

By using $(SRCARCH) here instead of reusing the $(KVM_CHECK_EXPORT_DIRS)
variable, __kvm_get_exports and kvm_check_exports use different source
directories for their grep commands.

> +	$(addprefix | grep -v -e ,$(kvm_exports_allowed)) \
> +	| grep "$(1)" -C0 --group-separator=3D"!SEP!")
> +endef
> +
> +
> +KVM_CHECK_EXPORT_DIRS ?=3D $(srctree)/virt/kvm $(srctree)/arch/$(ARCH)/k=
vm

[Severity: Low]
Will using $(ARCH) instead of $(SRCARCH) cause the check to miss the actual
architecture source directory during compilation?

On architectures like x86_64, $(ARCH) evaluates to x86_64, but the actual
source directory is mapped to arch/x86 (which is what $(SRCARCH) resolves t=
o).

This causes grep inside kvm_check_exports to silently skip arch/x86_64/kvm
because the directory does not exist, missing the EXPORT_SYMBOL validation
entirely for the architecture-specific KVM code.

> +
> +# Fail the build if any unwanted $(1) usage is found outside kvm_exports=
_allowed.
> +define kvm_check_exports
> +kvm_nr_exports :=3D $(shell grep "$(1)" --include=3D'*.[ch]' -nrw \
> +	$(KVM_CHECK_EXPORT_DIRS) \
> +	$(addprefix | grep -v -e ,$(kvm_exports_allowed)) | wc -l)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D6
