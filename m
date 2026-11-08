Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127752;
	b=CT3CEGHo9at2Q/BSGhJagL7huKv5Xpw+HThCwXiFNrq3qmPKmyzWFAYvGWCZFj1s3EF6
	 qIPUn7PbPkl1W+lbai7unoReKZmNzIpXwEiOVZV0VjDVWuQQIMwbOUUFOBGuoZira+4Yx
	 dvEVOmXqQ/+w5EgES5z4wb4Kp1fTU41QzYD9rEz8X+ATJeQYz9tnlesz6UrKFCYTFBRTL
	 lGtiW/1zEJ4Uaiyancx8DwdOW4ALRJqoSuqetQ/KbPHf4sJAoc49hK6nKQmV/YOTbm+lP
	 B8ZDvNcadiDpknv+c5hMwek9OzL0+4OWzt+yW6tXhtBVhlHZ8uzvTfV7ayFJmxXKsFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127752;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=fGNxBWkVhvnkoWITzYnArgAKYt5qHu8eAae1zejckKc=;
	b=A9S1Ltkt7/TnegGgsTqMxqZmLWgB6f8zzT4xg7ado+o+OVYOEEXzzQmNwpob3DzPxhIS
	 zyYxvTW+Hj3XwXbS0wSQBGpPrcehg+HCndj408iacav6P3VypT4GB4s84pk2cbhPBU4a1
	 89mE/CNRQnvFVH7wV6IZP4QWSYa9R1ouOamIQvUdmC9XzyMaXlf3pIDwUKaH6lNW6ZH+R
	 vGRYC03W2K0cKBJFfQeLMuygZ3/AbmzNHMBfAxkzmRIQXT5rLQL5sVRdS+PPB/bwElcrw
	 q4X3YovnEFh3frgq/WkSxqbpN3iOvej766gr9TqriQ7uN6VJcbx04qpWnvn2Z97BK4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdrKiZAY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E817606A330;
	Sun,  8 Nov 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdrKiZAY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D15F1F0089F;
	Sun,  8 Nov 2026 08:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127751;
	bh=fGNxBWkVhvnkoWITzYnArgAKYt5qHu8eAae1zejckKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NdrKiZAYWnQSggYG3kKUVOjbqpgcbntIBygXffutm+R+y7Iu8NnA+TW1MkLqaa8DQ
	 zWSTXQrWrjNHAOmQg7gRQF4yNLmjeai/Llm40gbtfdh8NNUVSO8azsrdsaHRufpdh7
	 1NqwUUnv5RBgC1TKurNFVIcfZrAvplYbJGxreDk2FGSxBzrWvnnuVQU3vq8EiMsE2l
	 bm2vbPQuLQzr8J+MlJMCFhTiLbeNdSfe0fvUZv19yKrYJ0txC5SHGDjF6fTIIDfidj
	 4HKvg7c1J96M+93FXMFLlOCYqnTT/fJV5FK6ewVD+GH9JYIFuJr+zcjNBEu6R7pQLB
	 IUZysE8iju+nw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:48:59 +0200
Subject: [PATCH 2/5] s390/vmur: Replace __get_free_page() with kmalloc()
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
Message-Id: <20261108-s390-char-ready-v1-2-3db507722530@kernel.org>
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

diag14_read() and verify_uri_device() allocate the buffers that receive
the spool file data returned by z/VM DIAGNOSE 0x14.

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
 drivers/s390/char/vmur.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index a47a40fac8483..a13839d70eb20 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -529,7 +529,7 @@ static ssize_t diag14_read(struct file *file, char __user *ubuf, size_t count,
 		return rc;
 
 	len = min((size_t) PAGE_SIZE, count);
-	buf = (char *) __get_free_page(GFP_KERNEL | GFP_DMA);
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!buf)
 		return -ENOMEM;
 
@@ -556,7 +556,7 @@ static ssize_t diag14_read(struct file *file, char __user *ubuf, size_t count,
 	*offs += copied;
 	rc = copied;
 fail:
-	free_page((unsigned long) buf);
+	kfree(buf);
 	return rc;
 }
 
@@ -621,7 +621,7 @@ static int verify_uri_device(struct urdev *urd)
 	}
 
 	/* open file on virtual reader	*/
-	buf = (char *) __get_free_page(GFP_KERNEL | GFP_DMA);
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!buf) {
 		rc = -ENOMEM;
 		goto fail_free_fcb;
@@ -641,7 +641,7 @@ static int verify_uri_device(struct urdev *urd)
 	rc = 0;
 
 fail_free_buf:
-	free_page((unsigned long) buf);
+	kfree(buf);
 fail_free_fcb:
 	kfree(fcb);
 	return rc;

-- 
2.53.0

