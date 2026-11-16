Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828203;
	b=M0kB/WSsHGl9SsHpH0Ncre5aBtJkWY4T8VDBczBUmf0B9A6HXOP38unot95lWBDcHcXg
	 lB5xDIVf44w3ECbyQG3F5t3dHboBYl4nUAjYdI+Eg0V349aNbVGilTMPx7jRp9AkQNGPA
	 voL8m9BluMZr98Y5UYDy0OOrkG9rJMDb7pOp7K7U3mmSmo+YDhdlS+9FMnfLONw2yASti
	 o0QEauvcdwhkfefhS8pNoZB9Xi4sPS016QE8XCWCn9bpWZNeTTmHnitQ4RF0Aap9k/DB9
	 Bg+2fHdJOPAC8GvH1KdT28Vl+xq/cp4ARqHxkJBUCRkp3mnUnyMptXKx8s3UXcAKSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828203;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X80pIhV/ltWtN9/tTi/4gch87ASxukPK7ythYnGH2i8=;
	b=gTF8V5N3d9zgEl1axRkm/ko73tys8/Cj4P5vyNFtPSDPKYOtDv8Hbm061AAYQA8I3Q9X
	 VjAi9r/SeSZd3SkByRfx7RcppK5GxtkAz5hTHkOHMKIS/t7xb2icA+kOFrhcCMkZevyOC
	 geFJ5rkm6MKUtosfcwQ15CpG5JN2SRe4nr/YnOVVqT57IUBmJbqAtZgDoH22tun0a4U1Z
	 US/AFMgDZt9348DkKKMsXlWc3WaP6BlO8dCQfw9hR2FuKeGXCsqKiy+bDSJ/R3o0XnV/M
	 b58sv1BM2eiPtnxLVhHJBwt6uOsMnsJwoM+rKh3kA6Yk4CjtxdHL7jWVDpx2jyeoPXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Leut2etw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B4606AB60;
	Mon, 16 Nov 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Leut2etw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B551F000C4;
	Mon, 16 Nov 2026 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828203;
	bh=X80pIhV/ltWtN9/tTi/4gch87ASxukPK7ythYnGH2i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Leut2etwB2gUeOz1FXi6uS3yQBbVT4kNUAaupYkO5FO/ca/xvDtsaMQOLdMfiDS9b
	 fYghQ+OXRULadKjLJsH88Mw3U5LrnsIsJr3Q7fqU99FiQl3qDJqG6qWUyeDNSCfZ8w
	 eP10w3g7Jwv25P0zp06fXV7kgz+uocBJ+gXWxVaNw5oZQbCuPoMa9dZprtdB6MJfWZ
	 VKqpEdJZi95T7Ub0Kh6pkU4xElRMTlGwwduLrhrwSHQ4B4r4rH5sBbCPAmDHsAPj20
	 FkFj/A6LqSyEE6zVykYa839v51f0e6AKzkRpD2byoNfCYnb8X3sGHNki8FtHYfWYfu
	 rV27tB7TdsqGA==
Message-ID: <sashiko-outbox-216910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:23:20 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D29

