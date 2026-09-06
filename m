Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633530F526;
	Sun,  6 Sep 2026 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683681; cv=none; b=Y5tvc9SV4p4NjtwjJxpPjXR8jFGkJs/pxmcBnZd2hwlvtS0mhXs/727CPWzS8dQ2CFUp0vocE6O8z1cGJ3PTqmF3xOQ/k2aH4gnmLA58sTvjFwCTgDpTlD/3YUl4vxKAAjEapgegqeuHaQK+VMAkHjfm4TYh3SlZl70WSTc/yR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683681; c=relaxed/simple;
	bh=t2IiTPIKFWF2c4W3e9Eg92Z/KZlfe0x7uQ6lULZAaTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmiwvRhfs6MSZgq+gzx4hWo375Y8m+v1zWwF5BbeDd25UZviWCWnIaFnhb3KDuDR1LmIWu9VHf9r64Sf5u+SY2r+XFI/lLinbXfk1HRPMh/M9uoQqBiZuBqNA9YPSatOwSfKY9+lrWWmhIwbMLmA1BPIDZOeWbpJ3FbG9OKSkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fipHyT+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fipHyT+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E4A1F00A3D;
	Sun,  6 Sep 2026 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683680;
	bh=VA1q25Xb0Zax5FOnZvhKdPFF0MtwKauttISqfNczKDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fipHyT+NHC2vuSCN7TMHYf4GEs74n1gclra+Xq74XsD6o3j+JAmqih4d5LKgr7FCJ
	 5VgSvUOH5FD1Q194qkEcel7eDvQ0EwhePswrPJNfb+ORTtH5idjLn8v5VqDJU0c+rL
	 Yabp21xpB+RiNMQpy0qcBgcU19q+0UiYy5wLHUgNn4ou1vEhD1YDPjHTiMBS880B5V
	 KIVypEbFbuASzjNA2h0UzJPG9AjP2x8jos/aW5eX3+m/4B5SidAnxt3xo3twyQUtfq
	 K1123DTZQUbgW6Sq6wY+o+T2EpS2F39ivWrN8EJrI11x1+VUGwDpfQNqqT4ilShVSt
	 B+qjRZJkZsOrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] KVM: s390: Replace get_zeroed_page() with
 kzalloc() for the STSI buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260906-s390-kvm-v2-2-2cf6434e6646@kernel.org>
References: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
 <20260906-s390-kvm-v2-2-2cf6434e6646@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 08:34:39 +0000
Message-Id: <20260906083439.B7E4A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kzalloc() does not guarantee the 4K-byte page alignment strict=
ly required by the s390x STSI hardware instruction, leading to a host kerne=
l panic.
--

commit 1bfe659dfe76809762877435521d74d061f7364a
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer

This commit replaces get_zeroed_page() with kzalloc() when allocating the
STSI response buffer. The intention is to use a cleaner API that does not
require casting and does not need the size when freeing the memory.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index b3cb2c2c3aa71..856939acf012f 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c

[ ... ]

> @@ -911,19 +912,19 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  	switch (fc) {
>  	case 1: /* same handling for 1 and 2 */
>  	case 2:
> -		mem =3D get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +		mem =3D kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);

[Severity: Critical]
In handle_stsi(), does kzalloc() guarantee the 4K-byte page alignment that
the s390x stsi hardware instruction requires? The previous get_zeroed_page()
guaranteed page alignment, but kzalloc() might not if kernel SLUB debugging
(e.g., CONFIG_SLUB_DEBUG with redzoning) is enabled.

>  		if (!mem)
>  			goto out_no_data;
> -		if (stsi((void *) mem, fc, sel1, sel2))
> +		if (stsi(mem, fc, sel1, sel2))

[Severity: Critical]
If the buffer is unaligned, will executing the native stsi instruction here
trigger a host specification exception? Since the stsi() inline assembly in
arch/s390/include/asm/sysinfo.h lacks exception table handling, it seems an
unprivileged guest could reliably trigger a host kernel panic by invoking t=
he
stsi instruction.

>  			goto out_no_data;
>  		break;
>  	case 3:
>  		if (sel1 !=3D 2 || sel2 !=3D 2)
>  			goto out_no_data;
> -		mem =3D get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +		mem =3D kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);

[Severity: Critical]
Does this second allocation in handle_stsi() introduce the same alignment
issue when the buffer is passed to handle_stsi_3_2_2() and used in the
stsi() execution there?

>  		if (!mem)
>  			goto out_no_data;
> -		handle_stsi_3_2_2(vcpu, (void *) mem);
> +		handle_stsi_3_2_2(vcpu, mem);
>  		break;
>  	case 15: /* fc 15 is fully handled in userspace */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-s390-kvm-v=
2-0-2cf6434e6646@kernel.org?part=3D2
