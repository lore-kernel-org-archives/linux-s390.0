Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A531813A;
	Fri, 14 Aug 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725744; cv=none; b=T0wp4k2ST6BwHbdM59Xsf3KZ8P4yzU4+BoNmb7NVDdR+Y2LfAoQ3z2UsROrQv4qBesXG4kJwSqAdRaFH0qLWGoycdv6vJUUk4e7rILqJ5qVVf/+UXsXlnrjT2E355YNdET2vCsylKgihx13E6JrBWcXI5SZZfCw288R47SAWydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725744; c=relaxed/simple;
	bh=3Jj6piIsP1UOKFdmZykcC3baQIO78Cfg8b9yMLe53Rc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FV53GH2loJ6kdJJWyKtd4pro4zzx7FUHHsQ9T+qlzPv4dOUYG1EKPmRCjZ3j/gEA8JCd+xfEQZrcCV5SEzJ/pU87SwJOx+c1hobpSYQ2Nb81xFMiCsDHOx67VPtyaIH0bedLBybcPkJM/Sf1tVk9hLLBAVUwuBjj17RMdBeTf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYdirtWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYdirtWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ED11F000E9;
	Fri, 14 Aug 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725742;
	bh=3Jj6piIsP1UOKFdmZykcC3baQIO78Cfg8b9yMLe53Rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYdirtWbroJa8/Y8oPn9UZxOFEPSZKBMIE7Q6+8l61aIf6ldyP8igIxWbYZSn+gDq
	 GYyGwy+Hpi8HgVSbsJeskzmMUZ7VOSzMRA2vS8nb1CqJD6muwQvmoC2+A4uzxsJaJ9
	 T/I/fHlaYCiiOVX+jFQfuiXmlWL5yk9SKwmQVLrqjKUfGbbRwYh8fLmR0E07adkyGr
	 sFohAaxD5mX7iFcXHB81jZ089VYSROzED6xOIgkDc8in8hX7oIWSZoqIMVLZke+XFL
	 bsdi0LwzCU6FqBw8g3JTNL8VAQWgjQePNYOUV+5MtlZ5qZ+uE21QGlsYidHDh365DQ
	 QBX1Pf+Ipooyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260814163355.227191-2-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:42:21 +0000
Message-Id: <20260814164222.62ED11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When the indicator and/or summary bits are set in the guest, the
> accessed page was only marked dirty in KVM if the access was performed
> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
> fast inject path would not mark the page as dirty.
>=20
> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
> for the inatomic path set_page_dirty{,_lock}() is not needed as the
> page stays pinned; the unpin path correctly marks it as dirty.
>=20
> Opportunistically reorder the local variables to be in reverse
> Christmas tree order and refactor to use guard().
>=20
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use map=
ped pages")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814163355.2271=
91-1-imbrenda@linux.ibm.com?part=3D1

