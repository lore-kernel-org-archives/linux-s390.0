Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C25231CA6;
	Mon, 14 Oct 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891051; cv=none; b=FHFM7DZTl7MH/05xr47xC7qprJ/M09Taq9clJ8Vu9Sis9PltI5MlhpqAIZd2ROty1BPjkzg6+I0XP0q20mzE68O2I6G+QkIdOZzNG0nwgYDbr/6ooJDh8DNAWliuhxPNNW2sd/Pvi4s7haenHdJYhb7evJfom6OXsHmIt8fTLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891051; c=relaxed/simple;
	bh=8lVE9q3BzwNZYhrjZXmrp9wCHmWwy3BB8gAiJD9KxB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R3B5esOd3V2r5HJXhLPN6UgzEt7JD/zETAPz3TLr895GSW2tw3MLrg74HLnea4F1a+PA5U+nR94YDXBDyv/hU1hF0a0N3SdUhwYj7sPlbgY8UAfI64Wv67YVqIdr8F8Gh6fQksIh88Gt4NVhkNJ2KfXvqK/msCCADxFaX3CP6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hud6tv1+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hud6tv1+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ceb8bd22fso4802515ad.3;
        Mon, 14 Oct 2024 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728891049; x=1729495849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQznHU9KEGI1S0OTHMiUghNXP8+0ENicZw5DxTDOnC4=;
        b=Hud6tv1+fvMTkVc7oeztxdqpgw5lkp93c56MdW8srphZVDuJBsHtbjlF2tdOxRuKJG
         uIgUeOay2iri1jTu0KhwxWJLe/Z37AbztLGhLs7eJ+qp1COEvDY+UUzgSbGaylkJz7t8
         /XRp8UtHFPlm62Ux9FPT5VMRGcomelo4QQ0QHkle5jKP5jEVmJPGZWmQN9GcBUbeXF9z
         xGRc+2w6fRmH0oDVa9cGv/TlEjoNj+a1+shitnzlh5LLMMUqNpH04OwPGI/Oa06iG0Tr
         8ufTjTJlcPVu47UcOZiA5X+sBfVaUB0SAjZOI0mjp38nHGboVATslIbumf7WW+3JmpJW
         8GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891049; x=1729495849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQznHU9KEGI1S0OTHMiUghNXP8+0ENicZw5DxTDOnC4=;
        b=xGNffFZ8YVuwRppq+ne5eN4s7Wv/KT6VdQ01K3oEKnY8DgUBlw/6MefPtopN8JDK40
         qAvKFp8uGYyac6yXYMSJxl5nTqEQehJFd6sEWiqPeEj1z4UdMEmxTGWKSwgWXaGUzuov
         MCt2Gd9FZOEaRdp5Y3/ONhRVVkckrA06hYC0AxvBPFDkfDg8T1ODR+wJo9iT5ziPA9Hg
         742q3zuz/TgNAerY9gq2YAn/0FHOe3Gvmj3siA7YTu+8b0sWoSNNaelQdfnDUHKBhwAf
         BM69XNNfn2/Ruz5INMteppYOYUosm6PznGHY6DczywXjIyWfyEGo3CXEUi5eWoSJ1IKb
         fHnA==
X-Forwarded-Encrypted: i=1; AJvYcCUozhgtv1h2Yh0LS22uSuyX1ye2PlU1GLsIIi7535lEoMtguuHDMkHaRCtAeg9ruxtTZjzvEq8i4RPpobM=@vger.kernel.org, AJvYcCVa/uzd5eSQfjoS5zYjrDL5IKbkopj6JxapYPSFDEFELAXI0qTS5mXpO31xdc4RmVz1WNKDiedb@vger.kernel.org, AJvYcCXty+QaALktNOyb8RPr2L8N5uUYBaS7QkGtfgWFot6zr2xHvoRmNzA6rRdaNvDxipoCn2rtBg5WJsg1Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQ7rkCvlC10hRYHsv3AhPFmHQ5PHL+AMyXZmg39u1TQB6sLAo
	JwO8A/61HkE5eh7HFEJns4zECMOUGpZhT8oKMXkZ0+BrULptgNLY85uS/q+V
X-Google-Smtp-Source: AGHT+IFofjd38bjVTbJjZXr6L74hkgc5RNmHbkk0JLSFqycvPcjo/02+cGqnge2r50Vgpjt27hqWAQ==
X-Received: by 2002:a17:902:c952:b0:20b:8e18:a396 with SMTP id d9443c01a7336-20cbb1835b6mr129147005ad.9.1728891049301;
        Mon, 14 Oct 2024 00:30:49 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c8c213258sm59719315ad.202.2024.10.14.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:30:48 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: danielyangkang@gmail.com
Subject: [PATCH v3 0/2] resolve gtp possible deadlock warning
Date: Mon, 14 Oct 2024 00:30:36 -0700
Message-Id: <20241014073038.27215-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes deadlock described in this bug:
https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd.
Specific crash report here:
https://syzkaller.appspot.com/text?tag=CrashReport&x=14670e07980000.

This bug is a false positive lockdep warning since gtp and smc use
completely different socket protocols.

Lockdep thinks that lock_sock() in smc will deadlock with gtp's
lock_sock() acquisition.

Adding lockdep annotations on smc socket creation prevents these false
positives.

Daniel Yang (2):
  Patch from D. Wythe <alibuda@linux.alibaba.com>
  Move lockdep annotation to separate function for readability.

 net/smc/smc_inet.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.39.2

