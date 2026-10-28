Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162931;
	b=IKOMsEwpVB6Pou/Bayy3k5SlYw+3ie4ZoqLjwUhaEuC2uPTsklMIgz2Mo/BNMiu5UbhS
	 syjd18O+4OAGkFSiNgs4A1M+2LNO/N12mpCaINurA5082CuPpScqyOTA9ZCVQ1loxfYyi
	 ovtbvnzl1vti7sWi3rGkEVZljm03KGCB9PmN61fyCP6z+vmjSztnVCWLfZqCLKZWNmz3J
	 Dps7yN9mKfVi4WTGFeOVrfBlynWltNHAcOwgWVed1IGr+qbbV1JmKVMXOcbenTsoLZoPo
	 idNqDrLvsC6hVSemp/tPnZUv1oICQze2Jnfzh7wTF3uMD9hZBNgRrxOOPWxfkKGW2Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162931;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=dBYnAyRWbMH9Ty6HmVhqT5hGu/VQSDIXmyjUOwXe5+A=;
	b=FpfyOMfuCZBUnmCbrSiL8J1gbgE9OPXJ6RzSynpTHi1kdjp+zFgbMfQTa/SKpBJedekp
	 SEZj9G461eWC2Hd3eKfoSCsU02bjUfEIidn+Y30k5S4kh19j/fV7QN8g8lZNin46OHnfJ
	 8sXQMshFI2Ok1V1xLS2pAiU+ilj7EhMi4Ti0oteKSghIIz971dhcanuXyL9bb8jlRimbr
	 +w7pjZkIthkgVnspz7aj9yhx138cVJcdczh7hNmJv4kX7O/YjkjWR3wVDqV2yo6vr3UNz
	 VevI0m3lBR2sXtRPi1RKESYxRY3OYGydCxWJz6tzuWoeDPBuWyIx8rQZwf0foJlsk7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lfoN8dYc;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56A606A31D;
	Wed, 28 Oct 2026 04:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB56A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lfoN8dYc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dB
	YnAyRWbMH9Ty6HmVhqT5hGu/VQSDIXmyjUOwXe5+A=; b=lfoN8dYchgjzdNnj6K
	JJcbycU5WbGRBZ5ro0BzqEVgtLfQsNnWkO0gzONvWL0/hZr2nwEDctrACBXT3qaF
	/ZFp3msD0rhgkH95cTQ1QrM6i+yHml5kAuc2CAfpLmxyR/wnDgaUK95U0PFnMW8X
	QvRolAohVcgDBsQOLNQGvOOvA=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S7;
	Wed, 28 Oct 2026 12:48:35 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5/6] s390/dcssblk: initialize device semaphore before sysfs registration
Date: Wed, 28 Oct 2026 12:48:25 +0800
Message-Id: <20261028044828.96177-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028044828.96177-1-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr17Kr18JrWfAry8Cr48Zwb_yoWkCwb_G3
	yfuwnIqFs7KFsIkry2k3WSvrW2yr1xGr1fAFy3t3yxXrW7Way3Zrs8uF4UKw4DGws7CFs8
	urn8W3Wv9r1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU83CztUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgPaFWrhfqOOzgAA3U

device_create_file() makes the add and remove attributes writable before
the device list semaphore is initialized. A sysfs write racing module
initialization can therefore acquire an uninitialized rwsem.

Initialize the semaphore before registering the root device and its
attributes.

Fixes: c369527f18f8 ("[S390] pm: dcssblk power management callbacks.")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/s390/block/dcssblk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index e5a02c2990d0..46dd7eb9ca7d 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -1013,6 +1013,8 @@ dcssblk_init(void)
 {
 	int rc;
 
+	init_rwsem(&dcssblk_devices_sem);
+
 	dcssblk_root_dev = root_device_register("dcssblk");
 	if (IS_ERR(dcssblk_root_dev))
 		return PTR_ERR(dcssblk_root_dev);
@@ -1026,7 +1028,6 @@ dcssblk_init(void)
 	if (rc < 0)
 		goto out_root;
 	dcssblk_major = rc;
-	init_rwsem(&dcssblk_devices_sem);
 
 	dcssblk_check_params();
 	return 0;
-- 
2.34.1

