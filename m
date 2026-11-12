Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483279;
	b=YLe4LTPTxig1doA16603OJx54MFb2psjT/bCrRknmqhn0xgIN67AkPZFPn9ebXzUMPnn
	 Jt5ZhCxfx+0Q+OR17J6cLOWpY583c69tcYV69X+xMgZgcH/BhaUQQ2BPGxTJD2W2x3Fan
	 K5hcvdi2J2K2xTttGd/61YK/UcVkVNq4ROsmEC8b/fqEW5m7SfIRzZT9t1XzhPB335MiY
	 n0T9y/U42ZEd77dUiCRURc0ppLD4PMl/zW3KQgxlyOA0jNz5qB/MpBeBWjszzX3OEu36g
	 QIu3z8PhEnRRvpv40SWPnBR/jjCsRKaVnwiVaRuY33kz49nlzH61YJhxfC2VkTY+Qgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zLsrZztbD+ZscRIw64dNIPk38Ao6S3WgpMxepM0KndU=;
	b=yk7DFjRFw6AVzHhmAO18SUg674b7W76MI8NDhFO6PHM2lGUc/k2Rl18pvFkcd8bdNAwD
	 inZvEHauqKKvMaR1ET+G3P5tKnM+2/Lyhr1wCjyDdXTi3/RLphjzITe74EBAUaTmKJP+0
	 aquAcyGdw+7nH9/0/uE8sJdB+Jg/asWFgUxjI3/+fE5Xhk8mdSfmEzqH43DkQuhOenTU0
	 biXGzob2oa1efNnEvLEpTUb60OL3mFXs7LF93O+t96Em0bkDpD0RYu67VJ6gFr0i3thxj
	 Pw3imc3n8wrCiLp2NJung3nPN3Nshp7G2QayKdwzD+c7iTWtBbwhoz3BONQqSMD4cYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKM1hCEB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BE606A31C
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKM1hCEB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9631F00A05;
	Thu, 12 Nov 2026 11:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483279;
	bh=zLsrZztbD+ZscRIw64dNIPk38Ao6S3WgpMxepM0KndU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKM1hCEB+Y0qpmen5FQZg5n+F3aAUCUNDd6q9uuqcfGcBe902Ijw7gtJ1ZIy1uYTl
	 KZaKYYaeDF2VJIsTDF+GSUgdmAxZGQRS8yS6uC7/WSyyRRAeCl4f5dHn5mHSo+rvMt
	 9ODr2GELrlcmDsHkq/nCCjMDlTtuWnbTXNctPd0S0YcQREerk32CoBQyIXTH9HGX74
	 QoKdUOgw2KOgojaHRhZU+ruAckryVumTQVIT8TsOTDGTnOY6NKQnVr1oUrkRbjONuH
	 bBGohSC2PWKBpMvNjAsubzMEX9ugKTYhjj8teu+WK9sHI7jKeCt8PYs8tSBOPPixTa
	 oyYQXMJfix3Jg==
Message-ID: <sashiko-outbox-211026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/8] s390/kexec: Pass crashkernel CMA ranges to the
 kdump kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-4-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-4-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:34:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Store the crashkernel CMA ranges in the parmarea of the kdump kernel,
> next to oldmem_base and oldmem_size, when it is loaded with
> kexec_file_load().
>=20
> The ranges use 64 of the 72 bytes of pad1, which is enough for the four
> ranges the generic code reserves at most. They are sorted by address
> and unused entries are zero. Older kernels ignore pad1 and kernel images
> have it zeroed, so old and new kernels still work together.
>=20
> For kexec_load(), kexec-tools would have to fill in the ranges. It can
> read them from /sys/kernel/kexec_crash_cma_ranges.
>=20
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D3

