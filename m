Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123B3128BD;
	Fri, 14 Nov 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118296; cv=none; b=uSTMb+8KH8TYPa9XTLWm0B7Je2e2ybCzkrJ3rpDPWAZShBXRvnp4KsmxgRd007GVeklWJJC2aUtdCa79Pgi1G0AzBEZb1y359+FsYVUFk4OHnQiu1sHmOIj3zTLQ3mGV7e35O/D9tyetThQpXqq5G/AtU6eCARFVw5YoRQjXGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118296; c=relaxed/simple;
	bh=5XcPxG0gCQk3rUf0L8Xtv3QBGQJPl29Jy4jm4mU7m6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wopp7mgDvK37SdxLRXIiC54gt54zjNKlRTIk0njH9DWP5hGxjdWt1j4hmK924gz4exS1yHZM63OBlXdPwL8fPZS+TtGkB4jueSE/wp/DXvsKKt7Ye6D5tCJ3K2RHqOuGyI+AaSCPQuLP2zXOnXuPQw1aWS7sND6VgOXYRoKX37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jw8aQo68; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jw8aQo68"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763118292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NTPyFfcINxspKW9Zk5wHRkBScquaFmhKsNqKXDqdr4=;
	b=Jw8aQo68njhZfwYLFxhF5J6GG2zJqloJWT99CJjGEFm/ta3m9pvnI52N//MIgMezjaUpf5
	jHHbkWDHp54S8Nkbmd5IiFvXo7f8nsfF0stOceMHQIPzsMZ52h+0F9CrGuB7MLdVrLS8+D
	5m9mH3u68Pt7szXwzF5T3FkGSGaIP80=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] s390/kdump: Mark __do_machine_kdump as __noreturn
Date: Fri, 14 Nov 2025 12:03:56 +0100
Message-ID: <20251114110358.169429-6-thorsten.blum@linux.dev>
In-Reply-To: <20251114110358.169429-2-thorsten.blum@linux.dev>
References: <20251114110358.169429-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

__do_machine_kdump() ends by calling the non-returning function
disabled_wait() and therefore also never returns. Annotate it with the
__noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 1d1c709bc088..c1103044c647 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -45,7 +45,7 @@ extern const unsigned long long relocate_kernel_len;
  * Reset the system, copy boot CPU registers to absolute zero,
  * and jump to the kdump image
  */
-static void __do_machine_kdump(void *data)
+static void __noreturn __do_machine_kdump(void *data)
 {
 	struct kimage *image = data;
 	purgatory_t purgatory;
-- 
2.51.1

