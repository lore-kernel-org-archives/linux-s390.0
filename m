Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FB3A7F41
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030853; cv=none; b=MQhhDf7BvjwgJKtmpAsdJ72FyQhPZXFPT1GoqiNqiDVTvVf/obhSsElBnHgsKINHGtp5243vQSU4IKYIWerl3Z1o01k7vdOOu5Hg8wtKfCBgDK40SXscOy+1vW1X8mWxEslu/cwTYHXSGhkohHEndzRmkd4Y79rNVRjdN55yhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030853; c=relaxed/simple;
	bh=eRRNqa+5rMlbOVRWPhqvnLdrriOoloTNa9mg7Vy24nQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aQ3GpPsdbFANYVvL7VAAKNi79e9+6GNsAlaMcjEIjXhz9ZyAzdT4RLeAOCth+7mJIkkTZf4abT0m8IKhNrYtf7FBocrWsac4gtch23+I5sgnE7acoCi6WLl6Lzn9avVOMoWO/nTxRdeUykPCuINbwNy2U0Hk+BTqvteECz6GP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqhGp1Ox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqhGp1Ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F911F000E9;
	Thu,  6 Aug 2026 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030852;
	bh=eRRNqa+5rMlbOVRWPhqvnLdrriOoloTNa9mg7Vy24nQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqhGp1OxtKRzyEM/tAa13t6GZmBx5vEa4tMEflQShnbvBK1ntqxi6RJxVSYDB5DlF
	 +xcYMniwwiaCAYoDCasvKNETepr3Tj8iExv+W5rh64UeWK/wE6KZ7g05D2GGeV8KSW
	 jk1pRgpSOvpejXKJKztM8anGWq7mTrQlmlfE1N/xhj/qN411VFS18GRWQ6CfsS4Axi
	 jhmbbochUyDuzlqyFaPRSBU4UP9Ev5IuYpBJA0NoDM1/j2MjKwE7pGfLqDoRcKJ69h
	 v9gQBslUsFCO+o2aW9W1qrL7fx3WjAxjqUJa5pgAWcRzLEB0rZXu7OXDIu5gHm2Un7
	 BIQzTaDaAeggg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/virtio: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260806153849.2622576-4-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:40:51 +0000
Message-Id: <20260806154051.B5F911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All virtio code passes clang's compile time context analysis.
> Therefore enable CONTEXT_ANALYSIS.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806153849.2622=
576-1-hca@linux.ibm.com?part=3D3

