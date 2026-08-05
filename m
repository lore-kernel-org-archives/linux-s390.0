Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478543F9294;
	Wed,  5 Aug 2026 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929498; cv=none; b=dMl7uqy/wNBWFwe9Qr/WnIDmQMrbvSI55zo528wQ33cABGn6Rj65m/rEZzHwdhk1jwB+1caIcAGvGxx9KEKl1m/yCnFWsOj14kwqmTD9OCM8EW9T3dvm0f2rK/PYyJxnoZXb1t2Zlip84g7l5U0hYzXj12meSRTk0epkbUTOTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929498; c=relaxed/simple;
	bh=iKt+sKaDlZjOKLFWRf1Kai3i9VcDvSZy6CoDu/v+eLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYUDk8uVQdBq1VR/Tcs1DPI5LAUSJyP9OspIr7hSnIedrO40NWiaewjpWWCbQ8O7DRY1gMmrzqiaCdh1vX8DXK47ZJnaIJAflFiBog6xljpEdg84hYQffmJUISqb2RGpBqzxlCiEhSREWYU1LZULMrHSxRWEbxScJp3TPGdPpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9zD2zCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9zD2zCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC791F00A3A;
	Wed,  5 Aug 2026 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929497;
	bh=W0rQJkbtnhYnXnAF82PIvkescxRO6NFKtWSOLKP565E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f9zD2zCiNHXqk9Mt1ur8gbty3puZz5bTbRKXoUxb9G6tbtCwLoUVRhC+w1CBvkqka
	 6F1S79X28k9iam+gpqKoAC717YHOsxlV5+ap3mr3prZ9ALw7A2o7tiCFx2BDU74yNt
	 8uZla7uPx9qO8vHmGMGdxTN2GPsYzlPJwzKEMJvXzB41W+TKCpDrHzSZunyMIOfN1E
	 IesZbs57bIDnr4LlM7kR8c+mYZ3eSNyMTNLRTMN6wh5m2wOqQ6TgdIW3qNoe7sRchH
	 O91Oqx+Tx7N91XQM4Bgi7fhUDbaWdrYVEV5ujqWUviIl595S15zG6x/y4tBkzgEakM
	 47dD3W9qBXDhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] KVM: s390: Zero initialize data structures for
 inject_pfault_token
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805110455.7200-3-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:31:36 +0000
Message-Id: <20260805113136.CCC791F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Invalid Free / Kernel Panic in kvm_s390_reinject_machine_check=
() due to kfree() on a stack pointer.
- [High] Stack Information Leak to userspace in kvm_s390_reinject_machine_c=
heck() during local machine check reinjection.
--

--- Patch [2]: [PATCH v3 2/8] KVM: s390: Zero initialize data structures fo=
r inject_pfault_token ---
commit 99d37a57e11716f103a611788767010736475aa3
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Zero initialize data structures for inject_pfault_token

This commit fixes a stack information leak by zero-initializing the
kvm_s390_interrupt and kvm_s390_irq structures in
__kvm_inject_pfault_token. This prevents stale stack values from leaking to
host userspace via migration ioctls.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 518a69c55e85c..611dcb5342101 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4474,8 +4474,8 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, con=
st struct kvm_s390_vm_tod_clo
>  static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_=
token,
>  				     unsigned long token)
>  {
> -	struct kvm_s390_interrupt inti;
> -	struct kvm_s390_irq irq;
> +	struct kvm_s390_interrupt inti =3D {};
> +	struct kvm_s390_irq irq =3D {};
>  	struct kvm_s390_interrupt_info *inti_mem =3D NULL;

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing this fix,
I noticed a similar pre-existing issue in arch/s390/kvm/interrupt.c that
appears to pass a stack pointer to kfree().

In kvm_s390_reinject_machine_check(), a stack-allocated interrupt info
structure is passed to __inject_vm():

kvm_s390_reinject_machine_check() {
    ...
    struct kvm_s390_interrupt_info inti;
    ...
    rc =3D __inject_vm(vcpu->kvm, &inti);

When the machine check is a floating machine check, this routes to
__inject_float_mchk(), which unconditionally frees the pointer:

__inject_float_mchk() {
    ...
    kfree(inti);

Could this result in a kernel panic if a nested guest execution triggers
this path, attempting to free a stack-allocated variable?

[Severity: High]
This is also a pre-existing issue, but I noticed another potential stack
information leak in arch/s390/kvm/interrupt.c.

Does kvm_s390_reinject_machine_check() leak uninitialized stack memory
during local machine check reinjection?

kvm_s390_reinject_machine_check() {
    ...
    struct kvm_s390_irq irq;
    ...
    kvm_s390_inject_vcpu(vcpu, &irq);

Because irq is uninitialized on the stack, the padding and fixed_logout
array contain stale data. __inject_mchk() then copies this data into the
persistent vCPU state:

__inject_mchk() {
    ...
    memcpy(&mchk->fixed_logout, &irq->u.mchk.fixed_logout,
           sizeof(mchk->fixed_logout));

Later, when userspace retrieves the interrupt state, store_local_irq()
copies it back out:

store_local_irq() {
    ...
    irq->u.mchk =3D li->irq.mchk;

Could this allow a host userspace process to access uninitialized kernel
stack memory via the KVM migration ioctls, similar to the issue fixed in
this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D2
