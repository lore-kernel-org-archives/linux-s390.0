Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E0C433B4
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 23:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46C461462
	for <linux-s390@archiver.kernel.org>; Fri, 23 Apr 2021 23:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhDWXDy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Apr 2021 19:03:54 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:47680
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232283AbhDWXDw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Apr 2021 19:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZVazw684n6Y8+6tl2aRgknSUvUyJ1MyVZV3XLZQOhhqbwKGRzVdkoUmtEXTEA9Deqws57vhZTzxuqss2GqBIeM22+oE6P/KJk4Ib35E8DMwluxKD3jIFcYtEioZPYwyAzX3p3nvtmk62FobW5SHXFLkutU+Vgh0tulksAWgJxK5YRgXyOucRXaDD0xryxT+fkz9NY1zCJuU7JmN2TNvfnBVQCgarvxoWF4JucjJv0zYUIg+MdkpqkkpPZkycvlFjEyN5WUOjxGQXgzq5DXqzW0Im4tkEVYmBfUefUxAO+YjEd00iSSl3iBUGDD3BSU+lqGVbYmCTPoZ1WSktB6cJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTCL0TSU54JoBKb1yW+dCDhDe9Z7aHxsQBl4QZPK6yg=;
 b=cJVD66P/LbGwWhc9d3CsdTFZluKE6LWakI3ADB9oE6yRtYQp1NRMbMC1WsLsWwH/IlUjOsJBKk4e5KhI/r3m1kskduXEeUP0SkVo+OkgF+U5Ve2WZZGH+LhhBxjvUkSt/qBPKVUr/djz8n3pNWmtcz+TB5NqkrQoJT6t+HzzLE0yR+Atj7tFK996Xhx+0lVbbjjTOHz8MTG8nssgKkSm2CvoeAgdqt3jPjVxE149hATVNLTWDXWUYOOUynjwDWGkI2RpvfiWFD85/IrD7eUm2AI0wuSplu4XmMP6wsi6dpYjvOFvSwnWJ10CbaqAv0tABwxAyMiacoJKQK10sPSQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTCL0TSU54JoBKb1yW+dCDhDe9Z7aHxsQBl4QZPK6yg=;
 b=bjNGJkL3sxC/Z3fqCCB6+uptM66pTykbc8PlG1d4/70iO+CCmRdP2w0YLj2S09Jb7g6ZwJNf5epTJ2PnlLi0Y/4E9wfK3eoPmfKIDE281h95OZacr1zPOnWrtcFIZ4uiw3UGTPEErvox4n1CBAlRsLjDq+eKgOb0d+9LF37mXMOMq5F01WMr0PB4EC5rh7W9ZqbTrv8PD2UYCpAos0pgsPevMNHJE3NnoPCHByT4WwfoR6BJA9HsOPF7SmM0Ht5VxyT0mnzkIo0/0Qan16C9AjCDQkXNgVwqX8NSx6RCgVA5SuLAv6Bq+27b4+lg0sQ7ARg/ttWrjsmlgXRUhXjwQw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 23:03:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 23:03:12 +0000
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
Subject: [PATCH 06/12] vfio/ap_ops: Convert to use vfio_register_group_dev()
Date:   Fri, 23 Apr 2021 20:03:03 -0300
Message-Id: <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
In-Reply-To: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:208:238::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0001.namprd22.prod.outlook.com (2603:10b6:208:238::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 23:03:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1la4pK-00CHzn-62; Fri, 23 Apr 2021 20:03:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76102e89-53f5-4732-ff35-08d906abf7ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB351341103E7153FB090A3921C2459@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5Iy2w3HBJK7THh9kxQ/T7BThLJEJ+vFqi3ukQzMcfwUgIHRL5LMty25Grom/rVHtqGKUDB7UQYvbDwm5z6QrZOYGDL6uIgeFAwsHmJW/uTQpb9uTwVfljmMaNEYsFpsl3BaAQbU3YAmOxnS5VSNvYdrLvd08MugCYMTDS5U74uZp2r2UMB87oumJwCQOzoRpM3s1ycbdq1HSToWdZ/NyqedIehpDc1uvwi/BIFDgvIHbz880AA85SrSfy4LZFIzwTEzEzVodqNvOw21xKY/H86yfHdDzsUCYc9ZpW5Nd+xJXa7d8C/VBHMw1/sAiLjRKvNV/la4rmzVfJbtob50i92vNy6JDc4HbLdTmdcEbdNZoz9viRwDJBjy8zV91ePofojuxdgIGqk6UGvHcA2psIhiVGqdyoYxn9m2Cp5K5NrhMDnbeJ+3xnB3UQd9ACLxNnlMtQYscKJ5Vg9dOdekaSFOpdukAXJTtcY762Aogdq5ANFLp4jrtLU54+Ocoj1S3e2L+sthyYnqtGgH9RU+otjCsrHYl7Ga6nFSRcuc8XXAL+Fqyfunlv7KthS6NBavtXHOtG3cSZDSosFoaRWJlGrKQwMr6BCi7upoMXfehz40NRUrcGZulHBKuS1xzJDGNIFfrhbq10kq2Btqkr0DFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(36756003)(66556008)(26005)(66476007)(107886003)(426003)(8936002)(83380400001)(9786002)(5660300002)(186003)(86362001)(9746002)(54906003)(38100700002)(2616005)(316002)(8676002)(7416002)(2906002)(4326008)(110136005)(66946007)(6666004)(30864003)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iyNxcAHyUbEeOr5HrIGzGm+zS8v9F1tz/92N2exhHUJHXbXKJ9++UesbGMpO?=
 =?us-ascii?Q?q5b2VDif14kdg2xs3ReFUFky9f6y2/RPlqO/IOpitzPsUaOOP43lVFwzuObg?=
 =?us-ascii?Q?M4b1HRBQKOVYg9rU0IqDgZOEoKilMpMdKN2+y3Y6TLzMPZWQWjab2KE79T4Z?=
 =?us-ascii?Q?m9ciCqA3PramU8a791S9HRF83HpT3dK1HjhaUVQBr59akp9GykMxCxPFQCx/?=
 =?us-ascii?Q?BtRbr2souMYg6Gi/VuCCyFDhAEqaDLdqkAM0dXFFZe8pLDJ1DN8h9hJATKa/?=
 =?us-ascii?Q?X62YI+EudiD7gzNFlCprjM9C2tY57T0ipML8vmUZK/RqiKAI0D2HX+KGjC/S?=
 =?us-ascii?Q?kCKhLqcoCCkFbHpIBqcQzKNxQne5vIhNUtpf+YOloLXcOLO3jjzGuOqzXu81?=
 =?us-ascii?Q?ZIDJQQG25jccPdY2wxGr3uarVA2sLxJfDwXPxzh6V+FM3U9RNhG1rV62yLCO?=
 =?us-ascii?Q?USa7GC94z9Ba9tAQZR6wYoBxZcvvAhDngmJyY0RS7Q4aHQV1ISScGPEBcWKl?=
 =?us-ascii?Q?KWBcTAVseLlj+vsHgwxjjBJFaEN+MDUAJ7BlfDeRxAPo/o42aimErPBkMC71?=
 =?us-ascii?Q?A/AmoIjVaTL/ABhMhWhesoP2Xdo1RU/ADo6G3f2pH44n2CM902W8E7+psz0B?=
 =?us-ascii?Q?YtVAX3Cs3Ne94v3trjQK15nvBwEYy0JOEEKPOiGDaAvQCYvSBa9PT9Xalbcp?=
 =?us-ascii?Q?RdjVCmPqbAOjkWzwaUS4xvcZmUtSP8OHT0fLLW8/5nUaX6cryDZMBk2geOIU?=
 =?us-ascii?Q?BSzmbzDQbralc/gqCw7qghr6cwcHQ+j/pMobO+Eop+Cmzv+O0/z4Z90I+Xsh?=
 =?us-ascii?Q?q9ZPwDzwp8emf1pFp33rXnTvUmJm9FdIH0eQUIgllA2ZXt38fuVvluYpu1Ca?=
 =?us-ascii?Q?eLov+acEWaaTq1mXJRplrFBIjlBG8Znh3I2KAlfTbBSmW52vsIvtnm/fVC9h?=
 =?us-ascii?Q?L6NBLcjZDzsXxUP+LqidK5ki/oZ47JtLWDmd0TsOZPPfNqqgOHOnzf/YG3JO?=
 =?us-ascii?Q?9MJOEZi5Ma50LYmBXrtmeiXod0ir3zhVMmCwlEHNHaoXhkFpCUpiU1+docW6?=
 =?us-ascii?Q?S/gVv/BqBBRzhvOlL20CuR0zEiPrniW3zB1PsynReoRKryFWOnef8yfJ/mHG?=
 =?us-ascii?Q?gUo8IY9JROJ03R9MdkpKDnrCBp/dVdu0/y7AyYoUMdzq2IRfsUHo8H8EZkd2?=
 =?us-ascii?Q?FT+NEIpTTa0uV5e03HA/5ypjGNlfoDSSjwwlhyl27rdejZp8Lt2wb403HeUP?=
 =?us-ascii?Q?TaeFoCOCUzMhnU0BGc+vSTd3nRM6kg+7SjcYdgJu/KJlEVQCAcxqzpXDppVA?=
 =?us-ascii?Q?rRi9q0roLH95QPY4toT9yrAn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76102e89-53f5-4732-ff35-08d906abf7ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 23:03:11.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlS8pNHdT5J5vYRoVi/FwdjhM47j3nieD2ZJyP/xmUucI0zfQ5hX2ll9NKWNkyFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is straightforward conversion, the ap_matrix_mdev is actually serving
as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
simple container_of().

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

