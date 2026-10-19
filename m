Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792450570;
	b=SBz+UyKPZWLgmWlHpXE2kCblGxTXosBPd7+B8NF7uUHZfGSlGWkMZ+gfGgoMC660h1O0
	 lK2b/9vEy5EF2e9yHjTp8iyDTcdt2cwjKybnoT/aiJwXrQyqXMH5Xj4+drhIImecBSZfi
	 3CttRUypnoxMeP3U2uC/gi7ML7NeprWlP+omopVDApeE5ZGmjCX5p7mybWo4vo2UIN0+g
	 9sMdVbR+LuvjS91yzEV2UVxLMZrMZjaMB7DuH2fHbouy4dzr9LZe/EX5kyX18KVKJloVi
	 AAlLHZCNoXeK+q8/5PwgCQMCdP7BHtraZR+lFPA+lq1Yd1SiAg5RdIyHZeeOJUh4XFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JQ17Ye4qjJesc7oajTqdRZkaPeMTHXbF5jh3TZSK5Hc=;
	b=hTFbDKHaBkLTD4xXZ9f/TH7XMEL+8rf5k7AHtyNpcp6v/9LGWvxziUMSZ3FpxAQ0Z37J
	 brHvQzbFZjqAMWHHQA4YiBpT52TKEWjJL+OelnezsxKMdwEVPHfZ5IwIq1SMqQjCqJwx6
	 SCczZCLQ78o+M8fzme3vdIuVYGik+Hxc23IlyraO2M6kbqXkiwZEFgOfj1rhwlF8pZJLX
	 C4QdAMbzXp5xT7AK9blR+gOnWsOSu6dY2AUcwVw+K5uodvh7bkLahtaJwMSGn4L2VPNpG
	 T2wY7J89VoG3qIuTzOe0+Q8yfoE7Oq64E2FTmDsHwyKEokQTeUgsMPmGcSsIm3xoPLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MbN/UaUD";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF1606A31A
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 22:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CF1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MbN/UaUD
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so19710725e9.0
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792450568; x=1793055368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQ17Ye4qjJesc7oajTqdRZkaPeMTHXbF5jh3TZSK5Hc=;
        b=MbN/UaUDBEM9EWrCHUFOXwAPxBqKToc1rA92rbGMpmsEzh54ASqrfOO1A+MKQsNH3D
         1pwYk7IrHlQ4uK3JQ6sw4R8vB7UIeMMghPDaLCWRQOlZuymeZMbhsx/dezoFanrd402F
         NK+MW3q6TiUR6Rm1rEBnpaLXfgaA5d7ujoxgwrCxEakIO3pb7JFHkTsJEV1bwU0yZA1l
         ee2qI+sq3MpFQsYMNr7UWZqmFBfNVF9ivixBdeqqL+KJEUT26X8AcYY2eldOX34h2UH1
         cijuw5DAkbdLxfkC2UmRiX9FA9dzN81wOHe0T+LnA418RDL9LTp+v71KDfyT01VPTFPD
         0vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792450568; x=1793055368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQ17Ye4qjJesc7oajTqdRZkaPeMTHXbF5jh3TZSK5Hc=;
        b=tvkc1KZCT+6fKK09MTMCmOYye5unYJZ/rakG4SmTL2sqUYlI7GfDmRG/BQQUI0QP/r
         X7zfLiJKoNasvvVVAQ3/WmDfOQWFeUZBO1pdXV9nDAPfWC9wzBmxxCG1XJ1EmPr0h3sv
         myweNs/z7Wn180EVcoV7oijf2bsrFzfGRtaRhOQhW+3pWbRdNz/nD+Ttk8QCkmaSr3en
         y+i2a7MQloQTpw5hYATdpW30Efb6XVylArkjwKu0X/yRba74QfUH0u462ZeDfwVQNk9z
         OtWb0wfI/kEHDB3dGsysylD5ADrWOSe+/1eN1aD6btoOV+vF1eBhiDTlSU3MydYzYMob
         orsg==
X-Forwarded-Encrypted: i=1; AKwUvByzw7toknwQMghrs0vuaB0GDU8tZHI0pzjjAkcv9HsORUwkP+jyA/oXTkLmDwKbnobzkHHBmFIVKNZ0@vger.kernel.org
X-Gm-Message-State: AFq9FYJXwBMiuVSXCVxyUPASXQANVG5Sh5VwF0XkXGAfqPSETtQqZHbB
	4EUpkzMmrt7jZzSLuvDBRVgM9AfD5DBc9uDXABywh3DtAJETx/zJNO4=
X-Gm-Gg: AYBFou0/Gf+zBc6FDEHnx0W6CAFnwAwMYHMOtOGbvuPP+LQ16FWFFr+zRFI5H36wK3/
	LRGa0qMNfRsPi273RK4vBtVVSmbs9T1W+rZmnvtfjZ8bJzoOuBM+0+iURGSsnsQfKMz0q32lRnE
	O0LUCl2o83SRdfXM/rKOPW4Xadtw2ff8OK4qs23PT0T8L38Byx/HYrSYyFw/LaJJvUadxAlFTDR
	r+4OYJCsoRsDcAgiIG1nKloF56t1HTXgDslkHlnPhAU4rJt5CQKFxLTM9nxyDSNjV8rMvrnAhan
	Vbs367JIrUWq5bMQia8/E6tpyKft0StufABKzvVGtu+gPEdBG+CesdelSoqBhg87olAc9Tnha1T
	HJ0wFxUi0sWG2dcZptRfnRiQk2yC+tUawmoZlr4AL1J8+TO6X7RB8J/mlNj1aFWlhZ+jpAeinEU
	Z56JvL1/lQCSIWGN298vwafYRoSvN13N6HRJBfxmA=
X-Received: by 2002:a05:600c:1d0a:b0:4a1:f377:5c6e with SMTP id 5b1f17b1804b1-4a1f4172b01mr10699575e9.7.1792450567871;
        Mon, 19 Oct 2026 15:56:07 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm25403155e9.14.2026.10.19.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:56:07 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Cc: Stefan Bader <shbader@de.ibm.com>,
	linux-s390@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] s390/tape: cancel delayed work on device removal
Date: Mon, 19 Oct 2026 22:56:06 +0000
Message-ID: <20261019225606.1864082-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

tape_generic_remove() drops the device reference without cancelling
the pending delayed work tape_dnr. If tape_delayed_next_request() is
still scheduled or running when the struct is freed on the final
reference drop, the work function dereferences freed memory.

The cancel cannot go in tape_put_device() because that function is
called from atomic context (under get_ccwdev_lock with interrupts
disabled) and from within the work function itself, both of which
would deadlock or sleep in atomic context with cancel_delayed_work_sync().

Add cancel_delayed_work_sync() in tape_generic_remove() after
dev_set_drvdata() clears the device pointer and before dropping the
final reference. At this point the spinlock is not held and the device
is no longer reachable for new operations.

Fixes: 4111796d89b8c ("[PATCH] s390: channel tape fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Moved cancel from tape_put_device() to tape_generic_remove().
  tape_put_device() is called from atomic context (under spinlock with
  IRQs disabled) and from within tape_delayed_next_request() itself,
  so cancel_delayed_work_sync() there would deadlock or sleep in atomic.
  tape_generic_remove() runs in process context with no locks held.
 drivers/s390/char/tape_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index bd8e3deb11993..cb5db2cabd21a 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -662,6 +662,7 @@ tape_generic_remove(struct ccw_device *cdev)
 	if (device) {
 		sysfs_remove_group(&cdev->dev.kobj, &tape_attr_group);
 		dev_set_drvdata(&cdev->dev, NULL);
+		cancel_delayed_work_sync(&device->tape_dnr);
 		tape_put_device(device);
 	}
 }
-- 
2.47.3

