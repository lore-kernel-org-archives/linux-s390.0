Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C837AA77
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577349; cv=none; b=fFYadFXh2JHBOijYokLUJZSkdKHBdRC/BP2m6O7zZ9Bsdu7mFhNC1xr4vCWwjxgSnjDrxkVt+XLkjR9iLG72yruoN+uoYOeKwIyrcWxbQO5qId7o/Ft2zLTMkSVVBVl24gw3UtBkpNdhUMzvNGyWUebfoQCwuhoOqYJ/N75L9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577349; c=relaxed/simple;
	bh=SAw0Kb+9oqAN1gzi6bUEMvt+RoU0VdIvRLyfU7ZQZas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5faQt1BnVJj9e7fHHwNe1bPt5yuMITUYlUa7YYbrXga2Dqjf297E1LY1f9g/WyRwOqFctNNdAxKynZjiwcCvNlmO1XbrKIn6QhJIc8q5zz4BB77HyE8S3wlPHyTBMa6xzsL4rhSHW1gVRKsw0DSEu9OqzmtXzAKSTjqt/xKH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=rYutlYtC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="rYutlYtC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce7d2adef4so29743915ad.3
        for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785577348; x=1786182148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYPNkkV+81Yt6KAtVQL4iqIfkVKBR+qmznODVw2SiBE=;
        b=rYutlYtC2ruhHNV6BQVR1DUVQQHLgoAa5v2wgWDvQKMG4J2LfLBL9kFgS5IVvoonru
         8k+iJ3RZ/ccNJQiiMphwJPdMnjfupQp3PnpAui9EmID3La7xcMe0kCYqd0v20Tlwxey4
         0KUNxKLptWABR93v1XJomADTi7jO/HAAh0Qgwu8V+6jTnUanKeYr+xiutO6ORW9rx4wO
         lq4TPzPB2l6xjF5eh8cV/e5BMH47uTU8tFp/BhqvvWZQ8SrMvDA3aiiZAt+Mh5Whh0Vr
         uzkOW01nXfCRvQa+fP0oFkXwIAdDZ6fAXVkiC8n8JYbX/luVqFtagI4/s8D/SAf7cbSV
         r+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785577348; x=1786182148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYPNkkV+81Yt6KAtVQL4iqIfkVKBR+qmznODVw2SiBE=;
        b=TobX4RUDJnL0iuM0Nuqj7tLz8aopuQCjbHpPj5SwjQigS+AasdVeQtXdByML3gg5hw
         SU6kyoPA1lvB7y/hxrj92tjGRHCFtUpa3j9aVHhGUx52fQUGXH9uPhOl6rb2L7KHHyQX
         JVXhf2GVVzDX/2SAD3Q2e/x1aHeejXLf/wOTj4c8eD9Ga5S2DAWNXZuLk/WGzyIlPWZR
         0dCX6kJQTHi5aHxEKzR2sVaDsP9xi+Q8CJoR2+0Z8NJRdp1HHmKhlH2NiL5Jns/SmovF
         btE3dP2oKxHSDfi5dZs+OYILdUAbh2pWbfIfx77YAuVJSJv0A9eMPet9q3GqyRtaljAl
         r6Uw==
X-Forwarded-Encrypted: i=1; AHgh+RrzUKbnCHNQzJekyepBu0Tp9zNUCXLfXSSMSm0z8REPnKHE7vTjfSeIN/9jpNgGG5Mngz3+U2XU/tf8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8a6ntjPgGr/zo1iBBJO0CN0K4DIhhufv0GO/8omfyQmcU+Y+
	EptktbM7BYjv6m9udpwJW1jwTEXqUDYZdDklMXzQfYO0n+CZUPXRHmd11DxRRxJUk24=
X-Gm-Gg: AR+sD12ePv0bW4Ox6eCuWVlVoYK9gAoBLgK3KjI8D7py7ZRYz2UFhQLvZiu9BIctBGe
	fkkNYYTncWH7HIduvNm4mfAkv9SgmtuKEIb1J75Ef7luIjwJm8Rs1bReWM3bX3szlLlYkR9WnrQ
	tAzQUQO47pNV35uu1i+fOpfmc+3IbDmMDyYO2B1rpVelmXDfo/Rov0BPRe3zfbaxRXMDHsW4FvO
	BsW0ZSBi5V1IPBv08hEOAIWmeOOKrSfUhON4GF3zhBT5iKwx37fmyVrQ7STPrw241EvFA99dRVj
	F5oFO1sbiqiHWibpTKLxW8OUhoyLJdM4B0KLl+xH7cHjOkjs8QKK8JSCzWLh3aMjOVIN5KYzZRY
	iNm2teE6XVfuo6Ym+eZMP4r7lnzeWwHRWpC4XCc98UyjKAwbkThOwNYI7bhG+2OGCens5g6SQ/9
	q6Ty/Y7NYq9twWOpDf6tbe0+ljxf4Aho6Y6TzFLMjcaL7XZ1oqHCsHig5v4flU5NE1r3Z5L/u8L
	qJkzj9mxnw=
X-Received: by 2002:a17:902:d2cf:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d0521a5657mr32621275ad.8.1785577347676;
        Sat, 01 Aug 2026 02:42:27 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb486sm16006465ad.53.2026.08.01.02.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:42:27 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
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
Subject: [PATCH net v5 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Sat,  1 Aug 2026 18:42:05 +0900
Message-ID: <20260801094208.1937951-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split of the single v3 patch, in the order Jakub asked for:

  1/3 frees the LLC queue entry in smc_llc_srv_add_link() only after the
      last use of the pointer into it.
  2/3 bounds the peer-declared rkey counts in smc_llc_save_add_link_rkeys()
      and smc_llc_rmt_delete_rkey() by the buffer they read from.
  3/3 copies an oversized SMC-Rv2 LLC message into the queue entry and
      declares the rkeys that fit inline, so both consumers stop
      reconstructing the layout themselves.

1/3 and 2/3 are tagged for stable.  3/3 is not: it does not fix a crash on
its own, and it changes a structure layout and a static function signature.

v5 touches 2/3 only, and only its comment and changelog: they gave
the wrong reason for skipping the extension.  No functional change.


---
v4: https://lore.kernel.org/all/20260731070509.1818665-1-yhlee@isslab.korea.ac.kr/
v3: https://lore.kernel.org/all/20260727095833.1079618-1-yhlee@isslab.korea.ac.kr/

Yehyeong Lee (3):
  net/smc: fix use-after-free of the LLC qentry in
    smc_llc_srv_add_link()
  net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
  net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

 net/smc/smc_llc.c | 101 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 25 deletions(-)

-- 
2.43.0

