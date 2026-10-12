Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7737357D0D
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815310; cv=none; b=PgP0yS6x/5GWR7dpKTtCusU6vQdQNTfCZ3EHPmw3MW8wgsKXoW64ytR9rYTzhPUpaHSKtQHpzEK93aUapABqPZgIHrfbmM06ETQ8mv5hM4q3Nh6W9/tDKD7SPKQB1gk/jvUs8QipEbdxxANtBTyCvXosGYJIIPuDqmNVCnvq+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815310; c=relaxed/simple;
	bh=nV4gdD6t97Ku27FLzPZrORAlcYITMqpIExPw7zO3ghs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZE4wp+hXJ/amCp7+GosRf7yhnGST6f302KSt8tIVpg8NkWwD+K/k8OtHNCSrxKb+HnJK1as20jh6qqOrOgzpQRybCfUIl+bhfUpCL8xN3xDw/gnbT/EU6i5rFIGuYHgGwRLUSg/SnDnHb4b/xV1BWicmFufdTc/pN4hsKfs4WPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8sidkrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8sidkrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4067B1F0089C;
	Mon, 12 Oct 2026 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815309;
	bh=nV4gdD6t97Ku27FLzPZrORAlcYITMqpIExPw7zO3ghs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8sidkrtlVd3DxQZbcqEgjlRwBYZHdXVOvKX49IRe7OJovcGCelzucfZUeXIsEdcP
	 QBhwp3W9KlF7hmsRI9CKK/bfgXtMKnkDc6r6wTAIij8K0zYbybDSJoauPqYTpg8ncw
	 qENOHZUHzNLw14VvY7/X7hAzHH1vlhtDlCT7qBgr/UFChcdLcPpEJc7sq1pHSMAV4C
	 CBg529KnqLHXOHhTQes36nLgW/Hgrs31HlMD9QYwiL6tPEKM0GrRtj++jibSMDzHMA
	 iYdmh8pf7u3EttKmkqU0In7I0qh6ruqaDw5xPW6RfWwsYwR4e695j+l+LZod1l1fgM
	 nywTrFVs9GCDQ==
Message-ID: <sashiko-outbox-168262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] s390/pci: Add function handle to RPCIT insn
 trace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-3-1812db73dfa5@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
 <20261012-rpcit_trcfh_upstream-v2-3-1812db73dfa5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:28:28 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In certain debug situations it would be helpful, if the insn trace for a
> failing RPCIT would reveal the PCI function on which this was attempted.
>=20
> Introduce a variant of zpci_err_insn_req() called zpci_err_insn_rpcit()
> that accepts an IO virtual address and a range parameter together with
> the req conveying the function handle. Switch zpci_refresh_trans() to
> use that new error trace.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-rpcit_trcf=
h_upstream-v2-0-1812db73dfa5@linux.ibm.com?part=3D3

