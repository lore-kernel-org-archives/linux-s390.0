Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA937374186
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973053; cv=none; b=cZV4A3ds/snE6R+1k6ct5VfdDTtAUtKCtgi8ySVp/z3VaIQxwEeI23dsL+tqRW3HPzZz4llEzMOjT6SNrmdNr42jGS+UPGaqrdJDwjv7DMQXc8ia+E/Ua9oi03g9RaCTAHAj/vwuPp01zcwZ64Sto2Qa6X38z4celhgPKgblbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973053; c=relaxed/simple;
	bh=rhlSm2vF4vFby4OERKCxmsQXXZqXz8kjfD6BMRRz2Ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=clhQlATBGf/lNvauQzlM0LRTt6DiDwEb/YI5T1mcFzN/W49F6xjGFuVgfLGEQkXy19+JqShgQigH2CWSQXIYXTTVWnwecV7hwMLcAOv54tq3s8qOiQkS5YToL58rx+GT+h7gaTmxfng52QOHscjKAlyi7tLj01Zglm7L8RWq43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrhEX7a6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrhEX7a6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D9A1F000FF;
	Mon, 21 Sep 2026 06:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789973051;
	bh=rhlSm2vF4vFby4OERKCxmsQXXZqXz8kjfD6BMRRz2Ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrhEX7a6gPfDD0Q6U3ncRGNgjvwsHh526MyJ9bqaE23HOoWHaBqEDtwt1pG+hlWv1
	 +yl+Uvzjfp9EeRrNunFgoRwyKW1nzAmM7vxUjUeuATV6lN4eJdFl3GEdpHrdeQeOuD
	 jW3KdE7BfzU/Cs93IgwDrCD/KXee12nX3SL/eepMtyNv3EIkK5lPQuOAk8jI2KEhAk
	 +vMJ7lRwL/lDdvfIhWGb8CRTh/5f56zw8p0szyDBaEwEhCAZtUkS3JrTGPMNBrf8Lz
	 D5qUT7gxe3GpId2Sa8Pp/KrbQV5aRCjoI+sXMt1h7e/JNWkLL11grO7+zafOXs8WGp
	 2nJp/vPHYf6fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was
 explicitly set
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260921063628.362078-3-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 06:44:10 +0000
Message-Id: <20260921064410.D0D9A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> swiotlb_adjust_size() must not override a pool size supplied through the
> swiotlb=3D command-line parameter.
>=20
> Currently, it determines whether a size was supplied by comparing
> default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
> explicitly requests the compiled-in default size, allowing the request
> to be overwritten by automatic pool sizing.
>=20
> Record whether swiotlb=3D supplied a numeric size and add
> swiotlb_default_size_changed() to query that state.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921063628.3620=
78-1-aneesh.kumar@kernel.org?part=3D2

