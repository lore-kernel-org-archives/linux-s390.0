Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530715;
	b=KmT4Es2uTqAaIWgxTsEyxYOI9czGUAsoKh+bNxKMmCop4ZGl8YJznp9AEK6UgOoUagRb
	 JZmh1NdntdLDwtzKioZQQlreRV2Y6sYjiclvxXFcEGWXkoyViLW+FnNzy6EFMtg7WtvqG
	 XTtoxewJ0E4F9d8xk81MbdbpUyMEJ0RHWrdpHpzSG079ON33lyYDWLtQ6N05GJUAZN8oA
	 vg5NzQsEOz7sW5p3w2QE9ma9Ucve7G0nHtreWfuuf1l4rangAq8yM7PeFaNDmufBj42e+
	 0E8RcgyTi8mbDcqn4/hU1jQXQ5fMMvXGqAOr7EVYZ8/GVEdvQXtpWWCy2N9FQedgfqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uZ2nv19VYG29QEUsKhjFZiIjPyzoB2HzMjwa1gkZtBE=;
	b=D/zUvuTtRH7LmyZcFYe07rG5AGpMXXW3Ni7EuJJS7JKkeAkdZr9G1pGLDAHrR20E9HS6
	 2Z7aQyzJMONIh6hCJNE7n5WdkKN61RikOXr/ZLzpragnUExr10W1ptM31xuxmGS6We38M
	 dJNNPmHv8Tz4w7niWOdQCPvM8it+KVFiof3vWzMHqpskHZSq7cTPExSoxw/sOlF+S0fyn
	 /mmREO23OK40sbjzyfKl/tBZ0Fnq97Kmj28sW5c/SOn53he8XFuiV+Utv0h/VeGwctv6T
	 RqwlyXEIUgt0UZwFEiOkjM9l4MI6VZ6ctxW19gzCHiBY20VGlvKw6KkBI6JcUDvpZJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZFPSpwn;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D2606A321
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 14:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271D2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZFPSpwn
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso3249488a91.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 06:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530714; x=1796135514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZ2nv19VYG29QEUsKhjFZiIjPyzoB2HzMjwa1gkZtBE=;
        b=eZFPSpwn+EWv3WI7oq8FlcFGbwsio7In32Q9BXJj5JT7LzvUi+kuUNm1OptvAjCIym
         aF8gEZ7GN0JzTzjRlSQ3RzWTQdd1+ELxeIAcrsblcQ1cDQsbrRnXpt+qp6NBBwMlAAlI
         8dmX7Soe+UgAiA/D0pjjKxJ71j8a3BiSOsVHvYDirhOXjv2CCz65FPRAx2J+gZxPH3X/
         Wfji9sW+KxmqfmoK0xns6FC+klWB+WlypOLzUqUiwa+utnziBtEUEndtzhsyOeCrhJMH
         CUAU99cpqBKX1trCjELPtos3AEXJ5UWjnA8HDPZIaR5qYjzl/vWzUSFJR2woUvkguqGi
         L9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530714; x=1796135514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZ2nv19VYG29QEUsKhjFZiIjPyzoB2HzMjwa1gkZtBE=;
        b=ZhuYYLw8oHGOfjaxifpWLCBKE2U/20+Z5pt0D2WEP89L172KnO8P8j5yahcQrrRxrB
         pl+BIG8jkW4rJ/tzX5Ee6P/hpxYbkaFlst1GnwEzKAQGRtYEEVdUZcBitvYh8enJUUph
         4IoBFbR4keRJc5I/0u3OHrkabYYfUwNaZokOAoMxytAwBABPsI7oSmVUg/USW/HuKTsv
         DE0hp+NIOZyQJtoi928s3QjeS8B97PI1lWi8nlRKph4gwN2hat8SBjtTY5o+HykFjTEL
         JvTgXlJJ7OV8P5INTjMh09MnTRpLu4vIaRTb1072xngkMuuKdnmfpPqm4YMVEBqY3i7J
         Cjiw==
X-Forwarded-Encrypted: i=1; AL+hErFEViYfjoOF+KFClG3DxMWVboVer28DnaEwKunev1t9O69yJ9r9qahbOyQOMGgSi54KNWh1OzVxFHgp@vger.kernel.org
X-Gm-Message-State: APuU4Z9JuLvRuo0xw9u1NMIAgIlo143RWu6dutIigfmpO1mif1UCh3QQ
	T/Re0t6IcE3GGkQ0TB7G3hKH3MbfqjIt96mpbZ+w4QeRobAT7IWZlM52
X-Gm-Gg: AZFdTZcZlrBJFtCo9ie2lKlvOk1mkqLcaTocnJir8kQA+YmZnen9rrM5T1EBwQNjC/m
	f3l87FYin3JOD2K+bNiPrFPRdhoLu3NH462RHsz+VvvqKeY881hH8WniXLwBKGinrx0k75fdwBW
	mdJZltAu+jni1TuvgJdNVQJEkkITQu+QAgkBBiiWUVu/7p8DXipBPMPLWY2zSqebQx2EFnQf615
	HNPcPeLAoY+rbhpVcOPz+1sZJX8aHrq75HZj1iKY6QUUZRBDXCYFxX/Pib1Mne7dJAVraHhlW+4
	hjSQlZpTJsWvpmJoCWio57K57zjWFCXh3j9vX5iGbvQLyXUDmxqaTFAeFZsTMhhhaoHK8AJAmVM
	0fHBEIQjFTQ0k0alN/i1fr/jwRPxT+fvKuBUSMiVKfsJe9lv80xozgQ/ENHxNq0IPVkzlNMCyGX
	2ZDb3HW2Yvf3JzVD5O7koem5CDOCbYvKS1tThhk0RK30zscL4osuBNTMnR4ZQWmPDVg+vEENzCb
	JlT84Gs9hgv4zrDicyj234LhQ5ywNOtOFRTgtgoJkOPM7CdIJ0jEfo3SnUIxP8DYMOXeOuE/0Ng
	NyopdVTC5FBmlLv0/RVSDELQBYBfoMHvA3b9/8TDfaP3WhgdiH1hAmYnKcENHVDn
X-Received: by 2002:a17:90b:4ad2:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3b41c99525fmr14250279a91.58.1795530714346;
        Tue, 24 Nov 2026 06:31:54 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm7171737a12.8.2026.11.24.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:31:53 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH bpf 2/3] bpf: net_sched: Reject sleepable programs in bpf qdisc
Date: Tue, 24 Nov 2026 14:31:14 +0000
Message-ID: <20261124143123.1182108-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bpf qdisc program can be loaded with BPF_F_SLEEPABLE, but enqueue and
dequeue run with the qdisc root lock held and BH disabled.

bpf_Qdisc_ops has no check_member, so nothing rejects such a program.
Add one that rejects sleepable programs.

Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/sched/bpf_qdisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13781a8..3dbe52a04fa2 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -356,6 +356,16 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.gen_epilogue		= bpf_qdisc_gen_epilogue,
 };
 
+static int bpf_qdisc_check_member(const struct btf_type *t,
+				  const struct btf_member *member,
+				  const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_qdisc_init_member(const struct btf_type *t,
 				 const struct btf_member *member,
 				 void *kdata, const void *udata)
@@ -446,6 +456,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.reg = bpf_qdisc_reg,
 	.unreg = bpf_qdisc_unreg,
 	.validate = bpf_qdisc_validate,
+	.check_member = bpf_qdisc_check_member,
 	.init_member = bpf_qdisc_init_member,
 	.init = bpf_qdisc_init,
 	.name = "Qdisc_ops",
-- 
2.56.1

