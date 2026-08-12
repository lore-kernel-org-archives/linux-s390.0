Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407745C6F7;
	Wed, 12 Aug 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543702; cv=none; b=mAwGYfnvPJjYs+KnQuR91vMrZkkCoDh0C0ppA97nd7SIyyW0pFk4RG2ztwv25Hn/WWjVf8e4TGINhq4JQC087JpXzc86H0FUZeWL16PTLAzTEk0Y4nxv8hLDgjP82pj2j/tW1yijkhUHFeIhZ6YX5cHlBnIWivX7bMwl+Sgd8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543702; c=relaxed/simple;
	bh=23KxbqkkoAEYUGKnibLYVRm+N5mgGjnx3LkrPtAY9jo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y5qmq8fxYs+eBKfUH0tKpRC8xnKSGT9OO98Ze5+w7zdIBMXvfzCDmzgPLVwReW++RYcx04/VNSHWbn9Ow4EwYv0WPf7A2bBYUfAFA5FSFAP1DOsA930A/dBHCgnBPPyjnxigoxzmiRtEHpnp37LyVfg/n4oMG36YFuGmL0Rwd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxHoZ6I4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxHoZ6I4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D8F1F000E9;
	Wed, 12 Aug 2026 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543701;
	bh=7V8zGyi0j4jOX9csC3EU3iianV0X6yEynlTIcXvHqkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxHoZ6I4zwuMEdN8Ne5IHPdaHsA0FJg4FQYu0wR0fRbjb+MoQFUP6aQPI9OtYW7kr
	 WoWgjQF0y5mAFVBX9jRhh04fuwIFLEtBL10jR44P2htjfNtCRDJMlVDHGIq8xAgoqk
	 ZJmwTgWCpP7U+VIKkUI+CyeYyi9YHjTIOdiGkl1STTwc/I21Sdql2jhidCsIuFoB3A
	 dRaK/ove40o7kUGmzvbTLclUluXXqXoAWznKoMDFsd+++X96YKP81OMv22dPrpESHY
	 C88o/56vQkO4EURaRoOHDa+JrpReIuQbVTkQdA0EJkaFGeY++/35kKrOBamkGRa6pk
	 542cn6oGO+4cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/20] KVM: s390: vsie: Move pin/unpin guest page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-6-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-6-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:08:19 +0000
Message-Id: <20260812140820.52D8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] pin_guest_page() acquires memory using FOLL_GET instead of FOL=
L_PIN, which is unsafe for hardware-direct memory accesses and exposes the =
host to the GUP-DMA data corruption bug.
--

--- Patch [6]: [PATCH v4 06/20] KVM: s390: vsie: Move pin/unpin guest page =
---
commit 987f41bc833e63c2dc670459a5500894b2f97ace
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Move pin/unpin guest page

Move {,un}pin_guest_page() up in preparation for the next patch. No change
intended.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 4b67bde0535fc..1b4f6b1691a27 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -150,6 +150,32 @@ static int prefix_is_mapped(struct vsie_page *vsie_p=
age)
>  	return !(atomic_read(&vsie_page->scb_s.prog20) & PROG_REQUEST);
>  }
> =20
> +/*
> + * Pin the guest page given by gpa and set hpa to the pinned host addres=
s.
> + * Will always be pinned writable.
> + *
> + * Returns: - 0 on success
> + *          - -EINVAL if the gpa is not valid guest storage
> + */
> +static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
> +{
> +	struct page *page;
> +
> +	page =3D gfn_to_page(kvm, gpa_to_gfn(gpa));

[Severity: Critical]
This isn't a bug introduced by this patch, but is it safe for
pin_guest_page() to acquire memory using gfn_to_page() instead of FOLL_PIN?

Because gfn_to_page() only elevates the page refcount (FOLL_GET),
page_maybe_dma_pinned() evaluates to false. If a guest uses nested
virtualization and its hardware control blocks are backed by a file on the
host, could this expose the host to the GUP-DMA data corruption bug?

When the host filesystem performs writeback, it expects the page to remain
immutable and does not bounce the page. If the SIE hardware acts as an
independent DMA engine bypassing the host MMU, it might continue writing to
the physical memory while the data is in-flight to disk.

Could this cause checksum failures or data corruption in host filesystems
like ext4 or btrfs? Should this be updated to use a FOLL_PIN-enabled helper
(for example, configuring kvm_follow_pfn with .pin =3D true) to properly lo=
ck
the page for hardware access?

> +	if (!page)
> +		return -EINVAL;
> +	*hpa =3D (hpa_t)page_to_phys(page) + (gpa & ~PAGE_MASK);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D6
