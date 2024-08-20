Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5418E34B;
	Tue, 20 Aug 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150075; cv=none; b=WtJseDE/cLoofj/f7PCrWVqU9WBqdzs3+3IywZH3p+6JlTbSqjIsVQsR1rA20Wm8j+f9fWv1s/vTH682io8Ta0aVHaPHKtEFRR4nkvNvC1R1PrEg4g0PS8p9YLqso2YtKFZO8lsHoMJno95kCm1Pivvn4BAKZqQ8k46h7vuEMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150075; c=relaxed/simple;
	bh=2vQ7xgz31tdsyYufAygdLLr+hpkpWW4htgArJk0EyzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyVUjd6FyEc3/U1rtl1VmXA7qZ31nCvkWGEmJJXPHoufLQWvmzzkzbSXl+Egs5n/0tfIpNWEGV+VlCHQiCPwzrCdvK4iliJZ3JGIIJZpfyX+99CKW48+TP+8qT9DK3yIVJGXqpkwjqkeFH79bUQM0Ups95F94u7VHeesu4l1D0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNIp/3gq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNIp/3gq"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc611a0f8cso40943625ad.2;
        Tue, 20 Aug 2024 03:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724150073; x=1724754873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYLnq2zDE0SQRgr4NTaRjzGrrtpAL6dNIJ7/StYnv8Y=;
        b=jNIp/3gqNYmZHETRjFDuu1WoJUAzlPejDvV2/aIle4Ugm24jqq6TEO+ikzzRVqNchf
         8FoAU+nCP0ZCfZgwaWtb7kr48evBRYyOXAGieFu7IrLK4tS+d4vBnN6d6i/oGlBhEbdJ
         KN5ym/rI1JRjXtbnNsB9GLht8PPYEKsP2ebLwVamai11bNZj3ENG2E7Wz850CM/qg2sx
         MJJe7xVaQ2ceBfWzcasovIg00JBBALU7pFcWwC4Dz/xjQq1byTLwuZ3S2W11xWhz2Crz
         Q5rfNcplBB4i2mVLluysqumjOIVRJQoKgI41NBRjwHSPs2VW9yfpkKwM0Uwpet5/zXUa
         QpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724150073; x=1724754873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYLnq2zDE0SQRgr4NTaRjzGrrtpAL6dNIJ7/StYnv8Y=;
        b=X08idkcchaZwO7KBd9nysonG7Xfo4B/6cGZy0TPm5bQJ69pwN3B2hE5wIJHSF6h/Mn
         Ji1IbOve128851Fvki/x5Bk5O9fFTZluTtZupy8UaO0hF6IY1KKf6NtGM1WnipnpCPip
         MSZ5FhaBkm6hdleFfTYlxjKEAwkczyLfTluzdcbfBgajID0par542hS5Y3TayO8qJ40Q
         6JGJV7Q8XGRkJS6Ue6GwlK7EIXJfpWREgG3h3ghF6WCx1Kx5saEtUNGdwK6fP+jCUHeS
         J7bvPnaGvIreN7szGU5/PSIfa897m/nPL4ghOYA6CAv5pBuu7C2p0TsJ6X8jxYU15cwR
         zoFg==
X-Forwarded-Encrypted: i=1; AJvYcCVB2cM6Aw44Bi6v4P1KHsbdbp8nqls5RGh/UBLjCz00y1B+NmDy9+ixdr6wAslT0XwohNR6xu8WvHZAP/U=@vger.kernel.org, AJvYcCW95TB9QQuwBefsGxrdIbQhsza4NrX25GuoBg6pYzwnSK+D444HqUDox1kVqOZ8LRkMIDQQ+MBfHLxl0g==@vger.kernel.org, AJvYcCX0/6KKZGC7g15KBpQ8kcRVmFn3UtymdzONCgfQ20bT7zdDMFIT8qTzXXcghecOBB5jgFNtWhYr@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDkejDnS54Fg4wJBMB1mj/vkITHtbIb5ffijzZqWOaWuNyFPv
	wz8BPV4IFCJ30jIod1kmVnK5VULXKslAngZ4SXQryeCJ/caB9oE4
X-Google-Smtp-Source: AGHT+IGJig1neYGceqF6j95MwaETMQHaposqjvhWHU+H3jMdgmHSiWGAimrcsFATSH71KEU4UDUarQ==
X-Received: by 2002:a17:902:f545:b0:202:4666:f023 with SMTP id d9443c01a7336-2024666f51emr52014045ad.57.1724150073337;
        Tue, 20 Aug 2024 03:34:33 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20219baeb13sm47696505ad.224.2024.08.20.03.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:34:33 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: aha310510@gmail.com
Cc: alibuda@linux.alibaba.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tonylu@linux.alibaba.com,
	ubraun@linux.vnet.ibm.com,
	utz.bacher@de.ibm.com,
	wenjia@linux.ibm.com,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH net,v5,2/2] net/smc: modify smc_sock structure
Date: Tue, 20 Aug 2024 19:34:25 +0900
Message-Id: <20240820103425.338094-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815043904.38959-1-aha310510@gmail.com>
References: <20240815043904.38959-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeongjun Park wrote:
> Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
> 
> To solve this, we need to modify the smc_sock structure.
> 
> Fixes: ac7138746e14 ("smc: establish new socket family")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Reported-by: syzkaller <syzkaller@googlegroups.com>
