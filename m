Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240439;
	b=Bjy3Lx+WRL1AACTd+Pzm3LV5U+8cQObC1BGSTECTzD3ibf8ye4GG7ijY7HKOAMZQjIh6
	 GrTW8s93iqqbsl4E1pj6+vJeLXSZsY+dTjtb5fBB/H558aXWWKvN4+/PXoin/gIaKK4PK
	 mqQW3GGEdcy94epGCOEjU7wWRx5fGICarH4aNG0t5YDZtFbEIuFjUAr4oaH5wyF+8Lstz
	 g0AATX7QhHt3Vsf9DHfyXZrgW5gglUeAb6PJh0+hk59FlMemOKdR+ypMKF8iuh1RQnj6H
	 FuOlUTahy5b0pit3WY2GtMZCkN+xONW1fiJ3zE0TATPtr8I13u54wJRdDf20rdhARaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SVOmDRps/YsTAgWokFT8+GwgNyoAcEKE4T7uVUf2NyM=;
	b=FIOw03vgfCP7ymsCcdzGlrkcTFLQydiq+GGBo6UzpNj/xyl4DN+lkw2a8sbjzvMchUur
	 RmOmTXMdaBrCUKatc2Un6fy1zBwevVtx++QHwRPFiJ5KVfO8LNkwTktS8u4GWZD8nfTdV
	 LXDz/GQTzIP9LiPWE0Oqe4uhIk35S1xFALbyC8bBD7APcfGVGS7u8gpk869N5kheUhP4/
	 KaqcKoa0J1ktal69zaPab1nhIU6xN/FthuX/cRLLfZ0o61Y7hgRz90v+AInDfxsNfhDOm
	 0wm4O1csAl2aBKE6XOjsYY8jdJ3QcQeXcrrdxFA4GH9pApfEjRjLR+ZGIcsCx2SXr+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vetztiii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B06D9606EEBD;
	Mon,  9 Nov 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vetztiii
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F092F1F00939;
	Mon,  9 Nov 2026 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240438;
	bh=SVOmDRps/YsTAgWokFT8+GwgNyoAcEKE4T7uVUf2NyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VetztiiiMA3mKOw5ZuM5unuUv/1gBX+plgcgNeYZM/NiJBeAunJizLFc+ex/OC1KH
	 ruCluqxABnjxL1fV5Ya95nJSrWpg9wumRRwSpEeDXXSJae7a9HVoz8VNwEF34W8Xx9
	 xVoD6jqwS/QJHxjR7wogSJjh8bjwYWb1LoRv2KodV27OA18DzHaRhZXUDViJaS2vZX
	 gQFDK8X1gs4cNZVDot7ZM8xGLhujrNHp1mgz96Ssl6nMTcCLnwOirCLxMpNopcwSfq
	 qpyQMqllln+bxV9PP2IQvLY5etPAzGou1Y0Yc/8gYrEnmHDFp4zl7jqdwbG60u817E
	 kcWFnCFRL/9mQ==
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH 1/2] s390/pkey: Include <linux/device-id/ap.h> for struct ap_device_id
Date: Mon,  9 Nov 2026 17:07:04 +0100
Message-ID: <179424040473.1704532.16041517405742082345.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
References: <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 09:14:40 -0500, Sasha Levin wrote:
> pkey_cca.c and pkey_ep11.c got struct ap_device_id from
> <linux/mod_devicetable.h> by way of <linux/cpufeature.h>. Commit
> cdfdbc11552b ("Move struct cpu_feature to <linux/cpufeature.h>") dropped
> that include, so s390 defconfig no longer builds:
> 
>   drivers/s390/crypto/pkey_cca.c:22:28: error: array type has incomplete element type 'struct ap_device_id'
>   drivers/s390/crypto/pkey_ep11.c:23:28: error: array type has incomplete element type 'struct ap_device_id'
> 
> [...]

Applied to kbuild/linux.git (kbuild-next-unstable), thanks!

[1/2] s390/pkey: Include <linux/device-id/ap.h> for struct ap_device_id
      https://git.kernel.org/kbuild/c/b48d1c04

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped,
reverted or modified (e.g. trailers).

Patches applied to the kbuild-next-unstable branch are accepted pending
wider testing in linux-next and any post-commit review; they will
generally be moved to the kbuild-next branch in about a week if no
issues are found.

Best regards,
-- 
Nicolas

