Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23F3D9DA0
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344861; cv=none; b=sbSm0mhR+tLiSNR1nGQ2RAltH+sNG44RCwnpFxOjzenKUtWCj1JvSin/uCdylYbHm3PhjkQBMo3hpPUC2ot09szWpBXoNxCfvkFO0BkMv/6uTHjBHiLcMbzIJHuMjmVlolfUmWehQTUwesSQA6zlOmO0Ok7kXoYWte/ClrE0e8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344861; c=relaxed/simple;
	bh=lc4eeqs569yI9YyLCrbuZ4ghPtst9BznbgmScuKdWcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G2jCnLPBSJ3/b/Nvb5SQwMRxROyFKb3uuMaFQc+EgAzm4aajHErMMYVBd3Qg3h+V27w/AtbyGLvq8pGMWEx5I7fbwDoSDNBae38D/HpkGYeBhk5fsXWNtMYOe2tBtFoVjFxoewYwZigN1AWl4hXH7kzIvPWtoQctuysTBm1KvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VssgPC4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VssgPC4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FF11F000E9;
	Wed, 29 Jul 2026 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344860;
	bh=PTMsJzRa9siNZDNQKLvLw7EixQ/xYF3JXtBcDJQtWq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VssgPC4mIRNxZMayu+c6sTjEx1AWlVPf/e05tE9zGst5j6MhXrXQYfC3gByFo/U61
	 VFyPdQAbKNsPzhgN70PYUimYPYcl8bYeGu+C07DYwCCycpRXgKo3p82MQbAQkp1N2r
	 IIDu9BP1aHiUS6uwqpLMRQmWcYuv77nUbtOJG/RKCcENKYHU92yE85p4MhGPhLl94u
	 uZejKd9H5Z1WhSyvAU+LKmzpF8wVkN1AzRwnuQqwLuHuMcLuDuqRI06Lqrqc9/0nbU
	 +Kawb6BQqw08CpLyckOMfoN4oQhWpGylvY0HfAgIIP46H+xJJM0ArPtN2Pr/VaTydk
	 y1iG+ykm02wNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/5] s390/zcrypt: Pad trailing CCA or EP11 message
 with zeros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729154458.195135-6-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:07:39 +0000
Message-Id: <20260729170739.C0FF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but an integer overf=
low and incomplete bounds checking in hardware response parsing allows a ma=
ssive out-of-bounds kernel memory leak to userspace.
--

--- Patch [5]: [PATCH v9 5/5] s390/zcrypt: Pad trailing CCA or EP11 message=
 with zeros ---
commit 0141bfa352999fc87f7b7c58c7c727f991c4b416
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Pad trailing CCA or EP11 message with zeros

This patch fixes an information leak to the crypto card firmware. It zeroes
out the gap between the user space copied message and the message buffer
length sent to the CCA or EP11 message processing.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index da7580933c6f2..4a60540b07003 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed an integer overflow and
incomplete bounds checking in hardware response parsing that could allow an
out-of-bounds kernel memory leak to userspace.

In zcrypt_msgtype6_receive():

        if (t86r->fmt2.count2)
            len =3D t86r->fmt2.offset2 + t86r->fmt2.count2;
        else
            len =3D t86r->fmt2.offset1 + t86r->fmt2.count1;

If a compromised or malicious crypto device firmware returns a response whe=
re
offset1 + count1 overflows 32-bit arithmetic, it might bypass the buffer
size check. Alternatively, if count2 is non-zero, the bounds check in
zcrypt_msgtype6_receive() only validates offset2 + count2 and completely
ignores offset1 + count1.

Later in convert_type86_xcrb():

    if (z_copy_to_user(userspace, xcrb->reply_control_blk_addr,
               data + msg->fmt2.offset1, msg->fmt2.count1))
        return -EFAULT;

Since the bounds check can pass under those conditions, could offset1 be
used as an unvalidated offset into kernel memory here, resulting in
z_copy_to_user() copying out-of-bounds kernel memory into the user-provided
buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729154458.1951=
35-1-freude@linux.ibm.com?part=3D5
