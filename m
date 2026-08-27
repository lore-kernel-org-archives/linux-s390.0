Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAE48822B;
	Thu, 27 Aug 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846520; cv=none; b=eroTdG72f3Zmo3RwdvNk5ajMlqV5xg//kd8x3E9erbxTgDW0HeNs09OaRmKBDnKtMkh901f8a6Iey4oajOEsldpND9RNvWZknnCAYu+NTjwtl9kogg1Xto7WtWClYa0YfcZ21USn3c90WNGCossVOIbtI4T+kKq4PJg+35/Ntqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846520; c=relaxed/simple;
	bh=LNI07TWV3r9UmXvGvmfswHWIITk5hCeNaW1YB7rX0EU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bVIlvIHYjTvxMkZt6DLafGg4ZHf6lkWfAkXA6bHf3nWKT5KHdZD750PNVFu+yPH0tS/FV3rYkAY3eppBySId3LS/d/ihs0wpu2Dqo6DUQokdkYht3jDVxqG+bRwqsD7xtWbLc2TUx8hWM1djlxz8bjhMLPtJEND7dwuXJJa4Zzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN51uHCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN51uHCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01AE1F000E9;
	Thu, 27 Aug 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846518;
	bh=slP1lzSQ+q8oC6bnIWGYCMmoSVAuCEOAB/jWGhwaUoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aN51uHCydkN1OTGHgYemWpt98ySZWExBZ436ibWbcBGcDjnu36Qnn9u2hDweOkk3z
	 nSI9I7jxXfNmjVjjc7ITpBR+FAGbf4K1m8LClQWrF4htQHqeMQ/RO+gHJ1PlCPEGAU
	 WFaBc2xXHRQk0sn+qhVFU3uj1OebL6GP1MCfuPvvrbWkcJzik5djGxS/4RnX5LOoTt
	 57zf0CKXSqA/9o1NxPfGnI69ezL6jglGRy6BowqJt43m/b+pYKVm8Cg2mCdTKkF/Kz
	 MMyoODPjz2K6EODZq8PPgCA1+X8Wqe9uUjF+MYKNmSgd5YP21a5YkuEsJpolzety2V
	 Apxxf5YtBnv2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/21] KVM: s390: vsie: Add helper
 unshadow_intercept()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260827-vsie-sigpi-v6-12-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-12-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:01:57 +0000
Message-Id: <20260827160157.E01AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `unshadow_intercept()` clobbers the original SCB's `gbea` and `icp=
tstatus` fields with uninitialized or stale data on early validity intercep=
ts.
--

commit 34fcf2e024c20552fa013d88fba35acdf5dfc65a
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add helper unshadow_intercept()

This commit extracts an unshadow_intercept() helper from the existing SCB
unshadowing logic. It uses this helper in early error paths to copy only
intercept information back, avoiding clobbering the timer and guest-state
fields of the original SCB when the rest of it hasn't been shadowed yet.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> +static inline void unshadow_intercept(struct kvm_s390_sie_block *scb_o,
> +				      struct kvm_s390_sie_block *scb_s)
>  {
>  	scb_o->icptcode =3D scb_s->icptcode;
>  	scb_o->icptstatus =3D scb_s->icptstatus;
>  	scb_o->ipa =3D scb_s->ipa;
>  	scb_o->ipb =3D scb_s->ipb;
>  	scb_o->gbea =3D scb_s->gbea;
> +}
[ ... ]
> @@ -641,7 +650,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
> =20
>  	rc =3D prepare_cpuflags(vcpu, vsie_page);
>  	if (rc)
> -		goto out;
> +		goto out_validity;
[ ... ]
> @@ -755,10 +764,13 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
> =20
>  	prepare_ibc(vcpu, vsie_page);
>  	rc =3D shadow_crycb(vcpu, vsie_page);
> -out:
>  	if (rc)
>  		unshadow_scb(vcpu, vsie_page);
>  	return rc;
> +
> +out_validity:
> +	unshadow_intercept(vsie_page->scb_o, &vsie_page->scb_s);

[Severity: High]
This isn't a bug introduced by this patch, but won't this call clobber the
original SCB's gbea and icptstatus fields with uninitialized or stale data?

If shadow_scb() fails early, for example when prepare_cpuflags() detects
an invalid CPU flag set by L1, it triggers a validity intercept and jumps
to out_validity to call unshadow_intercept().

However, at this early point in shadow_scb(), scb_s->gbea and
scb_s->icptstatus have not yet been populated from scb_o. Consequently,
this writeback overwrites the nested guest's original SCB with stale data
from a previous execution (or zeros), destroying any updates L1 made to
these fields prior to triggering the validity intercept.

While this patch successfully stops the clobbering of timer and guest state
fields on early exits, does grouping gbea and icptstatus into this shared
helper inadvertently preserve the data corruption for these specific fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D12
