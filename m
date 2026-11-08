Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128672;
	b=0oYmUskVSK7NIcCY3kSiLgEkOzR1esWovl8jt6VDCOuNonyvpHGcxBZ3q+R2dwkl40Vh
	 tBAnKkHiLVmKr30GLKAoPL71GGNZb3hNtfTHrMn58S0MJodOO5dBZsyTmdRPp3tBWE//b
	 xjR8Vl7rzrxFswC2VFZ2VblKS4TxMK0Nin+MxwYqNBNy0+JlWP0iUOQyeyR1pY2ErKbbz
	 qie2xeddGgX98NcMSIrjzMlSEtQW+ckeSuasxW5JgEkyDsyq3p+MIwN9hFLzjDzYTJDee
	 LQUqU3xubdRsxTe0AgomtxhSRiB2hkLHpSz0uv8y1QL2kqQRoXFqrZX1U3Pav1+Vj1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128672;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=1OKxj+jZn3tttfq9U6e6lzT17ukOWVUXm62oh5PZV8w=;
	b=3LYTxxZXZI3/O7ZFeDB1gCIm0yR3SuyQ2ztT9eJ8kZQCVJAejMRZimk42tQ9P9Y5s0KZ
	 Gag8dLuCtST9Zveb0PWE/s9uj3WxH+nIT4WIsVVeDZGFDnAWmU8J7ixqtO+r5I6LjdPZ7
	 dIhMLRJUf/X7t/H7gYAkc2Cd0o09XuIvdXx8lLwkV8QqvBVOzJdAkXnSLeCrt5fckVHMm
	 3NONB4WUAIah0Bf3Os++KnexPCCvERKQTsvl57XU9rTsfnW5qAWFko/4SyYbIH5kouNo4
	 Al6IO8SQ8DytpgMAWv0GVgTcs/TJ2j0eavkNH1PPrYYy3fIQoTIY6XpRcBeVmg/sNRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZWEYrvV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10E606A31C;
	Sun,  8 Nov 2026 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZWEYrvV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5945D1F008A3;
	Sun,  8 Nov 2026 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128671;
	bh=1OKxj+jZn3tttfq9U6e6lzT17ukOWVUXm62oh5PZV8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kZWEYrvV7d5iUUnLUXeW+MxNjndjmOabN92/4q7nAjeB3q/XUK7amoJgLiY0aMN3o
	 n622W1TS6wCjmB36bNGvxNIPyvfrvaHZzu93sBO2eNrJJwObUY35JZZOqI5FNOIwqb
	 CHjO36iGGIt7Fg3hBFFgvyzu9xwPR0XxuRQVjCDFdNdOvaqyI/QlioozQU6/m6MqNz
	 VrCE0pFTuvOa4G8+O3sU2H3uh6kZ6tj2It4TijtyS8LhyR01jzLLqLIi1LIuJm37Te
	 KbNJRR3aHt479eacCmqopgXMfp/EU7uMI4mn9HCJtga5Smd9VVU8IobGcEJm1dLZTl
	 bfIRo/sK+ouFw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:34 +0200
Subject: [PATCH 03/14] s390/sclp_pci: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-3-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
In-Reply-To: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
index b79ef7006e46f..9e3d4b1015357 100644
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

