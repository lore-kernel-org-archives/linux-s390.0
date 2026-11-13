Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579960;
	b=I1qR7MN4rVLXa0VKTa5h8nzoTNahaEIhoY+EZfw8cj+zt0vM7u4M0+0cLkTbP35UAuzi
	 2R22QWHj4nIr2NAUHAKcfUAmugwHe7s+1gZw2nOv/Qctrc9Vv1kBVw2m4MCYFcMbm7p4J
	 0AeHDCZfGMh/IaB8UmT3SMFbzYBoxhwlb4s0ZOwAOhcGjrOlA4S8rRoShumnuksmqPgu4
	 1OfsZHM4u5anHNSurNbHNMFw6HGROBKtThsApioxERT55NUCU6znKHBn/u3FfxJAEbhUY
	 xn4WAzOrBJZpdTqXY0Ay2yBmgR4/EHRM9crCN/9PEIPuCiR0CtuzC/DNlEyvRZUiOhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579960;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GN5pfvXptDA80vUcvYLmz+sJHzAweInmp26ylcxHk5w=;
	b=E+KBTYOxiDnZOdvekJolEvVIHadaY5H0iY2tpYkBnZ9GlrtN+R/82kXcFDOzsHpJKyPX
	 CHeM7N+rkqfPcGE0iF/JaMCeHgC/FWgnABLGFgHHQay+z/QygJbH1b5OCZILn2+ZFhNEy
	 Sk23QCfsAsasjyh4A3ylWruoS12e7b8Kgq6XGULUfdwpYUhso3UGaUrxCbstqjF1e6x+B
	 sXtvPkrbEXAhBBl9yeiHY+nSbjQPLhHRHZ1KUuUEP/D0K2Ntw+9PxUKIogDnhNbKiC/m1
	 1VPS4+cC7QhC68IEknoE8Z0yAnjWgjlbhyGPq+wUNhTHJNp5pTu7Bw6dtEwkwm3qrAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfxuTFoi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D367606A338
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfxuTFoi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117951F000C4;
	Fri, 13 Nov 2026 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579960;
	bh=GN5pfvXptDA80vUcvYLmz+sJHzAweInmp26ylcxHk5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfxuTFoiOBlAosfuJpYBOc8KiC2H/9I38zmdJITl/X/ZMVYgUOWHFwKB8i3yHIqL6
	 pwVHv+nMLMJaXqSUn4DJHiyaBiAbkqqQ4FduZFqH+Vn5ndEfkqW5gMxqdQZud8CBGv
	 cJnN/Mw2VxGDkuR9VDlOq6GVJo64/kvYxK/80L14gFk3P0eyLf6Qnfw1pzKN7FvQl4
	 TOAksD7MfQn9dqI9WHeolJyPVsWRmPXOiZO+rEc4LRIVx7VXHzCEmrEZShz96lTGcT
	 rFh5W4NSMMNSrK/iUgF6czs/F/7/oNm2DNyXXI+9EXkFdpeUKTwGo7PqMcRy87nVNO
	 jxFYErd/5P2Cw==
Message-ID: <sashiko-outbox-212983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-10-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-10-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When an mmu_notifier invalidation only upgrades permissions
> (MMU_NOTIFIER_RANGE_PERM_UPGRADE), keep the existing SPTEs instead of
> zapping them. The PFN is unchanged and no access is revoked, so an
> existing SPTE is no more permissive than the new host PTE, and the new
> permissions are picked up on the next fault.
>=20
> The motivating case is a userfaultfd-wp dirty tracker such as QEMU's
> background snapshot, which unprotects every guest page as it saves it.
> Zapping on each unprotect makes the guest refault its whole working
> set. On a 64GB guest under a background snapshot, a read-mostly workload
> drops secondary-MMU refaults from ~1M/s to ~2.5K/s and cross-vCPU TLB
> shootdowns from ~1400/s to near zero.
>=20
> Note: this also skips the APIC-access page reload, which is not needed
> as the page's PFN is unchanged.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D8

