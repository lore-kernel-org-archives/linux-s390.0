Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213931;
	b=dKFHz4Rua9jqfufkLpxmJ8xbiQrwpgHW2ShZ/HI0TQhEhvGPVsDzHaFFeavA2JJ5eppn
	 ZyD9kg/1QBZPqjmur66zn3hGQTbVHQjaoL5mQ+1wI1xJnJrmZk8LUSmfsf5/lJ+/EfC3D
	 xNYBuTvruTxKbC2t21G+YSJ4tOvfYGfnngwx6YN1JGkKD22+b0CAs+tKriDuAWHN4VNKS
	 7/0ckRULjST+kAVi/PaaIJ9kAadTThnKMWRnaIT/f7xwoMbFAk+w/d0fAe5LKhVwcOttm
	 h7uZTmByqDSBH5UuwZAq2ZDuNxA6hPwrt0bO1JVjWb78GKn/RKAkHjBiRMVH7OIFwUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213931;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1R3s80eccd2XT3jA5C8GGSFLTa8AWGJWs6KJhBlY3Dg=;
	b=O+tcnbDyGHCACiZZZP7gSbaIqxM3B+tIrRWFyirhKVDoLjtAVcfkGQqqn3iSZJw5Svy6
	 9goXzMOK8/qC5oCI6rdOFvGpuqb1uPPpXRQTMn+H+oHc3pFgLvPRQIrM6KP81st6Lgn+e
	 fL8jL02/DcaQq8OHOB7K7NQBd6LhK5Q3skWOG/OUy7MI/W8PXd9kF4TXuuKVMzImUcMLV
	 NXmC1PStx/QWKHDlPk8YXm/MDDkTyz7zNtJeVPZeACuldCYs1simW9H6nS61CrS/EEZpO
	 sZ2evsVLUeQcFd3BLnXdkWW7sz8U9HDRhkFl8I6wVz3ZHSvfA89YX7mfnsR002zxquA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HkCwpz/4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB5606A31F
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkCwpz/4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E81D1F01828;
	Wed, 28 Oct 2026 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793213931;
	bh=1R3s80eccd2XT3jA5C8GGSFLTa8AWGJWs6KJhBlY3Dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HkCwpz/4knnxgQzobgoBZRU1DQY/GzFRD3lPCEhdXPkYstcD575wCCmj5sVg50bac
	 /CsudnAzvU2t6ZW5TCErl3zp+4IC3Dbbk+QYSc3UBzClHOdN9JwPHmBJgk48Lnsixx
	 XNUlDeLMhdWg0u/LKrZ8vueZ7kGy1M0/owV7S5ENTLgDjAfM7r/PzqS0zd5hHeX6V1
	 1/CYJDvRUbKTHoD14OeVGvEspyjpE9+gSAH+VOv8Ry6p0TyqXTcxe2RzxR3c6FaXLD
	 xbNtYJtZ37KFR+YuJHZj3QYKELX6NYfv1CxETrJ54IC3npY79cA3iwhFwrT+jB21lN
	 0ilerbhT16UTQ==
Message-ID: <sashiko-outbox-188321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] KVM: s390: vsie: Fix pinning using the wrong
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028185422.272146-6-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:58:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When pinning guest memory using pin_blocks(), gfn_to_page() was used,
> which under the hood uses FOLL_GET, which is the wrong type of flag for
> memory that is accessed directly by hardware.
>=20
> Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
> correct thing to do.
>=20
> While technically a bugfix, the previous behaviour can only lead to
> guest corruption in extremely convoluted test scenarios that cannot
> happen in real/production systems.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028185422.2721=
46-1-imbrenda@linux.ibm.com?part=3D5

