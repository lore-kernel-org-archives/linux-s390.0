Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1A3ED5A1;
	Mon, 27 Jul 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147031; cv=none; b=DCiy6PvyUMftuLsKHHJ84+YqnbeYbRMVDnE1sA12KNnvfg3j+dERt0c4TFT3+Qjfhygj9yqr6/+iR6rRNG9EsSu3Hx7JWfDZ2itaqzGIPGp2A1dZNv1R/9Op0YxHAhX/zmExAT7a8NcyqR9u2gZmDo1jFgMVxt71vqSLutZD578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147031; c=relaxed/simple;
	bh=HONSksX8ghtev94iIZiMy4tmtlUOcQiK3uRnee5n8kI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9wTZPs4CjOtP34GC40uH+tsEZ0zS/LjPYJa3c+IwmWEvCVMOkgQUlHgWOGPNHjwmb/w+8xcMPGQ4Gnh9Vgh2EV4NvzNRe8C+MC1/lZgHhSaU3XhVtpBz10DeqBkAd0AIqTVvZTj0mpdAT9oCNG72LQ7xf7eRbaeO01XuhvxsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYQUuHRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYQUuHRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F341F000E9;
	Mon, 27 Jul 2026 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147030;
	bh=HONSksX8ghtev94iIZiMy4tmtlUOcQiK3uRnee5n8kI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYQUuHRviB1LR8Xyf0tKx+aVbWrWIQGtQmBupOkJv+/Qc5gF/3pAKjJjIdvzX2tCm
	 BwUriiDN/UW2DGF9rxY+Y3zGW007W4rHfxPL4dPFMOGmhEpXLFQAMRAT7W85MqzqBI
	 Ri3y4dx2Rr59mWW36Rq7AWBGBvFmdBrUkou68qrWszdPGDecOAU65ZIPyIGt2fGMZy
	 ZSDQKRkGGgXrvzweLao7zoBNpy9zuvbQikHaBKoSSmvHzrQEClRtvuIXmiHmOrec7V
	 /c5v/FQMYNx5gbwRonsAZnZH1xHJNRwx09+pQBnMTB+6r0eJKR8T83tMn0lah+4MUX
	 /7J9ZpY4SIC2Q==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 7/7] KVM: s390: Fall back to short-term pinning in
 MAP ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727095720.9150-8-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
 <20260727095720.9150-8-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:10:29 +0000
Message-Id: <20260727101029.A0F341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Jaehoon Kim <jhkim@linux.ibm.com>
>=20
> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
> irqfd adapter registration fails even though interrupt delivery could
> still work via the existing non-atomic path.
>=20
> When FOLL_LONGTERM pinning fails, verify that the page is accessible
> using a short-term pin instead. If the short-term pin succeeds, unpin
> the page and add a map entry with pinned=3Dfalse to preserve MAP/UNMAP
> symmetry. The non-atomic irqfd path already performs short-term pinning
> for interrupt delivery, so this restores the previous behavior for
> memory that cannot be pinned long-term.
>=20
> get_map_info() is updated to return NULL for unpinned entries so that
> the atomic irqfd fast path falls back to the non-atomic path.
> kvm_s390_adapter_unmap() and kvm_s390_unmap_all_adapters() skip dirty
> marking and unpin for unpinned entries.
>=20
> Update Documentation/virt/kvm/devices/s390_flic.rst to reflect the
> new MAP/UNMAP behavior.
>=20
> Fixes: c9a568838086 ("KVM: s390: Add map/unmap ioctl and clean mappings p=
ost-guest")
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095720.9150=
-8-borntraeger@linux.ibm.com?part=3D1

