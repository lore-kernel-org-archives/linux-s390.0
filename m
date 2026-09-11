Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D52F5337;
	Fri, 11 Sep 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138014; cv=none; b=SlmeXgI4Bw6Cplx5zuMMbev9UfxduMFA34l4AkIo6EQUnB/3E6vSIszZA6m6paErohHbSMJc8cPsmkbH7B1jichJsI6IIwvwbq+0EPFI9IBh8UqjkfouNTbhylI9Qn4Lud2W/cUCxaPl480h3+LOXB+wciv3BOhzbamW89f4Xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138014; c=relaxed/simple;
	bh=sHBBGPzOUnRxe2PVsLk4dMO41kAAEptR3OPp0QXVqjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPFHDYA5owrsQR7QkOkm0Lnk/LRjM5OPzVOLpToqy1/AK/Gte88ydrBsfS0qWalNsNl347g8HhNV+QIIfOBZ78iERPGpjxOZ2QHywKYG/iMC8AYRC/7JNENUXzsNDSIlXxaKzd9aD+562f5N3JBiErKpfZqpdJev69U+JYPgITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR0KvBBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR0KvBBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547121F000FF;
	Fri, 11 Sep 2026 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138012;
	bh=sHBBGPzOUnRxe2PVsLk4dMO41kAAEptR3OPp0QXVqjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eR0KvBBmIgdB3yBek+OwvpaNyUPDs4zpqHVWi0nULlbLeqSIzf/RiAd9khR3LYKkF
	 KCyF0t3HeooLc7hwJ36ska6g1RrXid4aqP1IvQkjzUZA4GbLzBmQg/FHd1k2+VKKtF
	 7AdfQNohvzBuqCsX4T3HGJMhIEfF14YNM3JPbgewBzs846kFi+6qVOH52Pdq0M8JE3
	 0jpygz2X0sxHcbqMm684FZGVx7N+3U6siV6Rjw4s9fffelKk50yBxWZTThO8h1tEWA
	 IpB7/v3hc1Jww8aW6e1eHV4Hpcwgu576XUP1wV/hFnTy1wS91Zy1u6uMUD2R2rh04w
	 hd93KCV7gA+Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] cpufeature: Include asm/elf.h for ELF_PLATFORM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260911-module-include-elf-v2-5-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
 <20260911-module-include-elf-v2-5-954c732975fb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:46:51 +0000
Message-Id: <20260911144652.547121F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> linux/cpufeature.h uses ELF_PLATFORM, which is defined in asm/elf.h. It
> currently relies on that header being included indirectly through other
> files, specifically, drivers/base/cpu.c gets it via linux/module.h ->
> linux/elf.h.
>=20
> Add the missing include in preparation for removing the linux/elf.h inclu=
de
> from linux/module.h.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608151415.UAbFbpvE-lkp@i=
ntel.com/
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-elf-v2-0-954c732975fb@suse.com?part=3D5

