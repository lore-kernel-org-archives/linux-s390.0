Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D76131E37
	for <linux-s390@vger.kernel.org>; Tue, 23 Jan 2024 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971826; cv=none; b=sJqa5xW59NjLUCM7NQac2yLmeV7EvZa0Fi+e2h6fzdanHdbUGCLF3CTxNbcsFZFoGH9OHoo8CMGoH7nggZIHa8g6MnnVoKkXmHA3FQoQFr5QIDZyRDIk9S+NRCevdBjx4r66GzzKUD/PQpD7pWY1FvjXBbqMnRF6qoGEWED18IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971826; c=relaxed/simple;
	bh=0h5G2tRq27FIpo4Q7qModudkA+HmHi/wgWR1Q2jDdRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLfyF3r1S9GiFG99RM2PH15eNBa5+2et0SFVKs316EwOByrC3WsTyX0NKputPQcsIBqhHLu2HcNh+Pa1g7GReq9fkYIvizVe7GpPbQhpdfMGCrcfbmWBYjUhmh/OCAAo2u0VvMtMRqzbCQdEPu4xMygy378RpEpA0myxHgeQOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KIdjwNrN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KIdjwNrN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dbc6c48594so2020205b3a.2
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971824; x=1706576624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHzaAgF/BvT1ydL5OjrG2T32BsfjtHiswnni+cftQZw=;
        b=KIdjwNrNfztB+9sApXU8+AmNq+1j3EAk0XGIsme3K/4b7xQMf/NvAZhahQnHguW2ds
         BrgujlKCAjUi72g25ttj2EftG+At1FNxAq9H5pCNQeZWvRgSwNJmgNadDLhmCeYmKRCw
         Ai2hltH3QbJWENzjPeMwPJdan61Q6jpHmGgGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971824; x=1706576624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHzaAgF/BvT1ydL5OjrG2T32BsfjtHiswnni+cftQZw=;
        b=ibyhA5xkNktBOEt1jSq2sAPkUDrxmG67d0yn0JQf6TVVs8MEaEBmCv6klqGI1SvNPE
         3QUsFpgdcB9xauHSiGXKUsV6Ug7J7sfWIwQmXcg8DPyHMjfnuIxRuofPs8q8XPT6BHFD
         TaA44+uquUV9hZWhx6ppAiOHFCB89WDuUwFmyuKxpwyw9n8Sw7n1PKJfP3X/giEsiY+a
         YFDfkqgYEFYeAl7e3JdKxUn/3DZf9x79UA1EqcQH3DtYM/9qqID5VH8TwBUNy0t+Vyze
         Qwlo5QjyeaDEWdhD89n7CyDsNGZBoLxJOYUTdTG31kW+/SuOQ9xcZ/Ywq0HRctTvcbgH
         /H1g==
X-Gm-Message-State: AOJu0YwMhQLlC64SH/YYoh3UlZKQEMfUu+EzrHWRbIRFnW5AaHgJjYdp
	Kur1zD0rcg+KObe0X4imo8+VMkHFHdL/c/3ddJPv11DVBuhrohH0ADU7kkv8PQ==
X-Google-Smtp-Source: AGHT+IHvroj2CO8ZLYbE446i2XqYNffjGeUmqPm7hHeasKcoNWT1iFohUjGr20Vo2qOU4QDlncK//Q==
X-Received: by 2002:a05:6a20:1587:b0:19c:5643:faee with SMTP id h7-20020a056a20158700b0019c5643faeemr678799pzj.19.1705971824060;
        Mon, 22 Jan 2024 17:03:44 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mm3-20020a1709030a0300b001d740d195e0sm3193684plb.93.2024.01.22.17.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:03:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 71/82] s390/mm: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:46 -0800
Message-Id: <20240123002814.1396804-71-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=keescook@chromium.org;
 h=from:subject; bh=0h5G2tRq27FIpo4Q7qModudkA+HmHi/wgWR1Q2jDdRM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLpMT9noDscy8y7zO/F2OVlDacpSoottbqW
 UQWgBJTZW6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JnnYEACr61LHBTRgtHLdcMb2Y/zEYEf9fNAgAUuvvxO5kW/+qOG1DgGldVNv/XDAOoTlvFck4ak
 FIYHx3fNLtAD8BeeK5FOheewr9wuzYSB2sgKs8XYqaq4sSAAXBqcUVwzQIYDgLycXM91gBv6XWk
 TeOK+U3cPpE1u8dG2uO+vai6gmjkM7zS0Lj3DSFl+yAomYD2D3zqqmmJ1Qib47sgyy5CQPLbYwq
 8hQXgWNrKwuC55t2HcHW7NaosV0nPz8gyjVVzEIOMqB66z9DJ3S2/XGk+rN+hzjOpGhO3LNgIoE
 0JLif7W0eA5mpxrskfe/zXJl7nPYZw2fwH3JgQ/rsfxRvTv9FrGq6Q4WJGpTyXoopYaPLotcPNQ
 frGK+B1yd5iZMGtbAaN5bq8DiNvFU3q3H3QJIQ4StPWYLeUFyLZxZpOsvYOKUO/G+LYtFyMisV3
 1EhF6Eg+Mb9MOAF0D/l0yE6tyCJqLC6jgcWaK1APTpgKOfeLbel2oOBr/QNOy6USDpmVnd10rui
 j6e1h1sC5OpJF7ML0bu+pIvfu57zLAyPFc1RW3fZbOpExWdOhgnkfMjvf1sqq67wTBn+Bw1urz3
 T/U0rOzWsOjUlMKwey8HgpQb1NBONSo8NXBrAEgZK0bKLp2E1JOdlZi6mD9rOPfnew+b8F/eOtO vrl+6rhRn/aFP4w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/mm/vmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 186a020857cf..98a7f08141f0 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -538,7 +538,7 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
 
 	if (start < range.start ||
 	    start + size > range.end + 1 ||
-	    start + size < start)
+	    add_would_overflow(start, size))
 		return -ERANGE;
 
 	mutex_lock(&vmem_mutex);
-- 
2.34.1

