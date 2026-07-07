Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10C2D7BF
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438732; cv=none; b=TJF5/Uux8yGgRXq8t28+ABwFimUGA1YeqoA3swRTm74YXy4PbEwypI1LtM+D3uAlSDL4OC95XjRXXppav8KpRTFghWyloURq8Kb2h4B7UCj+UiTwEK1/XEvXrESRV2wp4Olw7CFz/eK/Saf7EaREeSw86nnEAH2jcQdfghQwliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438732; c=relaxed/simple;
	bh=Oe/4C5CNRzZ9YU+v00jSZhbg5LdWqb5vYdjw2GlJdww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMOxiD1biRsg6Q95MFo1uD/qHH60r3FO8VZ47reEFLWdkdJxv7ZG6sUJ3sFw9kUWwZWaVfogs7lrmdBVIzWbl4wReRkzeHlRZvL2/FwmBEUWh5uw0qcD5TTivRz313apTgvb6rGaK3keTEFjr35nSie4vJGDTuVnC7iDUY4XYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G1JrFb+o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G1JrFb+o"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ba701891so34703145e9.3
        for <linux-s390@vger.kernel.org>; Tue, 07 Jul 2026 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438728; x=1784043528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=G1JrFb+o6K3b2DQ4aApygcAtsuTlbZ//RZ8NQgCFFEcdCbT3ldUHbRDBV7BnPtt9uV
         amIGFzJ1n8vaPDUHwrkKlGGk3WEStRjCPWHRTq6wfCvdZFSnw4xyGXQZQlwt4UCjkbYo
         EG+3T8n8+zp/EfAutVDqG4s/AO2nYEo9NLn+YiLXvVYvIpBe2uLJ/26V2Pgyjo20CcTv
         Mg9TJbQTw8ga8Zop/C2M29xCiS8IehfpVnqoLu9vg66W+EC21tcwqSwcj+hggHGkAytT
         Kyr97wP0u8mno9kY4/+1zBtiDLFIRQ6u+ZlCLo13wedVnp3TpP0TQlpuK/OzEVxZZ+F/
         TFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438728; x=1784043528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=rBqYc6EDSFeRxIJXI+mgEpoPsqvLKx7ouR7rYDCzlc8Hs+Nhiaeev7pwGhFyC9sal0
         g9BKfuQzpLFHJ+OlHtt0n9aKdAmNgiPR8wQmkXnrqPAJI68Sx0YRQWy0CiYrd8u+dBXb
         K3kRTmy6zPHRrAIkmEeJNnqnkol6ImlNRAkDOUri4bM44SZe+HWGh/4FdwAzpYvI0Mld
         5gEl0Sj46+tt/WHBnB6Ur+UNlujKuQWKbPXCmvJWhlcWyb+b2UzUsr6Oxx2N9mVpgTvT
         byqYshCzlmg8arnXKN4CWqakfsfeEvgqFkjvP4QC+hIE+BtRStX+AvOza9Lp40sxaG+j
         E6GQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGTZ0yPHDlZZxA4px6b/C/XXsZP3xXaNM6cHXkafOAWDCg5PV7GYsYEIUGdRA/xfFsUiEx0bH8w88a@vger.kernel.org
X-Gm-Message-State: AOJu0YxhN+Wahe0uatCC8uZHN/ow9R/c0QmoyKwVs+vmh/7E+vaAr8uj
	hDrIvYSBJknEpZ3mmDwYyHl6WyDuTe9fBqwWiNY829vVQolBBGZ5+qC9gi7vSqW0X+A=
X-Gm-Gg: AfdE7cnAcUDHMowKqeTA/g06s/ANAg6NTPOFsW9iDajJ/lHDd0TS4MhdHQH7xfIXRM5
	c23Stoynyc8eK7ewcaADmlLqL8ZxVzFNJrs+Qe58deRJ+jQcUtk92B1gwHiQmwNP333X7HFOTvR
	7Gjs2pJLodJL0+mpL5pjHshNzIZG21fpBmhMu9ksxSVUEDml1ZHkiVjOvYPQ0ztwdOmpvFxDB6I
	Rlz85rCnwXIotbuQwi/CgWDRF/MBMp6ZRlc7jCF7r1rJbajK0HUwMfW3TSD4T11iIJTjPRXv1bX
	S6XIwf4nis2q+3ZJj6sjUktjnxI+GZw4PQlcmW2IPl0tdi0rlUvVZChWEP1wtHCPrqaeofwF1xU
	4MRg5ON4gu19+PgCVWlDdrGlI/L/czJdI1CyhRkBgQoxIzTgW7DGOouwc9/SjRUJbONcaK3UW70
	oaupTjonbQYc1YCyIdgRNg2Nk1uUpW/ryFxx/k+CVnpn9sAKSWCvYOui8+8dap0xR/2lnrUTEzn
	ibPm2ZvS3d/ow==
X-Received: by 2002:a05:600c:3514:b0:493:b7cb:c5f with SMTP id 5b1f17b1804b1-493df05f8d4mr59362085e9.11.1783438728542;
        Tue, 07 Jul 2026 08:38:48 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:47 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] s390: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:05 +0200
Message-ID: <20260707153819.4172541-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several s390 files use declarations that are provided indirectly through
linux/module.h -> linux/elf.h:

* arch/s390/kernel/nospec-branch.c: s390_kernel_write() -> linux/uaccess.h,
* drivers/s390/char/uvdevice.c: copy_to_user(), copy_from_user(),
  put_user(), get_user() -> linux/uaccess.h; file_operations -> linux/fs.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/nospec-branch.c | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index e11ec15960a1..b62da9e81e79 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/uaccess.h>
 #include <asm/nospec-branch.h>
 
 int nobp = IS_ENABLED(CONFIG_KERNEL_NOBP);
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index e6a264c996ce..4fe3ead4a091 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -28,6 +28,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/cpufeature.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>
-- 
2.54.0

