Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB2231C91;
	Mon, 27 Jul 2026 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163155; cv=none; b=QUbXcT/HwY9b4I1gfenxTO2PG8HMRsg4nHuPopWNWq+EW6jEcxL3/IbHEiw+yiGXdaPsI3zBnJcF6jgG6wJzu8bFDIxAwz6uQYOhm1xkH0yur7R8QUq+uD2TkMUl4SMOoxWUcQO2zy2FlDA9Y1zJrXPtSxexYfdmYabrUy0YPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163155; c=relaxed/simple;
	bh=RuYpqAkfFcT+PVJbM/Z6In3WTvF+D73FBruw37mysvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X/+Zgsoaj1IhI5eO2rtjWL7mny8fAaO30d2Y1fnRPR7ulgRh1q637AUC18VUCFa6V0inHk74CfSIJ1MJcsDOZsNAYkRg3W0cI2ZTUZEKSanQUrDWwa4152NUpir8gE5K7fPeR/HNXjDXvpf/CZ3rO2nvjwqRq7RuhKpDdkiC324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk4W7rax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk4W7rax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494471F00A3D;
	Mon, 27 Jul 2026 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163154;
	bh=NB4EiCMHabLPNeDZgMlKkQFwbg4/ngB3CKZgLQIk1vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kk4W7raxj9gwhw0gDSI0JWtykdM3Ev23d1Wfm8ge3+mgQdfDLUQ0lWphUqtiAg6vS
	 3fCEWYt++tIcV6VgGlDYsYg3De8oPoMUo5Vm1kwHD0PODSDfXjsIsk0bkOZlFiaqRk
	 tq6Y3+TI2LILvl/O7AWpf2BsAuUW59bqDR3bN+jmU2Cy67o+9lOQOnki9uAjCurnOx
	 5bK3fD/rl2Qs6jZptaLrn8O8UbAfVtM1CUGbpMQSXugjvDg5RU7EdkEd8EL2etcs+R
	 FSvyl+JKrAAP0lXgS7/h9lUZd6cQN9RGI+Wr6dXtA0Ug+qmyzRduApxof+afhKYjYH
	 Byetd9gSYZqYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] s390/tools: Pass symbol name to do_relocs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260727140514.116501-2-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:39:13 +0000
Message-Id: <20260727143914.494471F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect error message when reading string tables in `read_strtabs=
`.
--

--- Patch [1]: [PATCH v2 1/6] s390/tools: Pass symbol name to do_relocs() -=
--
commit e68500dff60fecd07a80700fe6440eb03ef64800
Author: Heiko Carstens <hca@linux.ibm.com>

s390/tools: Pass symbol name to do_relocs()

This commit updates the s390 relocs tool to pass the symbol name to
do_relocs() in preparation for kCFI support. It adds additional ELF
processing code from the x86 relocs tool to accomplish this.

> diff --git a/arch/s390/tools/relocs.c b/arch/s390/tools/relocs.c
> index 30a732c808f35..a2774176d38fd 100644
> --- a/arch/s390/tools/relocs.c
> +++ b/arch/s390/tools/relocs.c

[ ... ]

> @@ -216,6 +266,81 @@ static void read_shdrs(FILE *fp)
> =20
>  }
> =20
> +static void read_strtabs(FILE *fp)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < shnum; i++) {
> +		struct section *sec =3D &secs[i];
> +
> +		if (sec->shdr.sh_type !=3D SHT_STRTAB)
> +			continue;
> +
> +		sec->strtab =3D malloc(sec->shdr.sh_size);
> +		if (!sec->strtab)
> +			die("malloc of %" FMT " bytes for strtab failed\n", sec->shdr.sh_size=
);
> +
> +		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
> +			die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(er=
rno));
> +
> +		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp) !=3D sec->shdr.sh_siz=
e)
> +			die("Cannot read symbol table: %s\n", strerror(errno));

[Severity: Low]
Does this error message have a copy-paste error? Since this is failing insi=
de
read_strtabs(), it should probably say "Cannot read string table" instead of
"Cannot read symbol table".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727140514.1165=
01-1-hca@linux.ibm.com?part=3D1
