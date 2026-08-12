Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268F37756A
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556906; cv=none; b=oCVj8np22vUIGnVshwRrS6nHlNvPo6q8qjhwvFNSIVOzn+ZzdBwFPNf9zPF2Rg0G51Rd+h4iAGeU8qrwGBPp+rxl4IqeIOUadBeLZpiMqRVxL9I9USRE1IEX/jsho+aztV4B4fN5cnXtrjCXuPpth730U4xItZV7LPa5YT4ITis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556906; c=relaxed/simple;
	bh=sBwCyvVQn3wFiro2LbOcyIZoAMjr4tl5XhyQbQO8CnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HL7t9qoGr1UfoU17Yln5OhgFdjx39Kz7s6gtUPZhYAp+EHc4Mvl374+UqzZoSurZ8tI2W0MK0rnZK537hnKfFCV5dzonHuE1CbWPqE4XX3aIX+lQqWW3tBJMcIITpa7tmYXabd9lPdTxR+lwONOSA8E8UbJJPnGtR/W91N3OZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgPMHExD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgPMHExD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443B81F000E9;
	Wed, 12 Aug 2026 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556904;
	bh=OQr8XDnHahclKnEEgpL2hsiJ/a9wnZoX0+NWF7msajk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OgPMHExDiCIDtx92kAiWEWrQsyKWhi0tuEzO23Q14v3o1ii2ro9Zu/yhcQnJQs8no
	 7XNnC590SQdf7JgLwCGha2XnY2bN+GRrxtgKKB3xb1Xd4KfLuh1c2wgqbgWi5liRkY
	 IS/9eCVHl/h2tYvgclCu/hOv9LBrwYBikTH7qGCXcAE4zzi35uQMciMF+qwSvM62zj
	 kMtBbsoD8gvqmlC2OqvThvy8NSH6OzQBNkim0QD511sBUMbbprBAJ4ZwWuIxW3X1vK
	 rtTO9rGQ0Ua08OF7h92mPwlnscnMQ27OBtpWilympePaa0KNYj+Hq71vDkiycUaXwb
	 QX0R1TMz64qYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/13] sparc: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-6-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-6-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:48:23 +0000
Message-Id: <20260812174824.443B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing Makefile dependency on syscall_common.tbl causes stale buil=
ds.
--

--- Patch [6]: [PATCH v5 06/13] sparc: Use the common syscall table ---
commit 3c949c999a9aab298b7fdff67ab7b414943dbcad
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

sparc: Use the common syscall table

This commit updates the sparc architecture to use the common syscall number
table to remove duplicated code. It modifies the Makefile to pass the common
table to the syscall generation scripts.

> diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/sysc=
alls/Makefile
> index 8440c16dfb225..c6d6378f7aefc 100644
> --- a/arch/sparc/kernel/syscalls/Makefile
> +++ b/arch/sparc/kernel/syscalls/Makefile
[ ... ]
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --emit-nr --abis common,$=
* $< $@
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --emit-nr --abis $(abis),=
$* \
> +		   --common-tbl $(syscalltbl_common) $< $@
> =20
>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis $(abis),$* \
> +		   --common-tbl $(syscalltbl_common) $< $@
> =20
>  $(uapi)/unistd_%.h: $(syscall) $(syshdr) FORCE
>  	$(call if_changed,syshdr)

[Severity: Low]
Does this generation target need $(syscalltbl_common) added to its
prerequisite list?

Since the syshdr and systbl scripts now read from $(syscalltbl_common), not
including it as a prerequisite means the sparc syscall headers might not be
rebuilt during an incremental build when scripts/syscall_common.tbl is upda=
ted.
The if_changed macro relies on explicit prerequisites to populate $? and
detect changed input files.

Would it make sense to add it here, and also for the $(kapi)/syscall_table_=
%.h
target just below it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D6
