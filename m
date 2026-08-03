Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477151DFFB;
	Mon,  3 Aug 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761746; cv=none; b=Emc23IszxvC8yqa4W8zX+KIbj9+UhvVCEVHICZBCSJl3SuMTI8TlEL114xZpgIJ5sMkjB/kWCJFcQmWeYNiTtG1mb8fo9KyyOhWyT2qkNdu0/wT8TQBnXqlLu/e5WLC+g6XPLqLqzIMqjFKbO8AtGk7d0Lc92vMfnH0RMpjg5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761746; c=relaxed/simple;
	bh=OxoBwGQ3oVN0sTZexl4ySPhUQ60x+Q2R/u9KuhJQAwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V6DQh8YwQcrQPLDZjPB8yLnR9P1WAn4Abl2eVroAZFB8FEppXkm5CuKfU5gtzhGD54A01/VQbZz6w5DxNz60eRGZNL5nkxxtEbXbSjiKBy1lPD2+jQXzraZzQXlohkZHtWBWa5HgEdr5ENtIfa9T89qGB0Zrj3R6gxRrH7HRRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKHyCOX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKHyCOX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3921F000E9;
	Mon,  3 Aug 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785761744;
	bh=OxoBwGQ3oVN0sTZexl4ySPhUQ60x+Q2R/u9KuhJQAwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKHyCOX22iyNqdsjfJPfvuZ7s7CwU0tkxND4UbryQHHhFZ3dRcKbUFwJDvuB1mKuz
	 fAeu+PxNLavjQP8GrUH63FmJLwRydA7MVlWGsVS/3tK0N8hLaisRSXqPNWTrIFEpjc
	 LSIACZWY+Y9vMDz2N1LDo+nPkOyfdkYtla4+v1vjb5jpnF/BLr7ua9xtbZ8AnooMek
	 qhN3eaa4w59mdLSzidpepCAhGR9dHJINnEcFhpPHNyv1Uq+CAWKzyQi9jjJsFkNuAX
	 tQnMExCWnd8kd3q1/L3WHhNzL43p5WxEBhXWEpbaFiYf95aZuHGO8aZsZT5kScYmx1
	 wR6mZJv5UEStg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/13] KVM: s390: Do not free SCA if it was not
 allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803124040.126471-3-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:55:43 +0000
Message-Id: <20260803125544.0A3921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If VM creation fails early in kvm_arch_init_vm(), the cleanup code
> tries to free up the SCA, even though the address is 0. Due to using
> free_pages_exact(), only the first page is skipped, accidentally
> freeing pages 1, 2, and 3.
>=20
> Fix by checking whether the pointer is NULL before attempting to free
> the SCA in sca_dispose().
>=20
> Fixes: e72753ed1267 ("KVM: s390: Use ESCA instead of BSCA at VM init")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D2

