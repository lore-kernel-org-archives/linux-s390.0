Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582297;
	b=TA7JH5HMszKsAC9rb8mkclO9Y61adI3Uzk/eezG0uREVXa3UwZ10hKPxQ2UALHK7gNfH
	 Jjp8kAjwaVL0tbXGmsK9OsBgJw7+2y29I1vnaBz9VUjFllJv4iVbb07N5Wk216djGYPS7
	 /k/kOtl4Qp1onmGosGxez1dIDxpRW9+Vt7/kjrcrz6N1ewzozWUgsGwFnzYwxHUOgljO/
	 GTqVkObMORxQbBkycUp2xuSTxnJvCCFJXlpICX8M+Z3/rG9g/P9knlJWBk2duQoXE2f3Q
	 tgEEBhfkkY0OgQMmHVqQzoRL9PIfDdfd9KXzgzFwQrW9QWRSXkd0KXFRwNAsJL3lcAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XO4TrpK9P96uCfE9RUiQZD2WOyvv7UkLXAlskXveiYg=;
	b=gXHnYMyXtTH1gE5MzhU2V4MbdqlviYfsPhRBmlfp+t/vAHiR5qpcmn2NCA0kxdbs2bLG
	 78yTUiuxKnE26Dukwo6iy1Iy9mSbkXJOETYooo196tYAL0YE2eY0HlqQmKMDYpboRiKxR
	 FVsmAzFe0MzPPHgRAhFSUsSh01i3yU4/T0nODaf0F2Fmfc0EsMX4CcZ3bsOkwLnVfBbdI
	 VyjZvW664tf7fHT2z+q2gzxZq9LMUzS/bi0yftZsWtn0+mepb4IOo//Ef0NDtbFdHbsEX
	 2/pNxPwXtDPDHhyWd0HYYJqy2HhhusbDf1v3MXTr6Cw2iV4+5J1txOqJSue6nIyezrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McoupJE6;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702F606A323
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 04:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B702F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McoupJE6
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cde827b7b95so1444375a12.0
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 20:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582296; x=1796187096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XO4TrpK9P96uCfE9RUiQZD2WOyvv7UkLXAlskXveiYg=;
        b=McoupJE6wFfgw5zfTpObm4Yqn1QNI/cTFKc6lB8T6YoB0iuTcnCCjvOMj3Ch8puAnA
         DyUDOkRXRv95zl1I73oN+tePX2MBItkbp6/x2/RhD70SiwnW2UZBU3rlFkqmDIKkfmvH
         fxMHfYQ79v23fyyi1XvIHiN+uXteKV5jCoURlmhFsvXxRAfIr2cdchzTYPUgEdNjf40F
         7lsKXVSVgrvWTkiRDIInkGPU3Ap9hglh5xTrgOxmBnXQTzRaIyw/bSpO1NK+F/BIu5zX
         YBCX7iMYxRv9R+k3Tatp1CGyXzzc/0OkiIg7AnZZ/8U+gtwnIkEONyabaf2owP4oP2yr
         +Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582296; x=1796187096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XO4TrpK9P96uCfE9RUiQZD2WOyvv7UkLXAlskXveiYg=;
        b=VNCY3tZgroU9XF+f/OUvMgCLjUoAnRpr81j9A6Sa6GJGVgFI7jc6LSUnoMPJsinSOp
         bp+ehL0Qigro2Qm5oCw9fcOzwFzTWVSP3ep/WTQIq0KoTfI/fe++Q77LO4E36xnfjWFg
         ECfAT5U6a57/A7QQBN/ItxkQAolr9fvGGYVYKMVhjbiq724qDErE2btGwJXlB2qUckWh
         Kq9C+FKOZtg0U4C5HttpmfWHwDYgCb/SHlT/RLh1YOcWSnM/VNVl/rWroVPHgDd7vQlt
         Ef+XgAGf73u+NJSuFj8bSN2CsKNv1BUkhaUm/SYuVRjZx0fHRTBMnimuqcG4WSM70iet
         zx7g==
X-Forwarded-Encrypted: i=1; AL+hErGlCDjP218hnYUhvNHgXy6/5o2/ExuMnZmDu3+e+Vk320FbZZglp/nGzCwNZCUMbwVddzZs+6owpuLJ@vger.kernel.org
X-Gm-Message-State: APuU4Z8xHK4MzPI2VmzrrXbDRx10kxfYLYVs0OctG71+vghojpwX0VVz
	/X4K+FGzQKcN+pk+LYNdQe3jcpNWMIAmQ6OTJBFGj6dYNeWd54en92cv
X-Gm-Gg: AZFdTZd5k6APUuveNvLqXMt43s9Hvl/PaBQU31D1YgELxbDmw2G+vFBkovfJung1+jw
	an1L2Wij/woMcoeIR6VEGuUTOXi9kv+IinAmCUBIfWWOUsqm83KjqEi2sHPEQZU/8QwEIINgglN
	aekjvIgdj/KFXG6UvS+zYW3hQl2/7r86GOPQSwOifCWn8pNFQ9+6IftNmL9uqUa0XuZUHcpTYIr
	cflm7SKhS2KTdSUxh0a+N7PVnlPNOcO928NDsK7WRaF+9emoBYV3j8B/OCbogKu0jiz62ppI/Zz
	54mCndTHB/P1nTV/j4w1oGnDMrDLOx0Pje1OVjqbfitPpoAYyiv9xXjuMFmaVsMHocb32ZIwv7t
	4wbk9zE8MKXB2s6/lY7vXS1YM9uaQojVAC822pYLAHG1MUgHB89jY/mJSIQ9mIIUVTOAhv1OBml
	c3zWDyjFrHDcEXd49fPGj7s+QIvrfo6VmQij25x1YJkVAs5dvfScSqbOdxgQAkthdoVW21CBfPe
	KcP42qG63QAsc+0eTFpk/C9NpImbq2OEjwHW8pL+SauW3ZYn/hWlfoeem0NOLmRnOigm2eILYCE
	DbuWSgwrcMmiiCv6jNMRei5gbBYJYRjnRU1UFARBSsvKvEWyTiH+cjl3KuEmvt1i
X-Received: by 2002:a17:90b:4ccb:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b41c7b67femr15911910a91.3.1795582295961;
        Tue, 24 Nov 2026 20:51:35 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm9457209a91.5.2026.11.24.20.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:51:35 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
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
Subject: [PATCH bpf-next v2] bpf: Reject sleepable struct_ops programs without check_member
Date: Wed, 25 Nov 2026 04:50:52 +0000
Message-ID: <20261125045105.2326120-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Any struct_ops program can be loaded as sleepable, and it is up to each
struct_ops to reject that in check_member. tcp_congestion_ops, Qdisc_ops
and smc_hs_ctrl have no check_member, although the kernel calls most of
their members in softirq, under a spinlock or under rcu_read_lock(). A
sleepable program attached there is entered through
__bpf_prog_enter_sleepable(), and lockdep reports "BUG: Invalid wait
context".

Reject sleepable programs in the verifier when the struct_ops has no
check_member, and drop the check in bpf_tcp_ops that is now the
default. Qdisc_ops init and destroy run under rtnl and can sleep, so
give bpf qdisc a check_member that still allows sleepable programs
there.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
- Fix the default in check_struct_ops_btf_id() (Alexei)
- Keep sleepable Qdisc_ops init and destroy (Alexei)
- Target bpf-next

v1: https://lore.kernel.org/bpf/20261124143123.1182108-1-rhkrqnwk98@gmail.com/

 include/linux/bpf.h    |  3 ++-
 kernel/bpf/verifier.c  |  4 ++++
 net/ipv4/bpf_tcp_ops.c | 11 -----------
 net/sched/bpf_qdisc.c  | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d15af0e..95835534b065 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2253,7 +2253,8 @@ struct btf_member;
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
index e7013ed8cadd..8c7e43220df3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23934,6 +23934,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
index 2ba73dd6c52c..4e54165a3928 100644
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
index 5691c13781a8..61a19713c5ec 100644
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
-- 
2.56.1

