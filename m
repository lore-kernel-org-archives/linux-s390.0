Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554399;
	b=gUlzB12awT44sDQwVqEp4l+Ys5h41wTqm+OWvzfZtz3WvcqHxYEQCm9dF4hNTUWswcJ4
	 DT4ocAw6WptCrO67bgUA9KkIqy5mrgV0FwljefD65OVku7NqJLv9eV7U0rKIBdD3malPU
	 onhFPXUwQTQx8s1PVvY4vtByYhWG8+bDmO4zATAPmR7xDr5qkbrJVsL/hIZr8gEbXRubu
	 mt0hVtFMMsAKONQXodbsE2eYd/Gral2zuLjxFKjZ1Vdf+Z6U/EUHtaDSVjCOoibzRfRBm
	 mm4PwSTnMgIXnpmv7GGAAW6RcZ4QPZZSCgSj/RvTzXZf7Jzp+IORDqApChz7i6VHmzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=H+UnSX/PqY8z8gSxSr8JwMySn7nrmtRIZfAK3roY4J8=;
	b=AT8AgXYsOfnN/Uk0XEZ7knMG5XiByKWYd7VEYr7ylrdGZ9b3EvRii/L2pRa6gJCG9ZYu
	 JTM0QILf6tG9QcbOjqkyi8dZHUPBEnGI0v0jUXF2GULjBtNYdss5wgKfUe4ZdbmgXvtOs
	 Nz5zd73zK1LeoGhqOljsU8zTVewi9sHpVZ6QYmdCxMuLCjtqhNZcm07g766L0S7UIr2fE
	 d5NMS0kjbGdix303x8UtHWeoCS6/6zPudf3r1yu30R3btLG3lkwkQ/M7izNccjwic4yf3
	 LwvZnFV8d+yEeDq0R5aYkPJbo4kyazR2i/MCg4vgD7QbJR1/BXNYs0cqEkZykyvp8LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfOV8cdi;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF84606A323
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 21:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF84606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfOV8cdi
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so2142584a91.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 13:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554398; x=1796159198; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H+UnSX/PqY8z8gSxSr8JwMySn7nrmtRIZfAK3roY4J8=;
        b=sfOV8cdi5VcmHLGRH5NTHwYZRQT9RsIrKksMA7txdbiosbMCbAQYV26IZcKiFHrh78
         OByVPKUKC2iks63XrrC/Vob67keyfOpbI6AbSWcYctfLseA5aUgfWDbB0gH+cP57XeoA
         HvYK8D4gxMFmG/IbCgHoizXNsJHuIc0uS90lHnWUYkQTFKsY0cqGvWtkcp/we4+H9Dml
         ZqZ8Icv5JY3kGArOdcvJEGfXB8rVyNRzUQF6m2c+ikoo0q7uSSctQ9gNmyyWp1FzBX/n
         5Q/n/05PPX0eFxw0iPGlyFxRtWQQ4HKHXIw1X56qMeyAeIZyUluqHvCCAf18OM8Wonzf
         4H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554398; x=1796159198;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H+UnSX/PqY8z8gSxSr8JwMySn7nrmtRIZfAK3roY4J8=;
        b=vsvHymw3sL63AAXHuJyaD1g7VvxIZFNdAI7MRS4c1C1IqKscv0kPFKlblZTHdw3fTq
         4Lqm36lqm70okZYR0pLyr4aSKc1IF82o+Oae1epyxYZeo//K9jx9p0PTl1Q5Fj3ZYdhI
         kn7nl7eghv/ESt2PuvXnaJmKa6uVA4Myvclznm5FSUy69kjGxIpgAC9gRLs6meVUhUrW
         eoLI52x7bE+r4KMCLGoKVlK/Jl6xjym9aW0CA+vOu2p0fj9g2PXUuR0wS4YGHj9/OqBK
         xjeTGVoI1vZVD0mw4BUl+K7Dp/7MmEKQGvpsKzeJERN9LVbYtVq4T2dMPXHwClc40sMO
         Gz7w==
X-Forwarded-Encrypted: i=1; AL+hErEnFDRXi1pNzjiFFa3TYJ8PaWNQ3sIv6Ys0Ltf9hUCd3k1Xzh5iZY0TSQ2gEDa4t4NpkhxE4MHgVZbg@vger.kernel.org
X-Gm-Message-State: APuU4Z9j4lC4onLmyBpT7SJN0DbtFSDLc+1T9IpiJqEoMnCLm5zXS9Pf
	mjrRRIWLlfdto+urjZsMzWLVYHTNCUSi/cI4pqK6GaA5U8umpbY8q+4M
X-Gm-Gg: AZFdTZfBUdtduTAdodmxyUIBwU9GT1Fszd+l/hbQQ2es6AWca+e3kFghW26+aqyN0J+
	DPYFxUfiXbkGcRGcyuKj2+0OfbovzYF2dXbzgByuq2M/ezupQiyo3UaVwCaLL51nW6DDZkrmfJL
	6khrVkyuQpYBuP9HCrJhHHHOyYIDaEXdv0pUAYQyl8784QP7MJbwGqA5XGDHoNJ0eqKRdqzk4xN
	7Ub/5kJpbErFyXBK/z+XFWyJN3CqrBp1Rj0jew1rAbJeQpxcavSllCta16/cYNZc+zDaMZQQcR3
	POyAZx0ZqU52R1LZavbeeyNiE9AGTEPIq4rRcOcL7v+4hAmXJKD9Jy6ke36CFrwljAq9GKXZS0A
	pbvx8APPGxH5cOqlNjSRtLmsI/voxxixkKkBw+P2Up2gIHjGaEvDh4R9GDYoiUAfrKjP0LnJ8o4
	erB7mgh4M/1Ce0ZCaggpWrwHePy8OexZy8gl025jWsqhRHAcYoiaOtuP1a2os1/URnlVLzhqQu3
	0q3awTMM7tSP3PA/vCQT1gMqHiF1ORQM6NggS/Bp45iufTz1jYVnycjLPRaS2Z7cCCjowvFC0we
	rooZ2iUMCeI+GLCkRSCv548khEi/k70k24/zEASNy+76Rm+j2zv5JQs5ABGZ6GYNtDFSFPt1wiq
	kpC8fZ+wteLRK5ODqTVYCl5511J3yHu/eGg==
X-Received: by 2002:a17:90b:4d0a:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b41c9cd21fmr13382679a91.24.1795554398193;
        Tue, 24 Nov 2026 13:06:38 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm24095661a91.8.2026.11.24.13.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 13:06:37 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 21:06:37 +0000
Message-Id: <DN3QWUNLDYAP.1RWBZ8RJH1QSY@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jamal Hadi Salim"
 <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>, "Amery Hung"
 <ameryhung@gmail.com>, "Cong Wang" <xiyou.wangcong@gmail.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>, "Mahanta Jambigi"
 <mjambigi@linux.ibm.com>, "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu"
 <guwen@linux.alibaba.com>, "David Vernet" <void@manifault.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH bpf 0/3] bpf: Reject sleepable struct_ops programs in
 atomic context
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>
In-Reply-To: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 06:31 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
> atomic context. tcp_congestion_ops, Qdisc_ops and smc_hs_ctrl have no
> check_member, although the kernel calls their members in softirq, under
> a spinlock or under rcu_read_lock(). A sleepable program attached there

Not all of them. Qdisc_ops init and destroy run under rtnl and can sleep:

  qdisc_create_dflt()
    qdisc_alloc()                 kzalloc_node() with GFP_KERNEL
    ops->init(sch, NULL, extack)  no lock taken in between
  __qdisc_destroy()
    ops->destroy(qdisc)           fq_codel_destroy() takes a mutex here

A sleepable init is valid today. bpf_arena_alloc_pages() uses GFP_KERNEL
there instead of alloc_pages_nolock(). Patch 2 rejects such progs.

> This series adds a check_member that rejects sleepable programs to each
> of them, like bpf_tcp_ops does.

That makes four copies of one function. The default is the bug.
bpf_tcp_ops v2 and blk-iocost v1 missed the same check:
https://lore.kernel.org/bpf/20260623175006.3136053-12-ameryhung@gmail.com/
https://lore.kernel.org/bpf/178889947167.2.9168058946538747939@kernel.org/

Fix it once in check_struct_ops_btf_id(). Patches 1 and 3 go away.
sched_ext, hid, io_uring, binfmt_misc and bpf_dummy_ops have
check_member already, so they keep their sleepable progs.
A struct_ops with check_member still has to test prog->sleepable itself.

In place of the series.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1dd9db1..f7c7380 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2209,7 +2209,8 @@ struct btf_member;
  * @check_member: When defined, a callback invoked by the verifier to allow
  *		  the subsystem to determine if an entry in the struct_ops map
  *		  is valid. A nonzero return value means that the map is
- *		  invalid and should be rejected by the verifier.
+ *		  invalid and should be rejected by the verifier. When not
+ *		  defined, the verifier rejects sleepable progs.
  * @init_member: A callback that is invoked for each member of the struct_ops
  *		 map to allow the subsystem to initialize the member. A nonzero
  *		 value means the member could not be initialized. This callback
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01a74e1..42a90c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22244,6 +22244,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 				mname, st_ops->name);
 			return err;
 		}
+	} else if (prog->sleepable) {
+		verbose(env, "member %s of struct %s cannot be sleepable\n",
+			mname, st_ops->name);
+		return -EINVAL;
 	}
 
 	if (prog->aux->priv_stack_requested && !bpf_jit_supports_private_stack()) {
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 2ba73dd..4e54165 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -301,16 +301,6 @@ static int bpf_tcp_ops_init_member(const struct btf_type *t,
 	return 0;
 }
 
-static int bpf_tcp_ops_check_member(const struct btf_type *t,
-				    const struct btf_member *member,
-				    const struct bpf_prog *prog)
-{
-	if (prog->sleepable)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int bpf_tcp_ops_init(struct btf *btf)
 {
 	return 0;
@@ -329,7 +319,6 @@ static const struct bpf_verifier_ops bpf_tcp_ops_verifier = {
 static struct bpf_struct_ops bpf_tcp_ops = {
 	.verifier_ops = &bpf_tcp_ops_verifier,
 	.init_member = bpf_tcp_ops_init_member,
-	.check_member = bpf_tcp_ops_check_member,
 	.init = bpf_tcp_ops_init,
 	.validate = bpf_tcp_ops_validate,
 	.name = "bpf_tcp_ops",
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13..61a1971 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -356,6 +356,24 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.gen_epilogue		= bpf_qdisc_gen_epilogue,
 };
 
+static int bpf_qdisc_check_member(const struct btf_type *t,
+				  const struct btf_member *member,
+				  const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct Qdisc_ops, init):
+	case offsetof(struct Qdisc_ops, destroy):
+		break;
+	default:
+		if (prog->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bpf_qdisc_init_member(const struct btf_type *t,
 				 const struct btf_member *member,
 				 void *kdata, const void *udata)
@@ -446,6 +464,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.reg = bpf_qdisc_reg,
 	.unreg = bpf_qdisc_unreg,
 	.validate = bpf_qdisc_validate,
+	.check_member = bpf_qdisc_check_member,
 	.init_member = bpf_qdisc_init_member,
 	.init = bpf_qdisc_init,
 	.name = "Qdisc_ops",

Pls target bpf-next.

pw-bot: cr
