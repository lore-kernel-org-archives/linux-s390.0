Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127764;
	b=zShq8CpTYBCGF/dOFbHimqmmaeB6+mtBrs8UhVvC3BsLzw99jwFtgwwC9qFQODdz/QM6
	 DJdyhZcauxKOYSbLKSbPQnwWR3/XpgOUyKr+B7WtrMrp361iH6X8BC21hmbwU4uFfsfeH
	 hvlscMOtkL1f13a5SLpkQyJVuTT3kIWrwR+EcRxekkFCXtYFj8JNlVk8UM7wR8pxlhXe8
	 y0IZIEdrgzgRGobGsNdcnyEiAA8tPfNRCKwkcsbrLr2pF5D1eJ2zrobWDFRDoC99wgmn2
	 WcOozCSjpPDyyozoTw4olNlMsTTRhUYYMRwpe8ATOZMQPV5uGU8wBhQ2IvgLteYNc7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127764;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=H0/h2A5rwxJVNDSipV463VVDQJBhqLVmF0Nxvl0ClsM=;
	b=kJT1B2yI7DrFuZgiuosgU4EkCnXt7KLw4ZXZcFH6vwIhBOWOnwOUK/iPEMa6C3G+KkDj
	 POAGPdwMR90fP4tTifK4P7466MAEnvsulSWllQYheBQTQxMzYYzQitsaWDd5cGKuvCOlx
	 N6vCwQcaEkwuDwYnhs5l6cmPy2/WP8wMq42wxpngK1E0kZrRTIFxmWsfXD0ePwgdxWwtx
	 TLwvSuqj1sRYgaavC5Q58qVzUEGjvtPjqlfQAb1u9zQ+0Qg7sIqfNlFHRqOA8Q1ecc76k
	 nukq3COH/MdycznuQno1Li4TW3/X0cVsAo6Nkv07PsGfkqZp5hSjH8aHa/ElrKEq9iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3LnY97A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336B606A33A;
	Sun,  8 Nov 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3LnY97A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB541F0089F;
	Sun,  8 Nov 2026 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127758;
	bh=H0/h2A5rwxJVNDSipV463VVDQJBhqLVmF0Nxvl0ClsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L3LnY97A1SL8QgstjBbwFfQ0TcuCvOVWGbAi+Pvhq73TMaxhAzAZTxGr34Hw4XIc+
	 80VpQzH0GrADK+Fecfhpg01a6PP1Nu8xD0RZOuPDS98IRWNWYyy6hSlKq/RNdG0SfR
	 VLy46A96daD9K8EDQqVdOUFqHVEi7B6tUhIbpcAwQOWs1foo1cUu0loUG5IasH3MJE
	 5G6PhjCSkAUB2O7XwQ9zKDKQypic1YVwkNcmzK1TUXIggJen2dQRGf03syqSRn921/
	 nohv5C68eyceCV/EmZu+mkWF0f7YVGKwPbUIQBoQN96+8toclCnpdStMRjq8MeXud1
	 mrLVHbQ56XRdQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:49:01 +0200
Subject: [PATCH 4/5] s390/uvdevice: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-char-ready-v1-4-3db507722530@kernel.org>
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

uvio_list_secrets() allocates the buffer that receives the list of
secrets returned by the Ultravisor.

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
 drivers/s390/char/uvdevice.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 4d274a2ee84dd..5375cbef2810c 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -371,13 +371,13 @@ static int uvio_list_secrets(struct uvio_ioctl_cb *uv_ioctl)
 	    uv_ioctl->argument_len % UVIO_LIST_SECRETS_LEN != 0)
 		return -EINVAL;
 
-	zpage = (void *)get_zeroed_page(GFP_KERNEL);
+	zpage = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!zpage)
 		return -ENOMEM;
 
 	rc = uvio_get_list(zpage, uv_ioctl);
 
-	free_page((unsigned long)zpage);
+	kfree(zpage);
 	return rc;
 }
 

-- 
2.53.0

