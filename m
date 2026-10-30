Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793402996;
	b=g6w28iW00FCH/LtmW+7ds+BR6/cr1tAaPApPnDUNKRhVCgm8TNeEIcCid5G9Lu6n1pUn
	 UxfZdc4ZGgqjeAjCSJPX1SWsPrxrSIdkWh6Athzz5FfDL2o9BZ92TqhGfLPJE6FO9XIY/
	 7VIKJNBsytZAQfbVVPX2yxWSETx3QPC2bTMyVqcmvF5aE51WZhUElO6Ge9PhKzhLQSIJa
	 9B04rORDMzF3EVGcwXhUE/dFZHPkp3OkUGmwcYPAtWLzgM5M72cmFO44/joZ9LxHiMog6
	 vzZwh5D6ftH5AmpWrQkOekNvdbpYvzXQDddM3LeJ5Zw0XEslaN3DsFu4rmkrCG2hdRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402996;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BLVQYcC5uqP+sgkk0aa1dTKDAmMaMJXS9oCJGifXySk=;
	b=xk5hy4txH2bwToYAQU23jGw9pyt8IGkLCApKuK9oBv7CEHUja86cq58J27ZOFuGC2E2q
	 Ruq/Ly7SDXLtUOMvrOeMnOnSC9m23l5a7Ux1kXHAskbAnSvPkZ17S4O7KlwW56TjswWAk
	 J4Ye++1L6VQQyQ0MifsIg6ZsHcffGPOmafwwT/quTA30e7UnBpcoDlWjRHzzgMWVzo1mg
	 maZpDTt7DJ6CSDmil3MgF1K5atAm35nz14YSPaDy75tM/p01WPW+lDrtlU3nfVFAyWhKq
	 72wD/mwxL3/eHiRB1soHvV9eY6WkS/URDNah+GAg4n/cGGGqFQoGM1SGqeFSMVh1VIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dxC0ry/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8B606A31A
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxC0ry/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596131F000C1;
	Fri, 30 Oct 2026 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793402995;
	bh=BLVQYcC5uqP+sgkk0aa1dTKDAmMaMJXS9oCJGifXySk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxC0ry/IpBeO5OfbacQUPLHEIj0oC2ZOC7xXZIDYk6msqCenmaZdXDhto5CtPuGDj
	 V2rlhgbGTXEM64k3hmixqZm5lIbq3DfJNSef1yevrPRTw9sqKmHWiY+u5/nT1HZUN7
	 ErEzF90YIn6E9zJ4+ac85aOZHzTo+wj3epqKmEsJg7SrCx3TmhQ1LcPOqVzjwRH6lj
	 +LDvaTd1cE21PaiqQ9cxfPWVMhZX7BltQ/fZoiI0H2MAIVorzSyKLpxuGYZTIEQ2kx
	 +oZ69G4FR92bW5tjLlJcqD+V1me1M3329GGH9q+DZt8GkuiDYQOHeyNpHdf9iXs+Bv
	 07obPVNbxjPfg==
Message-ID: <sashiko-outbox-191634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: add CFI directives for call_on_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stephen Brennan" <stephen.s.brennan@oracle.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
References: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 23:29:54 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When debugging s390 on drgn, we experience two issues. First, when a
> panic is triggered on CPU 0, drgn is unable to unwind past a stack
> switching event[1,2]. Second, drgn is unable to unwind through an
> interrupt exception frame.
>=20
> It turns out that the reason for both is the generated call_on_stack()
> assembly. It modifies %r15 (the stack pointer) without any CFI
> directives describing this change. Thus, the compiler-generated CFI is
> wrong, and drgn tries to unwind using rules based on the wrong SP value.
>=20
> To resolve this, use %r10 (a callee-saved register) to store the CFA in
> a temporary register. Then, emit a CFI directive describing the change.
> So long as DWARF CFI is used to unwind all leaf functions, the value of
> %r10 should be recoverable, and unwinders will be able to use it to
> determine the CFA and continue to the new stack.
>=20
> I've tested this only in a QEMU VM using drgn's vmtest framework.
> With the patch, drgn is able to unwind through two stack changes: the
> change to the IRQ stack, and the change to the CPU0 nodat_stack during a
> panic on CPU 0.
>=20
> [1]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b509=
7fcef9f61/vmtest/enter_kdump.py#L69-L74
> [2]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b509=
7fcef9f61/tests/linux_kernel/vmcore/test_vmcore.py#L19-L25
>=20
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030231714.1319=
773-1-stephen.s.brennan@oracle.com?part=3D1

