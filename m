Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB206466B63;
	Thu, 24 Sep 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267404; cv=none; b=JXflaYFa305qXheDJGVG02QFNrH2AyPR3rObYpddmK9cujCYKvaf9pW4gus4/a78WA0S3GmVPOGCV3OCkv979ucYwYvMO3fmFDPNfSP+gAMLpEtz7oiNDkjNajhLUawo+Is/QlUA28CsvnS9Fdm//haf9+UUpgOSfDAGI5fkPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267404; c=relaxed/simple;
	bh=MDZjOimdvLZMPJwfrdx5b897pclV/aUxgsHuk9NcK5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To3lanvSMgyiiIEHb9TAB6SegGvTLQdPiJAz7M3H33AK5FO7P326wHzHMwgvtZGu9mxtcAqN03b85ezB0H/wvBBzyaaKyzO9T/IvGGvtn7yTqo5TF+jPI40R7l9WgyaxihQo9AT7t6eclkJRv+sj7NwMDQhON5+1kUTVLvFNEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R0TskwCn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R0TskwCn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OG5UEF2700642;
	Thu, 24 Sep 2026 16:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:sender:subject:to; s=pp1; bh=H/A5O2bUz1
	ZNbUC0rfU8bSJt/d1PlOBwg6YOQ0GLhLs=; b=R0TskwCn/1ZDsB2YKk4B0sxR/3
	YpdRSoVDParoQZ0L6f8vSeYug22TL85SdTYlQ/h9Bd6F6GxHjcxPguDyZfwEjlNP
	jlDnt5MxkJ7EKviUKQH87tUL7aYO37xAIheStMe3uxL1JwvXK4FnbpOZbK9VBRBi
	y8MMuWakGkqxJnNUP2tveCacWwFIJeFciHL0VpihehSXk+tQlslO5hExDudn1EMH
	ToX8I1RO/REkjt/bgRpOSF0yGQve+4I08BrU+JSgGinaa+dhuAY808eUhs265t3J
	vSLYH1frzgejAfFnK8E+W0iL3/p86NYjF/LDNGzeqJeZWyO48UriVHG8qbuw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2tby3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlUCJ2346093;
	Thu, 24 Sep 2026 16:29:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1xnyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:29:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OGTW3e52363652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 16:29:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C6A42004D;
	Thu, 24 Sep 2026 16:29:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3EB720043;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 16:29:31 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1x9mKB-000000094DH-30rW;
	Thu, 24 Sep 2026 18:29:31 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Benjamin Block <bebl@ategam.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-intel-xe <intel-xe@lists.freedesktop.org>,
        piotr.piorkowski@intel.com, Farhan Ali <alifm@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>, Guenter Roeck <linux@roeck-us.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ionut Nechita <sunlightlinux@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Benjamin Block <bblock@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v15 2/5] PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock in remove_store
Date: Thu, 24 Sep 2026 18:29:28 +0200
Message-ID: <1f58bc47da3e119a0c72e721455041c18db6f3ec.1790267348.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: IBM Deutschland Research & Development GmbH, https://www.ibm.com/privacy, Vors. Aufs.-R.: Wolfgang Wendt, Geschäftsführung: David Faller. Sitz der Ges.: Ehningen, Registergericht: AmtsG Stuttgart, HRB 243294
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IRLkOt6o9f-DRiqdF5jdSI5Vc5sllT9x
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab54ff2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8
 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8 a=mm2UkWPFonPHBTd3Hn4A:9
 a=nlm17XC03S6CtCLSeiRr:22 a=KSHYvF9M28j0gckGFaEs:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX1Qv9jgPWkSQ3
 UDKQYSTzIJRUcM+cMo2qDD7HWUfI6Qnha4ATYbIYdyFM03KrLRqGrd5k8KT8ECyWqoCPUtD+xMH
 vcjOKYqkOLsMfdGva4364JwtQctq1YegEVYaA0WmDfhn0IpXVhP8PFXtYO+n39UAKVdbjnvq6CZ
 AGUEt3Gi7yg3oFUnn7ohlYg21hNExJqOWNHHYqnEStItwKj3eFMrIWafnS1klmu8fSCO9N5II3e
 VpHCyosl7dngpjNTg/dX+gRIv2d20yPKzhxYGyzzoMBIh/QQfP82Vnkpm7vwcPapEIDCN4apr30
 LrOo6yv87sMqsbfE+vXyUbKEtXVzIzVgdpM5fsf5qO/Q8wW3P3Zg1KsZn5sBPq16wdIYAXenJNA
 BH9W1rGUPvANa0ih9LKTkjsZgV3eJWPWqI88ZlfsDRHFjZrWZMTx2ckjTqNshBRcVaW/Oe11d1g
 pFUhnTa8p9iN7sPBtwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX206iYhdVhNRP
 tdD4eBR94e9z3PaBV1NZhGM9Hu/ILCXZ/nKHnk7CylnUDAckkoeJ4HD/vMPJxc6gJQP/hL0/ULQ
 mTfda/M0Jg7EEuphytxQydtz57W9Cnc=
X-Proofpoint-GUID: qsqqzs_eNHL5Zp229PKcduGvXQSy6Cie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

From: Ionut Nechita <ionut.nechita@windriver.com>

remove_store() calls pci_stop_and_remove_bus_device_locked() which
takes pci_rescan_remove_lock first, then device_lock during driver
release.  Meanwhile, unbind_store() takes device_lock first (via
device_driver_detach), and the driver's .remove() callback may call
pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().

This creates an AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Fix this by first marking the device as dead using kill_device() to
prevent any new driver from binding, then calling device_release_driver()
before pci_stop_and_remove_bus_device_locked().

Marking the device dead closes the race window between unbinding and
removal where a new driver could theoretically bind: once the dead flag
is set, the device core will refuse any new driver probe.

After device_release_driver() returns, the driver is already unbound,
so the subsequent device_release_driver() call inside
pci_stop_and_remove_bus_device_locked() becomes a no-op.

Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-pci/0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net/
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Closes: https://lore.kernel.org/linux-pci/20260317090149.GA3835708@chlorum.ategam.org/
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1f21856aac8a..b2f3e052d903 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -520,8 +520,36 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		/*
+		 * Mark the device as dead so that no new driver can bind
+		 * between the unbind and the removal below.  Once the
+		 * dead flag is set, the device core will refuse any new
+		 * driver probe.
+		 */
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);
+
+		/*
+		 * Unbind the driver before removing the device to avoid
+		 * an AB-BA deadlock between device_lock and
+		 * pci_rescan_remove_lock.  Without this, remove_store
+		 * takes pci_rescan_remove_lock first (via
+		 * pci_stop_and_remove_bus_device_locked) and then
+		 * device_lock during driver release, while a concurrent
+		 * unbind_store (or sriov_numvfs_store) takes device_lock
+		 * first and then pci_rescan_remove_lock (via
+		 * sriov_del_vfs), creating a circular dependency.
+		 *
+		 * By unbinding first, the driver's .remove() callback
+		 * (including any SR-IOV VF cleanup) completes before
+		 * pci_rescan_remove_lock is acquired, ensuring both
+		 * paths take locks in the same order.
+		 */
+		device_release_driver(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-- 
2.55.0

