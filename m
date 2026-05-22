Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45730362137
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491170; cv=none; b=JaljhbRe5b/2xVczQcINXxJzR/8lzkbdxDmnuRatUb53GEbxFqcF+Rpi44h496hC7BXu0T7V9+M0dmLa7j8US6JU3CfTlOBVSZTPiJLdw50kmKte50RxmHpN3+its+gmBjTGjyLGk4/9roOEnSz8jgZ+DqKFV/eqL7pl6nVVTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491170; c=relaxed/simple;
	bh=0FXppDeKTTVTZ6pJebHDrfJ8EGjmC1SknUjLLrTB2mY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tI7bpi723zYcDwStZhXUBXnNqqOdMX48vtOSKMAHBfhmO1eFgBxQbMYhD5LXxsThnT8VGmwZFoXOtvOg+5Oa1hJXgOIEk5LgsvZgbavX9t57FiNeP3til2nbQqggf6+fwsEuuqre9KoWGbyhXXu8t2Qh6bXHQSpnV09vuRM1w+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNC2TTXb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNC2TTXb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4654f9bb6so80253905ad.2
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779491168; x=1780095968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oa6ShCXKOoXccUXmm8NZQPrHCwABB3PfpqI6qY2vEzc=;
        b=YNC2TTXb1PCKDj6AQ5IgcdmdQKMm2XX/DaVPwtIMA7I4qsOWUIyr5lBdbH55Ine4La
         Q+UR8ETbBA4aQYqZ/OySyy82QDCEvpvMYM4RVdcJBycUKVyEUKa1QgFhyoJ/8QdbhcMF
         IxtTdG3+FiYBREglNaONT1QgUXnhPqnFesTCxExqT3NkV1H0dx1LtjT+7Z6X78T5erfn
         uH/atqaLhI7vrw0lVCbUrNiBpi+Up3qvG1JA/9lVqCh9zF8xc4G7C0x58JHydUs6AObO
         X+jqt8BdU0tg4jOpPIiwwgRFXPGZ7Qhw/0yIncxn5Gfg22eWWRCWbOIDBquwrXvyNxvS
         /Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491168; x=1780095968;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oa6ShCXKOoXccUXmm8NZQPrHCwABB3PfpqI6qY2vEzc=;
        b=FhJLhI6pOLbla6/bW2j25RseOsk7gVoixBMlJpDawT3VkeXygZhUFtyyBQL3kUv/ZZ
         ZqgeDUOvDWtICsCRenxXsPR1lm/Ed0DG3UIiog05c4ycbf43YF0dF7YA5F9ZBSX8RXjc
         +O52kB7viPrkY6kD7143iPaSv9HNm2HWvEnQRNgGVDATGqEUdo7lQQ881zNf+DwNkr6n
         fZufEdN35PSAhwosy4+VoEwl44HNDW9Hj9RmqVSjwKLpMW9U8ETjxNl1CSsqhumJF5yJ
         FQUzoTXPEiPQjTtfoNvwzSH/Ul06Uqn8gjZsVX7GsYYfiYLW4eV4mIGdwKUHLWpo/N4n
         EI6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9cMcikuY7g/0S8WrjQPvX31MMim77kiXgKdccvWJbvtpY+FVwSpHoT4vcE02n5Mecrj6cps26M8y/l@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1q2ZrsUTzJsCTFHBB+kLRLvAKX6KZBz8zdvo9HooVhYjl2qYp
	E2NxYlJDye7tEsVCpCgiaJzDMiyHCiX9w5Egq8D9dLrEmeSE2fbpkpbdceNKJXdRB/9u0sintUj
	CCCyiJekRFScZhsGorA==
X-Received: from plgk16.prod.google.com ([2002:a17:902:ce10:b0:2bd:b542:cb02])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf08:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2beb083ee1fmr56196155ad.33.1779491168236;
 Fri, 22 May 2026 16:06:08 -0700 (PDT)
Date: Fri, 22 May 2026 16:06:05 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522230606.883180-1-tjmercier@google.com>
Subject: [PATCH] s390/mm: Export set_memory_encrypted and set_memory_decrypted
From: "T.J. Mercier" <tjmercier@google.com>
To: agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, mripard@kernel.org, sumit.semwal@linaro.org
Cc: linux-kernel@vger.kernel.org, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
module") the system dma-buf heaps can be built as a module. The
system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
but those functions are not exported on s390. This results in a build
error like:

>> ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
>> ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!

Export the functions so system_heap.ko can be built.

Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 arch/s390/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 36bd9530db52..8244b57da31c 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -124,6 +124,7 @@ int set_memory_encrypted(unsigned long vaddr, int numpages)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long vaddr, int numpages)
 {
@@ -135,6 +136,7 @@ int set_memory_decrypted(unsigned long vaddr, int numpages)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_decrypted);
 
 /* are we a protected virtualization guest? */
 bool force_dma_unencrypted(struct device *dev)
-- 
2.54.0.746.g67dd491aae-goog

