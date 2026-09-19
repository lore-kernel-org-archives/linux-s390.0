Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F2375AAB
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779689; cv=none; b=Jq84RtLn5GgN/+gIt9CQ2/+d1m3S2fXeqY7BuiKY/ecXRKqW48nHn6wQadiz5SqGScZW8+PE+9xSLpSCscupRxm++xA27kXDOavK+cNgVAXjZiKZ9urPIToxJIuFzUBePnj3RWMLtj/lMVgroPYAjHy8bmkjvMs0SHy++8QJGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779689; c=relaxed/simple;
	bh=NzSAWF+4WqDNN1FMA3p0/inA3O1p+l/cYfgFOvghPjk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KCQ5IGsEIWjGaQ8eye16XDGygReslyZsoNVxLr2z0Zl8EhaPoOIAFT/Pu6Y9c+HsG6trJ4jx5yhBsL+G5/LaxjHjcNMRDGx0isPTSeq75vjVbbDn+XewQa8p8StGlB/PfB2H9QdbR+Vnmqrwr6VLXBNTgsgHoA0TQmk2b1QmFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrhrZfaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrhrZfaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F1B1F000FF;
	Sat, 19 Sep 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779675;
	bh=NzSAWF+4WqDNN1FMA3p0/inA3O1p+l/cYfgFOvghPjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrhrZfaFLCV43Lj/t9LOWuQ8lR29C2eD3JBG39Dy89AtO+90IZq2twOiwCRwARfpk
	 w9ZLa4Z8XOpwwgrdOwgFz5XtU2Flg0vuLde63pkKDacE7rk3O2qIdJkP0VYHcRbhAD
	 eKJLZq2Uop73WL5AiC3my3giPSZHN1J70mEh+9Lv89xjnl1zbfe0eZbt/oFv6Ru+Rr
	 28AMIAFmagZO6OAF/C4kDFqC0qnOwrQmnnS5i8j76f3F2RSsS9OS8+Vg7ddFQXb2H9
	 7Y3sXVy6iMyn+rczMCuFWVmjHP+q8Pb8avJraC56N1HXCXNopkvGNH+PsxezLOe/vw
	 tKTvxRyDQnV8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/12] alpha: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-12-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-12-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:01:14 +0000
Message-Id: <20260919010114.B6F1B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D12

