Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB05372F5
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906789; cv=none; b=DRLUF3ulEBojPieUDmnXHj+8enZ7ozYqxPFCOfhw4dIrO/0Usgc2VkCgPnJe6zyJa09FhD7xQ1vmYy/cS/qbEQ0aBGuMZY4GaZoosFcOPvbIj+ahFXuw2VLcwslpuSJThLt2MTg6KgCah/X7+pUIxXBaf65jcq/kGZFZz4O7zRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906789; c=relaxed/simple;
	bh=zf7tb1RehJWB36ccpkcNAQPo32LB71OH8RKjR0roLkY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DuhE3AiS2VG4yhtzfpSlF4jkkyq6QDJARJFprzdPyZSDLJw30lUgXDiL1COBo3rogKsNyjb1H2TRaobcRNLZ1eQFyjj+cJ/6uLlk272l3VhH4jNqkYE/gJBpvHm5+EZgmDOw5zk18atEXZUyQ5cZ1uy6iUIrq3Xo2rB5fZ4nqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyaq2c+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyaq2c+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315E11F00893;
	Tue, 13 Oct 2026 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906788;
	bh=MbtiwVEyWLZG12pb4x4VELcHzzdpmC3QzkQF82SO+kM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyaq2c+oouTOWOvkDjxS4Bgjj/28Ygv/NiGAQwAFsVY7i1FiX9oRNj2r8lID1bfmo
	 p1JEPevwljPqdnhEz1yV5qkLmEJc8QZXKjMq5hjsvi7G+UnxnkFPd50zSEnBh7TKAS
	 7u7fEPNF91xblxZOJ91OPkrJGFpzVb/jOE3QFT/te4pguB+erMNa0+HoN/KOFnOLWM
	 CycqopzgHu/aYm22SYDxFZqJk37NTKbW8Vbeey9vfJbwZJ0W1ey2B0jsynGudn/MFj
	 Dwb28vNLRK4ghBOUaUbm/w6WpkWcAuakj2Pn2nRXPW2jNtIopYqIKdB9tIyQ8VL9ml
	 welp6bGHlVgKA==
Message-ID: <sashiko-outbox-170058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] scsi: zfcp: Fix out-of-bounds read of bogus status
 read buffer length in dbf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ajaykumar Rajappa" <ajaykr@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013154041.393716-1-ajaykr@linux.ibm.com>
References: <20261013154041.393716-1-ajaykr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:53:07 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zfcp_dbf_hba_fsf_uss() and zfcp_dbf_san_in_els() derive the payload
> length to trace from the channel supplied srb->length without checking
> it against the size of the status read buffer. A bogus srb->length makes
> the 16-bit pl_len wrap or exceed the payload array, so the trace code
> may read beyond srb->payload.data. In addition, the u16 pl_len cannot
> represent the original 32-bit srb->length, so the raw value is lost.
>=20
> Add zfcp_dbf_srb_pl_len() to compute pl_len in one place, and use it in
> both trace functions. Check bounds on the full 32-bit srb->length and
> clamp the number of traced payload bytes to FSF_STATUS_READ_PAYLOAD_SIZE.
> An oversized length is thereby not dropped, the readable part is still
> traced.
>=20
> If srb->length is neither 0 nor within header plus payload array size,
> additionally write the raw 32-bit value as a separate "fsf_len" pay
> [ ... ]
>    precedence over pl_len.
>=20
> Fixes: a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA =
records.")
> Fixes: 2c55b750a884 ("[SCSI] zfcp: Redesign of the debug tracing for SAN =
records.")
> Signed-off-by: Ajaykumar Rajappa <ajaykr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013154041.3937=
16-1-ajaykr@linux.ibm.com?part=3D1

