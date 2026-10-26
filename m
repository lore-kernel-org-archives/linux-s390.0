Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017705;
	b=SiZRSMhqnlRjnCqhULeDHSK8QxSZjxAgPvnYbhj8vKP3ODJYKT1tjnY/6qATvxZPCvZn
	 AD/rJO50uRTSSD4V0rvd11w/jdmrA/tofrqoOP4V4N9xQDOyQq8dU7Tu6hg0SUSms1Wud
	 98nP//OmrahFNBvMK0lMIzaLfxAMPdoaWbs5Oxa1pFiPwznABM5d++Ldo/P39p1G2m8zO
	 5uMo1BmWU7HsgINH16znu1Hmyk5HVHSJ1aZ0D46YvTx48gsNnfindO++5WsbkStp7MybN
	 L6npctJyw333lmJmsrYcfM3G47oxpn9fMMow5Cl/0+6q+VstppDigZBXCcVcqkG8WvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017705;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qGGeGjG2eYAY2dt4lf0qPn8WcfC8fNOQi81YJERwCoM=;
	b=qgRFc95Tzy6yxvLCQRfkl0Wadi5d3XM3HKusjyzc/C/2dKRS2k35ffgfNYcwRHKq4fn4
	 7vpE7UyURbCKSIwxptu4muHzr2abmWuKrrnbV1Sf1Lc0gw0KR+iLUrteso58eigOtaIPw
	 MTkmsXcsundmni9sWAcHvAUPls4CPhzUWcR5E5jUZ4sNL5FDmIL+YizCe1KGkZFxMAswx
	 FXBqSniQ3ElduhA7spvVoHYTstNWH+m8GK5YesVQXRSnEDBpzsGMXhhIXeQj1AgsPrprr
	 wovXSqC90weEP6pLuF2ThZukNUOX598OX9UAgwnGILtxdWQEgzdvIA2wC1k4VcfXTCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBeQ1PzT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B94606A31B
	for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBeQ1PzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCE91F01825;
	Mon, 26 Oct 2026 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017704;
	bh=qGGeGjG2eYAY2dt4lf0qPn8WcfC8fNOQi81YJERwCoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBeQ1PzTcZokDWTu/x8+r6otlJ8PJqsSq9vMwN1aBOlLqgT2DPjlVRljKNjvjapwy
	 BpdH3TjvK+rO8CzNI9PgiUEBP1VpnpyXVLk2MRvrlzbJpCqN80f/1Hl3iTsxAoZp1v
	 QXWxnttes4r13SsmNr5KNZ3MzcaPSCfGMjapM3wrJOhVlT53/xs1mgFaPCOCmDKWHo
	 2P003o+nlnqyxbz3CMtS/0M3EhQrOLQLfzQq4QeL/Zd7V3WfiSpvlDcypAuIZ9juRj
	 Wm9eXcT4fz8hByEEiiXhXlXoY6vCN1MNzgwBegm1qaqP+LYy6TAHjQsRP9tqcTZqre
	 xEW6Q19tYMyJg==
Message-ID: <sashiko-outbox-185211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] s390/bpf: Serialize text patching with text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261026120329.1792436-4-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
 <20261026120329.1792436-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:28:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex in bpf_arch_text_poke(). This way s390 uses text_mutex
> like most other architectures.
>=20
> This is a prereq for removing the spinlock in __s390_kernel_write().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026120329.1792=
436-1-hca@linux.ibm.com?part=3D3

