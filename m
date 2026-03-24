Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6269367F3D;
	Tue, 24 Mar 2026 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314031; cv=none; b=R+DVYk+k04903426sScl4GPrju+iKPbpbF9uLtR7hfGKiFqU0BXsF7mqt66rDeTWAACUWQaKWUTRMl6JOsFAiD7LBE4RW3NOEdcyrxNs9CEN09jJIrBxH6G1rMkfKztj7OmWvAzwVnTufh6N0vTfhAgHixOr3nz97+BvnKuJwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314031; c=relaxed/simple;
	bh=dVVILhMfLU1pcFlan9xwtWDXjlzo37eXkY5X05ORIlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf8BGtii7Q4nh28B9yexVYqsgbwaozqd2m8fRcw4JEoIy5Hbyi7RSE9rX/Ad+3+o6p/lS/4sfkIXzp7b5SrX97vYuPuE5qubwJvIqrDGugD8RTBQ7DKDgXPf8Dh7iRFOKD+Ha1uqqBcX8RG1PKeT/FcKje/4LPeMjWvYdlGjOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy7fnz0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy7fnz0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D3C4CEF7;
	Tue, 24 Mar 2026 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314030;
	bh=dVVILhMfLU1pcFlan9xwtWDXjlzo37eXkY5X05ORIlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oy7fnz0d39vA8DeLusS4kHmpWkfMdqaP0nrRciue0f+NOlsV7gOuADpO1Y48Jjg9f
	 MITiU8jQzjjQb8f5VUB0Og0V6KsNuJU5YifXigPhRS4NOb+330wbT3injb7ng50liP
	 ZqYubh6zWsY6SNwUAyB+PO/HpqXevDVNbsUrBXfFeyOD+eL8N4tmQ16wvpDq7I+Ye8
	 iZ8d4J+xr7mwhTpSI2vWE/qgDpXkD4QpCa5xOcpu1lnxoYQaD4trGqmzV3/Z0aby4P
	 mzbq8SomMXXsM9/OneYtf9uUKMBhTaqwO7Z3Va8LBxv8TI9anEyvFJWgLAVmMmZ6P7
	 5kfjdP36uus8A==
From: Danilo Krummrich <dakr@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 06/12] platform/wmi: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:10 +0100
Message-ID: <20260324005919.2408620-7-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a driver is probed through __driver_attach(), the bus' match()
callback is called without the device lock held, thus accessing the
driver_override field without a lock, which can cause a UAF.

Fix this by using the driver-core driver_override infrastructure taking
care of proper locking internally.

Note that calling match() from __driver_attach() without the device lock
held is intentional. [1]

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Fixes: 12046f8c77e0 ("platform/x86: wmi: Add driver_override support")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/platform/wmi/core.c | 36 +++++-------------------------------
 include/linux/wmi.h         |  4 ----
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
index b8e6b9a421c6..750e3619724e 100644
--- a/drivers/platform/wmi/core.c
+++ b/drivers/platform/wmi/core.c
@@ -842,39 +842,11 @@ static ssize_t expensive_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(expensive);
 
-static ssize_t driver_override_show(struct device *dev, struct device_attribute *attr,
-				    char *buf)
-{
-	struct wmi_device *wdev = to_wmi_device(dev);
-	ssize_t ret;
-
-	device_lock(dev);
-	ret = sysfs_emit(buf, "%s\n", wdev->driver_override);
-	device_unlock(dev);
-
-	return ret;
-}
-
-static ssize_t driver_override_store(struct device *dev, struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct wmi_device *wdev = to_wmi_device(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &wdev->driver_override, buf, count);
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 static struct attribute *wmi_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_guid.attr,
 	&dev_attr_instance_count.attr,
 	&dev_attr_expensive.attr,
-	&dev_attr_driver_override.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(wmi);
@@ -943,7 +915,6 @@ static void wmi_dev_release(struct device *dev)
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	kfree(wblock->dev.driver_override);
 	kfree(wblock);
 }
 
@@ -952,10 +923,12 @@ static int wmi_dev_match(struct device *dev, const struct device_driver *driver)
 	const struct wmi_driver *wmi_driver = to_wmi_driver(driver);
 	struct wmi_block *wblock = dev_to_wblock(dev);
 	const struct wmi_device_id *id = wmi_driver->id_table;
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (wblock->dev.driver_override)
-		return !strcmp(wblock->dev.driver_override, driver->name);
+	ret = device_match_driver_override(dev, driver);
+	if (ret >= 0)
+		return ret;
 
 	if (id == NULL)
 		return 0;
@@ -1076,6 +1049,7 @@ static struct class wmi_bus_class = {
 static const struct bus_type wmi_bus_type = {
 	.name = "wmi",
 	.dev_groups = wmi_groups,
+	.driver_override = true,
 	.match = wmi_dev_match,
 	.uevent = wmi_dev_uevent,
 	.probe = wmi_dev_probe,
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 75cb0c7cfe57..14fb644e1701 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -18,16 +18,12 @@
  * struct wmi_device - WMI device structure
  * @dev: Device associated with this WMI device
  * @setable: True for devices implementing the Set Control Method
- * @driver_override: Driver name to force a match; do not set directly,
- *		     because core frees it; use driver_set_override() to
- *		     set or clear it.
  *
  * This represents WMI devices discovered by the WMI driver core.
  */
 struct wmi_device {
 	struct device dev;
 	bool setable;
-	const char *driver_override;
 };
 
 /**
-- 
2.53.0

