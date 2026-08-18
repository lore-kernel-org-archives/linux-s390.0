Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD045199C;
	Tue, 18 Aug 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066116; cv=none; b=XQBYL8PWgDRSaa6WmfJHrHIV46P1MmKRT6XO1Rc1s5OzrEgf988+ySy5YM9XxtQy9ZgjGaF0f3fSebVkh5P/34cfNV2LQKXX/rx+5T/du0gHF+8VCJPct6qSSGfYNVzPcR2bMcXp05x7yNvfGQQpyrPwNjQqLL42Go0mMnTVcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066116; c=relaxed/simple;
	bh=e2WGGdt0kKL2QKkuVMu/LK7tRgKArkAanaLGv1fHYVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IsWmnTy4REikLsZLGfTNDqlHvvAf3Da6rs+qZGePkZPWj/wZo+C7HpyMTY/WIh6Ak4yVeFQGcxND5P5ZLihJqQnFTwCxtsHu+Z1WlijwK/91fAlVfJfuz3Jp9CJlz5sBUoKMaw6P/LcCdMKkGoed4FCxSzE/Lor2ND4V+V/PXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjLRL/rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjLRL/rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A44C1F000E9;
	Tue, 18 Aug 2026 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066115;
	bh=nZr9AGBXD2VFVJb3kjDcfPHWbHdidC14pH40Uwxha4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjLRL/rnF9dNxtn/1Qt7pOw8yIy5lemMDp8X1nEq4txdMzrag7g8Yc9OUj4iJrHW1
	 3pBz6dn45btIPVMJA8vczm6tXIkXW6HNBG+XxMoVcdEwWwC5YK+FAbEd5tAJUJTBdv
	 WNSqxiYGK3cHlaiB1V+SjZnQ6iLznouakC29wktUxwi0DQQRrXwX1cIYxbglXLnHF5
	 C1Wi6KPN8nLNNRrLk9hESv8u7RkNg/fa8PnZ51uLvJD++FXo+C0G7O9D6flRrva17l
	 FK650/kicYz9Ix3t1nbeHVYJ7Tx8AGc98PqVuXdS1qs9sKxD7veHoMTitSydQQme/i
	 5U9HWK0TizzAw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 24/25] unwind_user/eh_frame/s390: Enable eh_frame
 unwinding on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-25-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-25-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:15:14 +0000
Message-Id: <20260818151515.3A44C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The unwind user eh_frame implementation works well with GCC and Clang
> generated code on s390.  Enable it.
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D24

