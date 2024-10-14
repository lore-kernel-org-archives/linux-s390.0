Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70612CD96;
	Mon, 14 Oct 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885030; cv=none; b=LYk63/hH2u6MlDGAJ3HbeKxLISumYYNfLC3wjF/zgIHDOSZVUOzjrRtvqzeXLiVaBDBTWyUKGeOnILc48GLCEDeOfze67AsW1blBNJYcBK8kkw673aI9Qw2kAbT42Muun++/hxOhXGP059jNyhekU19wKQSvUyaEIjWhRDNIxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885030; c=relaxed/simple;
	bh=Dyt5MhyhGO3SmoG98QeDPkLBBgT90CECW97RdNnY04o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIWFkUo8lo5ckzX4CaAaLTwy314Q8bjN2BePPF2bqk+zdt6TGmoZIKsEMnkH0RHmSWvRY3XIi/q4U6N4AtQtDlFjVsbvz7ZW9nWkygHzsqmZ1qdanIgPj4vd9TldWY/kqCfH2/ITDG5xal/7ypx6ZZ2Sa+WdJ+px78XWxT8tUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKbf2Vbe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eviwaudt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKbf2Vbe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eviwaudt"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728885026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Wki/ePTip/6Lw7Wb59eoC1rHv1cVXfkYZvGNooR6cA=;
	b=LKbf2VbeKd7Xb7KITtZuTctd97tWcKc6xD1vhLNT3JxZPZt2bG5N9jSGS98rtdEruMYImn
	wKVmy2uxIRY5oLcBg+jG45p5Znf3KFoIlB/BTqCkWIBzykp0rrHxdFDrSrUcdCt68H5VKF
	VfPUuOHJmW7wYh7rTmumtokFULNklxWKO9cwkh9rZGncCYKhjIcKWUGZYQKwy2lR9Dup6S
	wVCNtZ75GSgXaYkHFyb6d9OrAC7I0o1RkcIqQD1Q+r3dYEUjGf22FpfE67i4E05OA9sdaL
	uO/G0GdoTR5fhgdmIX6ql+M+f8kUOpnTzHmk/GedPaMG9EPH7oO6KvMVYJYT+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728885026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Wki/ePTip/6Lw7Wb59eoC1rHv1cVXfkYZvGNooR6cA=;
	b=eviwaudtk9ZGiCKUt0q+vKCPbQuetfuWPjrfwerBnM8hNh6ftIaEd/yD3CxxhajxLdYsSw
	jhcKnrXwgCn6yWBg==
Date: Mon, 14 Oct 2024 07:50:07 +0200
Subject: [PATCH 2/2] s390/sclp_vt220: convert newlines to CRLF instead of
 LFCR
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241014-s390-kunit-v1-2-941defa765a6@linutronix.de>
References: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
In-Reply-To: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728885023; l=1942;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Dyt5MhyhGO3SmoG98QeDPkLBBgT90CECW97RdNnY04o=;
 b=dReodt8GrF5+C/WpiDGzIM9YCn8UUHcNnZP1tfgHw1+H/BVQ1+3pLLrCJqslX0F3CqVOC1T+i
 NNX1puWNbrDAYT7ZXj4ujjrm55pLSMgYiAwsFQ6VxXvaOK16VDvv3XJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

According to the VT220 specification the possible character combinations
sent on RETURN are only CR or CRLF [0].

	The Return key sends either a CR character (0/13) or a CR
	character (0/13) and an LF character (0/10), depending on the
	set/reset state of line feed/new line mode (LNM).

The sclip/vt220 driver however uses LFCR. This can confuse tools, for
example the kunit runner.

Link: https://vt100.net/docs/vt220-rm/chapter3.html#S3.2
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---

I'm not entirely sure that SCLP is meant to follow the VT220 standard
here. The only other reference observation I found is the QEMU code and
they are doing "what Linux does".
It would also be possible to hack around this in the kunit runner.
---
 drivers/s390/char/sclp_vt220.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 218ae604f737ff9e20764ebce857ce427e4a7c44..33b9c968dbcba6584015d70a8500f9f5f70227db 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -319,7 +319,7 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 	buffer = (void *) ((addr_t) sccb + sccb->header.length);
 
 	if (convertlf) {
-		/* Perform Linefeed conversion (0x0a -> 0x0a 0x0d)*/
+		/* Perform Linefeed conversion (0x0a -> 0x0d 0x0a)*/
 		for (from=0, to=0;
 		     (from < count) && (to < sclp_vt220_space_left(request));
 		     from++) {
@@ -328,8 +328,8 @@ sclp_vt220_add_msg(struct sclp_vt220_request *request,
 			/* Perform conversion */
 			if (c == 0x0a) {
 				if (to + 1 < sclp_vt220_space_left(request)) {
-					((unsigned char *) buffer)[to++] = c;
 					((unsigned char *) buffer)[to++] = 0x0d;
+					((unsigned char *) buffer)[to++] = c;
 				} else
 					break;
 

-- 
2.47.0

