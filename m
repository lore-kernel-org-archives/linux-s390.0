Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429871;
	b=lbxCEObe2kd5o2Fp11BDlLkYtVC/hIAemXJWhr2ZCotHkbZUq7yOzl+96WvaV2eKMxCw
	 l4J60eJGoo2Q9H4HeyTo6J9fQvOmB8cXkeI03e7TO3HK/5v527t6f1pKXFRMRtFozWlGu
	 isaPW5Zh2BKbA9g9WeNXa9nJDtEErrPOqEHqreJqNNwXtIcQccwr4iJmukHLq7qUrWzzB
	 +lC+k7F6EQsHMrUUk0yWSVeo3zpRnije6kH0+Pg6vwqCvO/gyPMeujPPD32Q4cqldyT88
	 5TUPw3NmCcFXzEAR9Rx1JQulkG9k0KJuoYJNbk+9Lh7cAW8PTjzHfTkqJu2iJehDtpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429871;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hY7CfGO5TiisChy5f2H/mfWwYucZEr8na0zEEuuLprY=;
	b=Cz0k8UWHlpXCSlAUyu7KhzkB2H2iDUP7ddC/YOEMrh/ujvbtvHwyzYUYkv82kHU7brEU
	 jVNiu+uppLQ6vloaQHXhxNWssbYmDsrfTC7Ds1nWzCHNBiEPSQZrQ/7O4A0x9HjVsGd/i
	 kbA9qfc+Zc5JQkoxUBKa+jPp/WkXI2aedaVHsQxeWFlvWToy9Q1Js3nzmf28pu1mh0nJd
	 QJWVQQGE8eAVW4XFgrO+IchbIzpyoJflnjZEYoC4KrhaJ6zRsM4ycQlPGPIpaIpAysW4n
	 xNPBnEpi8GgTuIhN0R1DGVoOOR5HK6wANeEND5KzAcMUMTu3kL1DXefILToWYa45L3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVGojYuZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D9606A31A
	for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVGojYuZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075401F000C0;
	Mon, 23 Nov 2026 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795429871;
	bh=hY7CfGO5TiisChy5f2H/mfWwYucZEr8na0zEEuuLprY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dVGojYuZeGXIUSpth6MQCEBzqOoKpdT0M+BQMrsPCWKbWBi+o5r12MXPLlcfZx63P
	 3ZwfyQs9vaoXS4Lcpj/NXaiFGoQ9x6I5AUVQiLG8CIW3QorMFdFXML3hG9/7Mm/Jiy
	 P+ZSn93VXCyPCgU3Dek9f/XkUjJ58U5s8VI6uxrsTd3sPTcZRkBhuqOzOFKfozwjOE
	 Qakc7iL6h5yqnJCe5HieAI0OROzukFt+A71IZikDiNB+SOEsWuW5/l2EDvLuwQ567s
	 fsewo9DSCeqBng2mDVd+B7W470OlpsoOmaKspiIt90ObFq9/03GIPYir75NOxa/6FO
	 RuWK/omMbcR7w==
Message-ID: <sashiko-outbox-229045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] s390/cert_store: Restrict link creation and key
 type creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261123102324.483917-1-hca@linux.ibm.com>
References: <20261123102324.483917-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:31:10 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123102324.4839=
17-1-hca@linux.ibm.com
