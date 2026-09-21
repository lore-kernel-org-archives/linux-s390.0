Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C524CB8C8
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007492; cv=none; b=DwnvBHcJm3VgZVznB+Z8Bs85Z4FYBRf86Zbh6MbVURFaHYkifBUuAzsFoQNcuAf9JAm5EarJxfxEzDAtvA9EMmif3XFR7Nk9LGZ21XAzbr4OGLA+4yPEUB3TJTUvQcPu3XPrRwa9mY8DhQrHosMIFH7SeXeEtszUci+1SeDqCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007492; c=relaxed/simple;
	bh=wW9vZeVPNybhqDP2NVvqyVb2X8NKA3LpRfByFNkg95A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=APQ2uu9Q2Ir7Mz1cQCVr5//4oldAb5ZXxiEnlrKm6AG7JsT8/Tz4obMYx0Isw3CUZhO/FiOYSPBoans30vo+VzogBwXjhi2ODpdyneOvr3GkJXB0el2OgTk9yjphNGvwQ3JFjKYizWvUQEr+NvCxWPUkS9dAzW4JdZBeB5ikoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9Xtsc+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9Xtsc+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06B81F000FF;
	Mon, 21 Sep 2026 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007488;
	bh=wW9vZeVPNybhqDP2NVvqyVb2X8NKA3LpRfByFNkg95A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9Xtsc+oIsD9ASlLgTu7mHlxT/OKUqFpmhCGMcw1viuOTmLKK+mA5K4G16STevNUe
	 DTYnKbDr8LjmTO8LT0ZnrQbZui7Pwxlpd4oqvqvhKhlEFrxEMAvwj04AUGtGPKR9jm
	 yV2v4OR3XnR/HeQR9+JwBLd/dEbxPjjE5zfJPKaMUzryRtIqbpinbFtZvihL7bidjK
	 BgixKrUPXB/tpmP9dR6MJ5IpjKkQ0ei9364c+YsLKnVBykzDCVJg+voSSjz051ZUjQ
	 8Lq5t020ToTILKPR2QRSVZL3RtobX42mSlZqz8JFQUPBhbvPpIDnZybpSSvEM4xRgE
	 cZUWDnCKFOpZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/11] s390/percpu/lowcore: Add and use LC_PERCPU
 lowcore offset defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-6-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:18:07 +0000
Message-Id: <20260921161807.D06B81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define LC_PERCPU_OFFSET and LC_PERCPU_REGISTER offset defines and use
> them in percpu code. This shortens the percpu inline assemblies and makes
> them a bit more readable.
>=20
> Note that because of header dependencies it is not possible to use
> asm-offsets. However to avoid adding more dependencies to asm-offsets
> it seems to be preferable to use the current approach in any way.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D5

