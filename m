Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C619D066;
	Thu, 25 Jul 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919740; cv=none; b=Kk8u7SVD8ooLPg8TPmrsMQYAANRYYIcxZydUutV2dI+STBGqPrlW0TYDFnFKSWyz0O+SJiG9IDLFYgtaLv7I0Gs9q+p0aLI/RYWi+LNgjfqrpD9MvZHa5WHD6haT/oSsfqppNLlG3JiXauZz5h+TVQcjAyy0TenDL0gx//NWJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919740; c=relaxed/simple;
	bh=Gt7tT4IS1ETjy/tUYBrc2CiRyA2ObR6lUoBhHn98yiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2TOcrV/EnqeJxU/h/Hnrjm+ab3+05Nzp1Msw79/R+pRqq+Ccl0Kw/v/BihHTu/sitHKNyLyrKNwJ2jboQl7xprzaNr9Xpg3qAZpYXlwCz00LUcYeOzAYXWxQgICP0ddM6jnSxUDL75Mb65q83vDnGYZ11WnKTVX4u6NWJoyE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9t2BiyF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9t2BiyF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso768883a91.0;
        Thu, 25 Jul 2024 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721919738; x=1722524538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoJFajSTaKRkyu/ZodTh2Ah4x6T0R9kHlD7qvYnI/nA=;
        b=S9t2BiyFoF+4x74KWvO3xSGvxGieIex8jxcM3t/oeOoGE6Aon26ciOeMo1TTY7HTcj
         MduYPLFKXNIvzHmEwae15uT6sQIwEBVmvjseZN0zD/9Oo9MjsVHz6djlFk1CiPlqifAc
         zvK0pPArQLMKqv3MpxIU5qSCurnFQEV2NCMQown39tUqMymyt1ouPhpU3U/Y/ngox0hd
         9Zg/mcxrpTT7setRMJlIvHzkqwYSZxaZH4JbZZfuWkyJeehVdARBu/H1JG8yLaDSbTZ1
         vnA9twX7r2kHRd9MOvO8Lp99BH1LBRs+t9vuNex0V20b3h7NT7bFVvGHw0ACfdCcc+GH
         2TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721919738; x=1722524538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoJFajSTaKRkyu/ZodTh2Ah4x6T0R9kHlD7qvYnI/nA=;
        b=aaA9YS2GUztdZSuGVtsOh4n+d6OxMvl+vqz9aKp0Z2nWqs7JN/KfpyFyMoRaSMgDb9
         K0u6RFOkvCueRGq57p38iMiuBTLEXWnw2K1keQUNkGU1UPqdNnq3SxiEMBcN57dkceqs
         w1iERbZiVcHOHgpLh1xab3fXHBhW5cvjE5gh0wcOZvMmiBc9OCAFDk6oJvZ1wCIKRtpY
         lJJ5fG12lOn4oHpp9qYfilxpoN73NOOfpc5Uz3mxB7juF05zzdCcxofMN4JmhiB9Xy2T
         pqJqJROHa9iFQSj8lI7IF+tysTHEJH02QOID2hFAYIf37fk32QC3ttKPRahc9hQqoo5A
         FX5w==
X-Forwarded-Encrypted: i=1; AJvYcCXFfGWF2Wyf7MsK12iJJqw54qenJEApM76sF7z3hHn6Z+B5zw1sg95EOi7H1WqMhkLoz4tYjK3hU/p1vtcGZp5fwXRNVh/Pi/V+ZA==
X-Gm-Message-State: AOJu0YzD/teuHyyMPr/40uGd0A/AhlX7gdOv/33foJYcFikw2BSrDFQ9
	vPlv9djOo5JFgxhLdD9j2B6aoJJZxj5qcSfajhuZFFqF4QsjYXsx79fikA==
X-Google-Smtp-Source: AGHT+IGZGLrpBp65z/osGfTeccjvs2IJt9WMWAD8p4OsAYCJQWqiqH5PFAxAOvhrHhAsh6vo9n5w7Q==
X-Received: by 2002:a17:90a:ee4b:b0:2c8:1f30:4e04 with SMTP id 98e67ed59e1d1-2cf2ec05516mr2484907a91.36.1721919738250;
        Thu, 25 Jul 2024 08:02:18 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73afe30sm3688841a91.13.2024.07.25.08.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:02:16 -0700 (PDT)
Message-ID: <83f4efd8-8bab-4113-a845-dbb462201069@gmail.com>
Date: Fri, 26 Jul 2024 00:02:12 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] s390/mm: Fix VM_FAULT_HWPOISON handling in do_fault_error()
To: gregkh@linuxfoundation.org, gerald.schaefer@linux.ibm.com,
 agordeev@linux.ibm.com, gor@linux.ibm.com
Cc: stable@vger.kernel.org, linux-s390@vger.kernel.org
References: <2024072535-synergy-struggle-8ecc@gregkh>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <2024072535-synergy-struggle-8ecc@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch backporting to v6.6.43+ cherry picked from
commit df39038cd895 ("s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()")

There is no support for HWPOISON, MEMORY_FAILURE, or ARCH_HAS_COPY_MC on
s390. Therefore we do not expect to see VM_FAULT_HWPOISON in
do_fault_error().

However, since commit af19487f00f3 ("mm: make PTE_MARKER_SWAPIN_ERROR more
general"), it is possible to see VM_FAULT_HWPOISON in combination with
PTE_MARKER_POISONED, even on architectures that do not support HWPOISON
otherwise. In this case, we will end up on the BUG() in do_fault_error().

Fix this by treating VM_FAULT_HWPOISON the same as VM_FAULT_SIGBUS, similar
to x86 when MEMORY_FAILURE is not configured. Also print unexpected fault
flags, for easier debugging.

Note that VM_FAULT_HWPOISON_LARGE is not expected, because s390 cannot
support swap entries on other levels than PTE level.

Cc: stable@vger.kernel.org # 6.6+
Fixes: af19487f00f3 ("mm: make PTE_MARKER_SWAPIN_ERROR more general")
Reported-by: Yunseong Kim <yskelg@gmail.com>
Tested-by: Yunseong Kim <yskelg@gmail.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Message-ID: <20240715180416.3632453-1-gerald.schaefer@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 arch/s390/mm/fault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b678295931c3..1a231181a413 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -331,14 +331,16 @@ static noinline void do_fault_error(struct pt_regs *regs, vm_fault_t fault)
 				do_no_context(regs, fault);
 			else
 				do_sigsegv(regs, SEGV_MAPERR);
-		} else if (fault & VM_FAULT_SIGBUS) {
+		} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON)) {
 			/* Kernel mode? Handle exceptions or die */
 			if (!user_mode(regs))
 				do_no_context(regs, fault);
 			else
 				do_sigbus(regs);
-		} else
+		} else {
+			pr_emerg("Unexpected fault flags: %08x\n", fault);
 			BUG();
+		}
 		break;
 	}
 }
-- 
2.45.2

