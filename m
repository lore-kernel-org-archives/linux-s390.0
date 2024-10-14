Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6544D599;
	Mon, 14 Oct 2024 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885029; cv=none; b=njRZcWw9vqs9HG8Ly1i8nb2UNSOudF6HLmT1NslJ1Rh0f/aDkmBfgQetB0XztERwBBg3eNtnyLMJUyHRWjxBOoBQN4uHIYAD+Ctem9Z94+XDwFxfLrIzz+7B9Opire1cSi1S0/hEtkKIMFBD8Y9E2Eo8CB/DPuXSOVaCK0y2KzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885029; c=relaxed/simple;
	bh=QlIXnWn+S44w6d2K96pP1ioQz2pYAabANfB5+Y8h+NU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QJUbgDD/dcXE2Y4DDi/o6Z5U29/CpxqJ8+h9PWTHR+H6FtlH4HXflfHe9xTDKPk36I+HZWikLLbsRUUs8g4gkT8lvAF3ae+WaSgv+heGOm+LuConiQixFZ5Xvp9P0rfKyoeRkk6ARxUQP8HqxeO6jlcIB6tpWHOW8uLaSXexoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSMYXRF7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MPM/tjms; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSMYXRF7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MPM/tjms"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728885025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WKzOl/U/ei8PcWQ8ZAhzDCcwCPalsZK9XuOJkZI+SDo=;
	b=VSMYXRF7ePjX8MYV+mBvbmgzdlch4cW+tZEnZGtAbNzEC443om8drXBfljfZ4OUETcsptu
	aL04h/NEVXFg0Z9oFf6dPbv/CUU6U4KIEOaA7XKHOT5npVzBXMczdMRF5VwNk2Ki8l4Fia
	t67lWzsymLYqRJxAuh9d3AKZqEJadvMV+GYX7qfbOxTIB/USVvqp9r2nfHLg6AunGEtCzO
	R5oubteLEz6tSP9Bkc0XEptoKTWtnGVkJTy/q9umUQznIhQDlymZ5U8IJfOxIwADMZJEkp
	vYdSRJSKEhZUqHfEgFHUkcJpoVIq9cSs++b6vIPtyXW+PmXICq1Fp63EBMwjPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728885025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WKzOl/U/ei8PcWQ8ZAhzDCcwCPalsZK9XuOJkZI+SDo=;
	b=MPM/tjmswS1EPKbeE9HjhFy0i/ls2Koa88Y1a53gK1xaNmmbLr4Fx7yU3At6fCwSMsgcYb
	o/55shCHGCoa6VBw==
Subject: [PATCH 0/2] s390: two bugfixes (for kunit)
Date: Mon, 14 Oct 2024 07:50:05 +0200
Message-Id: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA2xDGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3WJjSwPd7NK8zBJdE/PkpGQjs0RLy1QzJaCGgqLUtMwKsGHRsbW
 1AHXY3XtcAAAA
X-Change-ID: 20241014-s390-kunit-47cbc26a99e6
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728885023; l=708;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QlIXnWn+S44w6d2K96pP1ioQz2pYAabANfB5+Y8h+NU=;
 b=orf0zzIvq2s0qcuFNjI353KcdpMIl5XOr3T/K8ULk/CpCq4WDZNrUFBW8Cl6N++UAsMhhv5rJ
 I0EzZ3ZMjzZBCh6I3e/8P0TG+5yKkv4epfm16dSISnaLR6DjzPxmuEr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When trying to use kunit for s390 with
./tools/testing/kunit/kunit.py run --arch=s390 --kunitconfig drivers/base/test --cross_compile=$CROSS_COMPILE
I ran into some bugs.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      s390/sclp: deactivate sclp after all its users
      s390/sclp_vt220: convert newlines to CRLF instead of LFCR

 drivers/s390/char/sclp.c       | 3 ++-
 drivers/s390/char/sclp_vt220.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
change-id: 20241014-s390-kunit-47cbc26a99e6

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

