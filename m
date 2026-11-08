Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128685;
	b=Fr/29D0vIncpCMXVDtiHRLFQu6Xj2JceL3oXo8uuQkfJBJXTQODerpqTwOnWGQ3FHq70
	 1RGwdF4CRRHnNBeT8y3y8iyfMjSiIpUlv8KJNQMG9dI5YU2HtdCm6A1qY3RLjtbwp5NB/
	 nNnsx6QcqNXc1gLwm8Elbkspcv6w6GYhYRGZReuTP7j92VHxAgO/CUk9AiNHzEocn4P3A
	 6uch8cZ+ZqYDWO0MTKO0Hc8vnvv/UsnDqPrZ1IJPl/qJhrKvS6IqmPZ+rOrR1ltEUFZii
	 nHWqDXc0rXypQ8Ah6vrHvWXnq8E0VwWPPsYPaz7Lr+lKpI8l9nsIkJpC+FOudiW5f8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128685;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2BEDb75+KlXwKKqBsbU7KIos10JSO/7hJB/UiWOZTvA=;
	b=ozynQcbl+6dwZCWVydD0+h4exILTjY983eactl+SX7Czn8SIbGe9BHeHr8gKd6XOP+CU
	 726ZOs7aojLF6LTnuXVcVHuz3jIW0Ge3p5U8ON3HBip3FRm/KYCnzBxRmu0I9y+5Ttq97
	 9e0dsuy7145G8QakZyGPNSuLw0jC0q7UCswYU921GnQ2nX31pbg9ck/HEN7PKEDl8kPaz
	 kW6vsw1Fp/q0yVbl9JsfbvHfXKpMJYk/HDeCaydr0eg3N/rcaRq5bmoU10rIIH02S5sVq
	 7BeR+KjPgSNbk33VUSppO+WomCQptjZ7jmAFPeeBE4FFXDJUTm9pE2VWimEvQPZZ7jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7eG6bSb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF194606A333;
	Sun,  8 Nov 2026 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7eG6bSb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC59D1F008A2;
	Sun,  8 Nov 2026 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794128684;
	bh=2BEDb75+KlXwKKqBsbU7KIos10JSO/7hJB/UiWOZTvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P7eG6bSb7y3UfUsVSVuy7wbuk3wUu8ykJI+w9P/X78rMEwqlKslu7MOiHe3pX1yeJ
	 CIxCZQGi/A45U3SHNMlvkhVgXSoUi2/E3EQARpsCPPfMowmZ2gk1qu3UGWGibPzxYE
	 2/7dGqmz+PSMycPnvTLWhH3ja3vFKP50rZo+B3OT/ER7NZxLSjZzGszn+NgUMbBCBI
	 oikudTn7nn1p0up4YQObbpBtXsyXkkvAcYTh4I42FHxq46iYg0Zcg2wqjcOSe+StD+
	 B94SYXDPIrC3FxiDlh5ilKCqOflZQoTAv1JRligdSXxPTUaDP2tBKpCzCXjS4Zrl1b
	 9o7Zu8H75MUMw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:58:38 +0200
Subject: [PATCH 07/14] s390/sclp: Replace __get_free_page() with kmalloc()
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
Message-Id: <20261108-s390-sclp-ready-v1-7-3e7c90eb6676@kernel.org>
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

sclp_init() allocates the SCCBs used for reading SCLP events and for
the SCLP init mask request.

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
 drivers/s390/char/sclp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 98e334724a627..bfbac6dfa053d 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -20,6 +20,7 @@
 #include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <asm/types.h>
 #include <asm/irq.h>
 #include <asm/debug.h>
@@ -1268,8 +1269,8 @@ int sclp_init(void)
 	if (sclp_init_state != sclp_init_state_uninitialized)
 		goto fail_unlock;
 	sclp_init_state = sclp_init_state_initializing;
-	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
-	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
+	sclp_read_sccb = kmalloc(PAGE_SIZE, GFP_ATOMIC | GFP_DMA);
+	sclp_init_sccb = kmalloc(PAGE_SIZE, GFP_ATOMIC | GFP_DMA);
 	BUG_ON(!sclp_read_sccb || !sclp_init_sccb);
 	/* Set up variables */
 	list_add(&sclp_state_change_event.list, &sclp_reg_list);
@@ -1302,8 +1303,8 @@ int sclp_init(void)
 fail_init_state_uninitialized:
 	list_del(&sclp_state_change_event.list);
 	sclp_init_state = sclp_init_state_uninitialized;
-	free_page((unsigned long) sclp_read_sccb);
-	free_page((unsigned long) sclp_init_sccb);
+	kfree(sclp_read_sccb);
+	kfree(sclp_init_sccb);
 fail_unlock:
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	return rc;

-- 
2.53.0

