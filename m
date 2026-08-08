Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59C39B4A3;
	Sat,  8 Aug 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210459; cv=none; b=GF4Bjnlt+aQq/gvZWjfEXb+W8DQhpHZrTmYh+50tDtgaqS3U0C71pNz8FauE9x3j63SKs5/PtxFUFbGD3pN3sb9udmzJQE604DapQ0+76fHMVvACagr/X3qZ6IziaIRrFaUTGA0KNoATJ8/oLARPg02c4LhZ9WeBt6wfAOZ56JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210459; c=relaxed/simple;
	bh=1C0M15307IJwU8kHAB/8FCwb3oo6ISRhl669VPMn3TQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UkRqSO2pCHznOUsfEZAymrXg0qTUZc+uywkdUSMCKI+nI2qfm4/NTwa/pNKXn8W9vjGkZRYSLnSX8XDoW073Z/ySSSWGcrfIlSSQvbxN8WythcD4RcUgghWLfZ1Z48AW/+/7G8QAQMOAwOWSusBUYCLERTRuKrYIwJyfVJQRNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRz4tFwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRz4tFwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271231F000E9;
	Sat,  8 Aug 2026 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786210458;
	bh=1C0M15307IJwU8kHAB/8FCwb3oo6ISRhl669VPMn3TQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRz4tFwCmqwYGPvIBDjmug2DFmgSaxqLNJ3giFkQbiUl1nLW5gShVK1s8Tkk117OF
	 sNyZyenTuWyGMp4/5PE0cVSfX0w23yoKRugaYDKe2hcnNot8+WMlG1yLIbHRAEQfRY
	 66io66JKjG6ImuL9KtFK1KuD6QVlyS+1b5VianfXp4B6TEP4XoHSsVTq2tNSt71i53
	 28LI1WgnyEa8L0t11Gk0fUP2AkwLbFl8t5tj8qvBqQxfFLsD4+yUHutTitJbpxwPhg
	 dXSMFLAgvH26brobFncHsahs3unJRac4sJRWuJpOi9TW6Kx/9Uo0c7H+j86sXvn9+m
	 V0uSbqs/DCsTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] s390/vfio-ap: Fix required lock not held during
 update of ap_matrix_mdev object
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260808170712.839066-5-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:34:17 +0000
Message-Id: <20260808173418.271231F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808170712.8390=
66-1-akrowiak@linux.ibm.com?part=3D4

