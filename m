Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562F6BB5B
	for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724595; cv=none; b=N8r1obquIFGzMxSW/3q0GYxEHHwo5lXcGTllWdPn374VLylnyiPlDw6P345gSCnTB1J3hZ4WTppumwMZdYB3P1uFfwDmC/rbH2cDp0MsrgioUtI9WqqFaVHpJ7p3/ZUx1++SSWMX0UbEWoj6TvoCsgTRcZk0uxKTh+1HtCdihxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724595; c=relaxed/simple;
	bh=aIH0UEBp9jrH7zT+VD2BpCtGu5L0ukANS11y+zY/wiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USr4RZMgx1BbSo9A07bOMP9052cyxSVd4mN3ATerTYjU1DSXo4xBL8U9xkLxNDJaAvRRsizOdQ3/iKOdsGjr7JazjpfVBeHZ24pah+nMKL2aa/niTqiIVQTIH0RBFYBT7AqpVyYUK+T+IsQb7R6IGWff/++gKGJHFAW1Y5ZBlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnalPX+q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnalPX+q"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ed68313b6so2380843a12.3
        for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 17:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724592; x=1758329392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=;
        b=bnalPX+qyvgr51ymiDlUfPxoeZUYWgEFDy0cQeYqymsBCvCezOGrJ3U8Al89pGPiSi
         SSyRFcIuh3aPN7d3nbj3vFvet/FtixGvtToqVpvbhZnl71bJcjH55pysGpeFLsxcJClr
         Bt/m6pOWSQS3nswISqsPVyKXarq9cHQAiqrIJRpMDOcq4sXGJxOcdj37SQNsEzQrAS07
         ojQ1n2EnI2YZzsJI23mG6otl+nP4GjF3XGApnMXBOQzVVuhDymKpXPgfAkD7IJvdXDnj
         ysQ8Cd7j3XqEpnxg98FXaz0YvfYwLiaeShFJBYv68hPUadpXC9ulul209mPf00t/7nOW
         Yx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724592; x=1758329392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=;
        b=gvWwHgfhv+lCXk8d+adpChB2YOhp03ze9mvstqs5p/fzoIGHCQF18Ck/No9P6I0Ka+
         Qn/5WFn5nrNAVrmDFLsqqKtukb5udPvCajZpcKlH9QUYoEo2OaD4SDA0GeZk3/pcd0oO
         oAbqNqI8eOvuokhD/sihmtDkK6sPm2LZyoirxhIUPaKzv0m8VLDpKxUPF8OEYNx2HHpR
         otyfuw1rd9HXhkUxfKeGXiA3d9zAPjOG07TSfjmbbGWQ2os7J7yVbo3qh5m8U7VaXX91
         HykLIDgBlLZ4dDT9p63xPXnt7MD1VybJY+45BT0/5lLHIe3a6MVYWQwpPYIM47/nom03
         wCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8AplvYIFRSDdEDjx8ay6CCY9GwIT9weYmFHBvkf+Ln29FGyb2KHLPahInrny8hifJ3nh1WhGDKN0F@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC5LUkdbfE2u1b/C8+oEHC5VnrjxTgbTXxdpM1t0JCOeVVNin
	NO7QKLsmzy0KrczcEHoANcJdWUpyCDfqRsol27yMRXQWmBfqhSit4UkA
X-Gm-Gg: ASbGncu4YZuqahalEOvQWwgjg9UgC3YDXqLIwCw8lIqibvFzMJR+2b6ffUAuDSpwlyY
	vZJcfhe2UZaxreTyACpLYhl6b+E67xlyOgogKn9yB9YVZPwwV86Z+86GHMWzsy/Dn7XLiQRmZLX
	V0HxGDaDy0QZoHMHXcVd5OOyH+OlqLhPJNPl76DFocZLh4ZcAwM5eIFby33YFvU0/MSW9kaRjD8
	p4O1wmJUBe265vR7F2u6SxJ/9OQvIE0jtHh71I3wJRLqdAW2/yMlKxVit8pFUR21kTkVbkdIZFf
	FqZ9ShniR+H1qBP2N0uWB9neG+7vFFsYmuROZGCMpyq0EEUtutgaeuM4eAau7whpnSBCG6+MElF
	ZBKH92WuUTDezxBokl8VYAxP05fco0Q==
X-Google-Smtp-Source: AGHT+IFuaD6uE53o0kMUFqkBYFUIpIv4YZNYfnndGaXs7B0K4+B96SRU2dTVgEWhisS3xuLKgCtRtQ==
X-Received: by 2002:a05:6402:4316:b0:62e:df3b:79a6 with SMTP id 4fb4d7f45d1cf-62edf3b81cemr3814693a12.1.1757724591635;
        Fri, 12 Sep 2025 17:49:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3b6csm4149162a12.32.2025.09.12.17.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:49:51 -0700 (PDT)
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
Subject: [PATCH RESEND 09/62] arm: init: document rd_start (in param_struct) as obsolete
Date: Sat, 13 Sep 2025 00:37:48 +0000
Message-ID: <20250913003842.41944-10-safinaskar@gmail.com>
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

It is unused now

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index be77d4b2aac1..01257f30d489 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -86,7 +86,7 @@ below:
    initial ramdisk.
 
  rd_start
-   Start address in sectors of the ramdisk image on a floppy disk.
+   This is now obsolete, and should not be used.
 
  system_rev
    system revision number.
-- 
2.47.2

