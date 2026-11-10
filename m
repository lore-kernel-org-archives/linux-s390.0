Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310584;
	b=hKkOVqF3om68cTZEKEltHFtqx6c7EdevS/98dw1u6HunMffhAvyIOkkPTzu32ra1SR2M
	 eyHNGtz+r9/+ME7jtnYJ41Zqo8ROEtDrHfRVpVSaincQieIIqTziJWuV8MJtU74koXTOi
	 m2sgmApcp6FRJabxUahukiCE7AyvOzq+IZfEuF+K8vkXu9zdRi9b+Zm+oxjYa/0uQnPpN
	 YV5jE8HgfuXXYnYNJferqF3RrWQGop9UpkNY680h6g5Gv2/lafGlCV7eHBk3VoFEYC7Ll
	 CwjxQZJSB4GC6vh5lYgKF42yiMEhL+Omiib49mobFzYKpJ29OhjCST1nPwB8+3s8fZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yZFd4Ketha0pPvbC5lC3rGjGW1Ak5NZzFbEO2oR8xOU=;
	b=SrijWpy7ngXNNbGCXn/Ika5rwCNtWPQ27/hU4qcriE1/QlfO/AFl79+W+jxGKGFVC9vR
	 PZ+P/HpJnlfkQZSwdmgNKFueYoZaO6ZoQp2HpZ+FbNNnnmsC9I6Skc1BDr19hn8jbQYI4
	 z+rgmKymWJ8F10sXlouulyCYHvC5WYgLIa8BemnhjxjdkU+zLkSNpg2MiIn1+0Bsd+bVU
	 HABluj4xvtAgGBqd3+nuDl2TiA2HfAe2oZBOB+GzAK4xnkSP3APF01nzDvgHtkY7p5hFF
	 NDpOhubQUWO+5K01n58tXjyPrr4nNKXkDU0NMWkTD/UvHuLX6SljnhykI7cDjFFxhpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfozuGaU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DF606A31C
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfozuGaU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777851F0089F;
	Tue, 10 Nov 2026 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310582;
	bh=yZFd4Ketha0pPvbC5lC3rGjGW1Ak5NZzFbEO2oR8xOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AfozuGaUBsBXm7DoEubxGMb5ZDJzZDqV8DhJ+JHSzIfF8GOkZJKPpJT/yBqK9V8Tk
	 tdT1eWwLt1z7OqaC99sNoQT3qbYGTBTLequB/GWtgxuseXtivBKZvvbn/zVvVTfZPt
	 ek/I6U1deRm/GPhEgT9C7EGbHiOxo2x//U6vrUCChKyIuXknrlO9Ce7TBgHfU1Fk99
	 GqfLBA2HH8yEi8tfax2MKPMHUb0cv4oiragYpjcc3ovzr4VJTs26waAWj4lRlQitgE
	 rDDN1yq2EYZH1iOBR8bdv+USWnzQ42R3IREA4tD8rsZkxVvCjC6odje5b1idefLGe5
	 5LVDe05KFEU3Q==
Message-ID: <sashiko-outbox-206942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] s390/sclp_tty: Make use of sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110113047.238367-4-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
 <20261110113047.238367-4-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:36:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Replace manual and error-prone iteration over entries of a GDS {sub}vector
> with sclp_gds_for_each() which deals with erroneous entries in GDS
> {sub}vectors more safely.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110113047.2383=
67-1-egorenar@linux.ibm.com?part=3D3

