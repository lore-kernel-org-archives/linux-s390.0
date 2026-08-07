Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF9455168;
	Fri,  7 Aug 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141687; cv=none; b=nEG/+K5EeOelGnDouM7ek57jSrveucQJqE0mBHgezcO3msVXCz0+hG+QFYQ+V2tLwtmAXKVDfeaPXMxqf/EOfq699LQ+1pn3enVDI5058Ew34Li1bSG8A8synllF3JKUSRb9Uua6gRDHQlSzmNOY+yOQ68qFaABwlXhDCL/xcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141687; c=relaxed/simple;
	bh=rtq6gxaWjeq7iss6NNI1fOPb2/tT2SmPYoTYNJxt6ZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BpuG69ByjQBeIPOX1KGHjNId2r215zmu2gA7ZnCGxTfmy0oQhcR3CCtmE1xtlrIu/mh5BzFCVxdTvKY3vIRTTrdwgn1wF9fEYuNxYzZStK2eCppU5sVQ1L5LJSfHPRhD9y6HIRbHAw1cXnryIv5SN/T6P2KU/mOWXX8+v/8GJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRMdfzZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRMdfzZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825CE1F000E9;
	Fri,  7 Aug 2026 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141679;
	bh=rtq6gxaWjeq7iss6NNI1fOPb2/tT2SmPYoTYNJxt6ZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRMdfzZS+KTXHSXxyxMpZsg1evx4ZkPx+eBmHVOgU51ncbWgFobitBTwDrCO93hAn
	 wKED//OxgRrPcr5qhcoXROxEx0WlBuf45+q8U4Jf+zkaE0XJ+uAa+lg5DiyUfFpCw1
	 0SNiEWkZCdO+Sg3JqLoxUNktHm5wpgkhtKiHAjkFgTuF53pxD7blCt3ujjxIyMXar4
	 KbNzREKzWUw/Uys+U8YWfiHaF+6yGAJAvgrBwK/JIjRn2UKr9qMsTbxY7ktFVe5m0f
	 M5UIZ01cKplgrMPSDLq2vAJDlWbB1NW9ByL3LDSJZceY56EshGldTFUnytBjDXhCjk
	 kXwhr776BCHsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807221834.562851-2-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:27:57 +0000
Message-Id: <20260807222758.825CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D1

