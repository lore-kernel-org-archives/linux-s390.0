Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264B5A7BE
	for <linux-s390@vger.kernel.org>; Tue, 23 Jan 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969754; cv=none; b=dCHI+2hLNeH82mtnWokAO/hFj8xknGwMQVqZSAQ8u+gwSd5qoYIQYjwPGpMjWaM/OXRRyYotYrqjn5pyej+yauddquShwxereA7QvfPKxY/bqlpEnKMAsmpDyCGXLqjlTaLXGeG2plalLT0D5JauTxSOVOyiGEUV+GEo1kNGfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969754; c=relaxed/simple;
	bh=DQU4joanXRgd1mS+gxXcm4BfbB4iNwIjQJ9FPFqx45U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFUGVGxF8VDeV6Ykcyxx692z2g6AOu3NIrhm9YWRPWTSEc8k0AfglrRet8J18SstKBir6aqU4jCfYstC4g4Pbm4g/dzQIoWuZ1gTpg7aoMAsbqk0Y7gqYz8gB66EYHGwkxGLKundDjw4POk4ZDGSamuiTKW9kI16y/d/GZkd8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U+XngC5y; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+XngC5y"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3299499a12.1
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 16:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969752; x=1706574552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvywcYW77f9W0/EEawC9chQVSlmM/wYw9WuZ4ujpaBk=;
        b=U+XngC5yhwSHfcAeXyiKIAwlBnviRYdrjm9mQAGzkrE04I/qggNqJ7EXr6byRqOOHS
         RmbMa0p+/7TquRmbrl5UNm3nscRJCeaXDVPqkkNj2ZepvzB7PK7Fmg8preYvpKu/jeVU
         lB0rngG+suGF/wLnhpOTqz7mvo8OZO5rKUGSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969752; x=1706574552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvywcYW77f9W0/EEawC9chQVSlmM/wYw9WuZ4ujpaBk=;
        b=nTEbxVxCNQwI5IDLi0Iq+C5KwaVU/B9g0XVfDw3itSbg97YuO4cA6qod/Uhm6VzOXa
         bvR6CvyU+bKgeWMphzc0JddCuf0a9nU2wwhc7LpSRqX0Yi2bIxxnwkXJFPx2sF5ESTGk
         c5kbwA5XuTZCNe2yiOK98dChF5SoRxGZGssqbcSxdYWJMLbAGcDTs5xmKHgdvqj3Jgu/
         Ew2M14Hl7g78x/HM0kaun/mxdT37jtF4GKJflFlLKEgjarU7NUWJHd6vxAWu4PWYZQUK
         jbtLqqplZWLCoUH2B4o86VkGzLN+exiordd1nu1X+et1MdkxI2UUZ6lHiJ57pIDUQuzm
         6A/Q==
X-Gm-Message-State: AOJu0YyXpbUlH9OkPyfdQr6iZveHdULABY5NfWYUGCfN3kzuwd7WVw23
	DkKk/vV6WA2BWHrWdtw+ySsk85wL9akVvZ0zQpkPnzZR4rZAZPfyUZkn4CashA==
X-Google-Smtp-Source: AGHT+IFj6nXDFRwAngJViBctccMejN1t3BelBA34ipms9cwPh9gV9+T4jqVADGchm5OGinfbn3pAmw==
X-Received: by 2002:a17:90b:607:b0:290:5246:beb3 with SMTP id gb7-20020a17090b060700b002905246beb3mr7402551pjb.37.1705969752595;
        Mon, 22 Jan 2024 16:29:12 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001d706e373a9sm7559865plk.292.2024.01.22.16.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:02 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 58/82] s390/mm: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:33 -0800
Message-Id: <20240123002814.1396804-58-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=keescook@chromium.org;
 h=from:subject; bh=DQU4joanXRgd1mS+gxXcm4BfbB4iNwIjQJ9FPFqx45U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKR1fdbTlXCSNHaLsraY4kCN0NXjk4wrN/9
 ptrTecUkUCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 Juo/D/0Rijh7xs7t+z0k5sUC01Phuw7CfMgDm7ealxIpjEnqcPeKLdz3mD2xMlnLAWp8AQgMX7x
 UsVZepQBCW+mbZNcyaU8P17kkR/DVc7kuurh6A9/qg0Doo0FWrmPWygvxpM4QDhE0BWg+HnMgku
 n6+MLAW3qZ38qFK2TNKcR1VOhVuLWxTkckPN8Nec/7/x4EA/IrvviqK5ppVmcCCP1kkU6yqRS9V
 GLUxRZfvGVuFMMnb0GKhKAWo7DZdHEZR5LzYBFF10XJes46hmqVlAymMFxiN7EIxv0ywKkw+/jo
 nLiBSpXgpdEeNMvEbekQ9g18cBvZowM9RckCdGzvVuhqEE8wlYliS3Cl6xZFQKeDcLXNaS5Iddd
 l6LypkhXu8RsRGFMSTTeST3NLd2MV50Ak5N7MwlYwztrZhji/SUmMGdL6wI/FRsTLYy80nbrjy8
 fyZyR3PPt/w66FT/FbS1YpSxHVHI4lBm2rBauWi2Lt61XzIBNU5xedEqaQEl1dEb4INlRI7CV64
 nbqMv8Q+wAg8JFTpkVL0iRqSD8sKKxtAw4q49K9wuS9FmVtOcyDAcXkG7QMZPbW6fnyVYVPSPbY
 tEhStv2vcp7DGK/BOSTiwcIMprY0XAIyqKXaQ77rYBqq5JxZIOFNPSPAu/upxkCHl+TQQK0n5j7 tszHYawERVCbBMA==
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
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/mm/gmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 6f96b5a71c63..977b61ab59f2 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -411,7 +411,7 @@ int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len)
 	BUG_ON(gmap_is_shadow(gmap));
 	if ((to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
-	if (len == 0 || to + len < to)
+	if (len == 0 || add_would_overflow(to, len))
 		return -EINVAL;
 
 	flush = 0;
@@ -443,7 +443,7 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 	BUG_ON(gmap_is_shadow(gmap));
 	if ((from | to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
-	if (len == 0 || from + len < from || to + len < to ||
+	if (len == 0 || add_would_overflow(from, len) || add_would_overflow(to, len) ||
 	    from + len - 1 > TASK_SIZE_MAX || to + len - 1 > gmap->asce_end)
 		return -EINVAL;
 
-- 
2.34.1

