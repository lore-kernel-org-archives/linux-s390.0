Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCC4CCDEF;
	Mon, 31 Aug 2026 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202913; cv=none; b=ri/Sam182wWSlsRklSwU1+hqX/iP3VWKwg03ZqbxoT0tzVX1oW6wG+9x0z7XSQ7pg6B0YWZ/oYht0m7C5EWlRboXrCmS8W8ZbAObKYMXWY1DSZHGEi8GohH2CMVyYfQNg+Om8XCR3a3XOFrgUuEFMnbjSYs2RTqMEtUMQwJXHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202913; c=relaxed/simple;
	bh=3E0OZ8OhQKB5OqIEz1F14yZaQ+5B/2HnXvznB2vRHqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HfxUek6Qo4SYcOVfbseVnKKvvzKQW/g9FVHjpsuPTgt2kkltgfwi7evepQhoxkd9IADCEYxxwO8I9MDiUMqud1eI7irb+eMv8yDZR/cJgiQCAUdpdSNGWpvFt7Zn07frqKVf83gve49V6biu+PM0l0jOCRMJyMUHiFasoLjJHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj05xhql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj05xhql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40561F000E9;
	Mon, 31 Aug 2026 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202912;
	bh=5zFu9vkouZ+K22zZEGQctXZTkCUpbXMFE5wgpakUF74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xj05xhqlvwArM43LupWF8iOinRCLK9CLgLJq7hQB1GkFH4scOsdjdaXKrbLJpKeGp
	 bJxlsWoKVH23kI9mcmzSQgbp2mcXT3/b4QhLd8akeYV4FybFfqpqUqaE5z6IxUXrJU
	 ukxGQbfS+3FxB+MdhpLvVZMiXyzX4yQid+QNIg9L1iqeDcT/8ejWpYVAGMYAt5n11J
	 MtfqDAwDiufNtgNPG2mYxydTADJ7vIs7ajsXwnmzhslnkqn1ykgDCLW44x1Rk+wTq6
	 rb5PXB50oUxn2LsnhqDmgW5nLKCuIE9f+URMJ2713COTvdVQktKoU/YEm5smhvXqOu
	 YNfAWQnCVrZWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/20] KVM: arm64: Share more arm64 code with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831145536.913567-8-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-8-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:01:51 +0000
Message-Id: <20260831190151.D40561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-reachable WARN_ONCE in bad_trap() via read_from_write_only()=
 and write_to_read_only()
- [High] Guest-reachable WARN_ON_ONCE in access_gicv5_ppi_enabler() trigger=
ed by a guest read.
--

commit feaf451c9f33eb68d8400a6395fedbe94a88f53b
Author: Steffen Eiden <seiden@linux.ibm.com>
Date:   Mon Aug 31 14:55:22 2026 +0000

    KVM: arm64: Share more arm64 code with s390

This commit marks several functions in the KVM arm64 subsystem as shared so=
=20
they can be reused by s390. It achieves this by wrapping the relevant
code blocks in #ifdef ARM64_S390_COMMON.

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 53d096803d9dc..b167f9d06fd46 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -82,6 +83,8 @@ static bool write_to_read_only(struct kvm_vcpu *vcpu,
>  			"sys_reg write to read-only register");
>  }
> =20
> +#endif /* ARM64_S390_COMMON */
> +

[Severity: High]
This is a pre-existing issue, but doesn't bad_trap() allow a guest to trigg=
er
a host DoS?

The bad_trap() function calls WARN_ONCE() which will crash the host if
panic_on_warn is enabled:

arch/arm64/kvm/sys_regs.c:bad_trap() {
	WARN_ONCE(1, "Unexpected %s\n", msg);
	...
}

This is unconditionally reached if a system register handler calls
read_from_write_only() or write_to_read_only().

Because KVM's sysreg dispatcher does not validate the direction (read vs. w=
rite)
of an access before calling a register's trap handler, a malicious guest can
deliberately execute a read (e.g., MRS) to a write-only register that traps=
 to
EL2.

The dispatcher routes it to the handler with p->is_write =3D=3D false, the =
handler
checks !p->is_write, calls read_from_write_only(), and triggers the host wa=
rning.

[ ... ]

> @@ -800,6 +806,7 @@ static bool access_gicv5_ppi_enabler(struct kvm_vcpu =
*vcpu,
>  	return true;
>  }
> =20
> +#ifdef ARM64_S390_COMMON
>  static bool trap_raz_wi(struct kvm_vcpu *vcpu,

[Severity: High]
This isn't a bug introduced by this patch, but doesn't the=20
access_gicv5_ppi_enabler() trap handler also allow a malicious guest to cra=
sh
the host?

The handler executes a WARN_ON_ONCE unconditionally upon entry:

arch/arm64/kvm/sys_regs.c:access_gicv5_ppi_enabler() {
	...
	/* We never expect to get here with a read! */
	if (WARN_ON_ONCE(!p->is_write))
		return undef_access(vcpu, p, r);
	...
}

Similar to the issue above, the system register dispatcher does not intrins=
ically
filter read vs. write accesses before routing the trap to the handler.

A guest could execute an MRS (read) instruction targeting ICC_PPI_ENABLER0_=
EL1,
which would route to this handler with p->is_write =3D=3D false, triggering=
 the
warning and potentially causing a host DoS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D7
