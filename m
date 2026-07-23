Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E505486E61;
	Thu, 23 Jul 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832167; cv=none; b=i3WrncZVWQvHH3uV5mKjy2iESL47QlMfUmzt5VHTpkS9I1+F97j4nnwnzv1uVVd54oGsSt+bc7SV8bzLF1y6qVzk2OmnxxENdtIV7O33vBu9snYnUwM4ewq2hPsgAClcITa4b2BQUSWxZ5Nkq+1NM2E6ic2iO3cKnQPChKrhCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832167; c=relaxed/simple;
	bh=yVUHDzsOe0/OZ5C3aGOuE6wpKssIrCaKBcN9BcS22t4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eRAPtHnK8VrxkTvlrm36mTyEgSuauwxcrKT97zz6c/kLGk+hejlyAC0MsidmcQG9NQen1JZjyZ8Sh0hdspjcOJQH1GjaID3jhkD1jLOzvtdKsbF6nadcySn+QxruFPTO6BEkWmd6bkYWGm3fLRe0ovT1bw3W5DG3t5qHoCJqqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AizGEWNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AizGEWNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFC01F000E9;
	Thu, 23 Jul 2026 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832159;
	bh=yVUHDzsOe0/OZ5C3aGOuE6wpKssIrCaKBcN9BcS22t4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AizGEWNHKWl4rvCP384Zus0eKULE4cYPUXamVAalnw2S0QRUmAx1FgxY3IWvknDmO
	 spQNsS+9nFyeS+b92ap07lQH2reEk1o1V7ABDMU41YlTjcchAD7WSnNo6g59JRfpPb
	 8gD1Gpx1NJl/nFVkTSGRB7ALP8vZUACQBA9M31dErym5wvBDciFEnuz+NRKiFts764
	 8LabDp6kxk6QZEt73cqV1RwYwpqVrgw2xDhL85vg2IFKjYTYs729FNsYg/K/IrOEb/
	 Dkvk62qWHx2v1vfUJK993ayrtdf2MXWxczhAoJb/OcRt4kAwHUt4es2a9fhIB9eDN0
	 iymkODoARoZGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723183440.3271-6-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:42:38 +0000
Message-Id: <20260723184239.2BFC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
> an error code but doesn't do any resource cleanup, thus leaking resources.
> Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB a=
nd
> unpinning any pinned pages. While at it, remove dead code that stored FIB
> values that were never referenced.
>=20
> As part of the cleanup, we are also holding the aift_lock while executing
> the MPCIFC instruction. Though this is not strictly necessary, it means
> we don't have to drop and re-acquire in the error case.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723183440.3271=
-1-alifm@linux.ibm.com?part=3D5

