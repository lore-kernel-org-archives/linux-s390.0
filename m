Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47B4D58E;
	Mon,  6 May 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014403; cv=none; b=Pglf4oYIJ1RJlFSAHIDLA3iXn0yp2Tp6wAmtxKndMRR86FnMxTu7kHFGlunrQ6k8kCINsBrHFY5Yr7y0RT0cnf67elWbZYegIfLCK1s0Ducr908/glOkEW1TMFWFqNCHFqXI80C+RNsTsfBzkEgxYSZYseBrYQ8UrSwcr4z+FUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014403; c=relaxed/simple;
	bh=l4IbFJnd58nxG6y1i71mGfGe/M73MbcutH7+7EWhR/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=peB75UC3QiGFJqJyypcHL/5wOaVdAMZnk0u364UEuCBAZYF2iIfhQCDR9t9oavQJ8en1im/iJc1BEq4gq6b7swCaL82b49Gt2J+Xv/PnLrwha03F6V4qdOKDWfN17UXqbl0nWdhf3Ikw3Th33zJ6P8pXOcYtN8yc/jwlVoQ58Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmjeh1/c; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmjeh1/c"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso2436255e87.2;
        Mon, 06 May 2024 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715014399; x=1715619199; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=070NvSbDEFlAvOM4epazgaOFQ758tENyqtrJCWEDvJg=;
        b=Rmjeh1/cxWdCE38OO8QpLzPNS/CcdVsfIE7r6uYAkk8AE8kpoBaufrri0+EM+aXBU3
         fnsOMIRj4JNjnDsup98P+ia5GBHMKi4+3hkvlTq1t2c8Jh9LBI7j9cWQfce1QFWeKZAd
         55COoL/wBqXpTfdq+V7TnCSu+kvFfe0RtTau/uzWke9SZbf+AF0PLqBWP1WIpaQJA69l
         a50YPPRahU6Ri0KOcFUWKW20sLJi79mtUkNDWgrW0XnARcB3jua8B+Z3JZDlBo+DZ41H
         LQKpHLhtLy2dB/IhAaq9uz/fXYz1Hj1uM/3rDGbD5N3BNe7m4RCAbSd9zgneZFLEpxFz
         PQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715014399; x=1715619199;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=070NvSbDEFlAvOM4epazgaOFQ758tENyqtrJCWEDvJg=;
        b=tustXkwy+UcYggCGzwor4SFZMvcdPpcsX6NEYYfeyGPgPr6Jmq2dypAlkXsb8LhOGW
         SGqOZ5kaMFYmx0uXTtg/er9UYQy7RgegYOknDe7vP3iShinnI2WY9ybxWlAovi4NZAgZ
         aTE3iAhM35bNCyYt4KGgGEyDjtYTRh0S/V15xsRmAjW+QdWYwfnE0LQ8LR7S3ZKWQrS6
         OgqnpCvkENFHVNR2NCFSfyARhqPSn0Rq9t+xjxOohgChbCgMcMhMbB+0IPj6RCOCOzG3
         eALSBW2JCmjpO6JljL3eJ1wFciHnDcEq2a8c3vDiQFcL2brRNwnRaw7kfu6lOONOeMLq
         OsEw==
X-Forwarded-Encrypted: i=1; AJvYcCWqYeAPwGuEK/VolUb8G9AERwxRBhc8p4I0WZFhL3mp/fifR8T/5aFBAKf1jYx4JQi5w4mriMXkzrpqh+3HtXcEiTdDfiJdIo+hr41lxFRs9VFMVbojU2VN0UU94N7Leh0LnP3Ew8Ib/A==
X-Gm-Message-State: AOJu0Yw182ZMWzvCpF5eRaHK8arYfMlkbWpY5g2A0vFkDsj4vz/uZV75
	7irqlC2Y62K7QeRl3eogjlAr6RUjdBOnYTikqo+9X2asfpYSuaI=
X-Google-Smtp-Source: AGHT+IGgbbPKOdDhy9Ja6YkFrIxuGZYyNAbhnfkB/b6pklaRezusNozUWGa3fmJz1Uv5LeIOL/Hxmg==
X-Received: by 2002:a05:6512:3f21:b0:518:9b42:b846 with SMTP id y33-20020a0565123f2100b005189b42b846mr9190340lfa.21.1715014399108;
        Mon, 06 May 2024 09:53:19 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b0041b43d2d745sm16702403wmq.7.2024.05.06.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:53:18 -0700 (PDT)
Date: Mon, 6 May 2024 17:53:16 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: svens@linux.ibm.com
Cc: borntraeger@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, agordeev@linux.ibm.com,
	gor@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH]  s390/pkey: use kvfree_sensitive() to fix Coccinelle warning
Message-ID: <ZjkK_EfK9L5qMksX@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace memzero_expliocit() and kfree() with kfree_sentive() to fix
warning reported by Coccinelle

WARNING opportunity for kfree_sensitive/kvfree_sensitive

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/s390/crypto/pkey_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index dccf664a3d95..76e98275f6ab 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1503,8 +1503,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, ktp.protkey.protkey,
 				       &ktp.protkey.len, &ktp.protkey.type);
 		pr_debug("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kvfree_sensitive(kkey, ktp.keylen);
 		if (rc)
 			break;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
-- 
2.43.2

