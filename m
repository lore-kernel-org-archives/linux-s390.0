Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB29257842
	for <linux-s390@vger.kernel.org>; Sun, 14 Sep 2025 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821837; cv=none; b=qgMQjHcEAqmjDesP2tYNB1+r3tmBt3wm0ZV53O45GYZLo7Yc71SLo8Cd8GM3DzkySyCIR1VvdoBxM5tohBHqSwcju7b3qXy2E2ZiEsnPS/OR8JPSQ42eC41dNaORq9efW8pDIw4njdp4j912JqWH49uED6N+ucoONOBy7Gzgcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821837; c=relaxed/simple;
	bh=UKYo3sZQHTOBTzj/ZrSKU3L73PiTPpOmU1LUHeX039A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GK6AhrT4CtFzV4yCkiV41beqDIC4yxxvM2bMGNXClfOMmlnigFT6eG9QP3KP97Wr3CoF2fcLr1exOmUFwk5PKKcI/K2r3JcrAtfvWBw53VoYYGjOgwzBmmNG688p8tUIB3XXz7Fp8XBPmYezjVC3sLj5rMg1vtCcbnvG7r8LL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1P8kBWK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1P8kBWK"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso2845640a12.2
        for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 20:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821833; x=1758426633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xULsRy9EzPzDuVUBFXoTlnqFZHMdg+FSwp5f1Vonn0Q=;
        b=a1P8kBWKhC/YGuTQ1qtgdu/eEmNliJm6xmjHlAYF/nZVCc+MkYl483G0Hq/aOPOuVQ
         co1t+z2BxO/DqCnrZV/EXoLvGXKtEHZqFdATOOJ7EzTdu3MgJ41k6O6rnPR886VF0J+g
         jgvNa+Ki1aT0KILtz2E0BMca3UYgzXBOakUCCFuFTU7ebx7Nd0hzzslIgv4hyWtZH0Us
         YbZQmnVSwIBoXEECRLCw5/S9dNhg9pi/sa5YxeFeAtv7H0GbAy2fZWrU6+0CkFOt7mcb
         RR3YbY8LMKAJx2sciiyJGNfQKUPjHVakvWWvmZVaCaVDH0xUngt3/RwvkIeU1VGaFSWY
         JGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821833; x=1758426633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xULsRy9EzPzDuVUBFXoTlnqFZHMdg+FSwp5f1Vonn0Q=;
        b=B1dS/bs9+g50tdxfn84Xs03uu7d4QIU93po6GAlAteUaj8YkLZE0eH7QMEQu3VZ7Qq
         IvQhQYRPJTOPHF6/oMscvDG+lQGjdMckiHSODsXVwtTEUls5mIb76cFQaobOjtPvdfDo
         aPPg03rta+FblOW0AwlxQkFLaKCPiekD2O9j7SQXYGg00e9qAIAZDMaFADHH512PH5MR
         JWo+paRNTfrGrQL1Kqu+t7gdc7zTq5/rwRzSR4vohF8MY05r6RoVujox5XWT010VGYI8
         0xnbbZTmvPt014QX+2b+jfSlAekHySnjng3LHuPey8tIOJjekhQOrlssZ+J4FAaVFmYa
         JHtw==
X-Forwarded-Encrypted: i=1; AJvYcCXfFqeFQrq1QaSznSEw3VfLto1Q06Db+0+DMiCEChf1u+Szl1luux/W5CR8j3kHYL6CgD0rFlkwQ+28@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr91Y0Snf/jUBTDVAIwke7uaFIcRjnKU73lb4kkt8dSwddAQp9
	yUnw5FYIvEuZFsy8r2cttrDR9DdjHyAH+5hPB3aBbZ4Z4FELg7nQAWW/
X-Gm-Gg: ASbGnctMOOsj7L/17GTeGdtNeDeVN4apwB6TO2pjkB1r7MaxSU+m+Zvm4Opi6U2jEwH
	osDgLTWQeBFtgwA27ejNLLhD0wk3SZ/sWsrc/lx3GnDqV2eM3Czdk/Rql8UWtpw6uMqvOe0vL1C
	ftVP87m0nZA96WMePueZcgwNirtPaYcyLU2v+eUQTSfPFSLpHaU0JeVz5MX0/fLk7QIt7F2/ILs
	nSf6OONm69QXargJziSncgNB5d1L8nYl/trFS/791+G+N0t7c2+AFxb+D6cf6LBuLT7NdEkRvWe
	hcpc3gzbBcJzF2erkRiOvs/f5gpdgUxXuppTgqSg1zsO6yXK9npd2kq5yvPqJRs1IjvRrPX4eAr
	1Q/6D5BslsZ3jXaBO9quVjEEP7LLKCw==
X-Google-Smtp-Source: AGHT+IHE3K7efxQ+hk8pVBE6YY31PD4G3LjwwPuEi1DqCDNI+Ud0foCSPIjpPnt40T661VaNMc1/Ow==
X-Received: by 2002:a17:907:3e8c:b0:b07:8836:dea9 with SMTP id a640c23a62f3a-b07c3819dc5mr855439466b.39.1757821832889;
        Sat, 13 Sep 2025 20:50:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd3efsm668828766b.55.2025.09.13.20.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:50:32 -0700 (PDT)
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
Subject: [PATCH RESEND 38/62] init: remove most headers from init/do_mounts.h
Date: Sun, 14 Sep 2025 06:50:27 +0300
Message-ID: <20250914035027.3609569-1-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.c |  2 ++
 init/do_mounts.h | 10 ----------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7ec5ee5a5c19..5b55d0035e03 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -5,12 +5,14 @@
 #include <linux/fd.h>
 #include <linux/tty.h>
 #include <linux/suspend.h>
+#include <linux/blkdev.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
 #include <linux/mount.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/init_syscalls.h>
 #include <linux/fs.h>
 #include <linux/initrd.h>
 #include <linux/async.h>
diff --git a/init/do_mounts.h b/init/do_mounts.h
index e225d594dd06..53e60add795a 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -1,14 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/kernel.h>
-#include <linux/blkdev.h>
-#include <linux/init.h>
-#include <linux/syscalls.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/mount.h>
-#include <linux/major.h>
-#include <linux/root_dev.h>
-#include <linux/init_syscalls.h>
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-- 
2.47.2

