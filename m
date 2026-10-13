Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B953A9612
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907956; cv=none; b=Cfgl5wsTkwGsgp6aWHSH24GSvXvqSuqFZ5mlEc0015hYwIjT/uiQx/5785ee34y4DVpAd3HqQRMpPuEUi5n+6gdlFbsTQRVjfxr2ZYFqC+Ik6INxxL7uaqpsbo1tmxjGVyFe7MUvk27apnz1LP0E2qPeqeVXowmpBOqTrWDYab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907956; c=relaxed/simple;
	bh=RSdpqZs3ySeqg78psd83J+fQQlZ02Ij89UfCBCMGE0M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BpszEXlXP/f+ubvIdhlEWwkFvjgSTaFJClCdQx7mC1JVtGJaeA3EGVORTvObOBNJNuL9VN3a7NKPwONGsXJXqagcS2pJhKu/UHW13YGikV5wxnmxgSyQRFLwyCDLcxrsWMrHRBWeqef1/kzfowF1LTQZ3QESKP+ujZ+w6OUE5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=celxCoPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="celxCoPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425211F000FF;
	Tue, 13 Oct 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907955;
	bh=RSdpqZs3ySeqg78psd83J+fQQlZ02Ij89UfCBCMGE0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=celxCoPmqjMPcgafT32tc0N5FWUqEtiM0NDzbgqmVQLMjlaTzUsStJZJkqlsIq0oJ
	 K8YgAuY3h/4b64g2UsVnCVwK8AzADUvEOI14DrojJYpWcBNO0erOU9pOp9A007yiT1
	 YQN2vYE5OyD1c3vvTUeAy9YeaLRXM68AN3je4bz/TiLtlwguksakL5f9HRHln4AsAq
	 V2xXt9fXI+4aDP4ZeLiPy8K016FurRDHIWi62fZUT+LTCkMgTWKW+JLViShdKc+3DS
	 PViSyJ2ob+/EE28Mds0JTHrFLBc+RMO79RL/6bxiEGkIg9SqvgV9zQN7cHKQtF3J9C
	 wg+U80oK6rW3Q==
Message-ID: <sashiko-outbox-170098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/15] s390/vfio-ap: Add 'migratable' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-15-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:12:34 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the 'migration' feature to the features provided by the sysfs
> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
> of vfio devices is supported. Since live guest migration is not supported
> for SE guests, the 'migration' feature will not be included when the
> feature attribute is displayed.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D14

