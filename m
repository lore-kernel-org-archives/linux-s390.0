Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736284E021D
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009332; cv=none; b=vCnEvFcrtpm948SHqnyxV2M8Sq806CXAQv6+cp0cpkrktp7Ncdn73kPsMwARmvZwf0n6myChmG45jfcLiT1w7E+9od88kOvFhAdDG1M1kuxBHii7/6IV5HuwX8K7XLrGhwZAHg613Zuu3uRB7riLo/2VzeqK6gNYh5JPwglq7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009332; c=relaxed/simple;
	bh=K6GfNf/O7cO37I5wXa5ZFprO8QNrAgV0n4mCTzcNCUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=COZQm7FyneUtzx+hPoY5yB9QiYWMI5cG6BEFSYnNScJpXuwt2nM87kJUPtkhg9FEkW5QHyUA8BKX5kiXAi4IjRrovtZ4KJAez9LiIiqdeyhYW8li71ldwO5edHgU6cASM3FzPWe+UC7gjrnCFvksoLGJq+NIAQFm7vKMP8kWq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfxvNpSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfxvNpSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95551F000FF;
	Mon, 21 Sep 2026 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009331;
	bh=K6GfNf/O7cO37I5wXa5ZFprO8QNrAgV0n4mCTzcNCUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfxvNpStqhLmxAeHuXJspr51xvd065lhX3d5QWlZQKeJqtIn6sIEoLgP0cOYtjF5f
	 fWmCsL+aSLp9aWla0UWdjXA9WnphRVvsStMJhCPo2E+2TkO7aXbA/Wa9dxYbmAZij9
	 dT0IwzzLl7PGxzTxf70Kb1JdwJSVDpyh3T/UuV88a4kf97bl03GMUqjwsaIHbyUAKX
	 T3LzyMWdL7lIhYmHE21YS7/XR02s9jjfmzQmFIsnUDIW0RIoNNSDKE9fXdYQsUj7gr
	 s1K1pzpoNPPk2NbBHtnjKIugmaOE9Ea1tKqG1iut/cNH8xI3ceQf79UnLq4XF3FMfz
	 oG6AGG0F6QAjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/11] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-12-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-12-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:48:50 +0000
Message-Id: <20260921164850.D95551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The percpu code section functionality uses a rather complex method to
> figure out if the register, which contains the address of the current
> cpu's percpu variable, needs to be adjusted.
>=20
> If an interrupt happens within a percpu code section (indicated by a
> lowcore field), the instruction at the interrupted location is
> checked. If it is not a specific AG instruction, the register needs to
> be updated. This mechanism needs to take kprobes into account, and
> enforces a specific instruction ordering.
>=20
> Mark Rutland provided a different solution for arm64 [1] which comes
> without such limitations, but requires to use one more instruction, and
> two more registers. Given that this simplifies percpu_entry() and
> percpu_exit() it seems to be worth to go that route.
>=20
> [ ... ]
> gcc code generation.
>=20
> [1] https://lore.kernel.org/all/20260908151741.394589-1-mark.rutland@arm.=
com/
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D11

