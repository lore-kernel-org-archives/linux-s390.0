Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53588267AF6
	for <linux-s390@vger.kernel.org>; Sun, 14 Sep 2025 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822198; cv=none; b=WuQZ12imt2cw5JqTdzs4mQ0eHcFxn0umPykSHJtRvKwS8lGEcDHFMijrgq/YL5nJCpHYLRyxmlooTKgUuXRVf/3qlP4VBMPQ/vJWMX8Gh11o5dLFRMoh1hIHjNx9ypfXzGaRiC3Bh/ErpcPbKC8gZzVdnawCHy1Z/uz2IbvFVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822198; c=relaxed/simple;
	bh=Z/NLntZrolo0ykWAS3sXBn6sCvdr4Jv7RqhYT4lljv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8J9GWdL/8CRFw9wmb6KkKTMCbz6d02FPGtFicavFvKsALVYuwI4rANT9dWFnf2W6rG6o0w/yZNEfHJVhIAV19pk8muwmQ5LF0TZG0QhWbPN7QrxyhSTKHVIFGE0L2r1qkmGQpzZNyeP+ZKWiv3+/NxgZPygYS7iBnl1lWnKz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/aQn20j; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/aQn20j"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso1757498a12.1
        for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822193; x=1758426993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukssGXUYVXOD0e/noqLCBxDtEOgQieVYL/7Zl394zX0=;
        b=B/aQn20j3rCcnelgL9u2/4O+eOA6v5R53N6bq1hQiG+7SX2YgByw2FYlpCjzRXxtnW
         pIRzVvX8n7M9DI69LAZpmiB7CJAX56lYS5GAnWBineIBTco+JP4EqzYq7o7yG55oCDe8
         35HZsaymtSR/LtZsodlZSGJdg2xL+mKPxTXC3x3PIWWX0RdnCd9MANmz+0g6uFYOpX2d
         3rA9ueyvK+Pevogq90X4nOo9tL9Xw/m1bpvd7pha0F23PnyPM528fcRKFwxjBXoLaW99
         q2nlq3MbEhp8qgVNZ+Ko7S3az0mFadW15Y88ekI0f4VwlPH9nMBsPF265pr4XPbH7gel
         ptoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822193; x=1758426993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukssGXUYVXOD0e/noqLCBxDtEOgQieVYL/7Zl394zX0=;
        b=wFD9S3PCRjjOQI78ZWFOqdxd+tRFSle9mnIR3DFW82PPMs3OXjiro3jyVvZ7ERUBFw
         r5JOKI0UczDqfMN6/MREHJGeKbqxHJuvx6gS8Syx8MFhzNgKua510gK9iTxXv0xXajMG
         yeV4HdMshJAzrv1AytUr+nmyj0HNw30saymkobSJbk4zRu5z6MevUafW1CpQYcQd2X/r
         ZXXPa1m4VIm1Ozq6p1GbBRg+l3SaDLEU+1+BmUGQBmLNdtAIfTn5xMYRrXtEl5N7sUdu
         z+a+bV+K1A3eGOfnSLm2KIUfRox4C7YQvhMFCdvN+Z+tCEcYYxF7FLm7FSSpV7WTMcsj
         OH4w==
X-Forwarded-Encrypted: i=1; AJvYcCXrQceFO9Mlc2kYCDwkHyK1iOyfKIKz2lJd++0q1+6A3mFcB5OOYQfXdrQ8qN9dcaG+ZhqjBF+EG8er@vger.kernel.org
X-Gm-Message-State: AOJu0YyARoHoJY92e7BD0y8d+i0HdpcwF61DmylgSAB67lVpXMi92cbf
	884He+7AWGtY3WE87hZstR6fGqxcSPdB7wmz1DxwAaMwHcuEvGP/q3KI
X-Gm-Gg: ASbGncuxGn1qPx2SUQ7AWwjdweTr6/srffbwbWOCmfpsLsWkWrGc3vCg8jBruzA0FJg
	GVIZ29kRuwY4GrZvyJwmQcL6yBiFHqup/w1lPszfcEwb9QN+M2m4yetaAfpQzLfMyR3o5K8hYiO
	upehQBGWJzAf/vc6NPVACsIjQ2BdqJXjm7hMNY+494i4+8l7A1qldF8dlW/sbRTpctxqNOMmDIb
	iBf4UW8i3d4t5rQP9JDZ8MXFooaWhMgGSmIt/UGTZoXK/X02CwEpatXOhhicpcStcjF0ids27nH
	1thT4yR551hhZd2SElA1CZoIxERoPNad7Z5bCy5nhLr32lqtxGpzL/XaqVK5YMFJsDR97RIZLSa
	9sRQZK1ifKZPYiASXsYQ=
X-Google-Smtp-Source: AGHT+IEh42ac6WqH282xp0DieWYXKfg+ycti4urbWWAb1GXqLLNoKNDdAlfHKjc5T4lrTIZzL6YLwA==
X-Received: by 2002:a05:6402:2815:b0:61c:e1d6:6bf6 with SMTP id 4fb4d7f45d1cf-62ed80fd3fdmr8226990a12.7.1757822192729;
        Sat, 13 Sep 2025 20:56:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ad2d6sm6510443a12.18.2025.09.13.20.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:56:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 48/62] init: fix comment
Date: Sun, 14 Sep 2025 06:56:26 +0300
Message-ID: <20250914035626.3718268-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make #endif match #ifdef

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index cf19b7c0c358..30e94ebf4902 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -717,7 +717,7 @@ static inline bool kexec_free_initrd(void)
 {
 	return false;
 }
-#endif /* CONFIG_KEXEC_CORE */
+#endif /* CONFIG_CRASH_RESERVE */
 
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
-- 
2.47.2

