Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529235;
	b=Ji6bcNV9KO4MxIMLhPD8b/Z9MHbe0rTv86eOoe5TPSMJ3zxX5CKhNwtF8KXHxWYVdxH4
	 Tx6tCTcHQn+0KwcRcjaNwFAj0tdK5xh11lNg3LTZYRnCP8OI3L0Hk71cVIrxaTUzh3ZeT
	 Cnevc9KaDtYPy/+Wkss1zyJ2CoYwSvmrLMCb4GNgwsb0+HYlheieVUyAR7ksUggSt36TJ
	 9PrVixFW/FSi++cpFdRJgXTdkiANJJKtl1Ckj4Ie9tCU4pdVWtJD5TSt3tPr1KC0cFpw+
	 x8BB1KBi0cdvB/LH7BQ26Pa6rJql7/Dcm6oQXkddatyrRheDhffvS4qCDXLMMYhUIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VAplBdUSW+Jo2ELE1ee5L0GYF1mR16t7vqDm6Cog3cs=;
	b=VE4JuFTgIQPgoMviOfi04+v8tddmTQubsBrN2CdfXTr86r5jhz4BS4k5H/rso08NFGAL
	 auv2v6yzzAVkgrCzb59MnNHX58L4K2+grHRUEETQBHcfuaVnH5XBxHSUCN74+brJBqtgv
	 4GN/VJVpss7ML9uffgbKR800+UhLks/I9g+POsJRHsPCcPhZo3+d5a43valHxCISJeW1B
	 UyuHFy5VYBKjE+WhC9gm0It8JjyeJ2W137N2EksJINLyIBzdaovMCUGaSyiJw7X6AjXDf
	 EJJv6pAisdVfJRV7dUZIK48aTMh+6i8WKIrAp/rNmaK2ywMhzAjJ2ShBXHlXN5ue8XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLzxuDzZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECB606B753
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLzxuDzZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475761F000C6;
	Tue, 24 Nov 2026 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529235;
	bh=VAplBdUSW+Jo2ELE1ee5L0GYF1mR16t7vqDm6Cog3cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLzxuDzZqvhwPCbdA+i0T/uljQocZNdcesNVYRmsem63642nSYcwuSt4h40600tbX
	 PKuOpu/13dE4SzHTaZDuU2g+Z2QqxB7IDTwkk+XGYx97SvRM3NOKKihgPD18S5cqxL
	 3EPs2gdB/4unJHDqvhjWs4sP5HwCVfCEtGplHFDDLnygWExBQcXv4ZnAHkovCzVZUK
	 +XedKXpE/70Pc8UwIOdQKLK+mOuYEl7FcSb4b/HhRheFcyfIX4H4oPmlUQGb6v2peu
	 zGXGb4eIlQpN1xRIZpx4/WLHK6ot7DiR/15B1UvUbNplc+8EuOolezBvPf/AR35+Zn
	 /A+dJ0z1XGt5A==
Message-ID: <sashiko-outbox-231303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/5] s390/mm: Deduplicate machine_has_tlb_guest() usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261124135948.1295745-1-hca@linux.ibm.com>
References: <20261124135948.1295745-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 14:07:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 5-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124135948.1295=
745-1-hca@linux.ibm.com
