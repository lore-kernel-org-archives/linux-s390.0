Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8F3515F1
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033873; cv=none; b=W///Vy9vvnxxRwYL+qK1VcbSQxIxa3LSy8jBa2bz5TQ4ymlzAfCwXms1gHCBHNdz98ByK3xTeVFlP/XSq4/7u7GkMOeV2JtODRYcsLR2bOFo9K/UeKKIFRUaigA6M9gqYUXHCMo1vTSq+sMm2bd8Kth+vLj1LokC8ARbe1K3mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033873; c=relaxed/simple;
	bh=wPLAm97YemB/niTBC8yAQE0A0j6ddmiKmwVDnRuaoes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TTQrZ7k+2sIaacQzjuJZiMZFkEz64gIdT/rOBUBVDkSFT+9duo+Z0qRUE8dCCu8H6ohXloli4lPvxXNunaL+z0elmbRR/1ns2m4qWl3q+1u9fwf9ttDB7Zx1jtOCdvQ6u0+CvuiA8QccL2q12S2la/A0YW/m1IiweKh3xNTE3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8Ob+Hb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8Ob+Hb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7B31F00A3A;
	Thu,  6 Aug 2026 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033871;
	bh=wPLAm97YemB/niTBC8yAQE0A0j6ddmiKmwVDnRuaoes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D8Ob+Hb4L1dKSF0Wy3pIRLv1TGWoJd5lLJ9EEjjrEzILOQ4e9vWGBTFHnOLxuqKdU
	 615WOMn1dQsgrMqKQrWkh7bE1ZJW/8bC6H5iLBRPNzCzQbYJbDmS66BN/PD62uSaG0
	 tIwnRQkD0Ys5ATpBMj+tUHPyS8vUOG4ZSPogiButRSms0uKJXuG53ZNk7NIejI6OsE
	 U0HOSUaDOIYkfsVhj4tqyNZkv0ZwEHEIbfMSkwxwj84V98njMuTxjpqLBlWTPMY4yy
	 aXulpXuEGVH+uWSRp9Z36uWCaKC8A/Gr85mkRBMtR+OAenSYJNV0uPPwVoqI6bbM6R
	 hVF/gAhx8o4yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/ap: Drop unused member from ap_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <55aa5d3b5b1794b5fca7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org>
References: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
 <55aa5d3b5b1794b5fca7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 16:31:11 +0000
Message-Id: <20260806163111.7E7B31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> ap_device_id::driver_info is not used in the kernel. The structure is
> also not part of API/ABI, so the unused member can just be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/55aa5d3b5b1794b5fca=
7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org?part=3D1

