Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6A3B5303
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805888; cv=none; b=N5cY3Xb+QzzHW+G75kGzjDgS96MZhmoL+CJmbcFGQOwjBWTLodkOYe9Y8j8L5G9JYsQ/bq3LR+NM4MdzrU2WU1AhPxKzuaO/EWX7GGeObUbbJPwxyU66ooRthJSQRChD/dS3k1fmcoMwzkqWqUso1It3FxRSukoGd1jCyvLuwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805888; c=relaxed/simple;
	bh=aWhMNaiQ7zvWiwn1nC3Q9DYXD6i+uoFKGXjJDHEeF4U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oUkGMzcMRFW7fTIDZeapxAqC4mdcJMxbF7+LyU+stursST/tfAWdmqtpww1Ba89eqfBGxrATRzv+El4kPu2jHBtyiJ4DDuVC0mO+ShKVxsJAX7QriMEGwZQ1X9Rt4t8bWSUrNOgGIwWTqe0WTtexutUwx9YT3G2IwPwGjkIBH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6+7oVDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6+7oVDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE581F0089B;
	Mon, 12 Oct 2026 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805887;
	bh=aWhMNaiQ7zvWiwn1nC3Q9DYXD6i+uoFKGXjJDHEeF4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6+7oVDUt4Yau8cpU1mP6x135+XJvDGjHm733ejgUp9TzNxn7ARiqCUo8nk/+ufty
	 MYYb2BVuReJvoShhH78MO2ABkhaIPW3Dlaao+ZqgcT5f+voM2l73SsxbM2qYvSZ1Qp
	 prwwJkmoWJRLOyJjVKsQ7T17cyIBxS5wzwl7Z1uPTz5OYy4rxYLdISuEP5+j3fX+rz
	 pKKg1aeu9UUTDQignJ5o45ygbQH0PpTPlWzPFgwLy4pcD9+EAdr5s9nkU2c/ez04JS
	 4BI5Miq4ChwVpen0u4y0eTbD12fZm+SOlFKQLyfVWdVtEQoeWwIYoIgcj91+/mIGVZ
	 0qyrQ/j5HbiOg==
Message-ID: <sashiko-outbox-168029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] s390/percpu: Drop unused output register from
 arch_this_cpu_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261012114249.2898572-3-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:51:27 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The laa/laag instructions return the old memory content, but
> arch_this_cpu_add() does not need it. Instead of allocating a dedicated
> output register old__ just to discard the returned value, change the
> val__ constraint from "d" to "+&d" so it is used as input/output
> register.
>=20
> This reduces register pressure.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012114249.2898=
572-1-hca@linux.ibm.com?part=3D2

