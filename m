Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0C45518D
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945226; cv=none; b=JajYBUgdBTgLpXT3jeL/mb6CugosclEV36GTPJgE64opZD4CELzerSyWgCqdL+Dj+QuQw8Vi0HMYRa8QDzwnwPiLYDywFi0NOjrTmc7aoFZ3Ue80+k069PVvCjowNj8Ig/qfDl/yBUonDO443fimpMSo4P1vNJRpcLStdpEG7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945226; c=relaxed/simple;
	bh=OgDgHubAwsB/AOPaPSFNh+EsFC7sSIX5Ap6wBhFgAf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L6gcCYuZylaD2MVmIgxGg0jjFSvSwTzPKPxmDmFXsquRJbLRLfnX0J7h+x6zkUu4hdRzQh2+2cAi4SEzW7CoJk4AldU3NBMGPXXtKpgpnUE0jq0Kzhx/ljQBHg2PS0jrxR6mmfqR4zRcYFiWtUO4gbhknYPVtaSa2aFvIAKsvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5EA/X/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5EA/X/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889E21F00A3D;
	Wed,  9 Sep 2026 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945223;
	bh=OgDgHubAwsB/AOPaPSFNh+EsFC7sSIX5Ap6wBhFgAf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5EA/X/rQVPwE3mZuFXy2rf5FuZ6IPRwEdZ7PIA/Iviete7vI9vOnhIxPWffBrucj
	 SOGb7k52QCSvCAwcEhz4xRzKEltLzxbisihpGnwv+2SDOf/OGrBMJPXSoggrQs/A3R
	 J9uSXHGIA7iF+80FoJX8wzQ/ixKP+0NcEwUS4jhQHSQvaosbF/Pyp5PIG4Vx4ljeoN
	 nafx11xDDd6mMLF3aw7Gc5FCHCHMn8A8PL06Gj1GOuj1VKUxIh7Tnmx8S2jPp15f62
	 BP7nbeYnpARcP1a9tQdSEIwzQIsSRQKsuNxEoha4r2aAKouj7Ddsd0UM7O9/SStKKS
	 085JeC1O6DjiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] vdso/vsyscall: Define fallback time
 synchronization functions in vsyscall.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-4-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-4-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:13:43 +0000
Message-Id: <20260909091343.889E21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __arch_update_vdso_clock() and __arch_sync_vdso_time_data() are only
> used in vsyscall.c. vsyscall.h has become a dumping ground for different
> kinds of fallbacks.
>=20
> Move the fallback function definitions into vsyscall.c.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D4

