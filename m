Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A115ECC5
	for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824223; cv=none; b=Rg/g+ba1QKqvRJSFuH4jCMmLUVUme2CENSMB40B/Pm2thEhk1OFcX+hMq2MyHWfncvxhHkH2g9nwnkIS5wQ2H3+QSnIrvCUhPew1AiiKFpXK3zuLz58eu2lfD2xbZOOO4263yRLPGmxgg5osnEsWSSUT2Yu3n5emp3H8LyqmAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824223; c=relaxed/simple;
	bh=bFLw7L4BlwG3KLICmNgvPIAvf1/5Sm3GeWEQAkx1eJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eH81IzL28JfQ2rGQqMs6eJn8FXLFz5nTWg9uOGxXul3xgRyCkW6VXrjDQfZZlNRuzQ02Jg0vc+82CH9WHxrnpcU2wzShzuPLf4+8mw/GoOaIcWQpo/X+sgs27gkD20byJ3RWMmx9Xs0GSrZ+GwxoSnJfyxVAH7L/dG7PPp5SHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sxDFGbVG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sxDFGbVG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2021c08b95cso2125755ad.0
        for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2024 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824221; x=1725429021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1bnpMYTna27bSqlaeNn9zMkLMdTuL1lgzvNhNTdiTs=;
        b=sxDFGbVGjoz0x7IjUj+0+lr/jueiOzguOCsO9ZcVBLFlrqxx6t5LqRwtT0W+HYL7sK
         fbsyxy6Wmao623MRZ5O9KbFsLvl549QiOue33YER2YeTYwgESZe6vk3DPekCtbRqvXz4
         VS1hIcYPDSDHv6LzWmvXvYsgNVRnZ8mXg+tWj0BGX1RA41O8hN4d5VeOreNdbPYaEcIu
         PJU4cJrbRhvhwaan7rl3lCJ6UW8aFGjW8lt2wJwIElP1ZK0lwB9uXng4KQrOuusm+Dtb
         Aq4AWx/H9WJ+e6aUo/lp6Sigd535qnZtiEdanT7dgnUbMKoa/MbwY2abJqE0B+v9QwOC
         LRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824221; x=1725429021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1bnpMYTna27bSqlaeNn9zMkLMdTuL1lgzvNhNTdiTs=;
        b=KKKgAnw0nUit9jotg9u1T7QomV3QhAabQmkXzLfO0x19bazbLxF9cMBOeRXsxqmvXI
         LgTNDdJCQZ5Es4k3+/luW+9QcC11nzXBXDz7eAsnlDeH14h9BBhXgxJ0IXyFLb3B8TcQ
         ftJpDdEpmax4Ks1y5l7+eZzNBI9O573blM+rNhoQ2UAchFeKmKFW6OnnihK8EMg0AwCL
         XuZYcDykmk6O4+pI6RRYnKszkyfFV1UgoTKB4dxXLWgCfFRTgh8oDEmgNo5V3/upRwsl
         J1pOwtG4IPArdW+V4/ALbVX/7qxHpwpch3K9ZqR2zW8B6wAw8YgIZrgsLVo+i5cjhUXY
         MQzg==
X-Forwarded-Encrypted: i=1; AJvYcCXnqLyPL92Ohd4jFtwm84aZTQKb4FtIXVaPgv9jbWl+WxK2LXQep3V6aJb7l+Wi1YtP/DNmQrz1CDQu@vger.kernel.org
X-Gm-Message-State: AOJu0YwcuhdBYRRxVOGALqbgh8VBNfzZq8L/8g2hsv8FHCEsDzoxur+e
	pbSeEkNfS234TS/dH8wMbtDnz9B4JMBM1aGNRCzEYfkv0/Tq2pJ5jhpW6A3R9PU=
X-Google-Smtp-Source: AGHT+IGQeeMMIWRhlzvEY447u73v0bcDYqggMB4NKbY4CT7iyrW8LbpZG4Gsc+7GkkDRX2iCA5iJHw==
X-Received: by 2002:a17:903:35d0:b0:1fc:41c0:7a82 with SMTP id d9443c01a7336-204f9912733mr19656305ad.0.1724824220864;
        Tue, 27 Aug 2024 22:50:20 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:50:20 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:22 -0700
Subject: [PATCH 16/16] selftests/mm: Create MAP_BELOW_HINT test
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-16-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=bFLw7L4BlwG3KLICmNgvPIAvf1/5Sm3GeWEQAkx1eJA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XYnPPfbbPo8yeWL66+yxo/N6BS8nd1/7qNQhsOWpf
 3tQ+KzTHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEzkdAYjwwau79apS3QeSJmm
 67cdPe+1+9TsAsXmhc0Xrt4+G6VRe5aR4ekEGZPT2yyYhB/f/i4QYfZn696jodpGS1YWP+X48/d
 dEQMA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add a selftest for MAP_BELOW_HINT that maps until it runs out of space
below the hint address.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/mm/Makefile         |  1 +
 tools/testing/selftests/mm/map_below_hint.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index cfad627e8d94..4e2de85267b5 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -50,6 +50,7 @@ TEST_GEN_FILES += hugepage-shm
 TEST_GEN_FILES += hugepage-vmemmap
 TEST_GEN_FILES += khugepaged
 TEST_GEN_FILES += madv_populate
+TEST_GEN_FILES += map_below_hint
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
diff --git a/tools/testing/selftests/mm/map_below_hint.c b/tools/testing/selftests/mm/map_below_hint.c
new file mode 100644
index 000000000000..305274c5af49
--- /dev/null
+++ b/tools/testing/selftests/mm/map_below_hint.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the MAP_BELOW_HINT mmap flag.
+ */
+#include <sys/mman.h>
+#include "../kselftest.h"
+
+#define ADDR 0x1000000UL
+#define LENGTH (ADDR / 100)
+
+#define MAP_BELOW_HINT	  0x8000000	/* Not defined in all libc */
+
+/*
+ * Map memory with MAP_BELOW_HINT until no memory left. Ensure that all returned
+ * addresses are below the hint.
+ */
+int main(int argc, char **argv)
+{
+	void *addr;
+
+	do {
+		addr = mmap((void *)ADDR, LENGTH, MAP_ANONYMOUS, MAP_BELOW_HINT, -1, 0);
+	} while (addr == MAP_FAILED && (unsigned long)addr <= ADDR);
+
+	if (addr != MAP_FAILED && (unsigned long)addr > ADDR)
+		ksft_exit_fail_msg("mmap returned address above hint with MAP_BELOW_HINT\n");
+
+	ksft_test_result_pass("MAP_BELOW_HINT works\n");
+}

-- 
2.45.0

