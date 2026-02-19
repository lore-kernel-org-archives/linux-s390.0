Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98D3191D8;
	Thu, 19 Feb 2026 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544479; cv=none; b=KgjGesJHe6O0q08C902uHstS7YQxjHhLCZVpcgwoPEstAaSHHuZG7zuGpsGRFT3oxWsjNIEk8voQuJ7BUCDsvAWZ6gJL7XklGtxlzyiZYtZFRRZZwFEBJxrVLO0BpL71436GZr3Yi2+/2hHxyWeHRjoBxEpDm0FUAImsbM4GKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544479; c=relaxed/simple;
	bh=VTQ95hJqzOo2h7kigE+Yn3hWdRxeEherTHC6Y3ja1R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=md5+N9/bJpoIF7T+Ic7fnR/ggeSABaMY+AcQgM2DyrdTUytKSE4h+LWsHFNqRyZalTWWXYVMPU9/ufRhZEdS4rXE/E4ejFutBdJMI9cERiw20KqywHhdVslkqe0XEFi1I98RgbahWYuWWvxAJDjiyfuUQgbOsy7UoPD9KPvuNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=pQKUJmWr; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="pQKUJmWr"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fH8ym0N3Rz9smk;
	Fri, 20 Feb 2026 00:41:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771544464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFceRmR8Q2zbOemIjUsCxHLvvbJHP4BrivlhG/ClUsQ=;
	b=pQKUJmWrtXVMoVdr5Zf4qnDTcNN7sKIg/id6TJmSlPChP5H3NZ/4vdyEHKcXJGNr1gTRxm
	nGERj4NfoXtOt3qhNf2S15wL5zqNf8nvbtjWQ13QvDbfAplHSBtLtlODOGq8bRDwYVmxmX
	Ix8tYsXi9sN+lxEM5t/hHvfdXIvaDsR6QMp9Ln7yivGW2r7sG4O/0X3Zm1V+Nmp1UFxMuG
	2gxDGj0uUioxiWvTbgsGKQZcf00rDncX7s1OOTiZ8DLKd3yFxdqs/JUHCR12KY3MICo7RW
	N3Atyo72Ddy1VdFAJ1ImAv+FFdPa+b8MQdI0OX28/f7nSt+L02OvdK7US2B9qg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] documentation: update arch features
Date: Fri, 20 Feb 2026 00:40:40 +0100
Message-ID: <20260219234040.3260616-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4fH8ym0N3Rz9smk

PA-RISC has perf-event support since commit 610cb23bcc75 ("parisc: Add
initial kernel-side perf_event support"); and s390 has stackprotector
support since commit f5730d44e05e ("s390: Add stackprotector support").

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
 Documentation/features/perf/perf-regs/arch-support.txt       | 2 +-
 Documentation/features/perf/perf-stackdump/arch-support.txt  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index de8f43f2e5d6..43e49c71612e 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -21,7 +21,7 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
-    |        s390: | TODO |
+    |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: | TODO |
     |          um: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 09431518b0e8..4c9a5a012075 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -18,7 +18,7 @@
     |        mips: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index f9db4dd8ef79..dd362b5cb638 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -18,7 +18,7 @@
     |        mips: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
-- 
2.53.0

