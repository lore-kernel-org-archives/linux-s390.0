Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0713DFC82
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560641; cv=none; b=kiTMAkSjLlIyLAAYklPTGsNMSCf5aHhCCkp0H7J0tl5yr/fQA49ARhCiYi85jGlao9w0jIhVT8AkBMLvvD9MAvKKpV9cIcDpY2mIQI708xUak89JHOg4GaeAoYrJz+KAXfJ5LMDig8fyNBRRPHQc5qxqeW+WCtlCsF+XN5XT1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560641; c=relaxed/simple;
	bh=BY0c54t9OzC+FaNWojmNXfhwIv1yTqZ5IfNcWC7Lpos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJa2h0vbuOAtVN0ULlRdGkMOBo21DDjDYl2UKj1cFnsHmpOhYoY2oU/JOVPvedrnVrpctIQayMd6S54jyvsA45cqqlFAUrJ37mTX9qyHGj5Pt4yRGphGY7P6q5Kinut8Hi4aizGA0gaP8JfjYDIaWDmVIKCIJ5DrEXROFp+gWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE5y4YMw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE5y4YMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183651F000FF;
	Wed, 16 Sep 2026 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560627;
	bh=BY0c54t9OzC+FaNWojmNXfhwIv1yTqZ5IfNcWC7Lpos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WE5y4YMw5xCNwA/DaAreI7Sf4x59dkzS3BJxbxNS/pSffbKB2N8CtRDLTuxlL7uE4
	 KUNtEmRz5U5CirlYclibjoXsrFpRlyvSl+zbGmPAW/gjRNDXwF5HpM+KOp9hpr/IM4
	 9VSrLM/MG5GswhmbVzAJwdCvu2TY1cqqpbSx/gSHfdhTuoAgya/rId2pR22b0GEDIp
	 dVRr64R4VA3cJH6zo1Zl0C2sWjlayYtzfi1Ezw4xMp+dtq2xl2CAzpRhzNH/6XzVsC
	 RCF6gv+bAJ6KREZM3Hi/bPS9GinmKeUmVtT6XfO7aZ1haqNEuNctsO5Ijeyr7f1VNa
	 DHYDvscLEudUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/13] s390/chsc_sch: Use __free(kfree) for
 synchronous CHSC requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-4-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-4-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:10:26 +0000
Message-Id: <20260916121027.183651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use __free(kfree) for local buffers in the synchronous CHSC ioctl
> handlers and replace their cleanup labels with early returns.
>=20
> Keep the asynchronous and on-close handlers unchanged.
>=20
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D4

