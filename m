Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017448;
	b=GRoh9n0eVin7sjCENbt10gSaf3+39trQWaIgvWQfeCAYiGy7UYICMQ2zX3WJv7v8sCkv
	 oNrnP8q+Fk5pPlC/pRdJU/Kx66Gez/Hmm487zyba8h18Z/mSwQHz9VXAuWooZNi4EY9/y
	 Ah9r7d2G2oyuGyFbWwpRyP667KXUTNoXUEQWF9pe0EL+VIF9/feUcy8KpP9C5AIPXH9AK
	 cpd3qfzUMIzdI7Y5XMvGwvxMlwHfS+JFl1UQD5dIdFOAGg3Kru6CZpC4pzP1xboKylhX8
	 AOUAJKEJjy2x52ZphNaBZeZGh9e2CDOugy6H5jYuVZJP2JQ/QE+Az4SxKTs5UhjVdJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0zDJHSIUPMFXhVT6PgUbRLXsLSmvvh65IHXIJ0iQcXM=;
	b=4N6X5tn7icCiXv0GRDPdTcGH+74/l5WLVRoG+zVs9flTGnuaNz43cUyyiIGdp032ONim
	 BTFap47flinh8+Y4MsoC5g1Z9suCaPLybeg7H+zmPZVIpegIb+w53IAIzc8+QZTt4f5Ur
	 r73vMsg6QohEMbnsHKPsAiY+bVXxag4gdbwHjiLw89V57HkYaZq1US5R27uu9Vs/0wL0Q
	 PnbnVDaFtXt76IGlvdB+bnp+I9OY41f9dJDXk74qyxMW9weA4o6dQjZeLEI8XjU0rGKnL
	 B0x3TUysbhlj78DfA16MNwZ0zLvgvad99N+JYg3EBXMJowTllvpbvFxPs4LrPlQfhnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4bdLiFT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A7606A31A
	for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2026 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4bdLiFT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661BB1F01825;
	Mon, 26 Oct 2026 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017447;
	bh=0zDJHSIUPMFXhVT6PgUbRLXsLSmvvh65IHXIJ0iQcXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4bdLiFT8yy3/9SbLifjOtYGgCUEJqECJXBCPuRFhjvsaoUl5ejaDvUdIe7e62XJC
	 DL7pBSlyPjP4y3DZ6m9m/glNOY4GYba7p9XR0+SH67ZJiPIjiDVQN43v3O2nGOcNDr
	 fpRtB5WKz6w8BuTjObmhhOqg24E3grkYH6daV5ewr0KaiD2Dgzy3lrOrA7pBtX5WDi
	 y5hk0bAmJ0WBP6qrNH+oObMfX7ie8abi3SyfES1dZq9Dg5LZzq8YtpAEcwxOM1Hg1W
	 P5oUG1fRyWUhuofkchyq0mLnVwZ92r4nllA8aKWnWUdl7ESCHybzemibObc8EOHDwf
	 hEaW2Nz/h9xnA==
Message-ID: <sashiko-outbox-185203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] s390/ftrace: Serialize text patching with
 text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261026120329.1792436-3-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
 <20261026120329.1792436-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:24:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add ftrace_arch_code_modify_prepare() and extend
> ftrace_arch_code_modify_post_process() to acquire and release text_mutex
> around the ftrace code modification pass. This way s390 uses text_mutex
> like e.g. x86 and riscv.
>=20
> This is a prereq for removing the spinlock in __s390_kernel_write().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026120329.1792=
436-1-hca@linux.ibm.com?part=3D2

