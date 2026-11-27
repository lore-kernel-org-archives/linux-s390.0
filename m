Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791852;
	b=b2Dud9Hoxb7jnMGNBvjgE0KQlTo2xlmQmvOtoMM5tcPtWVnPrh2twzCuUy06YDQ5pL+L
	 S72LufLgZAwLOSOWtpZuvmeu3Pb7euZatZIibc74NflREf6E6wgm5nFR3hyKj40wcaHGB
	 PZgUgxfw92Z+3cyB2kDVXBSwrrS7QaQrjkSO/9OmkoasWtnBlbyH++6Vc+wCGung6eGsw
	 mk8zxOtLZdfVhkudU7BIOxFfxaRZ0z7fpTF8ZXNQm2NY5ZPyVjzmLAfkCGA6RXP6otNhA
	 9h1qWlD2he2FmKfT6QfxODN5Rtn0pVpj7AlHpznXw8E/zCGwEzdsQQFZlrqRllqnDhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=80BjQMDOtack7GC2vS+lyX7RABWFQ6HTHpuDd7hN/4Q=;
	b=H8AwMSn3NDB7TyzEYbiJ5skSKTADNufEm9Qwb5aumWlZ8rEofWn/QXyw5j33lSsEp6nS
	 nXk5qbz89kz+NhjGCl7GiJn8UYhidn6DKW+d+CfbedmzEj/raj19b9O3mqGdN9zDmQTBz
	 HNwzBz4fy1S26WdOlEb/jjreuXkfFsgeqirho0HZ/yDmtaO5cBE5/JD3CFz1Wqqstcyui
	 gY3l5vO1BHbqdy/ZYflp7w7pRuAVu1mHMdeDz2fEqfEfOKFoBkVjVF4Vhj+kCSliKMxAO
	 AbgwSMa6mDZ4XPjLpMrdedr90d/s2lulV27N/LoQ2NJ5I4DSKjJ6yxs89CR+bjMFhaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+8HKsIz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B58606A31C
	for <linux-s390@vger.kernel.org>; Fri, 27 Nov 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+8HKsIz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC271F0089F;
	Fri, 27 Nov 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791852;
	bh=80BjQMDOtack7GC2vS+lyX7RABWFQ6HTHpuDd7hN/4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+8HKsIz1ngf03g0lF7jxkuGjlAPDS9LbxBD7PBtytmGNIdTAijI33QBupITi0Vxa
	 Z5jVr/sggmJNJhSUUhA953MXYqKjltgnTW/pG+HV/nr2XfYb+FZQWT6ji3c71DKqBx
	 7K131NDap5DztkNJ4e275B23CpbSEhhfAc2mWPTcRROuO3qmCP4Awr8dJjtc7l2Fdt
	 7JESGGnPiUvsgRiTv9OWqjh3ulytLXuhpaP2/vL7D+05rEQoenENpSCNljt+TrVmvY
	 AkzZUt546B0TF0FDsgo8IlEzzGSOqRU/n40UwfwZiV/FHUEepgI3yTjz+XKMoLL4Gv
	 c834zlxc0vBuw==
Message-ID: <sashiko-outbox-237672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 00/25] KVM: s390: arm64: System Registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:04:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 25-patch series:

- Patches 1-9, 11-16, 19, 20, and 22-25: no issues found.
- Patch 10 ("KVM: arm64: Share system register code with s390"): 1
  potential issue (1 Medium)
- Patch 17 ("KVM: s390: arm64: Implement feature sanitisation"): 1
  potential issue (1 Low)
- Patch 18 ("KVM: s390: arm64: Implement arm system register mana..."):
  1 potential issue (1 Low)
- Patch 21 ("KVM: s390: arm64: Implement exception injection"): 1
  potential issue (1 Medium)

Detailed reviews have been sent as separate replies to patches 10, 17,
18, and 21.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-sysreg-v4-=
0-a6318d18aab5@linux.ibm.com
