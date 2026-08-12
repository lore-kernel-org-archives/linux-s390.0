Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAB3909A6
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557236; cv=none; b=JGnvOAAYTmJVOhxkTGSBh3kCXjo9PgxYsR/PsH+zUDr/35kHkvYW6/jz8DSD0mJT33Fm8o5prjuAJh8qd3z2t7PaoNcrp/7owYE4q4PxjycXqLmDaggjRV9umoZVJflp/JCH+iSydTpKoQyOuthdK+L4KXximNPLOkHUrEe5B5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557236; c=relaxed/simple;
	bh=Ie5O/sdOLRLpVN4TfJelaxfTYUxflwsOPq7tfEysjW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qt54BWnFYJ45EO5rbSto62NeVd99LOFqMlDd124r22Wp89C3sm4Fvbek8xBpkSYAjPCcSlr432YkxiVJt+r+RXIwx/bhqIiBx8Rva5KnWFHz4BaPfwButopZCJM4E3GQkcq2nxb9pYf6aOq7kzEfg9dABIXGAojKiKMLWhszwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqmQTx8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqmQTx8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD271F000E9;
	Wed, 12 Aug 2026 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557235;
	bh=0jBxzFDHKr9Rr92Up4eg1sd2JfE38SZB6RCP6CaoKLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GqmQTx8JuKkchZ0iz4u7SvKZNF9C4pQEDypEGwePN+CInWeeMvy2WvfHh/rY4hzIB
	 EkYfFzub9o68v0D0vBLYW51jqOoWx+CLZx1+JrJIjyQQuTpSrJUqLlS+OryLPz0XCZ
	 wDAb2slB1XYYwRue5QqtBlm4Ht494u8ZHj45XsygXsBG3p4MQsq/rFVw59nx2/AIQ2
	 ARmcjDb2P1Y2Sd6k20mzovymFSTWWcBZTyexV+DwWg0SgGjhOZtNpd2Z/62sNP/QhR
	 A0thkCmVUOhcCSj9XbExEJ1obrn8vMudLbVNIj1ANRqIkV9jHMRc6oEKVankWWaeab
	 2jya3DgcIY+1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/13] scripts/syscall.tbl: Use the common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812-tonyk-syscall_table-v5-3-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-3-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:53:54 +0000
Message-Id: <20260812175354.EFD271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] POSIX shell syntax violation (`bashism`) causes build failure.
- [High] Sequential table processing breaks strict monotonicity check, prev=
enting architectures from adding new local syscalls.
- [High] Sequential table processing silently truncates `__NR_syscalls`.
- [Medium] Tooling Breakage: `tools/perf` fails to parse common syscalls fo=
r generic architectures.
- [Medium] Missing Make dependency for `syscall_common.tbl` breaks incremen=
tal builds.
--

--- Patch [3]: [PATCH v5 03/13] scripts/syscall.tbl: Use the common table -=
--
commit e407e18fccaf1e26e59809a57f9bedc05e1b414e
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

scripts/syscall.tbl: Use the common table

This commit removes duplicated code by moving common syscall numbers out of
arch/arm64/tools/syscall_32.tbl and scripts/syscall.tbl to a shared common
table.

> diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
> index 8a4856e741803..681713f240cc1 100644
> --- a/scripts/Makefile.asm-headers
> +++ b/scripts/Makefile.asm-headers
> @@ -15,9 +15,10 @@ all:
> =20
>  src :=3D $(srctree)/$(subst /generated,,$(obj))
> =20
> -syscall_abis_32  +=3D common,32
> -syscall_abis_64  +=3D common,64
> +syscall_abis_32  +=3D clone3,common,32
> +syscall_abis_64  +=3D clone3,common,64
>  syscalltbl :=3D $(srctree)/scripts/syscall.tbl
> +syscalltbl_common :=3D $(srctree)/scripts/syscall_common.tbl

[Severity: Medium]
Since syscalltbl_common is introduced here and passed to the generator scri=
pts,
should it also be added to the Make prerequisites?

Currently, targets like unistd_%.h only depend on $(syscalltbl) and $(syshd=
r):

$(obj)/unistd_%.h: $(syscalltbl) $(syshdr) FORCE
	$(call if_changed,syshdr)

Without adding $(syscalltbl_common) to these dependencies, Kbuild won't tri=
gger
a rebuild of the headers when the common table changes, which can break
incremental builds.

>  syshdr-args :=3D --emit-nr
> =20
>  # let architectures override $(syscall_abis_%) and $(syscalltbl)

[ ... ]

> @@ -58,14 +59,14 @@ quiet_cmd_remove =3D REMOVE  $(unwanted)
>        cmd_remove =3D rm -f $(unwanted)
> =20
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) \
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --common-tbl $(syscalltbl=
_common) \

[Severity: High]
Does calling syscallhdr.sh here break on systems where $(CONFIG_SHELL) is d=
ash
(like Debian/Ubuntu)?

scripts/syscallhdr.sh uses a #!/bin/sh shebang but contains bash-specific
process substitution:

    done < <(grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input")

On POSIX-compliant shells, this causes a syntax error ('redirection
unexpected') and aborts the kernel build.

Additionally, does passing --common-tbl silently truncate __NR_syscalls?

When syscallhdr.sh processes the local table first, the global "max" variab=
le
tracks the highest local syscall. But when it processes the common table
afterward, it unconditionally overwrites it:

    max=3D$nr

If an architecture has a local syscall higher than the common table's highe=
st
syscall, max gets incorrectly capped. This results in an incorrect
__NR_syscalls value.

>  		   $(if $(syshdr-args-$*),$(syshdr-args-$*),$(syshdr-args)) \
>  		   $(if $(syscall_compat),--prefix "compat$*_") \
>  		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
>  		   $< $@
> =20
>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) \
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --common-tbl $(syscalltbl=
_common) \

[Severity: High]
Similar to the syshdr script, syscalltbl.sh also contains a bashism:

    done < <(grep -E "^[0-9]+[[:space:]]+$abis" "$input")

Will this sequential processing also break strict monotonicity checks for
architectures adding new local syscalls?

syscalltbl.sh uses a global "nxt" variable to ensure numerical sorting.
If an architecture adds a local syscall > 403 (e.g., 472), "nxt" advances
to 473. When it then processes the common table starting at 403, the check:

    if [ $nxt -gt $nr ]; then
        echo "error: $input: syscall table is not sorted..."

will trigger (473 > 403) and abort the build.

>  		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
>  		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
>  		   $< $@

[ ... ]

> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index 7a42b32b65776..ee828d03094ed 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -344,71 +344,3 @@
>  293	common	rseq				sys_rseq
>  294	common	kexec_file_load			sys_kexec_file_load
>  # 295 through 402 are unassigned to sync up with generic numbers don't u=
se
> -403	32	clock_gettime64			sys_clock_gettime

[Severity: Medium]
Does removing syscalls 403 through 471 from this file break perf trace?

The perf tooling parses this file directly to generate syscall name mapping=
s:

tools/perf/trace/beauty/syscalltbl.sh:
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile"

Since tools/perf/trace/beauty/syscalltbl.sh isn't updated to parse the new
syscall_common.tbl, perf trace will lose name resolution for syscalls >=3D =
403
on architectures using the generic table.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D3
