Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C3221D8D
	for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798516; cv=none; b=oFuWBB798K9/eApwkmFVG35eZoST+yO3DSlBcxPVWRij0PV6yKesBJcsjfbTtvzpuly8bKt+minDl5S6Xt0sqBYTZP0hNGULxFn8osiGd4+/8KBOK6993A9coySIXEbkmF2Ypj4Ku3enXH+gsv+JfhEHll3HJeid+QCkFHzgSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798516; c=relaxed/simple;
	bh=6Jv3RrScO5w/EgDCugSyRpOSSLAIZEKRuKvKOtAXhc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hNNUXpUfRExXxfR/MG3qRI+EEiSDP68eLeCFp71EsTDpoLkb52HgO4aR4iHxHavtUH/lxtYRbfX16XJgMwj4OtSoi/e6JVx6hDKuQ6TClMqrL1d2Q3IVuZPEY7ofaNOvMphJUEuGprlQG6VcplxnaGEK0+ebPantQjNobSsNnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zt/AJBNT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zt/AJBNT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e4bee252so1842767b3a.1
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2024 18:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798512; x=1734403312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpJ3voZ2zpkCxNiGYJ7mZV4beiWEDuh5gW+cJghhtIw=;
        b=zt/AJBNTWE7S0YkQ89Ai+Cr+bI7/Vtl66s2tVTb1jo1Q8OXaNed+nZEzX/wjE9YxrX
         Qn5CH5DU2NqmxF2XnPpJdinveGr3qcpyTIdtVrbBvgcs5XBHqjhrrAA880o7Qseu/NTX
         WipFrylGDp2d8wF1+O/Vx5ZoSDaF8LCjFyxSG0PkoB0lrMkTWeg66H4kNmqo3EM1Yhjd
         ZElKPdKafEJ1YJJGbf8mriqE2PI8wTP+pHvFOdPPg9i58ggM1W4fkjask0VIGJZiu5x8
         ym3cuJmsk03eHhbJPVqQoLLdpfS3fC3rKNoJ9F0Dn4fVXY889iqh5QbHCWuXoK05GWD6
         Ll3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798512; x=1734403312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpJ3voZ2zpkCxNiGYJ7mZV4beiWEDuh5gW+cJghhtIw=;
        b=HmyNgS4zBWpMXskM3MeiWfaIVIu6SVRWVXpNYXyLgVkDBWwRun2eZrQdhYxznKkj/V
         AUisILD9dWR0VeLaAmtuGmmC110MVIj5Ow08KNQ8e6zA+ip0Ht2e8MCuY178aICoYj03
         9NjTOmDWRxhCEcOpndzvnYEhqOwj1vg+HC7WZDbySw5mQR99OApQm6Zqf5nlD6BZqlG2
         2khK5PPG1eEdwBlF5NUms48VT8+YC9l5IDZUDTHZ6IvizMMUyvLvslNIbQCI2rAUpZTA
         +9GnMWbZSswALteRFHhwFzHVTU6Kh77YDPi866eszparhwKV01qwdBdBToiU0hO67XTr
         eVfA==
X-Forwarded-Encrypted: i=1; AJvYcCWHORewM8mjF1GePBp2cVu2DU3qwkyDGGhdr0hHbh1sMJxWvq5H9///jhAy602DvQW5ZBL4Cw+arfZp@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUkKLzyirXpQpn2DGU6q4BWwHPU5eZ8Ijqm5ndWHCB3M935xn
	kBdM9mCzDjPs4oAcEWehPAUDo0WxobmYwFZaExB4aVgEqTMFBMb03cUWFueIBYTo5pL47T8phnQ
	Y7zT9lSxN5adPk1j/xlntZQ==
X-Google-Smtp-Source: AGHT+IH+U5NNduIwURg0BoDlPsKnnOIwfCnZdS3eRXACF/uPNRGoE141bvOCCDVesMcVlUE6OG1mnMpg0Q9mT2r6sg==
X-Received: from pfu5.prod.google.com ([2002:a05:6a00:a385:b0:725:f376:f548])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3016:b0:725:c8ea:b320 with SMTP id d2e1a72fcca58-725c8eab756mr18454838b3a.14.1733798512543;
 Mon, 09 Dec 2024 18:41:52 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:18 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-17-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 16/17] mm: Fallback to generic_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

If an architecture doesn't provide arch_mmap_hint() fallback to
generic_mmap_hint().

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/mmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index e97eb8bf4889..59bf7d127aa1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -691,6 +691,15 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 #endif
 
+#ifndef HAVE_ARCH_MMAP_HINT
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+#endif
+
 /*
  * This mmap-allocator allocates new areas top-down from below the
  * stack's low limit (the base):
-- 
2.47.0.338.g60cca15819-goog

