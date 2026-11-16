Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827986;
	b=xfkVaafu+TSim2dkAwxe26MpLhUXqglDC/Qw5mBFnokyOvkCTKEuLTw/pJXXO1LMTg1X
	 FzWHNtnjdf0anTxZQns1+Djp2AEO6ckU+jo7Vz6Hdg73F+NHb69dqbPz4DqU2rQslwdCu
	 behOzYp1D5iRykuOBHMj8sZ1B6yO0bw6WGyMNlxyXMbcjF7ShQBDuv0nyzzzD8lZ9CS5f
	 HtTdjP3szwqZtHY/fyMJnkqwoKgP2DeoE6xcM9UiXGc+GQcyqz8EAbzSx+BpFOoVNIoIz
	 LduGd7wsAAa5fN6KZf8EflreknHJTErr+iPqTL5yQHU7g6niHwIr1HwWNazzlmUiWVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OEX+H+PiAM/RWMNBEDNZmM4jT0oM0vcoclqgOZAzsfE=;
	b=a1o57TYlGgSgwqNTGLjQHx6jwWSt6wrRNSitgS0QLvTycsDGWrMkctmGAj84HjT3SPPc
	 5Q3MtOJQ+E+vST69YaiX9j9ux/BsnVxedmWgGMlMpBdJXDX2DmwQLHOfqgrLZ3GZUYp1V
	 CMj9fbT4wODi3SfgmxdwkeJl6MvcPwXWgTU5CtJbcYHeeux+fWRRag6pcYpBibrWXTSrd
	 15qCLC6DLMr9rlxcRRxvxz5ntA3PbftPz+1TodIMhOf0DGPfMuZqZfPsdMPUIy9VnhrAR
	 F7oeoWv9DA6B0ZIIZTRB/jBfmL50+Gu/tWKdNggvk083jQdLSMH+v7CvbEpnnAkEWEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDTvH6iK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726E606A783;
	Mon, 16 Nov 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDTvH6iK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28C41F000C8;
	Mon, 16 Nov 2026 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827986;
	bh=OEX+H+PiAM/RWMNBEDNZmM4jT0oM0vcoclqgOZAzsfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDTvH6iKAAnQnV1LCYPRy9cbKsu014y41xRJ7nOhekJQ14wazju5ixRsXQi+SyZhe
	 6ULl0j4bB+dvBYBjZhBVn0NFQEj1nRKRZR4m5UqsjgFR/HPEb1RcOejvtecyHjzRqW
	 thD+fNTp1GYcve5VD3nsKwgPmLAuQhCSQ75RGZG1DfK4AfQNsAH17JhrX8nHUV1Mx/
	 qREFrrXQj8jd79SGQsV6LD4OuFgt6X38WN+SDrFn2G+ZsjBo97v5CWmSf6AjIBJ8FX
	 J4QkmxONYbdTGhSEaBpvZ7NNUHaA3JuIQ70qPWP2hRMV5Uha4ie9yBNygTNXN/zfd5
	 fsyhRiLMD2Xkg==
Message-ID: <sashiko-outbox-216888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 25/44] pstore: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-25-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-25-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:19:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
> device nodes.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D25

