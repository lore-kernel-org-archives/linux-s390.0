Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128706;
	b=O8LL2tyQD10/0IA8YbfhT7yKQ2zc2goLHxoBDqlSfJKl1JdExSbnGJVus/AhIxKzS4EQ
	 ksvNr8xHUUQQicraMANVbhNH5o+ybFhls3hKOKbMN1LJl2e8WIcva23kxc8PZCBDJwFLy
	 GivApzKY5Zni7Rph+nQr0hNSv79RV6po8D0MIPqrme7jU9jUv4KH/jGQ7D9UjUlVvsiWt
	 YZHSJpBVr+jDh6xhAKegS/tL4sKZMVcrMCe+72KIq39ASooOQxQX37hmCoIouL2xTntFC
	 ECbrKoo50bGkQga+le5d2lftHl+fkYoLwLcCTVt1zEzE0XpwVz4g1QHTSXdGhLqODpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128706;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=MlJKhaH/GHxHkRkI9LbPdsXIENTIT3s6EiTose+Eau4=;
	b=IviN5MebJYNDJXX0NAqk3NH3DadBUlTSjJxFwGFtzdlav/EM7s94+s//Ok9wYWHG+IVG
	 C/EquopS+6FtUFSU3ZvcYP2vanrUHsLkmmp94Fo0sDCab0vE/uza5EuwJYDXuTpHA8HwZ
	 d2HKDUyYZxT4fEIFO5Rf6TtErRrqh08uC8WQih3I+GKezbiIOEQAqyppPK2rX4CXwrD0P
	 c6KVZb2k9ZHqNwVPjtLZSI+4999ujzx7ZIiNxg3ceG3Y0D4BzZCDLDTf5XkIhJZqdTClR
	 LcqyqY8Xf3pTuPkstdDpcXZ9sds1zs7JHly+CxjGELPWwSECTJYatfX//fii7K6zgGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCeeqjBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41899606A32A;
	Sun,  8 Nov 2026 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCeeqjBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E571F0089F;
	Sun,  8 Nov 2026 09:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128706;
	bh=MlJKhaH/GHxHkRkI9LbPdsXIENTIT3s6EiTose+Eau4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WCeeqjBDCKOlD2WXTKgnOb3VpGFbNofzjKQQMSQA8lCURuGfKJMVpLm3Y399NtvoP
	 /2bRS2AKpG+kHPeu6o6S2+vo45ObhufmljPhW5PpClFL4p0kRQm7frPug4C9M85pIJ
	 NS5+7DdLc6NcDQQJIyEehkXcr5lqQnbX2xa9PJdPoa1JKp9L/ksnGe/Ehh4uTnFEUV
	 mdyWG0tRI374Aq/FB1Ze4D6i+FAJMdbIVs5+CgB4Qakn/SCkd+ULmH4NJa1cnbVSAR
	 MGtSzMOKQraUfVtftuvtW3OWSNrW+rf+WO6xihRsp2GQShCv0Fa7Ok+qdvfgYsvw2o
	 wQzW3D/4aSAxA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:45 +0200
Subject: [PATCH 14/14] s390/sclp_ap: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-14-3e7c90eb6676@kernel.org>
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

do_ap_configure() allocates the SCCB used to configure and deconfigure
AP adapters.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

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
 drivers/s390/char/sclp_ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ap.c b/drivers/s390/char/sclp_ap.c
index 18bb018b4e0cd..15dff5dc0cac5 100644
--- a/drivers/s390/char/sclp_ap.c
+++ b/drivers/s390/char/sclp_ap.c
@@ -26,7 +26,7 @@ static int do_ap_configure(sclp_cmdw_t cmd, u32 apid)
 	if (!SCLP_HAS_AP_RECONFIG)
 		return -EOPNOTSUPP;
 
-	sccb = (struct ap_cfg_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 
@@ -45,7 +45,7 @@ static int do_ap_configure(sclp_cmdw_t cmd, u32 apid)
 		break;
 	}
 out:
-	free_page((unsigned long) sccb);
+	kfree(sccb);
 	return rc;
 }
 

-- 
2.53.0

