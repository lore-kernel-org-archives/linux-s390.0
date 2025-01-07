Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B61E3DE7
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254116; cv=none; b=DdBEWTUbh3jYAXDsbQOEKZZbUEN6UvYt3BfYj5NskxuEbYuJmSXsi+84Q6F2b9bImR6dwpB6xnmfrTjtXQmeCe32BzqUj3bLSVNWRGIf8ZJvmU8snHCAA+S33csU8wFjMpYnNRDzPEdtMItlhWFg+CWgsF0001FauuhSn75Bnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254116; c=relaxed/simple;
	bh=PDKDOEbG5wLU1DkJmdPQNhRgipqYHagmRVjwHv2hyKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZEcaxDjyp/huIwW3I8qHXp4WZTqkkT1C2t5f7ElIij4Dby/8FqHh3ck1cVawSSvnMT5OdwHAr1kWFd4zW39RS2NZLWS5nLs0qA2CHDY6C2dndthg3axy3lKtUFxk4lgtZoeOG+73UkOKQuClXMMbh6n0++t83l925G0Mp+oOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Jpc4jVfl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Jpc4jVfl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso7186885ad.2
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254112; x=1736858912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=Jpc4jVfladyAFl8Ao1wMovzGshEbmS6vSc1Uor+uJtQtcHXCUw8EEj4WjYFELtmJMx
         XISPiWqX3QgS0H56CSdEXgsTzFkSP3k02iPt5xxnXl1F2uMWSExKnL7s3Ia1bdqQkKMp
         MhjoWz5MIx2QrVjzKEJXQnQtnlmcZ9M1U/Z1TRtZ3ajo2e3yksdm6mm/rOdyCmT1jPom
         AVsLM8p4OVn/CzS/CXRVOspQx1mlwkI1pED0g5c/AMW8AktmNKePOBVxTej00K4Gd50F
         zaQE2ZljXc1EkZRaIIhByJYJyYhTh7jiTvB1/vtRhzX6C2ksSCkbq+mMNavhXpHiRy+e
         qW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254112; x=1736858912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=AilXawkCq5EdeAam5zxkXO42hEB1IJq5qexoH0QicHqHqorCfT40xcrr7g9kaGmrgB
         /gpQQEM53m+RqI7hqrCk0dizc/VtnEhE72jpgMvs9riEXotaWO6Ht78RZ6uDKRm4ppOg
         bWntTn8bJdMLnTfW2GHwxuGW6hrW2nldJ3LiDlqOmv3HXBAHtFAiEV6rQHYBiCy3bOSE
         hdpn//AQKwl9oCRLxswfu12rLuo1syUcjIPDCWthouBC0ZC0m2/TSoKGcgVkaZwumQxt
         8vifSrgMYs34y5WAoxLIRAroYzP7c94JSr9WIQAUNzmqMkP1FL/9n7DZ683eCQS2Fzh3
         gMfA==
X-Forwarded-Encrypted: i=1; AJvYcCXqrWuoCPDbF3nS861uXptq/G1pMRKnuFamKJW20+Aev4nu3APBB1YHUWRtigrEsnBbg/QhhOD15BN6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2997c1/V7noyJ5p9eI9uMM97JTiqeUULrOl555nZ60jbhwuvO
	jdq3P9IyBVoeK4i8YAkGBIFpSEwepOMIMKDK729mkXapJCEvVJdDMy7mwe7FBOY=
X-Gm-Gg: ASbGncvP3JSjomk26Ttdm3AcaZ6lJXgH7+IvW0bkdBKH3djxvMMvCo8eUm62/MhX0Fo
	HUWrciq4J7nuNx9qzA5/lzUoMBNdWeqMT0VTp4EK5lMN8rboJ/S9aEIxm1Vc/uiH40/vYwCrtx8
	bhESl9UhIHwugScge2MxpQycAWfhN1pMZdNuiBoaiFfvxyS1iZK/jRb5g8DNM9QQx9fmc24FdXi
	z2sifxmY1s6hfXl56z/wtxQp90E4hnsi+xWssVbBJgMKJOKTcY4t5BX750=
X-Google-Smtp-Source: AGHT+IEgGWm+TwbUeO+9N7FURX28AGtJrPEUj7uS49yO94eCRFf85XIQjkIdMNAyflZYWE42i4plAQ==
X-Received: by 2002:a17:903:22c6:b0:216:2474:3c9f with SMTP id d9443c01a7336-219e6f38177mr919043015ad.52.1736254112256;
        Tue, 07 Jan 2025 04:48:32 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dca02f72sm310596305ad.249.2025.01.07.04.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:57 +0900
Subject: [PATCH v3 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-6-99cb505b1ab2@daynix.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
In-Reply-To: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

KEXEC_CORE_NOTE_NAME is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h       | 2 --
 include/linux/vmcore_info.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..c840431eadda 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -68,8 +68,6 @@ extern note_buf_t __percpu *crash_notes;
 #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
 #endif
 
-#define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
-
 /*
  * This structure is used to hold the arguments that are used when loading
  * kernel binaries.
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 1672801fd98c..37e003ae5262 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -6,7 +6,6 @@
 #include <linux/elfcore.h>
 #include <linux/elf.h>
 
-#define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)

-- 
2.47.1

