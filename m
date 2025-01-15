Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324F230D07
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920159; cv=none; b=byOd/PifqSXdWSMrZwc19NGso878CevwgSeHApqnjpu9IfMMaXQT2g3ZLEVRkz7WsE1MQXHKs1XC6fA+hfRXM7VnJOdW5FkGJvoQ6FyFPZGAud08XBWBSZRKQO3HQE6Nw0ow/L0eMFj2AISb5h5PDqEmb3ubWE9vbbES15Yvf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920159; c=relaxed/simple;
	bh=dKp+neVs5VrK9cir+kWUKvbt+PUYfPNBvEjaFi25JA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUeeUfHNvIJcMUYXTIVzfcNf9hxU9SGMurznFZovR2sv2a1fYEHmHS+ZcdTRQDQmyBWujwG8ioZ5z0V/vudxMGU6DEYykywUmyRdVoQ9qHXxwbAOmCBbpPIlECLT6qvfx+Wwot5KgoH1FVJZD1rdKJS2F82J8r5f2SRiJ8EZREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=WXjmUHf+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="WXjmUHf+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644aca3a0so138940975ad.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 21:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920157; x=1737524957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88SqYtXaTV08jsATT/J9IavghVGb0T0MbX3fafAbdCI=;
        b=WXjmUHf+v1ga8Qdyp7ljEb9P4TEeKXQQkApzYqc7N44ooa1o1skljC4UTf53783sbG
         7qzB30u9X1U+UtNGOTd4mT+189VHQTgfkWvLOT3fsRbqX2R1HgU46mLPVl5o6eoodNbV
         cT3AM0rvmXUDJXPSn7aElu+E08xIC6oMyXXbR8jzN1x9CuVKm/IvfzKL55dkjclE7AU3
         N4fnLJM0OMDjRGL+X/pYYjFO+xEzJTvtmjmyHdT7Qm98JtxYrq5V8ovCmTn3n0uzvTsa
         5+4TCfWFjlaAlT4FgC7wN9ZPxNIM/1R/R6XA5tULOsgcheINkYOpZlHDId0s0kXfOii3
         JtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920157; x=1737524957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88SqYtXaTV08jsATT/J9IavghVGb0T0MbX3fafAbdCI=;
        b=HSdxBoghgiTgTQZZDIJaevN+P+zeGNGzlhDVdnpWfFcAWl7brD5CrbYbQpuDOpMum9
         U3LOfVpEvn7Yf3MaCskMt0dxNrRo1xs85txnaP1sUf0Vd5V3ZDnxUo7FmqXcneOOv5/g
         moDx7NO9yxqeG62cRVipTvJmbSZQlswJsA1/NEggvfdex5tqY223urHY9DzRiFQ5umPG
         hg7DBInPeP3+rwJKMtMWDiNqRpXmeYIZtg6JEIYOrIltiCHEY+M4tEv7NvcSR4Oo2nhK
         E9p4gd795bTeIkZDWF3ebhSIgYfvblrn877XnYR0++fnY8A+pl8qA22sbwd1WzfccUga
         0XQw==
X-Forwarded-Encrypted: i=1; AJvYcCWN+0byKaRAfd5QnWbHkiGAk7E198ImksXDspdCSqGlcJE2WGJUiLhazSFHFGTfBOrR7Ovhos4NwrkP@vger.kernel.org
X-Gm-Message-State: AOJu0YwNq0iXR4QeEEFuoh6Xabt2Mo4LzJa/Pnl7eKIB6cpe3ykmkN5J
	/9jcps7J9krX1f7Rir3TjHMkMBcjF6vVeHlPYbvpBop79ko1S7fgT4rG1SqZqh8=
X-Gm-Gg: ASbGncugGsAx5QhR+RR/5QjZDJb5CDwQFtUJvr/c5F0fXppM+8hoyiC/pu7hbyrgQRa
	ga9McLxfCk47mfbd7DeKWtf26u2oifABEB3TeU37dJ8N/1O9sKHuNm9o+1QI1+eQJHBgtGQnJNe
	bKn+nkvc9KUK9nx24MBKfSy39QM+6oAa3Ffmbd8VaoSs1b4fZSdKd+lpyxgxQTaLbuOFagwAliR
	I0klKajHBUXbNBntyuVTtk9nz0UtECTe7u5kcvhlDDjPLx0Qd80a23qVlE=
X-Google-Smtp-Source: AGHT+IE7CP/5jGWZAR0IrIqQIqvoQb7g5wi9hxFsU0CFVXu0dR68h2h3F8IAezzLwnE0Rlv/Ybh8/Q==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id d9443c01a7336-21a840109d2mr433462125ad.48.1736920157113;
        Tue, 14 Jan 2025 21:49:17 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f22e591sm76124125ad.180.2025.01.14.21.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:49:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:03 +0900
Subject: [PATCH v5 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-6-0f9e55bbb2fc@daynix.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
In-Reply-To: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
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
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
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

