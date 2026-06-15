Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB103F39FE;
	Mon, 15 Jun 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529719; cv=none; b=bjjAYQrPL7hy/oha/PJwPGrFt85L2aUy7jLstY7t35LR/tqZ+WRsE+Sy3OVvseCvbL4Svk/JkRKQvHtI4toPJQNTVZKhZuD8k9X4Up9MCDlWHaTn9IyZAfH54DXHKKlxygR+r8i/ER4fzzQm7F8pq7qaki+qmQIIfIeaDcQ5o0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529719; c=relaxed/simple;
	bh=iEef8TRCS9zV22imcGdC9mfgEzyAY7Y6qLs60HjnZq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=th+e58vXyFv6rpXovyAHY9BpNvaqSCBuQZBWKgT8BWZquFafyLsGonjjxOrFYUwuHlw17r57C0rqJDbWo3m0EEPT3D0ocLsgyw+dqHusxozQOG8fTzjYNyF24M1VZAZODfTbPDcVpwIcsIhejtuFBbTDgmz2V97BNr1kXMVJeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbL1sOw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbL1sOw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F84D1F000E9;
	Mon, 15 Jun 2026 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529718;
	bh=5GwdBq/cMTjESFPfUzt8oxdW/f4oReIXlY197p8o+Xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbL1sOw6vF4LLA5f6ZRoeqUViJ4UP8yUEHuW2Eq7k1jN9Tb20+oiqaTMlsCa/X52p
	 WpcWzZWL3g/KLcSzl0rkOWNpSmCNi44bGn67sBFeYedgjQiRnQndH2Q6RSa4p4l2CJ
	 28eDkAcyHuxitRdoe+aTp8SjHsp9YEjJOKz250lYG8hpSrjMHwrrDZNa1aLODAsPIu
	 bb+cvC+pEopYgiije6rGTkTRYff0/kw8Y3O7Dae/ev7nkc/NMdaVbirTuZQX1l0VW9
	 kFKc2HuR2E9kpxgDOKwsTcYFGj7kkkX0QYjkQ2wtZiAvq36H7yjYkDpO4EQwcno3a/
	 mJUMBwHi1zl8A==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 15/17] KVM: s390: Add map/unmap ioctl and clean
 mappings post-guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260615124243.187614-16-imbrenda@linux.ibm.com>
References: <20260615124243.187614-16-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:21:57 +0000
Message-Id: <20260615132158.5F84D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added `!addr` check in `kvm_s390_adapter_map` and `kvm_s3=
90_adapter_unmap` incorrectly rejects GPA 0.
--

commit a3f46a9fac83fcdf67e052053b6923a848a2c796
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Add map/unmap ioctl and clean mappings post-guest

This commit adds map and unmap ioctls for s390 adapter set indicator pages.
It introduces lifecycle tracking for mapped pages using pin_user_pages_remo=
te
and adds statistics counters to track map and unmap requests.

Message-ID: <20260604192755.203143-2-freimuth@linux.ibm.com>

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 =
addr)
> +{
> +	struct s390_io_adapter *adapter =3D get_io_adapter(kvm, id);
> +	struct s390_map_info *map;
> +	unsigned long flags;
> +	__u64 host_addr;
> +	int ret, idx;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;

[Severity: Low]
Does this address check incorrectly reject mapping guest physical address 0?

The ioctl argument addr represents a guest physical address. In the s390
architecture, guest physical address 0 points to the Prefix Save Area, which
is a valid memory location. Treating an address of 0 as an invalid mapping
request rejects a legitimate architectural address.

> +
> +	map =3D kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
[ ... ]
> +static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u6=
4 addr)
> +{
> +	struct s390_io_adapter *adapter =3D get_io_adapter(kvm, id);
> +	struct s390_map_info *map, *tmp, *map_to_free;
> +	struct page *map_page_to_put =3D NULL;
> +	u64 map_addr_to_mark =3D 0;
> +	unsigned long flags;
> +	int found =3D 0, idx;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;

[Severity: Low]
Similarly here, should this unmap function allow guest physical address 0?

> +
> +	spin_lock_irqsave(&adapter->maps_lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615124243.1876=
14-1-imbrenda@linux.ibm.com?part=3D15
