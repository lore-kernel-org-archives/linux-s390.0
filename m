Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE61EC018;
	Tue, 28 Jan 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082827; cv=none; b=VmOiCpnlmWtaUl6RBlF4ZwjysJoKZvNUxfZ3HD53ugmjoXMnKNE47EioWDwJAnJEGWQ2puLzsrzaN7hK9c/tzufIPPsABshLaNqR9PseqtHeCpd/ewo4jDS9EpF7prM6agkMusqhUKaU7gm9Rb6b3FW5oUIYXQa7Iw5xrowuyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082827; c=relaxed/simple;
	bh=yMRokBhP5H9OnrWHlTrwNrH37XaeTKVZOm1a1AkboLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9GbkmDxFP0O+7MNQ+FJLwrGxmg7zTdogR+e789UNuVC/V4w5FUM75GTlwJIDoa1IvdsLf0R9mb/DSFHgP73dtgnYQe/lSSiU9kGaxYM1i0k7RcFsvlqnK9afeyQURIX/eI2PwHH76wH/OY3YbWVe8nKUyz8vwJqBAhXpfYhqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuGjn2Ua; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuGjn2Ua"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so8106342276.0;
        Tue, 28 Jan 2025 08:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082824; x=1738687624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUFKYgpgMmlqbxBNoSqa7nmpKlvvBTB3tfvr1dpYSeQ=;
        b=WuGjn2Uau0ew3rF/gBdWesOdRLZkPoNPs69QgdtDJMrimvcg9Pg3cQoKDrepp4qLEo
         haVlITEKb1bcFaTGadADujC4ZZrNI+M67b13vrRoU088el2DwIxwgxbYJUXaYk4xtC7Y
         2M7D7pH1Hn1rYoLm+KA+QvtPW4sYOaBRQwdBdWroadjWjYobyF5xoMYVREL2ayaljgwP
         p7LoX0k4MhZqB1Fec61Gp+773Rlr4g8tAQIe9J7x6eagAkPUmS9t+Kq1+PNEckr6VPp2
         OmqYMvoQupx/U3tN04F43WiJAKr3vrPun7u2D70WJntaBl2kOgOAVTGbIu+C1QiUPKEd
         48OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082824; x=1738687624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUFKYgpgMmlqbxBNoSqa7nmpKlvvBTB3tfvr1dpYSeQ=;
        b=qoKh97FnVbjHdf9M1taNDjBNX4+DzRhEJfwJkjo5NFWsfv43uXtqc4//0GqABL0Gz1
         1WswB0Mf8llNAf0sCH0MUJtevwG834MU3IVP7F1k1pJLtWKHm5DB7ZQngLZ82qWS7iiI
         ljeg2ZkCIUCrCqQWcLFGD1OwF8ogJFqdsEi+F49x6uN3VJjCsffXKjuMT8eofBLjIJzU
         orAHCWMjuBASLhm7KypKn8TbLjC7sXaRRgxa+hba4yqInw2GW6/8SPVcNfJodU+4PPJ9
         8WnwIL4EYGFxYVEzWFoI4biv33flwtTe9RNEMHtVn9Am2XVngLhnxdezhW4vablErMdr
         BXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXMH6txjDPZ5c0NCDr6KnRDapEDrhLPJNkK2bNGHPlMdhDdGI6XKaI5cJgIdz3qCzo3cldmYnMalcEh@vger.kernel.org
X-Gm-Message-State: AOJu0YypUk3qWbJota5EsiaS8JvMQ7fbzsskmS6kc8MRsi59eO5FtWHV
	G1PB52zzUxLReLrUJkgy1KiNOp18daA/7RVO1a9NClHLJY4HPTFLq5L7EPVn
X-Gm-Gg: ASbGncvhDpWzM8oyY2reUZAs8E9gH11XQ9YCVNloCgBvG7BfIsAxFfjG7+VbHXXSWOO
	TbzPmQgdfX/VBk6ojyW0egjYT0dh/nhGcr/C9oY33pcsV5wijZpaOZry3ki+OcHht/R31jlOl6W
	f+HsL4+37eBwxMz7PWwQzCyvoDTfW6jFoqEPS+V3Zw7Wy6kNf5mWvHHqgMoDYelEmTgddolGxC4
	CGNao2ZKCHeVYncDz8KsD1F9INpqD5aL5n4nc7NqHMai16Ns8bQiad0948uw0jY9nXprD2+z7m8
	9V9GSfAntjvuyZ2WbZky1IcV8jZc5d3+BmlkCE07sl5HuYTUL54=
X-Google-Smtp-Source: AGHT+IHY/k+5M9vqLY6IK7f5jo7YjU2cVhIphVyfov44/LHHx2aJi7U0ibZ2tIXqNDaHQQ0SCMcf8A==
X-Received: by 2002:a05:690c:6b13:b0:6ef:48ac:9d21 with SMTP id 00721157ae682-6f6eb9046ebmr369889037b3.24.1738082824639;
        Tue, 28 Jan 2025 08:47:04 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757891e0dsm19401097b3.37.2025.01.28.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:47:04 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 09/13] s390: switch stop_machine_yield() to using cpumask_next_wrap()
Date: Tue, 28 Jan 2025 11:46:38 -0500
Message-ID: <20250128164646.4009-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling cpumask_next_wrap_old() with starting CPU equal to wrapping CPU
effectively means the request to find next CPU, wrapping around if needed.

cpumask_next_wrap() is the proper replacement for that.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/s390/kernel/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 42ca61909030..745649ad9779 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -72,7 +72,7 @@ void notrace stop_machine_yield(const struct cpumask *cpumask)
 	this_cpu = smp_processor_id();
 	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
 		__this_cpu_write(cpu_relax_retry, 0);
-		cpu = cpumask_next_wrap_old(this_cpu, cpumask, this_cpu, false);
+		cpu = cpumask_next_wrap(this_cpu, cpumask);
 		if (cpu >= nr_cpu_ids)
 			return;
 		if (arch_vcpu_is_preempted(cpu))
-- 
2.43.0

