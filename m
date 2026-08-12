Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FFB43552E;
	Wed, 12 Aug 2026 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536773; cv=none; b=Kb84chnD1C5vEjZCMQLEkbBeI2V80T6eAyLqvrP1E4ZxYh6qoa7cZIEiOcdCIKWZTHws0nmMRbDiOzZ26jC/cxhLmnIynrZ+Z1DEgA41g8bqRkU3so6k0rg4M0YgyvQu1P274nWWF3ENWu/yqPke5Ab4Mnex9ry8LpZQ0XQ9O4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536773; c=relaxed/simple;
	bh=v/N2K0TQi23gfVKb9PZTfyr9whAU5lUWrWoH4Jy+BPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdsaAkXenAW3l9bA2GnS43cx8+UStzkOAOMDM/Q/PlCx4gwmo4RDb2szfBMU7iwp2H7fKQW6SuiJ4QaXnONtLaDRayHLXQSYE/M68npTAnY34fGh0/VYpVEuZDwyMLDAVUMz/CE1xSjk3MQQwaK04dBHBtTal7YMQCY9lUCI8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8PNPVOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8PNPVOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749351F000E9;
	Wed, 12 Aug 2026 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536771;
	bh=v/N2K0TQi23gfVKb9PZTfyr9whAU5lUWrWoH4Jy+BPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8PNPVOK2IoqSp5e6gnZA/XK29PqB1N28v2O5xg8p9LgN8/Ut+1WaJiY3tHJ5sWF0
	 v1OGJpxQmRNY7MMk1qtPOqEsVMc/Y2h3pJtNQL/IseeBOLcOeXcYmkZxHByiLciNOo
	 MMZL6s+LRNsmQy/lyJG/ZyquKcQnKJDXr+X4XiBHy9Gn0AAF06orx2wQE+K+736mEw
	 XKUZnGnEiyaLnIoIbsRbal/n+++nNfjvalRPwDQTslFxDraCL5hxgf1Pk0xeqZgzD7
	 KrjzKBdv986cidkoUyWaTP6/vbbk2icnk3ZO5sZY1gSCh88Hpy2ydeqTmfQEJTRKSW
	 UtnErq01te6JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] s390/vfio-ap: Fix required lock not held during
 update of ap_matrix_mdev object
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812115139.576303-5-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:12:51 +0000
Message-Id: <20260812121251.749351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In the vfio_ap_mdev_cfg_add function, the apm_add, aqm_add and adm_add
> fields of an ap_matrix_mdev object fields are modified while not holding
> the matrix_dev->mdevs_lock. This lock must be held while making these
> to guard against a race condition with another caller that may be
> concurrently modifying these fields or any of the fields in the
> matrix_mdev->matrix.
>=20
> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan compl=
ete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D4

