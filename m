Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530709;
	b=bnDOzndJCtEGRGimVAVFsKpCPjClnarqmuWCRYHCSMsjA8tU8KU+9i6oyiqYw2uyQqEY
	 DC6XWqPsxEILrHWdZOTk0ypHqootHk6L2EShNpNYGfZZ2nvCALn7VEksrO3+YlTUxhLPt
	 P2G1RHEiIxSUCC8l32rTW3B81UAlrswN1lyWL/9ED3wVxBo20aluk+GtJfVtj+2SohIk4
	 8BGCkZq4RU03DovXrrZD6kn5S2EpNQirMczYCdwsde16a3bZznYDaRqP2pYdBOeHqwE/o
	 Mm1VIoEe7u0z0PQv1VPTbMyf6t5QXZKHZbRfUk4sLnk8zoa54fLp85ODjxq0Iz3nZBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e5nQK3hY4QWxDiFxG2TVLn0sC87qjDF+NBgRn5G+iKQ=;
	b=uC+izoOG1YSDzxe0r9i+Kx7g20KwyNyEZhKNxoL51wQ3i+gTnQOQYSPusdZIuwXZg8oZ
	 jcYWfhm51Hs+34q+4kjYM/gs/PZz/xNFjWERhF5pBOvy6VB4ES/BhJVuprnjRFAXpsf5y
	 6q2V7s7OfjeIwEsNDczPBQpcKOvR61kVTAgLqjqBnL4XjzzGC4B4ASJ73iCOrM0zGlvR3
	 E7D6TaQtUn10EZgIGd+eNYUvtxw0QagdY9VEy0CVZzqEJ9e1HCHdjyk846DmFv3PmV4Sd
	 t4Yl9gEqIvfcA9Prg87IdkCxQlXYC2bFRHQDpV8mJgHGqIRE87/jMEv+v2QFK2edkhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AjEHrqNg;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C1606A326
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 14:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AjEHrqNg
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb628232d2so2513936a12.0
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 06:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530707; x=1796135507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5nQK3hY4QWxDiFxG2TVLn0sC87qjDF+NBgRn5G+iKQ=;
        b=AjEHrqNgifqF8aPJ7EKJgLp2n35585eq5Lo7NlPgH7Ksj/AuHveZRs0v1+Jj/5Nk9K
         j+m9et26cCVsmUDROlNzguXU7+UAqRX9pNQL7hFerUbgazOwkPflbu4D2dCjEP9v318U
         qcBx5MXmk2SpLe7MhVmj7Gg5OXUqpZfTEYnUYDHGv+r2p9Hz6irlHYxkFGj8qj5h0SFY
         ovU0WeZu93+hL/FsH3taW3Bhd0qh6DJ7hxj19t4Nklc1hcnuguD/v+Bn9VvF03I+OyBm
         TOnOR0wxs8IQjc4nt34T2dTC9NQjZ8PdbM9CZoI00jbSq0z1/poyerK/kqKvJhrtWaIx
         ZxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530707; x=1796135507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5nQK3hY4QWxDiFxG2TVLn0sC87qjDF+NBgRn5G+iKQ=;
        b=rJN2vHFxkYE1pqVwh5Kr3zMVb4QzP4hli+ZSj3x9HBGZh0G5Wkib5HvnhH9j3iq8dw
         yNepJiH6v/HPVVdq7jLCQuawBhDnNfkcEvHi3WLcMxwBSmxNcoZXGmINB8znTqyRNqjW
         vE/pJwPz2Qg8Ze6GUTu9eyJIZVSnAYsDU+1zKlws3EOcOwWAm0Yhq7AL1VeklurULKZg
         HcPHa0rJ5yo7Q7kv1jwD6t/awI/SbxJVjqs/fOMG3oAAaxjKJhQVu+Q0IcNrDmMRYGQa
         eRTFtWetkeN4YEsrHaEttpJYWfytbpDP+Gba6O3eXlvr6MYBm6H553N31nq/m7MaEUpL
         SFKQ==
X-Forwarded-Encrypted: i=1; AL+hErHO4Xce5QFB6I26gfoVaJnAqbe+BfHoFcDe0Ns42sdObLjFudiVGst0TyIy9pGn5F2vm2AThYLsDlU/@vger.kernel.org
X-Gm-Message-State: APuU4Z/Vlk7dlz3MNXHHq3ZWTNQJ7UN+njKdF+6w9UUr7AngvSQFLF5c
	SBIr/g8QeDa7KDufDd00AkVd+tM6LNFQBjQ5Jbi1l97x6tcaTal3acfL
X-Gm-Gg: AZFdTZfPjjzjQHTxW3TZqkUE2a2YLpj0fP87+Kon9NZ9Ms41rzWQwlEa3nbHgzn0k3F
	/BiXQWx6J7oKvevkMgC1Z8EhKgGnjUi0vNrecrWQOWnYaGNYg3sB/Q2h3KRg/AAlNKHPucbPzta
	pqTUSBCLZG9lxOE/bRYniRtkIP++8avDeZI+rZjSLDt/w63d2IsMwa5pxTxuvZ0mi5QTOEzgZcI
	V6pcJUrUSB3vsNP9IY006V6cwjEIXFm4oM52+P7ZO6WsuvXzB0vYsbtHIbRgg6xNmH7WY1EP3av
	hop/n9HPGWv5I8EOubjYylS6SLeMqA91Jq1DjEptbV9qVDyOMYczSW8oTHCUl8+Yv4uKJMf5fXm
	B0Z+pBGHOTz6k1Q+vzu0DCoWkeCrUcsULAzdP74moRwVhKhBhm/6JQ+nowmRyUA/EBUAPQDgfcl
	3L/gP0szFGDQUdYBEDomEW7XVmUrkm9Lv/n23bPVzLCmjPzC6fzIyXYkpvQY/pSUgf9HtFo0IVa
	gyxYB95OLemNY8i3JVr5tmWs1l8gIzWXzUwYJxzOZMobigSLgGRPbqqw7SiJq2bKPb3vk2zuDFo
	PDDc72imy3JMAqcIoe0f3G1QSdALH/MVPMwFsWnvb4/7lseM+yXc/Imlq5sUQbOTJEj9FvjORl0
	hLSAIa9Jcng==
X-Received: by 2002:a17:90b:1d03:b0:3b1:96fe:f5d2 with SMTP id 98e67ed59e1d1-3b41c9bacc7mr14862324a91.65.1795530707373;
        Tue, 24 Nov 2026 06:31:47 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm7171737a12.8.2026.11.24.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:31:47 -0800 (PST)
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
Subject: [PATCH bpf 1/3] bpf: Reject sleepable programs in bpf-tcp-cc
Date: Tue, 24 Nov 2026 14:31:13 +0000
Message-ID: <20261124143123.1182108-2-rhkrqnwk98@gmail.com>
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

A bpf-tcp-cc program can be loaded with BPF_F_SLEEPABLE, but the TCP
stack calls the congestion control ops in atomic context. For example,
tcp_set_ca_state() is called from tcp_v4_syn_recv_sock() in softirq with
the socket spinlock held.

bpf_tcp_congestion_ops has no check_member, so nothing rejects such a
program. Add one that rejects sleepable programs.

Fixes: 1e12d3ef47d2 ("bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/bpf_tcp_ca.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 2a71dc81562f..acd5e84a3dd9 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -208,6 +208,16 @@ static const struct bpf_verifier_ops bpf_tcp_ca_verifier_ops = {
 	.btf_struct_access	= bpf_tcp_ca_btf_struct_access,
 };
 
+static int bpf_tcp_ca_check_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_tcp_ca_init_member(const struct btf_type *t,
 				  const struct btf_member *member,
 				  void *kdata, const void *udata)
@@ -335,6 +345,7 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,
 	.update = bpf_tcp_ca_update,
+	.check_member = bpf_tcp_ca_check_member,
 	.init_member = bpf_tcp_ca_init_member,
 	.init = bpf_tcp_ca_init,
 	.validate = bpf_tcp_ca_validate,
-- 
2.56.1

