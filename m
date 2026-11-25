Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600984;
	b=fio5iOE2gq12GOSIFUDQEdqwxT90kK2A02E9GZAlpjAwyXgOk1AlAos8i3NJbqCNnjLu
	 mU/7gvrFD273vmh0fs/rrDTOBkqoTkSKJLLQbz8LEa3+ulj4uS5ibaHXWbyNyBbTOiOTn
	 lyZ0U0iJgu67ORiNLQnmYmG0c2KcWWt5VsORKiHRJ++cw/WHY27aHp7h2+Ceu9u4rMO+X
	 LgFHVLYtKvGtuNAxuKYjIEE2oSrgdbWhC7c3Uw5Wp3bgdcN+QChPrloXMD6cYIZhu3vEi
	 RbaeI0he2kUyId4Yq6rqzelEkdXbqB4UaUGgbF+ze/p6x+ZJxkjCikcfhOJrCGtKvCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600984;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qEPIxvGniF/YhXwPA5SSWIjPSSOSPgJQxE6JPjadhkc=;
	b=15725jIJgGNw7penEM57gzGue3NMTognQuW4G/+MCqX2Af/YVJNf6pMt6YSdZvJNPiIT
	 rc1x/Ai2BNacLsHjiYBRtbGiXyHbakIz/v56ADISm90AQcZ3P369cmp+Y/ICORThaX26b
	 6TS8d5kD3LPe+V67/x8iy7sL+l+KHHSzx2RXHIFeruh2czK0ZvIAYjH0pVeUxYbbdoiHv
	 pfAMR/AY2Cu3nqgn4M6gyouYrUA9s8F+xRdZznd9BmK51Y0h72/IJzepAJK26nW2etbnP
	 sRFdRyN0nbNkohYpQATZi9Tac1lZM3Yy38gc6fGcQlAHDE5XEfy3CR8kQoC+EDEcTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogVPeFFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2F80A606A31E;
	Wed, 25 Nov 2026 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogVPeFFd
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3AF5E1F000C4;
	Wed, 25 Nov 2026 10:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600983;
	bh=qEPIxvGniF/YhXwPA5SSWIjPSSOSPgJQxE6JPjadhkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogVPeFFdbHD/v3IA3n2ctcWEn1t+zZ8PaFug04K7Y/geumcSZ3pFGJzH2uHhKBoUJ
	 k+2h9EfsyXSVTHP1l1awa3eMEAkCzVmmW3Jb4hTRz9CSXadmFvgjQvsgjmiaSxQn0e
	 087Htz6rk5oJXpnx689Xd8qB7zf+hoeYW8psuUV70R8n1gRiQdeN337lkmfaqYEiHf
	 2yrzsEOLKdDban0JBOybghKhD0JiLnCgLdsBxEaMpqw3LX6els8Md6Hkd6vE6Lfdqx
	 oA5LsOK1zTdXDL2cyaVpEacAZgdF9BcGDoTmps0wtw5LkVsV+Ykgiz3KCZSpzgpPQI
	 PyWT3f1Yw0r0w==
From: Nicolas Schier <nsc@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
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
	"kernelci.org bot" <bot@kernelci.org>,
	Nicolas Schier <n.schier@fritz.com>
Subject: Re: [PATCH] Move struct cpu_feature to a <linux/device-id/cpu_feature.h>
Date: Wed, 25 Nov 2026 11:02:55 +0100
Message-ID: <179560086128.3880976.17009453982842504625.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120202712.3377691-1-nsc@kernel.org>
References: <20261120202712.3377691-1-nsc@kernel.org>
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

On Fri, 20 Nov 2026 21:27:11 +0100, Nicolas Schier wrote:
> struct cpu_feature used to be defined in <linux/mod_devicetable.h>. Move
> it to <linux/device-id/cpu_feature.h> to let users of mod_devicetable.h
> that only need struct cpu_feature switch to the new include file, and
> to reduce the number of users of mod_devicetable.h.
> 
> While moving struct cpu_feature to <linux/cpufeature.h> instead sounds
> reasonable, it would break defconfig on loongarch and mips [1].
> 
> [...]

Applied to kbuild/linux.git (kbuild-next-unstable), thanks!

[1/1] Move struct cpu_feature to a <linux/device-id/cpu_feature.h>
      https://git.kernel.org/kbuild/c/a48b8e3e

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

