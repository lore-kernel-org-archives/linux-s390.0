Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142D3E5EF1;
	Tue,  4 Aug 2026 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867566; cv=none; b=W9wLmOekXlWQq/KxGcQSEkgtgfZhpV/fE7XZlPDmLC98H8eSU+stfh+0DEQ8cmxtGus4Ar1BMlErp+gNn6zlN/H0WJ3ETVrA8t3IOoTtiAwWiF5RKakymHBQUvedZQveo3fgSfm4gEbLgZkj4uq49qQrt6sP2NaURG0fBxgDG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867566; c=relaxed/simple;
	bh=Jf6MVU2waTh7MgGVG9Y72/HaKkGvXAyAmuswADQkemA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ikk9NOihJH6gCrkjo3cSgL2B0917DYtqxQSMgmdUXnlfPze/dCrvynx8Zu6G1g6Gf8fXft3HktqZa5O12BVwnUx5YzicSUI/VmvwjzzrHQ7WvkUlg8TqwRxVJNbo1F/T8IzQTKN7ad4h2UmQhhLSWgL6tCC/JIvmoLkII/IfTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmyQWy6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmyQWy6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70211F000E9;
	Tue,  4 Aug 2026 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867561;
	bh=8Em4rsSW5WvA/pIu5Gq7/dIXWb64UUL/Bx3Kq6L9KbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CmyQWy6fcF7BsiNzA4qNz636/HUu6tjsZxWB5pJjcgQ/f70QYeklpB3G/+yNOBYYA
	 fKHf/gQhRtV6uaOXON3i34lmOVzhTDFU2tjlxRXD1jD7x3U/o5ok6qgImJmnb68nQ3
	 TjApOcnyyl2itonrboHdWkO4+myOotxrgnn/t2LeErIgeWP4AQTNU4EkUEQ/jIXOHX
	 ZVz7Ooa9RNJk6gCGpOtI9Ig9nG07hOInhGU8UrGGuUy3nT0kA9cybgqRttnzH00/pI
	 rSsWdsLF16kCliYTRmfOaWsWWablu3IupsrLMOAXyYwWhhaXOyYPHr+XmxBJ0pizr6
	 QfINlHvvXjsxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] KVM: s390: Fix old_data leak in guest debug
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260804162435.28617-6-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-6-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:19:20 +0000
Message-Id: <20260804181920.B70211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing SRCU read lock around KVM memslot access during KVM_SE=
T_GUEST_DEBUG causes a Use-After-Free vulnerability.
- [High] Pre-existing memory leak of guest debug arrays (`hw_wp_info`, `hw_=
bp_info`) and per-watchpoint `old_data` buffers on vCPU destruction.
- [High] Integer truncation of `bp_data->len` allows unconstrained memory a=
llocation, leading to a kernel WARNING and potential Denial of Service.
--

--- Patch [5]: [PATCH v2 5/7] KVM: s390: Fix old_data leak in guest debug e=
rror path ---
commit a3583776c5b24b471704343b4d20b599ed4ab8ca
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Fix old_data leak in guest debug error path

__import_wp_info() allocates a per-watchpoint old_data buffer to back up
the original guest memory contents. If a later watchpoint of the same
KVM_SET_GUEST_DEBUG request fails to import, kvm_s390_import_bp_data()
jumps to the error label, which frees the wp_info array but not the
old_data buffers of the entries that were imported successfully.

Cc: stable@vger.kernel.org

> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 4c02dbebb2eb3..f7c94d54efbe2 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -252,7 +252,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  			ret =3D __import_wp_info(vcpu, &bp_data[i],
>  					       &wp_info[nr_wp]);

[Severity: Critical]
This is a pre-existing issue, but does this call path lack SRCU protection?

When KVM_SET_GUEST_DEBUG calls __import_wp_info(), it eventually invokes
read_guest_abs() which dereferences the KVM memslots array via
gfn_to_memslot().

Neither kvm_vcpu_ioctl() nor kvm_arch_vcpu_ioctl_set_guest_debug() appears
to acquire the kvm->srcu read lock. Can a concurrent
KVM_SET_USER_MEMORY_REGION ioctl free the memslot structure while it is
being accessed, triggering a use-after-free?


[Severity: High]
This is a pre-existing issue, but is there an integer truncation bug inside
__import_wp_info() for the length parameter?

bp_data->len is a 64-bit user-controlled value, which is assigned to
wp_info->len (a 32-bit signed int):

arch/s390/kvm/guestdbg.c:__import_wp_info() {
    ...
    wp_info->len =3D bp_data->len;
    ...
    if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
        return -EINVAL;

    wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
    ...
}

By providing a large 64-bit value (e.g., 0x100000005), the lower 32 bits
would pass the bounds check (5 <=3D MAX_WP_SIZE), but the untruncated 64-bit
value is then passed to kmalloc().

Can this lead to an unbounded memory allocation exceeding MAX_PAGE_ORDER,
triggering a kernel warning?

>  			if (ret)
> -				goto error;
> +				goto error_wp;
>  			nr_wp++;
>  			break;

[ ... ]

> @@ -269,6 +269,10 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  	vcpu->arch.guestdbg.hw_wp_info =3D wp_info;
>  	kfree(bp_data);
>  	return 0;
> +
> +error_wp:
> +	while (nr_wp--)
> +		kfree(wp_info[nr_wp].old_data);
>  error:
>  	kfree(bp_data);

[Severity: High]
This is a pre-existing issue, but does kvm_arch_vcpu_destroy() leak these
dynamically allocated buffers when tearing down a vCPU?

If the VM is destroyed while guest debugging is active,
kvm_arch_vcpu_destroy() seems to skip calling kvm_s390_clear_bp_data()
to free hw_wp_info, hw_bp_info, and the old_data buffers:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_destroy() {
    ...
    VCPU_EVENT(vcpu, 3, "%s", "free cpu");
    ...
}

Could a host userspace process repeatedly create and destroy vCPUs with
guest debug enabled to exhaust host memory?

>  	kfree(wp_info);
>  	kfree(bp_info);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804162435.2861=
7-1-borntraeger@linux.ibm.com?part=3D5
