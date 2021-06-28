Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39673C11F64
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 17:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBFC61C4D
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhF1RhT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Jun 2021 13:37:19 -0400
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:12513
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233747AbhF1RhR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Jun 2021 13:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYUTmfpyPEVnJLUarNDBW2s2y6xnzij1HasgrCTSJhZUccB1k+bsIaa/L27WMLVIyAtqBN4vYfMt5EcdRmnLM2KmyQbxbs7+bGMNYk/7Apgedmwk06OJBXWEr0kZ0TRo6FdGEZRxCSo0MoP0MsptztugF2Z0/w151jzG/oqASIsSjg5kv5UtNBeN6oYaaQpRhF847f4K0upJz3xxwWRGRmJezJyYImyVJlhvhh566U//SbzUMrKLd3eblY25elsEtf4hzKWzWfbp40JCne764GlU9F9O7WpeHEGRXUjFbROKR1CLu9r3YUbXagVbpRvCfECOpTwWGYIOczMNrGJyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGHdZex21aO9+ugiCjqCdSALBJHf7Z6/khcGUFAERiw=;
 b=U9Ecj9rkC7a57ti2k3pwAH70iKuG2+TfX4l9LG+9oCv5lan8Us1ehuY67QHhFC15iwu2Yl9gAo4f9eOqWSd8Gd64UdkkYa2ABtYwGavmiLtsTHdoG23ORrQvVT5mogahkdEivrwjX0GhXH2fM4MK+0S2tYcE3FY4Du/VrnESRBJaLXWJxPppOxNIEsY3hx/mktvDscWMhMkRjX8OxMVyBAApM6kM9Q2HEm4MAlVzlRVTtliYqF5bwMQo6cYZq7HlLXr0LaeBX1IMbE6W+5QeakINcmA5AaCgI78wKcriK9gnqTT8gg2n5z/mHTEHXPiG/K5i8aWvM6alBJugbauztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGHdZex21aO9+ugiCjqCdSALBJHf7Z6/khcGUFAERiw=;
 b=qMBHaVdBwIL1k+DxzeLqeJPZn/Rz8tfzw+f9y49+8T3jtGoW/XVCr6Yvjszb7/KhWP6T0CJXWpZZX5/XJo5XA6xW4HqTW+eephVlAg1UYDa3e/EtuIPIFi2J8sNAVuv4Z681HkV2mHTw7JoyrtvGzQ02b98aSjrkeagxUSWq3GIMDqJk/4/ewQo1F4uwmNNaRMvMIaT7jvkDITo+GRNalIoTvK41rdjZ6EI7xwsirx/P/tYKfju+Q9nhQ36Bp9RvEmG3W2r9u311Z5vmNZ3vgGBS92/tMeq4HhByz+uL6O4gt/f7RofYWdld9PUiME0MCeNZLwQyTdFsowSKf2SGsA==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5522.namprd12.prod.outlook.com (2603:10b6:208:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 17:34:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:34:49 +0000
Date:   Mon, 28 Jun 2021 14:34:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210628173448.GG4459@nvidia.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625220758.80365-1-akrowiak@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0084.namprd13.prod.outlook.com (2603:10b6:208:2b8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Mon, 28 Jun 2021 17:34:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lxv9k-000h2V-Gc; Mon, 28 Jun 2021 14:34:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d324e7e9-c7bb-4f46-ec88-08d93a5b0794
X-MS-TrafficTypeDiagnostic: BL0PR12MB5522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5522D42A4FDFA01FD8AB31B8C2039@BL0PR12MB5522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVSSIcAO+QpU5efuX2nh0QH0fuH5W8rbDkhLPXaU4seT7lmPeQ+pIvFCpHpAo/pneQxpDbDUgI3l+U9jLmQCwi6yatgyOz5hjyzyHj1JaPdQyJEmljimmdMJ6ra69PjOsoTXOu59+y7+UG0gP5+owF8OECFZQ4yDrWbuFV9Dwx08QaHBZrEgufWUY296pl6UAb4E8LfyVxkc0wDIqciSMCndyRi8ZtSBsSj6Cc2Ih61ybfwr3oVWsS6IQq37MeGBsytWIwluP6gNzPgg2Uug+vIAUs+iyEUHy35ZyLwy42jhv+dybepkA2JWyVr/qRS5zDV8Vrlg3BZ1dxuGJ3dBatnPJUeUuXP95b89znXhb+3MNmVh7Z+B9aPcqfeItyzZL91jpYaCdWtyd4qmPYZcSSzhyE8CeWHruxWJL1eFcsyPG6zZMPGWL4zxnDVXKDAQW728U1mA/tFugzaE7gzth7IqljW+T17087Bpegas2I4j9GRwjJ5lhoYtEh5KZxuUqasMLElmD3icRrHjJ2xldxO5orPM8r+Y1SuWuTLAJTYyymBv3kKqXBxbOb4SepDjTir0SupFrGYejjZ9D4f5w+16i7SqY0YhgEte/TLpxJh5MB6M8D4MmzRiG8XmAw+F6wZ4Y+/qTYev7wcrHbDDVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(83380400001)(36756003)(478600001)(6916009)(7416002)(33656002)(8676002)(8936002)(9746002)(4744005)(66476007)(66556008)(316002)(66946007)(26005)(1076003)(86362001)(186003)(38100700002)(9786002)(2616005)(426003)(5660300002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2z5lX8RFRT9il6BsTvV0gJmYiskm9k2DpxJ0AmF0E3tbSUtOpKo5zvEqUAr?=
 =?us-ascii?Q?SXUZFzXnF1zGGhutyyhC4Z4VKUxUES4ftiSNos74hjVgoUMeqki+ILr83hmE?=
 =?us-ascii?Q?P/bR2D+PtJa50Uoaeh9UqfO0Jir9rB8RZKR/eZz4qG3YaScptyEhKsw/AAcq?=
 =?us-ascii?Q?FLlyxVQjn9daGA7+1F4NIqoniRMCMN6FDQCgWOGmLMig46A1hNXiHcwF/wIR?=
 =?us-ascii?Q?/DAor2xar69Oi/eniKrjjdTH+MXgZuM3iGlH6AtQfOSN6onEaPJdnaPL+hOY?=
 =?us-ascii?Q?JEpVSvbWCmdqjUiMYuoiUJkjrTuAH75F8LoVa916Ht9VT7WGZ0UwfJRJU0t+?=
 =?us-ascii?Q?Z2YrEm3yJCqabGYmUDBea4sp0Pt9L2ZyfZMCuQzAu8ApfCxzZ4tDK2dvhOVj?=
 =?us-ascii?Q?WBN0zTqZhjhx9oy4GgpA+K4LHtglFpi97FeJGpH+pBQdM35wWVFiVxn/pcM2?=
 =?us-ascii?Q?1F2ErG1MMaQdeiFVL3xk7Ubhb2t01arWUSgeH+G7K1stppmE6HiFoJdXHP3+?=
 =?us-ascii?Q?R72p9/bSrMHD5aEjm5mE27H70szstRbTUEkrRbzk9wciRBAunPrGNsfQEI73?=
 =?us-ascii?Q?hj3gBFkGUKfWpJu8rEmhOY7AJksIJ58Qc0lIloBWfPPc534EBFsDiYixmMng?=
 =?us-ascii?Q?vnCPHjvK6EPtg2IVW1p6NUY8UDEC391PXA9XlMWHQdAdp00e24dj5RegVNcL?=
 =?us-ascii?Q?Nt/rZGiDJGOdHLaWeLEfSYaDNpAKIvjLO4XPeIpYqUR5A7hoDavLxoEZYmph?=
 =?us-ascii?Q?rPOyDMwaX7rUHUmSgdI5WkaPUi5DBpneb9Cqm1cbgC/ERrrBTot1ka3tCqlb?=
 =?us-ascii?Q?UWXbxc4SIt31bt9KB5KzCsuHd3VayDxlkMEjT9LgWuKJaMNVoDTko194igRg?=
 =?us-ascii?Q?JouQsDOHG/4QlHduPXq4SDrpzz2WOeb8+4B+hjztkd2EDWqUa8oIk+xlf+Ec?=
 =?us-ascii?Q?VGi/J7fM0/BkcLlFObgCN2vU4xPktnuj0z24Rrhf9j2RcTbbrtQpqZ81wLIR?=
 =?us-ascii?Q?qLERO/FpeBvZ2+5Vt+xPd/KQcOxKB+A8LQSL1Ew+QM0huQIM/3e9iNYlkA9H?=
 =?us-ascii?Q?SBJhyU8um2wUSitiYe4E1z5qk3d+/L9q93b20HX1n8KPuvd0f0fZ/mnB6Yxs?=
 =?us-ascii?Q?Bjdc4yjlTDLLdQHB/7RWmkcUAW0bmizq+vPhwtdW/CRAHtDNg8n9y/Xd3Xvg?=
 =?us-ascii?Q?1dMqdsnYbZeQUgISI6+1v41ElmfS+u9er+82pX8fkruvYnJij8lkusgeE76f?=
 =?us-ascii?Q?1nY1Ra0X/Wrkz3/OVWQf0AtWVP+crUatAh9g409yxIEThuypAVEyAVOb1jb9?=
 =?us-ascii?Q?CGZicHLWSHqf9q2+SzFQCRzR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d324e7e9-c7bb-4f46-ec88-08d93a5b0794
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:34:49.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZ2Qdya1iCTTc//ZaZnfUrBCC/A8J+a/Q4lEkh59gVJkxsSIv8uZ5sDw9tdDK+6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5522
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 25, 2021 at 06:07:58PM -0400, Tony Krowiak wrote:
>  static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>  {
> +	mutex_lock(&matrix_dev->lock);
>  
> +	if ((matrix_mdev->kvm) && (matrix_mdev->kvm->arch.crypto.crycbd)) {
>  		mutex_unlock(&matrix_dev->lock);
> +		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>  
> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>  
>  		mutex_lock(&matrix_dev->lock);
>  		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>  		kvm_put_kvm(matrix_mdev->kvm);
>  		matrix_mdev->kvm = NULL;
> +		mutex_unlock(&matrix_dev->lock);
>  	}

Doesn't a flow exit the function with matrix_dev->lock held here?

Write it with 'success oriented flow'

I didn't check if everything makes sense, but it sure looks clean.

Jason
