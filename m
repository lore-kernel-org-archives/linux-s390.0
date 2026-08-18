Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9036A03A
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026483; cv=none; b=SFQteIhRnlc2ojCOs+dSvwy/UxghVHVNOO0RYusK4q3r9JlynZdOrgav2Aa02osJYdxlIP2M153Z4mUelvBy1nhXk+Slsr5M0FVYgLbe3iHSDP2asyWNWegQ0ywz0hL2CdC3kYqAaVCZDgXLCOcs/tlgGzfUDk3nCAEiu8koDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026483; c=relaxed/simple;
	bh=H/PjzlRDjzK2w922OiGBKutJ8vZWUko/7xHnDKUDBJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqP72sT7JDPsgEcxvtztwc674aUfiEgKyzUnp0f+UXQyV1m1ez1Y8I1vstkk4+dBnTca6M9eSCEASkDWUEc+LHe1x4SbegKj7Qxb/+z/zpRoi1v/PFUpOxoc+a8lGJ8oJJuklCPUeEZMkXXtP6199lklLh2KNipsZTfoHg3Uuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6VH1ext; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6VH1ext"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D9E1F000E9;
	Tue, 18 Aug 2026 04:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026482;
	bh=H/PjzlRDjzK2w922OiGBKutJ8vZWUko/7xHnDKUDBJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6VH1extumd3D49Ym/MC8z78qS/WZTcXgVcLr0luJm/kjVcvj0i2VBPMshoe7P2su
	 pZWQpMUXg3iTy87YhPV1zOdl2jd9/gNzox82R3rKycBPmTOErC8ErkQj2E2E4EEmoZ
	 NVi69Q9JDHN2iSGhHDPhNW+Ieb/C7UqWeoJ/Jteo1XY+MikVmHv52Uhr41nhRYvBwz
	 0YdjsOCn4/HiwwytYiO6urIQJ987PoNfpwwAmo3x66X7CtXPp3DzQ5TrvgnAR0w4np
	 eIuve5R8YMYUowguKAS9q0bWI26MeyiaCzymGlIzTA0BYnCRlzwoSGMJsjbSfBwviO
	 adHAb5UcCfd0Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:14:41 +0000
Message-Id: <20260818041441.E7D9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move ptrval_to_str() inside a header thus making the helper more generally
> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D1

