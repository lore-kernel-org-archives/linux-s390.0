Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFC39FCD8;
	Fri, 28 Aug 2026 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959224; cv=none; b=HHhB30ELAW3Y8O0OauTUTGh1kMN8i1pXW7n+llBukS6EI+HfTkUt7q3bEKhyA1FuuZLah7qXuRXg67ew1W92EjwEMM9WW2M4AGTDeq1AgEq6q+zL2kl1HIi15Nimuq7OaLEANuEE1PCyfO5q0pPbsjL4gi9LAMI7V/SKgqIXTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959224; c=relaxed/simple;
	bh=kVU3n2i39Icq9qloJMwQvBwGCrc9vuWdWEbRtqBqTkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AozmQroyyEmTyNtfp74rKEHpTxDCRBc8KsHhzXfsSFrE5wL7D1vyb9kznI2cmgd6vE+Uz/jw88vPK4v+/MzCoE2ueaZQSWySU/TBTPuLNVMduiaFDUFPyywvI7EkNA/utAGR9xdeR9hWUKjtCgeE/f7GzHWR3fxKtvbSjJdzo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=s7D26FpY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="s7D26FpY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=cF010O5Ez77E0X5rUOC89ph1F6h/g+B4bYpAIT7kJFw=; b=s7D26FpYHcnTXj8QW5MAIKAiAd
	zrbF14QXYqdk+FW4r+RlDlXQR+vhTAFR+YvkTAx/Kf3Oks/i84BI+plIKPDKR/xviaQ0vM5wE30bZ
	IXdxKhouIJ7X3NTOKzW+7Dil594XvVl0HN1e7UeCs2euAEi0XLCqpk6jdvV20LuQdJKLGX3c0cwoD
	kNJClh9/zIOc/GI2X73602Zd5/AK9dG6LrwSRtydEy5l01WcCBmypAnFX546Ya8q1HexRnGqr++Cb
	KtgkGLsgtNQYhJt2I90+GuyyxBozjDw4/vf2XqmyO+gxloug4ZJvRU1Rbj7BXZx943LVZwEwAACy7
	AZiDHklg==;
Received: from [187.57.78.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x05rv-00B3sF-6U; Sat, 29 Aug 2026 01:20:19 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 28 Aug 2026 20:19:38 -0300
Subject: [PATCH v6 11/13] alpha: Define entry point for
 set_mempolicy_home_node syscall
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-tonyk-syscall_table-v6-11-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
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
2.55.0

