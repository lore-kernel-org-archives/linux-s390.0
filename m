Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C9373C12;
	Fri,  4 Sep 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551920; cv=none; b=QV4txXi262PXtGtk5WhnG/5Z8HDdoC4wxcsCs4eHx5w1F0DWpB2sOFq+BIZwbORfsJe6VzO1dZZ4y8MEpdJkM7DjjEXnMjTQViT0Vz23/kzRIKyCWWuG2aWE4hFhyhdLdeZTEAEnJL+EjWo318VNT9VtrKiIfQ2o2/qMmzHP9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551920; c=relaxed/simple;
	bh=me3dSSfRZOI64w0rGQ5w2zMf1Ir6A3EzGR1yjPRYn30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SefgYcyuzwL5MyvnpcWZnxXvmi5myxh8Km1Dn7Rx6E+D7v1wqmP6hGim1LDP8YkI42azyQQhnfT0+2Ts4IFsK8u50h7PLRCoRTi6Dh0ichobS3TpVjWOdZQRN4UArCWDhj6ExaxUJM9TGSRZnAlTqxeQeJqHKHYFBFJ/NFKhXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDMqkX97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDMqkX97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D101F00A3D;
	Fri,  4 Sep 2026 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551917;
	bh=me3dSSfRZOI64w0rGQ5w2zMf1Ir6A3EzGR1yjPRYn30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDMqkX97gs5AFvCPULy2CMhdnXM0Mx1Ok9GDtctSKQAgKfPnM7/SatulS/VK8pO6E
	 B978nIDAjWZUiy2iuRf5PK2t40csfBrrtmVMKOcfosiYhl9Uzkaj7CghkxWA5DfX02
	 7SM3PsYW7uojZcqW7d44oWz68hk/3BGcyWclXbl2znCe8jEouAmupXWA0UPATJ6RrG
	 1jh+TlMPpCN5bxlW1TmfM8et2AWIhpJqpRDQpsjF2FGPzO3t6WDJQ7sYv9SQFSRqd7
	 fmJcqd3K+ozQlJmnYeH+cLzVHg1FD/soxjF35Gmi7JTdZ43YwjE+TdaaZJ4j/YqpF1
	 A0JvjSkkYvcwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 4/7] bpf, powerpc64: Use resolved pointer
 for timed may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260904195132.141068-5-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
 <20260904195132.141068-5-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 19:58:36 +0000
Message-Id: <20260904195836.C4D101F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The timed may_goto fixup now passes the resolved counter pointer through
> BPF_REG_AX instead of a stack offset.
>=20
> Copy the pointer directly into the first argument register rather than
> adding it to the BPF frame pointer again.
>=20
> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed =
may_goto")
> Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
> Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@os=
s.cyber.gouv.fr/
> Assisted-by: Copilot:gpt-5.6-sol
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904195132.1410=
68-1-sidchintamaneni@gmail.com?part=3D4

