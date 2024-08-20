Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D518CC1F;
	Tue, 20 Aug 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149922; cv=none; b=pqAtirZoouJXMiNRGKVEXTvThZSQU1qKr1kI1PpASTsw8blgI/9C/Vqk8nO9JCks6TF6qQmv2MSTj5+/pRJGb4lzfSpKW2rYA+z8W7hHBeDnZhs8GcVHdk77z//ueHZC5a4OgLrPySHmu3CwAh8yCNBRnsHyzw30fCE69E6P6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149922; c=relaxed/simple;
	bh=duvv9iXl6bCaWXnoXdJU+2UgdcthjSXBUQp9V4nE5P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2/Q4pQiobVwExhlInqO7Fe/YziwYgifrGEcVUiBOA/R+M/bzYQkQl+R5vKwQ0MpWO+gGJMCl9Vwkazh+ea3XEO9pFzOzaKXQpCmDrcryvjrox4TTj1HO+he+bvsDsrK6EizISZMxhQMVQJBIYWs87h4ALc+/DKgYOW2HQ0Rpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMny8QmW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMny8QmW"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso4361208b3a.0;
        Tue, 20 Aug 2024 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149921; x=1724754721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LYknRxmxZhwkaY/3EByoVTqMfeWJl1Dz7XyYSW73hU=;
        b=WMny8QmWbv2a6nuoGZxbdTFa5VS1BXCZ7gXkiBIeGDA1aRAIBMaUL5aEgoaudid7jx
         XvbD+Wig8J1Z3chRosyBV/UtIACgXh6sUYZyEmtu2k9ArrPwdfmOGHkJArG+Oo+S9+i9
         IEQu8OqHMLiMcMQ10DNqOvO51g6aoXmmrW7EVjzEXWToxQWmNJP5uDxX/YY4UuVMcq3P
         3+2EUovcnqTsc1MQWTneOsI7H4n4R9QuvL+lc/pEr6BVQZN2IfO/pmC1TGa7/0jIaAzf
         aXzuJysjuLvlrFRE6tA0SONQERORLPWxpHhOjXG+ZTI/RxYce2w4HcDygRvvnpW8NE/D
         ZfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149921; x=1724754721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LYknRxmxZhwkaY/3EByoVTqMfeWJl1Dz7XyYSW73hU=;
        b=ITpgdIOF/CghxWZxUclSlC4cZVnrxuMn+SSTAtuAvEJs1tC9ku3Y0dacTqchOqanvT
         2liN1+MOOQl0MhzlxjFsZ90fxfip9jgwB3npBROeDWx7IMd6S7w28oOnOu1DcZTee7qK
         sKUwR0R7Y8YE4BU0gqLWn1h66m2Y8ot9zCxDgiKVbD88MD+PF3KWBPiPEpTr+zmcHBQR
         nJNhYhdnWW+Z+CMlLgMZE1/7vv3Fpj8ITyN39gBSmqGh/4AhzhgcqJVMIEv7u/sBxdXK
         zfYko5fAM1QxbRTbk73c/iiWbtJcEVvXV3Q9YnAIuJbI8iDNpTyMSFaglDM0oeaHddXl
         gudQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAfOWnM3bP6iesIx3kn7ivtqhJvtPJCh3+pLarOnZBDweFh+kdJS3jqCkhTe2QHSSIQ4hkCZTJDGwThX5WgUPi6n8qaMc6GkJeobHu15eXXq2xl6wK8HorJ24TTAFfzBLnPaiAaesHAWGgXSHMrgYKbA1yijMRUMO8Db9jR0FFXg==
X-Gm-Message-State: AOJu0Yx0owF9/YwJz5D85ngkz4nyLILg6tmbck3PzY/NORNVQmr4vg2G
	QsJNZD4t36I2w5NTj1F5g6oKgZz8NO5EEk+Iv7J3+tV5Nfjxtjgw
X-Google-Smtp-Source: AGHT+IGnnPdxAw+Fi4Vu9kUTtkIaWdxJFr0nMLCwqPlwY5RQOvDfHfRPVq/sbngDpx5c7XLeXyQ5yg==
X-Received: by 2002:a05:6a20:9c99:b0:1c0:e997:7081 with SMTP id adf61e73a8af0-1c904fb6619mr16269021637.29.1724149920673;
        Tue, 20 Aug 2024 03:32:00 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2035040319dsm8575905ad.23.2024.08.20.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:32:00 -0700 (PDT)
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
Subject: Re: [PATCH net,v5,1/2] net/smc: initialize ipv6_pinfo_offset in smc_inet6_prot and add smc6_sock structure
Date: Tue, 20 Aug 2024 19:31:52 +0900
Message-Id: <20240820103152.337880-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815043845.38871-1-aha310510@gmail.com>
References: <20240815043845.38871-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeongjun Park wrote:
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.
> 
> To solve this, we need to add code to smc_inet6_prot to initialize 
> ipv6_pinfo_offset.
> 
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Reported-by: syzkaller <syzkaller@googlegroups.com>
