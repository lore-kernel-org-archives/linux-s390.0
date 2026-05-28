Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDC340A46
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952220; cv=none; b=L7bxR7KRA+YS2wRTlOjYK/YyZP2diMDgTA4A6oQyfz9YdAn9lw1d04ceD5IZbQcpEc52MzgwBWQ3wKXNQkx6/SU/OKe2VVcER1tm3e7/mqaVomLI9rBLXlsBe1P1p+VPX67tCm2aP9Z+uO/5oKes/kD2m+2raLCwco1mMkFgk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952220; c=relaxed/simple;
	bh=8Y3y/nukPyXe5E1RgIG7Z112OkjsYs1zFS9CEBvS2Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loEI5hKn1vEscUYusAjwe1LJ7+2d9M1flb4zzNKgBzH081wQI83HkLvXPwILT+VKGoeXw6H6Ug/Cr9vy8vkj+PnhMyDgybnLn4hjhXSi/SLuC+moC3Ad7GOkM3NTs6Iv94Qrn39JUsiOwUthBVGixhD9jeGccz11lgfiGb3L6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbGOdn5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbGOdn5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C411F00A3A;
	Thu, 28 May 2026 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952218;
	bh=MMI0okuWnvQz8hXPZ1Dbwxy0dbRZzCobk9pIHoaGZDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RbGOdn5J1JlYPEpI3VMX6KD/2jcpizKn2712BfVbk0GtY7ipmV9U6zujkUaXo7aA4
	 CTcUYn77C3tgkxgq5FjHg2RAS6pvLQ0BeIx7XT40ZoYPmb43RGOtKHnCa+TDy2tw2l
	 SIlglYQQuusGhtqA//ZjVHF1wI+gzHnqMeAvAg9lVf88FIAeDvJZE3Ir5qvN4k5vmB
	 OxeoJ74hITwRwQ0LiKonupZgWca+KjWAhTQDpXilaQVlJKDVGwQzTwykQckvn/bMBN
	 o1Sv/z2WgvMYO5RQBAuoMm7sb2DDRguefQwtYAdsRD5X7FvS11Glmo45v0rVYhJfDZ
	 mYDY5XBRftzOg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 10:09:52 +0300
Subject: [PATCH 4/6] s390/qeth: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
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

qeth_get_trap_id() allocates a temporary buffer for STSI system
information queries used to build trap identification strings.

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
 drivers/s390/net/qeth_core_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cf5f760d0e02..9274087557ec 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3362,7 +3362,7 @@ static int qeth_query_setdiagass(struct qeth_card *card)
 
 static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
 {
-	unsigned long info = get_zeroed_page(GFP_KERNEL);
+	unsigned long info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
 	struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
 	struct sysinfo_3_2_2 *info322 = (struct sysinfo_3_2_2 *)info;
 	struct ccw_dev_id ccwid;
@@ -3381,7 +3381,7 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
 		EBCASC(info322->vm[0].name, sizeof(info322->vm[0].name));
 		memcpy(tid->vmname, info322->vm[0].name, sizeof(tid->vmname));
 	}
-	free_page(info);
+	kfree((void *)info);
 }
 
 static int qeth_hw_trap_cb(struct qeth_card *card,

-- 
2.53.0

