Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4808472;
	Mon, 20 Jul 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571184; cv=none; b=QToq7MgjtBRO1qQMGgvNOUyy3olwHo2b+UdKRxkya+u2wpmotwjGd+dEO7j00eUbvzworQ0R0z1vy71BHm8qh+mEWxIe8SKNDfIGQEe+7yJ64Wf0Ce3XMsI/yTtu2myU58FbUAo+w+7E8KDKwdmcRVCigRS9Rqz5ZNoQqj1iLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571184; c=relaxed/simple;
	bh=OF1SvnidqQ0YB5YAg3PuOe7YLn56tuPId12MtsgE35E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdaImlw4P90ysh5TF/fKE0cIAURjcdCW8Ysd/Xa1mpxsKU58ZOPb/LdJhEAnVjrSs8dxTCa4f1uj+0F6xByQAFFSDMLZIQUSIbHWYRu3dgyUpsUXI5S9vvAWPyzyOGNBN/KZz2Ymj7yu9GXM7EUz72xWov0aOMaEHZ65kUZ3HGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWRq9K1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWRq9K1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A431F000E9;
	Mon, 20 Jul 2026 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571183;
	bh=6r3qsa17RiH0tkeDBRF62993DvMIn8NN0DfTTMA0FNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWRq9K1tJu1it4XxWoSdgYJ8OdOoGzGQL0NEITMBHICAjJp6DRHKVrYM7PsfhpCju
	 OV6FMKmrPJt2o5CXmzNqFbedE/LRLpQKdStn2LjXTVuPMMB0yD5fhGE/Ukv4lAPZw7
	 NrepvNXkqZYrK25MpQnMdCQhEljOrBWrJHGIkYXzwlgeAi4VQbG2a0K/zhYpIB+92p
	 5nTWkF/DLidYc7YoSm4veHsX5A+3VjCSORU5/zG0QHiTfdwC8alkqdnMVQSMbCmqvx
	 bzxavDii60TVt8upR4u7nXJSFbjYbhJ3lZWmzIBOzuz8J7cbrD9FrRpTwNVc5HXQje
	 dkomrSjTn+//w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] KVM: s390: pci: Fix missing error codes and
 memory unaccounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260720175819.1723-3-alifm@linux.ibm.com>
References: <20260720175819.1723-1-alifm@linux.ibm.com>
 <20260720175819.1723-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:13:02 +0000
Message-Id: <20260720181302.A4A431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling KVM_S390_ZPCIOP_REG_AEN multiple times on the same device =
causes severe, unbounded resource leaks and state corruption.
--

--- Patch [2]: [PATCH v3 2/4] KVM: s390: pci: Fix missing error codes and m=
emory unaccounting ---
commit bb1306d6a0da97f9d5b884d1e67a7c8d12b6a908
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix missing error codes and memory unaccounting

This commit fixes error paths in kvm_s390_pci_aif_enable() to properly
propagate error codes on failure and rollback memory accounting.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index dd17f8a7b4734..9fdb6e383b189 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c

[ ... ]

> @@ -293,14 +293,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev =
*zdev, struct zpci_fib *fib,
>  	}
> =20
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(zdev->kzdev, pcount))
> +	rc =3D account_mem(zdev->kzdev, pcount);

[Severity: High]
This is a pre-existing issue, but can calling the KVM_S390_ZPCIOP_REG_AEN i=
octl
multiple times on the same device cause resource leaks?

Looking at kvm_s390_pci_aif_enable(), there doesn't appear to be a check to
verify if Adapter Interruption Forwarding (AIF) is already enabled for the
device. If it is called repeatedly, it seems account_mem() will blindly
overwrite kzdev->user_account and kzdev->mm_account:

arch/s390/kvm/pci.c:account_mem() {
    ...
    kzdev->user_account =3D user;
    kzdev->mm_account =3D current->mm;

    return 0;
}

Does this leave the previously allocated airq_iv and sbv bits leaked, along
with the previous user_struct and mmgrab references? It also looks like this
would permanently elevate the locked_vm and pinned_vm counts for those page=
s,
which could potentially lead to memory exhaustion on the host.

> +	if (rc)
>  		goto unpin2;
> =20
>  	/* AISB must be allocated before we can fill in GAITE */
>  	mutex_lock(&aift->aift_lock);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175819.1723=
-1-alifm@linux.ibm.com?part=3D2
