Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4334908A6;
	Fri, 14 Aug 2026 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726790; cv=none; b=L8Azklf9zLOnvkfCP5IdJtuMCCW2CpZxkkoenAGQGNOrol2YvyVa+abPTP/fz19NkO4nsAsORYDfQXw32RQRpe/6bVdP/jWNsGxF9qdqR3I/EfthCYQF0NsXEM+Tl6SIGcRvGJUKwgCncTPhhrYFSkflmI0QANgyqoMpZ6cBneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726790; c=relaxed/simple;
	bh=s1gocIF/FvAKxI1tAmRrHDWKG/r7/u7ZDNS1snZ5ZoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AgbViBS7uGJA9UqN+DJXakd01beFANC1xiv2nUFgdfqo325Vzl1QTHAzRIo3TrdlmAQbdXxA/h1/GyDs9xEF8wXEtOhRmcwzCl93mX5+P4s0Zmal5gA1cS6ENfwnqpm1xQH8gHRMCOYAsfMDy5CDKcwQI0DbvpL8V3MOzNcY/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ2Xgj2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ2Xgj2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893ED1F000E9;
	Fri, 14 Aug 2026 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786726788;
	bh=s1gocIF/FvAKxI1tAmRrHDWKG/r7/u7ZDNS1snZ5ZoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQ2Xgj2ueJqDAV3aR7zvhq+mfvO8ekp/5a39izwXe5APQF37SyqmWWVy5t1R7IHpa
	 QjkQRGVoLKP+C/oG5ALpXyl27YmwXdYUkA4LyRo432ktCbHIIDBTPmc9EIQHFpflSO
	 8N5qNeTwCJa4NGVZCpk/Ug+aKP+AO9vKp9/HzgWW1wUEnp/6L8Q9SO7beLooKHaE8T
	 7EBNg+s0+PczIozlGujLKsaRMrcD6i011GpI7pybA7GtZFqrhVAlH3z03N+1CI5J/H
	 BDNUmDsyVi5KBJhN6cvWFNDAt05jIgHa7sMvtchSNNcMp54oZ5pj+sbosAhaGuFfbc
	 MmgSgHTcmQFRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] KVM: s390: Fix _gaccess_shadow_fault()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260814163355.227191-3-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:59:48 +0000
Message-Id: <20260814165948.893ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In some circumstances, it is possible that the page of nested guest
> memory that is being shadowed is not present at all in the parent guest
> gmap. dat_entry_walk() will not find any leaf entry and return with
> -ENOENT, which will erroneously be propagated all the way to userspace.
>=20
> Fix by manually calling gmap_link() on the memory of the nested guest
> that is being shadowed if the mapping was not already present.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814163355.2271=
91-1-imbrenda@linux.ibm.com?part=3D2

