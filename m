Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5811E492
	for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091573; cv=none; b=FPqJyfZGZLEoo/ZO47HfRpIWaKhIGhEs74iwOHokzHPYRqHJc1jOeqJrwnaqFMaKu28ECVLCnMlpFRjy3zW3wqGf2d+uQzPy+l+x7qqlTc/tLroAGUs4IL5s79OtwtvOCJqrPMh4t19Hq7ZeBtKWD8LvTlwEAk/2ip2Ks6ZKPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091573; c=relaxed/simple;
	bh=twYFduWC9wJCrV9qqKjUJe/QHyM3m2kgSYUiYXImyBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sgIj6MafjeuUwnwaoawVEeaCO0p/uTAs/Pi7BcTerhrc4C2y5PoTjQ0ej3xerqnpdvf/mi1aHJdGgaEHZwiKWO0iaU9BHoCmkX4cdjEmqfga3BIroCUb+2NonDuYaQquN35HMqmys3AxSyD/SzvsCoueOxCoWeLlvnpylKEL4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRausBq4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRausBq4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso583818f8f.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750091570; x=1750696370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2K9WEA7lNr7K4DhnEavCZJYvbJZ0Xneo0jIPcE8RRA=;
        b=bRausBq4YYsPGYqGDeMRCMgpdbQajxxgTtJPiXiO/CxKszkKayz8A36Xk/6IPkwcix
         slGNC+iCBTF/CLsjx00gHh3w2gFhowjAn/m3npN2zrI7Safu3/z3Af4iszSWuqzdRP4g
         Ulrn0hkqS018kjTildYzAp5NopVe32c/z2WA3OGI4RoefFfpkZWCpWNGJfnUGWGhm248
         JpAs2Wx5DAA+k8N5k7iQ+aKrYnuJBOJmpK1NcMmFR9eW/QHOS8dpFfJ/1qGidFPynXAM
         N8TphUb3BYsUJgR6MC1ozzOIg12q8e0++SvWWcF/k7M2iyw8sN0NR+NINpc/lLIU0EyR
         haxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750091570; x=1750696370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2K9WEA7lNr7K4DhnEavCZJYvbJZ0Xneo0jIPcE8RRA=;
        b=f2HxwDLZNdlrETsXOaDrF5i5blezxZUAX2kt1CpwATlUGtT3vtf06Myx6cz7p1UXhK
         spP5wpvYyN2mf1nLGT2yohfbRlxiGhvfbOltvZJtq6mXQ18AAnOAWCDIhWuz4ANA84Hb
         cEWUfX5fv0PgWRO5/O/6VZYQvD5ccI7+VxKGxo4CLzw7BhAeuURnwxSPyWDY8lLMh0UE
         hCYioOvoAcXKhcdHz6iyeFg1MkMkO6WnVKnEUSu70pIfDHW5X98/JI3Rif/ZsaNTxHGu
         4NWkuj77wGvYcBcmLYRY78QTAGwZx+ShB32bPtPYuSs7iWwAb5c84WDriZ+YjC0ml7N6
         0QiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs/AJs8uvs0UCn4TG4ZVnkez+xF2KpcFym87FaPQ5wsm6P8Hw4AWVni3gtx/7u/YaqQd9BGViVaeK6@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyZ2BwFO2eKMj8YgJubk6ys//GzIzdfuLN3H1eu5Y1WzhgEUy
	hbXYaiCLf2FfX7yfyphEh9zj58M5zgCHiQPUwsLDX2f2TnW8t/BLiwM=
X-Gm-Gg: ASbGnctm8zm5ar5m/q/ObZZfJw8FAcUhy1FAeFUlFGxMGJmUec/Lq+0OtqLLdr4OcdA
	1iNmAWVzNImEQ1YN4+dweai2wP7JLnKrO0GWbN4eViJxPA+UUWIdUxRgkVHvRY+VEZBxWksmBie
	rOyjbIb2UDMByv6nd+DWOGIlFnBX8lKZg/gDFCJz5HEYHLEPAF9gieRItw002gj0o++wjr+A5TV
	XOsdsmHscZUCO6KQOW1eP87W4S4sYFv+oZGe0iucto1Zt/Qpfxy2kzgyZRTj6TYvGP7qD9Hlj7c
	lhlG00bhKuhCmKzKPw1TfblFTulqYdIJcOpknwX/abOvuejb52gDjVwSG4bW5iUIrndl1tObx3H
	V38Qsi/6d5fZuwJnY5eIVbV8lx+/3vVnPoN7Umg==
X-Google-Smtp-Source: AGHT+IG07Z/iJqXGznWLTbuyIJKwvq17rWq22mhGnNYvjkuhNpNKrYP93y3meOzAGbLAuNwlx3Golw==
X-Received: by 2002:a05:6000:240a:b0:3a5:3399:51b1 with SMTP id ffacd0b85a97d-3a57237a705mr3562215f8f.6.1750091569832;
        Mon, 16 Jun 2025 09:32:49 -0700 (PDT)
Received: from localhost (85.red-80-39-146.dynamicip.rima-tde.net. [80.39.146.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7cb65sm11691496f8f.38.2025.06.16.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:32:49 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	S390 ML <linux-s390@vger.kernel.org>
Subject: [PATCH] s390/boot: use the full title of the manual for facility bits
Date: Mon, 16 Jun 2025 18:32:47 +0200
Message-ID: <20250616163248.77951-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Also indicate the name of the section where they are listed, because it has a
length of 2124 pages:
z/Architecture Principles of Operation - Facility Indications

The current version is: Fourteenth Edition (May, 2022) SA22-7832-13

Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:3/4=75%,authored:2/4=50%,added_lines:8/14=57%,removed_lines:41/47=87%)
Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%,authored:1/4=25%,added_lines:5/14=36%,removed_lines:5/47=11%)
Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%)
Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:2/4=50%)
Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE)
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
 arch/s390/boot/als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/als.c b/arch/s390/boot/als.c
index 79afb5fa7f1f..7d4cec1975c6 100644
--- a/arch/s390/boot/als.c
+++ b/arch/s390/boot/als.c
@@ -65,7 +65,7 @@ static void facility_mismatch(void)
 	boot_emerg("The Linux kernel requires more recent processor hardware\n");
 	boot_emerg("Detected machine-type number: %4x\n", id.machine);
 	print_missing_facilities();
-	boot_emerg("See Principles of Operations for facility bits\n");
+	boot_emerg("For facility bits, see: z/Architecture Principles of Operation - Facility Indications\n");
 	disabled_wait();
 }
 
-- 
2.49.0

