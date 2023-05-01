Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58754C7EE2A
	for <linux-s390@archiver.kernel.org>; Mon,  1 May 2023 17:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjEARQt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 May 2023 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjEARM7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 May 2023 13:12:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3311FF7;
        Mon,  1 May 2023 10:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUf7T5R9Ldo15YUbHNo42TFM3SpvMtsh/93CCJ3dHSGHtSikI3ak3Rb6dzQhJ1LRi0HDYbVoALFnXeLOH0AiVOdHCXzAFJjtf4D2G2Kd8pHPNGOcYdXsdMnOg2Nrgp0YjFwDhSx1poJT8cut45R7wnaZlhtIof1CxRMLXYSl/9XEvJObbFJdaGq4oqbaUG5PBCm4SgzD5J9C43saqRArCeiezlEbBrWKvmz3N7rBi/BkH7cUhzJseziNiZmVxIJOaWC9hD/pnVTIOPu+3rg9jJP1fNh23kOpUovCrApNDGhGHIjjbx+p8lV4dUETAZpW6+QrERKrEirIkWe2q6hULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnTPX2GEL/EoijGeeKv/10j/XGBhBSEbaY3WQx9+b3E=;
 b=XZ9aMF+2CeP4Lj8+Z91iyIW3KTbadvgnSGU9rJOecVMsxc2sOUEDWynuIgEnBuRMy3jciSSRgjROEruMR1MgBZQMmKDVRBWxykJn2ttjE5IskPs9WwaWzU11z28NjTBXcBehQ9m56CZsxUoiOLHOLz+U9XG7hoMluTx4DOhOJOVa0RrxzGYtn8O4cyvQ+i56qGFEm3B7Pi/lcd/+oNZiN/Nlyhbpabjdfh958OMUvNILLxM2v5zbeYj1vwLzlDaSP+RlFf/uoL++2uax2arok8h3YIqVc7hNWUazMyK6EjxbhNSMm0LwPSGcCoZDj2mm0RlnXf3LuSK0qftkLBeVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnTPX2GEL/EoijGeeKv/10j/XGBhBSEbaY3WQx9+b3E=;
 b=fweM/JY7Dda132lSKbLguUtAytEXwYsogpFrIzkBbc/TSfQdNS2cFRizaRj8AombEv8WfhqNAREcnuR+AVt2fEwtfOEEtv4vYW2NYwjIpJZSysqvBlADBlsgwYEqkYWQAKM7+q0forkLnYYPOBEosuRqPLzFys/P43PJuSgsDItpoOS+austk9qdvKsOQvHkwd5ACgBhgZ6kk4ZbU3EdpKUUzDHbVzKyZucFhWxzRVl/A+9c13Ai9+g/6ru4l3TwLEbeM+loOssh5/BVc5FGxBHL2Xyu6WDYqloQN7CZgaCMCARa2gi8iOcPHUonbcHkPcKf9dTw0Rh6twbng1QM4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Mon, 1 May
 2023 17:11:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 17:11:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev,
        Jason Herne <jjherne@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Cc:     Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2] iommu/s390: Get rid of S390_CCW_IOMMU and S390_AP_IOMMU
Date:   Mon,  1 May 2023 14:11:28 -0300
Message-Id: <0-v2-eb322ce2e547+188f-rm_iommu_ccw_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: ef180209-0710-45db-4a96-08db4a671b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVfLTrlx3irBghT/gyo2V0guyRaBbRdsxIzt1+ihqbpezYJWmUW3G0X2vxd6hEKiky4LVpiJsuft//Kf/mxP2+DFd5UY0kOpWuvZEdhlewUMMWl4cVJo9FZSsp8nFAzGHf58xR8wDQHTfhYE7I0zOKEvoGFwmIJ9lD+48kMzwHFYVLGtFX91VXXkqKN0wnYoOHMyvO9LvkkKHIzrAmW5frCY2fWKZO8KvrbylE20mRnZclHgVUS9tMA0T9qIKUS6hNJXNTbjlHIHPZ6Fxc5vHtQQ0MPxklmZIvI+jz28lAkHsQrIbysZSGavstB7EPplli80xz3GaOHEfzbrld4CW/TU+2js9WgBetfTJCNw3tzRE4pxbuu5durZp0WQjroPMfiYLdG+fWB7Db6tam75C4o4hp6QO1V3aPx85XBaEpaL5c4mby9BMDliZXFxGymJOEwXavdeiJAr6qhpLcuSlIPM0EQwMLIstXdLraX941xBoOosx30h5WX5HxZSqWEz4b+tDcDRrn3U5JUT5eY3Aszrv5XvlgfK/ebiPIB7Tx88Mg0qpFjXZaIRjuRyeAN/7t6qDw+Bv9TuizTVVKoL4KBglBc/f8A/n0X88x0nJNTWh49/hN9hmjD+bx4SDL/XfFh+6DHDanAAvvALZ2TAuzY+byUIMn7X6p1D7IllR19UQI7Xhu+k7uzwoVGgAk+0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(6512007)(186003)(6506007)(26005)(7416002)(2906002)(83380400001)(966005)(6486002)(5660300002)(2616005)(478600001)(38100700002)(8676002)(316002)(921005)(8936002)(66476007)(4326008)(66946007)(86362001)(66556008)(41300700001)(36756003)(110136005)(26583001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JZmy06w4TgoKvD2Oj9LFxX1FsjrECVYtdM+XKHeGOTxf2rB1wQiqwU3Pgs0d?=
 =?us-ascii?Q?+DCS+tUptdpmc/rqyVwMzZmKUnGrjdhtEfUaXjNCCMqzrRvPLukG3+lk7s4H?=
 =?us-ascii?Q?mlQJhA5iXNd7EML1TRmFFluvPp70hLCYNR8mHQfU58apSVsD7cdQpCVC5hF9?=
 =?us-ascii?Q?hazsFdga2C7mLbTA3rtP3UFzE2ktKYIJ4XfcA3mhVDK+fsRCFRzBnclmYxhi?=
 =?us-ascii?Q?ClcLjYjUNZLrgGve8syL2OTxgIol94vFsyyj9845aur1ehcIXMLWfstKsikR?=
 =?us-ascii?Q?7cSsGAdDcMe/VT+BsG1HNJD9amO9nADyAsKdTRHgk8mRCMhFaJTrPnsTqc/8?=
 =?us-ascii?Q?4caXTe4hAdDgo18lHeXblRp9T4HsMCW8y0QOlqAkYyp2yGbbDmju1Zkt76YC?=
 =?us-ascii?Q?Xp5BmYVlolkWFdmx0k/3MR2BhA4iHazKDfllYVEXB7wXTBuOKTf5K9yAQLyj?=
 =?us-ascii?Q?qqyCl1IrTY6qwaP6f9fxzarWqX5gC5GHYaMTXDgjpgpR9Qbbx6HqrO2+F52u?=
 =?us-ascii?Q?CrZRqLYhnEcxsId6kK79pTOl2IG4ndGOae3FW6Ize8syTk9orNV7uTJhgA7m?=
 =?us-ascii?Q?9RmsPSvI49ZrcBFw5+H1mqsKq4ji1LhZFHVFNItc/trg5V/iCJ8BKtnu4ORR?=
 =?us-ascii?Q?Lb6GetAPfUNJbUEqGQKEemKMaGov5et/hAyEfd0pWD4y5onPxmx3c0MuJNnw?=
 =?us-ascii?Q?Cz3aHMusnAcfT4M7RjKj7x5owk4Y+0z2Ah51NgeUH3MlEv1UpGtRNzhueFpp?=
 =?us-ascii?Q?G/C13S0xnc+mSWv4zTlb8DpHxqHaqSiobcS22/oQMFAVgJOjECWmhvSdAOii?=
 =?us-ascii?Q?WBY2h2qeEW1YWFIEMknhuLfPLiEiUNdC5T+kOwKjl+vCfMdhTE0SUQUwNcgq?=
 =?us-ascii?Q?EgddsToBmsXNaEiTG0e7YVFKrUPcYhXbmfUkJ0sdvPstIaJgPTLv3W2RzbZH?=
 =?us-ascii?Q?sscU1DIQIqleWcCOIrQMx6VAZ7DIBSR+1df2ebj0u3qCK3DjgV3x4VZY02mn?=
 =?us-ascii?Q?McYwZq4M8DczBRnkmQQoWd/YcrEZhq2tTnnajY5l1T6Tp0dsDOyCw2B9oZSZ?=
 =?us-ascii?Q?99KiffQespiE1T3X8DdGLjRR5f2K211brKX5UsfBbRsXYlE+GFUhmnV7hJqS?=
 =?us-ascii?Q?p6eIOQeJmviIZh5G8dVpMFmSgOH4chuwzX9hwxXljtJ8QObfUMoJGWGYCZO1?=
 =?us-ascii?Q?NZ5mBSiJGWHctRuLau/VEJ4KLlv0xh7uR15ItbtbYSUzHXEFW2uf3dAbG49Z?=
 =?us-ascii?Q?5ytme/gLa1EUm4BLbzxDLS7+sDvzJG/ZJdiTds4J9GesmzU1gzbsjQ+q14Rh?=
 =?us-ascii?Q?3Xs3jisjSIPlEn+qZlO0fiO8NRlxA7zMHFSO+JRiZfRYvgxYmQvAHS5Oa4YQ?=
 =?us-ascii?Q?cNR+MmUq4DWh81ZUyB7Nq1KIbBdGkv/boyk7XMxbbrbxrHU4A+fhGZQLcFay?=
 =?us-ascii?Q?cJrYa3/zagVBjACQx4p6FRFjKIgI6snfHO0h/OsDikwdZv6zvIPsu8YPKBpD?=
 =?us-ascii?Q?CV8k0Y+E/sMtvaMjSFIHjKeXEbioERXYZlVKKQ/NURuMghUfgrnptbAXV1vQ?=
 =?us-ascii?Q?aB8Fu4eFmBtRcVTlcm5CQx9PmrhEiK+C6/akqWrM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef180209-0710-45db-4a96-08db4a671b07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 17:11:30.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK2LqjwA7Xbtz3nOmig6hKouVMxeJRTBeAeIz4d2uQrJasMxoXCOu9I4Z7JYgTTq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These don't do anything anymore, the only user of the symbol was
VFIO_CCW/AP which already "depends on VFIO" and VFIO itself selects
IOMMU_API.

When this was added VFIO was wrongly doing "depends on IOMMU_API" which
required some contortions like this to ensure IOMMU_API was turned on.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/s390/vfio-ap.rst    |  1 -
 arch/s390/Kconfig                 |  3 +--
 arch/s390/configs/debug_defconfig |  2 --
 arch/s390/configs/defconfig       |  2 --
 drivers/iommu/Kconfig             | 16 ----------------
 5 files changed, 1 insertion(+), 23 deletions(-)

v2:
 - Include S390_AP_IOMMU too
v1: https://lore.kernel.org/r/0-v1-11a50d289ac9+b6-rm_iommu_ccw_jgg@nvidia.com

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index d46e98c7c1ec6c..bb3f4c4e288563 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -551,7 +551,6 @@ These are the steps:
    * IOMMU_SUPPORT
    * S390
    * ZCRYPT
-   * S390_AP_IOMMU
    * VFIO
    * KVM
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9809c74e124060..fe3c639d86e002 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -714,7 +714,6 @@ config EADM_SCH
 config VFIO_CCW
 	def_tristate n
 	prompt "Support for VFIO-CCW subchannels"
-	depends on S390_CCW_IOMMU
 	depends on VFIO
 	select VFIO_MDEV
 	help
@@ -726,7 +725,7 @@ config VFIO_CCW
 config VFIO_AP
 	def_tristate n
 	prompt "VFIO support for AP devices"
-	depends on S390_AP_IOMMU && KVM
+	depends on KVM
 	depends on VFIO
 	depends on ZCRYPT
 	select VFIO_MDEV
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 4ccf66d29fc24b..311d78e01c35d3 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -591,8 +591,6 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-CONFIG_S390_CCW_IOMMU=y
-CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 693297a2e89733..b9b86a3a6cff5f 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -580,8 +580,6 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-CONFIG_S390_CCW_IOMMU=y
-CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index db98c3f86e8c8b..6de900776e24a6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -417,22 +417,6 @@ config S390_IOMMU
 	help
 	  Support for the IOMMU API for s390 PCI devices.
 
-config S390_CCW_IOMMU
-	bool "S390 CCW IOMMU Support"
-	depends on S390 && CCW || COMPILE_TEST
-	select IOMMU_API
-	help
-	  Enables bits of IOMMU API required by VFIO. The iommu_ops
-	  is not implemented as it is not necessary for VFIO.
-
-config S390_AP_IOMMU
-	bool "S390 AP IOMMU Support"
-	depends on S390 && ZCRYPT || COMPILE_TEST
-	select IOMMU_API
-	help
-	  Enables bits of IOMMU API required by VFIO. The iommu_ops
-	  is not implemented as it is not necessary for VFIO.
-
 config MTK_IOMMU
 	tristate "MediaTek IOMMU Support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST

base-commit: 70c9fe047a3db21c3d6e0b4cd957fd91c57477fe
-- 
2.40.0

