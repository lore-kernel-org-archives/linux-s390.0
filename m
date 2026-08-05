Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D542E8F1;
	Wed,  5 Aug 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929217; cv=none; b=lTdyMjswGrLlgFSFBnTv7WeuYM7yV0OHDafORiss4szwOeJu7fOkuGlMfvxLXJHA6besTqaGyXIb2MlC+LXyulMFgF1hid1aY30QTq/KImCI60ru2BwlB/I0Rx8p6FN/G3lWAx7aSoz6akfAkl8lpUzn5X5cGRT9w755Vu9h0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929217; c=relaxed/simple;
	bh=pe+ryBEZgXskHN7Mfzq3Sijs8Qe3mDDiXS0t+7/g3Zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cSIlw/rGKWoO65TAYY8Dn7/DLzgJPCDECbTaD6W6z2WAGUeeqoATLX71ttdlCP3+zepw/AesTGs/Zy/9sgGKXijhAY9H4XF+sE6lr8oPxqqBlYUh6vbCkUgQPwR63oiyXF77aZPgm2UrHx+/b9crDFrUte5KRjZe9vjvAQVZIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnrifeLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnrifeLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29451F00A3A;
	Wed,  5 Aug 2026 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929216;
	bh=gS+fMrzxXKey9DJcxqixd5aukDZ8dxaZnYKonF1G1DM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KnrifeLLltzCckQc3Zd9ciJ5LqAr4+3QhYFdJCesGNFqXP179gA1CaAPgDqnwd/eA
	 TT+vNVinPbYxM/+tPnQS1uQ+TCohdO9TGs8JFea7XXWyjZkvXAYH52Rvg6iJsL1uHn
	 RWHalJa9QK/rq/eILeO5F05rkCPdCxTyschtwuaTxBgVOxbg9OxulgmI/cXUvHse9s
	 yP41m0VgwkGFFcqb9g4qBOwzTTgcfYX02u1jjCH520g/2dwvTO57DB/lSd1vikq3od
	 de2sjGvJMJEXmwLCgC37xp1ZaDfTwaCk3ul3ocdJubxKqV5N/PCEhRPsK6gM2R1KuC
	 8PNbZeFIKlDbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] KVM: s390: Free guest debug data on vcpu destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805110455.7200-8-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-8-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:26:55 +0000
Message-Id: <20260805112655.B29451F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer truncation in `__import_wp_info()` allows bounds check byp=
ass and host Denial of Service via a massive `kmalloc()` allocation.
--

--- Patch [7]: [PATCH v3 7/8] KVM: s390: Free guest debug data on vcpu dest=
roy ---
commit 9d3d46230dbc0cbf211fd1bcc98310a2f3252d6f
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Free guest debug data on vcpu destroy

kvm_s390_clear_bp_data() is only called from
kvm_arch_vcpu_ioctl_set_guest_debug(), i.e. when user space changes or
disables debugging. A vCPU that is destroyed while hardware breakpoints
are still armed leaks hw_bp_info, hw_wp_info and all old_data buffers.
This commit fixes the issue by clearing the debug data on vCPU destruction.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 0a197e055cad0..095c9ba0aa5cc 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3410,6 +3410,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
>  	kvm_s390_clear_local_irqs(vcpu);
>  	kvm_clear_async_pf_completion_queue(vcpu);
> +	kvm_s390_clear_bp_data(vcpu);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the debug
data cleanup I noticed a potential integer truncation in __import_wp_info().

Could a malicious user bypass the bounds check by providing a massive 64-bit
length?

In arch/s390/include/asm/kvm_host.h, struct kvm_hw_wp_info_arch defines
len as a 32-bit integer:

struct kvm_hw_wp_info_arch {
	unsigned long addr;
	unsigned long phys_addr;
	int len;
	char *old_data;
};

When __import_wp_info() in arch/s390/kvm/guestdbg.c imports the data:

	wp_info->len =3D bp_data->len;
	...
	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
		return -EINVAL;

	wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);

If a user-space process calls the KVM_SET_GUEST_DEBUG ioctl and sets
bp_data->len to a value like 0x100000005, would the 32-bit truncation
cause wp_info->len to become 5?

If so, this would pass the MAX_WP_SIZE check, but the kmalloc() call
would use the original 64-bit bp_data->len, resulting in an enormous
allocation request.

Since GFP_KERNEL_ACCOUNT lacks __GFP_NOWARN, couldn't this trigger a
WARN_ON_ONCE splat in the page allocator and cause a host panic on
systems with panic_on_warn enabled?

>  	if (!kvm_is_ucontrol(vcpu->kvm))
>  		sca_del_vcpu(vcpu);
>  	kvm_s390_update_topology_change_report(vcpu->kvm, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D7
