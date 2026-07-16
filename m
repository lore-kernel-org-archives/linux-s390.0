Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47430427F9A
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208238; cv=none; b=pggHVwFA4fppq37pdVYcX+0k/lRgs+TVYv9ptyxsiE2eRrfoBnLjUXaIIcuNyd88y0UP53I+70/YQeotPE//UtYLESlJkE2ulNjkTM2/c2p28XEfw73XDm4tUNQ0eTKwppEmGxUIBPmE7nXXIQ9DQdt3XAuiKCoC0zXAdvGPwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208238; c=relaxed/simple;
	bh=BtV4YlWqSeeVkZLMl7O/Z8uUv5IQpghIyehpmENCIJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSJtR+//mziuWhj/9Z6/Ke4Q4NgCDdUJsVEE3R9qS/PQVLWIhfh/l5106fjuK3x+f6LvV0SIufNGFDDGk5xp+6O2rSsE9GXLaxCzrB2Gpzfofgom1+x8CEKeguiO+iMHeF/vB+DR81cAoUHTTpCRuGvoyHwmYzv+cRUxaKkKbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=L3sadX04; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="L3sadX04"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4720d22c94aso3619641f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208235; x=1784813035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=L3sadX04LrdZDyj+1eIDek6k1AO4oq0+VoJNTzJJxpHD7y6suFvl2BJUu87PKlqgAm
         Ewza1KxAqL+LmKltKg1fdVDY9bgPG4kksMNzvN3PLNjjKqxB5nab+zOJi2V357atRh3X
         KnCFlASrka4T+qTphB8LVLC44tuv/l287u825ypzdknNqwPNDNaDsa6FwieRF55YI+tS
         fGVkyPxKJtv44NzEWRFTs/YEsauqST4sAO+yQcAvLnrrHH725cFxbv6VNCtCy8RtepMU
         g04CpSdTg8sZLGxpG3G70yPI9iBbyRrwjLdjRPDz1ysUIPNvakCHZ6KouHbrelXCqJkE
         i7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208235; x=1784813035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=L62gsFpZhipgoYbQRir1DvuH5EdkPTabikTpR7nH1NHPPrVJiN+I2XEPE5tSeaG/cI
         +71WdTU35kyqDK54qjuodNn27pcDJTTVD9v1YQAOiLuvM/xpyf3johAoELQv//OCN/+B
         p5ahiIW/t8jpZbRixDZoBXiQBQn/4OYMRmaKftDj07aKpYIYkVEEOxmutlEw3v5GQw0I
         FE4lg4ASZ2OJHcylQPMVcU3FReJkO7uMXSKYtLADvf89HlmfJz3QXxtd7yi7Xt4Xtvp+
         1rP78DfU/P/za2+ntpxWltoP+JqE792FfuWgZBxMbVrUYZ1SXUpiwR8P5w6khW445lu6
         2T4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrwd78+hKonSZmaUjJIqOfxz4utDFkzWDtub288WZTXvxSlFpykTO1dAO70mNvna4dLeGXjgFotrr49@vger.kernel.org
X-Gm-Message-State: AOJu0YyBi9OkCzUTU9K/D5pqVkF/L2QT81TwaMoXAdmB00z8bTyfVJf1
	lJFFJ5UM7MKCwQ9lx2ON/4kjUl4fva4j/w+sHWoaifLDcy7QsiQhbPlJZ1k1THydH8o=
X-Gm-Gg: AfdE7cmbfx8oKRmaUodXEjKqjLMhbpKJaaCojXImxdQi7JjbVQw1RJ/yrDbV+FJGCRs
	va+fRSOMraDB2ln/pm7Vn07OegTWTepnnqie9O+DbHEvETHuCZJJJTdvLSpbj2yLF1Xv9nsjWFl
	1s5J5b6th3Yf5UPzjR2vmYb4kxrT+T2menPgZ+YLhP4WVlqpuxDpRQO3tHT1GFMgEnk4Xw99WFL
	nzkCLatblWjAv6lG6W0OE9S5p7kY3nalQ+PqeiGyv5ykdwxmpqQwQAmXTZsvOhRFVt+7n1rz8wl
	6XWYVHVpoGAZIRNrA+1OpGsEml9daR4BIdedt/Mvoo9SgWcs7wYvzmvEdwLxwVdLFYjWKFnpZ0b
	m+URcsw+/mUAQmXW49nHVna7BwyACBWY0ZNp3ViRyirlx3yC0cqj3YHcdGHtrnsI/0X/81ySPWC
	Y59MAb5mHovBA=
X-Received: by 2002:a05:6000:29cc:b0:47f:4d11:3476 with SMTP id ffacd0b85a97d-47f4d113b44mr8270146f8f.5.1784208235345;
        Thu, 16 Jul 2026 06:23:55 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm24761180f8f.24.2026.07.16.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:23:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v3 09/14] RDMA/cma: Document that CM configfs cannot be net namespace scoped
Date: Thu, 16 Jul 2026 15:23:10 +0200
Message-ID: <20260716132316.1495242-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132316.1495242-1-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Document the rdma_cm configfs limitation: configfs is global, so same-named
RDMA devices in different net namespaces cannot both be represented there.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/ABI/testing/configfs-rdma_cm | 4 ++++
 drivers/infiniband/core/cma_configfs.c     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-rdma_cm b/Documentation/ABI/testing/configfs-rdma_cm
index 74f9506f42e7..739f7b6a1259 100644
--- a/Documentation/ABI/testing/configfs-rdma_cm
+++ b/Documentation/ABI/testing/configfs-rdma_cm
@@ -12,6 +12,10 @@ Description: 	Interface is used to configure RDMA-cable HCAs in respect to
 		for this HCA has to be created:
 		mkdir -p /config/rdma_cm/<hca>
 
+		Note: configfs has no network namespace support, so this
+		interface cannot represent two devices that share a name in
+		different network namespaces (possible in exclusive netns mode).
+
 
 What: 		/config/rdma_cm/<hca>/ports/<port-num>/default_roce_mode
 Date: 		November 29, 2015
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 891e52afb8f4..c389d4e37b6b 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -65,6 +65,10 @@ static struct cma_dev_port_group *to_dev_port_group(struct config_item *item)
 	return container_of(group, struct cma_dev_port_group, group);
 }
 
+/*
+ * configfs is not net namespace aware, so a name shared by devices in
+ * different namespaces resolves to the first match here.
+ */
 static bool filter_by_name(struct ib_device *ib_dev, void *cookie)
 {
 	return !strcmp(dev_name(&ib_dev->dev), cookie);
-- 
2.54.0

