Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092091E4A4;
	Wed,  2 Apr 2025 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743635725; cv=none; b=Cu9AdQvWE/C16w1SBr8IDy5Ewhux6za4QXlzRC5YYHlOq+Tmp3QRPf9YUwyvTW7w7P5jBoo7Rr6vd9OAnSXua56/NYCEbTkUs1gwF9G0hMMk2q9KrEcwpxzCAnNA6JOXLZLN1OjEb+nVdhWqXtcdHGeRdhGr9Qfgynuq4/FEgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743635725; c=relaxed/simple;
	bh=wopiahh7HeOH1pqXjqshlIKTF9TiCQkO3PM56q4nLcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ytosj0DVllAMMKm1YAj13O2P7PorarJOPeVwkYsCUYEuZozqWF8fhqKzCXyKFMypQiGovT6MXaoHycrwiBE3Pt7K8R37cpNlYXCb9t92ThxAKYtOLNHMZCUf6SyRCgK0y6bvEnDpUmEZM1eG+gP+g6FcGrpfps/TgFaICJzt2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1DZvw1D; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1DZvw1D"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac34257295dso55260566b.2;
        Wed, 02 Apr 2025 16:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743635722; x=1744240522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Re3At2LIdr3MH8poGKxEc8VAoYJtk80ZXXMm4kh2d5U=;
        b=B1DZvw1Dk1NgtUQbvEZt7i5dcWhrMAbCrU3VsTgxFcK+kTg6ZakawAWZv7rSaf5mC/
         hX76pDlhb7e5d8zOBhW602l9xagblTtInGOCHGDShyZhMYl+kIO5kW2MihbiWMbduEfn
         LcCR8G1eZWBCoso8mzDzaZxW8+6t43zZnA408kJlymNzNB2gQs+rH/alT1z7GyV/q+ZY
         0Qdk3w/PCKUUjcK8n/5K2AnM6EGJw63bByYPta88rhGalyGLj48MyV0+G+MNwMnU68H8
         AQjGqifYTTFd7icoVGsAg6lPNvVUF8pLEJqg+MGr9yYwoTF1NhKiJWWWL/2M7kiCQZPC
         N/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743635722; x=1744240522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Re3At2LIdr3MH8poGKxEc8VAoYJtk80ZXXMm4kh2d5U=;
        b=QOtuq/m+7gKzaN84E/Qszsabmy0n6q8OGHAMJ8+FmxAGSeaxd5wS6SOPL1gjVaNMXf
         UWBjBNqCf65CkPxAio0+T8gncGRBNpOyncRB8TJ5eURR8fJMbSAr0FgkkvOlukMXxrPe
         Wj8KySNU1Bu0q6udTJMtWNvUR429Eip+qXjsk2ozlNXp5Q0ZH3FNFY2dEswjOb99y4Fy
         JEuX0LL9qqYRqllCOeQxu+/54srEqGYN/CMtKX8Z7kwvSIQOkayeizu0PtHnPDxlon8c
         pjFbY4wzCCxGsu2VZBMGSjPBvzdMx0uHrCqHH1w1f5EaRGKj9J2h1BmWwp04p6Srm1eT
         7dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD6VdbHLqzohjJhv2u0U9ZPMu/dDFciser17URWlqG9DptJ5oHLII19Spus6/YpOei8OQWTsNaTICGZA==@vger.kernel.org, AJvYcCXt8N6FnwGEZ3i8gb2LbkgmeIGmSb1HHR8hhla1ciupONEoERandH972TYq3V7CvaEe5IX0YwmQf5FbItY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cACkmZVwAFp1WEGX0mg4p89OEeO0EAR4kN9WjOshs40xzjHJ
	tmigp4oyjAZDnkk9lnYabP7I1Up9Q+HXUTA2Z8DKqLY9wUnnumRwXyRQBVR3YfOUxA==
X-Gm-Gg: ASbGncsHnvrqV8H+e/sGUAPuUUqGNujcwVxBtf7ZxRxZ0Znbbr4BqMajekpMGSwQD4j
	s01kRt6RqfM9JAVvgaLkClwug8EPEDW98g8mf6JkbxV74UL0LsolvpdZpAj7pEH6//F50XRHaxH
	Cfj6NHsp03gePtrjVHAzY9WkklKHwl3PGaMMyYj5pMAYV2zYjk3xP1Vhdwbcsza6SstYUw+Q0Kg
	sWcMhzhowiheiaB+mg+XKoj4hWDuPWOilX6ADdKm8AfCigAdbLb2FUqnrHzWMeoX/44QmVuWcMJ
	v5uD97axeV4SN/L1KwWl0HDAQfd4cVNnZwN2xHG/GZoiBiwFzNfP3N/mOYc=
X-Google-Smtp-Source: AGHT+IF2y9Sff6yr9ULKxR1iSNk2yKG2X6bb94ewdbZD/kmlZIDGChEY1I3eUQCq4D+B+LSTZXa2iw==
X-Received: by 2002:a17:906:2351:b0:ac7:3916:327b with SMTP id a640c23a62f3a-ac739163359mr1470226866b.58.1743635721899;
        Wed, 02 Apr 2025 16:15:21 -0700 (PDT)
Received: from localhost.localdomain ([5.122.63.66])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d794sm1448466b.11.2025.04.02.16.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:15:21 -0700 (PDT)
From: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Amir Mohammad Jahangirzad" <a.jahangirzad@gmail.com>
Subject: [PATCH] s390/boot: replace strncpy() with strscpy()
Date: Thu,  3 Apr 2025 02:44:34 +0330
Message-ID: <20250402231433.117505-1-a.jahangirzad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Amir Mohammad Jahangirzad" <a.jahangirzad@gmail.com>

strncpy() is deprecated for use on NUL-terminated destination strings
as it doesn't guarantee NUL-termination when the source string length
exceeds the destination buffer size. strscpy() is a safer alternative
as it always NUL-terminates the destination and returns the number of
characters copied (excluding the NUL).

Replace strncpy() with strscpy() for copying the bootdebug_filter value,
using sizeof(bootdebug_filter) rather than sizeof()-1 since strscpy()
takes the full buffer size as parameter.


Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
---
 arch/s390/boot/ipl_parm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index d04e9b89d14a..8b153f7b4112 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -309,7 +309,7 @@ void parse_boot_command_line(void)
 		if (!strcmp(param, "bootdebug")) {
 			bootdebug = true;
 			if (val)
-				strncpy(bootdebug_filter, val, sizeof(bootdebug_filter) - 1);
+				strscpy(bootdebug_filter, val, sizeof(bootdebug_filter));
 		}
 		if (!strcmp(param, "quiet"))
 			boot_console_loglevel = CONSOLE_LOGLEVEL_QUIET;
-- 
2.43.0

