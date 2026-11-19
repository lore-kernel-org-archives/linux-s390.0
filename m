Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119759;
	b=eTOmbdbrKSZ/KbLJlUFCyKSSqDzVFeiMYZjz5zuWe958H0JJf9B9I8QkV6ZSt6sedGxI
	 VS85uZtfrI2t0W2wjg3RAWFm+ElTreQ0NL5KRYzH3yph+Dc0N9TDQBplNKToTRAfdQxbV
	 hWvB+aJM5eLMBVKovw/AACpA9iSOukSB1aB/FW4eu11OJ+dGewsRIlp8SEqm4ht//lCMy
	 UHkgUVD4utfByoQF3StcIGjwnlxMwFj3QcbSwguxxB88aSMKGlYezdGpo9+RUxEHkY6JI
	 8tyBMcA0Gu24ZwYQ45g90nQ65i7UyFcBGxGMQprpYO3ZvovNJ2N9LRJ9yd8e5k//w8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119759;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=mjZ0ILJQDUB7/WbnVlwsuVvez94YmOPiIieAqVG81C8=;
	b=kMtzx820Cjo7WNjQjKyH7u6rsZpc13kCFslM0saQ6BdmmFJxQk6m3H6wfi68cx9MSg6g
	 tDeBLXM19oyj6iE6fmLGdOoHi65IOnh9g0fOn7knw2EN+FtAjx3e3lUN43zQwwRoGFHln
	 VDNb1gzb+nOpii0pjBF2jegvEVIkqeCV7VGINRaq0X69vks0V65lAynMDFEKAggD9SUIX
	 Gat0UeVVn78/18JcP7BLMF3KxVIy8gro+vPdEjob9Z3VbFJWmPTiazOGI5s63HnRlJjdg
	 C4B2MMopUJvB2rKa7WxWa+lxviSnWIgCZpPQo7g5XJJx6tOlrIFJrgJmcpHT01/vaKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mn0SGdXV;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B2606E4E4;
	Thu, 19 Nov 2026 20:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B38B2606E4E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mn0SGdXV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=mjZ0ILJQDUB7/WbnVlwsuVvez94YmOPiIieAqVG81C8=; t=1795119757; x=2110479757; 
	b=mn0SGdXVBIKNf9inmjZ8+VxNoIfQWxYUUut4nOuPf65uaJCgWsF+0yBPzbAJbHN2RjxFagmDwOu
	K4SMNp4Z8pr+4rzInTrX8NIZQuA2+ULIjl+bdiFE5rhTTe0UG1BlxtjkiQNmx7DS/M7yWQi435I8Z
	ToPYyXwexLk4X5UfIquiQapWhiHt3dI3sKntuKqaaY3FHX1t5+7Uv/fonsvEfsRrB3BxEkVVLgylG
	wz4CbU7O/5iVISZ7w3EOdDc977yXfjdXbWcDS8dSbMQ0E4u6d0Pw4u8Egs1EvIxLwzk92yC3u6A+7
	B/+8+WWaSLDvkelWFiXoknZaYZCuVR9CeWPA==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8eR-00000001cIK-3dKp;
	Thu, 19 Nov 2026 21:22:36 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 19 Nov 2026 17:22:00 -0300
Subject: [PATCH v10 10/16] alpha: Define entry point for
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
Message-Id: <20261119-tonyk-syscall_table-v10-10-a7c9ebd900f6@igalia.com>
References: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
In-Reply-To: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index f804988f90d6..d57c423026c3 100644
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
2.56.1

