Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BB4921B1;
	Tue,  4 Aug 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866441; cv=none; b=Te/hWtfoQ9yA5Pm2ORQ0PhrbxupZn3vSue/BoGe5VmMSgp2YYfpQTNVWam7j8yoIp9wUkzb9PleMJPPhdL7wzrRtqVBOGQKasjo36GxdiSuWeRlnIbH2pXF+BwNO+O8nySpfg7FL4O4Lu9zV6Z43kcvdKjfk4Y6ohgoJdTVTaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866441; c=relaxed/simple;
	bh=qNzuKs0qVsy0x2+wdXsUOEQmGGQrPTgsXEjwOR0hm3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jcq1qVlwTPzC/+PXCt9kn+22M10aJWRMiR6AASErDGHG380qLywdjxo2TD8uz4ASgGlO/CL1/eFMGwRVSnrHBFXPWJhLPmrO1+D6IQndYM0I12M19csYcJ66y9X+9oNgBUOepm5TgG/SgjyEWjaD3hfLo4vMJG1h9viKA/L3SyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNPWWoFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNPWWoFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F11F000E9;
	Tue,  4 Aug 2026 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785866439;
	bh=1hOHrrsv0lWSHOH5yeaigM0HCKlpx3MZ4FZAkvCeMSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DNPWWoFwQ0lcFn7kqVXxQguvAu3Yk9ITm+m71UtYJPGYlcMAV5pACjU1eY0AtbhcM
	 wKk6Bly4U9nav65RkY8bfCRLwSIQPCngeHcQhbXGVXByr1t8l2stwcQpL/jv4pOUCz
	 ZvASrCnq1XT7YGVcgJRuuwyfLwGxXkWuFSgb8nZl5F/VwZHsv9hHuSiUwFbrJv0Ze1
	 JWoadaOEn/ozqqpfRxqJYwvE8zo0OJ/TYFwElfab05KYzjUXuT26pqX5KVTzL9X3Df
	 hqamr2XO+QNHumb8IoDV9TMwHvuQN8Lrb1GGFTe+wOVAK4RNDvoZUdIuK+g32cGRh5
	 243k6yBwHxlPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] KVM: s390: Fix memory leak in guest debug
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260804162435.28617-5-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-5-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:00:38 +0000
Message-Id: <20260804180039.716F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing SRCU read lock protection in KVM guest debug memory ac=
cess leading to Use-After-Free risk.
- [High] Hardware breakpoint and watchpoint data structures are permanently=
 leaked when a VCPU is destroyed.
- [High] Integer truncation of `bp_data->len` bypasses bounds checking and =
allows maliciously large memory allocations.
--

--- Patch [4]: [PATCH v2 4/7] KVM: s390: Fix memory leak in guest debug han=
dling ---
commit ed2dab291478e4d3632d170d668feb5781798aba
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Fix memory leak in guest debug handling

This commit fixes a memory leak in the s390 guest debug handling. It ensures
that the bp_data array allocated during KVM_SET_GUEST_DEBUG is properly fre=
ed
on successful paths, rather than only in the error case.

> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 69835e1d4f207..4c02dbebb2eb3 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -267,6 +267,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  	vcpu->arch.guestdbg.hw_bp_info =3D bp_info;
>  	vcpu->arch.guestdbg.nr_hw_wp =3D nr_wp;
>  	vcpu->arch.guestdbg.hw_wp_info =3D wp_info;
> +	kfree(bp_data);

[Severity: Critical]
This is a pre-existing issue, but since this ioctl path is being modified,
is there a missing SRCU read lock when accessing guest memory?

When a user issues KVM_SET_GUEST_DEBUG, the ioctl executes the following pa=
th:
kvm_arch_vcpu_ioctl_set_guest_debug() -> kvm_s390_import_bp_data() ->
__import_wp_info() -> read_guest_abs()

In arch/s390/kvm/guestdbg.c:__import_wp_info():
	ret =3D read_guest_abs(vcpu, wp_info->phys_addr, wp_info->old_data,
			     wp_info->len);

The ioctl path only holds vcpu->mutex, but read_guest_abs() translates the
guest physical address using gfn_to_memslot(). Without holding kvm->srcu, c=
ould
concurrent memslot updates (like KVM_SET_USER_MEMORY_REGION) free the memsl=
ot
while it is being accessed, leading to a use-after-free?


[Severity: High]
This isn't a bug introduced by this patch, but does the guest debug length
check properly prevent large memory allocations?

In arch/s390/kvm/guestdbg.c:__import_wp_info():
	wp_info->len =3D bp_data->len;
	wp_info->addr =3D bp_data->addr;
	wp_info->phys_addr =3D bp_data->phys_addr;
	wp_info->old_data =3D NULL;

	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
		return -EINVAL;

	wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);

The user-controlled bp_data->len is a 64-bit value, but wp_info->len is a
32-bit integer. If a malicious user passes a carefully crafted 64-bit length
such as 4294967301, could it truncate to 5 when assigned to wp_info->len,
bypass the MAX_WP_SIZE check, and then trigger an oversized allocation when
the original 64-bit bp_data->len is passed to kmalloc()?


[Severity: High]
This is a pre-existing issue, but does VCPU destruction completely clean up
the guest debug allocations?

When userspace creates a VCPU and sets hardware breakpoints via
KVM_SET_GUEST_DEBUG, arrays are dynamically allocated and attached to
vcpu->arch.guestdbg (hw_bp_info, hw_wp_info, and old_data).

In arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_destroy():
	free_page((unsigned long)(vcpu->arch.sie_block));
	kvm_s390_free_mmu_cache(vcpu->arch.mc);

It appears kvm_arch_vcpu_destroy() is missing a call to
kvm_s390_clear_bp_data(). Could this allow unprivileged users to leak kernel
memory by repeatedly creating and destroying VCPUs?

>  	return 0;
>  error:
>  	kfree(bp_data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804162435.2861=
7-1-borntraeger@linux.ibm.com?part=3D4
