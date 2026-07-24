Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646223507C;
	Fri, 24 Jul 2026 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859488; cv=none; b=pFe1CWVBOoYGm8QzqiT/qbc7FSouQ+G6USKovKHUnzZUEly8Dvnfbb0mrBaJ7/9Bb0/NA3cUVigReni5XUajd/dIj6uu7YjXJ56jgoCGXI6ASdC67rITJpi20OUI6r/hPxlQFPQbqiZryvaIsRCD1QMwPPBNkvHk/ESPH0DtCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859488; c=relaxed/simple;
	bh=rwRg529y05peA/WWTMCXEBfX3q0s9gAsSrO8arvTDhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Udv56V9xCfVJxhYRYDg+oD+o8A8OYh9Q+MRX1L6OQV4XPJiKY0WlhSa1tEkaeyJwsovsRQdzUUkw7psDmYIz3pDG1Q5aGJOUQX9hoR9pOBPE59WWeHK9k4fhu75WLIh0eaBRxddYgJdPZ2RsbZvzUVlan9OK951snMtGjcO1eq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ipar9103; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ipar9103"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=L/
	SZp0vPqZ6bgIHdMlwc9563CUsJkyQzIo7rI6wG1fs=; b=ipar9103VugBwa7uzk
	RoqjOghrHfRoqDl2bzaHe0YPIkBrqYCLgiYNa1/ES/GRQ8WHq2GbajVuBN2uMDbr
	+3gkFYU0bsk813V33HstJUih1FcKIA7lBelM4qVniwAowoHQCdo0vuE4VHpsY6gY
	n6ZDAiMe/dnXvn4gK6jlV0i+Y=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnr+wRymJqH7z4DA--.34972S3;
	Fri, 24 Jul 2026 10:12:39 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [RFC PATCH v2 1/3] error-injection: Introduce EI_ETYPE_FALSE for fail_function
Date: Fri, 24 Jul 2026 10:12:27 +0800
Message-ID: <20260724021229.47302-2-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724021229.47302-1-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDnr+wRymJqH7z4DA--.34972S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr4DJw4kKF1xCrWkZFW8JFb_yoW8JF1DpF
	1q9r9rury8K348Cry8AFZ2yr1F9rsrGrZxKasxWws7Zw17tF4kt39FgrWUXrykGrW8uayj
	va9rWFZ0yr45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRwvttUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxfqampiyhdNyQAA31

Introduce EI_ETYPE_FALSE for functions which need false as return
value in their error-injections, like btrfs_data_csum_ok.

EI_ETYPE_NULL can return 0 too but its readability is not good
enough.

Signed-off-by: Song Chen <chensong_2000@126.com>
---
 include/asm-generic/error-injection.h | 1 +
 kernel/fail_function.c                | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index b05253f68eaa..6c399121ab7a 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -8,6 +8,7 @@ enum {
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
 	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
 	EI_ETYPE_TRUE,		/* Return true if failure */
+	EI_ETYPE_FALSE,		/* Return false if failure */
 };
 
 struct error_injection_entry {
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 2eaf55005f49..90cdad0412cd 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -48,6 +48,8 @@ static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
 		break;
 	case EI_ETYPE_TRUE:
 		return 1;
+	case EI_ETYPE_FALSE:
+		return 0;
 	}
 
 	return retv;
-- 
2.43.0

