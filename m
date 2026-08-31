Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFD3C7685
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169513; cv=none; b=f2Qq+sktIY/oV7EVtqceHGSaCTzVntBnM1AzHdkiyAp0NgkShll2eM+Rl8QgMgz3HRdj5n4885xHl6+nNcNKP8ItKfML/rdfQTOI+LDgNkd/Rbe7FWCUgWc6QFZ9Zc/hnsp3V2x+xt1i45WFAyhPU5vT0ZNbIktUE4d9s71JjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169513; c=relaxed/simple;
	bh=XuBgTeVTU23xfocL8god93C2u4UAlD7lbNmyBpCRaYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WnRXPluL5gh3cDLTsR1oFHD3eCd+metbbsKaK2mnGz6E1zCkJihqVS/B7SQ4Ud8xfJxYhh4MNuAVAnFKtds4/69ZZWGRbXHNtqJ1uaRjUc0m9xNiirXV5/I1Tx/2lrCVBJtzuJqBQrAsEVoK/HCm85VCqrwFB6Jd/wH5Ns8waRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/s3wMmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/s3wMmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132831F000E9;
	Mon, 31 Aug 2026 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169512;
	bh=XuBgTeVTU23xfocL8god93C2u4UAlD7lbNmyBpCRaYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/s3wMmXVrLBoUnUEzuoROwhgb24IYAhNp2u70hGjSuKfkiZxsY0Pn70ZyxU4vBmU
	 6AwelByWEa+dv5AbKxsOmEcHAZD3ys6fwG4a2JyVjxNR4i8QuTspr5FQRHdioVNvY+
	 VS9fuLne69crPP3uf2weec3UWlnJoz4Wo5I8ZnXZSgPhJ5Njv4O7tILnwb94u4C9yj
	 5VNcj24Ugx7+5t3H/Z7oAEQdfavzqa5ppkSCqxYIRtJgpRq/TY4rqcZZPUH/dOAkkc
	 QHtRxEIJxYUpWipBsFNI34SG0raNrTrHpnE8gCHB8HOAFX5kdOaIWGCqSTw2LxZHvi
	 CbUOxjLtwTB7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] s390/crypto: Fix handling of EBUSY in PAES when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831083838.3703-6-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:45:11 +0000
Message-Id: <20260831094512.132831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a request is transferred to the engine via
> crypto_transfer_skcipher_request_to_engine() there are two return
> codes signaling a successful transfer: EINPROGRESS and EBUSY. However
> the correct handling of EBUSY was missing and has been added as a
> return code indicating a successful transfer to the crypto engine.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D5

