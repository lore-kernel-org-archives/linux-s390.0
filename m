Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D1314A6F
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236515; cv=none; b=QwbxkBeEZHXOja3E+zz7hQSTZB40yU1kbXrqUgUHjlq+S1JQc7vQqpuPXOUK7MTcuFy2R2h8+6VgWLkyBpXDbZqpkZdFhgd5npwePtvtf6JdobXj7G3RhHFtx76wLqh1jZWtOAtqtNivupYbuMXAUAx9ruLFWvcYaq+K83LcCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236515; c=relaxed/simple;
	bh=DZVWaydZCCCi4qhARoDEFvDSk2CwdVjZ2DH9w3pvLfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKgVxgO0YVOCoCnaF2idMXxVGgYr8/UP0PAtPPew4UI6+fjrEJ0DUYzuhTCu/NHFNKx1K9zIYbLIuCt9P+BqVDAczNE2bcTXAY+X4x1P125F6WRth0nUqUb1x2HRKzvh7O9YL0a53q0VKRp5KaSKNkpdk+LuhLpyw7T47RLROtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIhtLcrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIhtLcrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5E01F00898;
	Sun, 31 May 2026 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236513;
	bh=6HjXvD/g8hE7iXCryGV2eNwahR0gVIqT6iD9yp5G21g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hIhtLcrvj+slXlj3mbgerdKmZ/hVq1AgcWtTyEpA7AR2XOPtVF6EvF4w0/nG/REGd
	 P7jYuH+mbT2rADdpgXdX/2rt/AJTjhTDdJ1pyyVdzmyuZxD9RZ9z3btlMkcKgD2zDA
	 8n/zw3CunaId8LSk3blyCe3rJMPKmFJg7LzrN0eCc6wTJ5cCviHJTQ1WU3EYPLOcC7
	 fGrN3Eo6zzAR8xA33YmUnuBg3xfEIkHTPUoymQU/DR9mACz0pLJny3yKSv4ariHAKN
	 DMZpVygVXvS9Sm/6UwRA3w4yWfiIxDraxCzW+D4L9KiTTP9FcQBI6KDHh0s+Q7QNLG
	 3g4sSXR1Sm0gA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 17:08:22 +0300
Subject: [PATCH v2 1/6] s390/con3270: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-s390-drivers-v2-1-f7985308ed90@kernel.org>
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
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
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

