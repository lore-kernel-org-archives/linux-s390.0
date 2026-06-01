Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019B2737E0
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780286905; cv=none; b=SRAMw9KI/al2qn9aL7ME0ky6zAUHnymOAHtsA/n2t84DB4KgLehO+WbABa0QZfUUChFYInP56Nj0hY+65omom4siXz28ao4mWTs+AGp+pmWBHQA2KGYGdRRmzoSEp97oZ8eXQppVt9BduH1CAO+ptj2zgaa+WUWZ4dsdh2DFK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780286905; c=relaxed/simple;
	bh=oJimIsAjTwG5Dit/F6xdNVXfNM3aibFK0k8tDI7amWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMhxl3tQuwNVxN46/cJ2i5as98B6TsXMFJt6jOY4oB9U7SgZqsZfqkFaMo/Is27IEf+Kc/tqV0e8BKcL+Q7+1MzXBtFoscXTLxteCoFi1ofpcPOn5xkwq/71oVakmhUpXg1eqlgGNbCBjgBvij1ZlIRNvFuotKTNc0gHZmBuyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDceongj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDceongj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85ba774551so97933a12.0
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 21:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780286903; x=1780891703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Fqls1Lkn4zrbHNsK46iIjuBoOprBS4OmT07ypRGlQ=;
        b=NDceongjF586QFYe31ZFLS9da+ygryZWIguvnWGNbzct/DWllhxyAuRrC/pMlloZho
         2/rwZiIN1r2Pezn6ilJyLjQHd4HrQoulIUuub2uGl+wfDcIuR3PDqf30AGdEQngJgRtd
         gPEz0jyeztkE3CFtBD3QP96vGgv3NP9qreIA3GcmWabZYV83zOc8SjQ4CUNP6ALqkE1P
         9TBVlRhdflwog9n/jeGQHGuuTQh3ejI5dWmfjq2w2ZFYnLmH72Ctaq84QJ9vPzfU3WBV
         l7A9rQPYOxtUaAD4iXP05N7GK2n2zIWB2Nkm9LqlVYKKPnZPn6agPy5EQTtNfio+loBP
         tRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780286903; x=1780891703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8Fqls1Lkn4zrbHNsK46iIjuBoOprBS4OmT07ypRGlQ=;
        b=ZiGFGV7hNGQOS/O6pM/3FuOwc4GGj/32PgrJYvXOIurBPLZ4UoT31c8Wq14wAfvlpP
         fheo5L369gBG3lFaqR9JJEFFnXh1S56LxCCW/hamnfDnlV8rr6j2CY9LV0V9EEePGySI
         XxakPRhhDNdY1AV4F3+vFUzvD6hIFEI5HNpBIarh1NSnCaypfOSzlpco1gY58nY+ib1N
         9WyENW6C2MaWm72MgjTvELRvmPVVR1MnXAiyvbis+tdmi6zA/nbhnfwrsf2ltgzNii4L
         V6M+on4AbvIzI8QfTtxLu17IqhJxwFi2BP/1V5Csg5Yxgga88CNgiXRcdVY3V9PCvkHq
         vwzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SWiOv7a6EsKdlG5S98Vn9hL2JfnMD0eVZ4VHz5mEvGUViTOVSp7EL1adCtp45Naz5GZrL5akCYVs1@vger.kernel.org
X-Gm-Message-State: AOJu0YwgrKoKOmx8QTpp5KuO6DNRC02O7Nh2U/4l+2WitUkfVBDvUlkI
	F35Czrji+8W4Qv0zE+cbytgtukVSe0y9mBCrF3OaaB0ocdVtmjQnj2UG
X-Gm-Gg: Acq92OFPNlDJ9RO8VfLRl1pqygxpADB3r3B3Zw/moJoRW9AuSHiz+bW6AjLRgptKL8x
	ien647K0mFMxR1eyvBTQTDHB4ROgZfKeYvKQ69NFjuvlbe18Mt+PqccROM3i7ZMeinj6xfkIdKq
	WtSP1jwaY69mi31mOv5xqDMj9UcMYQmspK8FSe0RlBbPQ1J1vu4HlIQmc3eFxM1SQZn7M9rzgdE
	SIJNoyd/WaY2oAgc0KSw/6hmQw/cS2N94BupBU+S1i8al8i5vwTipA6IdK1F65PQSXksxXBSFwy
	eNwMTFPvabkzyiZJV4KiFzSbBgmDYLjIRKFmxXkJ5N/zcDjwg9kdAqToXKuJzBKm1KIc92XDGkm
	K7Ya1kO4LAlBGUIndO7o2shf5bii59aM+m42Hxnj6D3I4uSDBl3JkArW9pBExa1L1P1JMbbQGj9
	EFbslP+TgeOIQWmfvdPkp8lFX0aRPse7fa4nlgu1+m1PAEl6hl0rWPNWCkiyA=
X-Received: by 2002:a05:6a21:512:b0:3b2:86e8:a817 with SMTP id adf61e73a8af0-3b42806972amr9448023637.31.1780286903228;
        Sun, 31 May 2026 21:08:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84237a41a3esm5017686b3a.22.2026.05.31.21.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 21:08:22 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH] s390/tape: avoid past-the-end iterator in tape_assign_minor()
Date: Mon,  1 Jun 2026 12:08:18 +0800
Message-Id: <20260601040818.1285976-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519100026.1970224-1-maoyixie.tju@gmail.com>
References: <20260519100026.1970224-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tape_assign_minor() walks tape_device_list to find the sorted
insertion point, then does list_add_tail(&device->node, &tmp->node).
When the loop runs to the end without break, tmp is past the end and
&tmp->node aliases the list head via container_of. list_add_tail then
appends at the tail, which is the intended result, but the iterator is
dereferenced past the end, which is undefined per the C standard.

Track the insertion point explicitly. insert_before starts at the list
head and is set to &tmp->node only when the loop breaks early. The
list_add_tail uses insert_before, so the behaviour is unchanged in
every case including an empty list.

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/s390/char/tape_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index bd8e3deb1199..361184c05940 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -330,14 +330,17 @@ __tape_cancel_io(struct tape_device *device, struct tape_request *request)
 static int
 tape_assign_minor(struct tape_device *device)
 {
+	struct list_head *insert_before = &tape_device_list;
 	struct tape_device *tmp;
 	int minor;
 
 	minor = 0;
 	write_lock(&tape_device_lock);
 	list_for_each_entry(tmp, &tape_device_list, node) {
-		if (minor < tmp->first_minor)
+		if (minor < tmp->first_minor) {
+			insert_before = &tmp->node;
 			break;
+		}
 		minor += TAPE_MINORS_PER_DEV;
 	}
 	if (minor >= 256) {
@@ -345,7 +348,7 @@ tape_assign_minor(struct tape_device *device)
 		return -ENODEV;
 	}
 	device->first_minor = minor;
-	list_add_tail(&device->node, &tmp->node);
+	list_add_tail(&device->node, insert_before);
 	write_unlock(&tape_device_lock);
 	return 0;
 }
-- 
2.34.1

