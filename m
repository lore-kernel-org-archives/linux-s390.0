Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D542F94A5;
	Thu, 17 Jul 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762494; cv=none; b=raAPbikr2t1mVTWwKwsz4e3TOqo+4ar80VTcAc5NL2nDe4OSOGJ6YQd06eJIHoBPSOTXtkUeISEVMme5/tSiAqaf+Vqdiqrxe8nzDenRQD0G/HAirKBX2NqJmh0NeKRfCrzWOSs1yropbnP2yFo3P7GuTsuWwzCwm4LhboI1vDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762494; c=relaxed/simple;
	bh=Xk0SjVcNNZnQp2HkpSSqHyE9VWiAO/AKIvYCRFHkldY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QMASVaeh6PQIB4lF6r/ezRv0Y72kOVtueHL7bBlO69hj8PEWuvBWi8Sar0EALHYbQfapNb9KFEr0BCU1+/MAIyHkvxlawo/iV0XfbgXM/2iLJWJircPbhIkQk29jxXYiZIlWrVKFbq33Iz+S6LaFEdiOrcwtRxEMfNewt/ALCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+MXLsw4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+MXLsw4"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553b5165cf5so1236721e87.0;
        Thu, 17 Jul 2025 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762491; x=1753367291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=a+MXLsw4314P/gl/rCzHa/Wy4ocdsf4ZVrWu2TCcVWvOnZZMTz7RtkjHH4EMjg1Hq0
         klqJusf44iBz+Pe6VHrZ4k1wjVdt87DfhWcxpoGG5KxTsiarbG9Al+/CfMMAH4D5Hb+v
         kbuDk24Uyr9Kyho9L/h8tW3CiCl24Fl3GN98NHNbV9AG79eOkVAuNhc+iUAdjTzGTklh
         IH7/v8d2WbEtj34gYLhAXEOho31ZhD9vjg+LFO4TisbX3hpOnK05O9gMjVzB7ajtR6WH
         7HwBKg2nS/B1diPW0XJtXwkUcjeGOkMKAHtbRpXuOQ9t20Q9OosJ3A/xmjORoFGz2QeT
         Bwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762491; x=1753367291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=WqS2G/qrXvR6uSqixfIx4rmaXBv0N1LqrwXSXZB3KkSbqfMJD8hQFD+zrK3YCBj/ej
         kI+TSUCgYMeTZZMFOeMZ8/MxpELKJIxCnF2pz22SbBVkShKbSsMfXYrGm/T2uQvjQ9e2
         izXE0RBYGAMKBfSvR6/nRGcgABgWi5PDPwQlE9q8hPXPuqqYA7BQUESKJdPW+aS2Da0U
         2twY3DYCRyhxlQ76G2D8eh/qrPgUSGNBVh4zJhEEF4QZztb2+O0OSzM4kF8ldailBSoX
         DL8Q4XCt9FcCD5XmGvp5x8T+Lekhk3zO/NSxB5C56KVz0u6rfKWNeZLtRXoQHZ8jKj8K
         T5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSt08Q1/BqrVPoVLG2ISWcLyMMoxXKrEF1fiwPf9O1D45C5fYYu7iSkaJ3t4GaWd1jTXTUNKbkmMKzEQ==@vger.kernel.org, AJvYcCXWsQxzhMWDgKVarAb5Xyj0y+JiABTnNTUxl8urBlageQo2zgnzyniQ8cewcGzpmqUuYePAMixYSyxd/jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4Qd8GcvWL5J+MVvGcBKD7216oO8I895lEN/sp9NB+gJaJYlq
	aNwhSgBrIl2wkKXEOHn7QREsivaWsDDwap21RNGtkpmAdXYKce97jehV
X-Gm-Gg: ASbGnctfTPRitOMF183NG9cDm/fZdYbndHESirsIOVxQcuEySJmC++Wx+4aO+tGxten
	bmg/YE0kcE9xsLl2AnmFRl7ouCZXUGOJWgTq6eAKV84hrqRBCWYpHoNTkq/nVz9UfTNbHcfWBCU
	T2FwXgXl0Pm0bISu0UxM+8OIk3haewwPkDtswwQSOiYTnsDcOUNoPcy6mgWZ+7JX2dSLvhpEKPp
	SKj2kLlbGpKo2q5lsKvXsyuVIOZyzi6ErpWkBfDkL+vZe3DxFGZgDXqxZdh4Xhoudg1QQ9gCTdR
	hftRhyP3BI6JB7dAQGqb93qHnbJrCpiCJ/xK7iIvNbbnM2ufuhypd90XBvzKAw7aendmdiJaWVH
	WQT98dG5G5qObTGDapKTkaFIkuFObZgmV9qkZMa8BnZUtiVLI5PIw5Cml8lWqBRxt5JDv
X-Google-Smtp-Source: AGHT+IHDhctOdPCboINtKeXrLTUszqbBiUuSpXqwZ8iJGfUdyizY8inGgvaZnyh7hxTvzKTa8fgC6w==
X-Received: by 2002:a05:6512:618:20b0:553:23f9:bb37 with SMTP id 2adb3069b0e04-55a233b2fbemr1641277e87.40.1752762490421;
        Thu, 17 Jul 2025 07:28:10 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:09 -0700 (PDT)
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
Subject: [PATCH v3 09/12] kasan/x86: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:29 +0500
Message-Id: <20250717142732.292822-10-snovitoll@gmail.com>
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

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since x86 doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/x86/mm/kasan_init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d21..998b6010d6d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1

