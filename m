Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D504274B32
	for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831813; cv=none; b=toLKy3sJjiK9F0qsBvaY4aXayObT4VmAGi+GlUu/1CGUEQYen5OR0yxQadN/iDi4W21cmueQuTUA3RHmwGOEnHDd3fG3E8IN1v1XdW3m01UQrTNNwnuOBmf03Ss8OpHuyTcyU92suxQ7pQD7EOui/QAVRUpzc+lr/rsPxgLnnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831813; c=relaxed/simple;
	bh=Ty0HqaJo0YMrjaKcw3usfBWyxkQ7++NzVDZDVqhZv44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRvlyhsIujdnZz20fSnO+N8UvYWGmnJffLaM75fCDRz6mvysCT5TEDonEagd61+C4xJGjb6g4BzP6rmK+Lhp8H+4uccrm5PDYjT71nQxK7wx68S/tymlzw6KpBn0CUxEkWgFs/V9dcGysICUlBE+wf9rXWgrDAUFPn8AaiQ+zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+Qrmjzy; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+Qrmjzy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761831798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/27E63V6v0chX/Wnv+95eUk3yCQINY+pVHFTGD5/UGc=;
	b=A+Qrmjzy/0hhYVpdq0V73dppybMicN+cGYbpZstUYWwooJes1gF0DYq328192V5X1lwtra
	84abu2m3V52u2yXEl6FMIOmUaPNZ9ZXSVYCxkzwUYu+6KD7Ko6+mlF1K1dbpIGVs81kszB
	u+TwKXSZlx2yNBCasR4sOuD32glLvKE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] s390/smp: Mark pcpu_delegate as __noreturn
Date: Thu, 30 Oct 2025 14:42:41 +0100
Message-ID: <20251030134247.303400-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pcpu_delegate() never returns to its caller. If the target CPU is the
current CPU, it calls __pcpu_delegate(), whose delegate function is not
supposed to return. In any case, even if __pcpu_delegate() unexpectedly
returns, pcpu_delegate() sends SIGP_STOP to the current CPU and waits
in an infinite loop. Annotate pcpu_delegate() with the __noreturn
attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index da84c0dc6b7e..93ac451db6f9 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -305,9 +305,9 @@ static void __pcpu_delegate(pcpu_delegate_fn *func, void *data)
 	func(data);	/* should not return */
 }
 
-static void pcpu_delegate(struct pcpu *pcpu, int cpu,
-			  pcpu_delegate_fn *func,
-			  void *data, unsigned long stack)
+static void __noreturn pcpu_delegate(struct pcpu *pcpu, int cpu,
+				     pcpu_delegate_fn *func,
+				     void *data, unsigned long stack)
 {
 	struct lowcore *lc, *abs_lc;
 	unsigned int source_cpu;
-- 
2.51.0

