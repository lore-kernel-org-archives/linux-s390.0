Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFED314A6F
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236529; cv=none; b=l8HwmUhSg9EXyD3Tk/iRAf90+xxp7sF9v0YTsjMdfX3VJtsUn7MPETYABv4kwBkMj4jHAqkS10X2dlMVMMbGekR6mscozJR/4ldRFrxLLxNjB6wMsSJrqGdz4/y96AcXm7RfnkJcqTv0nBzzWxS1IsZ+CmIXV3iwXheRdkn87ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236529; c=relaxed/simple;
	bh=hLefowPxvG8Upmu+vDfo4Loh8M0OO03s5V6wB4L+pAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeADaKqJsnN0hqNJAUUpxvIf6notwgoXvewFQANmg38VPdC56j6FaH1FICPteoLrZ4AT7hp16qdNj39Yd1smZ/bNgzexDMs7ZxaIZoUEhmogfVVBuVuw5FGpu2Km6lgxHA4s/azyI0LssFH8HSOnNwZ3KzA1t9DSVc1iE7Urhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loTry+3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loTry+3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965231F00898;
	Sun, 31 May 2026 14:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236528;
	bh=MmXDEkAmol1DiBaYpp0A9G5fZFdnZmnqsK/Hlh0sXoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=loTry+3DVXVetBnGqqeoFirOPRLclLF2QrDUreXlJcjA23eTCzthD8swW3CTUKzfl
	 jv379mwrRu/cM5BShL5UqvK5IvrjDgDgKDVcRLvUjnl9NbLfrosWtqTuF6LA0czsbM
	 dearzQXTnB0vSKd0cjicz5/Mv6rypMzPT33ZpxbJWIuOOPi+LDxOBp6fsybS+XT/5i
	 XtJ6euYH22fI6BeHxw4agawA0FuvUZ6+H3u05okKvdF30TlY/nspOIU1mKhhT0DmVT
	 MFqjBVFr8+NkzMkGSpDxDXpQ8O5ODf8n/goWI38uRcCK+QjvGe/hG8K5qF9JjF2L9c
	 Hrx+GgcOG9jWw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 17:08:26 +0300
Subject: [PATCH v2 5/6] s390/trng: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-s390-drivers-v2-5-f7985308ed90@kernel.org>
References: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
In-Reply-To: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2

trng_read() allocates a temporary staging buffer for CPACF TRNG
random data before copying it to userspace.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

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
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/char/hw_random/s390-trng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/s390-trng.c b/drivers/char/hw_random/s390-trng.c
index 3024d5e9fd61..5520f66274b3 100644
--- a/drivers/char/hw_random/s390-trng.c
+++ b/drivers/char/hw_random/s390-trng.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/random.h>
 #include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <asm/debug.h>
 #include <asm/cpacf.h>
 #include <asm/archrandom.h>
@@ -67,7 +68,7 @@ static ssize_t trng_read(struct file *file, char __user *ubuf,
 	 */
 
 	if (nbytes > sizeof(buf)) {
-		p = (u8 *) __get_free_page(GFP_KERNEL);
+		p = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 	}
@@ -94,7 +95,7 @@ static ssize_t trng_read(struct file *file, char __user *ubuf,
 	}
 
 	if (p != buf)
-		free_page((unsigned long) p);
+		kfree(p);
 
 	DEBUG_DBG("trng_read()=%zd\n", ret);
 	return ret;

-- 
2.53.0

