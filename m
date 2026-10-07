Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE42466AF5
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373978; cv=none; b=CQCi5bgcZaM/0SauXcGFlnRTQkLfvdO+CgVLqLn4QhOx5GCwU3CIJdGVEPI7Gw0RUX+W/rirCDXxn5+xgSl4lTPnPIDQ4sAeRhCt/DSybqmprKos24hOmtwyPIluzyWgQ54zE0x4w1J5Fkq/B0WThndKunWeBjJt7SIxAzQL7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373978; c=relaxed/simple;
	bh=bQ1+y8mxx4lEJBbEG2qrD5vGMuRZ5hxxcmRRK5VIHiA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EbVr7gPmL+aUTza6SP7G/gg7Jfz/hAupfMuwxoHd3nt3PNKJTCkMoFlwpvANg6Lol3gNX3URLL3t+rHfNztZ8pswO09xzWGi2fxt5iTZ9x353dCc+R/yjBSIRNdVJMitl3r9zMhNusBgMjhcUL49qxpDoxBHCl2HZv2BkAc1CQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNBYwbwd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNBYwbwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2AC1F0089B;
	Wed,  7 Oct 2026 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373966;
	bh=bQ1+y8mxx4lEJBbEG2qrD5vGMuRZ5hxxcmRRK5VIHiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iNBYwbwdTJCYfrwz+oshvv2GcKunbXyG+bxjqbUoZO4VB4hnHfhSIVCa6GVX/Ks5h
	 CxeuN5IR45kAOp6jjjbXToMCvPbkTOqDUnYRofYxVFBv+qHsOX4C/qhWKIFfI2y5kB
	 CTMLxYUkR50QJ8kuPhBDmlycWoBva8aq9BAEVJFoOp6FgCrpxPHDgJohNMUMAd16tN
	 e1csBwH+yJHK+ynkjvH9+TUUB3LJJVu8HAGgvQdcXm8FM5WCxRjNtcMHWJIOAEvwBP
	 PR2OYDisuZMmtZBoX8p1UYq3/mn6k2oecWlHZBrECEGIQg605hnPGTdsCn3E1Tpifh
	 gW3AJDRKO7EWg==
Message-ID: <sashiko-outbox-162947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/15] xen: use hw_pte_t for PTE range callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <50a0425734a973b4432f754587621c71d5abd14f.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <50a0425734a973b4432f754587621c71d5abd14f.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:52:45 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>=20
> Generic PTE range and remapping helpers now pass pointers to PTE table
> storage as hw_pte_t *. Update the Xen callbacks to match those interfaces.
>=20
> Keep software PTE values as pte_t and continue to access them through the
> existing PTE helpers. This is required when Xen is built for an
> architecture that selects the distinct hw_pte_t wrapper.
>=20
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D9

