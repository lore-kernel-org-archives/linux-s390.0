Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950E0C43600
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A44B61359
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhDZUBH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:01:07 -0400
Received: from mail-bn8nam08on2069.outbound.protection.outlook.com ([40.107.100.69]:56800
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241757AbhDZUBG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 16:01:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLQYf+3jFSQF4QjoNzzgCDV5n/hcNF7XHkmlqBqUptjyfP/ICJZIZjXLrEA7g4Vju/SzzdkRO1+Ep8qOSxwczrh9ChDVErCpJMxiDCegvKF/aKvCZxJ8lOZaS24vQJpOoOv9a9kbI1rVvryZPBg7J7lq5o15SBbCNHNPU5Pvs9VH+EGtSSAMNx7i7bR9Ln4lQdcJImBN4ZLibZfZ7VQlQ4ZGf9q4MH4GRo6mRSMCzPr03jSzC1u6Sw21P5jsWTaRnAIaXucL7o0PtfXY9ZwjVrws3QUlXoyePGH7TuEcV+dxZz8axXs+FWH5/cq3FFp5fLFXfII6LKFL8HHLwY/vRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRUOyw85rUvntsIA8YBfjKhoP8KjC1J1t4oMZ49piHc=;
 b=cSsN+y4spjZvs59y3pjRzeGIrFcLDwkLFlRa+K5A8tM1ubb+1ZwFlhAvIHc65Ws//tO833r4nj/Vni+Vw4K/5v1KCHtgT6+HCRLiLgWLPW/oTG3NJGbDW7lBA0lEj0t0ozVWeRS3q9wLmEAvrIuXxrmXc4zEbFnn/bqJTs1I5WFrrc0Wunj8icrb5Hk+p5HgA3G7XUXMvAKQ/gN7zLjT9V4pt9Fd9Lr5rMDuRSS/+/wsr6lo2dFYqa82o9zXnYO6HGVYmNxtFIxE0/ttMOYDchfaY6vKo61YpjYwySoRysNTOyek+vFo+H+omuYUsx7K7QfC2Q1I3oj1A+FmkXmA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRUOyw85rUvntsIA8YBfjKhoP8KjC1J1t4oMZ49piHc=;
 b=fHXFdENpl9zBnjC8QtqYL7DbX+G9SsvGpg2D0uG+ylkUFk33EHty/E7jqMjmEtQEBROe6nVvBBl8NSTaGj1bM5bJgjjfOiRfPOOiKdZXztD0JPRfmzl8V/tZmEehFezEs/yeqRJcMi82zHJFVI+Ks+3mXt8EcC/MNdEyji8Am//jGLzaG8APpzui2n1XgR7fC6KartYJ7k560MbSazjs5Nd46DEYfNDucPoQYYTCIKPrtniSVjgTE611nWgw7luUHIpfMaELQ3khBViifm2JxNUI1NcpMnMAN/S9+PYVcSc0qYmMkISwrjyvz6otAAdA/GQP5mqgOs10LCHYvq+qfA==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 20:00:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 20:00:18 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
Subject: [PATCH v2 06/13] vfio/ap_ops: Convert to use vfio_register_group_dev()
Date:   Mon, 26 Apr 2021 17:00:08 -0300
Message-Id: <6-v2-7667f42c9bad+935-vfio3_jgg@nvidia.com>
In-Reply-To: <0-v2-7667f42c9bad+935-vfio3_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:208:23e::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Mon, 26 Apr 2021 20:00:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lb7Ox-00DFZL-Vm; Mon, 26 Apr 2021 17:00:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522d2a1e-e612-45b2-5fcd-08d908ede9a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37404594DC0AAC547A311B6EC2429@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7j+5tXmdD+B4y2cGK2B8f/6HMJUS6NLQzfz8Q2TQI9hwfuzglmORIV+Ohjw+zBjxeLh4T82+VxGw1spMv9R6EnJokFY0FULQTDa7CpbN7Z7hYYeQ8RTFkJvSqTQwnstXyDrvV/NARqyhfMboMFpubKqGOsJBbpjdDD89cy4CfESB0aek1D/eaUciGYCFprDG6ER9ocIereg2KW/5znolSAqycQAjwzzJ81kj1aCVC75rOSLdDUTygVEmFdiMWCSirVq3je8gXMEck9E2n6acmvY87Z9okT1QuwchwUYVOJHwSChIeGCiRo6bJYFrH8SWdUKi2qCc6FtqXElQUsM3yR4Du/puLrUkb5vi+24PBGjWFgx74i88aHygKo9JvXZwoM+/yvCdI5DkSd0F8prf9f0hOj5fh0iicj04jUX7aQywwVO2RRtkWAg6uvE50RCWiqWfHJfB6YV1yDXl4HePswM26VP1I9h8HW3kD75nSJU9HEWXdp7jyn+LY9KDc1QvLgYp1qg4i/BQWgb32SXuJl08Fw9bNkr+5B3j3wV8fa20A5ZMOqgWQWxt/qNyAMyjPaZVXm5m5Hxa6AzLCq1PP5629XgR+1q6sWawHJTn1nNt7Mm0oyZvPwnAmuB0BxxlpTjHgoINZiGb1kruIRIWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(66476007)(66556008)(9746002)(54906003)(426003)(110136005)(107886003)(186003)(26005)(6666004)(36756003)(316002)(2906002)(30864003)(2616005)(478600001)(9786002)(8936002)(83380400001)(38100700002)(86362001)(8676002)(5660300002)(7416002)(4326008)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nXKZcrgpVZdpnNNMQmlpEdhWLbNARQZiUJY1d9GbGFXB/ojjus3e5zwNLv6t?=
 =?us-ascii?Q?l9476yVaWfXdVrH23HDB/8PbOGbF6CrlRFiBXbHTxAwse/Y9b7dSOA0jpg+o?=
 =?us-ascii?Q?EuDjASGMjrXoa1IvPGi+Lap0SomMF2Ar/+et82yqSdqGDBYgK/HcqM2GzUrd?=
 =?us-ascii?Q?53tSJ3XHG2LbOmZYirx4dOAiGU9RXMNrnImg/5AaiR00g2Df1jIId686vTTi?=
 =?us-ascii?Q?qeT0hj0cl7v52b2ZLN+tWGjj/QGPPykiaNr9+qf3XjE5L+Bo0dtI5eYzNGrG?=
 =?us-ascii?Q?fk7dkjxyOqPtFG9ESeobKm9EaZAPxVViUerkPitWrGFVpcJdQmZmLJRs2LMp?=
 =?us-ascii?Q?U7Ji9wNDS9SkdhxqutmUBePCuyvMzsIia+fqDvZ3eRAzMUeBKMDl+wwGh8l4?=
 =?us-ascii?Q?Ztia3xBS89xH9yXlCqIp0wpvOmJWp191qqcv5drBEnAz5553wDpzv8MzJzmF?=
 =?us-ascii?Q?PQTue7lteuFi7vwsfhz1yGbgWpbtuwXCcniTcNKGq93Wl7KxWPCa7bZCaW0O?=
 =?us-ascii?Q?EbXt+xhvOhqL4WUWPvf+Zy0xNU9Ze8QoSkGml5qz0KPdqd8NtjcEMlJ0XR3J?=
 =?us-ascii?Q?QZ13mD5Xs3fyx96HkS9fMs4ET4K3T+0gC/AHxutLna7Ew04805PVMW/uOcGF?=
 =?us-ascii?Q?nN1u7u8u0NeqCOUjoq0g7TpDNnRUIsmdVWArnMQLJFVFxr7K2IPhSckkrxH+?=
 =?us-ascii?Q?0gtpQ138RE3JCC0sseLdPnViudGixM+OA10DLVVO3bdm5LI3qzrsmyL6oM65?=
 =?us-ascii?Q?nCT6rjhlW57P4xfMRLQ4Gin2WHeApvOeW1LVbedjWjJ2jAN6QvptIgOfzEo5?=
 =?us-ascii?Q?jELnY3NB6W4bGj/uDB4ejPVuJviIyXEyzfjzlSGO1Px8LTvBLitb31chZzvz?=
 =?us-ascii?Q?puU+9gKs3rzpZgYVEXDDxGi7CCZgx/he9wqHcrF7PnUmi9xLwt3n7e/f7Ua0?=
 =?us-ascii?Q?XgEzpLQHO2qatdGlcRF+dDnH5PAjT0YK0W+4gKNmwZX+vcHY52RSzWaj+SNd?=
 =?us-ascii?Q?uZkJHvOozHO0qlt7jpi5aypQVdflXqzu0+36iDPaYLIpU5G1aPnkEVr9yb2a?=
 =?us-ascii?Q?sozPjciaTdwc5VSTqEPXQlDB8a9EqduuoveozoUMlgzFELUrQvFNbE+Ts0zG?=
 =?us-ascii?Q?UjR7eCszjnzGsGOoojiHPjwiUP4ZFj/SoANTM8y2fXuP0NcL09mu+xiyTJKg?=
 =?us-ascii?Q?S42yOLdeX1Sku0s2xsvaf3CFIKGigCma7owUBM8KNXZT/b//ItgDnBgmAQEm?=
 =?us-ascii?Q?ZUMQWvJ2tdPG34rfpG5dtTud402kqKbOQffUPNNPwpEFxLgv3NHlWeGficsl?=
 =?us-ascii?Q?NHeMlWGEd6P5U7KHN4Io1z//?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522d2a1e-e612-45b2-5fcd-08d908ede9a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 20:00:17.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0rNK8w8biTrYlGCAVULVq8jrT8zpWri1544oEUOcSQFdskVQiaD3erPSGkNjhwE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is straightforward conversion, the ap_matrix_mdev is actually serving
as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
simple container_of().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 137 ++++++++++++++++----------
 drivers/s390/crypto/vfio_ap_private.h |   2 +
 2 files changed, 89 insertions(+), 50 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0ce00c9311d378..79872c857dd522 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -24,8 +24,9 @@
 #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
 #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
 
-static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
+static const struct vfio_device_ops vfio_ap_matrix_dev_ops;
 
 static int match_apqn(struct device *dev, const void *data)
 {
@@ -322,48 +323,63 @@ static void vfio_ap_matrix_init(struct ap_config_info *info,
 	matrix->adm_max = info->apxa ? info->Nd : 15;
 }
 
-static int vfio_ap_mdev_create(struct mdev_device *mdev)
+static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev;
+	int ret;
 
 	if ((atomic_dec_if_positive(&matrix_dev->available_instances) < 0))
 		return -EPERM;
 
 	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
 	if (!matrix_mdev) {
-		atomic_inc(&matrix_dev->available_instances);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_atomic;
 	}
+	vfio_init_group_dev(&matrix_mdev->vdev, &mdev->dev,
+			    &vfio_ap_matrix_dev_ops);
 
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
-	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
 	matrix_mdev->pqap_hook.owner = THIS_MODULE;
 	mutex_lock(&matrix_dev->lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->lock);
 
+	ret = vfio_register_group_dev(&matrix_mdev->vdev);
+	if (ret)
+		goto err_list;
+	dev_set_drvdata(&mdev->dev, matrix_mdev);
 	return 0;
+
+err_list:
+	mutex_lock(&matrix_dev->lock);
+	list_del(&matrix_mdev->node);
+	mutex_unlock(&matrix_dev->lock);
+	kfree(matrix_mdev);
+err_atomic:
+	atomic_inc(&matrix_dev->available_instances);
+	return ret;
 }
 
-static int vfio_ap_mdev_remove(struct mdev_device *mdev)
+static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
 
-	if (matrix_mdev->kvm)
-		return -EBUSY;
+	/* FIXME: Remove isn't allowed to fail */
+	if (WARN_ON(matrix_mdev->kvm))
+		return;
+
+	vfio_unregister_group_dev(&matrix_mdev->vdev);
 
 	mutex_lock(&matrix_dev->lock);
-	vfio_ap_mdev_reset_queues(mdev);
+	vfio_ap_mdev_reset_queues(matrix_mdev);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->lock);
 
 	kfree(matrix_mdev);
-	mdev_set_drvdata(mdev, NULL);
 	atomic_inc(&matrix_dev->available_instances);
-
-	return 0;
 }
 
 static ssize_t name_show(struct mdev_type *mtype,
@@ -605,8 +621,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 {
 	int ret;
 	unsigned long apid;
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	/* If the guest is running, disallow assignment of adapter */
 	if (matrix_mdev->kvm)
@@ -671,8 +686,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 {
 	int ret;
 	unsigned long apid;
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	/* If the guest is running, disallow un-assignment of adapter */
 	if (matrix_mdev->kvm)
@@ -751,8 +765,7 @@ static ssize_t assign_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long apqi;
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
 	/* If the guest is running, disallow assignment of domain */
@@ -813,8 +826,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long apqi;
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	/* If the guest is running, disallow un-assignment of domain */
 	if (matrix_mdev->kvm)
@@ -857,8 +869,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long id;
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	/* If the guest is running, disallow assignment of control domain */
 	if (matrix_mdev->kvm)
@@ -906,8 +917,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long domid;
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
 	/* If the guest is running, disallow un-assignment of control domain */
@@ -936,8 +946,7 @@ static ssize_t control_domains_show(struct device *dev,
 	int nchars = 0;
 	int n;
 	char *bufpos = buf;
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 	unsigned long max_domid = matrix_mdev->matrix.adm_max;
 
 	mutex_lock(&matrix_dev->lock);
@@ -955,8 +964,7 @@ static DEVICE_ATTR_RO(control_domains);
 static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	struct mdev_device *mdev = mdev_from_dev(dev);
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 	char *bufpos = buf;
 	unsigned long apid;
 	unsigned long apqi;
@@ -1085,7 +1093,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 {
 	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
-	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
+	vfio_ap_mdev_reset_queues(matrix_mdev);
 	kvm_put_kvm(matrix_mdev->kvm);
 	matrix_mdev->kvm = NULL;
 }
@@ -1195,13 +1203,12 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q,
 	return ret;
 }
 
-static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
 {
 	int ret;
 	int rc = 0;
 	unsigned long apid, apqi;
 	struct vfio_ap_queue *q;
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
 			     matrix_mdev->matrix.apm_max + 1) {
@@ -1222,9 +1229,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 	return rc;
 }
 
-static int vfio_ap_mdev_open(struct mdev_device *mdev)
+static int vfio_ap_mdev_open(struct vfio_device *vdev)
 {
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev =
+		container_of(vdev, struct ap_matrix_mdev, vdev);
 	unsigned long events;
 	int ret;
 
@@ -1235,7 +1243,7 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
 	events = VFIO_GROUP_NOTIFY_SET_KVM;
 
-	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+	ret = vfio_register_notifier(vdev->dev, VFIO_GROUP_NOTIFY,
 				     &events, &matrix_mdev->group_notifier);
 	if (ret) {
 		module_put(THIS_MODULE);
@@ -1244,29 +1252,30 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 
 	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
 	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
-	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+	ret = vfio_register_notifier(vdev->dev, VFIO_IOMMU_NOTIFY,
 				     &events, &matrix_mdev->iommu_notifier);
 	if (!ret)
 		return ret;
 
-	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+	vfio_unregister_notifier(vdev->dev, VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	module_put(THIS_MODULE);
 	return ret;
 }
 
-static void vfio_ap_mdev_release(struct mdev_device *mdev)
+static void vfio_ap_mdev_release(struct vfio_device *vdev)
 {
-	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_mdev *matrix_mdev =
+		container_of(vdev, struct ap_matrix_mdev, vdev);
 
 	mutex_lock(&matrix_dev->lock);
 	if (matrix_mdev->kvm)
 		vfio_ap_mdev_unset_kvm(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
-	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+	vfio_unregister_notifier(vdev->dev, VFIO_IOMMU_NOTIFY,
 				 &matrix_mdev->iommu_notifier);
-	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+	vfio_unregister_notifier(vdev->dev, VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	module_put(THIS_MODULE);
 }
@@ -1291,9 +1300,11 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 }
 
-static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
+static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 				    unsigned int cmd, unsigned long arg)
 {
+	struct ap_matrix_mdev *matrix_mdev =
+		container_of(vdev, struct ap_matrix_mdev, vdev);
 	int ret;
 
 	mutex_lock(&matrix_dev->lock);
@@ -1302,7 +1313,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
 	case VFIO_DEVICE_RESET:
-		ret = vfio_ap_mdev_reset_queues(mdev);
+		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -1313,25 +1324,51 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 	return ret;
 }
 
+static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
+	.open = vfio_ap_mdev_open,
+	.release = vfio_ap_mdev_release,
+	.ioctl = vfio_ap_mdev_ioctl,
+};
+
+static struct mdev_driver vfio_ap_matrix_driver = {
+	.driver = {
+		.name = "vfio_ap_mdev",
+		.owner = THIS_MODULE,
+		.mod_name = KBUILD_MODNAME,
+		.dev_groups = vfio_ap_mdev_attr_groups,
+	},
+	.probe = vfio_ap_mdev_probe,
+	.remove = vfio_ap_mdev_remove,
+};
+
 static const struct mdev_parent_ops vfio_ap_matrix_ops = {
 	.owner			= THIS_MODULE,
+	.device_driver		= &vfio_ap_matrix_driver,
 	.supported_type_groups	= vfio_ap_mdev_type_groups,
-	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
-	.create			= vfio_ap_mdev_create,
-	.remove			= vfio_ap_mdev_remove,
-	.open			= vfio_ap_mdev_open,
-	.release		= vfio_ap_mdev_release,
-	.ioctl			= vfio_ap_mdev_ioctl,
 };
 
 int vfio_ap_mdev_register(void)
 {
+	int ret;
+
 	atomic_set(&matrix_dev->available_instances, MAX_ZDEV_ENTRIES_EXT);
 
-	return mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
+	ret = mdev_register_driver(&vfio_ap_matrix_driver);
+	if (ret)
+		return ret;
+
+	ret = mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
+	if (ret)
+		goto err_driver;
+	return 0;
+
+err_driver:
+	mdev_unregister_driver(&vfio_ap_matrix_driver);
+	return ret;
 }
 
 void vfio_ap_mdev_unregister(void)
 {
 	mdev_unregister_device(&matrix_dev->device);
+	mdev_unregister_driver(&vfio_ap_matrix_driver);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 28e9d998976820..b95ba674f60b1b 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/kvm_host.h>
+#include <linux/vfio.h>
 
 #include "ap_bus.h"
 
@@ -79,6 +80,7 @@ struct ap_matrix {
  * @kvm:	the struct holding guest's state
  */
 struct ap_matrix_mdev {
+	struct vfio_device vdev;
 	struct list_head node;
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
-- 
2.31.1

