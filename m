Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920829;
	b=wsxlbuqXsnYTirY6REbZ0EUBzVqo40t0ixh8AmRNB/aHeysQaFKDsf687BhDcS/3ya78
	 sLCoSrQ0VbQaH5PNFYNLiZYhczQfGwMNYrAPm2d+8bIfyG9paPsvUHTBtifOGqwcNjkJS
	 i1sR3Z/wEPos3jq3JcR9A1TBxA7Dax70o+VrsKcszKcIwPJEEVzHo6OIxzsYMD9AaXHmP
	 AWEksT07b8aAYPGq33n5ZK2bbEXBsfCbdOIP0T3Kq4rtRRzctNl0alcMq/D2kY3hvlrzt
	 Zyif9soqJEmjGUMn0ZXy3uatV3n9GVnDp4ZlQ073wpnupOQWIw+d3btWPS6D1gY+JnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920829;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Sf0tw5Hzfh3MRdcLooWrdAMwONcFNvSwRTlvWrvAbYM=;
	b=XuTPdjhcqgD4GhaFI10jygDLTWq/6Wcj4dyjelS0i6KZUJUUMtjjVzWsi0k9eMgeBmPv
	 rhWhPmXIGiahh+BFolBaW90HkSUUpMQZf43wadlvae/ElARrsapCZrtnGMM1ATptCw/1F
	 8m0A5FmDl8/ouwhIS33HLO1UITm1eOrk/l2rvJbiLMLI/SO7S5Bz5TRquVz2t5sx5sF81
	 4JRP2bJ5wBUL66JYJjas4uHrJkD4RAweZU80D23WK9fdwIIG2Tw9GmIjgS+dCqrQARdFa
	 opsvMV9C385l2MhifGsM45yp3zgt/Oj+tBGlThck/ZBDu2fIRWt6XKpXmpQAs5TlGjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6z23Cd0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923060A383B;
	Tue, 17 Nov 2026 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6z23Cd0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF20F1F00931;
	Tue, 17 Nov 2026 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920829;
	bh=Sf0tw5Hzfh3MRdcLooWrdAMwONcFNvSwRTlvWrvAbYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V6z23Cd0SJZbooN8G5fOj/b/BTpXkTVqX+fQUHxSlAmC6rsA7Rzn2ugBrlbJOHFla
	 1KLL4QHDjdXNt5edXeipJBCKMsH4TaNtwkYz8CvJmt/xNneZ++JAzJ6tvpzOb1rjiv
	 TyL2eC5VpBgm2RouprWBinn6FfpxhpzfCYiSQS54w/eqhPACbzAE7quC8llXCb/UsJ
	 Vf6ne84k2aGHqwiBgXiM6HoxJ/9PHjkElFsjFT6kSeAmp1QLSdOX/0KUCk8XBR8Zcg
	 L5kF0SZXau6+S0FCAEIz4Fx0ZMY2ZRmtMBiN6MYdLiEAFUzITOrqa8kFaMg06VH7eO
	 Nd1Uq9S9OCrdA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:06:55 +0200
Subject: [PATCH v2 03/14] s390/sclp_pci: Replace get_zeroed_page() with
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
Message-Id: <20261117-s390-sclp-ready-v2-3-e518c99622c6@kernel.org>
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

do_pci_configure() and sclp_pci_report() allocate the SCCBs used to
(de)configure a PCI function and to report PCI errors to the SCLP.

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
 drivers/s390/char/sclp_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
index b79ef7006e46..9e3d4b101535 100644
--- a/drivers/s390/char/sclp_pci.c
+++ b/drivers/s390/char/sclp_pci.c
@@ -44,7 +44,7 @@ static int do_pci_configure(sclp_cmdw_t cmd, u32 fid)
 	if (!SCLP_HAS_PCI_RECONFIG)
 		return -EOPNOTSUPP;
 
-	sccb = (struct pci_cfg_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 
@@ -65,7 +65,7 @@ static int do_pci_configure(sclp_cmdw_t cmd, u32 fid)
 		break;
 	}
 out:
-	free_page((unsigned long) sccb);
+	kfree(sccb);
 	return rc;
 }
 
@@ -134,7 +134,7 @@ int sclp_pci_report(struct zpci_report_error_header *report, u32 fh, u32 fid)
 		goto out_unregister;
 	}
 
-	sccb = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb) {
 		ret = -ENOMEM;
 		goto out_unregister;
@@ -177,7 +177,7 @@ int sclp_pci_report(struct zpci_report_error_header *report, u32 fh, u32 fid)
 	}
 
 out_free_req:
-	free_page((unsigned long) sccb);
+	kfree(sccb);
 out_unregister:
 	sclp_unregister(&sclp_pci_event);
 out_unlock:

-- 
2.53.0

