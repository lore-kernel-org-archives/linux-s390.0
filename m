Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CE3CB2DA;
	Wed,  5 Aug 2026 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929767; cv=none; b=GfomDWTgX1WDOfsZB1D0f5Z5rN88yz4iLlwPguC2hBrmLZAu5zJAsbkldxlI2pA6Ta/nXZKplXpYqEFr5w3nLuOu3hx014QE9NURQH+Huvq1yPei4dsj9CpxrN+GuNpd4hA/BJPUEUO9npcf5VrYbfq5DQNC6jtsDZO+QE1/0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929767; c=relaxed/simple;
	bh=41QjbtRhwRDnu4WGkbxS6g6c/L3hSieS4zXkhMJZee4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GyDUXUszPZRfKsXQzGnXArrp94IHwJ7ziGnlYAZOpJn+nBbvAGan1t7DJTMhiWW7YIOUfU9GJUaxntx7FKmXPFQpoq4bqmm+UITj/3FLkRvar2p6/9S/5M/9rCuZaS11F8qOKJusNwvOi3BSJe2Rzn6h/e4zKZ1n3x5oTqIQzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f84ckFq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f84ckFq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82B51F000E9;
	Wed,  5 Aug 2026 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929766;
	bh=UDY77qGW8+5L/GQtzFJD9uKQX7CrJBPp2KasHB4YkiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f84ckFq8cQEO3N9xevMIppImKvVGC+CgOuqrzL0JcEMvn3Opf/fYcV1MKFQTqLAg/
	 Yw+mfsZiUnV3eAjAIqqnNFG630o3l3dwUOtQbmvWBbloDNU5KXYFcNZ3K118ezuioP
	 QbXRpftXD4X/jN6XCnjyVpZtmC4wIpRJ/Pik5GJX4qw083i8oqY3j387VDH4dP8WB8
	 qq44KaYdcuB23RwMuBHndJ2puNuEctxqKNscxlSiN9FWbdKwixjGm03VaPWo+f0zJ3
	 CGbnhllq2VZeYDNWc3MoHdc1XjglQiIIAN1vxHTkt3Gd3OhrbZg/sMtjqenBUhZuKj
	 gajcWFEXxki+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] KVM: s390: Fix memory leak in guest debug
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805110455.7200-5-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-5-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:36:04 +0000
Message-Id: <20260805113605.B82B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest debug dynamically allocated data (hw_wp_info, hw_bp_info, an=
d old_data buffers) are leaked when a VCPU is destroyed while guest debuggi=
ng is active.
- [High] Accessing guest memory (memslots) via `read_guest_abs()` without h=
olding the SRCU read lock.
- [High] Integer truncation of `bp_data->len` allows unprivileged host-user=
space to trigger a page allocator WARN_ON_ONCE via kmalloc().
--

--- Patch [4]: [PATCH v3 4/8] KVM: s390: Fix memory leak in guest debug han=
dling ---
commit 4fe6d9b7b9fc213b17879f6cacc90f0c1ed0f351
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Fix memory leak in guest debug handling

bp_data is freed only for the error case by kfree(bp_data). Every successful
KVM_SET_GUEST_DEBUG will leak bp_data.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org

> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 69835e1d4f207..4c02dbebb2eb3 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -267,6 +267,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  	vcpu->arch.guestdbg.hw_bp_info =3D bp_info;
>  	vcpu->arch.guestdbg.nr_hw_wp =3D nr_wp;
>  	vcpu->arch.guestdbg.hw_wp_info =3D wp_info;
> +	kfree(bp_data);

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the dynamically
allocated data (hw_wp_info, hw_bp_info, and old_data buffers) is leaked
when a VCPU is destroyed.

If a userspace process calls the KVM_SET_GUEST_DEBUG ioctl to enable hardwa=
re
breakpoints or watchpoints, it allocates memory for these buffers. If the
process then destroys the VCPU without disabling debugging, does
kvm_arch_vcpu_destroy() fail to call kvm_s390_clear_bp_data(vcpu) to free
these buffers?

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_destroy() {
    ...
	free_page((unsigned long)(vcpu->arch.sie_block));
	kvm_s390_free_mmu_cache(vcpu->arch.mc);
}

Could this allow an unprivileged user with access to KVM to repeatedly crea=
te
and destroy VCPUs to trigger a host-side memory exhaustion?


[Severity: High]
This is a pre-existing issue, but does this code access guest memory
without holding the SRCU read lock?

When __import_wp_info() is called earlier in this function:

arch/s390/kvm/guestdbg.c:__import_wp_info() {
    ...
	/* try to backup the original value */
	ret =3D read_guest_abs(vcpu, wp_info->phys_addr, wp_info->old_data,
			     wp_info->len);
    ...
}

The call chain goes through kvm_s390_import_bp_data() -> __import_wp_info()=
 ->
read_guest_abs() -> kvm_read_guest() without holding srcu_read_lock(&kvm->s=
rcu).

Could concurrent memslot modifications (e.g., via other VCPU threads or
memory hotplug) result in a use-after-free when KVM attempts to traverse the
unprotected memslot tree?


[Severity: High]
This is a pre-existing issue, but is there a potential integer truncation
when handling bp_data->len?

In __import_wp_info(), the 64-bit bp_data->len from userspace is truncated
to a 32-bit signed integer wp_info->len:

arch/s390/kvm/guestdbg.c:__import_wp_info() {
    ...
	wp_info->len =3D bp_data->len;
    ...
	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
		return -EINVAL;

	wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
    ...
}

If bp_data->len is set to 0x100000001, it would truncate to wp_info->len =
=3D 1,
bypassing the MAX_WP_SIZE check. The original 64-bit bp_data->len is then
passed to kmalloc().

Since the allocation size is >4GB, it exceeds MAX_PAGE_ORDER. Because the
GFP_KERNEL_ACCOUNT flag lacks __GFP_NOWARN, will the kernel's page allocator
emit a WARN_ON_ONCE that could be triggered by an unprivileged host-userspa=
ce
process?

>  	return 0;
>  error:
>  	kfree(bp_data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D4
