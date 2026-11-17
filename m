Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920850;
	b=FisTgVFF5S0Z4jwXw4J9wrb3frmCSGQPil5ESP2ZfH6RrY4d1eS+A4fgYzAU7dYSud1H
	 +afM8uwv0TqeuC1XmSmOk5GvvUf4sxWf1dnLZQNkSgufl+r0tHzg7eWBKYBt2a+xIpTHb
	 Wda8bxKfH589MTzApRt6q2OVxxftzSpv1YXw8d64nEaPyizGdHwos47xk+fJxYOIaXATo
	 PFeWNEFE2plsgEswusZsfd+2B5qlyyOk8q7yNNjTCWLdwaSI18ItUwqjMXupt+H6N95Ej
	 dWk5aq0By/kW46mh3JDQs7tgHGyhWHBVsAKDYnyxkSdttoRsSobk44W1ZjwoIiulyng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920850;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=3oTcbpI93ALmImptUja7T0f81+Fa7+2y1/1yBg80QEU=;
	b=iEJ1BnewoyYGqBSpFcIErnAWmso+OTzeoBACD5rva4Yudkk7sLUfoHzdAg9qbz57c7xM
	 gL62tTtWkFAP0r3FziHTv1roWJWpf78djv1cAQcQJRCrQqOb+UPYmLArhy5BqfF+RMxDs
	 gyHX2jvJetTdVly375eVQb6UbL9nz3JSzKDpqkRfeWUBPzGkYwQCIfxljYMlDOBwW51Rz
	 maayibxrJxQAMA3yiQ5kTzKGXdwMrd57ve+ybedDvfXo7x/vXZXmnwmKHa+CcYJq6gqOK
	 94YVnPUkhhV/LIIenTeEkRibtAD3CamPqeTc1t+q0yBb6v5wt7lTKMYg9MGlv2x9v1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEgEUYus;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE2606A89A;
	Tue, 17 Nov 2026 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEgEUYus
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCE01F000C5;
	Tue, 17 Nov 2026 13:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920849;
	bh=3oTcbpI93ALmImptUja7T0f81+Fa7+2y1/1yBg80QEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VEgEUYusMfaBiL9V0jDqhE0cP1U4Va32n3mTGLAUJlBGLRG0RK7PCQOh85U6VD9BD
	 tX9/D0ecLRYyYdXHN1K6kvoGits0UcNP7FCjj8AXUDTu2Ur28dzIifK7pehSgnriUs
	 CYRskeZhsg00pQ96u1PWgrM7U3eIjwW+xV2OkRPs8kvJfvTCGtHWLfx5BHJmIMGRJ7
	 FviYP7E+bQCI05ts6keR3CYw11s/vwxa5HNAwEj+Urmx1Oo4+bqtJaktd9tjvU24L8
	 wI72hSoe9bAXXcZDDRBHS+mAMK3thU4h9eYjOA1G/99CuHIhTP68UJFZEhB8T+CkUU
	 7vk+e7LzkDr8w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:07:02 +0200
Subject: [PATCH v2 10/14] s390/sclp_cmd: Replace page allocator calls with
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
Message-Id: <20261117-s390-sclp-ready-v2-10-e518c99622c6@kernel.org>
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

_sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
allocate the SCCBs used to read the CPU information, to configure a
channel path and to read the channel path information.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Keep a power of two size for the SCCB in _sclp_get_core_info() so that
kmalloc() returns a page aligned buffer.

Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
and free_page[s]() with kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_cmd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 1dc93d945be6..9f70f67049e4 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -102,7 +102,8 @@ int _sclp_get_core_info(struct sclp_core_info *info)
 		return -EOPNOTSUPP;
 
 	length = test_facility(140) ? EXT_SCCB_READ_CPU : PAGE_SIZE;
-	sccb = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA | __GFP_ZERO, get_order(length));
+	/* the SCCB must be page aligned, hence power of two size */
+	sccb = kzalloc(PAGE_SIZE << get_order(length), GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = length;
@@ -119,7 +120,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
 	}
 	sclp_fill_core_info(info, sccb);
 out:
-	free_pages((unsigned long)sccb, get_order(length));
+	kfree(sccb);
 	return rc;
 }
 
@@ -173,7 +174,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
 
 	if (!SCLP_HAS_CHP_RECONFIG)
 		return -EOPNOTSUPP;
-	sccb = (struct chp_cfg_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = sizeof(*sccb);
@@ -193,7 +194,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
 		break;
 	}
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }
 
@@ -236,7 +237,7 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
 
 	if (!SCLP_HAS_CHP_INFO)
 		return -EOPNOTSUPP;
-	sccb = (struct chp_info_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccb)
 		return -ENOMEM;
 	sccb->header.length = sizeof(*sccb);
@@ -253,6 +254,6 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
 	memcpy(info->standby, sccb->standby, SCLP_CHP_INFO_MASK_SIZE);
 	memcpy(info->configured, sccb->configured, SCLP_CHP_INFO_MASK_SIZE);
 out:
-	free_page((unsigned long)sccb);
+	kfree(sccb);
 	return rc;
 }

-- 
2.53.0

