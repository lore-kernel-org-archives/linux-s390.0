Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742544AB83;
	Fri, 28 Aug 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918733; cv=none; b=q0riHPbG7wc/Yk9yYiMAW7A3KZ/vkx6Avhsb6U/gqJhSlhaHY31A5/gAHeHQfR0usPoqiocdYiGU7uY17O49KNOUHIfm3qbmvm29PT29gJdFg/KDrILYegHMc8cMvwoOqWOb0y8BeqAJKb8xoeJwQs+VsGqnSQqr4EHRE17KXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918733; c=relaxed/simple;
	bh=TAWBiXkRMcwIwV77vaORXQUZjvpEGZNc4ItPEZGUUkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=COtORVOC6YGNm3VqAuzBgB4+MyHumI77ZGcTNlJ34+Z9EWNg8GaGndIx7Yqz28USdtrwj07jDfhaSzE5Z6LaiqtZvheBA7RK9atyUsRep3pdCxynIEKYOJ1kDCm5VInA0fQG7Jhb0WyujbctFDBsyBbCmrMb5ZVBlR+tYuEyuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni9xqtR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni9xqtR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3241F00A3A;
	Fri, 28 Aug 2026 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787918725;
	bh=TAWBiXkRMcwIwV77vaORXQUZjvpEGZNc4ItPEZGUUkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ni9xqtR/Zklc1hllu0Gm3AMsXi69FpqGZaIpOUYS+5KiYJlb9mirO8fl8sWM7jRs/
	 oeC4qDemNYHm+43BQbF+MGCipsQ0QfLvDWi2XV3oJqnoUTpSaSp1bDLLCfJS5++kyQ
	 BhvrwiYtqJKwbaGfe8egu6HcpAAS2Jc9Fl4mxY6qAtxEvpVKWinXUyCtJT9Pr8vSBm
	 P5/IFRAvX6A/GWYKX5RMcOiRNA2sMPONhf4AmAM59NENXT7D1mWVapKVVmNq72Ivz9
	 Xq00fB6gutQiByP9JBSPqK7fHoueNW1EJRogqXYi05CSy9uplQLxQ9jXvCXWEaZ+kq
	 Cm41s1PVgkuxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] KVM: s390: Refactor dat_set_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260828115439.145885-5-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:05:24 +0000
Message-Id: <20260828120525.3D3241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Refactor dat_set_slot(), _dat_slot_pte(), _dat_slot_crste(). Now they
> only take a struct kvm_s390_mmu_cache as priv. For dat_delete_slot(),
> mc is NULL, as no allocations should take place.
>=20
> This is needed as a prerequisite to move gmap DAT table setup from
> kvm_arch_commit_memory_region() to kvm_arch_prepare_memory_region().
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D4

