Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920855;
	b=1v4bgDmcJGrzjGLySqLuB7ln6MAa58fmD6XWf/VwlTS85sUsRSTAcUIa9aIKG711eZq0
	 uR0cpvP9mnUSZsJ180VH6fws/k02xfNgBcTwRORtzyWXU76teAGeQVxIj/O3VsD6N96E6
	 OBnnKtfzdz0lXpHSl/q9vNrw3mAt4qjng9I8ihfSFWyXB4cJm83L4J9J5ney9nrr+vYcY
	 z6DmO+GfkFBagflCHjph3woAZAg5jJnn50Jz4ziIJcXt2pvlxC5U4iEkH3hc59QAxDtVb
	 Pq7qb+Yq5l5FaNPS1IVnwcAAigcwxxCbnc0miiy3W8b2mRTD/rxzUs/S60TYTZtvUNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920855;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=LgTNyWXJJEITijdTm//nXFVMQ7qfEthSD5JsfZnL/Co=;
	b=3ffk4vCEhUCbAQcXI3b3tk/CAyjlQTT3Os6dRmveKM8wP3DbF/2uXUDz8MyJVEJFVhNX
	 nnJ7ZRdOLcCky9YuKKSNXHlj2K1TU+9CSBZyH5cwH7TJoAeknBz5DqjIAUJ6HUAhjz1hE
	 cy4B+nriG8gMdiq3QaFO2ebhn+a+Sth+4rtoAZjvQnFVl03klD+omP0tKeSb5j0UyzET5
	 yok1Nen+cExOVsZnbfEBhgQxVK3oiFSTYBQlNauCzqVFB6hMbqS6S+iJZpSiFT6zb0hlk
	 Vy/kNJFn7/zUOGA7Ksoogn/BpZjNU4c48z+ExP8OfbHJFuiaC8ec8pzXM9ryvHulTwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYlyVwll;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB360A3824;
	Tue, 17 Nov 2026 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYlyVwll
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C3F1F000C6;
	Tue, 17 Nov 2026 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920855;
	bh=LgTNyWXJJEITijdTm//nXFVMQ7qfEthSD5JsfZnL/Co=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jYlyVwllMRqqBz2IQfdVjoT7+cFM4ROU86h+VFinbusD4k3+w0oaHGtQmaBr0Pqrg
	 HCRtNjY0ZHfoz29ADL97Adgii61dewiRwK4qHl0rF3c/v19/TzNigQa6IprsrscoJE
	 67dAqp+utVG5RHLRgC1ROwppdiG676N0UybxP8jVR/K3EQ0DGIRrzAMWWfqDQDxq4i
	 u873O/SesKzjoFN74B/rYsobVlM4zyRWHiU0Xvf0PJ5lmSavlJGgr0isrE327woqeB
	 ThVP7Ab841Y/TG/aJrXEuVymM3NMgXem/GRlq7LTy0PkjTTNzGsSkVbZ7a8zl3q3FZ
	 IA3L6/s1PgTfA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:07:04 +0200
Subject: [PATCH v2 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
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
Message-Id: <20261117-s390-sclp-ready-v2-12-e518c99622c6@kernel.org>
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

sclp_ftp_et7() allocates the SCCB used for an HMC file transfer request
and sclp_ftp_startup() allocates the buffer for the SYSIB 2.2.2 stored
by stsi() in the debug code.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, make the SYSIB 2.2.2 buffer a struct sysinfo_2_2_2 pointer
to get rid of the casts.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_ftp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/char/sclp_ftp.c b/drivers/s390/char/sclp_ftp.c
index 853492d53953..904a53ecb6ed 100644
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
@@ -241,7 +241,7 @@ static struct sclp_register sclp_ftp_event = {
 int sclp_ftp_startup(void)
 {
 #ifdef DEBUG
-	unsigned long info;
+	struct sysinfo_2_2_2 *info222;
 #endif
 	int rc;
 
@@ -250,11 +250,9 @@ int sclp_ftp_startup(void)
 		return rc;
 
 #ifdef DEBUG
-	info = get_zeroed_page(GFP_KERNEL);
-
-	if (info != 0) {
-		struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
+	info222 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
+	if (info222) {
 		if (!stsi(info222, 2, 2, 2)) { /* get SYSIB 2.2.2 */
 			info222->name[sizeof(info222->name) - 1] = '\0';
 			EBCASC_500(info222->name, sizeof(info222->name) - 1);
@@ -262,7 +260,7 @@ int sclp_ftp_startup(void)
 				 info222->lpar_number, info222->name);
 		}
 
-		free_page(info);
+		kfree(info222);
 	}
 #endif	/* DEBUG */
 	return 0;

-- 
2.53.0

