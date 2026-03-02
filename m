Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D382375AB6;
	Mon,  2 Mar 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455379; cv=none; b=qbK8FoAL1etiCxORQQZZdPpdBLAbBHnWCGsK25Uvl/AB+wwfDpwF13t2tRiLaRC9Z9ggmaUm1qSWN2ahTdbJZ4EguKnLvk53NcmYk0A3ByuNMOP5dDTCUry/D+M8qS2YytGdlijxcMvt8+u+BqkXabQfJJSe/lnRG1qtvbMmlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455379; c=relaxed/simple;
	bh=yDDdsBo1jMWNKz4i53Q/gbOwsZfoXqMpbmlpMaTSrKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dax3lWWGbGsR3yfqGEmTVYfgX91sAULSjb+kbJLiWwUkOverwG4UGd66uvO7q3jvRNI9rp6y+yD3pD7vqrjslLERhWDwhsl5hJ2nH2iiFtSI30p7gE9BKAhX+6FK2XR/I7s03zduK/bD+STOgSb1+DqI/rsvHZB0qkooU5G7Nv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JpD4TIJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ARBWL1rg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JpD4TIJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARBWL1rg"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772455376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edM/Hzqe3tsthU560XKL65xGahMk1uIWdy4OPGvvCIc=;
	b=JpD4TIJ7OJs/ee6nmbil0mjZIKKTJaQkWRAyGntOGhxK43dlHybsVq7QT+quA2dHPfkvfV
	PWG64EGwy9WehLxBsXtoFSU2qdeR0zUuXktunF4N59YBqleP6xL1G+sOw58fF/ph92+6I7
	famZarZHUV9FSzdQs0O3SiOcqZqEa4ZhI+5dKcSpmGl2GfzFkiRJvZwGikrqy+5FZybtmS
	gk2xWBkqsgn38+xLSf+RYrsDIENGfyWG/KBcUDLOVnpQ09jXOcw0A4Fl6FLgJFGnNdSyZO
	D2pnCrUOGyIaLuTNIbcCuZtdoa7IPwNiz+pg2RVW3GbO0913sUJbZWmcOcuv+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772455376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edM/Hzqe3tsthU560XKL65xGahMk1uIWdy4OPGvvCIc=;
	b=ARBWL1rg4yeawgEh7BOJROX8URPLxvKsulbNoO6JgAjm7c3LjAQezrJ3YexMI4eb/Twy6y
	ohg94bjwvSo1SHAg==
Date: Mon, 02 Mar 2026 13:42:37 +0100
Subject: [PATCH 1/8] extract-cert: drop unused definition of PKEY_ID_PKCS7
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-module-signature-uapi-v1-1-207d955e0d69@linutronix.de>
References: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
In-Reply-To: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
To: David Howells <dhowells@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772455374; l=625;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yDDdsBo1jMWNKz4i53Q/gbOwsZfoXqMpbmlpMaTSrKQ=;
 b=tQ+h8Au4YzGvhu3/zy0crCgJAsae3iSEzEb/ptjBM09S7Zu2+qkLNCQiHQBN7qvItBx0a1Ou1
 lOYQ2xsm6VhAyfnDjC8thENIAPhD2Qtw0Kp3Ji+6sXejKghtKdIECtS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This definition duplicates a definition from an internal kernel header
which is going to be renamed.

To get rid of an instance of the old name, drop the definition.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 certs/extract-cert.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 7d6d468ed612..8c762f908443 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -33,8 +33,6 @@
 #endif
 #include "ssl-common.h"
 
-#define PKEY_ID_PKCS7 2
-
 static __attribute__((noreturn))
 void format(void)
 {

-- 
2.53.0

