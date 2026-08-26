Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889703164BA;
	Wed, 26 Aug 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758522; cv=none; b=SB+nm8Iwn6+HPiqxLo4geClzUrBqbXCWT+euglCwhvK36QSlGfKZvjb/QlE6rnPJB3i5EhmM+TaW5LVhmCzMP3n3DU87PRyycZ2nArdy/IY21XMVJDQdSt1Yo2Mvmdjc5BHbhg7IoMLy6JXCNJ4qtshAHWtvvY3yUeZ3DSQo/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758522; c=relaxed/simple;
	bh=eurlnkiYIHm71q1zFta4LzR568hN53qJl6p1eL3rVTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tsLjbUeKJfq0ahOB2+X+rkev0bBXJCKGKT+lEU14igyD21yX4R9vhlL6W5AB8Nl7CrDKgJD2z1gRm+RBQaaEU+MVX92JcUWTclZVlXCxi6HlznDCThTmxkPBTkZU+sv6VPmW/lkO8qPybYasCnOrk1+vE6bNUM+WYxOvWFBWn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlD1MwHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlD1MwHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B3E1F000E9;
	Wed, 26 Aug 2026 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787758516;
	bh=+AnsXY3mBRY10xmaWh+4GMHmXpOqH3EjWSOLXjCYRMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KlD1MwHDWw/17OCr+Sz84Kk810nXHlPhJHarkLpAIGJrNWTf95viDc5vQtZVuLAu4
	 qTSrRJ/7E2hsQ9vlni0SjMaJF8du/B9ApJWgNKixymO3Npx/rUfPr46RpL9BNq79cj
	 tVja4A9JrZohdQq4zQWGACoXsTtfxutl8q2HUctjVmcBn7IiB9JvWzcXeQnSLTfoSH
	 XD8LQpo/thnwSwqRj1PoXWDrzreWMnkXzD8k0O9MSqqOLt34+elI6Cqr5ZxN7N0oXI
	 i4lPUY3T9eSDAlT8icJbFXaOte8g8K4i/jqDwSGcvAbIBSm1XTZEMrJlPANFiX8voN
	 MYWAAuTuDG22A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/21] KVM: s390: vsie: Create minimal scb shadows
 for not running g3 blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-20-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-20-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:35:15 +0000
Message-Id: <20260826153515.C7B3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Hardware SIGPI execution can read a partially zeroed `scb_s` s=
tructure while KVM is executing `memset` on it, leading to host memory corr=
uption via wild physical address writes.
--

commit 6a6b22a554f022a2f999c91a98c908cfacf9ce2d
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Create minimal scb shadows for not running g3 blocks

This commit introduces a minimal shadow of the vSIE control block for
guest-3 blocks that are not currently running. The minimal shadow only
contains the information needed for SIGPI and SRSI and is recreated fully
when a vSIE is entered with that SCB later.

[ ... ]

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 335ed1a927aa6..86ccd92233b5c 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> @@ -2166,7 +2186,7 @@ static int _shadow_sca_cpu(struct kvm_vcpu *vcpu, s=
truct vsie_page *vsie_page,
>  	if (IS_ERR(vsie_page_n))
>  		return PTR_ERR(vsie_page_n);
> =20
> -	rc =3D shadow_scb(vcpu, vsie_page_n);
> +	rc =3D shadow_scb_minimal(vcpu, vsie_page_n);

[Severity: Critical]
Can this lead to host memory corruption if a malicious guest-2 changes the
SDA (scb_gpa) for a nested vCPU in its SCA while another guest-2 vCPU is
actively running sie for the same VM?

When guest-2 enters sie for the modified vCPU, KVM's get_vsie_page_cpu_nr()
call just above this block unpins the old SCB and clears the shadow SCB:

arch/s390/kvm/s390/vsie.c:reset_vsie_page() {
    ...
    memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
    ...
}

Does this memset execute while the other hardware thread is actively allowed
to follow the ssda pointer to it?

If osda is zeroed while hardware SIGPI execution reads this partially
zeroed scb_s structure, it appears hardware could write to absolute
physical address 0 (or a freed host page), causing host memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D20
