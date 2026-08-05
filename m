Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620D413787;
	Wed,  5 Aug 2026 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929571; cv=none; b=FE1jTx2jjf16xtKiG29FbLjg3B2PQ3G5sSbk5jnjNDGvJYI53rxCtYpl/TC5530HUiNxSbiNAaMqdDtBTIDH1VtZM+7FPISdnceHijgJyyr+vKbnCNmqnwQE45QjXlVvl0HLMB49q8s9Dw25YXhn2CdYK5ZJN6ZnTmTAT5DraGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929571; c=relaxed/simple;
	bh=Zc28trPsFqTH1Fx3vXohbf7CkivyWaOCDoHcMyC/8Uo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KbAgtxbDw4MVmv3c+7PTA1mbN9/JXWFUItnspdrH06J0yyiQ5/0fG7u319I80Zui9QfDl5viw5HpKhSr0kPoVAGZhbBEueMuTN9XjrKNLSQVmNkxqf0ZGt8DA5EcDpCQejFqz8r/qV+OPi4AuW/TgBNVyLkuRWuSuhu8BC/W65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgBzQDX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgBzQDX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C761F000E9;
	Wed,  5 Aug 2026 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929569;
	bh=UCax1IorClCIg4OCcaSh9Ti1ly/xvbgzEXJr6UJ9OdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IgBzQDX11fmRlc9wCLhjxwKFR5Lqb3jB7ESs64oFG2mA2J3/BWCYwTuxpJ6Y6WCg1
	 VoiIp3kpONHvUfpOvyM86oDpWfZE3cB3rEuFPmixMpycXRmi4UrNPxd6ZqxUg8Fnn8
	 T5NGYdFTUYkpgXFY7bzFcpMXK7YAKufs2JNVvUuGurgkBFAoTXoRgNY6u12UaLh6OU
	 x4dIThOC91Musb3FohMNW+CWahykB18WcHNOppK3XX+jNl9NeLI45EItL0LC1lWM6u
	 y3JwAqFUuXfrdwCUtER5gCYnBYiEVdcpW7sFnueqmrbkEvw4z0jT/Hwgkd83rS6/mC
	 5tAbTH77Gh1fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] KVM: s390: Fix length check __import_wp_info()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260805110455.7200-9-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-9-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:32:48 +0000
Message-Id: <20260805113249.39C761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> struct kvm_hw_breakpoint::len is a __u64 that is fully controlled by user
> space. This is then assigned to wp_info->len, which is an int. The bounds
> check is done on the truncated value while the allocation uses the
> untruncated one:
>=20
> 	wp_info->len =3D bp_data->len;
> 	[...]
> 	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
> 		return -EINVAL;
>=20
> 	wp_info->old_data =3D kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
>=20
> Use the validated value for the allocation as intended. Without this
> fix userspace can trigger >4GB allocations which will fail and result
> in a WARN due to MAX_PAGE_ORDER.
>=20
> Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D8

