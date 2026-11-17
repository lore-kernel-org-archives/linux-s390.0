Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920835;
	b=KpQRoKzRQdv3pLnVc/PN+Ut9k/j68W8CVtl/6jk6bgsOpx0Hy7oGFIlINsz8sqLft30M
	 /amT1O2NVlxfX1wvsYBQakAjgdX2vI7D8eKMzw3H2qCtHz8bIiqBw8hNZg2ag3asgpiHO
	 GZtjdKAb5OGiCXHIiNQxHwXi5ZQBgODXUSqf5vd/iMQjETWUAW+6OokuksT397zQbfEDr
	 8Jh4CU2uH/VBqbrmRHLSaSKz6OEZfPr/3P0I47XCf9tylD9GlkIKgNN3RgiG0Bpx39uKP
	 mQ8EDHaH6dpFvoFfb/3/T5N8aG+cX+vz4IwL4tE1Twcqzj2lIClbHnGEosdmldaAAPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920835;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=dN106rk8Vda8DnkqLVSw3/dUsMv4evAL87wVFveXVvU=;
	b=vIJuVmeNCv7v24lKSGyskUQRfJ2z00lINsrwFGo3wDhPt7x/wHknaaZC2am6QjNPuzWO
	 fZkjNOKh/OzpfgxMzvTU8u7NcD6VTLa0oyHWISVegOWzCs3sy8rgXdISPBtVjVnhqS7Rm
	 GyQTT5S1uAn1FsQJI1ifQ3IfJg6Er65oHi1S9mMIMYENIIJAqlAMvi59B2MeCOUHiOibs
	 UJV0MB5lSlkKG42r3F3wMFMSXybzXn3Yzv+q/G4JDUibhlXE5RQWjVEwAzuIa1DDSoWGF
	 fgexpX15FdnyurOlPb+mdk8NMoae/yppsQdCA+5Q5R1v9zb3Ve5nTjZGVUzZyWOE++w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+q6aiil;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C660A261D;
	Tue, 17 Nov 2026 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+q6aiil
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE0D1F000D4;
	Tue, 17 Nov 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920835;
	bh=dN106rk8Vda8DnkqLVSw3/dUsMv4evAL87wVFveXVvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G+q6aiilbCrJFplxMnAJ4ox9tGFe2v6WCRwfe/GAzx9B/vXRwxgva9X41ZySvPIXL
	 spq8zdgFwNFFSC6ql8lExGA+vhl3r8cYdu7bwv80ZyQYjQdANfrJNT83gfAMYkZmYf
	 IhgJ1vjFd6XRsKs/+OVnrwUK21h42O+gTpHFHRyE1lc4bd++PuIH26QW/xhWG1U+50
	 rEMx++GA2wc5XTnItlcHUs/NJM01DmPVTrgKUbAWuT5ji8oV2W8MegdQ8maha1lVqk
	 /DXq0t062EFzcG7m7JCWIQLvXpIQC66dd/1bbIm3nn0GIxIHD+ha8F9Bwbs4oea5Ij
	 vL6ZgzGauQpJg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:06:57 +0200
Subject: [PATCH v2 05/14] s390/sclp_con: Replace get_zeroed_page() with
 kzalloc()
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
Message-Id: <20261117-s390-sclp-ready-v2-5-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
In-Reply-To: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

sclp_console_init() allocates the SCCBs that are used as the output
buffers of the SCLP line mode console.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_con.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index d8544c485808..9d096d7b5968 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kmod.h>
+#include <linux/slab.h>
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/panic_notifier.h>
@@ -272,7 +273,7 @@ static void __init __sclp_console_free_pages(void)
 
 	list_for_each_safe(page, p, &sclp_con_pages) {
 		list_del(page);
-		free_page((unsigned long)page);
+		kfree(page);
 	}
 }
 
@@ -294,7 +295,7 @@ sclp_console_init(void)
 		return rc;
 	/* Allocate pages for output buffering */
 	for (i = 0; i < sclp_console_pages; i++) {
-		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (!page) {
 			__sclp_console_free_pages();
 			return -ENOMEM;

-- 
2.53.0

