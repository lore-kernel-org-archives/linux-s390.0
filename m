Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7113C8C71;
	Sun, 20 Sep 2026 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875943; cv=none; b=l8D4FxVJzWb4Q4iutKcqOgsRi+880m0kAUJ/Ef0yl6f8Q6aaEwAtwetJwQbAOQVdBi4AEINOtxyQoqG/dLRkH4AzdBevndPrQPaXLOeniYcveW2+khTY5eqtcpOHT+1BIKn+sQk0N77s7fB3uZsq8YVs9UdEVYbJuhEjoAY3yAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875943; c=relaxed/simple;
	bh=fNDlvv9js+sV2beWReqfxE7Uavey4en9htf6yqVmgUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOEkGcAELHeKDKCkVQ+WlTa4q0vKzPf0cRXG95c0Y62NtwjpefHvWoGOFRLXZ1mNK1DlQxRfq1wQ5hMCPQtMA8knx1TjlKQiz4q/3TtIA8pDYl24SLH+xLN4PyfiC6BiIiL83RelrCI+EBKdQBSyeYE/7ktQntlX1Bhvk/0owDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HkC6IN9S; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HkC6IN9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7c
	zii8ADadjJtpJC2iwRVyjneTWNVczRgsww9F8lTRI=; b=HkC6IN9SFXzFmbfUx8
	UrOWB2mInUNCwt4LMjAgNr7B+Paqi4RgVjFD+4hbpUrViH75vJEyOThwR8pGkfhj
	rZgiUxBz1CAFSDQEPyp2mRLK4+DXt6HGa8FlZ482EHPUaKD27MEG3kNfAT1iHau9
	xsBlGiwMAf7BA4CtOG83WpV/U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnT4bAVq9qBxlxAQ--.5103S2;
	Sun, 20 Sep 2026 11:45:05 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: wintera@linux.ibm.com
Cc: twinkler@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	hppiscas@163.com
Subject: [PATCH net v3] net/iucv: require IUCV for AF_IUCV sockets
Date: Sun, 20 Sep 2026 11:45:03 +0800
Message-ID: <20260920034503.17322-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnT4bAVq9qBxlxAQ--.5103S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW7KrWUKw18XFW3tryrJFb_yoW8XryrpF
	srKryjk3yDJFya9ws5Z3Z3Wr13Xas3Gay7WF1UWw18urZ09348urnxKF4YqFyUAr4ktrW3
	X3yF934Yya98Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRY0PhUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QFMFWqvVsGu6QAA3g

AFIUCV can currently be selected with IUCV disabled. That configuration
does not build af_iucv.o because the parent Makefile only enters
net/iucv under CONFIG_IUCV. Independently entering the directory is not
sufficient: AF_IUCV also relies on the IUCV implementation.

Restore the IUCV dependency for AFIUCV, as proposed during review. This
also constrains AFIUCV to a module when its IUCV provider is modular,
without changing the directory traversal rules.

The issue was found by our static-analysis tool.

Fixes: c69748d1c9b5 ("iucv: kernel option for z/VM IUCV and HiperSockets")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v2:
https://lore.kernel.org/all/20260815135456.53684-1-pengpeng@iscas.ac.cn/
Replace the v2 always-descend approach with the IUCV dependency proposed
by Alexandra. Do not carry the review tag for the superseded
implementation.

 net/iucv/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/iucv/Kconfig b/net/iucv/Kconfig
index 5cfddc9c6498..2686d795cc2f 100644
--- a/net/iucv/Kconfig
+++ b/net/iucv/Kconfig
@@ -9,7 +9,7 @@ config IUCV
 	  communication link between VM guests.
 
 config AFIUCV
-	depends on S390
+	depends on IUCV
 	def_tristate m if QETH_L3 || IUCV
 	prompt "AF_IUCV Socket support (S390 - z/VM and HiperSockets transport)"
 	help

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

