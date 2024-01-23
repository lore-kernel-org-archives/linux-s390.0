Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B01272CF
	for <linux-s390@vger.kernel.org>; Tue, 23 Jan 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970762; cv=none; b=pOppfeh2JNs7SSnA1FWrGw5oSTpVIYcHjBT60YZLO2L2At3zQuQ2I91QuNOFkUWBNavCB4yJte6m93aFoc5DTuy+p4kGg20r0JmFNjvJ5IzQAxaMEeJOGrjtIrU85FjaOTSde3Z0iRamjZljbKQ2Untyv/KZW29qI+Z/FKquLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970762; c=relaxed/simple;
	bh=cmItHHDJ2/yorzOokW4wLWtGAZ57hv5idzTs6y53l8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tup38QUXfNJUY8CCT4BqIaRQ1dznjiToJPXUgQqEQPPB7FSPhis/xK2JXhvecDxMcvVvh7HuCmXZ84pY0lGiGEYoB2kLKr81M/NgaAT5OzU3geETu2h7/smCY+is7jZTsRwf1INvYN2C+M6GYyycz9ZGPgM93Ce5uBMnBa5BBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XGH8bbX5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XGH8bbX5"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cfa71498feso3329246a12.1
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970760; x=1706575560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw2b3tHeJEx9a76sk3FUumHURyBJJwj65NrMowk875Q=;
        b=XGH8bbX50dKD/LNZcdxj+jrFHSVD8nYifl2SGv+MYAtVxPyjHYryStFOrD767hbrUe
         GtskbhS/uzdFqJ5rcTltcvGpsMf9p6fZxMuEPowXsvPGIjMGA2aBS8PwVMKN/y8W/9mK
         Ju26un/oZVQPE9C29V0+Parje4ArmGhLc9dcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970760; x=1706575560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw2b3tHeJEx9a76sk3FUumHURyBJJwj65NrMowk875Q=;
        b=Jfec/VEtsm3/tzzbTlOXSJi+T6+YM96G5BgRnOt9cWSlfEVear61d2SIASXRWsDt0H
         +0VltN1JzePuu5fPBNDOak/d6Bc0703zpK8crcqvIxqZWNqduOBBUZZr/QtzEI12I4cw
         /5NxSHlbwy+H5eCCaxmwZbsoJ5gRRJi9ILMrsT9NEphYAZ2KyvUlGkBaNAFHy96ML+pj
         UBnuQogeQ73q3sPhdP5h1GkEql2U0VKEPvkiyBvzEH1wqnO9BrTjEWK7gNmNMM7ocbF5
         2ae7K6tzTXJdZ2T0GMj4rDUfaMzbnKQUHJ38WA8umWdAd+xFmLJuy5xuVVjH+BYhtsRV
         LeMg==
X-Gm-Message-State: AOJu0Ywhb/EXNZLbPHJB1pv0R9rwge9d8vBBrrRg1QlQfCqcp+gYiLAE
	6yJlba89tySpDC3g5Cs52kZNbmLBGLHJJAQAZ9LnwB/0OI8GPMN4NK9ov1jMcw==
X-Google-Smtp-Source: AGHT+IFpnmN5NeFDZoCtNSPJnK9l8YLwar/VS6Y7pK5lbfaQcHzj8ixTBuINNoXW+BgKQQm3i/BUKQ==
X-Received: by 2002:a05:6a20:354d:b0:199:e237:1497 with SMTP id f13-20020a056a20354d00b00199e2371497mr4858984pze.65.1705970760341;
        Mon, 22 Jan 2024 16:46:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b006dae568baedsm10164690pfn.24.2024.01.22.16.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nico Boehr <nrb@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Tao Liu <ltao@redhat.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 30/82] s390/kexec_file: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:05 -0800
Message-Id: <20240123002814.1396804-30-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3531; i=keescook@chromium.org;
 h=from:subject; bh=cmItHHDJ2/yorzOokW4wLWtGAZ57hv5idzTs6y53l8w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHS1qljwX0OBc821aP1oPgrqcP/CIrbF9OK
 s6Ar47XlguJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JmY8D/4lOAfDyZzxJuod1mr8o99HqUKS7ycJ2w+BmUnwdIT7FhMHPjXYoOdI4ma1NGPbJghRMX1
 KQh4FV76MnS1guDFLwXwYDsJKWpS3LyA+nT73MbsxUuacxblqt5Hh3MLWsexvC3I5rq8UnyZ8Rz
 OxP9Q7+HCEtVVq95HnnbN4NH0ssyF02BVeyeP3cg1KVo7MMrKpR3oRkKY5uQ4ANfxACiQP8ERkC
 45YM4DwsS1FmhsgCHCGraTPD7DYb2sV5bhvL21RPfNaXig08zMT/5ZUQ9ZjYwxIoSByFzm7Il77
 JwwfaVVgTNG7P3Rs9WKhVNOmxa3xDsgK9dTuvm72SLUQI+Zwb8997/d7vjECwWEeGWfRUiMrguP
 vBRHMDpNBBg5NNXV7zCvcPmyv++hO8F98tw3mLfrc3I/zJJ5p1F3Df0LKZ2x/4WL2WDIcolRjFz
 +AOJQe6vXf62QuIPIf5w7zvk0yyUTLqdvT3OWqxqmCnvHsze82MBf8A+ZYHr3YxF6u3exhea9t8
 b0oMGLlaiEtp+HYdg27KcvRIktdQeyqQj1+pUWLNuoSWK4xIpaTmoHwpNyigdAUI/I6sw+LKfKe
 L0szrDlREhEFJ1ygZbsZfF5wnN2NSu6FsohS1ZFZt+JaQP/V4vq/nnABS/LJxgLyTU9lzo+nMcu NTXqQzK2ZrdRSTg==
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

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Nico Boehr <nrb@linux.ibm.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Tao Liu <ltao@redhat.com>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/include/asm/stacktrace.h    | 6 ++++--
 arch/s390/kernel/machine_kexec_file.c | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 31ec4f545e03..3ce08d32a8ad 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -34,11 +34,13 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 static inline bool on_stack(struct stack_info *info,
 			    unsigned long addr, size_t len)
 {
+	unsigned long sum;
+
 	if (info->type == STACK_TYPE_UNKNOWN)
 		return false;
-	if (addr + len < addr)
+	if (check_add_overflow(addr, len, &sum))
 		return false;
-	return addr >= info->begin && addr + len <= info->end;
+	return addr >= info->begin && sum <= info->end;
 }
 
 /*
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8d207b82d9fe..e5e925423061 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -238,6 +238,7 @@ void *kexec_file_add_components(struct kimage *image,
 	unsigned long max_command_line_size = LEGACY_COMMAND_LINE_SIZE;
 	struct s390_load_data data = {0};
 	unsigned long minsize;
+	unsigned long sum;
 	int ret;
 
 	data.report = ipl_report_init(&ipl_block);
@@ -256,10 +257,10 @@ void *kexec_file_add_components(struct kimage *image,
 	if (data.parm->max_command_line_size)
 		max_command_line_size = data.parm->max_command_line_size;
 
-	if (minsize + max_command_line_size < minsize)
+	if (check_add_overflow(minsize, max_command_line_size, &sum))
 		goto out;
 
-	if (image->kernel_buf_len < minsize + max_command_line_size)
+	if (image->kernel_buf_len < sum)
 		goto out;
 
 	if (image->cmdline_buf_len >= max_command_line_size)
-- 
2.34.1

