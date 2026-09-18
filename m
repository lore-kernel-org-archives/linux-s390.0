Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBC3AAF4F
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721700; cv=none; b=VPdsEuWTjyEBolnu3KpOMKt/h44Djsqx3dnk+599U2aJFicUHK3LDRRvdmiEUXco0PuYvUNnYnrM519Tcr8QES2zZQvGEZoV+dXwTBuOEWaNC6mz7ydCjWpHEl9vAcC/e534xfrwy+ake4//xotPc2UPPiR9ie3jy0+2yR20rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721700; c=relaxed/simple;
	bh=P6AaVQ4PBR1dQ3m/l4Bi7GN1vNriyqWJ8d5xoaxrngo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fUEKptPMr0VxaSJbDaZs2B24fK8uWoMO9FslUmcIoww5PpiDS4NmxO1wzRSmWBSaUhaQwHE4wEf5K85UViqpBnYixgic0ilt9xMYNHJ1J/KcOv0xkHnQwK5uG/6EAuGZrztTMKEctBu+id04C9h9nwKx0igwb22p8XvbyzSDBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2RlICHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2RlICHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4FC1F000FF;
	Fri, 18 Sep 2026 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721699;
	bh=P6AaVQ4PBR1dQ3m/l4Bi7GN1vNriyqWJ8d5xoaxrngo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U2RlICHUsOoTgvX6MzKg8ZIim5TqUXrkS1QIGbyNEE4PnjyRNwvn37cEpWVxKz59O
	 B2UuxvgleEPQzoVxDqIOKCsdFsehO5vKfOC1FT8Y8u+BJSg97qm3hOmcR3xSQd9f21
	 FCV/2i3mRWlee9Ns63Db5RgaJdAwayfdBGfHig6qCv7SOq+wLRd3YB71KOjDUn5nbO
	 UcQ3NK1YqeXh6KGDEmcT5n7U1olfpdkfSdTBzSjDYlwKWs4b6Z0UFgzlKgMI7oF0U9
	 GbzPUt0W2Wj+kpO4cPnAl8IUqIuLVU9cI5CCm/nf2dTW2hW5y+sti6GllcLbQS9pgt
	 QxHMMeY55XLrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] s390/percpu: Use __PCPU_BEGIN() and
 __PCPU_END() for inline assemblies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918084842.2333237-8-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:54:58 +0000
Message-Id: <20260918085459.2B4FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace the use of MVIY_PERCPU(), AG_ALT(), and MVIY_ALT() within all
> percpu inline assemblies with __PCPU_BEGIN() and __PCPU_END(), since
> the begin and end of each inline assembly is the same.
>=20
> Also use consistent names: e.g. __PCPU_MVIY() and __PCPU_AG() instead of
> the previous MVIY_PERCPU() and AG_ALT().
>=20
> Furthermore extract DEFINE_GR_NUM and UNDEF_GR_NUM which are used to
> convert register strings to register numbers.
>=20
> All of this should make the code more readable. No functional change.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D7

