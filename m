Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290ED3148C2;
	Tue, 26 May 2026 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790885; cv=none; b=anC6/VM54yPXI8Uww2igixz1eR2vWlO+hFNWaCQVyb0EuFAkRGMi89rkSkFTz9xjP+FckYPHcb1nYOMDeWXARSIj8E1VDpss624MVfHk8ESDv5xW73W1v0+2Bt7eMDCVFnOTaAEfrTZ1dwrvddHEd4MRP0iZfD3mtieJOXIbQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790885; c=relaxed/simple;
	bh=EpQzeMV/x2ods87W99ZE1P9SHySUDX03MF+mltv4iSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkSQA7qWOvqhk+n4RNYv1gAo6SEG6fF3SHQmehDgY3cFnMDejYtSiqV1xBIgPUSeQuGTsoB2ZXCAXlnCFkadn+auYL3NesbFc4tw2Yz5bF8UQ5rkmzzs4puwSzQC2JI8PNmBxs2LU4LGrWrxtChT2OYvq0A8ynVoDNgR+XdyOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhUZflDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhUZflDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9F81F000E9;
	Tue, 26 May 2026 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790883;
	bh=a39oOFKp/uc4IEjdrZ5F1Fb9xJpEGl0BsmYzQBNxpiI=;
	h=From:To:Cc:Subject:Date;
	b=mhUZflDY5tbi1Xb88FHWIen2IUjZG7sjobZtf0v74pJyvXGbgiTO75pwtUzQAe0lb
	 vuIaJkfuWtPfJBotz8Q8I8YI66tE9qdSzOFbO5vm8jpFAHCmSSIVQvqa0QTKDdW5JG
	 cWFARbWzEMlKIXkhq5gwAqiFjGHTZq4z/2lyhJIf2qzvot+74sDt+ABnktn0ioQAsW
	 FQWoJLjD4ypUIJj8l+Dau2qJnNQDAKuvysLyZa2JCn3s36M30+V/7k/vd/iCC5uzrr
	 vuk6kMiyOdCYIM9uN+vRX/UmK7+IMq2hEo0SKI4bApG5FyUg9VpUiPJkRmBl+zdc/6
	 ljTfX9L2zfDpw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Davis <afd@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] s390: export memory encryption helper functions
Date: Tue, 26 May 2026 12:20:37 +0200
Message-Id: <20260526102113.2594501-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The set_memory_encrypted/set_memory_decrypted functions are exported
on x86 and arm64 but not on s390, which leads to a new build failure
because they are now used in a loadable module:

ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!

Export these the same way we do on the other architectures.

Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f07168a0d3dd..d589c5e4d388 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -124,6 +124,7 @@ int set_memory_encrypted(unsigned long vaddr, int numpages)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long vaddr, int numpages)
 {
@@ -135,6 +136,7 @@ int set_memory_decrypted(unsigned long vaddr, int numpages)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_decrypted);
 
 /* are we a protected virtualization guest? */
 bool force_dma_unencrypted(struct device *dev)
-- 
2.39.5

