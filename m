Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085603;
	b=vtVJrX/rj5WJK89IPMAfBXzI+KEZ9OO6+Y9tE7+gjSqiqWkSOBuvwc6vynYfioaaQcF+
	 5+teiz0jvg1oUHop+/h7XBytLESebi/H+44vlw/b09D//OgUDgJLkr6Jb3p9VM8G4/k7b
	 iR5xPwzT8pB/tcSF5s4uiOQkMce5vnXt4kj/3DBWEFx2hSiV3xOs8zypv7JV9hMFuV7Bg
	 9iHvVsIdiyF0HAky4WuPhKkZnOMX/+i0msjbssXzxPCvR6YlY31cxPplvuoxlA48Rxleo
	 4ySJ/wE5WvufKCfSRT3Il0rh+9++ljXHZnJdRT9TIjtoconiTxqOiyFPRSqgk8RkO9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u82m5XYfOkixN+Gu4sy3x8jwpD0ueQ6BxZtFc7iLOis=;
	b=I/bJDt8Pl9o3h/3S9ZPnfxTl8zofgxw6c81uew18Y3SHP7nj1Imr16bwU52Woj/JLpoB
	 nUcn53VVDh/FnqEwfBr8MPOe8CjOhjH89I6oHRjSExq2NehhTiPxo0QZ00QsCtuDc+CMI
	 4+BBqS8O2Re6tJO8NaU/Dnr+AL2f0vzms02jNgk08DQbOZbJ0qKRqICrSPcfeZHH92FOT
	 kfLntw8VoVoiYwxsNVibpHS3ZZvyWuPEsdCwO7FfngYSERtt9Gca53b7jUm7LAUo3/3D6
	 XUL2ix2tSrTnme3cFyJYFm4oBRDZBp50p+6htPjVOCZf9Iv/fHXQbcqpTBHBOleTC+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iQ6rUIIV;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416A606A326
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 10:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1416A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iQ6rUIIV
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1312372a91.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795085602; x=1795690402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u82m5XYfOkixN+Gu4sy3x8jwpD0ueQ6BxZtFc7iLOis=;
        b=iQ6rUIIV7M0UsUNIRA6NKN+GN+fSa8/ME/likVRUE5Bdb5g7Llp4kUXaNoFBFNOhBu
         F4l18R77EQ4LI3ORH9xbQFWnh3o6HuJKmiN0ciN6PEOTrv1IRf18GHrX2bRj/lKoek7t
         hmNB/zpCbM49xuUBktNQrmcoJ5zqomNzHzsqXTLF2iBDCAP6nsSVdeGU7R0jmF2GSPhS
         dA9NJl+y+nu6Ad8KkMo+5eCE9mSYpFxcvJTBEnQ55zbs6Y9UuJrshRrWTCo1cQhOwY1E
         z5WVZg6ZJLHx7WbdXSp0e5YnIwhwyAwlkQO8deuDe0o32wdEcvaysTjliRP98bQgfJOf
         4VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085602; x=1795690402;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u82m5XYfOkixN+Gu4sy3x8jwpD0ueQ6BxZtFc7iLOis=;
        b=VxhazJdvnq7FeqAccV/9UNkQxkUMLFCcbeRzAAF+ts+ZJpLuLnUGeZ2HKaKQZ2uwFi
         x6AxHELQUvTcX1UKPrKyES/co6TwhhH3wdZkQxK8dBvT+iaqcg9Uat9aK5p1FYepwXrK
         iw/Cu0GUarw1XgHMuMJlMFD1jkL9GmlPnxFKKMD4TDElrHLuU/RZ7VtyvH/Rf+xsZOcJ
         Ch5ry8nUG9e7MkP+URZBHWkKvTsRYEh4Av/bZ2dHdbVMTXP/w0+thx9ZzrBdycB1Ur6s
         q53JdHepBdl/QmMx5j6tVpDTgbMQIXFOksDNDfltjSeqcgBbwhMsYOU/s9+ehl1CIM7Z
         rBZA==
X-Forwarded-Encrypted: i=1; AL+hErGvNoEM/qlSCft+g46tT1sWK9A9PmUEeh3qHCX80oQgX2BKRIF4Aueto2U4wplk2cb/S/N5c/Za+zM4@vger.kernel.org
X-Gm-Message-State: APuU4Z9tH/EQ7wyN2haQa8s1rZhFmg271OBvllPkYX8648vo3+BvwnyI
	oFFUj98sr6xP4iMpU4pjrjyuxyTY2rYbXAqQCjHd4FkdfdV6KXNfwk+2WO5+5DRkhDE=
X-Gm-Gg: AZFdTZcKOtixsed+Myu1LeoRBXIsS9LOKEZ1K+68smkrAefHpQoGGOB42LZdVsXZguH
	0BqyO9FIOyQICKkcrk67Xt4Sn0O5lFo9nFA9YtmgUbNXJwpMSeE6a9gS+z5HR4qB/Wzek4dHUj/
	WjJuLrqD5G0nhCeP0GmiaSGnIMX/HIyxPZH2txA9d66f5xJ9yu4+THcT/21ukYr1D3+tLmDDwnd
	xdi6CJfiIDsB1fuEfucvIWSEppIRld0CjVabooMq8yOzNY1uh41Y31Egsopr1RiVtXh2WzazfjD
	R7muokpp8qrOtxka9Jm+a4WPVlTE4ffUOSC7GNXCQps6FHML8TYZbNDDxwcdnZRU7/zR3RBSC3d
	uhN5Auth7DYts5xbUBo67CHVsnildRA8KjuM906CdjTwZ3wxwpEWdEE0KGgaMn5K8APLYsQAffa
	Y8pL0Mh10sVpoXsEB6geLsllC5sikLBE9y5zQBHDJ0LsAbep54fgpagmjna2PfzOWYHXaBmySlV
	3eskPVT9grPKyU0XBIUlHqTl2bWNhtqkVoP2o1CXgwLeaTEjLThAp8V6r67Q7xOk5xtzGsiX7zO
	XWefS7eauWemy5/HVCADDhGiS5BQ+P7TIUZ2yXxJWz5ba8nO/2BECqPpcqv4j6ZuL+wfGx8Ji3q
	au9jxdNppW6qJ7TFBBCiRPVbQctVrldVuNRYBKA==
X-Received: by 2002:a17:90b:4fc6:b0:3ac:7e3a:1033 with SMTP id 98e67ed59e1d1-3b3d07d9ff7mr5928287a91.59.1795085602395;
        Thu, 19 Nov 2026 02:53:22 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:e78e:f7f0:2120:34e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm2246604a91.10.2026.11.19.02.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:53:21 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 2/3] net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
Date: Thu, 19 Nov 2026 19:53:08 +0900
Message-ID: <20261119105308.2567241-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820023347.9D5461F00A3D@smtp.kernel.org>
References: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr> <20260819023306.644849-3-yhlee@isslab.korea.ac.kr> <20260820023347.9D5461F00A3D@smtp.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Three of the points above are about code this series did not add.  Where
they stand on current mainline:

- The memcpy() into lgr->wr_rx_buf_v2 is gone.  3/3 made
  smc_llc_rmt_delete_rkey() read the queue entry instead, and nothing on
  the CPU writes to that buffer any more.

- The v2 spillover buffer is still shared by every receive WR of the
  link group.  3/3 narrowed the window to the copy in
  smc_llc_rx_handler(), but if two LLC messages with extensions arrive
  before the receive tasklet runs, the first one's tail can already be
  overwritten by the second when it is copied.  The result is the wrong
  rkeys being processed for the same peer; the copy stays inside the
  8 KiB buffer.  Closing it needs a spillover buffer per WR or per link,
  which gives back the memory 27ef6a9981fe saved, so I am leaving that
  decision to you.

- smc_rtoken_delete() runs without rmbs_lock, and so do smc_rtoken_add()
  and smc_rtoken_set2() in smc_llc_rmt_conf_rkey() and smc_rtoken_add()
  on the CLC path; only the three smc_rtoken_set() callers take it.  As
  far as I can tell from smc_llc_flow_start(), a remote DELETE_RKEY flow
  is not held back by a local ADD_LINK flow, so it can clear an rtoken
  slot while smc_llc_save_add_link_rkeys() is filling that table.  The
  rtokens are a fixed array, so this ends in a lost or mismatched rkey
  rather than a memory error.  Taking the lock in the LLC event path is
  not a one-line change either: smc_llc_cli_rkey_exchange() and
  smc_llc_srv_rkey_exchange() hold it for writing across smc_llc_wait().

Best regards,
Yehyeong Lee
