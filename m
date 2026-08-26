Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6623ABB9;
	Wed, 26 Aug 2026 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757591; cv=none; b=emDCZvVsxfkY4EM/t+PTm6Mb0CA1pZfk57POPVF2SubYmrL7kbgaL6e2lBXTo4E4dAmwTP7GyyaLWjwa6H7fV3C4AED8Ws9VufW+oAPVl9sZ9RKiOo2JBlbc7jAFdInnqBdh5z0BlEA1w6cPv7EbJmCASPfi484ZoqqpvlfCdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757591; c=relaxed/simple;
	bh=Gg0/trUdR2RB7tnkzUT0KnFm0WCGxZtxTN1bUqWzNM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UwILAtn/bEmjN/6/nVQR0bnKycLjTrWY85p3lBR2Sf2goxERUjkmfaHP3KspwJpkThiNgIz9/zsZ3kiDusYpZocQd0L47IBhrgS8a8q2MBm2e7Yo9+C3uGV5k8mKKhGs6uS44eVBDbQM5R5xadgVA/RQafY1CL4+XG7udHmo/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt1emhmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt1emhmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43641F000E9;
	Wed, 26 Aug 2026 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757590;
	bh=fyqIMGbsTKbLl6rCDiGKiSbULf0uCtl1PTFDOuooBRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dt1emhmRCPDrEJ9XG4Rwfjszb0aOxH5lt7cMjZ5LTnrAGYgp9DXrfDwfN6/clMl4h
	 KrHOxPxjcjmSnuF8BAeEmB9+Kz8AvHzUvEoOxQdS9TDveBwqADPmqTH8lUOE+KQe4/
	 RpeZVvbn/P253KUHAttP8br2V4coqqHO/1ZeYDtF6unJqMjdzjtIpUT1ivQPpj7G45
	 7EJk6huFCbCh8EkTboVSxIdGTuLpoZyG2K/Bxfb8OfF4bbItVl5xEmBtz6poprwk1g
	 awJwDA/ok0qnDrcZUc0khMWsg4ye90WAJE6By2dyEeWNtsuoE0BpVjeulf/s6AXaSD
	 QRofVkWqwbeyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/21] KVM: s390: vsie: Refactor
 kvm_s390_vsie_destroy and extract reusable methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260826-vsie-sigpi-v5-10-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-10-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:19:49 +0000
Message-Id: <20260826151949.E43641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly introduced helper `kvm_s390_vsie_destroy_page()` calls `=
unpin_scb()` with incorrect arguments and types, causing a direct build bre=
ak and a logical panic.
--

commit 76eef6d237151922051461101295712b30214ae6
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Refactor kvm_s390_vsie_destroy and extract reusable methods

This commit refactors kvm_s390_vsie_destroy() by extracting the=20
gmap shadow release logic into a safe helper and creating=20
kvm_s390_vsie_destroy_page() to reduce nesting. These helper=20
methods are intended for reuse in upcoming patches.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 75676f493ab24..5e41dd151f8e4 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> @@ -1658,24 +1665,29 @@ void kvm_s390_vsie_init(struct kvm *kvm)
>  	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
>  }
> =20
> +static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page=
 *vsie_page)
> +{
> +	unpin_scb(kvm, vsie_page);

[Severity: High]
Does this code call unpin_scb() with the correct arguments?

At this point in the series, unpin_scb() is defined as:

static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
                      gpa_t gpa)

This call passes only 2 arguments instead of 3, and provides a struct kvm *
instead of the expected struct kvm_vcpu *, which breaks the build.

Additionally, could this cause a panic when executing kvm_s390_vsie_destroy=
()
during VM teardown (a path reachable by untrusted userspace)?

At this stage in the series, vsie_page->scb_o is already unpinned and
set to NULL for cached pages. Calling unpin_scb() here will unconditionally
call virt_to_phys(vsie_page->scb_o), which panics when operating on NULL.

Note that this appears to be a patch splitting error where teardown code
intended for a later patch was introduced too early. The build and logic
errors are resolved later in the series by commit
5c64511a5db61f1b968b748560aa62a1a39b08a9 ('KVM: s390: vsie: Lazily keep
original scb pinned after vsie exit').

> +	release_gmap_shadow_safe(kvm, vsie_page);
> +	free_vsie_page(vsie_page);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D10
