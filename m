Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0334574F
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729849; cv=none; b=E2mA0pEwQ8123ndWsW0OnAWMjiIdWjAgTKe9USrZQt2PTjMB7pTrGz2QksykKx0z/l0xFPKMSWfRMyT8wRjWSBYyVJ3Cv+c3AwEnuqO/9XBcWE5NoX8TKUtfhVuWRT96TgEOmfbCpIhF1CeRTZ2jIQXRuj/1Z8uO6I0NBH83xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729849; c=relaxed/simple;
	bh=oY+kVrJSUNMT6cURQZxHlXP0Zp0Aq1m5o0k1qFqpfkg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5fUxwUgnKCukfh8f9Jo4G/MGzey+J3WaXbJE8w7psWO8foPgCTNZphpILuiPSDna75E43SeNmu+Tq7IC2C5igF+65b6zloCDx+arApEAUrLYbqpl12T61qLYTZf7+Cbibwr1T5zgtP1Y6EhrEphPLJm4m/8aqPvJZgOmWxe3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IGWxn0AM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IGWxn0AM"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aff0365277aso436475366b.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729846; x=1757334646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TakQ8h85rIAa1grDUxPMVyoALGVgUpKOsAVdRA9oxes=;
        b=IGWxn0AMjS7kGyrlVUR+4CL7D3H6J/2wHRGBk0IEFRRq50Z/9BMQkC3kD7SFCdanyf
         LWoObgGoAcB4Ll0Mrg99BgD1jqghxx1/+4TeO1cUqPvlh2ZJZTDK3jPspzsN4vXPzIAd
         +G5FCUQErcl37gyIi3W5p+vvIW4chQ1C7AmPLfwLXIEwlgO+FHsVjUek75c2caWvPTaz
         dIVY6jvCc/5S5gpJh2LgqoolixwNxw5xosp6bEIOyGHEyEOu59XAE93ObyWJlQ5s9UNv
         827S8WtDxpF8JF1lgnec72E4HJaKH32O7PAmo7EcuI5LSq6jP2YvLlegnbFESRjv/FuQ
         GonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729846; x=1757334646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TakQ8h85rIAa1grDUxPMVyoALGVgUpKOsAVdRA9oxes=;
        b=iVGifWudAAQi+n3RzUeowaC9u9NYmaEsiGWFRD7WuN7zQMHPumpjgrmraprcpoiywS
         CBzdjRoNUJ8qG4DQJbQnx+JwSqV8KkRPhNf84ZuvZvSeEtNxv70iFeyHxvr6glJM0U4n
         V0Xmoj1U5Lg6NVOjrs3Qek7QA/+oZA2xscU9oHyh5JyUKoE0Th3Igff6iIlYsR+h3Abx
         YUSnnFD0KFeNCTNOpf9e31IM5MYfyZ4ffAaGO8xlXpYQZJRM1juPnvG/4JZsXwmT93PK
         zM/gW0M8+Cc07Ee3BpYpgL1lDd8bSuqc7TqZmL8Fw7qv4kXqw9FobfpFwmNaOlwkgwsJ
         R5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUETErLhu6A4qUiEzT5znH2OQtjRisA6MIo+uh5PSmNsXiNlhv6BHCBiudr1p0QwntMlhpdW4JrRP0P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/z9/XHzjOBCzL7aGMd+rdClNunnMIbtWOreHStBI9CwtGkcJO
	RPeCI3xuEBtwZN0W89L8qajkhbHtYyVpdmCYwLwPkXO+78uU+XzJq35DniCnF1YKPwc=
X-Gm-Gg: ASbGnctWxNSN43CxH1KnzT7/mQ53A3/cDned32UX5yWg2T7Gr5dmmTP/zFqsS6ihtiG
	e+yEBcWYOjKbCa1RJFz8XEfQ39d/uQEhv5CZsTHy6DVOBWltn9nBZeHrtIBKaapSVWKMDF4cC1F
	KKjdU4+0PuMdVJYxEWbMeAVC89OlfnqjZDXEFE6AjdP3U2JwpqMCuRBnwafMbIlbnTCtFrjwjGb
	OPygnqVXiclvPQQjv00IN25ioVgpqI9L1bK56YhfpmUfnmpQmKMR5XFME7Db0MRhOIhkD/KmwtC
	YyTjOFDrq5r2wU2y0SenhUqYSiHC+5NlM806HHTjDIrNgqKRDO5UITovn+ta942CqodGB69rfX8
	pQHxFTCzaaAcndDUon+azdchWpa2uRjPKTFuZ4fjSQWY1zc0HB23uE18Oz8S3P+BwztzIDiaNO8
	j9YPlXh4ryNaRc/v55y5umQzqj9J9r9PQg
X-Google-Smtp-Source: AGHT+IEFyUt84N4Cv2kdLXAVUn+1e4FWCkv0k7DfQxCZiqDejVRSf4epoqkxZrOG2Uh7zwz0dBY6jw==
X-Received: by 2002:a17:907:7f1f:b0:afe:94d7:7283 with SMTP id a640c23a62f3a-b01083377eamr695696366b.32.1756729846177;
        Mon, 01 Sep 2025 05:30:46 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:45 -0700 (PDT)
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
Subject: [PATCH v5 07/12] parisc: constify mmap_upper_limit() parameter for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:23 +0200
Message-ID: <20250901123028.3383461-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index f852fe274abe..c2bbaef7e6b7 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(const struct rlimit *const rlim_stack)
 {
 	unsigned long stack_base;
 
-- 
2.47.2

