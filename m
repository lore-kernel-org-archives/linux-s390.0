Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924783;
	b=WNZdPEb/Wn1pMK2swlGIyv43nQ0Oswny6Qblsy3CFhFzEStiVUhnZLsHDehiT4Xx08YC
	 12lC8fwLQ/60s4EWNXssYu2aiTk+qQy8Ubnlp0EzrZtGgw4Bv/NPGzEe0H18qV07IsRIz
	 mz1DYhnOP75S0mSkgWEnb1g1yvgroG3u7MJrybHLXQMrrjAwsuNj9WjyYhNTgB+ljZ0A1
	 ElcGF9mRekX9ANhdgHtR2zin4ettKalU7BkpBuAxM9R0Qu5+YYsxaLl+DWUF4wGuHpZ27
	 JGhf9HqySYrltfEsCUY3ziLNvsZoVYGE9xBANc8FTXYUR7DIU3E34t93eTwR/KMSN9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DxvfoWBLBPQT+gx0cK0iCeOnvNUkAi61vv+xNLBbR28=;
	b=tmlnAKHIkA/zGudW7kyNHT20BQrNGh+zUopLobKwlsDdiyHKaE07FKJM1z9MO10NjvBL
	 LETt4N16YgNDWMWuDuJ9NLKMhkseA2+hw5xF/8Cz/n7xOy0Meml4rG96mgtS/dSoOIjN8
	 ISlTdz1v6rnE2Gxc6cRKovFxWBg7DPSOWOO+q7ZWqgRD0sOa3jqiMy8FzeMa3Ua1WS7Rr
	 TnKSzhtrD8Qh1LsO0Du0UzfJjAOH7doQtfVcqD+AdVmSs25vT7SPMBCaEfzj+LHD6QH8J
	 43Btgt0+pFGbeIkzDhQH3Jzb3a43BtduIWWa1BxW/V4MbpQvMN5Gwqeo+WASCdaMqXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjMkHAVV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27914606A8A7
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjMkHAVV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6081F000C4;
	Tue, 17 Nov 2026 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924783;
	bh=DxvfoWBLBPQT+gx0cK0iCeOnvNUkAi61vv+xNLBbR28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KjMkHAVVO+0ClA+lbNQKvypP3FB5+r1Ei8HkLxKyWi6Irk2ksQO9N3n69+conRfbd
	 sJDSdXubTPuXxUgOC8nLjfnGyztdyrzbFf+fwGjZUvmAuBl74qjuIAHP+J4dx4xJZc
	 rvKkTIob7gMRaVsCMt+1QMgYhgV/UARWgGLF79SCQrKkN9XPF54UBmYjq5MB7v5sHi
	 669W83VR4qIQHq/vaf1uIvxTo0PlstF1bu2lrCAhIR8ab2izIn3yOkaa6A7nPY6i/S
	 Y7ZRh/0ucnUu0DdWRuDIb1OE0+f/1qjK5Th+IfBqsOLR3nwh/tj9CBlG20xnL/x9q6
	 aD69M74N5gepQ==
Message-ID: <sashiko-outbox-218944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] s390/sclp_cmd: Replace page allocator calls
 with kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-10-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-10-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:13:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> _sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
> allocate the SCCBs used to read the CPU information, to configure a
> channel path and to read the channel path information.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Keep a power of two size for the SCCB in _sclp_get_core_info() so that
> kmalloc() returns a page aligned buffer.
>=20
> Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
> and free_page[s]() with kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D10

