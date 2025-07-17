Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894C2FA628;
	Thu, 17 Jul 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762497; cv=none; b=huq1zcBGFeyGCzB+5fHvhQWeAxV4Lj1pBGecWb0FMKr8Kg/trabs/yMlAM1kf837RedgjQJ30dL0CWlWv1El3JvytgcBbz0dlpOxEeoUZZKm9Ui8qNko5s8fpQBDdE0MwfZQDWWzRMam20K1DnR8ET2/JWuIX1XA/jfhuVTBVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762497; c=relaxed/simple;
	bh=3Cytk+SVwc2NsgWIw0nESWZsARd8iImT7N+vVAOVWLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfrXCAvZOUHNVtzNMLQC9A7nR5IaRck+/8zcM4yE9PMaAeEV0b56fNj5gfMJPu2b4L0oG4kr5uLaU5rPB9dlEqUkvdWdxUQr4O4jJAHbDT3vxmJcrJomJX6Q//1ydo8J8nuyvO9BQSzJ5vKdLqEHczUPmIeDAZrIShk0P2C4hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oobq2/VZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oobq2/VZ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-556373661aaso939192e87.2;
        Thu, 17 Jul 2025 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762494; x=1753367294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwSPw6gFzDTyOsOkroA5OTCCxXe2CzpjscG8NASBaU4=;
        b=Oobq2/VZx5oQyi19m75Z9zFI4Ty/iuXHf4UMb9qKZ4HkBe6I0WlrGfBqRU+QCnuOTe
         ZzW0UOU4ALpAHeQtu8Lq/p8GTN0L0tdHoPiFIIQ2hdDkULHaVZVfRmNlbZyqBFK0JmhN
         3ipN+Gtzr05Hu6jHgAZ9kDOCUkTem2HywhE/kTI+RZUD2iLZ1UsGoeIE5wk9nNzYP7mC
         QKLq9f+7F9kDK8sU3kGNXqv8wqMgGG0PdBgujEGzatas/vHtSbuVRVKnyNbvJDpvzEEX
         jx8L5ol40GEoqbC0J3INEvmR699yU6AcikK3bJk5da4ek7WwSNkGkza/IxD7L2CkwIvN
         It7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762494; x=1753367294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwSPw6gFzDTyOsOkroA5OTCCxXe2CzpjscG8NASBaU4=;
        b=lY6nN+OduGuZWK0YtwWc5TUug+fyXt6rSG6z61FqNhzGzZDwpHB+6n8Sge3S790nmM
         TWDgBwkbnOVlEoitgBwRyVvSxatksRld3d7FcAtkd+4XAXhtAQjEGud8xbLBmYmwcLTQ
         x0ZMPSXdydoRQmUivPjENVXs7OSC1diI2J+yAt9hADCxZ0lU6x7ZtQSuh+VqvsM91/a8
         Lqo37Zi6yDnB7Q00SOBTGYN1sBAEGfa0R+gaDSVyJbGntkV6SHf2NhOHuRPaYG4njml9
         IueNF8agDRdk2OHYbAtxXbP+unefReoaiEz/EQt4IrNnMnZgO8gc8ix9LbaA24wrMsRw
         YQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWve3pQKzXY3Z7APFafXJ7i+QPvrDFXxImvGfImEiHTIMfX2spI+LNMEqiKuWf7S4TVLNeFFCv+X76/FIQ=@vger.kernel.org, AJvYcCX/slm0+RIevvdRoA56z6BHR7kJmItB2TPGigClZ30NyC/nmaGSwM9H4QYF0MIVGLD40R6FZkoX4ipt2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSKhCJkuzz7kidprwY/qZGfZtepkZhleKTp0gDeYgt3FP8Jm+
	OvDyEk9tpQP4VgHQy7XqiWtafVNBL7sP68N1B38/OCIJzRUQVryy0BDz
X-Gm-Gg: ASbGncutWbXmVYbKy4Mmp4JGlN8VTO7m95PS26cyyieqzdtWMtSAhop3PMfF+i/C2K6
	SiRDzTOPSp7AHKQcvpJ6eq7C3UY0WcCJ4MLjKMH3jZZS5ksA9zCPj1+d8g3kzFfe+KuV2YBpcdb
	JelSF6FbE6zsOhaKmDqab1ccU58TPCygA0QbA/NYHC5MyNe9LH1Ayd3px4n4KFJV2r4Mix4i08W
	G9mNevol2bGl4XMUpxsUJkDTyjBhNXpTATYm/MVZL00gYDLGB4lzbWKevoLAYREUP5rZqfaCULI
	f41oyZU/lMU4G+vQAfYOirXgibxScxrstWETiLXoNT0ASm4YD6wcVURY8oS7omcpgD8WkVjl5Jo
	D4XA7HNCK6oBqUacy6KLBjMeWNEA1ZWgOcsnxFpU0xuywXx17zT7UHCRMHqtEG9GCzhEK
X-Google-Smtp-Source: AGHT+IFV4/fgUWSLQ9HeTYD1ZNc8U4khjXBXPUvRtZGAA8fcpyT35FlSXgJszoiLVDo7d7offe3D+A==
X-Received: by 2002:a05:6512:3710:b0:554:f74b:78c1 with SMTP id 2adb3069b0e04-55a233db3famr2128904e87.43.1752762493542;
        Thu, 17 Jul 2025 07:28:13 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:12 -0700 (PDT)
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
Subject: [PATCH v3 10/12] kasan/s390: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:30 +0500
Message-Id: <20250717142732.292822-11-snovitoll@gmail.com>
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
and prints the banner. Since s390 doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

s390 sets up KASAN mappings in the decompressor and can run with KASAN
enabled from very early, so it doesn't need runtime control.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 54cf0923050..7ada1324f6a 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <asm/asm-extable.h>
 #include <linux/memblock.h>
+#include <linux/kasan.h>
 #include <asm/access-regs.h>
 #include <asm/asm-offsets.h>
 #include <asm/machine.h>
@@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
 {
 #ifdef CONFIG_KASAN
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 #endif
 }
 
-- 
2.34.1

