Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6F309F19;
	Sun,  1 Mar 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329840; cv=none; b=FzC0xko3eoPCpenMNk/wy4oWab2UEhzb8GQ6tvY8GaPzgJJVo+qlPcs/5fpSIZ20SKdoblDu67kmv7nKDPwO40B7l50X7EvTFFlB4VxQRX+8rMtRmgDIdXz8IcdThaTVK6knQ0wmRVUaYoawCDeW7AVUOgYZwGjPLIBDEQCcEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329840; c=relaxed/simple;
	bh=P61Jt+ayGwDe7d5A4AL1fyN6GNlmJKTX29d3c3wAIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsLrmh1J3VBftMUe0sPUkUqjYREUCKVPzW69T+6Ur+Xgbvw6OTn811zvCCsbgRmwvJ6XaFP2OBn0K4Y3sF+/7SD/OiMrtPZX9ecu8Kkc0Z8ADdXNhDf9j8U9tMPZV2tziw19kopbY97WhjKTAw610O7+1fnGfvIXY/k5+TirKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIVTM3YL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIVTM3YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70941C19421;
	Sun,  1 Mar 2026 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329840;
	bh=P61Jt+ayGwDe7d5A4AL1fyN6GNlmJKTX29d3c3wAIXE=;
	h=From:To:Cc:Subject:Date:From;
	b=RIVTM3YLD8QTcJNK0yn6usDzQ4meXwzZrZMtnNKdxICrhIJwmxkMxYMt78Pf3Ule/
	 owX2Ydl4xomgSbXQdLzLi42PebHFjiYRgiTVXqbAwJN2GqvEKEVZIeIFrD/0r7l3xH
	 Zb94hE/JjLYqFibs4S9n4mOfj/HQ3jgIwf5nQ3DKgfaXpGnMxnBRKlpExUaddmiymL
	 qwoWfG6bQONoO6TH7f7D0zNqK75xu2+mIfjgTFaGv1DItbKL8RUDjxoQ1tDYwD4JaK
	 V7wc4AXtRSsUIB41fBrOHQijKP9xyIvWFs2eIRuOhBskhrPyPwH4XSUExZmX2iM6ES
	 OvO0TLHnSdCKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: FAILED: Patch "s390/pci: Handle futile config accesses of disabled devices directly" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:50:38 -0500
Message-ID: <20260301015038.1716685-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 84d875e69818bed600edccb09be4a64b84a34a54 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 8 Jan 2026 16:45:53 +0100
Subject: [PATCH] s390/pci: Handle futile config accesses of disabled devices
 directly

On s390 PCI busses and slots with multiple functions may have holes
because PCI functions are passed-through by the hypervisor on a per
function basis and some functions may be in standby or reserved. This
fact is indicated by returning true from the
hypervisor_isolated_pci_functions() helper and triggers common code to
scan all possible devfn values. Via pci_scan_single_device() this in
turn causes config reads for the device and vendor IDs, even for PCI
functions which are in standby and thereofore disabled.

So far these futile config reads, as well as potentially writes, which
can never succeed were handled by the PCI load/store instructions
themselves. This works as the platform just returns an error for
a disabled and thus not usable function handle. It does cause spamming
of error logs and additional overhead though.

Instead check if the used function handle is enabled in zpci_cfg_load()
and zpci_cfg_write() and if not enable directly return -ENODEV. Also
refactor zpci_cfg_load() and zpci_cfg_store() slightly to accommodate
the new logic while meeting modern kernel style guidelines.

Cc: stable@vger.kernel.org
Fixes: a50297cf8235 ("s390/pci: separate zbus creation from scanning")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/pci.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 57f3980b98a92..7f44b0644a20e 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -231,24 +231,33 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, ZPCI_PCIAS_CFGSPC, len);
+	int rc = -ENODEV;
 	u64 data;
-	int rc;
+
+	if (!zdev_enabled(zdev))
+		goto out_err;
 
 	rc = __zpci_load(&data, req, offset);
-	if (!rc) {
-		data = le64_to_cpu((__force __le64) data);
-		data >>= (8 - len) * 8;
-		*val = (u32) data;
-	} else
-		*val = 0xffffffff;
+	if (rc)
+		goto out_err;
+	data = le64_to_cpu((__force __le64)data);
+	data >>= (8 - len) * 8;
+	*val = (u32)data;
+	return 0;
+
+out_err:
+	PCI_SET_ERROR_RESPONSE(val);
 	return rc;
 }
 
 static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, ZPCI_PCIAS_CFGSPC, len);
+	int rc = -ENODEV;
 	u64 data = val;
-	int rc;
+
+	if (!zdev_enabled(zdev))
+		return rc;
 
 	data <<= (8 - len) * 8;
 	data = (__force u64) cpu_to_le64(data);
-- 
2.51.0




