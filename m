Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717D258EF0
	for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831810; cv=none; b=gwuXI5xS7e6uugITZAow5DjFOP0UOcb25av9w4Hkh9nQJMfqxhDirQcmoK+nc3+WPhfE4g7Be+iUDYiqHESVfRENyi75qgD+LkkhCeUjSb+S38urePltjcE4anD1MNXSyZC7WE8ez39deYXWcpyITr1AYXSU943yJpsFxKC2/G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831810; c=relaxed/simple;
	bh=q2dS9Wmoq0IvB9CNrDLlHYbQgZg77zhGS4+hlb8bpAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rl6gwFa5I1CB52XBkDNlf02DR/tdy+Fr49Fs5k3kZ4EuCqZCVxt8JM8FhOeVXNhAC8Glx10+bmtkyC9J56PAhhGWqWxed8Q/Ilkhnmm2eLgguCdQq6ygC0octmoYFsaYTiK/uACShx3uB6LAIStSv69JVaWjZN/Tpe4aQaQccY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYMwWFP2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYMwWFP2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761831805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nix8ccPcH7vv2qncbYSq0H0IVjKav1x3+J1SQpmFoEY=;
	b=KYMwWFP2KcB/vuUDk1frITmayPdSNXJs8/+iKr4zvc4P72iW+P1eZqJyDyWhqbN8Frh6XJ
	4uHtNZynZexCZ7zG3nGeMAawI5+MFbMDFLle045czys16xLxiTxKqUFBc0/0S2GiDgO3lw
	rX1leIGwr4Mu2kPL0xvwL4CFT5yRPZs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mete Durlu <meted@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] s390/smp: Mark smp_call_ipl_cpu as __noreturn
Date: Thu, 30 Oct 2025 14:42:42 +0100
Message-ID: <20251030134247.303400-2-thorsten.blum@linux.dev>
In-Reply-To: <20251030134247.303400-1-thorsten.blum@linux.dev>
References: <20251030134247.303400-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

smp_call_ipl_cpu() ends by calling the non-returning function
pcpu_delegate() and therefore also never returns. Annotate it with the
__noreturn attribute to improve compiler optimizations.

Add an identifier name to the function declaration to silence a
checkpatch warning.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/include/asm/smp.h | 2 +-
 arch/s390/kernel/smp.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index 03f4d01664f8..fb2bdbf35da5 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -43,7 +43,7 @@ extern int __cpu_up(unsigned int cpu, struct task_struct *tidle);
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
-extern void smp_call_ipl_cpu(void (*func)(void *), void *);
+extern void __noreturn smp_call_ipl_cpu(void (*func)(void *), void *data);
 extern void smp_emergency_stop(void);
 
 extern int smp_find_processor_id(u16 address);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 93ac451db6f9..49c8cb718210 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -370,7 +370,7 @@ static int pcpu_set_smt(unsigned int mtid)
 /*
  * Call function on the ipl CPU.
  */
-void smp_call_ipl_cpu(void (*func)(void *), void *data)
+void __noreturn smp_call_ipl_cpu(void (*func)(void *), void *data)
 {
 	struct lowcore *lc = lowcore_ptr[0];
 
-- 
2.51.0

