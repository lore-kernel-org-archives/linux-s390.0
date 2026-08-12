Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437302EBB8C;
	Wed, 12 Aug 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543346; cv=none; b=fNUOq43qG9d6RE8f55kWruROqTXMYrboztF59rAOogDstAvJ+nAPvnzAuJ+ZmYUijjv7aGz6zLbrjWPeVryCwWnGiO+lYyO2H+mijYsph36ux/keRNDHsKa4bD6+jw6ddwopriQ2NyHuPgcA6+ele67C+q5I+femnL/M8HSx2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543346; c=relaxed/simple;
	bh=Qyn6Do7oVMDSM0wMdhKGOBC6x7v63b5xyZrn9p1YFSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H1/2aR/jKVtB/sp7ViY6/bIVc3W5d9gjwVz6xCwWAXdsbeKK96Oox2d0yHL/fBTs5zHUtuWigXKrTQXBDtRbFqxyBNPmmG/+vsN+85p++UQAe6tT9TH+H8zyuOE7N0m+CXckv9jeaA1UEB0aNOUHuduWSpYtITwtXF/ArfWbwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiiCuF46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiiCuF46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650551F000E9;
	Wed, 12 Aug 2026 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543344;
	bh=Qyn6Do7oVMDSM0wMdhKGOBC6x7v63b5xyZrn9p1YFSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eiiCuF46ezyYtv4IbBBEmXgpTXNr8FfiLH1Uii561t684JXuilDswiY9cU5ttuOBT
	 ypE0olw4eXfQ1SHdaqhvl3EmoDvD5hif2AxOcebDgCIQXq62R0OV/BD0T8Qe2Uf/4S
	 4LEh9aqHtGaNvoBDkIVKSMsjNmRdj9/jiWgqIlaR5ZAwueXyue8IiQMHSacK2iFJ0P
	 QkpIm3g5IVlGwSsSglQsXxhJ+iX0SIIGj/afLfy/xVSjY8q2cGsOlY8BL/QTSI85MM
	 1cepcFv70wa/iUPI8QWJy4gLQTi7xKHoWjC4O57HwOiYawiqqiZC8TfUfbWqEffAPQ
	 MIgs8dZimEhTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/20] KVM: s390: vsie: Move release/acquire gmap
 shadow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-7-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-7-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:02:24 +0000
Message-Id: <20260812140224.650551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {release,acquire}_gmap_shadow() up in preparation for the next patch.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D7

