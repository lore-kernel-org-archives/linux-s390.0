Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128700;
	b=ompYYz1UbR42uZiN8qaDqjE1nD/2i62lfnbj1otf0XbfGoegxOZVxxCXJKehImZ6/kVC
	 0a56DnHarZ7cYWR4B3saHRvR3KEI8SFfBp3hwL/w6XwSSkJPzPD/3aUbUThz1vbf4ELCD
	 r1VMKApw6zZx50eOi/5WEG3qnoi9yBJOy5sYFmfnFEdGtWh3IyxmwI+JJ02UC91S8SvIr
	 eHfCzqiZxLo1K30zGSjvtc2I7sxp6cH1MktM1sAKo0yu2H0BZu1jB7EvNrkjQ4tg6XYIF
	 bAf2cRwIO6fR20XjbAP9wlIcxoaW1jYYEgJATdzltxOBqiXXNKUsE98Tc3/Ft89BE7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128700;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=/5xWZuOcu5wq1ILIYVug4mJ+WQ7JQuKPaFdS0svDsis=;
	b=Zng2R0zmbajgugRNbVS8hF46GgtDX6A/en1HsyqgXgZ6m5JNjtTy5Vfxm12r/K+7Fm/j
	 6vOJZNmknPQNKf4R12VgwWS2vy0jO99WhYpUhqr7Mu6jYqDp+cvRE9zjPIsJobtVTCBCa
	 X3wHkjNniL9HjkTDJcrJFogPsO3K4BLiKBDXEyaN18G85oKxY+N+2RYZv3n5Fl0+vWNZL
	 RNo/1PFm4rh/Mrxxa6+VKB3vsnbOUVRnI1WBfyfq11sM2Avmq42fvmFcS4h3eNfQwsPLl
	 OaFBM5+veM0E+aTdPqV5fjZkJEyeWNMnXbIcB92I2DEyWLYENq12+oz1lpzzfaK/23g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0CadyDO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C049606A335;
	Sun,  8 Nov 2026 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0CadyDO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA1B1F0089F;
	Sun,  8 Nov 2026 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128699;
	bh=/5xWZuOcu5wq1ILIYVug4mJ+WQ7JQuKPaFdS0svDsis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=o0CadyDO8ch09f8UDJW0fs22/dou/hpVtAd3CkgGduDYwDI6GH0BbUIWx1HB6RD8s
	 Gf97OZWAjCWSCBGqWVAyTgcJw5LtawIKJhAK/zqWRkKCAZ3AWieT193KBlgvETs1VW
	 o6/EdF+1mAE2TWOmYuDnBSPEaHCUsI1CqVQMnbmsqxZZG0uJ35fChO0QcI6ItTJoDZ
	 gWYwiG5ChHjkhgQbeEjuKG/0b5oPJ533UpA3sl5fO25cDkyOwsl2ElvgYAT0+vF3U9
	 Oza3yy2QtLv002cmfHyN+517zx0KI90d5lp6e9nqqd4njHSHN/EhWRYkHr6c5j8bWl
	 c/+U0E0Y4O73Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:43 +0200
Subject: [PATCH 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-sclp-ready-v1-12-3e7c90eb6676@kernel.org>
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

sclp_ftp_et7() allocates the SCCB used for an HMC file transfer request
and sclp_ftp_startup() allocates the SCCB used to read the SCLP info in
the debug code.

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
 drivers/s390/char/sclp_ftp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_ftp.c b/drivers/s390/char/sclp_ftp.c
index 853492d53953c..c46fd056e9daf 100644
--- a/drivers/s390/char/sclp_ftp.c
+++ b/drivers/s390/char/sclp_ftp.c
@@ -93,7 +93,7 @@ static int sclp_ftp_et7(const struct hmcdrv_ftp_cmdspec *ftp)
 	int rc;
 
 	req = kzalloc_obj(*req);
-	sccb = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!req || !sccb) {
 		rc = -ENOMEM;
 		goto out_free;
@@ -155,7 +155,7 @@ static int sclp_ftp_et7(const struct hmcdrv_ftp_cmdspec *ftp)
 	}
 
 out_free:
-	free_page((unsigned long) sccb);
+	kfree(sccb);
 	kfree(req);
 	return rc;
 }
@@ -250,7 +250,7 @@ int sclp_ftp_startup(void)
 		return rc;
 
 #ifdef DEBUG
-	info = get_zeroed_page(GFP_KERNEL);
+	info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (info != 0) {
 		struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
@@ -262,7 +262,7 @@ int sclp_ftp_startup(void)
 				 info222->lpar_number, info222->name);
 		}
 
-		free_page(info);
+		kfree((void *)info);
 	}
 #endif	/* DEBUG */
 	return 0;

-- 
2.53.0

