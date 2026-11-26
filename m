Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705745;
	b=4LmtiOZmxW/81xvVhXQ2dT0CANjyd42l2+MKhfSZhsEqCUUAYi7CmQEJIA2f47z2S04O
	 30Ez3aqkjsEDEslpa9fdWQPBUtSrCrf1NLhYyNbPFaG6/TUfCGpAWIKCLo3N7sCC+Yr0r
	 VSzO0+EftbsyCcW8roUo1oFi5sNU8XLqB0jWWz/18ZPyTWQPCTSpnCcujpSnHgYP7MHq5
	 ry0PWMqEqpGXKyds+JNmAdtXm5rCBJllXITqNLFoSqbReaO6AzHpV4+37KFugT+vH63sk
	 JjlkebB7XMdSrISlbMx49edLMSkw2pkKhj87xZd0heOa6P63CX+t5kGdEx+MldZeFWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qa1Fr1ic+7dw5K+GkYsqx2aXPhAv1AnGBqdarsMvPfQ=;
	b=KWdO4n/G7o8rLc1MlukktZXBFeCvaKIvmF0bo8TuwyVkPNZOBtDz/FT2CZqkNWri54ed
	 PVrv9xa3vPRfZTrjWOF7ca5pN2YYidL7gsqz7Qe/HlF174tGUIm6UeFr3pQmAwrwbjszW
	 a2zd/5zCzc/4kAwYLO3bH8thJzMYRYPpqpamJNneWW0kT0FGwMuyOxI8DOWLeK6rUjto1
	 23jWzrC6e7vDwYjCjIKbZFP2zr2DDtgeA6YqMuVxPvbdSQ+XfJuyJIlOIopbcRRBLcgnX
	 UobVfG4Gj9VEPIUke42YG2JgO3VebjcgleZt1NaijCOOdNbN4wU0diYihSYYuCVxiAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=B6xSaKdB;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54137606A323
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 15:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54137606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=B6xSaKdB
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso2824531a12.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705744; x=1796310544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qa1Fr1ic+7dw5K+GkYsqx2aXPhAv1AnGBqdarsMvPfQ=;
        b=B6xSaKdB9GurxyEl5XPkhgRx383fZevVQduVZmC86MWv382bjsTEtHbvVGgHN4Cznn
         4JSZJ81ag+eMbef5qkmG1EHTwPt1/D4GYkbNYl+b20Pv4J4wnJQGVnq40kjtElZ5UCnE
         yxT0xLW5tIIGRUC1T6ZTZzJz2XBXnuo3V4r3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705744; x=1796310544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qa1Fr1ic+7dw5K+GkYsqx2aXPhAv1AnGBqdarsMvPfQ=;
        b=XiiUx/6I6Hj4FvHZDciFxJdNaHdmuF2WURVhHDe6aXTTmRUSwZS9DnEtMJLgvQKvx2
         T+fnzebxxGPRED6eJURJj8nl6S2m7P7IjPSQQGCV4TKk73jqQgLL4KPGzQdHquhqSHG3
         oiZE5fqel7tKqJ9oAyp9t8o2qGR4wJMo+MKOioOEJSTqgFfHtEvjpBXyVusVDm55oSmG
         5ycpg4W8GKwVjoT8GYlxWf2v9sVm77nu2T8uXZV3AcU5hxhVGiaTY0BHGwo/d3oaWt3v
         xNnKUBPv0tfSIfcHzMao/g4cVK9SO/TksahpITTw+hsb9EdcMuSv3jzVVq/rEH0GxeBZ
         V8aA==
X-Forwarded-Encrypted: i=1; AL+hErEp1rN9i3VSFNqF3UNxIfY0HqTlNcR3ZEbwxRkRK9Pe/YUggel97+33UunUkrRtE91u4re5nJYs8Lbu@vger.kernel.org
X-Gm-Message-State: APuU4Z+9+XlQfoFDKKEfuM9g6qRTvMjPhZ1kTAbVsp4CT3olg7pArsU4
	zdE+Dc3Ct190yE5QAT7NXP3dydmITOeXihP3IsMDPztqbPsdzNd5a6skqI2wZS2c8HI=
X-Gm-Gg: AZFdTZc2G8cEGzSDd4D6WXWnvdTOD1jf5JcyMhd1OiXzxELik984ao+9qIpjWAFtItA
	3lmFVrecabxJEeRuQWKVp37YOcubGbeAUr5sL30udjcIwWOnup1SIGQNg6JLILct4X9Aq95ggkg
	32FOhQ9GprtUe54kLks/ApDSnRA3SasNLQ0thKuvhmX1+HcBZgE/6pr1JETPPzncRKivBQ45cQE
	Ql5rq/oox+PEVLW7fNKZ0d0DCDtaPswjoo3T2bkkBurPlfCkkczxt2dvBVkhAdSmqSlBein5Cdq
	81lQe38w1U3P4jKUofK5Qz5e+BJMQGBkIrBx3m4ZnJKMnx9k51LDFMRChZchNY5WmgghIqXN3ag
	0IX4DQv6k8f9Zjfok+nCU4iW6id6PxIAEkqwkuYg04I8zEMJt+kWUb/8FTbfSBsQuvnX8Oy1p/b
	v093qJL6abM1wcifb6GBD4xshEKbp5AIsM897lHHBWzSgBfbKPmfmUECykWMzrFfatowgBZd1W/
	ze8E/B86GSqkLOtuAs5uqSOOLnSrOZ1svdhAXJ+dBcJMsfcB/HgbHSkrskfP+AkpK4PSYaN5eQS
	ZO38wvh8OuGimF2mkP90t+Jl+JsREjG6JrXuseKksZ+sQHqBoB+zscPSxh+2mw20Xlx9beB/ibQ
	QNMf20TNsxkF6j4pmrYt20MQxQJwvEdDqIcvU7tJNzTqQM224zOE8ANyTCVkaAXF8ae+Oh9JO3J
	MBj0WPAMGf1g==
X-Received: by 2002:a17:90b:2792:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3b41c8e172amr19036608a91.8.1795705743643;
        Thu, 26 Nov 2026 07:09:03 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm34512681a91.1.2026.11.26.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:09:03 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kapil@presceralabs.ai,
	stable@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net v3] net/smc: drop the connection when the peer's failover cursor is impossible
Date: Thu, 26 Nov 2026 20:38:56 +0530
Message-Id: <20261126150856.2116458-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-233843@kernel.org>
References: <sashiko-outbox-233843@kernel.org>
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

Thank you - all three findings are right, and each mechanism was read in
the tree before acting on it.  v4 is posted separately.

[High] premature cursor rewind before abort check

Correct, and this is the one that mattered most.  v3 ran the check inside
the fix-up block and returned 0 from there, by which point

	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
	smc_curs_copy(&conn->local_tx_ctrl.prod, &fin, conn);

had already run, so the connection was left with prod behind
local_rx_ctrl.cons and peer_rmbe_space still holding the credit the forged
message produced - the atomic_set() that recalculates it is below the
block I returned from.  And the tx path tests conn->killed and
local_rx_ctrl.conn_state_flags.peer_conn_abort, not out_of_sync or the
local_tx_ctrl flag v3 set, so a send under lock_sock() could reach
smc_tx_rdma_writes() before abort_work got the socket lock.

v4 validates before anything is rewound and drops the connection with the
cursors as it found them.

[High] incomplete peer consumer cursor validation

Right on all three counts.

The bound is now the bytes that were SENT and not yet confirmed - the
distance between snapshots of tx_curs_fin and tx_curs_sent - rather than
sndbuf_desc->len - sndbuf_space.  As you say, that counter covers the
PREPARED bytes, so v3 would have advanced the cursors over data still
sitting in sndbuf.

cons.count and the difference are both bounded by peer_rmbe_size now.  v3
left that to smc_curs_add()'s single subtraction, which is exactly as much
as you describe: with sndbuf_desc->len larger than peer_rmbe_size, a
difference in between passed and left prod.count outside the RMBE.  Below
peer_rmbe_size the repair is exact - prod starts at fin and the difference
is their distance, so prod lands on cons rather than behind it, which also
closes the "halts sending" case in your third point.

[Medium] false-positive abort racing tx completion

Right, and it is the same line that caused it.  smc_cdc_tx_handler()
credits sndbuf_space before updating local_tx_ctrl_fin, and
smc_switch_cursor() holds only send_lock, so an honest completion between
the two reads gave a diff computed from the pre-completion cursor and an
unconfirmed from the post-completion counter.  Comparing two cursor
differences removes the mismatch: both come from snapshots taken together,
and neither is an atomic counter the other path updates first.

Tested on 7.3.1 with KASAN; net/smc/smc_core.o builds clean.

pw-bot: cr
