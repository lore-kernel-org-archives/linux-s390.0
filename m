Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA7C11F65
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 11:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9226261580
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 11:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhF3L5k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:57:40 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:53504
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234148AbhF3L5k (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Jun 2021 07:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvYYvvIoXb/XCjLRGsc/rGJD3ku7ABYAx4Oz+2B9f/j50eNiQraaslfSWlB84rKevCWtXX3wo512/QasU1Wx2IOmkt0LQlyjYOQHYDd/lduMpfrn6Z+Ii8OqdUeLAtWaTg2yc0DToh3uZWVNK8iPY/5q2oU7aDcg6seJ0YlQVE0Aj/ON/RP7rhCLERraem0trAywKSuP623VfqCCJcUB22QmNHba2uYMgF3a6mWS7OST9jvBuPA71qR41UzdjoaLSAW+OzDxx/2aisQ78R81HDc9IGxSdM7R749rdfkbbBDgKhgmwL802sSY8O+mqj3b0OIUCVtk2xNon5r6h0ZzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Bc7mXc+QkbQCHTrP6MosY2JhiZl3CdTY7dIDHb05eo=;
 b=hVK/MOpXJQN/5zpT6/c2Cydpu8MYW6B/YpTDKs/FFvIWrCmalcLsP20mw0fRjXsgHrbOEkhfH0GVdtRdA6H4LKYdgtCC+S5XSavXTG/70kO4VsfOQw1lrOIH4WF9Rm3/FrFxKBQMAKH2iyh1CMZbkPb93vXdK45Gd8gKf9nnAypXNsXNlM+4i5JmamOYvu+ONC/2EcIQgm8YVdboQrc+2XaSmsIlLVwI0vfw+b9XsJDBiJuibMLmEp/IObh/lOH2BglbNvepubtRtSPpzmYkBvKA4ZsQfsVmUoDTPuWFHmrAH7+CGl4Pz5zFqkZ5iitIaTRsl0QuAb/bd48qCPLPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Bc7mXc+QkbQCHTrP6MosY2JhiZl3CdTY7dIDHb05eo=;
 b=GTLjvMaVs7CWvyYdlP/ItuSQCL+wYyvyUMQJ2Me2dSlsEB+YJKhNKnydFY41OyEI3cGe6blc0ZuXqOYVDeUOb6WVyzmmCTFMwrHRkFCfR3iKyU3jGJwEp7nkph1b2WiftFfgyDXHp2u8b/DU3SafMEqch1GolAN20bKy5zZtOmueHVjL58cvnAarVdQKJb5Qbb3CvaxeWAOeuSNRvB94DCycfsBvA/eqM53dvNkxhkeHIsC7Mbw1cvGnRe/9ibWqJsGjADyJth0MPeWFk8NgV0yBA25aVSs74n0CJjSfItfzFQ1wG8HdsOMtftxa5y6ESlMaYEM+PduXGpIo/Bw1Ug==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 11:55:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 11:55:10 +0000
Date:   Wed, 30 Jun 2021 08:55:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Jason J. Herne" <jjherne@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210630115508.GB10820@nvidia.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <a37d2816-47fc-ef6b-eb59-c5782e13ca12@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37d2816-47fc-ef6b-eb59-c5782e13ca12@linux.ibm.com>
X-Originating-IP: [24.114.99.247]
X-ClientProxiedBy: BL1PR13CA0348.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (24.114.99.247) by BL1PR13CA0348.namprd13.prod.outlook.com (2603:10b6:208:2c6::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.13 via Frontend Transport; Wed, 30 Jun 2021 11:55:10 +0000
Received: from jgg by jggl with local (Exim 4.94)       (envelope-from <jgg@nvidia.com>)        id 1lyYo8-00030B-79; Wed, 30 Jun 2021 08:55:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8461cb-e0ef-498a-ef6a-08d93bbde986
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52384B1984C7752BA1F35591C2019@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9RleZ/GY3F3NmYSj4/GPzY93fwsxo7fl3XqR379/f/U3zov5JPQT9Hgfd6b9vseeIPvmdkF9hSbNRU/pHILuXbR/Jot9KYm5sDGoESYioonxB+87BgPyaIFk52mvIhWWLze8gX+iRkQx+3SJQS+2qI0YApJvMMOpEbmm5H92wsuuQR1AQwelaTqmvB93cB7MchYBMZixuPuoh4hrV1JROhSf1cgHrOjJEoezfOSZnF0VUlFrPRsqF30HqlbUmQnf0rntmuJMtA9UCwO1rS6VYJHIkE9AyGJEPAsWhFDpfhp9Tp55hDtC1sPi4kKEw+Eq/wXqetScEBB2mMZcLYRNk33plGOSWkIJqvXcBxhRMn7pS9Vr3mwjagnjBdv1dGff8KxRvVFTnw2C4gr263vNPoxh8hLpuuQeLJf9bkuuXp7UTBs6sfoF97tx27jtNjUTPqwZ0Ru7Qi8HWzUS1oaQ8ViqlryPV8dy7E5IiFum4Y1a0KbsfeGpij5Ea03BeGuVSHLfL2+/+If13+epp9EWYFOLJ98ARsMABP8dMkMLByfIJNj7zgb/9XApp0Gf6dPf898C74qIfOBET1t/9AEU/0XWbx4swUiUUY49pBFwXO34XVivYzHpCNC6Gg4keOP8xkMUhXQsjTeLFNo14/tOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(2616005)(478600001)(36756003)(66556008)(8936002)(66946007)(2906002)(4744005)(26005)(66476007)(9786002)(426003)(9746002)(83380400001)(186003)(1076003)(8676002)(4326008)(5660300002)(86362001)(7416002)(38100700002)(6916009)(33656002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zubtLXjlKLjMAgFHpzhJ6URabiQlE8QxubaHvghELuN9FhkwALM3L4M2iuQ?=
 =?us-ascii?Q?FLNyD0KxECWFFrYelopHLpg6D+VfH8Cni4oruqzhzv6j7NJ1S/YMIjrTAKbP?=
 =?us-ascii?Q?xyjlyZY5rYqTv2Oqf/JBzI2WLTnN3W1k9wHh3+cWI+JG24MkznapaX8JmFmP?=
 =?us-ascii?Q?kUzGPd2vZzthcvrwR00n6X83Owi4YSkfpILY2VlMqg66YTSb+uAPehrL+raQ?=
 =?us-ascii?Q?fQJaaUI8frCD8RsmX9K7JtPgjn7RdqzfAX7AnesQ9mMH2LgM1xd36JTVsh2/?=
 =?us-ascii?Q?zQE2NSzeHLzkxY68QrGMc4OauWR4aIKAWtooPlfciDGrTiqdoi8IvrHQVcT9?=
 =?us-ascii?Q?2aF+Ar51fCWtbPaXE9LSMVWHPhJuVRQMJWf02I1fRi53A01oj/y6cF+bmnm/?=
 =?us-ascii?Q?V06rLOHN/xR3ksQb+dGMTeLQD79qE4sMz/meQ/rth1mLAGVyGp6819b+pieB?=
 =?us-ascii?Q?rN9Xg3vBnuEyHPir6PP0Nq4yLh/On+Z0A8SzubyFM81miYbCHL62yaIMih1H?=
 =?us-ascii?Q?TxnjJob36SQIS3d677GI9scHjNh1/yp7anWhkzPLUq82E+1qi5/IymT+JD83?=
 =?us-ascii?Q?obRtnGYBhbMBWxur/0mibeozUNY8ddhqYicyT7mxy8PUOQRCVznpbbXWAnBf?=
 =?us-ascii?Q?j+fb8o6Mz8qt7DTwyUgmLX/7GliM+iKA1pkvVoxLRb5AoktmRKgkbrkIYkzH?=
 =?us-ascii?Q?v9Mkb//Hm3nWHnEl2P7nWp4ggTlMFKbCT4J+qu2/FDqrhpnzV7Te2rLsG3bZ?=
 =?us-ascii?Q?8NHSkfzgmO1OjEf/xlZvd5kytGHo4n+vuKl7lPaqgY/zoYwPEWJwSe2FTQwb?=
 =?us-ascii?Q?MUVPO9n3jmPLZmeR6LuuhW5/2TxJ5PNptw68Fl8hrrY0c24leMuk5/n3URBz?=
 =?us-ascii?Q?MEXUf6jOVDW/RS+ljxsvC4fOD2qQQ4aM06VdbBMpEgiyypFZs+9oRQym51GM?=
 =?us-ascii?Q?sJyaYu5Fia4y/LGSCLoXBEouGQoik8gEYt7RwqIfFF4l+qsamgmyGfOnUohT?=
 =?us-ascii?Q?zZy3/XVmZX6GIsOkZw60VBt1mvgt4lPvk+C8OFiTM3BWBCf+y/GING7o2m5t?=
 =?us-ascii?Q?hitKAo8Vdi3NZYMXrUVL3y0hLBAglsko4ivdWqSO0slxjoTSrcNWe7w2K7dg?=
 =?us-ascii?Q?dpSJX0Iq6XH4uJ9m8ImkIOuiDFKHImcRUnHWdM/vtzEpfnp+pKsHMfJu/8Mr?=
 =?us-ascii?Q?C50DLeiXSlGAZXTelyZDj54yhT86IpToTgRh43h8GAn19nSJvUeAod4NiAPW?=
 =?us-ascii?Q?uXri9nguguEfsMwvDQwq84po9yYsQjvWS6vV1k3dVeTMfeUP1mOyQAsE/UOj?=
 =?us-ascii?Q?2B9ikpqcCDEkHUp6Sun1KHun?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8461cb-e0ef-498a-ef6a-08d93bbde986
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 11:55:10.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbRYe683+QvUr98LJYgPo/tbaRVD7iE4BobiSrEJZg4ENqBxSVDoAPfzqOTiSXPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 29, 2021 at 09:21:31AM -0400, Jason J. Herne wrote:

> > +	mutex_lock(&matrix_dev->lock);
> > -	if (matrix_mdev->kvm) {
> > -		matrix_mdev->kvm_busy = true;
> > +	if ((matrix_mdev->kvm) && (matrix_mdev->kvm->arch.crypto.crycbd)) {
> >   		mutex_unlock(&matrix_dev->lock);
> 
> 
> If this function cannot be entered concurrently on separate threads then I
> think we can remove this mutex_unlock of matrix_dev->lock, 

Don't remove locking around data. If the data is written under a mutex
it should be read under a mutex too.

Jason
