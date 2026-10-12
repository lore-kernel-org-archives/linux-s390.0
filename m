Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E4443C38
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794305; cv=none; b=hajXRpjJ6g9gFiGAlKPc3koRTJDps+sPSU958SR0YuBh9wYqtIsKZ/ECCvLOsQ/iML9Nv/o3k+q9JLiKSFWQVxOHouABgXhKw2vNSPzr/xDoimvfE7E0Ad3NJ8qAwlawA8bmziFTyETVNPuBZi9YZdaPt0sKNbxm5EL6nARTexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794305; c=relaxed/simple;
	bh=qtfY27DZAzUgg3+KO54mw63kp5DATjIHHCLeZI64sF4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SsO6aKipYFG5dYbvd9i14UNQxl4KIlYM6TTFw2gALgQO7HjXc2oFd0AuApd5mDSdjXR5Aa6CscauIhD6YupMIdfLAylYcIYRPZlxwUR6K3LgXDkRhyXq8lmTF1o/y4aklFFWRNPpUtLVA03ZJawcMX6WWpnspXkR/oHxrC3kMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou9Lr1dP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou9Lr1dP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D591F0089B;
	Mon, 12 Oct 2026 08:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794304;
	bh=qtfY27DZAzUgg3+KO54mw63kp5DATjIHHCLeZI64sF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ou9Lr1dP3NYM9cKukYEK/J5eLi8nLtpKkBGPlQfIWzhta1UGdpHV01X/qiX/auk7Q
	 Hm6cw9cEiYfsmk9itwLJNtgHj4KLDXIJ/a45ARdtYe4A2Fb4f7UK/tNo/7qODPVM8I
	 rmugMrWXsqEXTXZ7WhsoSZYsJcGERAkHzBprPipGq0G7Hrz4yqohHWW9SDE4smtx7g
	 qyIQKuWFlqwVuLnH/f+00KDND9BEiyRWccmODPdvH6ccB2SbHloLO4zqXtbNM94Nbk
	 +vpemCtiIpS6Gm1rTSCkTnvru0BmH0NprL0B7Uydf//4IDmxck6SI1WxVHD7vokwJa
	 EidPfkGt4DLOg==
Message-ID: <sashiko-outbox-167849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/probes: Fix wrong mnemonic comment for clgib
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261012083629.2109206-4-hca@linux.ibm.com>
References: <20261012083629.2109206-1-hca@linux.ibm.com>
 <20261012083629.2109206-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 08:38:23 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is no cglib instruction; the correct mnemonic is clgib.
> Fix the comment.
>=20
> Fixes: 6b169ac9b434 ("s390/kprobes: add support for compare and branch in=
structions")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012083629.2109=
206-1-hca@linux.ibm.com?part=3D3

