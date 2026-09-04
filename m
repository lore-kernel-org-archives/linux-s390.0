Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66136C0C8;
	Fri,  4 Sep 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520409; cv=none; b=OaaET5gEIFQ7HmvVYNYlfl4phPjNwbTGv9UejXAYcvTGc0lO63qOAV1AMSNXFGJjRebH2QpK1OLdSzp6wmEdi4grR5YD/maPoOlmDBZe3UR5LGZBtHOtXogy8lzPvbqet4VVtSVTcJ0k32SiIUcW5yf1HYdPcWC1Jgs1vA915vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520409; c=relaxed/simple;
	bh=GGdEdtKn7kkgQkWrDXlVDLAtR8IIDSrfcQgr/GicTdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEaibQCyjniXp+RWjhYHYUx3JDTVjitaBBf4zq6uJ8wBgG4+H8n7ixvDzibXia6HuDpt3MjkHxqKMW78AjvjwqirR3ze9AIgjBuegRJBwZIv1eAPlP7/i2OSv4cjs6LVj6qtduZBSXIyM+0XPzOevWwh/4kWlqk8rqR0R0qSPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSBVDR1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSBVDR1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819631F00A3D;
	Fri,  4 Sep 2026 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520408;
	bh=GGdEdtKn7kkgQkWrDXlVDLAtR8IIDSrfcQgr/GicTdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSBVDR1iVhBGpSa5O73IaGc5mASR/Lv7px82EN+fkIwDhqWvBuH8sqT5ZvepLzp42
	 xWHoF19ZnzHeYcHSjOxIZdHnsub1HWLWNw3Qdv4CF04/eh7SSP9cNOUerfRJIvI0zx
	 GsqxOveAyeVe9W/G4K/kpSlg5wJgApTpTYeufXMJfoHQS4KZDBsKsbc0HOQ0E86Ssg
	 1+fjoqBUQnS2EC7pDvj3FOOska8Jkp7O95N1B/BGUmI/e+7AF3teHAKB/W/9+x/Vtq
	 mJV4c2pgChXv3Ie+AGEp2bhg/fiS5asZGXyB+SQtjL/N7aifrH9qJWu2uyd01AUpcS
	 i4pGIL+NNg6ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/12] bitmap: Add bitmap_allocate() function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, "Heiko
 Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, robh@kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-5-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-5-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:13:27 +0000
Message-Id: <20260904111327.819631F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> This is similar to bitmap_allocate_region() but allows allocation of
> non-power of two pages/bits.
>=20
> While at it, reimplement bitmap_allocate_region() in terms of this new
> helper to remove a sliver of code duplication.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D5

