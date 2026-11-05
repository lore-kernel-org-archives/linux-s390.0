Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909201;
	b=BLFqZp9J3VSRiwSX3cyovm7n9B1MasUbj+hZ4nXOLpACmd2PzvHRZEtbyCr9JVXtvKA7
	 XWizLmkB0XMIf9dKGbG9j6iaj9YtGmftHnxXPaln0dxz/O2WulnMbZLiMISl2Hv7YhZlM
	 RzpUH9+3MLcbhsnBoh3iu1ghXVuiP+PqBjJGSdDLDeUad6/D4Kz7/WBoTjcBrn0TeLW4C
	 jvC2spZG18A9jXEHUIlNhPYXahweGZFOdS7eNLXhSHFIRd3Doj7zTVh7w939I6k0j0wSX
	 Snf91tF+TtWyucvh6WG47iHUkke3cOtq8H2vp0wAQlt22Kcfx60uepx6V9hp4nKLriA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909201;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=L7svFljblYiTK4kK5H5XiTJiOf5f3bWHWj0lw93O9Rc=;
	b=n4CCT4f6jcwyEDiSbAeoQGoMsYLwAqg1IawMDBrw9MMg4yuq7Ay1RoTWLaNrz36Q5TjG
	 3FLGrLYCuwWMw0Hejpi+hYSnsjNMLaI+60jkO1XK1ddcpZdsQW1uWjHaCoetR8XHGm/oT
	 kxpNSam/+u5S71cYW1Hs/38lbS5rzw5ss6nz1yV2K0vIkIavK8VXRQTTZlcXHsSaXXLPn
	 C+6Xv6O7NqE+5ZJqJc6mxziHZXEcrD77TbALatfNVbfQuc8GjMh9fXVbm34FVTxtuUAsF
	 /r+OK71z/vIHdBOhcQ3acyBdslX+FQyIpOrZ3oQ1b1bI8gpnvv+Dlu3i3nGca8LP40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BzFYU+7z;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9A6082BDF;
	Thu,  5 Nov 2026 20:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC9A6082BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BzFYU+7z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=L7svFljblYiTK4kK5H5XiTJiOf5f3bWHWj0lw93O9Rc=; t=1793909201; x=2109269201; 
	b=BzFYU+7zN+krgDfsXUP85boa2cJtj3shGHYGM9SV4ebQMMxeLRsZ3SqNJQ9fEyBi4kumQCw1WHf
	TVJyDgDjWOhG/OIGq6P6V6kDLcfhovFoWw/7ZY6LLW2Tur4OzwgE3HzeySHq4TWIf5rqC/0hIAyaS
	+WO+ehnsI8KQJ/a/K0KrYDB2QXPksNlD/3xNjR4IY/N9IsFfbNQ8xuKi7rfKM0kl4Vf42Yn1D2QK+
	2y9LmcPSbd1SU83YgOZUuykb/mveucZTn+Cn9rg+scxwQI0uZCTFWPhINOqNETldZuFmjFs3Rt98Y
	BV/gi0y+CYPrp5aqGpEFrZjEDAKQpvBuEskQ==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3jL-003hS1-6M; Thu, 05 Nov 2026 21:06:39 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:45 -0300
Subject: [PATCH v9 10/15] alpha: Define entry point for
 set_mempolicy_home_node syscall
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
Message-Id: <20261105-tonyk-syscall_table-v9-10-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 Magnus Lindholm <linmag7@gmail.com>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall in
the syscall table, define it as the real syscall entry point,
sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
mempolicy sycalls will ever be compiled for alpha, resulting in the
COND_SYSCALL() fallback being used to result in the sys_ni_syscall.

There's no function change here, but this step helps to unify the syscall
tables and create a common table to rule them all.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 52e3538cc7df..8fc4701a6328 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -489,7 +489,7 @@
 # 557 reserved for memfd_secret
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
-560	common	set_mempolicy_home_node		sys_ni_syscall
+560	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
 563	common	map_shadow_stack		sys_map_shadow_stack

-- 
2.56.0

