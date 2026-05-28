Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613E32143D
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952206; cv=none; b=lfRyQpOEaLprqW0qO8TD7/NgQtbvv6TphPWmL8P2eCQEoTIjQ+FH3Lr9xZalDL6oInIVHLsikealPGfhCZ8XhrO+VzWIbQ7oib9TFsl0MA5U36tW0y9LmSOetpQlVADpFkfE1cSyTKxAYz0q+RIohTR7S96KEXWDtENXF4wK+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952206; c=relaxed/simple;
	bh=JzslDwAF8VhgxuUYL9qYjPLNJLw8Rvr7Tewuqjy6HFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pmsjYR+GW0Gio75KcWF4IWUVhFePQfpQOkAetUeqlgu8dBz7BgAwd3pRRBXdnESBxPEjcV4qOG1vIbspbb0zMjBxmMoMoF6sDuQTG5Ckg/r8mDY6dvmrdhLa5YbO9F8/n+7cVdcDtpoaJcj3PCpE2XhylWx+Hp8Ipvxe5Da9QUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUvBVUNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUvBVUNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB171F00A3A;
	Thu, 28 May 2026 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952205;
	bh=A1Xkb5Jm+HRMe5pSDUFbhPFlvDRr/tF94rjAIqqd6XM=;
	h=From:Subject:Date:To:Cc;
	b=mUvBVUNtPxHDm899SsnLE+NZNRs4F6DZf6BToEvAeVUOhE3n1m+hG+zE7kgUvf6E0
	 e2XaEbcBeq48b5HDqPSS6TzMOAwrd/HS5o7T5GFbaSBNJlxsCTvA5PEb+ZLwSH9VEz
	 fIbLd8snH0NdATlcFodlV3KBzaSR6EAnYRtSVSsHrq7ybzS/EOcgL8VmsJmWa8HDLO
	 wTugbcybXmY0garocJy+KaFkbJamuw7NCOtyFf2/3qdsjezHUFTVyrDlapxZoghkoJ
	 iYNqmawOU5lVVB0KKn1CsRfPgVpSkEeLcv02bS2nwkwSIl+4Y+z8NGnunT0Q1qVXED
	 Tp2bipLEsKK7A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/6] s390/drivers: replace __get_free_pages() call with
 kmalloc()
Date: Thu, 28 May 2026 10:09:48 +0300
Message-Id: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3qF2oC/yXMSw7CMAwE0KtUXmMpTT8QroJYxKmhZhGQXSqkq
 ncngeUbzcwGxipscG42UF7F5JkL2kMDaY75zihTMXjnRzf4E1KP1gWHk8rKajj2xzBQSz6GDsr
 qpXyTz+/xcv3b3vTgtNSb2qBojKQxp7lGlbDvX0cQjGOKAAAA
X-Change-ID: 20260528-b4-s390-drivers-64795b1b2a93
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

This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc.

Nowadays the right way to say "I need a buffer" is kmalloc() rather than
ancient and ugly __get_free_pages().

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-drivers

---
Mike Rapoport (Microsoft) (6):
      s390/con3270: replace __get_free_page() with kmalloc()
      s390/dasd: replace get_zeroed_page() with kzalloc()
      s390/hvc_iucv: replace get_zeroed_page() with kzalloc()
      s390/qeth: replace get_zeroed_page() with kzalloc()
      s390/trng: replace __get_free_page() with kmalloc()
      s390/zcrypt: replace get_zeroed_page() with kzalloc()

 drivers/char/hw_random/s390-trng.c |  5 +++--
 drivers/s390/block/dasd_eckd.c     | 12 ++++++------
 drivers/s390/block/dasd_eer.c      |  4 ++--
 drivers/s390/char/con3270.c        |  8 ++++----
 drivers/s390/crypto/zcrypt_api.c   |  6 +++---
 drivers/s390/net/qeth_core_main.c  |  4 ++--
 drivers/tty/hvc/hvc_iucv.c         |  6 +++---
 7 files changed, 23 insertions(+), 22 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260528-b4-s390-drivers-64795b1b2a93

Best regards,
--  
Sincerely yours,
Mike.

