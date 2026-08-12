Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C16395D8B
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557220; cv=none; b=RZLYviHMU/t8XfIQMqnrdIqYrn5Pdv/DpBxWD86x82BqTF5wLrwKfle2McgqwJOrfzBWZni2+RMhYyZaOhVrU4vI5VyEE6v3unv43NRbJL0wnf0zhu+G3SdfwwIIt34JH9P5I4J9EE3WKQwd7HfT6pTyNxCCV797m43N6HkUrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557220; c=relaxed/simple;
	bh=O+nSjQKOfnicyh7FJxyR5IdVr23uR35tZEkoi7g2lF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UqlMx2JmUomCzFajJUdLA5nNsD5scgfOTdiFQtI+1ExadLpMFPe538oQG1RrCUbjupcznmSvJIS3Gr+KzptU+61UwsFCHGz92FKT1/YQjJ15LxiVU3svwYHXIY7rb9n5EhLttL2G+j45K4MyLKxFcaVs+hY7in4LL2CZEdrOuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRjf6XWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRjf6XWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9D11F000E9;
	Wed, 12 Aug 2026 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557219;
	bh=OcRjWiRGKzVPXcSRO+pXwq+To24mMBDsOi0lw8OGnAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRjf6XWkFRU2quS2OVAFfBTr533FhNTpxVTjtM6814SjCWJF6FouXvVgnDb0jmwff
	 GXx77OYYUl8mgpv7L2eUJ+gVxu7vf/eBiaGOB0idm03VOKU0zetUvkD77jVKS1bb1c
	 /cszXQly4bLCJrPBVTYnhA8fLXAV5PY5wsdS30kayJ9ai0QWkhc2kM50e4R2H/iAqQ
	 rPV5w1xLyR80BWPDNlhkPBnY+zapj08cIL6gC+KzeotRWlm4WAjQNeefiCLL2UH2Z+
	 HGNMFBmn/MwfJd1S7wZA0K6ZzxAqoEsCVmz+S9HHxI3r208/73EYpRoRtIgFESnbWY
	 +ofi9dEBv4WpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/13] mips: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-9-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-9-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:53:38 +0000
Message-Id: <20260812175338.AB9D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure for MIPS N32 and N64 ABIs due to missing prerequisite=
s and incorrect script arguments in Makefile, as well as broken incremental=
 builds.
--

--- Patch [9]: [PATCH v5 09/13] mips: Use the common syscall table ---
commit 42dc635e6909962793a0c1f2315995398f780f3d
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

mips: Use the common syscall table

This commit merges the n32 and n64 syscall tables into a single table and
updates the toolchain to use this common table. It also drops duplicated
code and modifies the MIPS build Makefile to adapt to these changes.

> diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscal=
ls/Makefile
> index 1bfc2346d1009..f6a41ee9e38ad 100644
> --- a/arch/mips/kernel/syscalls/Makefile
> +++ b/arch/mips/kernel/syscalls/Makefile
> @@ -7,16 +7,21 @@ $(shell mkdir -p $(uapi) $(kapi))
>  syshdr :=3D $(srctree)/scripts/syscallhdr.sh
>  sysnr :=3D $(srctree)/scripts/syscallnr.sh
>  systbl :=3D $(srctree)/scripts/syscalltbl.sh
> +systbl_common :=3D $(srctree)/scripts/syscall_common.tbl
> =20
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux $< $@
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux \
> +		   --common-tbl $(systbl_common) \
> +		   --abis $(abis_$*) $< $@

[Severity: Low]
Does this cause the build script to fail for n32 and n64? The cmd_syshdr
command still references $<. In the $(uapi)/unistd_%.h rule below, this
evaluates to $(src)/syscall_%.tbl, which no longer exists for those ABIs.

>  quiet_cmd_sysnr =3D SYSNR   $@
>        cmd_sysnr =3D $(CONFIG_SHELL) $(sysnr) \
>  		  --prefix $(sysnr_pfx_$(basetarget))_Linux_ $< $@
> =20
>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) $< $@
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) \
> +		   --common-tbl $(systbl_common) \
> +		   --abis $(abis_$*) $(src_$*) $@
> =20
>  $(uapi)/unistd_%.h: $(src)/syscall_%.tbl $(syshdr) FORCE
>  	$(call if_changed,syshdr)

[Severity: Low]
Will this rule break since it still relies on $(src)/syscall_%.tbl? Since
syscall_n32.tbl and syscall_n64.tbl were deleted, this might cause make
to fail when attempting to build the uapi headers.

> @@ -25,10 +30,20 @@ sysnr_pfx_unistd_nr_n32 :=3D N32
>  sysnr_pfx_unistd_nr_n64 :=3D 64
>  sysnr_pfx_unistd_nr_o32 :=3D O32
> =20
> -$(kapi)/unistd_nr_%.h: $(src)/syscall_%.tbl $(sysnr) FORCE
> +abis :=3D common,__clone3
> +
> +abis_n32 :=3D $(abis),32
> +abis_o32 :=3D $(abis),32
> +abis_n64 :=3D $(abis),64
> +
> +src_n32 :=3D $(src)/syscall_n.tbl
> +src_n64 :=3D $(src)/syscall_n.tbl
> +src_o32 :=3D $(src)/syscall_o32.tbl
> +
> +$(kapi)/unistd_nr_%.h: $(systbl_common) $(sysnr) FORCE
>  	$(call if_changed,sysnr)
> =20
> -$(kapi)/syscall_table_%.h: $(src)/syscall_%.tbl $(systbl) FORCE
> +$(kapi)/syscall_table_%.h: $(systbl) FORCE
>  	$(call if_changed,systbl)

[Severity: Low]
Can removing the $(src)/syscall_%.tbl dependency break incremental builds?
It appears that if the source table is modified, this rule will no longer
trigger a rebuild of the syscall_table_%.h header.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D9
