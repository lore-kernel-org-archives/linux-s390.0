Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A413C0A13;
	Wed, 26 Aug 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757541; cv=none; b=k9Blnx9dvkNMxAl9jLsQZdC9mRJ07NscVnyhPr9y6nMyTD9AKKit2Z63hFVNmH7Zj5fP+nDNVbYyc0Iow4pqac7fljXIay1tnuiz4Z6/vdaSzYwwLhWaNSDR4dCivbkWgMhAzZ/7pQjXOE16vG3Q/AbCHS+uAzSuM7MXLbeX1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757541; c=relaxed/simple;
	bh=hTbqFbl0rNT4uqef4ykaokq4o8GoSwCXD4VqVXUtvz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UCqIgNjK4twuC1kjp0zbfZwpwQzTBtwqCsumu+QkXpYiiWEuH9iTGXD5drjP3vIcCv81+HA2kgCg/mtrZmss3nIiTN3aeTOOEccZFI2E3rMniRT2AT/j/Y3jusesdtt+FxkYYVBdRt/YJ19kK1cVCnC/8ywFdA1H4w95GzKpDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5HXMJ0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5HXMJ0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAC81F000E9;
	Wed, 26 Aug 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757538;
	bh=hTbqFbl0rNT4uqef4ykaokq4o8GoSwCXD4VqVXUtvz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5HXMJ0dAkvYFXSuSI1z6jrLfPcdF4L1elkprIEe1+Y9QAqI+T2pVRNfgVESgUxxn
	 aQFsaHyFe44TCi3AZ7+WNNS0GAKTzfIKxJhL8pE2rzAt3NA8jYoYIlgc9c0uMT9c6a
	 VFHbMCddJoMo5dl0l5QEUrqEJYwx9p4LFdVMC7xx6wm95c7u/hxjjOvvEm4Qa2V4tj
	 2qOn4xCyGZSuU8PnJVBsoj8szqBW7en/PYDxgGy2awQBuVRykL9a4mJsMTjqCm1vOo
	 LMj30A0DN7R9XrHvZdp58fdTMS4RQhxxBPRipW/Q86KEi4+qjy7YbfcEKiX2HsIO6U
	 KptR178HNGUHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/21] KVM: s390: vsie: Add helper reset_vsie_page()
 and unshadow_intercept()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-11-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-11-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:18:57 +0000
Message-Id: <20260826151858.0DAC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Extract helper method from existing code to reuse in new code.
>=20
> reset_vsie_page() clears and releases gmap related to vsie_page.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D11

