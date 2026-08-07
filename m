Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174A4B04B3;
	Fri,  7 Aug 2026 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096928; cv=none; b=aZW4mbhSl/+AwtFVi+Dml+neIcxJ2/8hV09ZB0L2Nyh/v/uIZXEPRAR+vmK2XsZdapbXP51NbPRMgtjJIKIntWKzIFKNvJhbR4q503V/LSRt4x0uIme6HxZJPRp05jz1QS9QBw0ljrxIXLe5QoK8IoAqc+gwn0c4azs8mpnnt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096928; c=relaxed/simple;
	bh=dTdoO+Pb0AyYKEztjMKvQwMI4OZeHcB+Cv15q4PQRo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JkefLT5O4WltUYyr/7QcrWwrp6kkesx5bDmkQaWuwVMLLHCjk+I6ctjcwL+J/4Zj4D2Nvo0ARDpA6v7Uebyg5FCq/HgZSx7IqdjLyYWmbz34PcLOSbHY10bEye+Y8yLmZlzFvsejQCTpzECN/wGo2tnNQkm/4HP7Q5ltpV+9D3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMz5jnvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMz5jnvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466B61F000E9;
	Fri,  7 Aug 2026 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096926;
	bh=dTdoO+Pb0AyYKEztjMKvQwMI4OZeHcB+Cv15q4PQRo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aMz5jnvU54EWLTGbctogT99qAd3O+V1EULUNOvwZ644ePNeXn7ZCH7jOzrKvK7iT8
	 lS2F7uS8pIjAA0y7PzpGNenoN9Q+WrStF7d6gVhEb4Eo2+1AfInRkrTXVHG4mbCZvf
	 XZLeghCmhjTpzQ8M/YCKkiAItoInqa71mjBdsSwlePTKmzf2y3kdRxgOc/h3aBTEHz
	 8MXEd2R+gNXBBus5VGTdnmehKiFR0LpHDWl3vmRYo+l6svukv1z5EqXpt3SuZYRJtg
	 vJUtYWSEreygZFAbNji/TJEhFLqVKND2u9jASZX5immmUaeO7ubE3Gtr7A0fydItgM
	 /tAeOSegzuOIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] KVM: s390: vsie: Assert mcck_info offset in
 vsie_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-4-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-4-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:02:05 +0000
Message-Id: <20260807100206.466B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Ensure that the backup info for machine check is the same offset as that
> in struct sie_page!
>=20
> With the assertion in place we do not need the comment anymore.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-vsie-clean=
up-202607-v1-0-b18659b55e3d@linux.ibm.com?part=3D4

