Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795321282;
	b=EBQJo+LyHqL3yV3H/fluIW1io5wigLaL7pQovieqmq8cVtU7MPotd5nNjOa/DnrYu+1N
	 tm0TYtlZsCgqOwdmBs7aPjpwFzkFAAlWeo2AyCylND/x6zv5djuxvSX1dNCBq+Tx68Rch
	 0txM6B0p21pAzjjjE6MjlUA7zYQF2anh/TN8sf0AMmHPAeCrkg73etNvJEiXQp1d3FBSC
	 3W5AsXx/ykev1StmXiWnDR3MBPvwKR0gt7wzdn74zF/8/yPH5qxAbdfZKGQKLtMJSreD/
	 NEXkVy9DeSFA/7l0iDxCmj7feyATkEtP+zBgnUq5reNP86b9vkgftAP03/YG5bWTJgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795321282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5ZGfxFm22MqdeOsOLhYKxi18iGVL17970v+rtqXfBak=;
	b=hWx7Di40LKGrl7COmDJ+d2YcXyaHyfupoUlppYYJ1SV6Wz537vAkfzQtAHBghDmkKPi6
	 5J9GHjIEqSpa7Z1ipGPyeaBFCrmX+tPELCq7sLcvBl/Iwha3/IQbuM6USBBNWt+JMXvLT
	 KYUYrGs2kFISGw+wHKO/mZmMfd9YdxxYwsoT8M2IEll6o8WmRh+aNfR1E8wBCD5c9l5Ld
	 VVWkFdMsCFNexAKXz9zcUsBsTf8IAz8Z9L9lVZmV8emNr/8CNyTk6h8bPf8AkMK9X4V6/
	 iUYArge6XozOhOkueBNV6YvGplHw/RQatk4mLImKmISlaW1py+96SOzYg1g95V7Y/Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=TlXDXhE1;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53572606A32A
	for <linux-s390@vger.kernel.org>; Sun, 22 Nov 2026 04:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53572606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=TlXDXhE1
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cde1479f76fso1396817a12.0
        for <linux-s390@vger.kernel.org>; Sat, 21 Nov 2026 20:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795321280; x=1795926080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZGfxFm22MqdeOsOLhYKxi18iGVL17970v+rtqXfBak=;
        b=TlXDXhE1vFamfVLeUXgS0rBDmWhARPSEQdZqgYb1TiKcGrKVl7fXBKPP6/JGfUDqYR
         OdJPTJdan2Hz8or3R3YtQFDsX8zxOZjjxoFH7usjuiOak/CkNBFXsz4OCOpUfpGXpdsQ
         TacQFdsnM9SmOIBkRkFLEBxIpkHt5UCcCb9w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795321280; x=1795926080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ZGfxFm22MqdeOsOLhYKxi18iGVL17970v+rtqXfBak=;
        b=IvnJcbLb6FQVzJNiIQT/WNwX4ISiGDcQJb2L9PFeoOxwNagQSOtEeet0sjtUHXySpr
         Ikg80PPi9nQRsHAPF+iqzGN1jBbQcbcbD+qxRroa6ifjim/UZ/OT9iBEdSZypwYvJv2w
         QXnWnpuqz1aBfIQ8Sy5hVsyvpitoFHIK4kz+iKo4upvLurwgbBabqsN/6MsVwXSyVEWQ
         MBGj9bs8OLxGUD5JBKOtvj7+E5OtYdssEWrCqsOAf6bZ+VE5VOJ8e35cabBt8bdzhmBe
         90ao3mfRhce81MHcgnjYqBrfxUHjS3pemgNs5xFtoz7WApRvfWvNSK8TsYlxuCYOKFeP
         4b3Q==
X-Forwarded-Encrypted: i=1; AL+hErFDdx8OHsWltb/tb2yvphnSROpCZf8Ho7WnokfPInTS29ff9FGA7UVvleZAFPt7PB5WY0DkxmMRtWwd@vger.kernel.org
X-Gm-Message-State: APuU4Z8nZYIP5yUzP8BWVk2NDWDXQlsj1lLqyG+C8AyM6BT8t0lRUMSO
	yBUzW6C5pcyA+QmDmpdgmO/RWB0NKP5ciSmwLzbGI1e1HTJ+z2fnNPcizoCI8uruS+A=
X-Gm-Gg: AZFdTZcpmomknQs4S3u0BnBbaK5Erh9JF+Lp29eMA+U99nfZqsgTHSyzZEU3VLYRHCD
	X1YLmzJmEexSS/eyzBnYjDILtzO7MA0uKAeukieHMS8OrmcHjcKz6VvNGBceJl2E6FViQBhB4Ju
	9xPB5a+Vu7NSl3OJsr0YJs52GrrJIENNOgmVsIJLJOEiZxKkhUKLGlcLBdWIsNmJq4mlKZcLFUw
	3gbXZ4yFxelOUtX84I2alnPpIdQh2n5SjpagRI45DMnrki1pmYZzr5OF6mDoA9X+jFsa5/XVujF
	jN2as5awNUbqAdkWfSSjQHB2jko9b1sUdr/4rvhRYDDKSbkwG86Q0aBXvUZ96rNrIWQiceIbtpy
	sBHuGPztOOk8eh3zlh7zmGpnyVd8oFhAbahoYnMbR+mB7qbE7TpydF+hGaGu1sKRQwXbQ11c3DO
	RMciHmWL68RCQzXa642AO+HazBZw4zY6YkwKQ3Pyj/ov6JhEX7RwDlkCKVPJGZnvFkJTWbKJxAE
	JY49GDKCnWyvqTIdQjHv7IUYXivRDSzGDbxTL62AVqrwAogKO3p1WHU31KAq9/NwMc3068+ZZU+
	13LzKp0QBqfO+i+EWsTEr2xogQmu5hVs3iKnlTOpYcZ8j39IC4If4ZUGMwLmxpX5O4+FVUIHsEo
	uhexqrZwJEloADiM+/XKJ72adpDrYjcpG0BwiD7XX4Eji25nxc33vT2ezkMxrmBG1
X-Received: by 2002:a17:90a:d2c7:b0:3b4:a90:7f3a with SMTP id 98e67ed59e1d1-3b41c95da5bmr6806828a91.55.1795321279640;
        Sat, 21 Nov 2026 20:21:19 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d97356sm13717803a91.13.2026.11.21.20.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 20:21:19 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: alibuda@linux.alibaba.com,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	netdev@vger.kernel.org
Cc: Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>
Subject: Re: [PATCH net] net/smc: validate the peer's CDC cursors against our own buffers
Date: Sun, 22 Nov 2026 09:51:13 +0530
Message-Id: <20261122042113.2430308-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179528990895.3294.1614564040906254045@kernel.org>
References: <179528990895.3294.1614564040906254045@kernel.org>
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

> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Sorry for the omission.

How it was found
================

By AI-driven fuzzing built on top of syzkaller.

Its analysis was checked by hand against the code before we wrote anything,
and every claim in the report was reproduced on net.git main at d5b89d55a322
under KASAN:

  - a 131072-byte read past a 65536-byte RMB in smc_rx_recvmsg(), reaching
    userspace through _copy_to_iter();
  - a 1-byte read at an attacker-chosen offset in
    smc_cdc_handle_urg_data_arrival(), from the CDC tasklet;
  - a NULL dereference and oops in smc_rx_splice(), where vmalloc_to_page()
    returns NULL past the end of the RMB and get_page() dereferences it.

Each was run on an unpatched and a patched kernel built from the same tree in
the same scripted run: unpatched reports on all three, patched clean on all
three, with SMC_DIAG confirming SMC-R came up (mode=0, fb_reason=0x0) in
every run so that a clean result cannot be a setup failure.

What changed in v2
==================

Sending v2 separately, because it is a code change rather than only the
information above: v1 validated the SMC-R path only, while the report
acknowledged that SMC-D shares all three consumers.  smcd_cdc_rx_tsklet()
reads the cursors straight out of the DMB the peer writes into, in host byte
order, with no validation of any kind - not even the length and seqno tests
the SMC-R handler applies - so v1 left the same exposure open there.  v2 adds
the equivalent check on that path.  The SMC-R check itself is unchanged.

We have no ISM device, so the SMC-D half is reasoned from the code and from
the shared consumers rather than reproduced; what we did verify at runtime is
that ordinary SMC-D traffic over the loopback-ISM device still works with the
check in place, so it does not reject a correct peer.

The interdiff from the posted v1:

  diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
  index 03ff10fef..8d24e0c83 100644
  --- a/net/smc/smc_cdc.c
  +++ b/net/smc/smc_cdc.c
  @@ -433,6 +433,18 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
   	sock_put(&smc->sk); /* no free sk in softirq-context */
   }
   
  +static bool smcd_cdc_cursors_invalid(struct smc_connection *conn,
  +				     struct smcd_cdc_msg *cdc)
  +{
  +	if (!conn->rmb_desc)
  +		return true;
  +	if (cdc->prod.count > (u32)conn->rmb_desc->len)
  +		return true;
  +	if (cdc->cons.count > (u32)conn->peer_rmbe_size)
  +		return true;
  +	return false;
  +}
  +
   /* Schedule a tasklet for this connection. Triggered from the ISM device IRQ
    * handler to indicate update in the DMBE.
    *
  @@ -452,6 +464,15 @@ static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
   	data_cdc = (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;
   	smcd_curs_copy(&cdc.prod, &data_cdc->prod, conn);
   	smcd_curs_copy(&cdc.cons, &data_cdc->cons, conn);
  +	/* This CDC was written by the peer into the DMB we published to it, so
  +	 * both cursors are peer-supplied and index buffers described on this
  +	 * side.  Nothing else checks them, and smc_cdc_msg_recv_action() uses
  +	 * the producer cursor as a receive length and the consumer cursor to
  +	 * credit sndbuf_space - which under DMB-nocopy is the memory the peer
  +	 * itself owns.  Unlike the SMC-R path these values are host order.
  +	 */
  +	if (smcd_cdc_cursors_invalid(conn, &cdc))
  +		return;
   	smc = container_of(conn, struct smc_sock, conn);
   	smc_cdc_msg_recv(smc, (struct smc_cdc_msg *)&cdc);
   }

Thanks,
Piyus Kedia
