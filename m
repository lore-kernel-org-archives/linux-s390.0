Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD94D2EF8
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559576; cv=none; b=PglUnYdGOC8CswE3epuOaHj9aLwLQ/nbT0s5gT+n8tpEBepnrKbiZzKZCki8g9JH9fwk1icmknCil/ijRn0cR1rphFFGAq2DovS5MbpizGWL7YpwxKlBktz4V8UYAWeFjh8bgeb5x6+nDFgVJhHKcit7BPa8JhydO0NIsn/hKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559576; c=relaxed/simple;
	bh=qXgyhNC78TGYpbnGOUITp9psaQedEwLYmwaW25pSl3g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=atPmboUSw5SpWu5SQ3jnxyh5F606CMgbyWoCLDA3ZQMnxpnpl7iBg63OsL2i1hhIiABOkscwlDfJXjJ3Wdcd8LYFCgFtSPWg2X5aysstmGOGvg4SN89B8w4DIMDjYCmzmmbsICUkZBo39mIKUeqb5zucPcObVn6koOES4VqIkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMQaST1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMQaST1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC041F00893;
	Fri,  9 Oct 2026 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559575;
	bh=qXgyhNC78TGYpbnGOUITp9psaQedEwLYmwaW25pSl3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMQaST1PSCAnlKlxGX99WRyCfNVigmvTFHFsY5kJOPNhQTVH+eDvHoODHdiptLhXt
	 e8UR5soMevhm0SybG+ErBQtWN3xZTubj3r1gW5Ok26cn/4+/9c6W887rC09RGasRdn
	 BB0URcXvouAbNX7AcSoG/Nf89kP3e0IWZynIzR9E7puuMwAxfXlpMh1RGnikyue9mc
	 i8qUiobnabf7tXa1/C6wfute932Tu9FE0v0dmSq2gZwvOEvBuMIuvVtewEqtNCtKvj
	 2DsQQwnRpKvjV1BzjVm6mWqrxF1C6DVm4FR9GwvoEZDP9PnOFn5/7YYuPPCvXroBvi
	 8i4xsItNWgiKA==
Message-ID: <sashiko-outbox-165771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/ptrace: Preserve ILC when updating system call
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261009152132.1113325-1-hca@linux.ibm.com>
References: <20261009152132.1113325-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:26:14 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When an attached debugger changes gpr2 via PTRACE_POKEUSR while the
> traced process has PIF_SYSCALL set, the int_code in pt_regs is also
> updated. In case of an svc it contains the instruction length code
> (ILC), as well as the system call number.
>=20
> The ptrace code sets the ILC unconditionally to a value which matches the
> svc instruction. However the svc instruction also may have been executed
> via the execute or execute relative long instruction, which have a
> different length. Therefore preserve the ILC and only change the system
> call number using syscall_set_nr().
>=20
> This makes sure that in case of a PSW rewind the instruction address
> points to the correct instruction.
>=20
> Fixes: 56e62a737028 ("s390: convert to generic entry")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009152132.1113=
325-1-hca@linux.ibm.com?part=3D1

