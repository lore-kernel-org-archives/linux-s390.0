Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302905;
	b=KeVCqZHsU8xhvDZ7igVjjrFImJZ1bYjZJ+2nKv3oOGH+o+/twz0DxpCXvCa0Y3YzsVh9
	 xN2hiABob532VqgpBDfsR5EgvbrfqAO1/RUpWc2ebL71pLyULYM4KEbikhyRuXKjBs8bg
	 fwElTCPRaF/gCaXHsEldi3Xr6N52nBKMWKnrpb29Y8HkRsv/hjP3KUjVg/HyRPpTGxmAs
	 2Got8VIf1IbxRcK4ljz6ky8eVjoIaTY+sy9S3euJPG5Gqg6NvtFn4RrlyCmsv0Td9M1OR
	 qLHIFwpEtsEC2nJ3oLigRBY/GWnG6qNuT9Dom4EmI5XtlzBFqcd3f33QmUZYw/xwREg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EDrlvOH4AE4zsttPGp/kzS6ad6ZLk+AeJ4+9Gxp5Kmo=;
	b=TkD5I6L3W2ivyBHtg9obR5y6LUlekspBQBzDfBgIKsRT3a2TQcO/1piqJKhsH6aIFliX
	 xHgAIKEe1FjtCXMUHvUUOYD96hvvFu1dej4xH4IALiKJPo4BG/oIr4OCbrjrsoYXaof7c
	 sGf1Rtud31vmcwChB+sa6mSj7nHyuXIyV5d4vUypgbaN0eImnKRcDhB+N3EnaTR21U3B1
	 /ba8FcF9QsemxEZuh7/5YZCuz0YVVFKI00bOvm2gYGzY/QCXlyAYWdTmzSQy+mskxhqJG
	 NfkJklIO+y0mIaPUrs/fBbXiwWknFAJAMdIMtQ+4tZEvfJbpFbDszGht+cYVhn9LxGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sctq63gJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB58606B9F9;
	Tue, 10 Nov 2026 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sctq63gJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C4E1F0089F;
	Tue, 10 Nov 2026 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302904;
	bh=EDrlvOH4AE4zsttPGp/kzS6ad6ZLk+AeJ4+9Gxp5Kmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sctq63gJLeG4Ak2036PbsYvZvxDtT9WlF7LEy2ZjiTlvbxuK/ol2theMrNFB+cgWy
	 02TBnWkJ/TXbG028ubnzI9tPpbfk2b4usJtIY2w84hfBx2K2Ghl0myNXlyaqT2YAFP
	 W7ihv4RZ57ERAtWbFD3xcVFR/rd7rpGdX+VCONuuiOmNv8Vx8Ajrh0vX9TSBYtSw2h
	 KKT7BlMv7CtXsZTnaUVVJ7Rr/MMsLX7didtJvZFDlbW8RkiVVrtlPenlKermqBWaL1
	 /3n+5tsYoO5DNBuZh9pnwnaV7dmPkeuhxg5r0fhKadySGohnMkCJGmeVZefKb/xHlD
	 mjT0hi7yQz6KQ==
Message-ID: <sashiko-outbox-206757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:28:23 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D38

