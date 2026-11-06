Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926453;
	b=ZHU996VaYPtE/smKLJnVl37Xo5hTcPG31uWVwcrHGjvQMjxjT/bRr5GeId9cDLss9Xif
	 iO3Vi1rqRHgTh3Chz2XXhTXHa2ZLyJC+D3QiMPCf1IHmNpv/0feLR2AHZaHAj2qyk8s6E
	 Q/KK7ZBSqJDGsGXkHyh9VxWPupJkaO2dpmQL4MHgg6NCvkyZsJya+tIV4bXvwPb89Rzmc
	 IhRih60y3mA+OKJOP8T/3TUBe6P0XAy6S+I9NEnm2/mMyc4K1VE28xUkCZXyC63ZtioUu
	 BtYWk5vHO12UMQOG2i0+SMIMdmAAE7SipgEDA/Pdqzlmp8DaX7+40DqVifs6Q/gBqjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cf3gbPEemvhtmquY/hbDBAk5cxzKMbbyZ9H+OWTLeqQ=;
	b=MkPiwW5Qul8DJ4S8gbNoiDplEpq+fIMKPzJmgpjrlD1ivRyRWJemAH6rLz5FYLsm4j6n
	 h+e/s1pKXMZhX9/T5waGEEH9jmrToLFyVNZ7chL1HSAJ7mARThBALZQlfBNkme/dZHdom
	 ZAGjvVcxFLQU90pouJMrbGyfqFsmKvG7Ew3NDYpzdVryTDpks0P22KYogArezmT4+uNJb
	 MmO5GEgAA2rTGBuSoqFQXXVz3BVLbOmAvrEf5rS/pm9JZLL8Fp1x/TgEI7rF2om2OjmsW
	 +wN4ApEuXU4RhmuRA9docrHLDgY16eQB0N88jMp/dPIdDh9ktcybICFsNPy/TtPzDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSaGjn5S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D7606A335;
	Fri,  6 Nov 2026 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSaGjn5S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFCA1F008A1;
	Fri,  6 Nov 2026 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926452;
	bh=Cf3gbPEemvhtmquY/hbDBAk5cxzKMbbyZ9H+OWTLeqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iSaGjn5S3BZzrSolgtu3Txtzmf1gNY7+YPGw/MAEXBoK+Rno52VCZh8dQBH1CZkDx
	 TBHXvBZbVoZHNKZv+D/wLsJzOLj4u30RA7fh1uJq+zuHRQNhvtIlP6B0k0kKryx70H
	 gBTEB2z8cl4jVVCgdvUQv8Mp1B7FC5rzxWvSbM9egkIBuIVo7lebYl/+6SkJ22Tkdn
	 gvLEdXRIFqNKdrj5aqGPo12lz0aZzbHGWHJavSwPrkSyxAjzSLFIw1tZZ9+s/Eo4HC
	 QzctvrC9939DGa7GxXRVNZYoWgwzwWb8Zz2PDO1emJK0jwPn9pw5ExzeRt3krQu+76
	 O+cRJz9gdvB/g==
Message-ID: <sashiko-outbox-200464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 09/11] KEYS: Pin the backing kernel module for a
 key type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-10-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-10-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add the owner field (populated with THIS_MODULE) to struct key_type.
>=20
> Pin the module in key_alloc() and keyring_restrict(), and release it in
> key_gc_unused_keys() and keyring_destroy(), which are wires to the keys
> and restrictions.
>=20
> Reject module owners still in MODULE_STATE_COMING so that the failed
> module_init() paths cannot leave behind referenced keys.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D9

