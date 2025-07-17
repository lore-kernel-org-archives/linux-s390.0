Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AF2F85C2;
	Thu, 17 Jul 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762468; cv=none; b=Rn07AXIBMqmhRv3T3Yy2k+gb+2SliYMC1GBoeqbF+g+CRnDaKtJjYs1qnWqMvvtSUzilDujqAYfRwjs8So5k24F8gpPAQyzyIq4SEjuL59ECMJyAiWIyr9ofISLMNxbqlwUSksuiGyMxNRVO6Quhkfc5UIStVQKpyhMwLDiiagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762468; c=relaxed/simple;
	bh=u5QXaPJcX4chKtk2OMOGLWnLjy+FfyCWJZqxtReexR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rk55Sqb5yQ2zCNI4vvPGkYefgmmzsOSZJvAXmmv2VDKylsvS/uOtmScoK1fCUH74bFstFOi+TXGNV+YwhJKl60i21aFBcoJxfrX2rG83htNtvVREg1SaxFnTMdVXm05OFua2j2TScJxdL30l6+BGjOMOvGLd9XLNH2r0iB14Ids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxJ0AKWx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxJ0AKWx"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5561d41fc96so1208516e87.1;
        Thu, 17 Jul 2025 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762464; x=1753367264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3WcQqYlZ+nGmkIZO7BZjNBhDOM5R3Ju7Hd0Z8GcHCU=;
        b=gxJ0AKWx0PJ/eR8udQ+kIz9x5NtG9rIhgGUT2Uc/HFMsiEspfekmm2tglOMOTUBtP3
         Us5nLeyjH41Q4TELlNvC1YBTcSgOE83dmZpc2ikkCPSbP6jb36hRytggmMXxQLdB0636
         Qcy709z7X3HWE8r/KYkyUf7HMOyYlt2xQ/N+YM3b0MKj47BLBw5rNMtyq/BkX/kugwrY
         JZIWQNrVuN/NyEmXcS8T+hUdYAwXld7S0/nTU5Uebfw49PomcdQ+/Dw7Z5JjH4wGDV9g
         ZD/0S0pkDYKOTihlVnW/SFAeUDqOKJRr6/rp7/mazoViMHtDxxL1K2+3H6+sxfcUpxDR
         8yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762464; x=1753367264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3WcQqYlZ+nGmkIZO7BZjNBhDOM5R3Ju7Hd0Z8GcHCU=;
        b=TIpudMeubLBzAYeN4wSI19JcE++Dm5eIvrkKV3BPa9RsPrBfkQhOmV2e6EGGMbc4gQ
         13j/tGhRGGtZ34uJeIH1iw5Wr+TYo/t9Ul/XBvEfypZqjtKWQFwBVzYplwUdXMZuX9Uw
         jIbP/i0f2mqNkoUCFBr5Ou0fLBBVixUKWdcKplmjnDxZsQANcNKvRCbcGTpfBnKOfdhU
         RUSkl4r34eYJo2VtOSgD5O2aBEc8BT+ZjuAYdd+BgDqIZjz/Z41fuqrB54NTRtAcfvIJ
         YrfzOmQTfxDxhEyWY9JhkaIsiTmxucaOpOa2ZwYoDl7LHCGUYc30PyuHczyhdF18JfNi
         4Taw==
X-Forwarded-Encrypted: i=1; AJvYcCWKnCLO7zIMF/WxxktOb3ja3MP/6Q1mvGCKl5M5xI1eIhBMpX2cTNjppWDDq1c4amWfWLbRnEeo3PnxqAo=@vger.kernel.org, AJvYcCXydHm24MFIsAMJYBx0zfKhqHQNISwCgqA1Pbx5AmW0axJM8zjWyMkiVnl0vT5agWinvjfhuqOgf67J8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+IALKmrRotNZLHRL1oOpeQGK0yNVr4Qoyvd1sjmv5Hj/7cp0
	iVLRR3Frbcr1TLQQxn/KaZO69x8vWeWodMhsxvDBkigcZjgu9uETY1sK
X-Gm-Gg: ASbGnculETvS60ldyx5EeS6D1VuXCxMmztlDq11v3Ryi8zYcoiKRw7I8ADB1MQo9dbH
	S8KB2KXzzNiDWUt6VWwGnvOtVvqED4Z9c8hkKI64bZlEc8dRcD0hEtWQHTha2PujWS/UwfnVKwu
	UNBJ3POLEthien6hIhHPV5ODXMkNliXBp3Y+osoAwq3nP4uQ3ZHQUhoo6Pdb1eanuxp4hEzHQKc
	/juKIQhpdSEHLysSGE3zT3WmqgxQduJfK/ZGi6TMvnmz7KxJSlHBHQIcusv/4nZPaFzrVZtDvlB
	KVbklLewlccNgWiDTLTfsCCc1E8GWp95hk9HrGWkPp92cuc27SnMklsxbsXKfWmXZMcCYenP/uA
	LFixCkijgMy5m08vqzydNGoWzUJN0fyogwPlX0LNzv0vHSYQ45hTaJVuB2oIHpIXEehKp
X-Google-Smtp-Source: AGHT+IF/OloHnnX3mhASN203Qn491wmneqjv+U28AgmKB7HhI1lYsnMn0p3m12S3GUHmxAKLZ2vT4A==
X-Received: by 2002:a05:6512:15a9:b0:553:2421:f5e3 with SMTP id 2adb3069b0e04-55a23f1f963mr2211249e87.19.1752762463801;
        Thu, 17 Jul 2025 07:27:43 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:42 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN option
Date: Thu, 17 Jul 2025 19:27:21 +0500
Message-Id: <20250717142732.292822-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
to defer KASAN initialization until shadow memory is properly set up.

Some architectures (like PowerPC with radix MMU) need to set up their
shadow memory mappings before KASAN can be safely enabled, while others
(like s390, x86, arm) can enable KASAN much earlier or even from the
beginning.

This option allows us to:
1. Use static keys only where needed (avoiding overhead)
2. Use compile-time constants for arch that don't need runtime checks
3. Maintain optimal performance for both scenarios

Architectures that need deferred KASAN should select this option.
Architectures that can enable KASAN early will get compile-time
optimizations instead of runtime checks.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Introduced CONFIG_ARCH_DEFER_KASAN to control static key usage
---
 lib/Kconfig.kasan | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index f82889a830f..38456560c85 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -19,6 +19,14 @@ config ARCH_DISABLE_KASAN_INLINE
 	  Disables both inline and stack instrumentation. Selected by
 	  architectures that do not support these instrumentation types.
 
+config ARCH_DEFER_KASAN
+	bool
+	help
+	  Architectures should select this if they need to defer KASAN
+	  initialization until shadow memory is properly set up. This
+	  enables runtime control via static keys. Otherwise, KASAN uses
+	  compile-time constants for better performance.
+
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
-- 
2.34.1

