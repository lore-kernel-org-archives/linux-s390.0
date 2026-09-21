Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4544A3E2
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980734; cv=none; b=jYfAw/2wy9fYN8iFTlQWANxPM+ce6ZKOZHPF50amRc4gMtgKpCcw8WHH3NcHluPA1LP9dQUsmn7dUpBoX53deIOn1gO6MzyEvUoL/WTQTpeCLvwdGD5rInMpiin1BIkdp4ThWPDw+l+MkC2oBL8UQPj4KTwQXM0AxXL0BXBMkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980734; c=relaxed/simple;
	bh=O83/3oBg+JDUuaRVNJ+OSDm7OB3P8SBjValF+Pla8qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJz/XLC26EnRfMYyCfVfH3KgpdxTi59JsdP9lNt83XOPBUmhWdWnzy8meqzLCq1KVmZLwKJDw9lraLzPhy3KPbKCUVAV17VqfZJZCCVIKA1ceaelRjpaZln0mP+Ur9KGsP0r6Gl6L6h7CVUq/5ZhasU+cpktB5s2IDL5X5xbvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnAWkGyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnAWkGyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF7C1F000FF;
	Mon, 21 Sep 2026 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980732;
	bh=O83/3oBg+JDUuaRVNJ+OSDm7OB3P8SBjValF+Pla8qY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AnAWkGyY5CqKcX5YjT4t/CV1r0JXNqteOpmIy1xQDePaLdNyoMhdLvpQiAWFVa560
	 rEXBJWQPitdDlwAz6IJG8G9lj4DnmCtCRkKzj1AAOcwztKv+bUBxLQ73lZYx5jBSVE
	 JMEL+jKWW7dAvuPw2SyQ8a6sP59ThFzUNLMFo4msLXhis0tBx8smCvwwBrbGicR8y9
	 AAYsXVUzcWL1G0yaM5/wGWVb9fBD5qQYhooa3xixP2re+TYz81TxlHHlvyHLpYCEAN
	 cJmiQ7X8ozbi29QsF3inb9xI5DTDj/pXr99jLobaf5FUexpfwh7Aya4iyGuYwh6yrK
	 n+fLK23IjNQsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/11] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-11-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:52:11 +0000
Message-Id: <20260921085212.6EF7C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_cmpxchg() to make use of percpu code section
> functionality in order to get rid of preempt_disable() and
> preempt_enable() calls.
>=20
> Consider only four and eight byte usages, since there are no compare
> and swap instructions for one and two bytes available. For one and
> two bytes use the previous simple implementation.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D10

