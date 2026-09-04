Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0343ECBDA;
	Fri,  4 Sep 2026 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502400; cv=none; b=GZFqp+WVTDHy/dLBttrN9g0xH9mrjF1Y8VTlZ7XK+Wc02Ooa93Ufj/9SiyZO/ZZOSYCFMo8gY0wqmu0tXC0YL7JftayFRV76KFQkghMl4pS9+B2v7Jmh8voGTyT51kjuLHFFAaS/Bpv7ubuhX5fW63gnRnHe54zVavdwEkdqdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502400; c=relaxed/simple;
	bh=ZGrlrNxcYqoEZjJwMT30HQZ7YdRr76ok4mAOrjhadbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PgOuad7BGJ1sFCyS1KDbUgRULm7igdw9gX/IHZiTgQq41Q4Tk1DF3Nmc3YroniBZpaYqDgzmvIT88dKRDxUmLGCkQryf0zEdnEEjD1TwaTOBKHpDoa8pKUul82dWlgXZnmpQ97E71eU5fJUueJcQOo5ZKrFvut6pAeL7p6/rIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7yLCnKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7yLCnKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184891F00A3D;
	Fri,  4 Sep 2026 06:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502399;
	bh=ZGrlrNxcYqoEZjJwMT30HQZ7YdRr76ok4mAOrjhadbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7yLCnKd7QIE+JhOS6Fsppc0CmJkgLm922ezNnQXVgIPpyUVFNszAJcmFpy25CD28
	 25XS6o99VrVOn6gwhVqBhTKzqBWYW0HTRWCmeY1WONCuCqeiJykpKx8tV5BsatZgFd
	 lmVOm8ihAlavUgak0lHkb93gnsUoNMsZpTaSvl5+ZWkILw2Hg2uFEaZ/Oek6JYWa2k
	 Bj33hwnussRo7k9BD9f3LWP2Ehm+cLf36ovqiyxoLYgO4htBTwyEWgoLjqpP2RjQFG
	 Q6n2+aOtUIyfjYE/VaFoIiOd4GdszTiy6NBZ58MiDI+evlltdJ+QGLbFArQj8+ahH+
	 RWw9utLY6sSSw==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 02/11] KVM: s390: Fix compile warning for
 kvm_s390_update_cmma_dirty()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904060647.562443-3-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:13:18 +0000
Message-Id: <20260904061319.184891F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The parameter "old" should be marked as const, to prevent compile-time
> warnings.
>=20
> Fixes: d487a24041c2 ("KVM: s390: Prepare gmap for a second KVM implementa=
tion")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D2

