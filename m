Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298BC47252E
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306919; cv=none; b=NiSLLBmrCJDtfPoMQKZrzUqxIrs8MKuYugoYAJe5ckRYyTjO4noXP0dJvbAMNYfyAv96sqvFJu86AmBlG+j/61Ik25EpNRoZKKIaMKY+Ts7G3a1yDdW+ecrh6ClRnUce4Wzfo5U0glw04TwjSz/quZARAYXGJkF13FNq1PRdujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306919; c=relaxed/simple;
	bh=SOrd7ZwJclofGLN9XBVr95loToWCiyr58gEEQQazmjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qo5oX3PreKJgFkZmVfu4mZOyyDdW8hAwhsOtfhTJxTVtsRPl9eGw1cEUbucU+24BKZVlzWFVsdk4zO8j+5tHeYHenud8tn6FcuJZGPQ9KMh0BI/IMW46VMtd6NQejtrIRXa6ftgxjhmRIl1CyaiAJHAZWpd50nqZE1pgvtkdTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWxAAKCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWxAAKCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816B91F000E9;
	Fri, 21 Aug 2026 10:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306906;
	bh=SOrd7ZwJclofGLN9XBVr95loToWCiyr58gEEQQazmjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWxAAKCMWrztWqvs1Pu895CyDALlEVpIUb+qjUZlKKGjfLjSK8NBBJd6b1Q/xvXKe
	 o6FGla2yCPKwCQZwb7L23fDLH8ul9M2Memvnf1jYXJ5UFA2QWyU1XX/RCRkSCqgmDH
	 VIgaxwha0xCP0XwQLW5CtPaoI1jYCS72Mfrj4HDQqp1Jp4iD1Na9jDinrY1TA2fp38
	 hFLTbCHqDfi8y6X+uj+t9vVhnrZHg1J04SQAI+wTQbtBPyedj3uI1jX6ai/QEthmKQ
	 10BsM6GsicUuEoxkSxQmnwiBEvovTPH7qOlRSTy/JqtACIDVQvAx9OmYP6f5vboUPS
	 vTTeQse8lAIYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] s390/crypto: Fix handling of EBUSY in PAES when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821084648.23222-6-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:08:26 +0000
Message-Id: <20260821100826.816B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a request is transferred to the engine via
> crypto_transfer_skcipher_request_to_engine() there are two return
> codes signaling a successful transfer: EINPROGRESS and EBUSY. However
> the correct handling of EBUSY was missing and has been added as a
> return code indicating a successful transfer to the crypto engine.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D5

