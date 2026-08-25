Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ECC332638
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671209; cv=none; b=f80J7bCjuKvLYvoXTGi0r6E5L3EcJxsvf8gig/xBECNSU618o8WWm/s2Wn8G6RQa51xI6gwn5V+zwjSM03dbeoiAGBlTqbyT+ijII7LzDPPoDb2YTc+faUC801ewSMmSLZr046ug1AufGElU0jrd3/2f7RKipRZ37/26U+WqB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671209; c=relaxed/simple;
	bh=VDrwnziu51LCx5yHrcRQF/ZBJnNXph2Vz2yEJ2Xb4CU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rY+gploHCDhnvyuca5IkMrC1je/QAA+JWfK2mXQoJ8F45WFAGWlW1ZH44mJ4527QF7i2dEzDMZOAWJTY0Jj/4RRYDsEM79L+V4pyEbJoMO0wAiJZBy/XXS1+FYwjtzlsBcGK9Sm2x8arT7EEGTmgSjMfjAoJgFmb9xTSR0sTnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om/cEYJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om/cEYJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C71E1F000E9;
	Tue, 25 Aug 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787671207;
	bh=H3xIa8ay/0Zno098RrFRI2/lS8i3ct1fJnsq+JdJbso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Om/cEYJoNSrcCIFVYjYQR4Yqj2gEVQJIOJ9NWWX9iu3kDoab/VHmJu6Uk6m1CacQ9
	 UAmM4YtCxwRTXJ/mEi9lBvcGTqPXsE/zpjFH6gyIesrCasOt+KZ1ZURJWkEnBZ6ifn
	 d9Jfyqeei/+CGkxnSBi00hSWBGjk6RIPF6VBx7iyopcpRX1oloVbk/FlxGvJrUivqU
	 Xla10+6Qhp8FP5LvIw/opcQRQ5xo/u8bnsiaCRPpM8/DcBURYQzEZONhQa9rrXWEIo
	 G7eUr8VFRy5M8tFA7Sz+VNVl2N+dUIyxjN1jgfpyykfBRTXTIFWlehC/HYaAbzxnvr
	 OBXGwd7vMCJbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: Warn if kernel command line contains
 non-printable EBCDIC characters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260825150840.537653-1-iii@linux.ibm.com>
References: <20260825150840.537653-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 15:20:06 +0000
Message-Id: <20260825152007.4C71E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer underflow in size calculation leads to out-of-bounds write=
 when appending IPL block parameters to a maximum-length kernel command lin=
e.
--

--- Patch [1]: [PATCH] s390: Warn if kernel command line contains non-print=
able EBCDIC characters ---
commit 0d3635825635bf3ebe41f7b2b8024aab279b4f38
Author: Ilya Leoshkevich <iii@linux.ibm.com>

s390: Warn if kernel command line contains non-printable EBCDIC characters

This commit adds a warning if the kernel command line contains non-printable
characters after being converted from EBCDIC to ASCII. This helps detect
accidentally pasted multi-byte UTF-8 sequences in zipl.conf that would
otherwise render the entire command line unusable.

> diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
> index 6bc950b92be76..71c0c26d56bba 100644
> --- a/arch/s390/boot/ipl_parm.c
> +++ b/arch/s390/boot/ipl_parm.c

[ ... ]

> @@ -173,12 +173,29 @@ static inline int has_ebcdic_char(const char *str)
>  void setup_boot_command_line(void)
>  {
>  	parmarea.command_line[COMMAND_LINE_SIZE - 1] =3D 0;
>  	/* convert arch command line to ascii if necessary */
> -	if (has_ebcdic_char(parmarea.command_line))
> +	if (has_ebcdic_char(parmarea.command_line)) {
>  		EBCASC(parmarea.command_line, COMMAND_LINE_SIZE);
> +		if (has_nonprintable_char(parmarea.command_line))
> +			boot_warn("Kernel command line was treated as EBCDIC, but contains no=
n-printable characters\n");
> +	}
>  	/* copy arch command line */
>  	strscpy(early_command_line, strim(parmarea.command_line));
> =20

[Severity: High]
This is a pre-existing issue, but since we are dealing with the bounds of
the command line buffer here, could a maximally long command line trigger
a buffer overflow shortly after this point?

Right after the quoted code, setup_boot_command_line() calls
append_ipl_block_parm(), which calculates the remaining space in the buffer:

arch/s390/boot/ipl_parm.c:append_ipl_block_parm() {
    ...
    len =3D strlen(early_command_line);

    delim =3D early_command_line + len;    /* '\0' character position */
    parm =3D early_command_line + len + 1; /* append right after '\0' */
    ...
    rc =3D ipl_block_get_ascii_vmparm(
        parm, COMMAND_LINE_SIZE - len - 1, &ipl_block);
    ...
}

If early_command_line is filled to its maximum capacity (COMMAND_LINE_SIZE =
- 1),
the remaining size passed to ipl_block_get_ascii_vmparm() evaluates to 0.

Inside ipl_block_get_ascii_vmparm(), the size calculation underflows:

arch/s390/kernel/ipl_vmparm.c:ipl_block_get_ascii_vmparm() {
    ...
    len =3D min_t(size_t, size - 1, ipb->ccw.vm_parm_len);
    memcpy(dest, ipb->ccw.vm_parm, len);
}

Because size is 0 and size_t is unsigned, size - 1 underflows to SIZE_MAX.
This bypasses the bounds check and allows the memcpy() to write out of boun=
ds.

The same underflow pattern appears in ipl_block_get_ascii_scpdata():

arch/s390/boot/ipl_parm.c:ipl_block_get_ascii_scpdata() {
    ...
    count =3D min(size - 1, scpdata_length(scp_data, scp_data_len));
    ...
    memcpy(dest, scp_data, count);
}

Should there be a check ensuring size > 0 before calling these functions,
or a safeguard within the get_ascii functions to prevent the underflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825150840.5376=
53-1-iii@linux.ibm.com?part=3D1
