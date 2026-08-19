Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471D38D017
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106801; cv=none; b=B9GUmWH9eeypSvCy/F0032diLzK0sg1bU+daF6aAoH8OvqdEnkTHCz92kf8TyP3yCfkZeA+m5Xj0nFimzoBDUFZ1Sl5Zf0/G3Q+z6hc7CtwZQe7toqTqiaIyHoPNyjM8//tRAcnQzAtbJ91heRCIuKJJrjp8UF5eEjhIp6kMAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106801; c=relaxed/simple;
	bh=KbiaYdST825OypEoV7XDa2SfQ25BArmjG8UWZpsc8wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQfqyksuLXCEiR3FRfwEBjRAlNmRF3PWk/q+QEm9M2OWC9Jfuc0/+w1hGVqWcBRh6nVeaB/GvYL11ed801uBX9F+GnvEhN4YtUplBXtRM290hpwnh21Y4g7GBl3smj1YbS6c6ouDMQ5C9LuoI6WNx6W8gM3Ydbrn9TukH6V6VMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=OalL/Zzb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="OalL/Zzb"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so548901a91.2
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787106799; x=1787711599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgYieFKziqFiGeOaqNKzx6X27Iiom9cGSOGSf1oWB94=;
        b=OalL/ZzbEQ8h8NLaW8PHeu+f08u50MSzBjnDN1shqp1cL/4Z6bhPf+BBBh96YLGNuR
         +5Y5q5KBk7lT8oYqDkhLkKTAjofnelXfy1e9YVee0+ONSaPSbQyhJetNNr7ESKRyQ93f
         2qgQ8gFummxVxm4gf27p66VSxPO81DEOrKRqekvLlo8V01x34QJtRCeOHCj2GBMExc2O
         gacisGsQ5WpDQ1B2mKX98AA0raOloVvum7c2m6md3rs8QtMnwU15/mEY26Js0WDPh3QJ
         DYaTl9XxD7b0Rde53Ekt9krbx9quWY6OPeuo/EQSjoxwg4XcR/2YMi7mVZ3mQqOJames
         JIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106799; x=1787711599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgYieFKziqFiGeOaqNKzx6X27Iiom9cGSOGSf1oWB94=;
        b=GWv44js08LxIr4Bim26ul/+fhE6E07NVHE0F6zQWoBoL09WY41m2l4idbw9QAJKGhb
         o0EdgSA963sV5yS+0JsjCL6O+Z72VchZPLjydYwk1vpYjKvCWX3DtTnCnOChGigeg1He
         k40DmaQSHgfsRhhLmk7yqsHDGJLOpVbihvsAco9ar/qTE1gFG3915dkppDV0+TKio8hT
         5ybNi8+Ba5GJwaZQOn7OAx0Rkvoh+741j0ceqRwSDxTzRzGMcxn5Pnce7bZfTvMJ+414
         bcLij+JGWFWWCsehbphoPxTuJD33f4wBA10CgwGMxjzp75iGpFMXD0cuMAGJpVJdIgfn
         Z9zg==
X-Forwarded-Encrypted: i=1; AHgh+RrBzcI4V8AvOrnHEkP0pOaMrnRqc8WkPTDX+aZK4MbOGcO/h6nB6gxD4tfM8SABj7jEpPefcWJqEVwy@vger.kernel.org
X-Gm-Message-State: AOJu0YzYv45REbftGelZpl8L2XylbOY9INKH03siRJXpGEtnI8D21Ug6
	XVccx67sdDvITMM+Kaq6w1Zk5EDbgljziBePkh0tDIQ2F4FOU8i9Y5DbH9PxTy+Zybs=
X-Gm-Gg: AR+sD12dEGnJF97x8kbb0oLp1vr/0L2Wq85fX45di5TKTnDQeuOOfw4k6RXsOf4JzG9
	1tLebo61JODcQYOLBZN1FAYNtGnv2xiqeTFETzKoxyDWXzK9M51ec7/kOYCHAwHEM8NNDH7wxhK
	hrjWK4JztJQFBmFkUwICAn4u7RhZ8pDAIETlWMyTHQwv0yCxG89TxZQ5EdCaF1dRo5gdtC0Au4j
	l5dx3xIxvSi9pcGid2MKCV+wb2O7tvtsunhUirnZVOo5AeKwLYtcycYOhNGOCvc6uDVTpI+FAcb
	0VgIjSCvkqd/P6xGMPSef4o5X3LZKb9xz852ia608DnlST5HHr58KAvUmgYvcFjqwjKlEl166Ff
	CEB+uQhQ6k0083YsaH5tLlOSyUDPdeUb/cqx6PiRvDkqj79/wYOpIzNfWCnZ9bVFqSWRmZQH9dO
	RQkSauBFaP4qGv7j+x/xVzrNwooV/w5bIrFtYtAOnYvmVxtL1IuF5Blqr4qtZVhKmDRPWj
X-Received: by 2002:a17:90b:4488:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-395810f21dbmr2355384a91.16.1787106799073;
        Tue, 18 Aug 2026 19:33:19 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f9aaa12sm786281a91.5.2026.08.18.19.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 19:33:18 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: leitao@debian.org,
	horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v7 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Wed, 19 Aug 2026 11:33:03 +0900
Message-ID: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes a use-after-free of the LLC queue entry in
smc_llc_srv_add_link(), patch 2 bounds the peer's rkey counts, and patch 3
carries the tail of an oversized v2 message in the queue entry so that both
readers are bounded by what arrived. All three are tagged for stable: a
tree that takes 1 and 2 without 3 still deletes rkeys read from whatever an
earlier message left in the shared receive buffer.

Changes since v6:
 - collected Sidraya Jayagond's Reviewed-by on all three patches.
 - removed the extra spaces after sentence-ending punctuation in the
   commit messages, the notes and this letter. No functional change;
   the three trees are identical to v6.

Changes since v5:
 - 1/3: leave through the existing exit label instead of repeating the two
   kfree()s (Breno Leitao). The object code is unchanged.
 - 3/3: add the Fixes: and Cc: stable tags (Simon Horman).
 - 3/3: assert that the two DELETE_RKEY_V2 layouts agree on the offset of
   rkey[], since the parsing code indexes one and the existing assert
   constrains the other.
 - 3/3: limit the copied tail to the largest one either reader can use,
   so the size of the queue entry is not chosen by the peer.
 - 3/3: the comment in smc_wr_init_sge() described the memcpy() this patch
   removes; correct it.

Yehyeong Lee (3):
  net/smc: fix use-after-free of the LLC qentry in
    smc_llc_srv_add_link()
  net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
  net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

---
v6: https://lore.kernel.org/netdev/20260811231902.47089-1-yhlee@isslab.korea.ac.kr/
v5: https://lore.kernel.org/netdev/20260801094208.1937951-1-yhlee@isslab.korea.ac.kr/

 net/smc/smc_llc.c | 122 ++++++++++++++++++++++++++++++++++++----------
 net/smc/smc_wr.c  |   6 +--
 2 files changed, 98 insertions(+), 30 deletions(-)

-- 
2.43.0

