Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530723;
	b=f6VtbCzveA5606IVAlNDGDlRR+xqVqGPGQ+KdCS7ZHrZ69DwzpstXZ/B8DEGQTn8vxzi
	 z1590pss2FCrTkBa6DLzU8AfSgIOpkGCazU6LwaY5IPHupGjsTPFnpT0pdPblhFxDuxcX
	 Pi1WeQVbrtUCn84YfdI/vmbAtoFG5P/mBOoFSDP8Q942ROeFOaLF+W6XFp7duEdTIFflY
	 eXwNGn+xpO+c71V4DA2kF/KDnDa9KazZeVb6LwCPpMqlPgeI0PHFluqt8NWo6OVeG3qJc
	 2p0uPuJmoGzZNCqWDyvi7RJWglpQDVd0kzxaO2BNOWFkjpQNhImT5CDJE2N0w9dXwMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dAalStsyfXudMpg2j2V+fdfxbWvoIc3klIPMOpbgtew=;
	b=3fRxl7phzf8QT6s4c7cxBPrn7VNRcFGKqLF0tVhhQ4pBy6EEv8PalhQyyXv/bI9XMiz2
	 Z+2zYwmFI7oSIc0yu00EcA3pkCkHNp7WOCg1+OYSMqHy9bhKCnxPGEr3aMW01HLyrJiCr
	 Usy0ED9Ro95XiS3V3yc0EQ4rgo7Ovy/QeUjx9xuZz0XCwrYyRfUNWTmgr8oN9GGql7QMc
	 0yJoHBlc9UApQ5NnhASWPDpjYaikbVxSwThMzfe/DVbuv6c7pw30lTDWoDDaoQALJorrZ
	 4ZlM9/jD4ZBNw1EFREQ/B1EFBcdJobpb6JJ75iy5tuouB8xf1LKh1dE3oGNRyKJtbLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cN6AA1Jo;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0B606A31E
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 14:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA0B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cN6AA1Jo
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so2037595b3a.3
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530722; x=1796135522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAalStsyfXudMpg2j2V+fdfxbWvoIc3klIPMOpbgtew=;
        b=cN6AA1Jo5PTed4Fuh1Z32tEBYOm+rwHdXRbPRhYueW20CqSPtk5CMVk+ar2L4h8YfR
         YDfoP1ddutTvohm8JkfBJLQP0L/rIc9rfdbeXoNlv3i9kStKCiUWl/2Sh+S6aZ7Oh0nI
         uiHQ6sCsJF7cXiyTzuRvHbYEFWH8L0zvTYAIn9VvopHd/ImDLgymUzizDWmswczd6OoC
         95DbOCDWTgzTefd+29AaCAuvjTrJjaRcqjUhesHuJlSjw/59rnscG053hvpwnIKHtUp4
         uROQuVFyxnBuPUVhEMOF6213D+8WP86Q6TxVERdTqqEF4/BA1Jq46UwVUH0b+LX+qI2s
         r32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530722; x=1796135522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAalStsyfXudMpg2j2V+fdfxbWvoIc3klIPMOpbgtew=;
        b=dBNM/IxgHQsdbJIOcE343YN4l7liaVwvV8QQxavGSS6h13yXlDhEduWLPw2QyJyUaz
         NquIOx3gWoDGr1mjt+fcVkiwiRsNTXeuP9ODGyUeHfgDJAWl3VA4JeNbWTyT4o+YdPzG
         e/Y7Iv8JYEzSldliVqN2JTNg1MNGeWSZYMaeTV97V7YKA1lSL9ias85/THrOeWjFeHck
         DNWOd6yIW63qQ9JTm2Q9PK7Z0guMQCVPFsEIKeFvGQ4Zpf+koTKRRgzJgx8ZLZjHmjir
         WO5dCjhKBs4fbKvZ8tNYaJFzW9d/pFOHtMHbMwUe9xl8hQcaZXx8M3PMKx/T52CF20Dp
         EKeg==
X-Forwarded-Encrypted: i=1; AL+hErFAR66uDlR5Tapzcoa8w4XeizGeOZJX80fE23oYbZ8+/t72G6n0e7kO1Kv5x+00TFcf3QTIWm+Lvs9h@vger.kernel.org
X-Gm-Message-State: APuU4Z8hd0ylSxIYcdgqF7kD78qdqZoqeOAj4uj7l9u3szjqSIn+lAno
	1QzvZQjgsCCWhZf7pDdjrOPIeL4+ygcKBPZ863lIOUWpfTTIVbfkGjug
X-Gm-Gg: AZFdTZc3vJ2a+yGz2duMzQoYppClNXSUu+Tnlr9DqSkEs2pv69car3zOi/5mnPbg+B2
	ABNVmoGoUO1jn9amYp4oBbI/3StSxMZ7MHx9Bag0zvYkT8eVJ/CRtopQiREO2ITFlMk1d2ZWFmw
	gCXAUZK5DNP/m3Zkj4yNqskI+wXFEk7WivnhZLbAZhD0tyBifjRMaeQYuHCpUMoTGlbQ4Ei+q3t
	HWxtjiRV1WuG9hCYBkUGrMERUEIrvJoiPCvr/dv0TR/fY4ir8mFLrnyy/HaJjWlh06TzolM6szJ
	ol+b7/aS7fHr+3UbcNQwvTdyz17LEPsRyeETpo24fJHEOgl3FREYlIvTGMIS0OGEWj8COrdI5BI
	2t/4dMZOp+gaOfNosAJ9BuaGZ4j7C0zmQSz2Kv7VeF9mg3+kK3OA92Onb2udMNPrH4dDrulnjM4
	iWDtDcln5MkCyY5bjEtTWyqGr8LJ7+pjI7etuaX/qd25NBSi+VskLBcBbAP3vXOa0WCK2zOfQT1
	vIo8vOukiDNRuZo2uJjmEXAqqiCt0KinSPTCDZaSzazAFZwHRGvqi5BjZWH9HXBvVjp0OXuBvlc
	IYAgSaB4m2txqE7KhTPPFxClvJDf+oLbzVSrp9hgeTX4aEtmkm2sGCfnAuWhnNWqCwL3b1AQ+vx
	WzR6GFY8wNg==
X-Received: by 2002:a05:6a20:a107:b0:3de:b0cc:b0ed with SMTP id adf61e73a8af0-4014c94a7aemr14594290637.18.1795530721628;
        Tue, 24 Nov 2026 06:32:01 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm7171737a12.8.2026.11.24.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:32:01 -0800 (PST)
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
Subject: [PATCH bpf 3/3] net/smc: bpf: Reject sleepable programs in smc_hs_ctrl
Date: Tue, 24 Nov 2026 14:31:15 +0000
Message-ID: <20261124143123.1182108-4-rhkrqnwk98@gmail.com>
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

An smc_hs_ctrl program can be loaded with BPF_F_SLEEPABLE, but
smc_call_hsbpf() calls syn_option and synack_option under
rcu_read_lock().

bpf_smc_hs_ctrl_ops has no check_member, so nothing rejects such a
program. Add one that rejects sleepable programs.

Fixes: 15f295f55656 ("net/smc: bpf: Introduce generic hook for handshake flow")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/smc_hs_bpf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/smc/smc_hs_bpf.c b/net/smc/smc_hs_bpf.c
index 063d23d85850..66cf5143109a 100644
--- a/net/smc/smc_hs_bpf.c
+++ b/net/smc/smc_hs_bpf.c
@@ -82,6 +82,16 @@ static void smc_bpf_hs_ctrl_unreg(void *kdata, struct bpf_link *link)
 	smc_hs_ctrl_unreg(kdata);
 }
 
+static int smc_bpf_hs_ctrl_check_member(const struct btf_type *t,
+					const struct btf_member *member,
+					const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int smc_bpf_hs_ctrl_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
@@ -130,6 +140,7 @@ static struct bpf_struct_ops bpf_smc_hs_ctrl_ops = {
 	.unreg		= smc_bpf_hs_ctrl_unreg,
 	.cfi_stubs	= &__smc_bpf_hs_ctrl,
 	.verifier_ops	= &smc_bpf_verifier_ops,
+	.check_member	= smc_bpf_hs_ctrl_check_member,
 	.init_member	= smc_bpf_hs_ctrl_init_member,
 	.owner		= THIS_MODULE,
 };
-- 
2.56.1

