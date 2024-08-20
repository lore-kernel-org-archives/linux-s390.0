Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B918F2C8;
	Tue, 20 Aug 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156001; cv=none; b=PMgpf2yDvTzLJT0UAdWdpRoPzQxa+BS6dFODzpsnqLhixN1rmzo30ydlr58MXBgSK4fddKvoi9uP3/RK3dXd6riueaTnU8MSRSotIfzulc4k78o6/SzEy9oJS1Q0AYYsmzbuZppCErAxE+VHOvQgdq2tnJk/DHGlztZ63Ebvk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156001; c=relaxed/simple;
	bh=sjoksWZ8Am0KeIIGjVG0E4j+q+NHl4a2vZP83KMzPa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=br9CZmM17XRwh2VAfAeMVOQC9UKaJFNouAy7hMt0wkQTYUZrntNVJX1z0dMEWRkgx/70RJnCDPrR4qU+TjCn8tSTlG3tcRQe/kGberDTyg4oG0qujQTFiFPtpM9WKaNOMxW7fO1cRHjZk35c2Pno/Ucfy4XxybYbLbICW4tnAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ1Q9DGo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ1Q9DGo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201fbd0d7c2so33942825ad.0;
        Tue, 20 Aug 2024 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724155999; x=1724760799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoL2v+PkNQmrjvvc83i9ktW//U4xDXc8wzaEFkS8wz8=;
        b=lZ1Q9DGo/+kXXf/rczq7zB7HbbK3DjxFpvkFLgg3x6WvS59vkyJ41ezPu2qQbQKWCw
         cjy3G93+uZoRuAFDC6LG97nhDcMR0mk7wKA11CEMAyTFK8ZknSNjcmPdgxm+kQ7A/SyD
         7MoDH0MOmLHDsWoz6Lh3CX5Rd9aI4G8jFmjyso6qdcVsLhDqwt9yksZ5LRwMd7GS30h4
         M0peuU7cbwGdDBaTcJCR3DYGTVpe+hoQrjODH7hfjzdhoPYb0Tmh5z3NxZBrsNqyB0JT
         HcqZTa5cfm/z0GT6hgJd/dPH8XKIkh1pPtlrlABoi7nhYu70hyMGfGoiC4HbqPXlRjLJ
         4H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724155999; x=1724760799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoL2v+PkNQmrjvvc83i9ktW//U4xDXc8wzaEFkS8wz8=;
        b=VsmvWd+jyEnlSuP4fvCJ7d+fAJVcgehlhMQdwLXJ6qr+RArSIaqbu9V+JVF/qEItG9
         wNRrrGqM59RMlCq6fymOA5LZstgRN1ckr7i1hIkXPgCtoZg/+MzDCI87p+xMSIpbIXfG
         a9iSa3pRDFuMrFpCnjesghd57A63VdmtNr8SckkYvLyncIty2lgbgPJbSdbmkQRjvZSl
         sypsz+SKUXSLvWvcjLBI/PFYL24IVMzH262bktuMUfRwKJyhNajeD2IZRwgmlbCxmfKH
         MncNOuLN4oblEPrVLNx7xm8W+0Khl6lRmtNLQd3SxSHlUF0UKBOqDpH9TmoTKkVDeEKl
         cyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9cs1kVI4dFloZWpAuYQBAlB1xRmNJR7rC5ljhlEUePM8W0F7PaLiL2mI1klwd+9vUkvxNrEPT@vger.kernel.org, AJvYcCVTsJHBIU1TcU8zxl82IJxIBkrYNwPOolZcqFAM8AlqIOIPUaXSNFr+lCRnLbCYVLG+FA9caaFYiYZhBw==@vger.kernel.org, AJvYcCWD1Xom4qJ9Ytx8frTc+jxqT95Lbe2D+g+LPHLzDcryzTrOJdC0E7WRHhw2x8of2bbjxjbebtoNmSQ9Q5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBS+1+uQ6aYBhdmdq9F2R2Mysk/EmaTpLrEwtcMs6/RxU4BFI
	BrV8pdZzi3tQ64JHuXC5XRXbz+OwQu5QED2mJzKPLGbnbmOKQ/WsUUNt7UyPz7U=
X-Google-Smtp-Source: AGHT+IE5m+P2JgvEeVsaTU0x5+8ycE2UTgoPNVpJRCgV6O/FXWgCaEmhjgXc4RredOg+4KFqmfqBhw==
X-Received: by 2002:a17:902:ea0a:b0:202:32cf:5dbe with SMTP id d9443c01a7336-20232cf5e3emr67545435ad.58.1724155998752;
        Tue, 20 Aug 2024 05:13:18 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038df95sm76339535ad.227.2024.08.20.05.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 05:13:18 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	utz.bacher@de.ibm.com,
	dust.li@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v6,0/2] net/smc: prevent NULL pointer dereference in txopt_get
Date: Tue, 20 Aug 2024 21:13:12 +0900
Message-Id: <20240820121312.380126-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is to resolve vulnerabilities that occur in the process of
creating an IPv6 socket with IPPROTO_SMC.

Jeongjun Park (2):
  net/smc: modify smc_sock structure
  net/smc: initialize ipv6_pinfo_offset in smc_inet6_prot and add smc6_sock structure

 net/smc/smc.h 		| 5 ++++-
 net/smc/smc_inet.c	| 8 +++++++-
 2 file changed, 11 insertions(+), 2 deletion(-)
