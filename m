Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856C34B43F;
	Mon, 13 Jul 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964487; cv=none; b=l52wn3h88sdyIdsQt0Lrd8mIzs2fHq4yBA89dqoRjdIuP3v2iStE1obid+gm81GKtPW0efBLnt5///zcIae/xuedi5byFdmVBigLS3QITGnI2XJlwkOphJkU/wuEhkpWqWHy18/wGT/JgCPxL3cVdiUiglLb4zi6jD0ClWJ4X9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964487; c=relaxed/simple;
	bh=PiUkkafRY9qcxkKxhiyDg1XPlp95th/cbl2bn7tcKCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JrTKuKP+/VUNsalouoxV+UhQCH3JXYtUTszQ3JBm1wEt7N+i+r4GBEZCX6ZdBXFZb85XFzz97kGI4IHEUr0clqFsy/m8qdM6tH6HKp3wKhac7dMVPRJCuB1YwlJLSK5hej5xdLzYwviXZgQhdAWRPdS1L2Hg5BArWJxcwOp2PgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ2KVRkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ2KVRkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC71F000E9;
	Mon, 13 Jul 2026 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964486;
	bh=qxo8K6JbaxSi3cT7ISYAM/yM/hMSM2DEgYR5OFycc+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZ2KVRkzIFZ9+RT/EOIJvuFSQCRuOmkVDp6kgQGnfkDlQhLI2nZrYn1adlRHpakCU
	 XmAaHc7eqrXmtSCaOvc3wQi98hsBZJIHfDqQlvJ+KlaQQdx/AZ+lJWuJ+tiTlLQAAz
	 +N7HApTUv7/8xHoJNvWILntKshx2KVkPl++aZ/Dkb9Ep9oT/FVnve/0NWjvuPtbZXS
	 RIX3DLdnDQD15c3NTyNsxTT+ChYPA6Wt1KMtuvboed+GR2qQa3ZKGrp2vdRYBBzKQm
	 f3ABaa24DWTDnXbB3s9QOB9q9hLRVqKO9nahNM8IQI6P5jxoyy38uoRztJVmi2HWgt
	 yeD847VcQK8uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/5] KVM: s390: pci: Fix missing error codes and
 memory unaccounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260713172600.1284-3-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
 <20260713172600.1284-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:41:25 +0000
Message-Id: <20260713174126.05FC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `unaccount_mem()` incorrectly relies on `current` to reverse memor=
y accounting, allowing arbitrary processes to corrupt their own memory limi=
ts.
- [High] Unrestricted overwrite of AIF structures on repeated ioctl calls l=
eads to severe memory and resource leaks.
--

--- Patch [2]: [PATCH v1 2/5] KVM: s390: pci: Fix missing error codes and m=
emory unaccounting ---
commit 38461cd36a2d54b4c7ee766e7c866405617494d9
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix missing error codes and memory unaccounting

In kvm_s390_pci_aif_enable(), two error paths failed to set an error code
and did not roll back memory accounting on failure. This commit propagates
the error code and calls unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabli=
ng interrupt forwarding")

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5bbbb1de4b5a0..42db20c2afca5 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -282,14 +282,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev =
*zdev, struct zpci_fib *fib,
>  	}
> =20
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(pcount))
> +	rc =3D account_mem(pcount);
> +	if (rc)
>  		goto unpin2;
> =20
>  	/* AISB must be allocated before we can fill in GAITE */
>  	mutex_lock(&aift->aift_lock);
>  	bit =3D airq_iv_alloc_bit(aift->sbv);
> -	if (bit =3D=3D -1UL)
> +	if (bit =3D=3D -1UL) {
> +		rc =3D -ENOMEM;
>  		goto unlock;
> +	}
>  	zdev->aisb =3D bit; /* store the summary bit number */
>  	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
>  				    AIRQ_IV_BITLOCK |

[Severity: High]
This is a pre-existing issue, but could this unconditional overwrite of
zdev->aibv lead to a memory and resource leak?

If a userspace caller issues the KVM_S390_ZPCIOP_REG_AEN ioctl multiple tim=
es
for the same device, kvm_s390_pci_aif_enable() lacks state validation (e.g.,
verifying zdev->kzdev->fib.fmt0.aibv =3D=3D 0).

Would this cause the code to repeatedly pin new pages, allocate new airq_iv
structures, and blindly overwrite the zdev->aibv and zdev->aisb pointers,
permanently orphaning the previously allocated resources?

> @@ -333,6 +336,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	return rc;
> =20
>  unlock:
> +	if (pcount > 0)
> +		unaccount_mem(pcount);

[Severity: High]
This isn't a bug introduced by this patch, but does unaccount_mem()
incorrectly rely on current to reverse memory accounting?

If process A pins memory via ioctl (accounting against process A's limits) =
and
passes the KVM file descriptor to process B, and process B closes it, the
file's .release handler triggers KVM unregistration.

Calling unaccount_mem() in process B's context would subtract from process =
B's
limits while leaking process A's limits.

Could this allow an unprivileged process to artificially underflow its
locked_vm and pinned_vm limits, bypassing RLIMIT_MEMLOCK and allowing
unlimited memory pinning?

>  	mutex_unlock(&aift->aift_lock);
>  unpin2:
>  	if (fib->fmt0.sum =3D=3D 1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713172600.1284=
-1-alifm@linux.ibm.com?part=3D2
