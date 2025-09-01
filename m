Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B027A124
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759845; cv=none; b=MMYDWPmarcI5AY5XrKS8GqA9onqSx8emxp5tEEKx/PKn4JUg5srkPx8pmb6BhWLEH5p/0KmVsElbVapBOFEKHO4HJZqwvLxEj53P3+LuyK8DhYuWYJBB5NicwWvzGwsrGOD/fM8DL4l9VHGNrlwwbFScauIz7JLNFbVybF5BZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759845; c=relaxed/simple;
	bh=mdsrJUeGrkHnP8zL/eyQeyjJ3gnG2ENBLTOi4VtzzWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMGwlBEMkFw8VGWrK0BBGLdBt/znglzz1xYa2QUlG6rll5LfLq+w6hGjzGT2rEocwiXrFrhSL248W6AgSktoUJSVg+OgSOYDhQ7C46ZJrGYvFtXO1dyGCl3Iw9Ic1+lfu9vHS5Xbh1THo1KQX7ha437G6qMypJ474cI0XEPEaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RqAwSCd1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RqAwSCd1"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b00a9989633so440719366b.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759841; x=1757364641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbC8N+XiHIHVwpnYZGh3ddN7VzXCXgVoQGtIXVqNTy8=;
        b=RqAwSCd1/MuaH+RNfTQfJif/LUGNnb9+rRIeKmCE5gnIsAPL/QtpEw9jteEXBRg05P
         QbqDNV6IDuvYXvEzLhen9SU34igihvQEZEVcHV3cg5KCfbCpfT01SiZXYWFGNTBKD7xM
         Py+HlZzjhr+6Po5dPKpWKUvZVpEKbiNwEDzMdqEih1P1yiS9Y6eA277wuTIE9H++kXb0
         sn8hJrKBzDp7bK4ffQ37BpnMvwqA5BXpj/l5yO4UZ38YOGd+PD0l7R0Xp+sIaPsYntod
         zGt0Dtzei/Z6r8vFxt4C8/yDUuBS0WOPJdI0C/ypqTRxoaxz27nONjh0FPC+BdRsM+Wn
         qRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759841; x=1757364641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbC8N+XiHIHVwpnYZGh3ddN7VzXCXgVoQGtIXVqNTy8=;
        b=fPrwjB88089EEcuUg845Fw7R3jg+lU1PtG281LH3fd/Oq8rOLIGeQN1OGAXZ3+afaG
         kSOiLZQ5TaEFCL3lzu/n/k/zejV16J/5cEOoijI79DRNaeT+IWJg1e0QXaNkM9mzHFr+
         VYu1t1pCg7vz7tVuOAsnmmY9uhdwjyevpeEjo28n6zvT7J6eiEnBOwrYe3UsJFhxt46Q
         DDm+iw1eTaRGY/g+2fxFcPeRAWiC7ipONjlXpM4DyYB/2KE84FOKFsBQRlMjNCTVmL1i
         dxAuIBHZzGGE4L8pLBa1wdiIZeo97K/efzeJ9BS0VYxFwTrgxwIUank3PaEl8IrBK8EN
         B9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVNfU/1j+cE5Wsf/14qGPCDDO2NJIcJNdSa/h4FTL+4fLrGDK6Lbne1vQvWt0JsrVhV29aszSC3XtqC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7YkN3gIBsr3Hr/kPJcjA7otUYEb4gUdQE0phMwaEmbAizmFp
	/9jtQgIQXltpdcqR3ObXNE2uZCorMXbvPqq2SoR0Qoab0dLBO/939oh/H6b6nLQ98So=
X-Gm-Gg: ASbGncsyO4elKZ3Ou3UiRA9hbbI110T6a+5/eFcbGP88uGHaXN/2GPOjn85m2DaVWOs
	oRWRXJE27AFZbX+J4m93+WEtoLXAwnDJLkD7AnPy0gqu+x0i4+m+vxbO/AZdy/1RAn9CKesyQ26
	REZhO+oi14PCfzZuAmJ35gE3UlDmlbysb1yVzBDYDdotn+GFxs6+3SHbqXSRIoduq04S93v+kbk
	45JeT1v7avJ+Kz1r359PfztzA7C0cf6qK+6DAuEA8rFFxWmTl3+pdHbNP2oqD7LUsjyyRcPmsmk
	UIAFafRR1KdCvVVA588tv7Ry/8yZCZbUrLnUgWIxBz9EqbNiJnScKa1deWmIlu6UXyaQ4SQgqBF
	+91A6pHvwLGMkgkxcmwE0wEKvrZqiwaVtfApCQIGqXUM55ZZcwIDGpwy8aAmNl0EUKBWgi/HvEO
	3vbhyHmzpvuyjfGKub1GGRPMQDkCGzOGm4
X-Google-Smtp-Source: AGHT+IFaWDHYij5j1CBdsPx53clPCy+ttl9kO3s+0ZW4mKhtLHQkGphieDUSAGfH3AkYqVOXY7BH3Q==
X-Received: by 2002:a17:907:6d28:b0:af9:21ed:6ebe with SMTP id a640c23a62f3a-b01d9754485mr912367266b.21.1756759841055;
        Mon, 01 Sep 2025 13:50:41 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:40 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
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
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 07/12] parisc: constify mmap_upper_limit() parameter
Date: Mon,  1 Sep 2025 22:50:16 +0200
Message-ID: <20250901205021.3573313-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

This piece is necessary to make the `rlim_stack` parameter to
mmap_base() const.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/parisc/include/asm/processor.h | 2 +-
 arch/parisc/kernel/sys_parisc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 4c14bde39aac..dd0b5e199559 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -48,7 +48,7 @@
 #ifndef __ASSEMBLER__
 
 struct rlimit;
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
+unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
 unsigned long calc_max_stack_size(unsigned long stack_max);
 
 /*
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f852fe274abe..b2cdbb8a12b1 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(const struct rlimit *rlim_stack)
 {
 	unsigned long stack_base;
 
-- 
2.47.2

