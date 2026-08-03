Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625D2E1722
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751968; cv=none; b=tjrTGpwzlf2Ez3jl7onP1ywcgRyXuy5SvMfhZINX3+3/3Yi8HKnsvGUpJ9f1qtW67IDVJ4wRYu1A3dWk9e7xBX6kvQTe3oo5rA5FHSZCnMudYqdKmdoiRng4/MqNgpvRiLh3C55lUAQrF8qYuAoFDEoA8jzOwacaSIO5hEtRYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751968; c=relaxed/simple;
	bh=xM7L3loTdRaYVmsPhasZFp8wErSlv3AIW81ftqkLEoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rq3i0VYsJEcbEUVkmRlMKimh4j4cJDGjPcR4YIGnkPgKJrPgEhTfEjrskWLUuueWU72NoCK7B+EZh34CP/AUlSj99MxtOr1nWoS3fBuwOdQKKkOEWRRUrLNJ2oiH3hidgHU1zV8Fmj9dFhEiltZiKAgoKrUSl1NYZh6M66paLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKzTuqeO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKzTuqeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E351F000E9;
	Mon,  3 Aug 2026 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785751966;
	bh=wubPYIg7m/4zrxif9nCOnWU/mCojSRjWarCt4bP2YBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TKzTuqeOGyG7vEUx4plxo06OGAEoIQ9lfJpwUmfUDB2VSEx8iQ/Ych5JlALFdxLHG
	 fBq5EwcVrJiLS9GhxzF3Bo7day1bzucWzDqD8b5CRiHP2wr5Vd837G7/x6VZNhNoGu
	 iuXCc6PpYjLaFK2YB21VaGlm/5lyh2DHlHtxpNd1c57YXjwv0KiJCVNwg7kqDfWkhA
	 JP5sxta3JNi1jt7FE3n5sxvrRaQta1xKi1rc023Yu1evvktuHD282ODpx7V7duWb/e
	 FGcDo2kemutqbA+/zIObpa/5YtJvaEU1ALfKoX9cMJW0DPM739zGsuUwC2r/GgVBrq
	 UWOmUNv9Cv92A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/pci: Rework __zpci_event_error() to remove
 conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803100723.2343688-2-hca@linux.ibm.com>
References: <20260803100723.2343688-1-hca@linux.ibm.com>
 <20260803100723.2343688-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:12:45 +0000
Message-Id: <20260803101246.54E351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Clang's compiler based static context analysis does not work with
> locks that are conditionally taken like in __zpci_event_error():
>=20
> arch/s390/pci/pci_event.c:320:2: warning: mutex 'get_zdev_by_fid(ccdf->fi=
d).state_lock'
>  is not held on every path through here [-Wthread-safety-analysis]
>=20
> Given that code which takes locks conditionally can be considered
> suboptimal rework __zpci_event_error() to get rid of this.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803100723.2343=
688-1-hca@linux.ibm.com?part=3D1

