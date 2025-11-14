Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D930F7F7;
	Fri, 14 Nov 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118279; cv=none; b=DpBEG5VmD6wmLeSThVd65rX1qfr+jgrHvuzsT617DoMysXMT/TNmJ5TzJjohc3letDDOkMHe6TDSI+p/q9bTcReu6MRpWRkNAndbFrrYA24w72DyvqD4tZxOFZWCO7rFVhHMp2HWa7XN/Fln32+ixv/uj27PS0nfcl0geo0GvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118279; c=relaxed/simple;
	bh=wzzMbTdC2hh/rR+4oIsPsUUKTlyMMZNrs2tvr4geO3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWpTUCJPMJtEFSjv4rzZbKCoCOpVBU5I1y6k0NJniYlnCpfKwv8guYeNiEXYi6nvRUhZp25ce7vy0SEh1IjEcCHkRAQRIBVgy5NUzkuiGrsIL9QCLfHw7OWIE8lb8sN5ylyd14POkWEYNPnaZDVEzcUTwl0V4DfyMfaEvYsP2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vbd0dnRd; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vbd0dnRd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763118274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MeI6QYtVANkFovy5tt/O/MTSmAciKfPNY1ZLSBRh7OA=;
	b=vbd0dnRdkHURapL17kA5OpkJkSR+GUdPi4KZA83WxMZtNa7TWQ9hsXeYeHJJ8DJb2rc5Or
	+rjTjnzVKIwKHM5s4YF3q72XD2WIztlq+mfQ0RV4S71slDnGkzVwi3O76Jh7Pp0pI9nwLg
	nCj7AwjAkwLU93i8tERuEBEjDq9C5Nw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] s390/kdump: Mark __do_machine_kexec as __noreturn
Date: Fri, 14 Nov 2025 12:03:52 +0100
Message-ID: <20251114110358.169429-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

__do_machine_kexec() ends by calling the non-returning function
disabled_wait() and therefore also never returns. Annotate it with the
__noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Drop the first two patches from the series because store_status() does
  return to the caller (Heiko)
- Link to v1: https://lore.kernel.org/lkml/20251110132803.1520-1-thorsten.blum@linux.dev/
---
 arch/s390/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index baeb3dcfc1c8..9be6f58a6553 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -224,7 +224,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 /*
  * Do normal kexec
  */
-static void __do_machine_kexec(void *data)
+static void __noreturn __do_machine_kexec(void *data)
 {
 	unsigned long data_mover, entry, diag308_subcode;
 	struct kimage *image = data;
-- 
2.51.1

