Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1FEC48BD1
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71698613AD
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFKRH1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:07:27 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:62615
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230197AbhFKRH1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Jun 2021 13:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJgYYY8uU6OS2QEcahbPMs3gXAv2SH/Lq9g57JNZX7FYLAQp4Cfj3HxQpEaSWqtWoBWonVsdvo57KsjF1z/uZWYHvfI4X6cJ4VWa2zhV4CHjYQaP6ooxYB1L8dnYLVu8PIZreu3D0C1aetagaQ8IiSf8qF34PKocKUzAwuhc7+wkTNjjyi/bbA7pxkpSei5/0xk5N0rf5C+nnPzWzI7qG73igeTz0zzLputDBErbeJ+ihYbr/v1qjnCYwJ3+X1Wo2Pr/yFY+c+jlhPTAaSxCHLjLfr0FXfiL2KTHM9EkkDbBdnb7HD/qCaRjtBnc+sk0QjWFxkGVNgkAALJEoUBUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/YKdSKmbOs07BGwYbnrTmyPScH52VXSLOaUQVWdBBg=;
 b=egJ4CGcBxHXeEO6GR1Q4TuyysluPetgUIQxOkFSjUirOD3nf5Nx8Qmj+jtUyUhV19jcVUplOBWKaRLqSGUojgQBXyh3ZWpEjwxWcbST8nI5ACxSu9/cbB9bgVPEt9qUHuKjDRP+POmP6d76spPturqhsf/0MRxCKAMQiQbCQ2b3Bc1XmXMsSlejWeQQZEhiHuKPR+awkVZ6gc8CvA4/0j3S+qu1BMFyZhsY0fvsP3vZrJO9ogRL6SGCYEkXjMoTjX51yg2LsOwzGYu3T2kqC2ergOei5sHedjFJm82hrRLIc2m5U7kVNk6+dlVLCujlcc4PTJ3JaFn4ImJxn92juSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/YKdSKmbOs07BGwYbnrTmyPScH52VXSLOaUQVWdBBg=;
 b=Tn3WpQI9ao440VHNbud9r+gcgL41cbneiLZCjksqtkoGEvdpCvRkhE2BJhmiaKyEyq9bnsWcB4H+xQx/IYTHPBtBYHNPCPb24CMMajhXOuol6XfISaiyrx6/5Wa2yVNyAEdCQsW945BeifsQCYJv6R7meoJM5O5GlwgvScGujftiKRLvhvFRezVbMrRTr8di3QOMFPSGUL4XgEMDXLiIfLvb08VAVi9rURjY7XWwApgGYIBqRyz6PGgtyoLI0zuJpYF8+cFvBCahVqqQp0L4RQNGSv+vawB2H5czxaCE7/M9OXhMJhig+76igtZNbRylBdGpd2GLsSBYa1D1Qc+3qA==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 11 Jun
 2021 17:05:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 17:05:27 +0000
Date:   Fri, 11 Jun 2021 14:05:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 2/3] s390/vfio-ap: introduce two new r/w locks to replace
 wait_queue_head_t
Message-ID: <20210611170526.GU1002214@nvidia.com>
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609224634.575156-3-akrowiak@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:208:329::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 17:05:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrkb0-005h4W-84; Fri, 11 Jun 2021 14:05:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e507c5f-1ff0-4e65-8da5-08d92cfb1c2d
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5554B1CE2EADE908779C607BC2349@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7LXBVwnXJIvxid5eFpU88NfAxH28t4F2FDRL71yf1sPUzO7z+6InAtpA4DxKU0IPwys5Eue4fybBpK8WWg4bdOpgtYQTpgQ9bKJKrkNWBRMV3sQkcRBC4OrIqloZbvq3/07EUkqW0jDJ0VcoBOPV7fJGZUl+YolgGwJde+JcwpTwXrMzUbtQNuqoC0svSJFqHqR/bolBNsHMWhgXax/j3HyGtGU4FhBOU8RKGGEwcfBUUG3fuS9crUr5UTt8ERzUVyysriZympLa52l3V0qx2Rb9tH3teJboOVMjkn6CopZZXdHN0KHd55ll+rR6DnYQv4XTxQ+qLudRFCgTECYfaWGK0FOYSFr3eTk4ERZlIU78SoTDY80UuDYi8c5F9pZvSwrJrZXsmbSk59uDg8kS+QWSMuLI7Yb3IhFr6dlklTgYDaZxSptlzDH0ILwxd+Qb4vkzj2cXA8H1O9vLKWRhyy1dE0X2mn84rP9u88ZwalhhIq+UyWxxNzS1gM7TOKoZutCks+eLjBv3at+bjk3IUXMR2CUb1iIGXLAb6BcV5KjePO0+rUaH/uqP4TR1heXbgylwNKUBuN8vJR1rhMzmUhza5EpG0VisZ+GM2fAAIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(6916009)(8936002)(38100700002)(316002)(36756003)(4326008)(186003)(26005)(83380400001)(8676002)(1076003)(66556008)(66476007)(66946007)(478600001)(33656002)(86362001)(2906002)(2616005)(7416002)(9786002)(5660300002)(9746002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0frug7PN//eRkPS0q/f8zTEO3PbC2XKm4DZoQYVY/hj8ANBtnrUr7jlKpKHp?=
 =?us-ascii?Q?MmJKoAYIRp059fFpH2Iuoh7fwuu0nlK8Cyr5DfO1mMEar+2xsZuu/9cdJMDa?=
 =?us-ascii?Q?bFzMknlvt9/52zQOuQ/DsTIy1bJGcu45BjxW6HXztU8g682Bz1ylcZTArwuu?=
 =?us-ascii?Q?s9v0RAe5RurGNcYmg30ulabIj2oCNn4UgHjaxKvJywRFdNh7cWa84yecWdQg?=
 =?us-ascii?Q?uD0m8EhyH9n1ZG3slphshv4dyFOWqBEAQSL1PtQBzIFObHpJy1oF7mWsuU1M?=
 =?us-ascii?Q?DWzZTp01+se6zABC/1jSkpNolM86vZhEu/1t4Ge3mE4qWAFntiXptTidbhjv?=
 =?us-ascii?Q?OrinURaHa8g8v/G+uXDyJLnflTzRzPfP0ao7GdB/YuUNfUn5m51iUZ8ofXyW?=
 =?us-ascii?Q?9fBx9MFDJF0pGlIR/NtI/XuuYPqxvJURt8okrQzB/UX/1KL2aPV85FOFL70V?=
 =?us-ascii?Q?3WYJ9SH3GLj2Nt3GU0Zg7gx1BAVedHUlZ9Qbg3fGdbR+OGdLTaa8hGWXKoUb?=
 =?us-ascii?Q?Z6KED3HQtM+3ELod4Uk9ho0C03+AL2Km12WrKjPJ1hFi1ANn0XIquqx4GBF1?=
 =?us-ascii?Q?KmYN325rc9nLJyouP3ZMouCiRfdvz3AZZSU186nlZqfopkjjAx7GM1/0puNG?=
 =?us-ascii?Q?AKsnV2obCigKFz1niEgMeQcih0e+JkSkxlfFQUpbLvhX3DOd/HSfMPZp91Ri?=
 =?us-ascii?Q?/dlL/O7JGYh3zqCfuMK0eV9jnB8PXUXLP6IEEinClbZlwozxOrYf7kcb90xm?=
 =?us-ascii?Q?JRrukQExw0r87e55LDPeFtKHV4iegH6XxlAjZm5DhEWKtbqaVHKov3RfTM0Z?=
 =?us-ascii?Q?ek3195zCC+X2Jz3VW3DLQyjrFoyEOPq0D+n1Mz3SxFfpch+jb7N8uDssFQAk?=
 =?us-ascii?Q?5y5PLB4aUz45h+IysSrvf6YNJi2F8M++/AX30ZGIQ2VmoLQCEq8sR8fauw98?=
 =?us-ascii?Q?OBa1ZAjkszt2AKxU2MCrPzWLaU/CwtbBCsceCdRbRTsWxIvQPGQ618w1Eq/G?=
 =?us-ascii?Q?7iEC2H69P8KOyZGWHD78vukuEEwk8LJLRbBIADrtC3vmcYUvn0x2uwfH9G2f?=
 =?us-ascii?Q?KmTUn3Nf+vXR8WqC3sUcd8nxAEdOezSUtpcV/hjY8WAdoQsUshkEk4E2owke?=
 =?us-ascii?Q?w4gDecyYx/Iottxnaj17vMtO5Q97OV7qC6/8RhWW/0oZmVXXPnenBpjIe2vH?=
 =?us-ascii?Q?aoli6DFcoIpXYQH8XQ+QTzgUMqAGLvxO2aI+1l+faHBmBaMIAEHI3WqE5Q8b?=
 =?us-ascii?Q?Bvpmq85UHMPU2F+pvfbTtXMvDyHbiwpYQGZ7G0dSVEREZ8brCOOrjKSlQeGa?=
 =?us-ascii?Q?c0ZnFRIveqm+3eJ8d3CtckfH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e507c5f-1ff0-4e65-8da5-08d92cfb1c2d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:05:27.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfPDQBsBKkE69ObQaK38RGxUl/71jf49KsHKZgIzVAp1tQ8y+VEaINna3a2BGbuA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 09, 2021 at 06:46:33PM -0400, Tony Krowiak wrote:
> This patch introduces two new r/w locks to replace the wait_queue_head_t
> that was introduced to fix a lockdep splat reported when testing
> pass-through of AP queues to a Secure Execution guest. This was the
> abbreviated dependency chain reported by lockdep that was fixed using
> a wait queue:
> 
> kvm_arch_crypto_set_masks+0x4a/0x2b8 [kvm]        kvm->lock
> vfio_ap_mdev_group_notifier+0x154/0x170 [vfio_ap] matrix_dev->lock
> 
> handle_pqap+0x56/0x1d0 [vfio_ap]    matrix_dev->lock
> kvm_vcpu_ioctl+0x2cc/0x898 [kvm]    vcpu->mutex
> 
> kvm_s390_cpus_to_pv+0x4e/0xf8 [kvm]   vcpu->mutex
> kvm_arch_vm_ioctl+0x3ec/0x550 [kvm]   kvm->lock

Is the problem larger than kvm_arch_crypto_set_masks()? If not it
looks easy enough to fix, just pull the kvm->lock out of
kvm_arch_crypto_set_masks() and obtain it in vfio_ap_mdev_set_kvm()
before the rwsem. Now your locks are in the right order and all should
be well?

> +static int vfio_ap_mdev_matrix_store_lock(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	if (!down_write_trylock(&matrix_mdev->rwsem))
> +		return -EBUSY;
> +
> +	if (matrix_mdev->kvm) {
> +		up_write(&matrix_mdev->rwsem);
> +		return -EBUSY;
> +	}
> +
> +	if (!down_write_trylock(&matrix_mdev->matrix.rwsem)) {
> +		up_write(&matrix_mdev->rwsem);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

This double locking is quite strange, at least it deserves a detailed
comment? The comments suggest these locks protect distinct data so..

> +
> +	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
> +	if (ret)
> +		return ret;
>  
>  	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);

here it obtained both locks but only touched matrix.aqm which is only
protected by the inner lock - what was the point of obtaining the
outer lock?

Also, not convinced down_write_trylock() is appropriate from a sysfs
callback, it should block and wait, surely? Otherwise userspace gets
random racy failures depending on what the kernel is doing??

Jason
