Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E642F708
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295794; cv=none; b=XH0+gU5mbRUZaCFsvXMhpVvHEsYFd8pK61fRVOyoh8myKK4n6FToRQq+bfEloqJp7H8i1vElbZKfadyjicF9APia7gR6EMa79nTqfRT0rVua3ABtTIKRm8ikNE1xxBuEEoX4QpGb/tU8N8GudjgkAaYAgSDc6GxjTTItteU70P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295794; c=relaxed/simple;
	bh=ohx9jV5d0ji4LPRqIgOG+OzoG4VNioVqpj76EKrEF9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdCbwbgM+FlWpBebl6Grs9eBP+RNj1OZvFFIcYsPuHaAxWx/3kX+Z23YIagFE5uBqgMR8d28sCCDh5OuOzjkQ9m7ECTFln8kvGW+Tzcxx3RUrBNiGgmdIU5f+zNY5Dz5N0/nJHs+8KPHyw2Pf/9I4+VaFtbe6x3FaCqkm2CdUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpKP+Vzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpKP+Vzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A101F000FF;
	Tue,  6 Oct 2026 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791295793;
	bh=ohx9jV5d0ji4LPRqIgOG+OzoG4VNioVqpj76EKrEF9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpKP+Vzz5Q9I6NWSjVBRQTDO1dpMFE93/ISEx/9BAulWFTVT+3d2/ufZbi2WSftSR
	 NkOGu0cDdH2A3EXazQjTjRROgEHCKMB6S4DXUzTUI9BGj3MqRptqdw1eYhkHLxY5Is
	 cuWNolkKXGN1OpIzKr9ek98V8yY9Iy8h13AM2K15E5SE/BvpiLnUjiQo73vcuaublM
	 AR6MpDSAVEX1ZERI0QUiotvnQunineADRWFsW/UrlQVRgTs7b8K6i6GsaFz8Rq/G4e
	 xs2EBMi/OhRwWz5eO26cnljsYwr63zzM+DrETquz2I16Eb7LRjVqwR2McTJIcWS5Rt
	 lUoWeoiFxkxCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/vtime: Remove vtimer infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261006140113.3128582-3-hca@linux.ibm.com>
References: <20261006140113.3128582-1-hca@linux.ibm.com>
 <20261006140113.3128582-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 14:09:52 +0000
Message-Id: <20261006140952.C8A101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The only user is gone - remove the vtimer infrastructure.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006140113.3128=
582-1-hca@linux.ibm.com?part=3D2

