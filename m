Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127755;
	b=afJ1rMuBF8xG9jEYHKyhTubwsWP7kyENp9/WLC/YwBm2D+3yLooh0nZIKRzjjNmpbJxZ
	 Dd2AQXmD6BMaTUTduQ8z92BWrKHaVgE1SgNbR1h8PeECLOwd6Rv8+RlAcJWSBJ9W4jvdn
	 /WZlS8Do329eXGmJPDQ28db6TABtUN/W59gQ9QPnVzDb+a/aGn4aF+fDuRCxZeyzaeD8g
	 Slpm84OrqP6vBDmDa8w7zByB6CGjfMy6/0lVMWTtOG9AFSmGEjjSHOE5UdVXPcLk/twEp
	 vDe8VHF62k+BZlmzZP+pfxQ7U+ElaSt5cT6F/yMaE8l8eo6zZAXqbSznkW17j4s2Vtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127755;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=jyfscNgfuH4Bgz6xRWZ3M/NAQI+U46EGvUlQUq6/bgc=;
	b=afO3RB7tt+WHSl+vdqUzzaxiDUfEpz2H3Sw8ZtcuXPqI0F0KIHPN8wQgImI2aFWyb3AS
	 mog+cvnGgYWH+qPjau+U70S7RZeD6NbVbBRRCmxDbfcHOl58alwQJhHp0iBHqloRPPkOX
	 Y+RqodEEBuQ1dNG/rbRLecfUjdnlc0l80JPWB7yU/kKNUhfUwC4ZpMGhwJJRAx28hiehf
	 mMnFolvLJA2ggzMpHTfIuiCVXX4s3tAMKMB9zN0qJ/2KDdjDwYnJKGqc1zaSRKAmBQF9j
	 AqAcjJCFwV+gLqCYol6H9K9dIznQ85ccdIR/uTBoBAldVQOrmGX0PIwwe88x9rjoj4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQxTPPvi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079B606A322;
	Sun,  8 Nov 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQxTPPvi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225691F008A1;
	Sun,  8 Nov 2026 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127755;
	bh=jyfscNgfuH4Bgz6xRWZ3M/NAQI+U46EGvUlQUq6/bgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KQxTPPvir/kfH+2bqchdYnHZIzVjk+t3znnd5k6S/8nUsbyTYUhn635WW8Ztv9MQt
	 1qL/XGAWJzB6TBHx/w6r8eH8Ubrx3N7uDREpMYDAoKD+YWI/y2sRf/Z3xlpuvy6utX
	 dKBaaT1iJ7s38+RjBbVPbxVQBnUMkm4peKHJE/jM3C++JcRAE/mtbWzpTxbzDvTmIv
	 Unktv4xstpWzRvIqV1Bg3/D+/Nz1po34iHKssRZsYAE7tkoyz8TAFTPTo4Y02/+lIi
	 LOLT6FTrdAf8A7SX697ByCc2Cjt5q4s4f21YjUmNJ5BmnnEvb4S0hmr6fiPzvrj5QT
	 ZaGqWjNFEJefg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 08 Nov 2026 10:49:00 +0200
Subject: [PATCH 3/5] s390/vmlogrdr: Replace get_zeroed_page() with
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
Message-Id: <20261108-s390-char-ready-v1-3-3db507722530@kernel.org>
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

vmlogrdr_init() allocates the buffers used to receive z/VM system
service records via IUCV.

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
 drivers/s390/char/vmlogrdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 005735a899203..229a0f71dc453 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -793,7 +793,7 @@ static void vmlogrdr_cleanup(void)
 	}
 	for (i=0; i < MAXMINOR; ++i ) {
 		vmlogrdr_unregister_device(&sys_ser[i]);
-		free_page((unsigned long)sys_ser[i].buffer);
+		kfree(sys_ser[i].buffer);
 	}
 	vmlogrdr_unregister_driver();
 	if (vmlogrdr_major) {
@@ -826,7 +826,7 @@ static int __init vmlogrdr_init(void)
 		goto cleanup;
 
 	for (i=0; i < MAXMINOR; ++i ) {
-		sys_ser[i].buffer = (char *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		sys_ser[i].buffer = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (!sys_ser[i].buffer) {
 			rc = -ENOMEM;
 			break;

-- 
2.53.0

