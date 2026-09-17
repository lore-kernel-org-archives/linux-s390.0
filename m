Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F640DB49
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689358; cv=none; b=m759j4QYkFbqDtEYhIWs2SCTfOZlqOmWPZ+AspeITKs75aPs49Z6xi+ONUxdNSMAB19zVKb4CCF1dy7TDRHsCn3+ZTPK/HX0VsvlZ+0kGz0BVuYSRwvbXQkNmtBHAIV4Uyv/PjJFI0LYdRdScspOgwzdUOhysND++E6vxsi/yr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689358; c=relaxed/simple;
	bh=lvK2WI8nafCy3bHDAdhKq91n4ESlH5SXkHx10pAJ4t0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nmNcwcLIN6PDcJvohU+vwkm3t75Ttq0QKjZDD7VW8zsYF58QyRKtHydb00XxpBtHxrfd8/TXln0Y6nA9KSxsmj+Ttc7x+A0EzGW0N5geJsQMN/lBkaRfQT/wY9jQVta0s4g4zEUJ++M5lWDGI53mN8Zeidd422rcliFdEf1F7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbW5a0on; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbW5a0on"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DAC1F000FF;
	Thu, 17 Sep 2026 23:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689357;
	bh=nIrIngBJ14U2WOMWBWP46Wt51vCtyl8OIskODPZ0tLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lbW5a0onRFZYEQKtNNpjn5xunFyTOv1kQ5P0A/QVkh0aMQlwFML2QRobF4hZDx5Yw
	 lHFIv9wmtmKB2VMjYyYfqnYWIgQn6hGMNylqVp0bghVlAAqnj3UXgPYqxRcX+9T1pL
	 Bx7uIRFrzuX2fU8IlBlLJwmNUdtq2virgwBv6r8bZu3xhK8nlezhFwGgr0eE/h/HTC
	 aG8aIM6h5Ylw/0rQ/dFyBMktmwQRteBflwO0msTM3LOg44RUW6972mg+1YpD9KhCz2
	 FDTIBbnMuMrX4MTu3Qv7T/LUsuAwygpmXJTSnS2raXYjQeCSwfy5Tv1zyAuNvtkTwQ
	 xCtbaVyge9auw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/13] mips: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-9-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-9-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:55:56 +0000
Message-Id: <20260917235556.D0DAC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Syscall numbers from 403 are shared with all architectures, so move the
> toolchain to use the common syscall table and remove duplicated code.
>=20
> To help with that, merge n32 and n64 syscall tables in a single one, taki=
ng
> advantage of the shared numbers.
>=20
> The generated files are not exactly the same as before, but they have no
> functional changes:
>=20
>  - For O32 ABI, the syscall table would have entries like
>  __SYSCALL_WITH_COMPAT(403, sys_clock_gettime, sys_clock_gettime)
>  which is equivalent to the new entry __SYSCALL(403, sys_clock_gettime)
>=20
>  - For N32 ABI, the syscall table would have entries like
>  __SYSCALL(413, compat_sys_pselect6_time64), which is equivalent to
>  __SYSCALL_WITH_COMPAT(413, sys_pselect6, compat_sys_pselect6_time64)
>  given the new __SYSCALL_WITH_COMPAT() definition for N32.
>=20
>  - The above applies for N64 ABI as well.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D9

