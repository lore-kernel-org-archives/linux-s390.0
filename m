Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303225;
	b=kIGvX0C+xcOmk/tMrhUlFK7rOw7aIXjIbBaZwNmUSIm3D3yc4ro+to0l09jotJ3xb2Uw
	 IfrlGN3mBGkXsxCmQb+6DwPMChjS5MrwrYOt9liNtSrobRu5P1vYM8UQ1Bz05V6vK9DCN
	 g4czNRuyhvaal6qlbEuQnnn4+KZ7LoewUcb+rL7Ad4Ac1FXAYQEExj3fp7DOUw+qmyJzP
	 fUYW4UVdM2CIrJF3bwrAewvlCYKNzKRJDbMGG7o1n3O5M3xL50dYmDIumSfYpzLX57yq7
	 wm44I2k78Voy5UheYOGuaPeOkAEGBJvDo8e4RvALx0KmW44pDgI6TywfRyr4/ZDn3ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=agNgpb4e4UuLbuJ1ugF2+0E0Gw1FDddfWhPWliXw9Kw=;
	b=J0dDiTHCVVx8k4S7pKphOmkB2wFE63crDIap2tMtzVsiRH+aVq/opWnugB+iN4af+ZqA
	 i80oKJV8AEZCtG4bg9+XoUVU4B7vOmhp+aUu0EWmBaPfRMc/3SjDSJUx7MeGc0CzG6+VO
	 cEyDqhCip9PV7cBHKTWrtpfcdgK5SxOhegb6ynk7S+PQklqLs3QnL0YcVTfboQRRjkn80
	 e5DGWf4VNSENbvW0/GgSL6u3Fsycr3zjhg36nVyJqvayI05Mq4LtHP9R1GqlJ5ADQMW3n
	 UkwirHXwSXEv30pPTRrIp/CY0OCH2d+kfIZ8g9Azyxes8GfrNng01NEnpwcljkij3Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AC/pEV8q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15A606D5A1;
	Tue, 10 Nov 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AC/pEV8q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026FD1F008A1;
	Tue, 10 Nov 2026 09:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303224;
	bh=agNgpb4e4UuLbuJ1ugF2+0E0Gw1FDddfWhPWliXw9Kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AC/pEV8qEPc1ipUbIOS7g0ZLC/EFFMYU/XrWJAtpc/iFQLEps8rLJXYDwhSogk35R
	 jlv/08IGDrVAXGcU9Dr8j/Z60vi1gUB7xdg2F1D2KMCJR/rXLrqrHn7F2oVfQIg9AJ
	 RnoCc1zniGJnvui1S33U/kvidSwLAV1ZRWmH9ounQ0QjqRM9wGX+238sg+8P2vDzXa
	 SxXfX0lComjyZzmdm6Q8uEVw4hRn64zUZpqoqVVgR/UqwNPkE5HS/j/ZVM+uvO7otJ
	 0NC9FTDYwyK9R+PVvXsLmZzJrrCEMVhYaP5ybsnTEBf+upDoZ2ruxofaRsKMR2sX5p
	 9jEeq03Ym+X1g==
Message-ID: <sashiko-outbox-206766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 34/41] loop: refuse files on pseudo filesystems as
 backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:33:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Currently loop accepts any regular file that implements ->read_iter() as
> a backing file and any that also implements ->write_iter() as a writable
> one. That includes files on procfs, sysfs and other pseudo filesystems.
> For example, /proc/kcore attaches read-only as a loop device the size of
> the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
> attributes attach read-write as 4096 byte loop devices. Writing a block
> to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
> changes the THP setting.
>=20
> That's not just nonsensical, it can be abused. Loop calls ->read_iter()
> and ->write_iter() of the backing file directly from its worker which
> runs with kernel credentials. But pseudo files enforce part of their
> access rules at read and write time against current. Dozens of sysfs
> ->show() and ->store() methods call capable(). Behind a loop device all
> of these checks are done against the loop worker instead of the task
> [ ... ]
> Refuse files on pseudo filesystems as loop backing files. Note that
> file_is_pseudo() looks through overlayfs so stacking overlayfs on top of
> sysfs doesn't get around this.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D34

