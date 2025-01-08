Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042531F0E2F
	for <linux-s390@vger.kernel.org>; Wed,  8 Jan 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736328373; cv=none; b=ow8yjLhvb6JJgyHE+op7QmmDSr+eB1qIGBRES8g9X12XiIbP/mejbJ0pV92SnUzfDkFJAJH1+ya50ijUMOVlMNigoXIajiA5F0efon4BHZ+69c75b9FgtDsug8mIIqa1hxBocBR/1+r1DxHZcwWB7FQA6/ZbjTc53FMspRU/p9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736328373; c=relaxed/simple;
	bh=Al+JIkYrhwgUrke0Av47fm6GwPZPZQq1mOw0udRwbsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=chsupbfgNnFQhe/nWbHbF6hVWwe39FrUSogXaCjVnZ1y2phWRhR61+7pLqu9MlvlP3+5oybnimHh9eQWucfOn49viYWRDuGP3F/50JYczkGDQJ4Ua3xCVTXJUzuQjbDiMGYWUZNR/VwJpn8/UYp1jLCJEh/FI08Vcs2YMupgqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bg/wdFN2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bg/wdFN2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43634b570c1so118080115e9.0
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2025 01:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736328370; x=1736933170; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llw2mMGwxOVC/4Cd8CMxpSQ2joGdUS5FVjkkuZLdTQ4=;
        b=bg/wdFN2c6j6Noxoyp1P+OjM5+U+Sy1i4eeuts/VB8CY0YuYkU0oZ/BXwEMS8EQ1kM
         NAVS4KXdJQ9cMSbzVaeoKRuYspxUUs1Uks7yMOjEMV+RwGvydat1SIjbaodbVFB+7wWi
         +RUWkqCFhY8U+dMcvvFYBON3sjRqMHCBxalOkIy8fOvRpWm9uL7qSsCQCbkiHhxim242
         ZWicFyeTGt9OvxzaF//pQQMFutu12S9J6iTrSKbKdEEUQVtH+4xO04W5+N+lp2sqticJ
         cjgWgDQCwGSJ6leUVtIK9HJNoi+jJ5PfiQUXM8CrcG/gPraOFUcjqzuLzoWlVw+nbTjk
         vSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736328370; x=1736933170;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llw2mMGwxOVC/4Cd8CMxpSQ2joGdUS5FVjkkuZLdTQ4=;
        b=X5Mu+u3lxvW0tDr/AywQFo5szJB8oqcic2RSDPyCVK632UXyw78JAHOz0deu9+Ghhl
         b5mZqr77U8INjfiU+TNQHSEaVReIdqN77hTBFYqmZ4UnSMNQlrF9e/XgZ/p0gtjFrGPi
         h522YcAg8siG9G+303fy0g/XZ2EGxlPKWUWLXShY5NFNZw0w89tLxd2kLzsJqibSUGu3
         5nwj5zYjt8dWryCbTgoaulORbt7j8LxN4qiCshgOd3SQSlZNySozn5y0PsoD4ZlCwVW7
         Adc4QhQLlUproJctIBFkaaAyDm06PbPiAU+qyjCVyl5rHDVXhiQhSgBxOL9OJvhvHSSo
         k/7w==
X-Forwarded-Encrypted: i=1; AJvYcCWF13k5Ln9Ym6LecLugBb/tWUjcTlCjVxDR3RCfV/7+nyRFPwwTCBo4qaW85afUk5InKTMh96IbgZ+a@vger.kernel.org
X-Gm-Message-State: AOJu0YzUF1QI5rxKsj4FZ31or94sndWHasMYS0nwivIFl7OfS0CAdwkN
	CpQT5UCPXBKIym4hiD8PcuhC5raZWi6ep6coMdqYpA5G0YsqFIKe0Q2uRphkK+8=
X-Gm-Gg: ASbGncuE25wO/aYJeQaNbW+ZR90wCoGJA8QK6X7XVemc8gopL+fIhFiNVRWxXYblSrs
	V2xUHJ0R6Qytm69pUSqejOfUviA2lprgjH0on8pk9MGvb4izlSo0s7BLT48s1FSZE+d/0pRauPe
	GJcx5tOExtTbc/VZf6G2SQLEHRqgJDvqGGY8Hhy8B+LpSR02i/SivfVC5djVmfHwpLXbSXUNuSK
	I8MTUIrkMmbNhtcwvS6UFk66SvV5pUdCA6imdmoKJMVoLxh7BZLyVMgjmLSkg==
X-Google-Smtp-Source: AGHT+IHYOyqY4pHUEmLh5C55hIoH02x8AafZyW/gRN9q2tRxk2NxlqiAWNdVuavxbFooX0Vi7IBNWQ==
X-Received: by 2002:a05:600c:4f47:b0:434:e8cf:6390 with SMTP id 5b1f17b1804b1-436e2684dfcmr13959835e9.6.1736328370469;
        Wed, 08 Jan 2025 01:26:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm53257556f8f.45.2025.01.08.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:26:10 -0800 (PST)
Date: Wed, 8 Jan 2025 12:26:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/smc: delete pointless divide by one
Message-ID: <ee1a790b-f874-4512-b3ae-9c45f99dc640@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Here "buf" is a void pointer so sizeof(*buf) is one.  Doing a divide
by one makes the code less readable.  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/smc/smc_core.c | 2 +-
 net/smc/smc_rx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ccf57b7fe602..ac07b963aede 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2155,7 +2155,7 @@ static int smcr_buf_map_link(struct smc_buf_desc *buf_desc, bool is_rmb,
 		for_each_sg(buf_desc->sgt[lnk->link_idx].sgl, sg, nents, i) {
 			size = min_t(int, PAGE_SIZE - offset, buf_size);
 			sg_set_page(sg, vmalloc_to_page(buf), size, offset);
-			buf += size / sizeof(*buf);
+			buf += size;
 			buf_size -= size;
 			offset = 0;
 		}
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index f0cbe77a80b4..e0ff6ed83057 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -197,7 +197,7 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 			partial[i].offset = offset;
 			partial[i].len = size;
 			partial[i].private = (unsigned long)priv[i];
-			buf += size / sizeof(*buf);
+			buf += size;
 			left -= size;
 			offset = 0;
 		}
-- 
2.45.2

