Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03729ACF5;
	Wed, 25 Jun 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845187; cv=none; b=oVp+GAOAt4w8Sx9jFPy1Wk/J5IBprd+zHYc/tU5bhPRuokt9b22WPGTJVle+Koq/vXWnjxAZGkmqYjkQTUtSyDF3xMjN8QSuMvWLjW8KhTMe0+BjpEFXNe//ilaRpZmKmEEPYI8oZxjmRq3MiOyp6TaRVLBlU0TnYQo9onk7Yzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845187; c=relaxed/simple;
	bh=sGXp482ePzEbOSqj6Oo7pSTRt0qdWiaHv14lzRVBHx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYSOT8yanxdOy0LZxz5VnzFGqjoRJF64etzXfACvzxMKBYh2NrkBp1FPHIJrVybgeMaa27FI0Ve9mi9XpmFYRq+3d7ANSA+rdX1OUmKJK4ElYz2WqjGYRyl1nBE/V/cuKFKuRk+LF9YTSQ1IGdyi0Sze7QWGO5i9EMqkmaKKoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPfQNopn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPfQNopn"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32a9e5b6395so12342021fa.0;
        Wed, 25 Jun 2025 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845183; x=1751449983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=VPfQNopnBR/H8mCrLkMzOeoUi8YEKxX8J0NxADzm6FjQkAnv9J7KZ52LGGcV2wWQEP
         c4XPzQMSGKFCozQp+JNxytmuKF+CtuRe3GPjmqR2MLhVQy21VxiHVfOxvujZsNV5ntgN
         uTG4P1VEWZcNqnmrvOoI/fl3adGbEcE7xzj6eQPz14vXORd+QuP0re6oDmA/tqeZoWAD
         nyFtICp2tMbpEoaCcQhscSCRQIHXSshP0Exy3bAFStb0sSF605RDCAiacOC+6AD+JV97
         4hZ8mGJRZj0CCj4Jv5jKSfMvNzaGnWyziLGG0Xhzb3+QzRRZ7uTCrdmc1CDYGuS0Ch1P
         Idaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845183; x=1751449983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=Yu5qw/LOjPHyxSTtFvxK83zGE6EDOJ3UIEjxMNzFN77X0uZ1uDHjatb+Ns78WIKM0C
         8sDdBo9x52w9fJ/QrfPVGxS7ixhXcFNTIbgQjSQA5RlCoG77pUvAL3Fv3EaNzBkzo2J5
         W3fmvvun477M3OMIsIYp46LtFfO4pIF8FYjTRpNuNCYkorj2WDBp5pIcCVx97Fk9XuUz
         Qa3UhGxUHCWwtWWhaq2bTsSzTGlBd6mWLtOazfiflYYYegW+UyK/EquClSgKjhsCWtQ+
         7Sbm8dzU2QN/V+jRD9SitQ1zvRbSV5Bm4xfimgMNhyk1extrEJOJfPwlMkfjMx+PkQ0N
         PkrA==
X-Forwarded-Encrypted: i=1; AJvYcCVFnd79BpeKbnL55XpqUTdVeTnNfyzKCnnqhPvj2PmVHzAtJc7i7ToztMmRsmC26KvuDZ02qWUQBhiDng==@vger.kernel.org, AJvYcCXrTnwvyWZh7hznVRnRsg6+/NQgiWLSw1k+VyhqNSurDoLzPgX4s456U2rzHv9N8nAWQah+VJc48dWYlc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh+5jhmBxPVyRTfNb3czlx+4JqJaYh1Xhxjzwo6X8nKRRhrJRu
	2PhUfkvPjn9vHn8bOMJxWagOpQjUjCoo2LeDeD0x2BdNrk1iAEWmQtHP
X-Gm-Gg: ASbGncsmZ76lJL7ot+sROzXe8oH1wrlTXkkDhT5SVCkIvzZNzMW10MpS7n4jnsnLSrx
	dHfiC5RXavICY9hc8c0yyxpvt21xWhliYhlhf2jDXFT+J/JLbYAg6N/nqpNvNjHl6Zf2NOhiyEe
	BIcPAV+F1ZDcuVtB9FvvPyk/3quyCoanfKzFtPW7F4C+zla+6sry7wFHCH/PRptkmdMwZC7alcr
	2q85BXWFuVbwAbWXUp8aboGcFoywXtduR+7WfO5LFmFr3n97ya7zF0imHfNyEebaEqQNuJn0xsw
	IPwBqxyAF6WJR5TkIU6fsuz3qpcQekO6RTYq1lYqdKx0vpFHlAmQlUvJ1wK8PtQRs+9Z8Z15LAA
	Gip+YFo7f6BQc3SEmC0h+rXHBWUgsSA==
X-Google-Smtp-Source: AGHT+IFM+6Gp9FKNRVxfpjNXcdXOUjE/qQpWABAqK3bSElIsQlHP18BbIkRAqZ9Oq2fiOL+vDX3DJA==
X-Received: by 2002:a05:651c:e11:b0:32a:714c:12d1 with SMTP id 38308e7fff4ca-32cc649716bmr4987311fa.1.1750845183165;
        Wed, 25 Jun 2025 02:53:03 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:02 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 3/9] kasan/arm64: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:18 +0500
Message-Id: <20250625095224.118679-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which enables the static flag to mark KASAN
initialized in CONFIG_KASAN_GENERIC mode, otherwise it's an inline stub,
and the flag is enabled in kasan_init_sw_tags() or kasan_init_hw_tags().

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm64/mm/kasan_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45dae..abeb81bf6eb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -399,14 +399,12 @@ void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
-#if defined(CONFIG_KASAN_GENERIC)
+	kasan_init_generic();
 	/*
 	 * Generic KASAN is now fully initialized.
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
-	pr_info("KernelAddressSanitizer initialized (generic)\n");
-#endif
 }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-- 
2.34.1

