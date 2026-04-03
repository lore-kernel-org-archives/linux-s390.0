Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483713AE193
	for <linux-s390@vger.kernel.org>; Fri,  3 Apr 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222834; cv=none; b=NidNXXm/FS3DO+JMzfj3AAPhSzKgZ74Zcnhpv7P/kr9CzWhaMW1Kd+dqR48l0mAstjtQNaDz9jcrtdbY11veJheLSG2HXL4UCFdZ/uchISCIGN0xZ9Id3xZxZYa9Tcxe4CtRy6uaFGJy6OP3OeV4HWfcYc8Vn3Owpd9UHsduQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222834; c=relaxed/simple;
	bh=IorhzViov1cVm9r/+KKc/l0jW0fISzzeOULpiPErfo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3AjJTt4T2Mfor5o/rbeqNWQklvwWMxhwqz/2AuZ9y1VQrNJGE38YG4ZEQAgFZ2u3peB6MN5aK/IqMak6PH/otCt0kz0wE1Z21Pb10nx5Q2/bYYmPwASA0isM89IjZmCYPYVb9vTb3t7Lme2rgp0YlOn2tGcHED1TmNpJhV5RGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nJeWPcKB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nJeWPcKB"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so2132292f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2026 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775222832; x=1775827632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGzKhyQITaXWpzFFDTEpEBEwEXBYoUMd6VEwbhJqhqQ=;
        b=nJeWPcKB5TnaeNBBXVNCeWWrAllvH557qIs3SIpdSda5z6xivxBTAFN9+InUMHrZug
         pU1v4HO2sUyzS5B3a3kkfL5XpXYceqA5Xy6ThCgpbOyQ61wkPdH2z1A8qvQxynL8Yb33
         QICWdwsDewLIPAjYu/gTcXMPWxpRDi2giNodmvoyptv0O5QZl+9IO3/M3mp2ZqxXzHER
         PL8aK2nn/AQFPblHIALGDaSoVoezHh1N2pURVxzvM9wdPyh4+mEA7C43DU8x87Y4r3Jh
         ri6840ZZIvCTgEITKibCsvaA28O0EJijTpKnfAU86id4FwQJ8QSxcEMMt056pgIvPFnU
         /LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222832; x=1775827632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGzKhyQITaXWpzFFDTEpEBEwEXBYoUMd6VEwbhJqhqQ=;
        b=itdGNhcL92Tq82u+l8Ue3WvFDnzAZ9r/ApjqW1xKfvP2cbXoMXDO+zY+QEh+7viMHu
         51lXtT1ezH1HlJkvk8YW+3yuWlfMj1oj/xQXyZetvbXn05ze5/F7Zv4H9AXJC1IvV7jE
         QFl+SofIOgvsOy3kbTEJMN2O2VFC+bnaxfCl5GTyDkKkvNlA/G0Uh9gVc+0J4XRftEjQ
         BvJwgD5VJf8tZA1T8KnZMYHPgykEFxm/URbflIFZsSR65+Qu6ZiOfYo2lXHJIy7Z+lU5
         2c2HKlFgcuf2nAVs4OcPISsIjp5D5aL/D1XuoXNEiQTzbPWV1m1W8CTGggmf6Z7SB1wY
         kaaw==
X-Forwarded-Encrypted: i=1; AJvYcCXpOzsRjV2BWvHT3nkIFoOvFm5qMAfOD1oD50inU96OTR/eXfCFt0elW1cisxHv3D6H3N4CrtiCBS5W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UKwBOYW2SVLsbqz2RO4CbUQxKe0OWptrY79uz8Rdgc4/b00Q
	t/h1vU1VRVeXezS5UIfiqiFghd8ohaNs9yHD0f+0Tt5vKa+g2iwAq3zWYfRhynDrgoWUI2WW89G
	aKg6S
X-Gm-Gg: AeBDieu5yyChJzC8Y1/5kX3d/3Rf7PrzabQt14V4iNGB25KkE7q1ao4stSevJBVJKx7
	jHE9IekGnfBpMCB14y4RUJeW5G0Z/gkrqxSbjCTNCHj3WrYUUMH7JsoUbb0ePYicG5WAX2kiu0f
	kkCv3Fd3JpPRe1Bf6Fly+KYsH6Lyq9Wib6w8AlGZQyJUT7o75jeszpVxJnrJau31W0lxvVtRpoF
	mweGiYFwb6VqeKwm8IJZiutoSFrQa8LK2Zh62PIU9JLm8LUyhQPJNcvxqFxb74OsiZDXMMVRauc
	+7iICfonEv4DcoKyKqmev9zh7W8v6ON4rBkWivvoNptJuq09h5D9vIh6yzk59BB6Tr++0cohMc4
	5qqOgHV99RVzvd1HfzVnh6GOXkoiy4I6Cl9Ld/lpKvsSk5K1nz3QgJvlOVdy3Y1if9uU21SZ9Ck
	DlCbFnaz3tSN3TM2iyDH/FGvet26nyuDG+AEvpCiOU2aY98XkDPa6/
X-Received: by 2002:a05:6000:401e:b0:43c:a352:c366 with SMTP id ffacd0b85a97d-43d290faa77mr4842051f8f.25.1775222831701;
        Fri, 03 Apr 2026 06:27:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm17839132f8f.8.2026.04.03.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:27:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: niharp@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com
Cc: claudiu.beznea@tuxon.dev,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] scsi: zfcp: Fix typo
Date: Fri,  3 Apr 2026 16:27:08 +0300
Message-ID: <20260403132708.2743836-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Fix typo in "synchronize".

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/s390/scsi/zfcp_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_diag.c b/drivers/s390/scsi/zfcp_diag.c
index 7be5a1d56263..f274e022effd 100644
--- a/drivers/s390/scsi/zfcp_diag.c
+++ b/drivers/s390/scsi/zfcp_diag.c
@@ -224,7 +224,7 @@ __zfcp_diag_test_buffer_age_isfresh(const struct zfcp_diag_adapter *const diag,
  *
  * This function will cause an update of the given @hdr by calling the also
  * given @buffer_update function. If called by multiple sources at the same
- * time, it will synchornize the update by only allowing one source to call
+ * time, it will synchronize the update by only allowing one source to call
  * @buffer_update and the others to wait for that source to complete instead
  * (the wait is interruptible).
  *
-- 
2.43.0

