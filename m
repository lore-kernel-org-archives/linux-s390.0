Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578D6BB5B
	for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724529; cv=none; b=ssYwJQRex+4X3Gm96CZOuvH8q/hFfJiienzwrvyeabJh7TP29cEQxE3M7vPeSFHTvN8a3aO5LjAObnseceJL9Wt7pOMYOTI7lAQEq+VcSeJ838pj8CrFijDZoDaV9yz9y3tt+Rw8UUjtbZ2A2LD12lUiAOsi1jH4AwzS15EcR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724529; c=relaxed/simple;
	bh=xKqULWXz/2FiENcJWmfzamYmMIE4imk3W/BtNdWBiQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO0lSu7y4IE03rqT5fhsDuN7HC5oa6TUfCb7sbHAwX554/zw63wf+J8UoMJHTM+wS+GeGHRhy3D7Bwx3uzk0z0zqs8jvs88fETIa97fEfvX0u7K7VfD4c6NwmDAhVR9tBpkPQBChc60E6EleU3TZz9Ehjq1E4JIK0Yq+SFHHAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXC5LHaV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXC5LHaV"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ed3e929d1so3232973a12.3
        for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724526; x=1758329326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=LXC5LHaVko3hLgitulh2D+X+9QzDfKDNhew7kFXwh3JBpMXe8S8TiFwp92HLY5PnX/
         nE0PBrgrSYYmvUr7nB60XBcUGWbD3ENdwZDdGEZEpmftZ+HtA+EeeF7PR1uT2dDM52dc
         ZMVq+Hm8pSzt/CvRPR7Me2trqTMPiaCvHkP6+b+IEQvD5eF5k0u5n4FsZ31R41RDQcDQ
         BrBCpUlXV52huKpy2TgomHW9QVs9Ykrr2tU/v4K4dgAQoo0ONvDQb+XsjiZSFbJ2IgvS
         xrCTwIgGWYosdnf/NGyWsk7DdhjDkNLnA/ofhmUV8ldCxH2yGyu11Sj/DxoAM0vBqfC8
         jM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724526; x=1758329326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=sOv4FsXpn0Jo1tlHaSNuLWI1nEkBymj265grFJB7meMs78eQQ/poIvxO9ZiRDGXBwk
         XtWdm2MPYQRR+rMgTWLBYeasfhRXOW07MkMQEh2LX8xOQXiBEDfU1FMI+lLP/4cL+0CX
         JksrTO7DTwmFxpIfx4FIlGBYNT66WzPc4/VYf0HU1LsPfIq6aJs3aD7lv6FSo2zp6jEt
         qZ0B/PN0RHb6TmjIJy0hfXkagYUSwVhMIPn8iA3hplUuUqdDQzPNZwUgOd34wXQiLvF1
         mL8eSXmcQMzipdJZ/TLCGL7S5S2cuG0q3dAhXtBTaS+AWQ+bpRWlWbuP2KDuW4AG+n63
         by+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEVe9kxxXd619jlsVD+dJD2LvyJwXIA+iz50heJEEtWv7Hcn0b49nEBDm2Ot4Eh9nk7es9HFg2HE7t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8iLB/xyqwF2JYvQDxsgiFvhXhGjr4mKikRMK+n8MrbiSC1yz/
	kMR5b9tr9SwYNY78rVHcMyDIpe4d522cOUh1oQYAx4bMYj3XbHXLx4OM
X-Gm-Gg: ASbGncucU8oZuAuEVIYutXu057GDpmUeI4b3M+a67sut2PH36kKJ3Lu+YpIQsNHA7K3
	ayyl/rhUf8SRJl/gtQbKSfbQ5hXwAIZ/rslzwcdYc0YvJuippORtfd/mwQ8XyHKqdk2wfkioLo0
	BjZKfkDkhIaK3f5UPH36XfdxCBwcAABeevnCKqS5t8wIl0ffzvf6rc9EbJYSmu/OC7ARFExxnGt
	AZYU6hfae0qAcdTgWh+/F370mkDIPls+YcxljuLCXI341bn5n2S0GHGNwXdZZPvYH2psyYEgA1P
	znwIJg0XuOHgM1So+LT6ii2TIg0xRnjZj+O2mTpkT2cNAlw+W+Z5gFBKQfJ8/5wefbQhnpi3xgG
	rAYGR9cNjZ0KkNFF43wc=
X-Google-Smtp-Source: AGHT+IG9OWg6vz1Y30fO80tUWulNMPWiUpAt7xVByuYcp52he6rblxs++6dTXTQkGfdvR2czpiOABA==
X-Received: by 2002:a17:907:d88:b0:af9:add3:6bbb with SMTP id a640c23a62f3a-b07c35fb469mr433586666b.29.1757724525627;
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5bfsm461777466b.63.2025.09.12.17.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
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
Subject: [PATCH RESEND 08/62] arm: init: remove FLAG_RDLOAD and FLAG_RDPROMPT
Date: Sat, 13 Sep 2025 00:37:47 +0000
Message-ID: <20250913003842.41944-9-safinaskar@gmail.com>
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

They are unused since previous commit

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 4 ++--
 arch/arm/kernel/atags_compat.c   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index 8e12ef3fb9a7..be77d4b2aac1 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -35,8 +35,8 @@ below:
     =====   ========================
     bit 0   1 = mount root read only
     bit 1   unused
-    bit 2   0 = load ramdisk
-    bit 3   0 = prompt for ramdisk
+    bit 2   unused
+    bit 3   unused
     =====   ========================
 
  rootdev
diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
index b9747061fa97..8d04edee3066 100644
--- a/arch/arm/kernel/atags_compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -44,8 +44,6 @@ struct param_struct {
 	    unsigned long ramdisk_size;		/*  8 */
 	    unsigned long flags;		/* 12 */
 #define FLAG_READONLY	1
-#define FLAG_RDLOAD	4
-#define FLAG_RDPROMPT	8
 	    unsigned long rootdev;		/* 16 */
 	    unsigned long video_num_cols;	/* 20 */
 	    unsigned long video_num_rows;	/* 24 */
-- 
2.47.2

