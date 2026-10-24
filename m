Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852962;
	b=HF+ji9d6cLrcUvd5qViCTGjnz3BjHI8YA1NSEYH1hOCKBKveHk9qY7swC4ozN3tIZMpZ
	 oP+4LP9awVqnHgKJOseUmYnAS8aAAsCAl9zKQQbNJYsJ7eDpY+cBq931u9t0rEK7nUNd+
	 tkwiLEXA02O6KoTvbzEDyNJq8xrPycUP/trSwNo9vZmqAvmoj4SXxY6exLRGRLFN/7LHc
	 Hph9eY3AzPEjxYVOTQsI63fKc0L77EDWjsbw8oE4AC5VdPw8dUfbLROhoKmcatzA856hc
	 4/meqmAkvwFi3Jy4ZX3k6SjIy3cbKErKox7vhi19fqRZ3ElCOvRTWOOK+csh+WWzXsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PMADbAEFiFFjIppWSmKDfBcECya0OZ1jzyZVIef6xTY=;
	b=He3lgvvYuMZIVT1ux3/4fNzzTaDng/p96U9+IlJX0I3thN71Eqt5rYbDS3kOsEy1Yx3V
	 7bZu2IDCEK09sav5KxnvaI4mvq8Xd/n42saFsXVqU9Qi1dw1/U4mTKfm3KmFjWDIKnDBl
	 z+JZtMsS5Dql5zZvWGTXc7++4HBE1qQXr5kXlDeJEPIsUNUdPOSTE8Y/hZA5upDr/RO2u
	 bgonlZ4VDHJWDUqs9MS12FDAArW2LPwUOWCD9s+v1ocys/9T4QmVdH83Zn1bDpXY7Cb3I
	 x7DmWowaHOX7eL4QxQf4YasHloyuJv9q5KGWkT6mP9sXwJAm6vTLwID03Usno/zUqSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEP9aKIz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9562A606A31A;
	Sat, 24 Oct 2026 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEP9aKIz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A2A671F01825;
	Sat, 24 Oct 2026 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792852961;
	bh=PMADbAEFiFFjIppWSmKDfBcECya0OZ1jzyZVIef6xTY=;
	h=From:To:Cc:Subject:Date;
	b=JEP9aKIzNH4xCXWc2hfIK2t5c2P+ZhO7/QcvQJSjeiqxUpQg+ZGQGVQd2cQtpnD1G
	 rH2PK8Q7WHZGxvo3rr3Hna95QCgKrDu0dAYrCDkppgwoJ+Bmff6Q4Y3R5aHqM1So58
	 IqLya2ku1LtJbJFv20T8eeVho922exJ2zDA9wwg8jnbsqKQYkLGtATiPXlpHnTRivn
	 l9Q9kbE4kiJSp7Ndo3Yvsx9u8hy+KDe8GLGwNHULupZwb0n1P0FnhxsZbAmwvvsS+I
	 tL4kkzAhw5k+fSRECpdqR0q4AsOLorrrLS6RL37SdJGVxnDDmF+1LptANm1IebgRQj
	 or+D5P+PtD5rg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Anastasia Eskova <anastasia.eskova@ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/cert_store: Hold the keyring->sem while invalidating keys
Date: Sat, 24 Oct 2026 17:42:25 +0300
Message-ID: <20261024144229.1546151-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

invalidate_keyring_keys() does not hold keyring->sem while calling
keyring_read(), which is contrary to what keyring assumes from its callers,
and can lead to reoccuring bugs.

KEY_FLAG_KEEP alone does not e.g.,  protect from  the following call path:

1. keyctl_keyring_move()
2. key_move()
3. __key_unlink()

Address the issue by guarding the critical section.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
This came up as a side product while working on assoc_array to
rhashtable migration and going through various callers of the keyring.
It's made by me but please keep in mind that I don't even have a
toolchain for s390 setup so it is based only on reading code and I have
not even compiled this.

Just wanted to clarify the background for this fix as I'm not a regular
contributor over here. If for any reason it turned out to be false
positive, I'm fine with that too.
 arch/s390/kernel/cert_store.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 998f2da56175..d35b1ea22507 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -18,6 +18,7 @@
 #include <linux/keyctl.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -320,13 +321,17 @@ static int invalidate_keyring_keys(struct key *keyring)
 	struct key *current_key;
 	int rc;

-	keyring_payload_len = key_type_keyring.read(keyring, NULL, 0);
-	num_keys = keyring_payload_len / sizeof(key_serial_t);
-	key_array = kzalloc_objs(key_serial_t, num_keys);
-	if (!key_array)
-		return -ENOMEM;
+	scoped_guard(rwsem_read, &keyring->sem) {
+		keyring_payload_len = key_type_keyring.read(keyring, NULL, 0);
+		num_keys = keyring_payload_len / sizeof(key_serial_t);
+
+		key_array = kzalloc_objs(key_serial_t, num_keys);
+		if (!key_array)
+			return -ENOMEM;
+
+		rc = key_type_keyring.read(keyring, (char *)key_array, keyring_payload_len);
+	}

-	rc = key_type_keyring.read(keyring, (char *)key_array, keyring_payload_len);
 	if (rc != keyring_payload_len) {
 		pr_dbf_msg("Couldn't read keyring payload");
 		goto out;
--
2.47.3

