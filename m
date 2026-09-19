Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A21339386;
	Sat, 19 Sep 2026 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777921; cv=none; b=bGaCrH2eE1UBnCa7F1BdPMGiqQJ+XPG9hKzJ1YAhV7imJqXE/DJFb4lhhSVIlindS6GDHMJ0rRJ2AOaVrTMHKO3+JHKKRC9xHTS8RlaF+/W0NXCac55vHuOkZpIXfg41TpwKIW9Ksy3zNXIx+GrEuZLq7vZ/KuHfjkcy/ivmxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777921; c=relaxed/simple;
	bh=gb2AbViRZzk+szGluxr09mWXdgtfA6SUo6NFEnjGLvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCHnAYpLWd2E+uD8EMDGPtc2NlwewVrfHCNSyH46btm/xIaE2sv5Gd34rpxkSpHG/LOTRVxJA1QemCbxz+LWLaJo8rYXhBUWDJV9TIKooX/biH09ebBNJBB/6fz47ZytbaeNJ7oOEo6J8S0LscZkFRuIa8kCUOqvNMHpF75u25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b+Z3zDfD; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b+Z3zDfD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=JiO7VRY2baQx61IOXoNYRmrKHWzz7eqIcunj8wKmv20=; b=b+Z3zDfDa9Kh3DbTCi7xcgfny+
	BrDii2nESvXgDmZFCas7RuSLEkn7MOnza4fAGs7MqMdh3AEoUrRuFPNA7Vyyf3JkMPwgaGUHlF2zZ
	R0FxFAd8VRTGCGR4PTerBrYRNh9nrSLYrYEaHiMEgE+H72AVaqki8ZG6Tvc1BvR8dt4CSYhjaG4YB
	SANcvx704WQD3WqVf36urWkXt0ufFgL7YDZSrPyayvqjdv+QhFSTKgqjOHak4b69j3ADOKxep+OYI
	rJb4v/JQUfUF8swY8nmv2Z5HUCPgwI9jPi4OhpdO3N9T8FuJl8myiV0AuAATrI7lhwyd38iYXhUmx
	j+5d1VEA==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7iza-004Bwz-PB; Sat, 19 Sep 2026 02:31:46 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 18 Sep 2026 21:31:17 -0300
Subject: [PATCH v8 10/12] alpha: Define entry point for
 set_mempolicy_home_node syscall
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-tonyk-syscall_table-v8-10-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
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
2.55.0

