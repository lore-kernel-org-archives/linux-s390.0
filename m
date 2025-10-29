Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1252EC560
	for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706802; cv=none; b=iKQ7lOZerfFCHK7GrC3O1ULS9tG5hK2XIJV07sCOBqGq88DzWNYv6ZvSC+KXpSPvjaRQNTeNDuwST7fhaoP6GQWeFWRBoya5rBKP3nijMeFMg0Bg0jPOEbu1QiUz0s+tJP8KimJQJvAT34x3cl8Vr4b1Sm/pQTleSnh1sk4gKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706802; c=relaxed/simple;
	bh=uvWxTYSvYRprQ1ZW3Euflh2mgClxsjMln7S5s7l2A4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tvFLNIsTo3oRnfRHUj7VFiZ48WuYZlcWZNPtz2T1zvr3Fso+k6GJUeSfYp+7cCpMKrpHHi6OP5/iABlEZJasxFVQO/JLMVA2lDz/W0DISjnWLED4DSr2qQU3adY7ql5Y+op05I4GMRcI8yxjogtpP/D4e5nZTZfPQXt8JZwuEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtCq750y; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtCq750y"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed101e8486so17113371cf.2
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 20:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761706799; x=1762311599; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikVE0ssZ8PILuEq4k6Un4Yxlye8b1lZqi+jy3bbKHWs=;
        b=KtCq750yzMPqbDB0T+rDe5/DIlCbEsm60oNYzlPaDsnuNmnQPje3PncG0HV+7wJqoy
         GmOJBIEW2st+e0owkZgEsDpF88zX0Zb+MkqlLFwdoKDdL1RiIkiiaI8ncDw6k/8IC5uA
         TMUcvbpaqCxubrCEvsO4hdKvbnGCc0ceaqAXMq4Rd06jPi8+ugsw8oOgTyiQUYZUt6/p
         bCb0m1cCriaUFskYpq+KE6QKvY/kfiZ9uNsdoX47+VikXAzBHBaDQMAPyd/GEYL0eGx+
         ixef1QrjUe8ohSBywYOAgrriyDd5yWmuLZRRTr9fGLb9fqX/1px/vNErbd0xZylsR+Ey
         V+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761706799; x=1762311599;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikVE0ssZ8PILuEq4k6Un4Yxlye8b1lZqi+jy3bbKHWs=;
        b=uVM5D5vP5ytfRTEteMHYZ42sJsgQx6N/bU9u8wgYeEeV+DaClgfln507zu1CH0a2+w
         8owWNXiMNTvY4/6v3lWMBegg2+vTx9xedzDB/luWT8peTARgQQjY96RyZn7oU4A1BROZ
         4sxA/25Y2lPIbqN0u+z8oE48/vsSskfAr0/p0YBGUhn89+y1btEAoFlcme4iZrtPznaS
         mv75g+RsBni9isWEu3Tb6iQ7L9SihwmjjLqqvDJApfRdp70LrX/UdX1d+iYIYTbZoPWZ
         VJFFGye1jTcFraF3xIwVPp59NZnwnctHP0sZ0nBeiwpk5OJqaYD6NmEVTBCdaqHps7F7
         j6Lw==
X-Gm-Message-State: AOJu0YydLeVzdk1ZRnDrbCUG4NrRHrK06OQ562iZHDGrkdCVemN4hWUU
	oHpLi9TP10PL18dWN0xlGjJ/6PpKSnhOtHQiIn3+pn5jfY5LOWppPUxE
X-Gm-Gg: ASbGncu7IrSe2mtqfyV7KNuQtAXWkrwULQ+GSQaKT+jP0vuzX1ThVjWm+KT96+jeEhO
	LBzxEV1k5VmfWopcaVdNRae8tacXQ8MN47vuECiT/Hk8ygyg1QuFeCiF/pMAXE1K/SZbOwPni9p
	BuqR14N+mIh7OKWK7qF2ulJ/LKZ3TcML7T67job/T463e11VY+G0BBsHhs3RAVskkCv2cHFNcX5
	HstHNQKJwlzMc3FrMduOuSIkom1fK8JsL1ymxEKILENYzt/zup853iswR4bLWDCjmyG4+X/fm+V
	waQuOr0Lz1/FRyeKg4j7xlrnmrpLTyI2vspiXH6p7TMlyKPpp2DogqU/gZyUecnPpfnfvund0mf
	CnUHmpPKN4p+hn/uXPLz+62W0cDDQgTHna1oA7L/7MXejCmKNKLFtOQZUy+JZfNWYriAtW/sABZ
	+tI4kdeEw=
X-Google-Smtp-Source: AGHT+IEvOug73vtl4ROvl4ozZsUcProXlbhk8qKycNCnxdG+O+1krran8kKir/F0sNEdEd48ksbtCQ==
X-Received: by 2002:a05:622a:4089:b0:4d3:3ecd:efd0 with SMTP id d75a77b69052e-4ed15b32dafmr19732431cf.6.1761706799473;
        Tue, 28 Oct 2025 19:59:59 -0700 (PDT)
Received: from [192.168.90.162] ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49783eesm91505776d6.44.2025.10.28.19.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:59:58 -0700 (PDT)
From: Samuel Kayode <samkay014@gmail.com>
Date: Tue, 28 Oct 2025 22:59:35 -0400
Subject: [PATCH] input: pf1550: Replace deprecated PM_OPS define
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pf1550-v1-1-c50fae56b9b1@gmail.com>
X-B4-Tracking: v=1; b=H4sIABaDAWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3YI0Q1NTA11zw+TURGPTRINkSwMloOKCotS0zAqwQdGxtbUAZM+
 jM1gAAAA=
X-Change-ID: 20251028-pf1550-71cea35a0c90
To: Jerome Oufella <jerome.oufella@savoirfairelinux.com>, 
 naresh.kamboju@linaro.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
 lee@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Sean Nyekjaer <sean@geanix.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Samuel Kayode <samkay014@gmail.com>, 
 imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761706797; l=1053;
 i=samkay014@gmail.com; s=20251028; h=from:subject:message-id;
 bh=uvWxTYSvYRprQ1ZW3Euflh2mgClxsjMln7S5s7l2A4k=;
 b=4fOl76a+CJsXMrMz+3jonDtJ6NY+vU6ExNNoQfFuEd/1lba8UY1jfJ+UsD9eN1tHk4G1uPX5R
 14VlvMCGU0DDnq7Zctg0xOZZ6d15Bc2fsqI4Bw14sECTQ5Ysid+PEw+
X-Developer-Key: i=samkay014@gmail.com; a=ed25519;
 pk=favoK08ilD1j62PrGf+RHihBzbqJGWMC6f2nszR5UIc=

Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS as the former is
deprecated.

Signed-off-by: Samuel Kayode <samkay014@gmail.com>
---
 drivers/input/misc/pf1550-onkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/pf1550-onkey.c b/drivers/input/misc/pf1550-onkey.c
index 9be6377151cb3be824ab34ff37f983196b909324..a636ceedfc04f0946e002a0b1be4586138429f12 100644
--- a/drivers/input/misc/pf1550-onkey.c
+++ b/drivers/input/misc/pf1550-onkey.c
@@ -173,8 +173,8 @@ static int pf1550_onkey_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
-			 pf1550_onkey_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
+				pf1550_onkey_resume);
 
 static const struct platform_device_id pf1550_onkey_id[] = {
 	{ "pf1550-onkey", },

---
base-commit: a7d6255a0bf302c028ac680564633a6aac5f611d
change-id: 20251028-pf1550-71cea35a0c90

Best regards,
-- 
Samuel Kayode <samkay014@gmail.com>

