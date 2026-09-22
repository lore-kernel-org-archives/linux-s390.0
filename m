Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F162E6CB8
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092182; cv=none; b=JpjvoLRrAIvgqATSTbu4S2eTYyTIu1p6aqh4c7E6EWR1VbgAYikLHG4/DuHbziSsD6EyijFImKYLcjldj8kFJK3tz9yYAbjAbPl8NA101X0EMjQ2I3TpUKfkYT3mSRLR+AT2j787q3Ag2ngY/ATOlEvcwe0D+SEIDPfGPgFuWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092182; c=relaxed/simple;
	bh=oe0+t3hPTgnXuWC/zsid62EVXVvI0uMcqrtA55wEMZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gfaIX3imePVznkfOHY58dO9hAhaTNx/60qkzsE8BxVCk2GNdf2t8FL+zESRxgHLHEj2F/1FhCt75nLXL3O+bE2tEqWwVI/RGeraJBslyufuIFx4mlbc8sa8qL+mIjOZQgnNM7dS1nsH2YQkuRWRVrx7tnbui7KM0zvpBz1n5H5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUG5UNRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUG5UNRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A9B1F000FF;
	Tue, 22 Sep 2026 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092181;
	bh=oe0+t3hPTgnXuWC/zsid62EVXVvI0uMcqrtA55wEMZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cUG5UNRAdmFd5CJtw0p8pQ2W12c4JzhfyI1nAjFikHAFkmHgYTn03vS57xJtadppN
	 8ixA+VUQhzj/QPYBx+HGUmawL7EZ9bw4jJomtRYIUezNkJaYWnBb5jXiv5BAuEwx4l
	 TXE91D/1cA7Rxt+Akjui4/h5FIi+hVAgo7tihNQuvc3DYSj0lkJB0wFqFOylxriMk3
	 maWmAJoY8VW9FgIRN8wtH2WxvtHOs1Va/3Pc56/Nha/t8NIINV/6/VYusMjV+XHrJM
	 FE+T0uJNgAMiVahjc9jEWOZpV0uhHMLzu2CwTif/ROPmh0QvRBXno4+FrI69zGGpZ2
	 JmvGkQ2h+f8kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] mm: change the contract for free_pgtables(),
 update docs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:49:40 +0000
Message-Id: <20260922154940.C8A9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now that page tables are freed after an RCU grace period, it is safe for
> read-only page table walkers to walk page table ranges that are being
> concurrently torn down, provided the mm is kept alive via mmgrab().
>=20
> It is however unsafe for writers to do so, as they must obtain an
> appropriate lock to do so safely.
>=20
> Update the pte_offset_map_lock()'s comment block to reflect this.
>=20
> Similarly update the process addresses documentation.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D12

