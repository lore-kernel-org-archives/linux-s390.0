Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341EDC77B60
	for <linux-s390@archiver.kernel.org>; Fri, 28 Apr 2023 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbjD1T2q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 28 Apr 2023 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbjD1T2p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Apr 2023 15:28:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE74EC7
        for <linux-s390@vger.kernel.org>; Fri, 28 Apr 2023 12:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKiDjvfiBjckBu5TZo7A5mv2pOd+35OA/+VAuZak3y/TbjfNIfSH3hR08hb7pM3CrjQV3c/RBSf/XKPADhOALHnznOqPxtBp2fqKEIz9lBI4Dqtcez/GgJy44zTrgIGiTBOsSUF09q9k1pegi8Hn0pvFaZ6U8EdLvYhc0OBR4pEEfpIx9zD7+cKlM7c8WNp8z0wp/hxQ9Sq6TomjYIKr652YrBwWYWi1ZuqvtYfsbKS26NwA1I5/9oD5+4SHjL+sdKA3G8KRKbXwYJHvUK5oKBj1a/KEj7UvrudJ6UhzHF9isDLIkgHxS4aNfTJoi/WBEmJ/ohqoWfr/ygKNwYDhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LDJsjdpw+bo+m7xkj3F74O0/31CNvM1ky7Gl9j1SI8=;
 b=buM0ot0xuENTv78JwB/LGDcAnlN9XcxSODfbn4RaloR72M+nzAmda8hKyBxSbKEGqvMBo3ZUpOMbvnqK809vtTJ2mC8PpVJpLsRB/2csZn7F/dEriIaQ8zFXRyzaY2WTi1gfIlWM2EmdOGOKzrK5RcCePrbrllI+Iv2DYANG5E3nNXGrCOv/xkjJVYPjCbB7LPg9q/toENqn8RRKSuAG3sN9E9MniItmJDEzYLJv49jpeWlbM1jQszzM07SKcYS2EUMJNpmA0IGuPXy6IzSfkgCLGAmbNCg56KhcfraB4B510F5X0MEGoW1cJtn3qd5B0Tw4R06fdwyT/GPXrEZImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LDJsjdpw+bo+m7xkj3F74O0/31CNvM1ky7Gl9j1SI8=;
 b=aX9boPph8nvP95f0FJuW6TLC5i17QI1m0z2+r4v6riKmbEgPVbrh/ELQdrjuiT2o8qjfJa67o46A5DAsri4W/oeKGCqlqE64OvBlSzdUV7BPYQe5wtizd4CJ9HK0QK+1fgMScY9Uejx/ndp3jC3iv84PyyCalkD/5DptYPnu6O7JJre5FI77kOQajtIso21PVqBoSMq3iTqo7ogi5rY7PDcm+/lMMjTrs9ChKri15Z2iUg+Ekfwhy1lQU8ZCJ4dk5afsdqNkoTBUwcSKKKC6gqNtsQ2yuZGhMTIb04yqK2o2UHteZsj37KW4LFl2YIs4VLCYF8NBH7lKG3lCzW+aXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 19:28:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 19:28:34 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, linux-s390@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/s390: Get rid of S390_CCW_IOMMU
Date:   Fri, 28 Apr 2023 16:28:32 -0300
Message-Id: <0-v1-11a50d289ac9+b6-rm_iommu_ccw_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:208:32d::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: cec9538d-9786-4f0e-09e0-08db481ec1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5p7Adu1f9E+46mfAOSrOe8olM1crqpz0ZqAjb7ZoX9QWBgsDZb2gSorSO3NzlfgivUhUJazLDx4nbCxUs5S8JXGsg0KpL3NM9kTkWbr4rbad5/xLIvxD2OSRmhs/gGrywCknhynVQjYqXEOsFFPnVMMJeyGGg9osmEfNIUZsFGTDHEah5g/dNw7uV14RoP31h/tM/zd1/sgQGP+2IupBdtQyD+9sU8ZJDYPEpZjlXSSIbq3jPxC993fd/E37WZpFQTZmRel4xf3AmJ1l9Y6SBlbPsiI408Shv1P2bgpYmqBva2g8+NyS0zTAh9nsZ7hXsepsQvMUwK2OvUsRtfPdJa5h6rh6yzMGd+//QH5uL96cf5DqzoNZO5B260z35c4hDYeKAiGeHfAIZNdE2X6RsEIhyraTyvwLt+HHGeIjqq+KZP5Bua1EdmktFxfpM4/dxERe0Yg3biexncxcWuljZKjlnr1iF65P/DfSUC/MhGwW2IWA15q4SyakosLRiL8Gd4VwjI3a99Rw3e1/TlEuQXHWzsX+dvklRmrQjsPGGCjEHOrMWixTnO4nKxbpsBowb5eRRMAjh7Vbk7g60I4NpCqUyiKe3/Dj5wRJvGXvYtXGqj7yfvdlsWPCBDFxZLKrU/U75dWFd64eqUeCvtPwAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(8676002)(8936002)(86362001)(83380400001)(7416002)(36756003)(5660300002)(110136005)(478600001)(316002)(6486002)(66946007)(66476007)(66556008)(41300700001)(186003)(26005)(6506007)(2906002)(921005)(6512007)(26583001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxCvPBnS2WwyUYTv8APtukWKK6Jq5jNOEizybzOfHPWW+WBFguhDhUnZW7Qr?=
 =?us-ascii?Q?Ck4itz1nkW921qN/KPs20N+nRh73heGNvSxy2bWZ5q77eRiljPjTmS1D6ghQ?=
 =?us-ascii?Q?OtTJOhJ3YDW58WOsAosQJOCTp3CdrjjlJmJ8z86TvkpewdHLrhpKMqE/jICt?=
 =?us-ascii?Q?ROusXOxMFbnQXRkviNv+6C5dFNl+GfDyW45SgpVbe09566+iLtuIo4rhWtHz?=
 =?us-ascii?Q?e0p6goJ9EmUYwRTUCHHOSvR92hBDlx7Zxckg6qbQ9ILE+VsOBxJBlVB1y2C0?=
 =?us-ascii?Q?AyN4Pk5eY4jaT1/3md2Tc43sfzisS+B2jkrymvKUWiQ8/Yj7eHlZIsBnhj4O?=
 =?us-ascii?Q?+A0CUU4RRPQCO7T/sX31bs36k7Z1iHyCo1xvhN6+VlDRaFbQXbpzqkTwI4kK?=
 =?us-ascii?Q?QUayrnSuY3CnQ6Ei11nJH1WxGgFaeGTCoyeJ/8Rfk4DFDVeIRW0WTH22s4zn?=
 =?us-ascii?Q?T74pkPexDnv+SpQ0NPm5XnUQ3DomYum0oATjWRyRVnHyiC5p/xTVghxWrMrr?=
 =?us-ascii?Q?uhmnr3ocX5SpMQp+YNAtlobe0EiQBk25MbROjYfA8MF5MV1bkru0pDHHZwh7?=
 =?us-ascii?Q?W/K6HujY/zei/iF00wXt3NeNUMIVGJ2CCbdm5lAfqdyqXmMBBh6DEPbzSYIk?=
 =?us-ascii?Q?osOrTycmzY2oR1slPDYrglxKzMdpy3MIeEk/tVgp8dHG2WHfuceX8vizIaR1?=
 =?us-ascii?Q?Y8PnmBpeeOz+cpyv5rYqqxtiySxztfytZcYGYYEHoRIsWzpmmA+lpzUbHR9u?=
 =?us-ascii?Q?m+UQr28nUyk69/S7OtXaTs9DojiWT/NyoklBlvrnmCSn3lvwetLJIiktPqI0?=
 =?us-ascii?Q?jzkdP5v4b/ZkoQGEnon0GQHhUSN4Kbu812zamghTLcWbVkzwdZJRUy6EnSEw?=
 =?us-ascii?Q?5QgWQ0U7eH0j6F4jA34exon8c/b+hZMk/YBtH+LvQtXC6Us8oR0y+fFUDEv9?=
 =?us-ascii?Q?mXAfw0Oxi417ekioH/gByBJvBLQn0whvH8Ika/iaBVfXyGMO6PYc5MvjSfUX?=
 =?us-ascii?Q?T66wTekX/cBEM9/0BfGqnlwU0u7Vwd1As2G1Dg5frhCZKDHAkboqDA47wMgG?=
 =?us-ascii?Q?rtFJnUT290VVE2o6PQRaAPbefvZI241UZRKTRGScneR2RMyKQTQT/5iXtimv?=
 =?us-ascii?Q?nv12dMhS2ZBbqdqJzTIa0v4i1KtwZRVxIkfCQukhICxpmU2ukb8+T6sDM6Eg?=
 =?us-ascii?Q?ZnvHaMPWKOoMp7YMAWLQWSr4BoLC5eU8sqyirUGuZOZr6IBuBnjbbXJnJ9XE?=
 =?us-ascii?Q?tNsTt+NkT21gxbWPKRsydCgDMiQtXgkECaBDwh+SmpERO1bynqZ23HU6KGOn?=
 =?us-ascii?Q?zsKhuMZlPXK6mka001589EqvJuiR8CB9UPKzza0oay6UcLVmBRCqtX5yiZtt?=
 =?us-ascii?Q?CFP9HAeT4kpssmZkVpI95BOF1bbdKsy39Q55EpTyPgmkQsr8ZS2KzGEFGL1M?=
 =?us-ascii?Q?S6vDHVgtNHu72/sXyvWDlFM3OHDcts5lRpl/BIl1jY0l+zPTis7P1lQ/vXjP?=
 =?us-ascii?Q?03htKydz9ptkQOmqZOo/Z06jLalxygWzMIYS4JXVJ5RchLnNHkjaV7+c4E1v?=
 =?us-ascii?Q?2yYQbzxwacYPROh6qV0cpEg4LNKvL5ddnYNsMQgW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec9538d-9786-4f0e-09e0-08db481ec1a6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:28:33.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76ImkOGvjt+grLx0lR0jz3W/O1oknfXLbkI3Q/jmUO01nuR7AtHP/PdybZB6YMHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This doesn't do anything anymore, the only user of the symbol was VFIO_CCW
which already "depends on VFIO" and VFIO selects IOMMU_API.

When this was added VFIO was wrongly doing "depends on IOMMU_API" which
required some mess like this to ensure IOMMU_API was turned on.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/s390/Kconfig                 | 1 -
 arch/s390/configs/debug_defconfig | 1 -
 arch/s390/configs/defconfig       | 1 -
 drivers/iommu/Kconfig             | 8 --------
 4 files changed, 11 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9809c74e124060..9334500078f978 100644
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
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 4ccf66d29fc24b..77b886e1b867d4 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -591,7 +591,6 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 693297a2e89733..36ab9b1956245c 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -580,7 +580,6 @@ CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index db98c3f86e8c8b..b1f9d82b4ec9ae 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -417,14 +417,6 @@ config S390_IOMMU
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
 config S390_AP_IOMMU
 	bool "S390 AP IOMMU Support"
 	depends on S390 && ZCRYPT || COMPILE_TEST

base-commit: 57d60ea1868f36586c85f6f6692cf4bc49affecd
-- 
2.40.0

