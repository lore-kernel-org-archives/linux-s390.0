Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26836E497;
	Thu,  9 Jul 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610902; cv=none; b=b0FjrzD8slWidtiovDQBHBAhKPezr2q2H4KaRVTSQfkWI9AQkNwCtlskGAORzM2sxGXNO/MLEP5+KSmMJMlfg0UCt7lMtnYv4xXVwQkOcN0iYypMye5et5NaOU25DFSCa13lA6t7eyWdfOJABKOl4zLtS185Mta52cKXbS5fhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610902; c=relaxed/simple;
	bh=4LE43HFdnu9J+Hnq0hr7LtLo/RCEv8cGzQfUpMKKOmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BD9PVTfYzbreNWaYnhqDxjAh7Gn7S+Aj6nqq48rsAsqWRJKprqWPcE1O/eoj9uJpj4uLOGatdj98pa4/VDb3JVBQ9mrSr8tkzl9khOg7IDvrdoiLlS7c501Msb72GXN2fJ4Wez3KrazjhLZZsIurFuS+8jMb8tII/StQ3TPnBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYdYncZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYdYncZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA50D1F000E9;
	Thu,  9 Jul 2026 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610901;
	bh=YYNiq4S15DjqsDd6zl+v2H9ZWdITMR0swfeRDY309kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYdYncZTR9HhrfjQ1k6gAhCX3rwgUott4AAvePsz7BuwnekP/9KsrswIftEJX5UjS
	 ylb4HhwJ3Qu8fjBeII3ELE+qqg/u9lJn6Jcm6dtwsXukIRDoCHxku4p9Si8ksoMuVf
	 ScyuLdCkD1k84of8OL930QckDoYs7culWsr/t3HIjcwQJ5I6SSThzWIIk1Kwwxi4OG
	 aNQTM1eWmKVmhN7L2n0/cyq/MWQUXySwx6pC0yy//HuyIYSeEmulSjI68ZShd3Ju5A
	 kGk72TDZz/UYGOIy2FTE47SjiyNiOhx2En3ZpMZz3nRieRa06Dpcuy2faMUD9xyQ6x
	 PcGaFOeNpNykg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/21] KVM: s390: vsie: Add helper to pin multiple guest
 pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-13-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-13-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:28:20 +0000
Message-Id: <20260709152820.BA50D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect address calculation for unaligned GPAs in `pin_guest_p=
ages`, leading to data corruption for multi-page contiguous buffers.
--

--- Patch [13]: [PATCH 13/21] KVM: s390: vsie: Add helper to pin multiple g=
uest pages ---
commit b2d504ec12f509941a6b52b4ad1605645f085955
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add helper to pin multiple guest pages
   =20
This commit introduces helpers to pin and unpin multiple consecutive guest
pages in guest-1. It moves the existing pin and unpin methods to avoid
forward declarations and iterates over pages to store guest and host addres=
ses.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 1734215ae73a9..644b37582b5c8 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -240,6 +245,40 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t =
gpa, hpa_t hpa)
>  	mark_page_dirty(kvm, gpa_to_gfn(gpa));
>  }
> =20
> +/* unpin multiple guest pages pinned with pin_guest_pages() */
> +static void unpin_guest_pages(struct kvm *kvm, struct kvm_address_pair *=
addr, unsigned int nr_pages)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nr_pages; i++) {
> +		unpin_guest_page(kvm, addr[i].gpa, addr[i].hpa);
> +		addr[i].gpa =3D 0;
> +		addr[i].hpa =3D 0;
> +	}
> +}
> +
> +/* pin nr_pages consecutive guest pages */
> +static int pin_guest_pages(struct kvm *kvm, gpa_t gpa, unsigned int nr_p=
ages,
> +			   struct kvm_address_pair *addr)
> +{
> +	hpa_t hpa;
> +	int i, rc;
> +
> +	/* the guest pages may not be mapped continuously, so pin each page */
> +	for (i =3D 0; i < nr_pages; i++) {
> +		rc =3D pin_guest_page(kvm, gpa + PAGE_SIZE * i, &hpa);

[Severity: Medium]
Could this address calculation cause issues if the initial gpa is unaligned?

If a caller passes an unaligned gpa to pin_guest_pages() (for example, 0x10=
10),
adding PAGE_SIZE * i propagates this initial page offset to every subsequen=
t=20
page. This would mean the calculation requests 0x2010, 0x3010, and so on,
skipping the guest memory between 0x2000 and 0x200F.

Would it be safer to align the gpa calculation for the subsequent pages to
ensure a truly contiguous buffer is correctly pinned?

> +		if (rc)
> +			goto err;
> +		addr[i].gpa =3D gpa + PAGE_SIZE * i;
> +		addr[i].hpa =3D hpa;
> +	}
> +	return i;
> +
> +err:
> +	unpin_guest_pages(kvm, addr, i);
> +	return -EFAULT;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D13
