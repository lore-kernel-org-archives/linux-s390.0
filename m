Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933D47DF95
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628871; cv=none; b=MVBI/StEejl2d6QR0Ku44qCcXkSzuZkXtEQHntpEuR4dyJeRXu7O6Z+GmiQ0TLOTsvzmdTj9ys0Mn9PNx8btkOvE/Lgx2xw7FntlCNGdUP8LVDIwlM9nCmZiB+d+Mx9GD6h2Uts1jtH77OOvJ4m7Mmy6uXtGSlUHTUmJhEzXAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628871; c=relaxed/simple;
	bh=ARU0IlBtAWYvMN8dupbtHXZR/hdxI7uhv2UWDjDPDkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OsIjSseTzbiY4JdYGQzX0Uof1QfxLOflClHR/muu+kQCtr6ez/Y57fstoxP8C40NOT46TgL1EaQTowUJDzEO2z6FkXpzWDYCOsyE7H7WdxkK+lU2JSOb1G18Sd8V+3Kl39UH1P/ile6iDyMIdWbrk4j+TYdctMlgIVNsvy5fOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDDZpXm3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDDZpXm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF931F000FF;
	Thu, 17 Sep 2026 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789628870;
	bh=ARU0IlBtAWYvMN8dupbtHXZR/hdxI7uhv2UWDjDPDkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDDZpXm3/kUJtkVq86rU6+Q9sLygN+uwwMSc5OLPkiWvEgmsZgLgM8ADsQQ73Sa6X
	 unwtVs/ziASP/+6IQ985nd0rPfOrrwzl3blEx00eEy0CRcljrWdzuVG786HZkyz3/K
	 t3qCOj8oe5ErfqJa+NYyWmjAWsIOBBgCTJJqNhQNBCQl80jQMCkVMpRpzJmS1G/Cau
	 KvdBXq0QjpnQHgADdQFUoxs+Z5kxON3i5r1Tc0KzKhkXxtpR3xILmrbPSHsyRS+vwb
	 7/NHLKniGNaBpDAI3q+PoLfL9z6yz1kVnqxodHmjJrThQouz5eQtFF9PCVX0nqBysL
	 KRr4shVG6lTXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] s390/sclp: Ensure no callback gets called after
 sclp_unregister() returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917065824.2858737-5-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-5-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:07:49 +0000
Message-Id: <20260917070749.CCF931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is a potential race condition between sclp_unregister()
> and sclp_dispatch_evbufs()/sclp_dispatch_state_change(). As a result,
> it is not guaranteed that the callbacks registered with sclp_register()
> will not get called one more time (and no more than one) after
> sclp_unregister() returns.
>=20
> The basic idea is to use a single global wait queue which is woken up
> when no SCLP WRITE_EVENT_MASK and no SCLP READ_EVENT_DATA request is
> outstanding. If both are true then it is guaranteed that no sclp_register
> callback could be in-flight. Once the struct sclp_register given to
> sclp_unregister() is removed from the list sclp_reg_list, no further
> callbacks can be scheduled for the given struct sclp_register and it only
> remains to wait until the SCLP driver becomes idle.
>=20
> With this change sclp_unregister() may no longer be invoked from atomic
> context or registered callbacks. But this represents no problem because
> this is no regular use case and no driver using sclp_unregister() requires
> this at the moment and likely should not require it in the future.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917065824.2858=
737-1-egorenar@linux.ibm.com?part=3D4

