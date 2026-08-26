Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A52444A3F9;
	Wed, 26 Aug 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757469; cv=none; b=q3Qq30/2pk+sZYLizzcnAihomL2kj2NhE34IOgx+esHfn7Bi4jN2iCg/+Dh3u09Z70QmeiuSKX2B9SaeBfF/f0Fdos4m+WLVFxmTQpC/HxtkCl2Tc9lOrmeUmhA4NiVhS4SnoTC25wl1kxgDq1stSMvMKtiVCXdQLw/+wBuZRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757469; c=relaxed/simple;
	bh=zMgNshBIWr83ID//ZSKIWqe7cofbW9umoVXxArEh/qM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N4xpq65/OId3zsuN5vq+FEL4tH56rkiOkcS9ELWxv64AGGpmsrUCPnqWEobSEg/hgHDxFpzJi1j2kXHXIvX5pASvpeZXa6z5kkC9yPuym3rWdvPdannLY10epeJKxWHfvO3xYKqYzxMWYZXH9UV6pBmqnpCpMyX+Qm0UCnHEMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe1tfigw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe1tfigw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD541F00A3A;
	Wed, 26 Aug 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757467;
	bh=zMgNshBIWr83ID//ZSKIWqe7cofbW9umoVXxArEh/qM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pe1tfigwAHtZfMG6vk97juND7OfurvUsHMIM+3Q9lYd3NAgu07hZ/imc+USR/Avit
	 8fADGV8byTl74PiSNCP2ejdRKsYdELAcNT/RNIq3C8M+xBKcxLWLJHm06W/F58cH4u
	 3fun0jC+XMu6YnWdSK4GW6xq6w2DuQWjDxZOeaGrMjME8kcqe2/cSfbExnk5tcBP/2
	 4k+7pQ7ju697z3akefEpbMrG6l/XJO0HKdh9SzyDtuzi7vFGIMU02vEVWyWHWREd4R
	 Tz+Xq+CRMjBvD9uz5MAL9MbxhZO3HrSYhO1LraTRxDQKfDeR8/kPcgPckAkbSP0Ooj
	 Ish9lPPXDHNKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/21] KVM: s390: vsie: Move pin/unpin guest page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-5-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-5-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:17:46 +0000
Message-Id: <20260826151746.EAD541F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {,un}pin_guest_page() up in preparation for the next patch.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D5

