Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0A39184A;
	Mon,  3 Aug 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762104; cv=none; b=rXNSRxj4bRf95KZxbDTa0L1Qyw0pWyv1qG3q/4D91mRMXtdmpPTKdn5Rw259QUfCiWrxZ6zw3FjvUAPQZC4ks1K8XxBmS571Z3HXRnk30oc3uDi/bPfdftfQxpffrKzd5+5GmgAFSPoSKZgqkDnqS7eSMdNw/IWstfK6ivcgLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762104; c=relaxed/simple;
	bh=IhUVT6BNrP+0lzxk0HFuBULt0+OCpQ+4N8uXIpO6IoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9ibECIwZvddg/v/6K5Y9IXVbcEuG0oKUi47OG+cEa+7R8/r6ZIkzxTUCaa7S5ePmTBdv18UvegyVQwGujJYf+u/jxpJWP0UmoN9wlWLLqkAZ6p4+p4wMsS5YUI45cBtHQ+PPq6uJ5JcHMcFvlHC5OxxaRLBgu4bQxkI8nsRFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht+iMtfz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht+iMtfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31391F000E9;
	Mon,  3 Aug 2026 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762102;
	bh=St/J+OpfKOq0Z9OVaK0C0yx5nb7OdA5dSbkiK+kIp3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ht+iMtfzA8FQTAoaLdUfjZYwPM0xemv6JVWBvg5h0Jph91cu2qidIVJN2seuBfDM4
	 Cf9P0HVJrsciF8MPQcB9557PKyGgcfzA2vfyAkTbJFhisgYRMjQoAuth8w9N4ettv6
	 k2NVVs+K7kJGg0r9O9tGszsIj898K4ktIsut/hGF2zro8xBLRX3icMQAOddQ4/f3Xd
	 l940j6XXT9ZCZDZBU315tCTUyjpwGkiDrP7I8UGTu6uoC1C+YSxF2kEn3icPlHYly1
	 pKiL29armDU9Pz3rSYV/Hk5x/1SDmKBAA2ZLrH6qTQzLI3r/mKY5wfiynULY2J1Uvu
	 YC9ueveBBQ1Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/13] KVM: s390: Fix leaking of PGM_ADDRESSING to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803124040.126471-7-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:01:40 +0000
Message-Id: <20260803130141.D31391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent large page split causes `large_crste_to_phys()` to =
dereference an invalid address (`-1`), leading to a host kernel panic via a=
ddressing exception.
--

--- Patch [6]: [PATCH v8 06/13] KVM: s390: Fix leaking of PGM_ADDRESSING to=
 userspace ---
commit 7bad2118b8960be854e59fc638949bdda1bbace0
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix leaking of PGM_ADDRESSING to userspace

This commit fixes several key and CMMA operations to return -EFAULT instead
of PGM_ADDRESSING when acting outside of a memslot.

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index ed4259d176295..171b619599089 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -771,21 +773,23 @@ int dat_reset_reference_bit(union asce asce, gfn_t =
gfn)
> =20
>  		if (!crste.h.fc || !crste.s.fc1.pr)
>  			return 0;
> -		return page_reset_referenced(large_crste_to_phys(*crstep, gfn));
> +		skey->skey =3D page_reset_referenced(large_crste_to_phys(*crstep, gfn)=
) << 1;

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential race condition with
the large page handling here.

Because kvm->mmu_lock is only held for reading during this operation, could
another vCPU concurrently split the large page under the read lock (via
dat_split_crste()), clearing the fc bit?

If dat_entry_walk() succeeds, but the page is split before the implicit read
of *crstep in large_crste_to_phys(), large_crste_to_phys() could observe the
cleared fc bit and return -1.=20

Passing -1 to the assembly block inside page_reset_referenced() could
trigger an unhandled addressing exception and panic the host kernel since it
lacks exception tables.

Would it be safer to use the already validated snapshot (crste) instead of
dereferencing *crstep again?

skey->skey =3D page_reset_referenced(large_crste_to_phys(crste, gfn)) << 1;

This same pattern of passing *crstep directly to large_crste_to_phys()
appears to also exist in dat_set_storage_key() and
dat_cond_set_storage_key().

> +		return 0;
>  	}
>  	old =3D pgste_get_lock(ptep);
>  	pgste =3D old;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D6
