Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540917BED0
	for <linux-s390@vger.kernel.org>; Sat, 11 Jan 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736574578; cv=none; b=MMCor0o5nzIzeNkOCsf02qC1WS8jbHGEf3/Vh2mXaDdBw9UDbbHupuLRldYFPO8ey/xyCH3Xqaw4RuAg+B29fJ0VDU4jx0H72on+LZJqRWOLjhfSJ1Mjuuw5TI79OnbGIJuRvL+hucICWALUomznT/37frMsskDhBS0MKRUtaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736574578; c=relaxed/simple;
	bh=PDKDOEbG5wLU1DkJmdPQNhRgipqYHagmRVjwHv2hyKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0DOR5kbgJhrDKWT58m3dxbbSJV53C+Om7ORtyaGlGi2jY+ofM1eCHUwm7sYQgikR/pskX4lb7jTBPGSJl21HWsrUBv0319h0IWGnRpRfWNQvG4I8AMOO341MBUhr68F1Xb8bVX63UxVgMYPEfayRrEc2IPMpqACXQYb8Hcb+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Mrk5pi5+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Mrk5pi5+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb95317so46355575ad.1
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 21:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574576; x=1737179376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=Mrk5pi5+LgbSuRWkugDhBASfg1fK14Frvx5xX58x3XsJlHhlhBseJCt/8a9h95QYzM
         xaYQ9Rx+MlCwUhjrlZ+YvdpjdgWzttjgNk0KQBWEtAlfEpq98sgViacNihhQi3UmMAAK
         lXRD4LPozpNnrGFygpu+mBgZ2KRewOVR+XHxwfXFaykiMmzX5xx7oIh/DDsYXXalOjsn
         6DHn+qOCPnEqQIwkEYVh1hv/MXloWPHgR47uOD8uDZ5Ls6Y9sq+fEP2btlq2Ira97igG
         kIwKvrkDr3BunoQIRQJD85rsxBvLYWbJ3lcWn6Or/f3RsSpvZPQxV/yIxGqsxnm+aZBs
         zjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574576; x=1737179376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJIM5PjsK5XkECqCUUoGiieCybrsun7CzYeIZbw5syM=;
        b=GE246FtEgo3xiuDGlYCykPyDZHlgGeZxFy0I4RkM9V73tRiXEw5r5uYsdENASuYLOr
         WHWNbdS1L1kmSgQp1m+vAwPdjRDAQbuksM3Ft0s4vxRVzDRQkg8gZa873X0j7DLPvjhW
         UApVVcvvxc7VICgvnHCh5UPIG2bkeNLlYRPgyUtj/n1DAj2ILi+LagL7oXixhM4sf9gF
         Zq6CLa1LZgfRW8MId+8ffsZNcOBE8SpxNKl+HlocRPjxj0nxICfQ6vF37KfvgXE00zBV
         tEKBP0ivTRG4buE7BbNWf4jU6iHA7eF9gOJLawYadhltW22DcabVTED9KeXPfH8Unt+l
         +JjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMAXpa2FbGypnnjgMgKv1JqheAQoWKucqMs40CJ3eoYnEQ2pw28tSN6P6kVNFjDECIk7d7yzrr9SmC@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXESoL3tv7iNjVadV6HY+LyAI8QLbHOwF4II+Y/vrMbAZaa45
	ynM5qww1XM0Zu4XFVHNfIP/kLckBSBRSHSYkrFhYmjD41zZhGyEaDjc3fmhGWto=
X-Gm-Gg: ASbGncuSD+mJ1OtBLU9l3T/JTog/50qvvWLJKypjbdeINyfnIfyt+hzC3QjmBsflFyC
	9kzxkx3lbZha0vltbVhY2leMlvG0BSeyRmJLIyL3u8pY+fzJ4pG3pgfPiZjEpGfOZq0rrLlz+J2
	uFDp4qBmuvbPvOoA96Cl0D2LWs+9tNbhSKe0lvdPyOaaCi2TrFEZCFNT0vZpRfbaK2DykBo+xiL
	0iN72uBrucV78oyg8zvaoC76dl2jg8e/ty24mHVkvhdjm7QoQNist0Shbk=
X-Google-Smtp-Source: AGHT+IGdQ/W+GdFqyOEQRaBJtYEIC3d/2Cs4dWBSsnFKDdtRyf3/E/GqQ6RNXv61x1Bb9PKDJOpeZw==
X-Received: by 2002:a17:902:e552:b0:216:2426:7666 with SMTP id d9443c01a7336-21a83f36f14mr210827905ad.12.1736574576473;
        Fri, 10 Jan 2025 21:49:36 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f10ddbesm21468195ad.2.2025.01.10.21.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:49 +0900
Subject: [PATCH v4 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-6-b3841fa0dcd9@daynix.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
In-Reply-To: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
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

