Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580751;
	b=Em1VnqcmosZ/zZo/LSTUL8E9CSJ5hw4ukmy8cg5Tuu4Q2fdFldBT15yiRYVjkDiefP2e
	 pBMTzNS+3+2H4j3llcD4DfEKp9V6pG96yFnb523iksUWXSPi4s3KgK3unfYPbGnhA7jG2
	 sPqnrMCY6dgAE2BSqb73ryF/MTA4WC6XsyuFPzuEuECXoixgt7QXkaKklGCvZSoaTPAbQ
	 UBMoh1Woffzwn2CK3KtjqAAptCGfit0ViEb81JtKbL/yvFFnfbXPF1rkUAqzW8AqY56Dm
	 7eLh/thzSreZ+xHPWItVC/fTWOedPhs8vCfoSX5PYD2vMDJyrA3uQmQMd3TvbAzkXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bTDEnpPeCb23WGIf+9L+jNqO6MEIQYCxGNNbBRGqPIA=;
	b=HZ7GqzhJ610z0mXSUf4wwpEFMdtflGkhc1elN7JGIMA3FXxv7u6PA8lUSoj2n+1iCvHD
	 vP21IHuRGFtom25SaBglWSfZpsLKQF4OYfO8r9zrGFdz10q6lxcs/inO39rSi3AuCMl03
	 AfXSNCX5GFJulZUIQSX7oDsti5SHR4ImbR2AR7yWlhoFfMEMvKZIISaY8gJHvC6pqDJx9
	 v+9+AwVo/8U4jmrs8Pacz/yH+s6ZBTZhvLUyjoQO9Lxg/xptUID/2BrQ+STAY7ExTJROa
	 SqHTQp3+8nlHDCE0VABMM3aujLJyiPc47S9oyemAOAEFhOoQR4Fyywd7R//Y6km77Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gc/xVqLD";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1867606A326
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 04:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1867606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gc/xVqLD
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f04b676219so29075075ad.0
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 20:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580750; x=1796185550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTDEnpPeCb23WGIf+9L+jNqO6MEIQYCxGNNbBRGqPIA=;
        b=Gc/xVqLDzTMXlMMy9RXVPwR6yGVCRvStDyMXKzkOR0PF3xSvURHhVvLNDljr9xvj47
         x54+Q9cjP8acT2wc3VD5t+D6r01sF8CUke8mIc8KlV86JE4o9pM00cwmhVbDCAU0RJMI
         6Ta8e+FJxpaxr+o1AI0N1WOXke1t4llTQKR2aeZQmewULXJwum0cVH7eMSgNeCcJNh9m
         a6NtyYKXz60t/C2+VcL95LLgZU+pB09T+CKY07w2ifY6Dz/Jzwz+s2iElKtwpjvJzbGf
         +PMLT6flnLTpqOWhsHDoUIHm6zx9rb7H2Cx7OI7elfMNYzlS4cl58dQiFUT1qUuv7e6F
         hxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580750; x=1796185550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTDEnpPeCb23WGIf+9L+jNqO6MEIQYCxGNNbBRGqPIA=;
        b=up1V+G2soW9hVLjYtn3Oum7FCDMt69+MEDOAo+Sc0Mz+NgtO4asvisSXc4E662dtEO
         2UVeeJvgdao1ydythIOSMXUe95oNWCjEwvAhqprs+tXWXbjHMzVT1cr8R1x+/iW3Tf1R
         UJEmrZWjQI9eayD7ijZCCpdcw3rLR8weXzAhfjyE+d1C/m0umlM3CBjzJPYpTPNPyQj5
         4AwN/skahQ7DwRD7UgFG/1wg7uriUyGKpbYeCOhGOWJ+FEA34E9PnfQH8tfX313DEeh+
         gpQNigqkz6FwP697skPS8TM/4E8NdAC33nGEPHHM1iKYHJn+a1LmpJ7unSWGPbhkYZpE
         7PIA==
X-Forwarded-Encrypted: i=1; AL+hErG6Qzkw0IcEp2Q/t8DT5Zwg6YlGZLwmPB7bnKggDf+I5d5qoU3wnwmBTG70wnYXFadaJPC5M/fcjyhw@vger.kernel.org
X-Gm-Message-State: APuU4Z94VissP/XscYVsvpGgrcpQ5qXls31g06STjDzlPUQR/XAKZM5R
	xbchxap3qpi3RmhlZluXYfPvGKQalQ1h1aZrWGanETABNP6T7OKG3AXp
X-Gm-Gg: AZFdTZdkyLvsiI+8+u5VpvwMIYRlMuEwv3ziyZbBQlEwwSFPSHqYCyh4PrkFJqjlvU3
	FFlihE7VKiufon0biK4WXS1qrGVohGU+fUFzvLZN9hGYhr72isZHjzZdePzcstcllYJN67iK8Rg
	VUwdIhFg5v30mILR1d6vTusB92L2To/DCLmhJxkaJvHGwhK1FvB7QVcl+NNnsDQXYsH5HqK/5Xq
	sSz9viBIZmfKYS+SK8fDJaO2X8E17gpZpsbraxeM60pEzQ7koA+etguWnMPefTDg5VWsvYLGU7N
	VIxxDd4tIAoOr6r00GcPnhGVBjLColDokbcB1B4mtFpbU+1nAFsjO4JUJ54lutbku1jyZgscOsv
	MKKmKvS2lkyek+teYsjMynaMZ1Zu0uoyvMbyn+M4vpEqKjk3dR5f4vAnJkZlL5/Wt793t4r4O6H
	jvlXQWRzqwMW5R5bGVMRraed0H3HiaIZr5wTXaFYhE20ZSLc7HOJ/Hm+i5nnwk5KkRODCMO6zbv
	dW7DzG0cFpkM72dCO6hRTro7LXpKwEbyE4xMKIk//yluFhCpB612H20g3tGYmgMiiI0p+ETuXPj
	YFs0sH/ToGZTTPqMEOxTCX5l0GN4cKxCZlBtTgEI8uLTbhL6xz5mrQ==
X-Received: by 2002:a17:903:f83:b0:2df:8f19:5db8 with SMTP id d9443c01a7336-2f03f1d09e3mr160319915ad.59.1795580749927;
        Tue, 24 Nov 2026 20:25:49 -0800 (PST)
Received: from srsys1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215d7sm76117185ad.65.2026.11.24.20.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:25:49 -0800 (PST)
Date: Wed, 25 Nov 2026 04:25:41 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, David Vernet <void@manifault.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH bpf 0/3] bpf: Reject sleepable struct_ops programs in
 atomic context
Message-ID: <awZjRcsJ30sLFpc2@srsys1>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
 <DN3QWUNLDYAP.1RWBZ8RJH1QSY@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DN3QWUNLDYAP.1RWBZ8RJH1QSY@gmail.com>

On Tue, Nov 24, 2026 at 09:06:37PM +0000, Alexei Starovoitov wrote:
>On Tue, Nov 24, 2026 at 06:31 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>> atomic context. tcp_congestion_ops, Qdisc_ops and smc_hs_ctrl have no
>> check_member, although the kernel calls their members in softirq, under
>> a spinlock or under rcu_read_lock(). A sleepable program attached there
>
>Not all of them. Qdisc_ops init and destroy run under rtnl and can sleep:
>
>  qdisc_create_dflt()
>    qdisc_alloc()                 kzalloc_node() with GFP_KERNEL
>    ops->init(sch, NULL, extack)  no lock taken in between
>  __qdisc_destroy()
>    ops->destroy(qdisc)           fq_codel_destroy() takes a mutex here
>
>A sleepable init is valid today. bpf_arena_alloc_pages() uses GFP_KERNEL
>there instead of alloc_pages_nolock(). Patch 2 rejects such progs.
>
>> This series adds a check_member that rejects sleepable programs to each
>> of them, like bpf_tcp_ops does.
>
>That makes four copies of one function. The default is the bug.
>bpf_tcp_ops v2 and blk-iocost v1 missed the same check:
>https://lore.kernel.org/bpf/20260623175006.3136053-12-ameryhung@gmail.com/
>https://lore.kernel.org/bpf/178889947167.2.9168058946538747939@kernel.org/
>
>Fix it once in check_struct_ops_btf_id(). Patches 1 and 3 go away.
>sched_ext, hid, io_uring, binfmt_misc and bpf_dummy_ops have
>check_member already, so they keep their sleepable progs.
>A struct_ops with check_member still has to test prog->sleepable itself.
>
>In place of the series.
>
>diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>index 1dd9db1..f7c7380 100644
>--- a/include/linux/bpf.h
>+++ b/include/linux/bpf.h
>@@ -2209,7 +2209,8 @@ struct btf_member;
>  * @check_member: When defined, a callback invoked by the verifier to allow
>  *		  the subsystem to determine if an entry in the struct_ops map
>  *		  is valid. A nonzero return value means that the map is
>- *		  invalid and should be rejected by the verifier.
>+ *		  invalid and should be rejected by the verifier. When not
>+ *		  defined, the verifier rejects sleepable progs.
>  * @init_member: A callback that is invoked for each member of the struct_ops
>  *		 map to allow the subsystem to initialize the member. A nonzero
>  *		 value means the member could not be initialized. This callback
>diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>index 01a74e1..42a90c7 100644
>--- a/kernel/bpf/verifier.c
>+++ b/kernel/bpf/verifier.c
>@@ -22244,6 +22244,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
> 				mname, st_ops->name);
> 			return err;
> 		}
>+	} else if (prog->sleepable) {
>+		verbose(env, "member %s of struct %s cannot be sleepable\n",
>+			mname, st_ops->name);
>+		return -EINVAL;
> 	}
>
> 	if (prog->aux->priv_stack_requested && !bpf_jit_supports_private_stack()) {
>diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
>index 2ba73dd..4e54165 100644
>--- a/net/ipv4/bpf_tcp_ops.c
>+++ b/net/ipv4/bpf_tcp_ops.c
>@@ -301,16 +301,6 @@ static int bpf_tcp_ops_init_member(const struct btf_type *t,
> 	return 0;
> }
>
>-static int bpf_tcp_ops_check_member(const struct btf_type *t,
>-				    const struct btf_member *member,
>-				    const struct bpf_prog *prog)
>-{
>-	if (prog->sleepable)
>-		return -EINVAL;
>-
>-	return 0;
>-}
>-
> static int bpf_tcp_ops_init(struct btf *btf)
> {
> 	return 0;
>@@ -329,7 +319,6 @@ static const struct bpf_verifier_ops bpf_tcp_ops_verifier = {
> static struct bpf_struct_ops bpf_tcp_ops = {
> 	.verifier_ops = &bpf_tcp_ops_verifier,
> 	.init_member = bpf_tcp_ops_init_member,
>-	.check_member = bpf_tcp_ops_check_member,
> 	.init = bpf_tcp_ops_init,
> 	.validate = bpf_tcp_ops_validate,
> 	.name = "bpf_tcp_ops",
>diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
>index 5691c13..61a1971 100644
>--- a/net/sched/bpf_qdisc.c
>+++ b/net/sched/bpf_qdisc.c
>@@ -356,6 +356,24 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
> 	.gen_epilogue		= bpf_qdisc_gen_epilogue,
> };
>
>+static int bpf_qdisc_check_member(const struct btf_type *t,
>+				  const struct btf_member *member,
>+				  const struct bpf_prog *prog)
>+{
>+	u32 moff = __btf_member_bit_offset(t, member) / 8;
>+
>+	switch (moff) {
>+	case offsetof(struct Qdisc_ops, init):
>+	case offsetof(struct Qdisc_ops, destroy):
>+		break;
>+	default:
>+		if (prog->sleepable)
>+			return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
> static int bpf_qdisc_init_member(const struct btf_type *t,
> 				 const struct btf_member *member,
> 				 void *kdata, const void *udata)
>@@ -446,6 +464,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
> 	.reg = bpf_qdisc_reg,
> 	.unreg = bpf_qdisc_unreg,
> 	.validate = bpf_qdisc_validate,
>+	.check_member = bpf_qdisc_check_member,
> 	.init_member = bpf_qdisc_init_member,
> 	.init = bpf_qdisc_init,
> 	.name = "Qdisc_ops",
>
>Pls target bpf-next.
>

Thanks, that's cleaner. I'll move the check into check_struct_ops_btf_id()
and send v2 against bpf-next tree.

Thanks,
sechang
