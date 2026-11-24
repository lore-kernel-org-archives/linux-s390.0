Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505349;
	b=4oXblfKHQ3lccxfO/zYb+B7W4bTxPQ2AdCrxkfxyw0GXcvtnziHgr7DO+pJiiE7CM83e
	 OJPW+IgG/dTkdK4/ZZb57ay86i9V5Ckvib5AIwZP70afbRu8txEI5QHQaocHJVuroG38u
	 ApOjV0y+V1wbBRq3EAhpkYpdnfDdiii6riL7kqiCric7iDD0XmPtAF6ZwTxwoa0Aekn2E
	 FLpDSazHs/oDdHd4a44RxUolBJnQEjMi7GetTFEc/Xwz8y4kLL6zCsBrDsgX/1yeQ9NKg
	 FhMA++9wzCje1/WrG7PeuzbkDuHE4fzGh8ttSgIWQAAneIVDvfmwa63+RFHjihE5IJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=i5K60fmvwEmavzV2HbQ6y0ufvklNifD+2bmJJtU7uFY=;
	b=b7eiWpNhD8i/R53zRNZDS847bbvaE2RiW93T0JeOZt0oWbQZdNObvRMHDUeVGtohY+IP
	 lhSvB2Ntkb8u2f0o4vGmyXRvBeILUIqBi7FYojFiN2l+trUlIn36r/BCiF3A86QmhnUwj
	 fPh+WBSqXn0iCyA+oySq9mALuwqLl91x2NJnvIGgDxvZ6Ar23s/yq7vfs7DND6K+3vKa8
	 n5dYcPgvtN7lRJw6cDz7VYsJB9/P5RDUPRLAFY84gjFCCb1eLlStZ1LrXwY0w106xYkgC
	 lhkXCkaLltqubf3tk9NLWEnKbiFNZpKfE3vUMVAXY5BpF4Um8/PfIeD5CstnPa8yBKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IplZS4yt;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22303606A326
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 07:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22303606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IplZS4yt
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so3537683a12.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 23:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795505348; x=1796110148; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5K60fmvwEmavzV2HbQ6y0ufvklNifD+2bmJJtU7uFY=;
        b=IplZS4yt7iFWiBqF1sGzXXNr28tAyTBxelnjRoW/R38BsaGGufHVy2e+F1z78g1RLO
         SE3BbI6T10JIDGX4rET1dFhR+52jdiJiYlG8cdqGx2jDUGpesVM5XyqZKQ5MgeSiACpV
         vc2MeTpHte4eAE8DJxKn9bvqUOFpNfMb9VqvsNC/iJ3NYFFIXS0BsJyaXaijg7f8fqYB
         mNsWDyUj/66KHjAJ/SOW4uLZVULMi73UQ8xEm9UR4Oj19QjPkpo0BnJ8npx3OrqoqK/h
         mIQ9vagSqrPiY2tkm+ax321dapyNyZ09Ifboz2Sfqv7x+qPy8PvcE8EafAs8AFkXbr0r
         WmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505348; x=1796110148;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5K60fmvwEmavzV2HbQ6y0ufvklNifD+2bmJJtU7uFY=;
        b=c+30YVK0Ieg4TcFHZk1BFh0ec7gatzlkYArKr1kZCiP31tbn+ZetO2Mlx8DMOZfEC+
         hHbBAcqb6gwmfelME65qdPdwfDqq3oLhhkE/SakAvv5qNaBzDxac80XUVwNOQmlQ14O4
         /iNcQLbFYGAvPHMQsL7eg6asSzbM7mS37E18JZutBKPdL4tvBAdzHZGcFjGi7AfF4g0V
         5xHW6cqSDbG35zVpCY21x7iedEp65T60aTTLfqtgWJsKxudroc3k+SUS1/fjwvFpRbr/
         Geu6uLVYGLKKpuRw4PMi8ISGOiGEhHApwMgwnGdNtJA7cgsSRS7w+aSLiRN4vqCwTjS3
         b8ew==
X-Forwarded-Encrypted: i=1; AL+hErHIlweNK4VKxQVuiYpR8NXiRzyR7j5OURS8C+cWQ6WsqsnwZxIaUqv6Nv5GJlGD84yL0F+wy2QmsTjo@vger.kernel.org
X-Gm-Message-State: APuU4Z8/fs2HelxqaDmOel773B0VuEjXKxQExVe+ISUKhIsVpgpShQll
	kh9j5YXFjELTHdZ8qdMj6hfaROfgmsW+8WJw7AKZuiZbhFoRBiWVnyb+Zov78m/xVk0X3ZLE
X-Gm-Gg: AZFdTZf4FntkAf+p312nrif1MfBA2JD5XP7Dl1twNWceqqc4qhjos7XTR2FCBrbKmma
	sTfjwW9ukNyUGK2ezgnFL1gU0PtkY/rmSqmnKoXZJo6cSHWn6c4fdjCAwWuXxZGdWryCa+4F2KC
	2WyLK0DcEgSp7vW3D3nBj2wBQ3JmBLd4amNw+k2DjCi6Cwbk3SwLcfWYkdAPdAJNOMyhG3kLrLm
	wLGJQOTb1Ee8U7s2saQ04i5DY1jm/JOHyZld+jMGxdMjzwFSz/9RZVzlw5R6qYaaGK2/9FDS3Ec
	eT09vrYCQlZxXo3NIMcuptp6rjTku04agg7BEpiv2cnz9Am1iwtZXl9+gvN/ufo/8XCCyTaxkYY
	s23i/9yyQY1kLFhO6nqqw8rluzZc9S65qCa7US6PXuu7f7skav3qDRrwBfUSwIh721omDwA57YK
	XzjNjWhuwf5z6B3H57xZWELYBcpxytf7BwkKutfIZdKhb8r6t1VDzHFuL4wsN0mBbmSuNjq4oVp
	BNrB5EzNqG8yt05oICwhMOIldO+cGPDyZcNZTFrp/AGu+Jc0SVMyyLTqeZi5RW1W9jLgU+wEoVW
	iYUQkWHwE4SDNnCuGB00JOfl0gWy5hHKQHIMg2XqdGveYHId2wEX+7JIegh7MiZdENIo4EniQEu
	1kEXZeW8QjFmrZ/J4evfLKisM+UTjpPk8x6F3
X-Received: by 2002:a05:6a21:4cc7:b0:3dd:85aa:4524 with SMTP id adf61e73a8af0-4014b56547dmr13760885637.31.1795505348209;
        Mon, 23 Nov 2026 23:29:08 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfe9bb9sm6296177a12.12.2026.11.23.23.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:29:07 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
 sidraya@linux.ibm.com, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net] net/smc: serialize clcsock release against CDC receive path
Date: Tue, 24 Nov 2026 15:29:02 +0800
Message-ID: <179550534286.21006.10155127387498208795@gmail.com>
In-Reply-To: <awURtCvesMgSBQY2@linux.alibaba.com>
References:
 <CA+OT+OPkNsk2QHczVmb6KVJ+z_1tpH9DXm8JmACc5E6x-YFwPA@mail.gmail.com>
 <awURtCvesMgSBQY2@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Dust,

Apologies for the trouble - our v1 mail had the 95-char hunk header on
smc_cdc_msg_recv() line-wrapped by the Gmail HTTP gateway.

Note that this clcsock release vs CDC receive race is an independent
issue from Bryam Vargas's CDC cursor bounds series, and I have verified
that it applies cleanly with zero conflicts both directly on net/main
(4392bb809812) and on top of his 6-patch v9 series.

I am sending a clean [PATCH net v2] via direct SMTP right away.

Best regards,
Qican Ma
