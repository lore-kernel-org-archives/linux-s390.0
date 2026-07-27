Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B241A79A;
	Mon, 27 Jul 2026 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171583; cv=none; b=CmbYmN7jOha4A44X1ZIwaYsQONqF1NrIbaOfgY7KiM7xEMfJR6YVwpTIPRG6cFcgyTajAyPdA4nHwVU0ED7Pxln+FXx28jLwacpskxMdPecuTZQ+1OJ4RZOqwKzitrRwMDntsphlGlhHvN4cyS4XzyVfIU6UOMsVrzhu0EQ9KfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171583; c=relaxed/simple;
	bh=9z6ml388rJwAmtN43qezCXwoxTTUoWBtV2IA7r4y+Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EP5OoERNskVsNnR602IJ541nfAqrAvZkrnmqJbHEzWOx4mCJifzS87eOlpbmANRNDQe5EWRC+sEKhwrMm4YGCMPmD7far+KpSMen64fFN29sXiVjIGQL2I9WxNJScPx2fRm7wJlG+ncbSXwtqfS5SNrf2xvuiDdPQwGhdElBQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5Q/i1iL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5Q/i1iL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56DF1F000E9;
	Mon, 27 Jul 2026 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171582;
	bh=ZpJMofX46IsCnF5ExCupu6vqNbGM4LnLsHZRA2GgQAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5Q/i1iL1FQ2FQYxS2bROJG5D9gZHkTS38cbmW9EFtn2L/U/DDEri4VU+jQhHStHa
	 3ic7//FF3OT1krSn7g3ZtrBQy1eIZprxkjoDn+/9vrq4f24ds2ztfG40med7zeibRR
	 NA/d/pIWhfnOz1WB9XJF/q4K0kHjtPeVj/Txb383GmeHnr5d07j45vpEmxzalEIssK
	 7Iz8XeMoaPn9GjQi58EKHF1YBvmptljJ+759+ePISALirSOyQ9R62CskilA4JPfxxl
	 sND52mIj+AdInaOIgOrlPUILN2mpVetvbkqkAx7LD9CaJnur7Aql1+u50sIU2S7Zcj
	 K5TRnLjQzWASA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] KVM: s390: Return -EINTR if a signal was
 pending while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260727150254.236021-8-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:59:41 +0000
Message-Id: <20260727165941.B56DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `handle_mvpg_pei` function incorrectly leaks positive program =
exception codes (e.g., PGM_ADDRESSING) to userspace through the KVM_RUN ioc=
tl, instead of injecting them into the guest.
--

--- Patch [7]: [PATCH v3 07/10] KVM: s390: Return -EINTR if a signal was pe=
nding while faulting-in ---
commit d199a77e2748da899d6f673aade7f1a0a260ebe8
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Return -EINTR if a signal was pending while faulting-in

If a signal is pending while trying to fault-in a page, return -EINTR
instead of -EAGAIN.

> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 1980df61ef304..08f2128db1473 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -369,27 +369,25 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)

[ ... ]

>  	rc =3D guest_translate_address_with_key(vcpu, vcpu->run->s.regs.gprs[re=
g1],
>  					      reg1, &dstaddr, GACC_STORE, 0);
>  	if (rc)
>  		return kvm_s390_inject_prog_cond(vcpu, rc);
> =20
> +	kvm_s390_retry_instr(vcpu);
> +
>  	do {
> -		rc =3D kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), tr=
ue);
> +		rc =3D kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), fa=
lse);
>  	} while (rc =3D=3D -EAGAIN);
>  	if (rc)
>  		return rc;

[Severity: High]
This is a pre-existing issue, but does this leak positive program exception
codes to userspace instead of injecting them into the guest?

If a guest executes an MVPG instruction with an unmapped guest address,
kvm_s390_faultin_gfn_simple() can return PGM_ADDRESSING (which is 5).

Because this positive value is returned directly instead of passing it
through kvm_s390_inject_prog_cond(), it appears to propagate all the way up
to the KVM_RUN ioctl return.

Userspace VMMs like QEMU might not update run->exit_reason on a positive
return code, potentially leading to stale exit reasons and state corruption,
and the guest is denied the architectural program exception it is owed.

Should this be wrapped in kvm_s390_inject_prog_cond(vcpu, rc) instead?

> -	kvm_s390_retry_instr(vcpu);
> +	do {
> +		rc =3D kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), tr=
ue);
> +	} while (rc =3D=3D -EAGAIN);
> =20
> -	return 0;
> +	return rc;

[Severity: High]
This is also a pre-existing issue for the same reason. Does the destination
fault-in need the same kvm_s390_inject_prog_cond() wrapper to prevent
positive program exception codes from leaking to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D7
