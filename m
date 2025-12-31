Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C782BE7BE
	for <linux-s390@vger.kernel.org>; Wed, 31 Dec 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202652; cv=none; b=N+fLP7tz+F+ekNW9OTfQQYcGhbQpLAl0S5vVdFmxizDmwlW+Q8+N/Sj9eDhZNb01bYW2ZVXaJYfnyj044zLtPAl4JWfWu+/K8d6ng25Vwdjh18VWL5KmhTrouzDJeh3COd3U7kJcWxpOpBnXpl59V+8LL/rZkm8gJG7xRynunb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202652; c=relaxed/simple;
	bh=b8KXgdkuB2rBCBMKoOj23zAGkLun2ndQut4LRQn9YLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoTQ+zcpJERGq6U6rtL0sNy9h/EPz+mAkyej1Cq2JDp/FRyn+NWfRwu0cqgG3Wl5169G5VEKk4yRF2xvmzYyA/surodCS/fwp20OfLLxXS3kJUG5Eby+qE/U2qZVwGgZ8ty+dA0FN5PuM1MJr/DbdQpUJBKCo7k77W2eTnysrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B65Bki7b; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B65Bki7b"
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-37b9879f5e2so11685571fa.1
        for <linux-s390@vger.kernel.org>; Wed, 31 Dec 2025 09:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202646; x=1767807446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z65KNwFWdBB4vKMl4Q2RH4hcwYRlqC7hzCG8+fs8pqw=;
        b=B65Bki7bNr5asR8gLT4UQO5QpsWvo24HYhFuxdOGrbh73k/Zr92fazIv6voAUW/2PU
         NRPRaa4XHs2xXve3L2aLfmP/X3GSNnom4rxPzZrxyrixO6Ux7nOIe8iYhtQ1ssVInkFM
         iAp3yel9cShgORh0d//av01ytc7Rj2cNdxJvUhhQHfIos3TiTrVRDeOu1/02104vqjtG
         RRS0sSH3EaSEgt6jotTfiemRL79/aQhhbmW0ch3pRyntq2bKZpwNL8WVuqLaJLpRtFGy
         ldEpIkoNzRCn8ozbNaHEkZRfejpnWZArPOsmBAtc2jDNT1N+OMNTUhmTxc0XZcfCIgaE
         gYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202646; x=1767807446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z65KNwFWdBB4vKMl4Q2RH4hcwYRlqC7hzCG8+fs8pqw=;
        b=D/XQqtCnt6rNjyUUW+7JSR6O03xRZB1ZY6K8197qq5SPkzITFr2r12LLN/vwKp//28
         vJ4uUzhu/4O+jiol6VZuPkCaWH4Md2VU63FPv8iHsXB2svryLYwHKlODMTR8FPP+U1eR
         aqY4CYphgvnoX6uGTiCxcplLBtjqKO++alP/+yd+zILx5M/AHsCCNw8tDnFO75V4xV20
         hBGu8r1MtArNgqp77Q9O8GBIUKGWq/HVdmIpZIr5ALHJgaTjo6s3w5ai7s/cIPXMf32C
         Si5GPUrrAqGfRvb+tkMK/h5Wzz5ozuTFg+delRR5RkMB7u3r0Q4k7UxXfcmjg7pACWNx
         FKcA==
X-Forwarded-Encrypted: i=1; AJvYcCX7JapdqB1i6Pg1QcwJi2MwCundDGq7qEHAXdHhWm3XtwaIF9Vn347LJKGmH+qDHc1pPL8WWyTir6jc@vger.kernel.org
X-Gm-Message-State: AOJu0YySVItUE/qaQSeuMasYcBarj5ZYrfWRV/WTqFoQzBoNorV+S0Wq
	e2cyYbU2pFB4KNa2RsbYCHsI6jkrwHjz3rKD0EYcuPjOfosJ3GhNgyI68ou7w8DGMlq4nt9MArV
	1OpJbuo6eIeuhK1WdeFJpn6HYSdQ1hYw2leo2
X-Gm-Gg: AY/fxX54qzJnbNE1RJLQTBXTMWSPbND2hEBEAFsF/Mc1TkWCxf0bt2PPOSewSkafLhQ
	qSsL9fO4GqG0inJpIOhfQw7ZrJAg/l8CVgXH2MnlXPZMWIObSD5hAyaL8njlfy6mTz1BHdmLZ+L
	4Gm7JKjnZP781zYTmPAXC/Mi7QHPJoAjmtzpignYtgv+AJA7WDLYxEfRGupQRGGxxXU+2sPjXW9
	0VmCcKZ/M8VGB4b1OA7KL76nD8ZG7yTtP7A7Xor1t+lY++r1Rt5WpYidwooxs4NiDwMDwKkxYgY
	Xo0ZgHuRkoEi/y53bV35rSwHNyL/3jsIfaCtgzpP1qKJMIJupuVgf7DCVooiVcUM1wmHew0EHVu
	PnLAIWO6HsCzQHObt7t8VZfCDB7xrxBweLgJ5XuN76A==
X-Google-Smtp-Source: AGHT+IHDF3ca8umxceWHVP6etyuOqrKJuvP7YcuUqaxQdob64KBatF2Z5P+pEZdYR5Wycxsg5VpsXr4tuz+m
X-Received: by 2002:a05:6512:3a84:b0:592:f383:3aad with SMTP id 2adb3069b0e04-59a17df4092mr7765992e87.8.1767202645513;
        Wed, 31 Dec 2025 09:37:25 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-59a18637640sm7186949e87.29.2025.12.31.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:25 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 293C9341FB6;
	Wed, 31 Dec 2025 10:37:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 22C62E4234A; Wed, 31 Dec 2025 10:37:22 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/5] sched_ext: make __bpf_ops_sched_ext_ops const
Date: Wed, 31 Dec 2025 10:36:31 -0700
Message-ID: <20251231173633.3981832-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __bpf_ops_sched_ext_ops global variable it points to as
const. This allows the global variable to be placed in readonly memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94164f2dec6d..af8250b64f47 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5336,11 +5336,11 @@ static s32 sched_ext_ops__init(void) { return -EINVAL; }
 static void sched_ext_ops__exit(struct scx_exit_info *info) {}
 static void sched_ext_ops__dump(struct scx_dump_ctx *ctx) {}
 static void sched_ext_ops__dump_cpu(struct scx_dump_ctx *ctx, s32 cpu, bool idle) {}
 static void sched_ext_ops__dump_task(struct scx_dump_ctx *ctx, struct task_struct *p) {}
 
-static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
+static const struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.select_cpu		= sched_ext_ops__select_cpu,
 	.enqueue		= sched_ext_ops__enqueue,
 	.dequeue		= sched_ext_ops__dequeue,
 	.dispatch		= sched_ext_ops__dispatch,
 	.tick			= sched_ext_ops__tick,
-- 
2.45.2

