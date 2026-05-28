Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43A32143D
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952209; cv=none; b=dfe4ckUAEj12kSI27lVppJNOTLthSCMl+wX4tIhRk9cJMC1X+NzaZpM4n7AhE/B6VF1Tx/iP3X/7hS9QKceTjP/fyoaeiSa9CPjNjkSmFsD1DJpXR3l2chzks5HpRm43S2gLaCWRRA1XU8cuO7T1jGoVl4rmOTNBBrOy4NETwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952209; c=relaxed/simple;
	bh=brbL/VZ1uwBscKN5ORsjkef+G2WLw+GGZUBuoAqTN84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bz9CtUSjGmu/gyl38/BREpE2B3Tq6Nj+jz7otTfp32I3q2lFvqxwkAJkCj8TYolWNObEa1ZnBoylwlUrzn4jtzKb0s2FkoU/wp3gZ/RP2Q1mQtnKYcYyetDw6Ear1sgzHS8TE7GRzUcScI6znKsS34GnP3sdCYooQBDMJidDWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE5TIPRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE5TIPRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D6E1F000E9;
	Thu, 28 May 2026 07:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952208;
	bh=Xp3A+s12iguQlNP37fbbQhAMk7ken+i3BM0mDWYoo98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UE5TIPRrOiVRIzgOkWsPMQiQAFsbNuZbfoRu0zr1fzixqZG2gJDbHipEh2hFqlxZJ
	 FFpvvIfOrt/fWWKFKVMQ7rxSMi9unLhbiESUDbocmASFPmwG7nEjFw8lnZCDWTTeTT
	 Hf/YSq3ZVDHtzEtoVmdgzxLmoeXUO+8GvmO6doAKYW2gGfIA/ZW9ONf27q+YgCyyHB
	 Nj55wYc9bLffkYZUHUXQBvhqaK7GIiBbXbOswcKZrcVQlIzi/Yw70iCFnzZhYzTbvT
	 qc691B8YHiV5eCAtdj6QRpAzvRBITfVfmOq9qNkN0LMTNxnONTDBr9kCx0rDHVRywO
	 CqOFGqYj7Ms7Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 10:09:49 +0300
Subject: [PATCH 1/6] s390/con3270: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-s390-drivers-v1-1-b7108f54d722@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
In-Reply-To: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2

con3270_alloc_view() allocates a staging buffer used to assemble
3270 datastream content before it is copied into channel program
requests.

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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/con3270.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index 644d3679748d..c39da2ec22b4 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -880,7 +880,7 @@ static void tty3270_free_view(struct tty3270 *tp)
 	raw3270_request_free(tp->kreset);
 	raw3270_request_free(tp->read);
 	raw3270_request_free(tp->write);
-	free_page((unsigned long)tp->converted_line);
+	kfree(tp->converted_line);
 	tty_port_destroy(&tp->port);
 	kfree(tp);
 }
@@ -1063,7 +1063,7 @@ static void tty3270_free(struct raw3270_view *view)
 
 	timer_delete_sync(&tp->timer);
 	tty3270_free_screen(tp->screen, tp->allocated_lines);
-	free_page((unsigned long)tp->converted_line);
+	kfree(tp->converted_line);
 	kfree(tp->input);
 	kfree(tp->prompt);
 	tty3270_free_view(tp);
@@ -1121,7 +1121,7 @@ tty3270_create_view(int index, struct tty3270 **newtp)
 		goto out_put_view;
 	}
 
-	tp->converted_line = (void *)__get_free_page(GFP_KERNEL);
+	tp->converted_line = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!tp->converted_line) {
 		rc = -ENOMEM;
 		goto out_free_screen;
@@ -1167,7 +1167,7 @@ tty3270_create_view(int index, struct tty3270 **newtp)
 out_free_input:
 	kfree(tp->input);
 out_free_converted_line:
-	free_page((unsigned long)tp->converted_line);
+	kfree(tp->converted_line);
 out_free_screen:
 	tty3270_free_screen(tp->screen, tp->view.rows);
 out_put_view:

-- 
2.53.0

