Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8111640B;
	Mon, 27 May 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817930; cv=none; b=lU/wrLRZtJ+SmYBcoN7H2IjMpISUmNUXWOmGcoOHCJ6t0xekUDgfpSDBCK2Gi3dqbVZl0R3sYVv2Cl35m/JSS7avHsW6hKq1xoDnOhbYFnX2aUNgJ0F2NehQjaK5ATbUlK0VXSmHaCllD2sAYmWs8u3IwfZNh9ErBqSU4JAfThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817930; c=relaxed/simple;
	bh=eFC+zHb3oIvVuWejIQTPDJ18pZsvb0KL90MlIxZI+JA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H/A2kxkTP93AX3zfTiyxv7xidpyqFzsfiJj7Y+24MY/gF2NiwHsAkAuTpGgIQLm0APh2hhmKFZa8Q5r/SSQdQeiuV4C1RCWTIthj0YDF108l/p346fahcRhBMzxGR6HCK1p9oSzJs53MSqc6knk8s1GeLUfPGOGlKM5mT3Ur8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bp8r3jv1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dpx9EAtY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bp8r3jv1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dpx9EAtY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bp8r3jv1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dpx9EAtY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bp8r3jv1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dpx9EAtY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4ED021F2B;
	Mon, 27 May 2024 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716817926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0DlpYZBKGdCoQoP2XdcpMMy4YA8iCzQ3r0sqemNzJWs=;
	b=Bp8r3jv1lf9v9SBj5hPeeikio3tNBZRNUquox2ZKLCbE18CZ06d9TMc2cOSBOc0ikQEc5q
	EtllrXgXTaNyEL7HX3F7s97EpwirsJuYtXJrQSZdtd2JfJNZA/JT6Z0DbcxOpIhsIz+W9/
	tutJhbSU2XpyYcyqN4b/wuCcpFu4Ioo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716817926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0DlpYZBKGdCoQoP2XdcpMMy4YA8iCzQ3r0sqemNzJWs=;
	b=Dpx9EAtYenuy8ORW58pQszD35YCrXuIQNPNkJlFakZOK5GyBYKN7zyJZJVNz3AVSgjD8tX
	hn+G7O96Fd3QOKDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716817926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0DlpYZBKGdCoQoP2XdcpMMy4YA8iCzQ3r0sqemNzJWs=;
	b=Bp8r3jv1lf9v9SBj5hPeeikio3tNBZRNUquox2ZKLCbE18CZ06d9TMc2cOSBOc0ikQEc5q
	EtllrXgXTaNyEL7HX3F7s97EpwirsJuYtXJrQSZdtd2JfJNZA/JT6Z0DbcxOpIhsIz+W9/
	tutJhbSU2XpyYcyqN4b/wuCcpFu4Ioo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716817926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0DlpYZBKGdCoQoP2XdcpMMy4YA8iCzQ3r0sqemNzJWs=;
	b=Dpx9EAtYenuy8ORW58pQszD35YCrXuIQNPNkJlFakZOK5GyBYKN7zyJZJVNz3AVSgjD8tX
	hn+G7O96Fd3QOKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0520213A6B;
	Mon, 27 May 2024 13:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GSjFOQWQVGZFYwAAD6G6ig
	(envelope-from <clopez@suse.de>); Mon, 27 May 2024 13:52:05 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: linux-s390@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] s390/dasd: fix error checks in dasd_copy_pair_store()
Date: Mon, 27 May 2024 15:50:45 +0200
Message-Id: <20240527135044.27427-1-clopez@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.20
X-Spam-Level: 
X-Spamd-Result: default: False [-3.20 / 50.00];
	BAYES_HAM(-2.90)[99.58%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

dasd_add_busid() can return an error via ERR_PTR() if an allocation
fails. However, two callsites in dasd_copy_pair_store() do not check
the result, potentially resulting in a NULL pointer dereference. Fix
this by checking the result with IS_ERR() and returning the error up
the stack.

Fixes: a91ff09d39f9b ("s390/dasd: add copy pair setup")
Signed-off-by: Carlos López <clopez@suse.de>
---
 drivers/s390/block/dasd_devmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 0316c20823ee..6adaeb985dde 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -2248,13 +2248,19 @@ static ssize_t dasd_copy_pair_store(struct device *dev,
 
 	/* allocate primary devmap if needed */
 	prim_devmap = dasd_find_busid(prim_busid);
-	if (IS_ERR(prim_devmap))
+	if (IS_ERR(prim_devmap)) {
 		prim_devmap = dasd_add_busid(prim_busid, DASD_FEATURE_DEFAULT);
+		if (IS_ERR(prim_devmap))
+			return PTR_ERR(prim_devmap);
+	}
 
 	/* allocate secondary devmap if needed */
 	sec_devmap = dasd_find_busid(sec_busid);
-	if (IS_ERR(sec_devmap))
+	if (IS_ERR(sec_devmap)) {
 		sec_devmap = dasd_add_busid(sec_busid, DASD_FEATURE_DEFAULT);
+		if (IS_ERR(sec_devmap))
+			return PTR_ERR(sec_devmap);
+	}
 
 	/* setting copy relation is only allowed for offline secondary */
 	if (sec_devmap->device)
-- 
2.35.3

