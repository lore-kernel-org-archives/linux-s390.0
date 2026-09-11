Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76A33F8C4;
	Fri, 11 Sep 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137902; cv=none; b=gN72PJp6envgcblVYdM6p10RrdZOimep8gNrqljCI5qt04en0Paj0MDex9XAcz7+PT3K1zdLwq1SXpQC7quEyzYCvphFQW6GwgVhS2hPut3set1OPRBmbgygqwBZ+6sw6rR2ZfQmoGWdOMVAlsHk299Np10FfnZKXusxt7mBXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137902; c=relaxed/simple;
	bh=9meOAPkhZoiQkL+/gHswr0dJCvHTncNWKc+7rVpDTpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ME5HXEuSjXEBLy49rI6w3p8mSvpRTVrOTLuMja3CIz6JVmyHkoy79rgk82wiKNNyQo3SAfZtUrNmemXYpKj26LMl7ddPJHZOKbHxA1nTx9tBwzrZLmxzX+hui+MpIACFQBo3oGOxIX4t6kJw3HVjF8VGQ2Imjejf+Wfy/QBeESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSuuKpGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSuuKpGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E861F000FF;
	Fri, 11 Sep 2026 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137901;
	bh=5QLhWEYWPmaw/kjYG9D5eGwJF06d9IfZkJP2dF0joMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSuuKpGj46XJBd6FLM/UOE5I+Wh4DOPF8cTkFqTI/YrEbf6SsOGc9tX730CaIGKhA
	 aAbEnHOHYCGSOft6vPsGWln9GhNGaPcNj2XHN2zH8DwoQdeBhY+8Z6Q/xrGC6N04oW
	 rP71+KEr/d8w67MrEIq7ARt6ySfkXQ+NxWZLSpG0gkXA8CftpITtQO7d1dMzQlAUo/
	 TU0bCvev+WzqQZZ6RtnDQGpsME1KdVeTJ0KNsM5ddGHe7NzvkXuhz5+0jg2+f2nC6t
	 GSu0o4W7dMvBoGjEouojPw9hpz12FCbFrbYDQpMgqYy0HZxCChJK8gseCWcaaYN3PR
	 ioruUtHAjn2EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] s390: Avoid indirect includes through
 linux/module.h -> linux/elf.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-modules@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260911-module-include-elf-v2-2-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
 <20260911-module-include-elf-v2-2-954c732975fb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:45:00 +0000
Message-Id: <20260911144500.97E861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Several s390 files use declarations that are provided indirectly through
> linux/module.h -> linux/elf.h:
>=20
> * arch/s390/kernel/nospec-branch.c: s390_kernel_write() -> linux/uaccess.=
h,
> * drivers/s390/char/uvdevice.c: copy_to_user(), copy_from_user(),
>   put_user(), get_user() -> linux/uaccess.h; file_operations -> linux/fs.=
h.
>=20
> Add the missing includes to these files in preparation for removing the
> linux/elf.h include from linux/module.h.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-elf-v2-0-954c732975fb@suse.com?part=3D2

