Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384367;
	b=JY8YgIpSM/3h7sGG8DX2H4e78tcQUdHuB8E8U/xixSbp8fJGNWwJi/qk91yAkQhy/T6H
	 WqRXmxLf7iQ4ctFNGENcDayGo0Vr+QyZLAwOnojAcXDczXTaBv8uBs5L7Abhjp76BIhAD
	 wxxeOVVKSeDGPKnCABa9OxsYn+0ECNX68Hlinuz/HEMET5v8ckKg5gbDGT1BVRPCVVuwY
	 XqhtHb3oATETtmag+YA9qAK6MtUaBq4gPPqJPgqCDnd1+u9ifQQn+48lUTm2fQUYz27Zd
	 Znxg8iKArz/PpUa10iwTD5nzlrgHrCuNlOZKdRGcOZhzAA3vbK5y0DVSa2wfcyVbGPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gQfM4/E9kkp+dxCiGlljuM7+HMQTQzN/muuH3WlNtFY=;
	b=ASCNac9qm4j3NxNd1qlCxQ+Tj6kSdOl39KPUZv/TEn5q+zcfBNr5B0RXcFBiESKknxIO
	 H23XR1Rbm8GpggFF27uN6Ahi2cJqF3Cl0puDzyovh8xR1+rltQA3lU+80IhJzYbCyzHDn
	 F6Shu47simDn9b6f+6PbiSFScCP3bH4z2R56dmk534e9fR2P38E1yBMtaBvIVdYmbU4RD
	 zhsVz6wsuAk1ydRcpl9POj/rFi7ffiP0KUZfE7PL2FXEr82DjqT39nUcRf2Fi7a5nJpYm
	 Y3jK7hCIWYtE0IfA/D7vxD9h6vTqVfIEov3SwWORZBw2K9OmItzovche/gKskM0KCIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGAoXJHZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9439606A31A
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGAoXJHZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092151F000C1;
	Fri, 30 Oct 2026 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384366;
	bh=gQfM4/E9kkp+dxCiGlljuM7+HMQTQzN/muuH3WlNtFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGAoXJHZ6A0oh1wtR3+UIJDgmTx0Fm1s2Ays39xeeOfcVk3QJ0wNu180RPnoaSp3N
	 RaibgNqVZn0QawdLJ8r6omMgtKhpzvI0zVgQ/NuARH+lS7paRYi/HpMJ1WIbs+5foV
	 VIbbJdRT0hNpBh2xkku/EofDWreOmuo+XZ5JKc21/rkKjhqPj+fejkqCTtzsKZKAv/
	 Dv/Cwv4s48UsFoOwWHTYclDBBIukUuxKTCiS1LQC1/a4nVHRmOvZmAbbm01CrK0JW0
	 T8TmoWmy/z8vtmBSc/ebkFkSQHZuyxZq6HpbZ3A/D1xpDNe43T8+vOCOJtpxPFaoQ6
	 nZsEUbTsTE1lg==
Message-ID: <sashiko-outbox-191402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix jited line info off by the CFI preamble
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBGZXJuYW5kZXogKEFudGhyb3BpYyk=?= <jose.fernandez@linux.dev>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261030-b4-arm64-bpf-linfo-cfi-v2-1-4eac83435d4b@linux.dev>
References: <20261030-b4-arm64-bpf-linfo-cfi-v2-1-4eac83435d4b@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:19:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> With CONFIG_CFI=3Dy, every jited line info entry after a function's
> first is cfi_get_offset() bytes too high on x86-64, riscv64 and arm64,
> so tools that use it show the wrong source line.
>=20
> The JITs count the insn_to_jit_off[] offsets from the start of the
> image. Since the CFI commits below, prog->bpf_func starts
> cfi_get_offset() bytes into the image, and bpf_prog_fill_jited_linfo()
> adds the offsets to prog->bpf_func. s390 corrects its offsets before
> the call, the other three JITs do not.
>=20
> Subtract cfi_get_offset() once in bpf_prog_fill_jited_linfo() and drop
> the s390 correction. jited_linfo[0] stays prog->bpf_func, the
> function's ksym address. Without CONFIG_CFI, cfi_get_offset() is 0 and
> nothing changes.
>=20
> Fixes: 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call")
> Fixes: e63985ecd226 ("bpf, riscv64/cfi: Support kCFI + BPF on riscv64")
> Fixes: 710618c760c0 ("arm64/cfi,bpf: Support kCFI + BPF on arm64")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260904014748.C04AA1F000E9@smtp.kern=
el.org/
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/all/DLNXZ2WK7TPD.2RZBUNRS4FA4L@gmail.com/
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-b4-arm64-b=
pf-linfo-cfi-v2-1-4eac83435d4b@linux.dev?part=3D1

