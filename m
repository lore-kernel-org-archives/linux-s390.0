Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58A423E91
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692911; cv=none; b=sRCtrOcFp7ipbwZNO88CFOLy/7jr9VHNYdpLrTo7LOgklJef/5Y4NGpeemQCGFwUBzCiSTxwqGw4/zZFsXFxVyXu66p7sFsK8N6qtEeoBQqMDa2f+iEuCnL/HmgrLUmE0iJfZ3N6Jnob4o43Mw1GuIblSnywty9+cJ7cYgvIVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692911; c=relaxed/simple;
	bh=tsjGuuXCglYQgsuVI3xbgvGshlYHNikGG2aYzee2B/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJDS13ewDODFhOOfs+GC0Zn3vqW49AzxYuzo2ohYU+9rwo+icA/L3sovKf+BzaXld4YxV7x5rZqD8LXmeJODVGIRe7qgKaUfjNJJNMpo5T2g+Zv7WZzVpfmqJlY3ZHh8wy1OcyE1N6xwlFEN0WXEQ4usF8rDVUiTueDnajIO1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/dSm/4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/dSm/4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908631F000E9;
	Fri, 14 Aug 2026 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692890;
	bh=HK/rWVRr6ig2uUvwAZnUeCs6gvVJ21G9Ph05uCHzOZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/dSm/4qIB0aywx1yrWkmqRYwbqLjjLed2LJ7ul5aTH8mbJ3Ux2z6hWfm/ejpsiKy
	 OqV34foi8NLOJUJPzYoKGGQrqc6QVc46x0wnYyTcUNVJohOIhGM3lzft6CCuCOk+tm
	 6RVfcH6Z1VzT/wVdjgPe/6G3G0kkMZ5B3wkPqLXQ/krBuoXPndKTj8SRayvYDFDUwR
	 QAjuWfD4fTY2lJ75Yv1ezuHUD6sd0TQfZgMEf5RCtmTAhdo6oOFJ/wG6OUZAm9FjqM
	 6Fod0zqGUe/KbC7X3vafbo//UVQfPPLxiOl+00PXjULsomUvW8QrppIMC4DGcOsVl1
	 Yww3LHYO0FxuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/stp: Drop CLOCK_SYNC_STP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sven Schnelle" <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260814072223.2218864-1-svens@linux.ibm.com>
References: <20260814072223.2218864-1-svens@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:34:50 +0000
Message-Id: <20260814073450.908631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Booting on systems with XRC-capable DASDs but no active STP networ=
k will hang indefinitely due to an unhandled -EAGAIN loop.
- [Low] Lockless plain read/write of `stp_online` introduces a formal data =
race.
--

--- Patch [1]: [PATCH] s390/stp: Drop CLOCK_SYNC_STP ---
commit 39bb08d28d4e120a87017a08eb301d774dd6baa2
Author: Sven Schnelle <svens@linux.ibm.com>

s390/stp: Drop CLOCK_SYNC_STP

This commit removes the CLOCK_SYNC_STP flag in favor of using the stp_online
boolean directly. This change prevents get_phys_clock() from returning -EAC=
CES
when the kernel command line option stp=3D1 is used or STP is enabled by de=
fault.

> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
> index 2b989bebd220a..de80e2a316ba7 100644
> --- a/arch/s390/kernel/time.c
> +++ b/arch/s390/kernel/time.c
[ ... ]
> @@ -299,7 +299,7 @@ int get_phys_clock(unsigned long *clock)
>  		return 0;
>  	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
>  		return -EOPNOTSUPP;
> -	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
> +	if (!stp_online)

[Severity: Low]
Does this introduce a formal data race under the LKMM?

get_phys_clock() now performs a lockless plain read of stp_online.
Meanwhile, online_store() modifies it concurrently via a plain write:

arch/s390/kernel/time.c:online_store() {
    ...
    mutex_lock(&stp_mutex);
    stp_online =3D value;
    ...
}

Could this trigger KCSAN warnings when userspace toggles the sysfs
online attribute while get_phys_clock() is executing?

>  		return -EACCES;
>  	return -EAGAIN;
>  }

[Severity: High]
Could this change cause a boot hang on systems with XRC-capable DASDs
but no active STP network?

Because stp_online is initialized to true, if the machine supports the
STP facility but is not connected to a usable STP time source, time
synchronization won't occur and stp_online will remain true.

With stp_online remaining true, get_phys_clock() will continuously fall
through and return -EAGAIN, rather than safely returning -EACCES as it
did prior to this patch.

The DASD driver ignores -EACCES but propagates -EAGAIN:

drivers/s390/block/dasd_eckd.c:set_timestamp() {
    ...
	if ((rc && !private->rdc_data.facilities.XRC_supported) ||
	    rc =3D=3D -EOPNOTSUPP || rc =3D=3D -EACCES)
		return 0;
    ...
}

If -EAGAIN is propagated up, will the block layer endlessly retry the I/O,
resulting in a complete hang during boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814072223.2218=
864-1-svens@linux.ibm.com?part=3D1
