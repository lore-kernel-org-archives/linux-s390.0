Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351F11187
	for <linux-s390@vger.kernel.org>; Mon,  8 Sep 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333755; cv=none; b=Cx41jqaQK56DA1OKqkI5ncgDZNr/hAyipRbGFvkTQFiDwGTUAZRngdHjDe1LsSu2WmnXTwgG5foOcT8UihPqkMqjbfKwN1wKGQzHRXjZxpYLlBi1Eu9MpvbnQAmyTCaRlv8KuD6gMNoGEQ/P4K5INIZxkOy1Gu85It6cBPsmwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333755; c=relaxed/simple;
	bh=Yzki8UK5ivqU+xZSbkykGPPBdjgGpNIeynzagZ7/ITg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JRauOcClvoKTYmcTmIGn2FQUThO557RxEotMbhZfC/TGNjAst/pWH+FH6x5v6lENNhrsEVZ5VoUKTmKuPzAOTGV7y2xKj5uA7J197/l47/u/VKK8mWVGgRBQoltjINt34YolfB1bE/wqU4nIzjprQOaQe1amuPBuuZ6JR+XVRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBmgcFhJ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBmgcFhJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757333751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OI+lrpmwu6GMZxyp0oEbI2hfIoT0pSRjcFrJLPV8SDA=;
	b=kBmgcFhJF/0Bvc4I++B+oTSQb+1XkD90qSxBoHYPtw4ApxYKm1TRI9v+tkBDGQPaTNH6EI
	r7QV2LNXGRS4jtG0yZfS0/krjXEx2WdNhfn2dOKo+woY6gCOQBTptwvgpqTzT5f8SDh/rl
	/zhpUon9FVE8fm41SsOOXiCcGX5FEr4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-s390@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initrd: Fix unused variable warning in rd_load_image() on s390
Date: Mon,  8 Sep 2025 14:13:04 +0200
Message-ID: <20250908121303.180886-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'rotate' is not used on s390, and building the kernel
with W=1 generates the following warning:

init/do_mounts_rd.c:192:17: warning: variable 'rotate' set but not used [-Wunused-but-set-variable]
  192 |         unsigned short rotate = 0;
      |                        ^
1 warning generated.

Fix this by declaring and using 'rotate' only when CONFIG_S390 is not
defined.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/do_mounts_rd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..cbc4c496cb5f 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -189,9 +189,9 @@ int __init rd_load_image(char *from)
 	unsigned long rd_blocks, devblocks;
 	int nblocks, i;
 	char *buf = NULL;
-	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
 #if !defined(CONFIG_S390)
+	unsigned short rotate = 0;
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
@@ -249,7 +249,9 @@ int __init rd_load_image(char *from)
 	for (i = 0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
 			pr_cont("done disk #1.\n");
+#if !defined(CONFIG_S390)
 			rotate = 0;
+#endif
 			fput(in_file);
 			break;
 		}
-- 
2.51.0

