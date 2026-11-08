Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127748;
	b=rvhSCWImbhVVF06bOiJ/48HdMc9UgzajcqbK9Nz1sUYk8lce3joala9MfMaae2mOyTKy
	 b+Qzk89VPeg55TnYcgpn+PAW5x8JXKR7vCA+dUAqgdAdkBXpFcBJDE7i786HGfslhTUJM
	 SoMAO0N+9dqArxKLBPbu9TgGi7ksqaaofwLw7erJedXTltgmscO+EA3y5y9a0xQ05qecL
	 6/t66P+sICRbeOUduV1yi1kSTX13mAGeh3ot5F0PXeDsiOme2EhUGyoAJ4Djo4WIirCci
	 EUitJFPglDKCx2+4XvsS2AsBo92wmklYycR7lLs5Mk6aLE1XP6CQACjD3InTV5Nt3Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127748;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=9vCF5k78rkiAQGJjEpE8px/2xJwLOSb14zi+Ub19SbU=;
	b=MH1P8XWEYgO5OOhxVksUC39kBNTDoXUSw6CAYSc0C1c0LZJNp08K2CvphR1SztLpqBKV
	 cJBUTS4XwI95MGdeHMcTRjVMra8d5/oIJBT1FNY7yvVR+GAu3FbwmcInzaOdWK/pUx2Gy
	 IC9oj+9aGg0IyczyKrN3QAZ5V517jqF30dN4yB9pgjvwXKGTMKM7HFBl8bCra60O5vtGv
	 hRukG4oY/8XkQJDNLAzhZg3L66U7s6RZAeaqvZXDIfpXRMRNtwhIjTgR1HG5hX7a2ClJT
	 XMXEXKqzV7g8yFCIYW5HYb2CHwseJ8XGtd7IrV5iQQKqRBSKpkP/npyCYoOGoxvsfug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7sKL3ij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93F606A323;
	Sun,  8 Nov 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7sKL3ij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E151F008A1;
	Sun,  8 Nov 2026 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127748;
	bh=9vCF5k78rkiAQGJjEpE8px/2xJwLOSb14zi+Ub19SbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m7sKL3ijuMxiCN4KBljYFZ4jfDx+8OwrmAzhjpzdOxERJ5fhUwGeGoaN28nsVVx5d
	 M0Gh1a7ABrwYOrUh4ZIFHfUnB6vPmYrVaRa5nghTSf8i3sHnwHIJ4LjFFQVYGlDPXk
	 A1AiuYKdUw/GULPXZfb69YhWrQxyrgQnPCthHkx53FdjGQjvHHjdu5MmR540QVQDuU
	 i93q1Pl3aWsLWnRCWcsXaQiyaH/uFIBGb8QoNm7qyL93gBF+4kVRkE7fygLRGnjDsL
	 gWN4tne3+Fx9t0iQ7SONlmf7NJHPquOjLTfOpWexeJOkxxvyf9WBCwtCsLW8ZUfWV6
	 zKDeEbDYvKruQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:48:58 +0200
Subject: [PATCH 1/5] s390/zcore: Replace __get_free_page() with kmalloc()
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-s390-char-ready-v1-1-3db507722530@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
In-Reply-To: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

zcore_reipl_init() allocates buffers that keep a copy of the IPL block
and of the OS info structure of the crashed system.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/zcore.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 1ab7400a3c10f..92e31a8a7f242 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -224,7 +224,7 @@ static int __init zcore_reipl_init(void)
 		return rc;
 	if (ipib_info.ipib == 0)
 		return 0;
-	zcore_ipl_block = (void *) __get_free_page(GFP_KERNEL);
+	zcore_ipl_block = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!zcore_ipl_block)
 		return -ENOMEM;
 	if (ipib_info.ipib < sclp.hsa_size)
@@ -235,7 +235,7 @@ static int __init zcore_reipl_init(void)
 	if (rc || (__force u32)csum_partial(zcore_ipl_block, zcore_ipl_block->hdr.len, 0) !=
 	    ipib_info.checksum) {
 		TRACE("Checksum does not match\n");
-		free_page((unsigned long) zcore_ipl_block);
+		kfree(zcore_ipl_block);
 		zcore_ipl_block = NULL;
 	}
 	/*
@@ -244,7 +244,7 @@ static int __init zcore_reipl_init(void)
 	 * to continue dump processing, considering that os_info could be
 	 * corrupted on the panicked system.
 	 */
-	os_info = (void *)__get_free_page(GFP_KERNEL);
+	os_info = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!os_info)
 		return -ENOMEM;
 	rc = memcpy_hsa_kernel(&os_info_addr, __LC_OS_INFO, sizeof(os_info_addr));
@@ -266,7 +266,7 @@ static int __init zcore_reipl_init(void)
 			os_info_flags = 0;
 	}
 out:
-	free_page((unsigned long)os_info);
+	kfree(os_info);
 	return 0;
 }
 

-- 
2.53.0

