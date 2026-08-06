Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A83B9D95
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996886; cv=none; b=aEridq8wSzYnX2wiS46Ywfc7ifTL+au4wY1UgW6Hf+4j26Z3m9h3Vy8EG06wB1hFUPVC9Xr3A4xhZdu2KfXg0Y4OZj/Qk0V0pjMhjDFa8E9azjGmS0U5IkwrDEg5klUJc1IXqmDtsVPR9YKbABiXB/K12r1XdVWqH4sjIPYUJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996886; c=relaxed/simple;
	bh=zK0URDPVEXSMclZ8lWEXPCGPTT3zF/u5FRxlC8toxFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AMmVoQwhn6/su/WZkS4DQnzDIf0Sx2ohF4SuwUkeSKayJkue1LPMANOqatEB2fiW90YB4hzG21k8NUZKRErMZKGMNWfuekTcmvHGctvgAORoMb1HDJ4/fmbIRrT0JxnbJ2/km5/vhTczbHSu/VKnDfaxlCppvU260Ow2Q5ohLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FygGjbUN; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FygGjbUN"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3811279d51aso3034569a91.1
        for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785996884; x=1786601684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bFzqH4xCVi7VLSbp83LQR7Sy3Yjk2atQ5O9h+mavTgs=;
        b=FygGjbUN+j4J9YWV0bZV9jVTaqH62kRHL9vZ08rPKJ+mUTXRm1fcYYeAW4aBCLKrkd
         TZa5fNsVcA0ARTJK/jxd9ldvd/WJQmXS87QRSkxKE6A9n73FPODA3sWtslZbcaoujdpt
         lKT6cYNkynj7aeYyY40JdidtRkok7Bn+wbgKawP+AL3cQxb3tHk6VJ9uTfMMQ731HRDV
         ERvWMqeLHVLigz8TlzkeoVmdLGWeZ6jBfDnfYLYil61Fv7NS2c33MnuQPIjyLaKPQGRo
         bRyDM8BwV7w/hivW58Ztb2ShvdECLLwjSv4DHM1cGkSziYbqqRFgOZdYkYQPV+GD4ORH
         Nl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996884; x=1786601684;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFzqH4xCVi7VLSbp83LQR7Sy3Yjk2atQ5O9h+mavTgs=;
        b=QodwnoJc9x4IPqWbfOVIAuCGQUnXndjM5u4jwgzvDk7DXhaUDqHXccO087dnhrrDG9
         X/oJI9yfHVmBVJgc+l2ru/qoJO9K+xXMcWvM/3V7tNp1/V8UF8ISc0Idh3FyOfnRjS8A
         FBNrwppS4Yt38aCkfVFmtSguuPuRLhmtbnsS4CvGBPya0c/aLiNKiJJ/YZZq3mKsWNSF
         2j5ZaYJ4j+Ajdagb7cWZ5HK4+WaMQASvEqlXw8/4Iacv2i+Lthcx1ywwMPkdrpgHaqp7
         krLTnNx+JzgIQke8v9WFkKvHJ/wcHyx8sxkhayWhF5VNHg7Bw8Q4DzvtcE03MnHuIjEJ
         ZhSA==
X-Forwarded-Encrypted: i=1; AHgh+RoLv6QJh8RTbu/nEeHBzJejlQ4yeY0L6QM6QswbtbSOnBLzJ6qt1ul3U+pANn7IsPw59t/b9WS5A3sO@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDjNJEN/V1tVV8AcEQq4WKFcya5qa9kve8upH7lX8xTuPWjTi
	foPvAQEST2+CVM0BYS6uoIztIgfzAzruGSHzdCYJuGYRndzU0/h7eiaGYmLDHJ+wUaJMKgMU7Sc
	8D2yhyB+7Iw==
X-Received: from pjyx15.prod.google.com ([2002:a17:90a:e30f:b0:38d:d40a:d192])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b87:b0:37f:c2a8:ce45
 with SMTP id 98e67ed59e1d1-3903c537d5fmr11343222a91.4.1785996884273; Wed, 05
 Aug 2026 23:14:44 -0700 (PDT)
Date: Thu,  6 Aug 2026 06:14:16 +0000
In-Reply-To: <20260806061429.474992-1-wfelipe@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806061429.474992-1-wfelipe@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806061429.474992-4-wfelipe@google.com>
Subject: [PATCH 3/3] init/Kconfig: make config INIT_ENV_ARG_LIMIT user-configurable
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Wilson Felipe Pereira <wfelipe@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

INIT_ENV_ARG_LIMIT is defined without a prompt string (`int`), making it
a hidden Kconfig symbol that defaults to 32 (or 128 for UML) and cannot
be configured in `make menuconfig`.

Now that CONFIG_COMMAND_LINE_SIZE is configurable across all architectures,
users who select larger kernel command lines (e.g., 4096 bytes) may pass
more than 32 command-line arguments or environment variables (`foo=3Dbar`) =
to
`/sbin/init`. If INIT_ENV_ARG_LIMIT remains hardcoded at 32, any argument
after the 32nd is silently dropped when the kernel executes init.

Add a prompt string ("Maximum number of kernel command line arguments") and
a `range 32 4096` to `config INIT_ENV_ARG_LIMIT` so that users can
configure their init argument and environment variable limit when needed,
while preserving the existing default of 32 for standard builds.

Originally-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
 init/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index d42bb55cb2152..28c0f1fb00ebb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -231,9 +231,10 @@ config BROKEN_ON_SMP
 	default y
=20
 config INIT_ENV_ARG_LIMIT
-	int
+	int "Maximum number of kernel command line arguments"
 	default 32 if !UML
 	default 128 if UML
+	range 32 4096
 	help
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.
--=20
2.55.0.654.g21b8a5bc05-goog

