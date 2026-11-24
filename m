Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530701;
	b=DmlVZlVxNyaKVhybU3YYlOLc3zeqxARbsku8yrxwLBznWfJMQpu6WIY4Hx2PNs+R7o7A
	 du4J1DraFfAKYRVJ+eUNY5qbm3gRc/FQUZtI01NC09x+NLM4YSHAOzYeYoIA5XFW4PThN
	 E0JG7gq6YIUZ2Ybqq7x8Ylup/Oy487dN1yKipt2XMZS94rRUkizFgX1mBMLC9MYOJsWKD
	 Ms+cfQ6onEbcI530q8Y3QTIS49sl1uXnRx2nai6JZDB3f6GJz4aZuLKg2DOzJKDoYuQvu
	 iNDYmhMzaFVDFIGDyM2nGn1OY+Nfa90cSw8Po0540Ke3q1Twsa6Otev5oTe4tfvYnPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jS+nnfUP/mk+uzq1WRMmZ1+p5s6g2KJ+Zyoi13aubO8=;
	b=5RrP4h6T6/joCL48dzwpbJgZ6Kekl5F6sLWeVPHMfshTX6hwiWbCLd2FsZ6Ny3q6boey
	 PAIWwtLKy1wOo4QEwndXH3YkGtx7X21SOaUK4Ej0HjlOHDr1ArbBRI6ZkrCdUF+xc0QVg
	 PHoKbIz8dcjp/rH0tntr7UPMrvbNc78AV6TMTTiqm+KAuD80R1APCtKfyjymf7PA2xRgK
	 ov2dBRJN8b1Smz+FMolueRiPglogIDwvB0kjCQkAb6BYVOp9N1RYVI66rkACdb4wa0/kG
	 vgUXnG2agBvAIUfRCZ+1ZffzrLFtAF36Ou9RQlzDREj5O/sIDN9OsRlsSa3NRZ5IFNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pC5sINY7;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFC606A321
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 14:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FFC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pC5sINY7
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b402824d07so3101479a91.1
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 06:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530701; x=1796135501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jS+nnfUP/mk+uzq1WRMmZ1+p5s6g2KJ+Zyoi13aubO8=;
        b=pC5sINY79C+4AgNwYCHtQsgbceJxN2JL/o7ODQlGs+RCFyL09S5SBB3jb8+RV/zu4c
         uReUsgjhRD4YOTORigQTo1Hg93FhrKwIUBX/UFc54VdocQzI8ijqZYMAv2Fk60+F4r+c
         zc2B+VML47gQVM+c4GoDFitRViVwlIptdpnSB7ROGeeMOsEUGjjOsserxv+ourBDy4ZM
         lzy0PbaK2lRCbLFkXrW0LsnCL1d5wIRcXdcEJyL2x9mDvbmG9NZQmiiEPdNmz6Ssq9pZ
         ky8TZNgnZznEB6JP9HnTyhI9osqEu1BF5MF/jPp9VdywsrtelmCPrpZbFWuRqNxUpgiy
         Zqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530701; x=1796135501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jS+nnfUP/mk+uzq1WRMmZ1+p5s6g2KJ+Zyoi13aubO8=;
        b=Mwa31DhBCHLby9OxC74+WLDQKOew+l4faFV2/xrQjnIQpmokDeZj6gsDwmLRBrZxwS
         AuTQKO8zGGYb8NDkZvEgg5uEi6Ub6E8x9uWHUnXFSxNqMcpMWdYo5MAGAq19c2zAV4GF
         M/LaIi9T6g0wQR1ERVZLjBY87LxAdOBvZlUstqKV9T5u3qg4aXT1S2plh8kd8AiNDuHx
         u0pPwkt0BnPNXGkTpXVDr1uAgQcmW69HE40xSutc7+yKrZjE7fha7P6rkrRJRqRIY+ev
         1HZZbXazflJ3yTyif+PmSuugVgcUMYVDFW8D7RHqXEIS/PxRNtjQsUKhD5SNA25lHnt2
         PM4w==
X-Forwarded-Encrypted: i=1; AL+hErEtDPHqH9SjveArxjH8O0GWtalepgqmJF8xs5Y7RLB0P3ye88Rme9Rdk1NkiJw/+Fyv4KLvVXLegZPD@vger.kernel.org
X-Gm-Message-State: APuU4Z90KITBop72v4eAUuAk1JWw4Jv75NINMwif6ekkesTkwgmYY3+Q
	HWCavu+y5AVR/4TsL2PwiIVzgV55flQJETUG8UtHNzmhXKjnJGnsK0qJ
X-Gm-Gg: AZFdTZeHCA5GRhldUGo3q1rz0Zd0os1oa0ktL86QMYsoTts41ULgGoTicLf4kQLPoOy
	DVYkP13q3OLxhf0TYFEkWvOqnMS3vrX+Z5czuAC9gPvgLcw5NrLi25aE/ruM6K16T7NZ2Hl0VJW
	HeFg4Nn8MSVaCPzlW8KOOWE5n/+IIsRSkeksPtNgkt8uyDHunX0eb8OWFX2lLjhGP/O8EdmckfL
	Bx4iTVLyhI5zaKvrRJNyAT0CWK9Lpr5hNdykYVRF30A/d4rdlAQcfTPwuE57NCxZFtS1zDyl443
	3vngTAmwLnZbDgxVtuxwWdLQ09VA/AlfJ8c7FNSHJIDAMdSzlq5ioefB7kx+32gg6Y9ywhpwUi8
	FH2HF1AdhvVpMfqKotZj+zbUaxcxBiugqfMOkU7I8nLWLPk17N0mQI+eO6tIWFd4uoxZMo3E1Rx
	xUx12JNHyldWwiu31M9rcaRNLY1lU25SxrWzxdJzpgjoBSL1OxvRqGfOkKhlMYh8SPH1cij15FD
	XUSjeRXg07vB0ocyWYKpKUORF291xpwpqGTpi1A6DHjuqexMHUAFLde7TuwYxLSK4nDKxGSgYNk
	enjriR4CBLmFz5e0rS1U+OTNve5U3WVLPuL24FPuyO1p0351p0YJSp2iwwfo4lxjS/JKIQ7iT/F
	4+7C7Qn3jAMk=
X-Received: by 2002:a17:90b:4d10:b0:3ae:533e:7e40 with SMTP id 98e67ed59e1d1-3b41c8d9bedmr13597888a91.23.1795530700477;
        Tue, 24 Nov 2026 06:31:40 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm7171737a12.8.2026.11.24.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:31:40 -0800 (PST)
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
Subject: [PATCH bpf 0/3] bpf: Reject sleepable struct_ops programs in atomic context
Date: Tue, 24 Nov 2026 14:31:12 +0000
Message-ID: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
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
struct_ops to reject that in check_member for members that run in
atomic context. tcp_congestion_ops, Qdisc_ops and smc_hs_ctrl have no
check_member, although the kernel calls their members in softirq, under
a spinlock or under rcu_read_lock(). A sleepable program attached there
is entered through __bpf_prog_enter_sleepable(), and lockdep reports
"BUG: Invalid wait context" at its might_fault().

This series adds a check_member that rejects sleepable programs to each
of them, like bpf_tcp_ops does.

Sechang Lim (3):
  bpf: Reject sleepable programs in bpf-tcp-cc
  bpf: net_sched: Reject sleepable programs in bpf qdisc
  net/smc: bpf: Reject sleepable programs in smc_hs_ctrl

 net/ipv4/bpf_tcp_ca.c | 11 +++++++++++
 net/sched/bpf_qdisc.c | 11 +++++++++++
 net/smc/smc_hs_bpf.c  | 11 +++++++++++
 3 files changed, 33 insertions(+)

-- 
2.56.1

