Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35C3C43462
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 23:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48EF61465
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 23:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhDWXEO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Apr 2021 19:04:14 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:21884
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243974AbhDWXEF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Apr 2021 19:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGhTtYdC1xPV5x0MhlthzhzC22Cd8TCHfmyp4bNeARDGpSulb4ZSX1fOB93SNYO/fuijd6spQNFG5uKW9lLtTk759Hu482hq4lLdcl9wu7/N+F8udhx+J0GOTF3yptrmQJG1ThFy7/9ilszCc1iTmkc+Au3vmU0e4Srng4MEuw4NCwyiSG97aHmUOdO13zNXZxW2CXbyJ6A2pQ+CgkPllm1JCkhkUw1Ba1+gyX9JZROPnOKyIpU9pS7AZKxkQxv8KY1okoM6CONVCDiavj0xiiB2Fg3MV2/0s6U8zWnI2zeFu+BSwOAV1ZVSE60V3S175/X4KypNoMuU2fxzCVU5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAl1RpTrWqN5LZrV77LcK5OTpSV7Yj94D2r3e03JiG0=;
 b=j+WQrdXVd7A0yL5sfB9RiNJNoJqm4F+NZ+JlDi1/6UriVYoL+aWSzoLXtpvBOmt8lU6eowflTFzgXmRZMdTtDE0YegfCh8zrc+ZnsOHFopEPoujzeW9/+EIz8yNpff05J/ihjlpvJT3N5NJpq3c/+c/4OCPjUd76bm1TDX3jZjmWWdraDSXol3IVoG/JOASqkPvx2i41Z8Mo1GHjkl5Jq0/iBWdt03CWA1dgA1E6wtV7z4EEG05S54tpPPP9ZwF6qQuLiiza/s11PfYaEQH7hAUMSZf1VBtHzw1mBzmnHSawuQ5JFKT0Dp1Kirp2pGhWRfkTvT1UmA1aZw9VvT+9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAl1RpTrWqN5LZrV77LcK5OTpSV7Yj94D2r3e03JiG0=;
 b=X5Jy1+ReBcns6rK1PQ/OAjh+5vEQsf90IdwgZ2tISBZdcgAQbFn3RE3KLXLszDAuVjQg6JqcPWMtSvmv6ZPNWLzrQPw4TCSWPQo1UZXz+gHlaX6qhk527athctokTIU3pEV7qpvA2z9ClGjolKh4OXIfwbF4uvyf66o2yCGK+mwN37oOYkf12Pv9pp/N5GXuxWLH7GaaWEGhResNWCsegIRSnU7Xgu8sB9RDLCqv0Vs6xMt+78DB4ej99nzuCssjgMgARXl9Z1fiFXPueL3FwIYDMMGPP/ZPXhrBrsgAB6JKiuHP0sXi4+NR8xXP1AkNGlnQqORYnC/U/VF3IqhBZg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Fri, 23 Apr
 2021 23:03:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 23:03:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
Subject: [PATCH 01/12] vfio/mdev: Remove CONFIG_VFIO_MDEV_DEVICE
Date:   Fri, 23 Apr 2021 20:02:58 -0300
Message-Id: <1-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
In-Reply-To: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:c0::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:c0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Fri, 23 Apr 2021 23:03:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1la4pJ-00CHzQ-Sr; Fri, 23 Apr 2021 20:03:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cacf2b6-9d03-4803-f244-08d906abf967
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203B6581A924D2472B5EB03C2459@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wA13cT1V6sMbejR+LLkbqK35QHe8l36lOmpaeOon5zanujv3PivlFKHHvG7V5/JoAcfZbo1R44Kdji2iIyGjdEE1f9wpH8bRhVZis6y97Xm9Msno4POD/Ajb0goM4RmPyjYWjWwTD7nkdeagRD67xHRTi6cwYIPtyPUc39h0owuFntTRObef13ywGI1l1uMKfPpgdfWCVpytwI4IulQCvwFcCHQZnNNEzzEkQoNuEJkAghMt6ftLsQrpAGeKSPOhiLXF+rpf/MKeVa+aTlUYeAVA7c2CZa6/tYMoXGdVa0osFv5MJCUXr1OFQMjGYQv+cc2GIs33lE6U10YX5CXHXGrDG56V5/D46NMHgLIKC3MFBSZuonACjrw+ezfR0zWphJmqQjEbGphjEqRNSwvU7Nhq3TZnFb4o7tfN49A40+oZYWeRV6DGUehjciLv/jzkxVF/rb5cXXt1E+OAisafbqRBOEQR0gdFJWsSrNLvqHS2sC1nsMAUq8aPHgqaTElblUWLAcJhjkznypd5nyI5GX+kGoEccT7WAUVAlSwAsO2nRVJC6WVhlqCvA9YAzhb13ysVcfNWmrB1felpmm64gE47yJOO+PS5+7Xi6PRvXpHExoVXIzbBhaZiNCnNbMbL1YYtCX6A5GrMI8sdzvAnHYQ+G5xjlOROqzb+rDsjhzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(6666004)(86362001)(2906002)(66556008)(2616005)(426003)(66476007)(921005)(107886003)(66946007)(110136005)(38100700002)(36756003)(26005)(186003)(83380400001)(8676002)(54906003)(9786002)(316002)(4326008)(8936002)(9746002)(5660300002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vUzAH7iwIp0yWNr6M1wCR94sMWF4b7HukMgbr+c/eposXfCEaKkA4CsEw+Oo?=
 =?us-ascii?Q?QRtsqBrWKuhjWtXY8CBnIbkqywhy1miTzmxHevUM06LjVtP+3SZ31P6nDA4n?=
 =?us-ascii?Q?HGSDDWAnORJhb4Pucd5roo9UTwpZOU5qzFeVqUzi5APoPEFQBx3/xMG1O1jG?=
 =?us-ascii?Q?Ai5PbIQpwEHMtjtyBobc6wYk9fCDraylgkSsmQydTDcBNUjF/X/tAbUlCDe2?=
 =?us-ascii?Q?oXPeYj7BkPjbvk8vs+tw1uvSomm/xoyQXfUBBmOqLI+9zHSmO5i5B74Ugcks?=
 =?us-ascii?Q?KOYJLubvze5z6TtoH0C0S5D1C4XyW1vC1XIJTxiR10eCZQRYWV+hBg2RXfZG?=
 =?us-ascii?Q?kbz3VErBvWAwQc4zIPpOhxVLG/yHKvKf5wMX4vSs+XNUMFphyqKH++WmxRVd?=
 =?us-ascii?Q?tjUX5RSenpUofYHmR0Y/6YoZjOM8hSxViCcgDsBqiWJp8iSSqt9ODdM9k2o0?=
 =?us-ascii?Q?wYT400pKyp64w4V0PHssV2iDLK340S8K0oHIdKibV6sHRodQxJLJyjLHgQDZ?=
 =?us-ascii?Q?eIHxzk5LFnQcSfkOL57SB4dwQ9P1FJDFdSs32p59BqNjHewsVVWxsd6XSR8a?=
 =?us-ascii?Q?zAG2fczhlZqNwmHH9gOE3520y9YwV+Q5jUbgcaPhz3Joo7kfm2myiibUdhyC?=
 =?us-ascii?Q?y1Uds0XMAJ+wA3k+ealcNAuNrp3YZilC7StF6+V+JDAHb+gzoORTGpoi9C5E?=
 =?us-ascii?Q?BGkLZpr7WmxMB+Cmuuh2vVB3t2XAQw4KFMhsPKbZ2Rs58cnT9XXA4HimStvC?=
 =?us-ascii?Q?fzViVxz+q05MS2hdkZ6aAcLRVSNpN3CBaN5bDGAJdRUeHcLrQn1R8uKNDalA?=
 =?us-ascii?Q?5nme86uAdOaQW9C0xawCUx7adrY37b1mdc3cFx+cjtPREE6Mgyg2ZyvPYm2w?=
 =?us-ascii?Q?oHHyv8Syo1O3GzOS2sGzE64ixEzxRdsGzFIlWV9KgoLkTDkyGgTl0k+ruRdH?=
 =?us-ascii?Q?8s8vqHY1bt7B7iV8cy6SC0tywdm7l53I6MtFqNcmMjp/cnt4bA7Ycai0CS35?=
 =?us-ascii?Q?XFtN8B0yANVTh5lxcULue0n3gimRiteyXw8zv4SPR61oikkuzzYekSOFbsR6?=
 =?us-ascii?Q?hd5Pa/Miu785A9AiWpVf5hEe3SNNjE/qQa02tTSfiiweXrhTQTCZcgKd6BTp?=
 =?us-ascii?Q?Md3KSI4dgw8OmHyNcw5t8flJhBuzWXkhv34hhE5rgLf6xv7Q6jQC0T1MqdYj?=
 =?us-ascii?Q?7T7bLTjC4irL9N7ingh/e935c+AJZztI0rSI1xkBfYieG36qxyP4RqwTmjwj?=
 =?us-ascii?Q?exHG294x4QAnVvlW4mwVqrrAzIPk0GB3lWWHmtfjdgYTQkPRFgP05akhQnWK?=
 =?us-ascii?Q?9+ePjjRgnQMGUbK7XiXnTnh3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cacf2b6-9d03-4803-f244-08d906abf967
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 23:03:14.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJWXl81wqXhyt8dU9bsDcR8dKOlKhyx7A/IojhnxSOIMGl+w63eOoJVt/hzvseYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For some reason the vfio_mdev shim mdev_driver has its own module and
kconfig. As the next patch requires access to it from mdev.ko merge the
two modules together and remove VFIO_MDEV_DEVICE.

A later patch deletes this driver entirely.

This also fixes a misuse of kconfig in the samples which prevented the
samples from being built in.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/s390/vfio-ap.rst   |  1 -
 arch/s390/Kconfig                |  2 +-
 drivers/gpu/drm/i915/Kconfig     |  2 +-
 drivers/vfio/mdev/Kconfig        |  7 -------
 drivers/vfio/mdev/Makefile       |  3 +--
 drivers/vfio/mdev/mdev_core.c    | 16 ++++++++++++++--
 drivers/vfio/mdev/mdev_private.h |  2 ++
 drivers/vfio/mdev/vfio_mdev.c    | 24 +-----------------------
 samples/Kconfig                  |  6 +++---
 9 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index e15436599086b7..f57ae621f33e89 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -514,7 +514,6 @@ These are the steps:
    * S390_AP_IOMMU
    * VFIO
    * VFIO_MDEV
-   * VFIO_MDEV_DEVICE
    * KVM
 
    If using make menuconfig select the following to build the vfio_ap module::
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c1ff874e6c2e63..dc7928e37fa409 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -773,7 +773,7 @@ config VFIO_CCW
 config VFIO_AP
 	def_tristate n
 	prompt "VFIO support for AP devices"
-	depends on S390_AP_IOMMU && VFIO_MDEV_DEVICE && KVM
+	depends on S390_AP_IOMMU && VFIO_MDEV && KVM
 	depends on ZCRYPT
 	help
 		This driver grants access to Adjunct Processor (AP) devices
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 483e9ff8ca1d23..388bc41aa1a75b 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -125,7 +125,7 @@ config DRM_I915_GVT_KVMGT
 	tristate "Enable KVM/VFIO support for Intel GVT-g"
 	depends on DRM_I915_GVT
 	depends on KVM
-	depends on VFIO_MDEV && VFIO_MDEV_DEVICE
+	depends on VFIO_MDEV
 	default n
 	help
 	  Choose this option if you want to enable KVMGT support for
diff --git a/drivers/vfio/mdev/Kconfig b/drivers/vfio/mdev/Kconfig
index 5da27f2100f9bd..763c877a1318bc 100644
--- a/drivers/vfio/mdev/Kconfig
+++ b/drivers/vfio/mdev/Kconfig
@@ -9,10 +9,3 @@ config VFIO_MDEV
 	  See Documentation/driver-api/vfio-mediated-device.rst for more details.
 
 	  If you don't know what do here, say N.
-
-config VFIO_MDEV_DEVICE
-	tristate "VFIO driver for Mediated devices"
-	depends on VFIO && VFIO_MDEV
-	default n
-	help
-	  VFIO based driver for Mediated devices.
diff --git a/drivers/vfio/mdev/Makefile b/drivers/vfio/mdev/Makefile
index 101516fdf3753e..ff9ecd80212503 100644
--- a/drivers/vfio/mdev/Makefile
+++ b/drivers/vfio/mdev/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-mdev-y := mdev_core.o mdev_sysfs.o mdev_driver.o
+mdev-y := mdev_core.o mdev_sysfs.o mdev_driver.o vfio_mdev.o
 
 obj-$(CONFIG_VFIO_MDEV) += mdev.o
-obj-$(CONFIG_VFIO_MDEV_DEVICE) += vfio_mdev.o
diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 2a85d6fcb7ddd0..ff8c1a84516698 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -360,11 +360,24 @@ int mdev_device_remove(struct mdev_device *mdev)
 
 static int __init mdev_init(void)
 {
-	return mdev_bus_register();
+	int rc;
+
+	rc = mdev_bus_register();
+	if (rc)
+		return rc;
+	rc = mdev_register_driver(&vfio_mdev_driver);
+	if (rc)
+		goto err_bus;
+	return 0;
+err_bus:
+	mdev_bus_unregister();
+	return rc;
 }
 
 static void __exit mdev_exit(void)
 {
+	mdev_unregister_driver(&vfio_mdev_driver);
+
 	if (mdev_bus_compat_class)
 		class_compat_unregister(mdev_bus_compat_class);
 
@@ -378,4 +391,3 @@ MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_SOFTDEP("post: vfio_mdev");
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index a656cfe0346c33..5461b67582289f 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -37,6 +37,8 @@ struct mdev_type {
 #define to_mdev_type(_kobj)		\
 	container_of(_kobj, struct mdev_type, kobj)
 
+extern struct mdev_driver vfio_mdev_driver;
+
 int  parent_create_sysfs_files(struct mdev_parent *parent);
 void parent_remove_sysfs_files(struct mdev_parent *parent);
 
diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.c
index 922729071c5a8e..d5b4eede47c1a5 100644
--- a/drivers/vfio/mdev/vfio_mdev.c
+++ b/drivers/vfio/mdev/vfio_mdev.c
@@ -17,10 +17,6 @@
 
 #include "mdev_private.h"
 
-#define DRIVER_VERSION  "0.1"
-#define DRIVER_AUTHOR   "NVIDIA Corporation"
-#define DRIVER_DESC     "VFIO based driver for Mediated device"
-
 static int vfio_mdev_open(struct vfio_device *core_vdev)
 {
 	struct mdev_device *mdev = to_mdev_device(core_vdev->dev);
@@ -151,7 +147,7 @@ static void vfio_mdev_remove(struct mdev_device *mdev)
 	kfree(vdev);
 }
 
-static struct mdev_driver vfio_mdev_driver = {
+struct mdev_driver vfio_mdev_driver = {
 	.driver = {
 		.name = "vfio_mdev",
 		.owner = THIS_MODULE,
@@ -160,21 +156,3 @@ static struct mdev_driver vfio_mdev_driver = {
 	.probe	= vfio_mdev_probe,
 	.remove	= vfio_mdev_remove,
 };
-
-static int __init vfio_mdev_init(void)
-{
-	return mdev_register_driver(&vfio_mdev_driver);
-}
-
-static void __exit vfio_mdev_exit(void)
-{
-	mdev_unregister_driver(&vfio_mdev_driver);
-}
-
-module_init(vfio_mdev_init)
-module_exit(vfio_mdev_exit)
-
-MODULE_VERSION(DRIVER_VERSION);
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/samples/Kconfig b/samples/Kconfig
index e76cdfc50e257d..2a4876e2ce0d03 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -147,14 +147,14 @@ config SAMPLE_UHID
 
 config SAMPLE_VFIO_MDEV_MTTY
 	tristate "Build VFIO mtty example mediated device sample code -- loadable modules only"
-	depends on VFIO_MDEV_DEVICE && m
+	depends on VFIO_MDEV
 	help
 	  Build a virtual tty sample driver for use as a VFIO
 	  mediated device
 
 config SAMPLE_VFIO_MDEV_MDPY
 	tristate "Build VFIO mdpy example mediated device sample code -- loadable modules only"
-	depends on VFIO_MDEV_DEVICE && m
+	depends on VFIO_MDEV
 	help
 	  Build a virtual display sample driver for use as a VFIO
 	  mediated device.  It is a simple framebuffer and supports
@@ -171,7 +171,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
 
 config SAMPLE_VFIO_MDEV_MBOCHS
 	tristate "Build VFIO mdpy example mediated device sample code -- loadable modules only"
-	depends on VFIO_MDEV_DEVICE && m
+	depends on VFIO_MDEV
 	select DMA_SHARED_BUFFER
 	help
 	  Build a virtual display sample driver for use as a VFIO
-- 
2.31.1

