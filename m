Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE744A724
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517542; cv=none; b=aXWfiQ4wxRM6ycegC2oF+JdM+AyFFoCy2/9jjO/ItI9rM/lfUjCCapwKm6OWxh+pvzG7dT27YpUH8b9SekpUEdg3sOA/eilZV5z3NZJrbWGopfmmfD0Q2JyYx7Kg3R9Sr75sHHZLQ+MteSgjB0ry4jJT5Nvmriz/+0u8IZnl104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517542; c=relaxed/simple;
	bh=Gc5jBz3q7Fbkl8TZL7fFe9WYgFOL7bWf3DOclFEWKBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZVdup5VhVFXrw5rTGqJonE5wXbJt4LWMbc4+BQy2dhk8WR3SO3uKOtXuV65HcnsWaj0h2WY/AndkhzdMHDAVj43u7FdCjCDphxu/uaPxynPpV1od253uFxhtot/PLcxT32TNwRqoKMXC2zDcKt6nh1wOHRKdrHSl/HV8KzcK5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxYqKznq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxYqKznq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBCC1F00AC4;
	Fri, 31 Jul 2026 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517540;
	bh=QBfeu/h6E5ddLDvNcfPtpD1sOX7Fhdi5papgz+F5J2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxYqKznqcyKqQeAABvRJ+NCkByeU+DCqzR6OnhttzsBGCOIxocwGxhbhG8oI9CBZd
	 gV+hn3eQ9pAys/yBBoPp6I4752fHd34ALSL9TRRXYuy/KHmgNPpEwlm+psC+JyLois
	 2sj9fAND8bfiT+9m5eESIGtETWQGBsrj28HL9pmOQmXNwkzyNG0XkKv87IknKWGAdW
	 ZkaqwFw6f05rM2HlTZD8EYyyWsHpRyYbNF01mJ3Pvf1U7jjgKYRFTDTeOsryoQibER
	 XduwJIYcPFjiNPLjZ9dRwPqo+LF17mYpnMWG0ugDVXlBrjLeO1+YoGUZDu+MvXVMyE
	 iUxN9GkbfIvKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] KVM: s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731165004.2758105-3-hca@linux.ibm.com>
References: <20260731165004.2758105-1-hca@linux.ibm.com>
 <20260731165004.2758105-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:05:39 +0000
Message-Id: <20260731170540.3CBCC1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on `user_data_len` allows an out-of-bounds re=
ad of kernel memory by the Ultravisor.
--

--- Patch [2]: [PATCH v4 2/4] KVM: s390: Remove cond_resched() calls ---
commit 6586b58419c33753e59827884fdaa5a7f473b641
Author: Heiko Carstens <hca@linux.ibm.com>

KVM: s390: Remove cond_resched() calls
   =20
Since [1] cond_resched() is a no-op on s390. Remove all calls.

This also entirely removes uv_call_sched() and replaces all call sites
with uv_call(), since both functions are identical after the removal
of cond_resched().
   =20
[1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> index e6a264c996ce3..4d274a2ee84dd 100644
> --- a/drivers/s390/char/uvdevice.c
> +++ b/drivers/s390/char/uvdevice.c
[ ... ]
> @@ -224,7 +224,7 @@ static int uvio_attestation(struct uvio_ioctl_cb *uv_=
ioctl)
>  	if (ret)
>  		goto out;
> =20
> -	uv_call_sched(0, (u64)uvcb_attest);
> +	uv_call(0, (u64)uvcb_attest);

[Severity: High]
This is a pre-existing issue, but does get_uvio_attest() validate the size =
of
user_data_len?

Looking at uvio_attestation(), it calls get_uvio_attest() to populate
uvio_attest, but there appears to be no bounds check on
uvio_attest->user_data_len. Then in uvio_build_uvcb_attest(), this unvalida=
ted
length is copied to uvcb_attest->user_data_len before making this Ultravisor
call.

Since uvcb_attest is allocated in kernel memory, could a malicious user
provide a large user_data_len (up to 65535) and cause the Ultravisor firmwa=
re
to read beyond the bounds of the uvcb_attest allocation? This might lead to=
 a
system crash if it accesses unmapped physical memory, or it could leak
adjacent kernel heap contents by incorporating them into the cryptographic
measurement returned to the user.

> =20
>  	uv_ioctl->uv_rc =3D uvcb_attest->header.rc;
>  	uv_ioctl->uv_rrc =3D uvcb_attest->header.rrc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731165004.2758=
105-1-hca@linux.ibm.com?part=3D2
