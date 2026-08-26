Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC49444701;
	Wed, 26 Aug 2026 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757929; cv=none; b=gTOHzTAOCusIKnVy+a7cGIHV/PKLk/deOfbEo8WNxjhB0LaYP6BWB8UN7cyD7DPU7QQZLSmauqDik0gXFdbYr9egPo2bJq8OmvTAcrainRsRvyBBO/B/EONAddW/4tAtdoQD5Pf2CsIJBaGtKYn2KOKcV1a5iMFtmwQJlPvBJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757929; c=relaxed/simple;
	bh=z7EsTq7XIyVarF5pbfcGyr0WRhJP62yyohqR3naqeYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/kk5P15lsjFg9KXhhfqirEUtRnq5+Uo4vY/jlVtgn75VI+x/R66yq7I4FkF0EeaCN+UiDSsLkOZ4z3ivkfFu+qKQuqlGk9kERwGtdk7eNcNIEIgk+qSr49KqU31HvuOAs8fAxAdqClN5JggbTbkVHrZIAbHzg8sxltT1/MXgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+WziJQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+WziJQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D5C1F000E9;
	Wed, 26 Aug 2026 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757925;
	bh=ydFqx/iunRoES9s8Rbif6dqus9OylgUD7RlRpCt1wHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+WziJQ3decmZW925MFy/ziNpMQvSgbUFG57V8CPFx6WqRcVLZmACEVLPkZLkEmRN
	 BSVtFxxVTiR4i011lwc9thoRPLRIsUIdpYeRMEcROOgABxqQWs3Ryg2XyxWYSQ+FeW
	 C+qXne+6pbG2+ct5GgofqPwEEvj3SsN4kRq2XOwegw4RpctOlJvB4hQ2J/eM3UugeL
	 1LJNb4UtQDI5XRJz7IQsv+CWVeMBwAU2QeFQcTjIV9Wnu0D5SlGtUQXa/UQTVFQNZI
	 wSkMimMc0dKaTGUa8GygMAo8a3kle31uzOPuWIKwgWzSMgHTLh6vrDkNz2Hm1AIwfC
	 OD1gC6xg2mgUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/21] KVM: s390: vsie: Lazily keep original scb
 pinned after vsie exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-13-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-13-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:25:24 +0000
Message-Id: <20260826152524.C3D5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Removing the old SCB address from the XArray when recycling a =
vsie_page causes an unbounded host memory leak.
- [High] Unconditional `xa_store()` silently overwrites concurrent entries,=
 bypassing KVM's protection against concurrent nested SCB execution.
- [High] Misrouting of addressing exceptions to the 'double use' path cause=
s improper guest PSW rewinding.
--

commit 5c64511a5db61f1b968b748560aa62a1a39b08a9
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Lazily keep original scb pinned after vsie exit

Keep the original SIE control block (SCB) pinned and only lazily unpin
it on reuse of the vsie_page for a different SCB. Track pinned pages and
ensure stale pins are released when needed.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 988370f491bf5..24af48af89cd9 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> @@ -1575,47 +1606,65 @@ static struct vsie_page *get_vsie_page(struct kvm=
 *kvm, unsigned long addr)
[ ... ]
>  	} else {
>  		/* reuse an existing entry that belongs to nobody */
>  		while (true) {
> -			vsie_page =3D kvm->arch.vsie.pages[kvm->arch.vsie.next];
> +			pages_idx =3D kvm->arch.vsie.next;
> +			kvm->arch.vsie.next++;
> +			kvm->arch.vsie.next %=3D kvm->arch.vsie.page_count;
> +			vsie_page =3D kvm->arch.vsie.pages[pages_idx];
>  			if (try_get_vsie_page(vsie_page))
>  				break;
> -			kvm->arch.vsie.next++;
> -			kvm->arch.vsie.next %=3D nr_vcpus;
>  		}
> -		if (vsie_page->scb_gpa !=3D ULONG_MAX)
> -			xa_erase(&kvm->arch.vsie.addr_to_page,
> -				 vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
> -		/* Mark it as invalid until it resides in the tree. */
> -		vsie_page->scb_gpa =3D ULONG_MAX;
> +
> +		unpin_scb(kvm, vsie_page);
>  	}

[Severity: Critical]
Why is xa_erase() removed here? Leaving the old guest SCB address mapping in
the XArray when recycling a vsie_page allows a malicious guest to repeatedly
execute vSIE with unique SCB addresses, continuously consuming host kernel
memory by allocating new XArray entries. Could this lead to an unbounded
host memory leak?

> =20
> -	/* Double use of the same address or allocation failure. */
> -	if (xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT=
, vsie_page,
> -		      GFP_KERNEL_ACCOUNT)) {
> +	rc =3D init_vsie_page(vcpu, vsie_page, addr);
> +	if (!rc)
> +		xa_store(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vs=
ie_page,
> +			 GFP_KERNEL_ACCOUNT);

[Severity: High]
Does xa_store() here bypass the concurrent double-use protection?

The baseline code used xa_insert() which gracefully returns an error if an
entry already exists, preventing two vCPUs from executing the same nested S=
CB
concurrently.

By replacing this with an unconditional xa_store(), the second vCPU will
silently overwrite the XArray entry. Both vCPUs will enter nested SIE using
different shadow structures for the same physical guest SCB, and when they =
exit,
both will concurrently write back to scb_o in unshadow_scb().

Could this cause severe nested guest state corruption?

> +
> +	mutex_unlock(&kvm->arch.vsie.mutex);
> +	if (vsie_page_new)
> +		free_vsie_page(vsie_page_new);
> +	if (rc) {
> +		vsie_page->scb_gpa =3D ULONG_MAX;
>  		put_vsie_page(vsie_page);
> -		mutex_unlock(&kvm->arch.vsie.mutex);
> -		return NULL;
> +		return rc < 0 ? ERR_PTR(rc) : NULL;
>  	}

[Severity: High]
If a guest provides an invalid SCB address, pin_scb() injects a PGM_ADDRESS=
ING
program exception and returns 1. Here, rc < 0 ? ERR_PTR(rc) : NULL will con=
vert
this 1 into a NULL pointer return.

The caller kvm_s390_handle_vsie() interprets a NULL return strictly as a 'd=
ouble
use' scenario and executes kvm_s390_rewind_psw(vcpu, 4). Doesn't this
incorrectly rewind the guest PSW after a program exception has already been
injected?

Furthermore, if follow-up patches in the series return ERR_PTR(rc) directly
(evaluating to ERR_PTR(1)), an IS_ERR check in the caller will fail to catch
it because 1 is a valid pointer address, leading to a host kernel panic when
dereferenced.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D13
