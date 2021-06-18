Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C0C48BDF
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 18:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993B5613C2
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 18:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhFRSZu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:25:50 -0400
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:6593
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230175AbhFRSZu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 14:25:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1ZXluPkd0iOlr0t2qisSkaRu0U+6NYT1Nt77gUKIpg9nNyEUDzLSRkiuIbaaK5YLbbU6fuy5X4lSs2BkhOQpKxLQrrZED/jk5XAMWQOrdXZNUpN3WfnnN3y14F/sAmQ5hUK/WJq0CFMBxogMO3C5o8s1HUng+J7yaH0oCanAbofKbw5V78/Zx0Uyb27h9VXffc224SYdvxh+O41Wb7SaKN+q+U3aqqMBERw+n6HGqS4y9CTe0jDY4GPRMp2MEucEwt/UR0b7OCux5oZwhtwsxfxbeziVGjka78CvnUwNbFdkmI72OVV74nizqpWRBD5Lv1xRwCj1ED9EAWhYZJwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNsmetUqqceg0PLEgGEoEWxBCBKB3+sX8vf/WWtsU+g=;
 b=eH0iPyGJVox8HwW5B+cgRC7y2WK5L1B3mLL9NBuxJldhQAibWi2zSS72lbAVzwKc/QIzqZ72c1YuYAsMZ36v+KAliO2oAlfmfknOS9kLFBxQoAwc27zepcGwb81ZM8Sb+peHKQOduazFMoT5wxoPMEhtL//JGS/dRzIn7cNnt96Sq1tzCpP8dLx/KGgQm/80W1vV/spUqSMDzI1S0/tnbXN5m+B0HmDWuDAMGZ3EdhSlKcvM0JAAmy/vobBiyZakDwkOQE5jdg8q9akodjMY/eCFxL+u+hupvdwgItR+3fdQ04DNWfLkytm/NAMw9bU7iZzw/rWw7ULkpJFuycrJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNsmetUqqceg0PLEgGEoEWxBCBKB3+sX8vf/WWtsU+g=;
 b=XP1+dVSdfk/1j61BSg5y5UZgIoJUKBaGs1gPLQ2oHqBrxXd2YTK2wohO1Asl/n+w9XxeI9vI1sT4//A7f/XVQDien1LTJUqu+oK5MeoCyJS4MnvcDNpsCI7/Bj9GtOODmGNPkU9wUe3qELn1qKKpNIkZCdWzj3vn4WrPhnKrqvf61Z9fdw/EuWHLGt8xr8PouKUUrPbyG5KPYLFAPoxGhN2dZbsYLXcVROdtoYiHBMi1kGxBcpxZfOVU5L71pUUSZP/dURvhq8N7SeIEgfvuGoF2lG2iJJ7IMkyq/Bm7dhtV3sTaonFLs367ClRtVN6GXV6nX6DV8x4rmk9z/LI6vA==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 18:23:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 18:23:37 +0000
Date:   Fri, 18 Jun 2021 15:23:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     "Jason J. Herne" <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com
Subject: Re: [PATCH v2] s390/vfio-ap: Fix module unload memory leak of
 matrix_dev
Message-ID: <20210618182336.GJ1002214@nvidia.com>
References: <20210618171255.2025-1-jjherne@linux.ibm.com>
 <af3d6c67-e045-770f-82ff-dd8e691c1317@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3d6c67-e045-770f-82ff-dd8e691c1317@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:208:134::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:208:134::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 18:23:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luJ9U-008dQN-Bp; Fri, 18 Jun 2021 15:23:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d0c100-5854-4a77-6b06-08d9328630bc
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:
X-Microsoft-Antispam-PRVS: <BL0PR12MB550883153C38A6C7F4BB409AC20D9@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cTBcN59CzazhZBeCQ2L3iX3rXLMmhnv8WmvFqIA2NyrUIPvpkmEo35IyRsL7+f+4ITnd0dVDk89oZKLzLSKU+dAjSpgEu1b1O/16WrSPEgN/ZwFpZYf5xsNAb0JCECYTJkx6Jk1hAzMiLPn59GFP1C4i7GgxNjCjQWb/GvZ08RPmBmYkYHFh+wxIEMy2g1YtYTyCupHs5UlE6kjhL8OJgKdf+E3nmiqyz0bgZDJPwOh49GFrrqCqYrEHIj/RjPTBx3MZTO/A5tm5QZBvzN4eWZszw5wo663zbAUZPPgKghY3lSwcM+olnh+npc6HMLbVOz5ZlHBD7EWq3Kod6sTo4UDs57AfFexpRGg0JbQwvsXlvKIN1tYwWHuSwcA1aakD/kg99Up8i2Ql5+RQQcattUd8qBas8AN7xXCOw7SapZdfq0s6/vSQwZDtdFSZtP2nLYaYyf5OWQx0ZjUDtJJz9BY0ygXbAUB25xH3kN8FLIhae8HPIJfVH4G8/eBmAg53JHhrImL/6UQNFvCkLjloRhLp/vvMEzAD/X6AV4mS9Bg/l/3dlF4pu7YpgXcbVbhPG5E5Zna5CNRyNU7MJgR3pHF85xzabRaMlO03KKf8xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(316002)(66556008)(9746002)(426003)(26005)(478600001)(2616005)(36756003)(53546011)(2906002)(66476007)(86362001)(6916009)(9786002)(5660300002)(8936002)(38100700002)(83380400001)(1076003)(186003)(33656002)(66946007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmPXfbAZTGZmBo4QjxEwFKtytZGIHtwXD8m5NV0pXsXLC4rykkxqstc7e54P?=
 =?us-ascii?Q?2NTBsp4adMQfijg7jOBVLoHhZM4TfsRgW4/OhWRGk5q2JmIuCV+MB0mBC9PG?=
 =?us-ascii?Q?7Bs3pe3vBKJmDmJ7aontrRBB9/2BW299L0oCCGsQWc4yHqLpQ/USkpwZrj01?=
 =?us-ascii?Q?iKlV+rYKsnev/e1k1Sl2/ziyZ++zbJlfH0yD1TYGsZ+Hp4MSAopJaz5u0HXV?=
 =?us-ascii?Q?RC2ccMmq1NphUiFQTqOPkZ2DuFnAEc+2n+44xjfsE5V2IK9sWaNXgJvkf/bP?=
 =?us-ascii?Q?4ufsvErOSR0c9Reu6GMyZX+0YePLELzVuL+7oLy0hWNhLE0K3cL71fchWyat?=
 =?us-ascii?Q?aUtt6kRoLc9LXtd4qxUbD9eSe4fSdp710Q6PYmOVAqilYqqmOaYeEmI6iyDR?=
 =?us-ascii?Q?AvchELcG0ydKAMmlQJ+RaeS3D6JjHyOQlKy5HIA2ohnJnAYDpbZ8PK4ul5+r?=
 =?us-ascii?Q?BQKsWr8DG+3SkLe6jWUXnm/U3ygdCA0txOumcO5HXsezbfUUDugH0tozTuQ9?=
 =?us-ascii?Q?h1Vz2hQBnXsqdFgv6d4z3SOQi8wrOQmpMP6JTxkeyxsnj4Ldhcy828LUV6/V?=
 =?us-ascii?Q?5WdkCvtaeEKJxiiosDaSMSmQ4FxE4FPWrYwbKsj+oFdHTtDlSrA3fIhXgoNB?=
 =?us-ascii?Q?Ln7jE/CdWR8a34uJdDNJevJyKjg+ivcj7dmO3AfJGdfzfm4mJWeUyysjSsGp?=
 =?us-ascii?Q?Kzfa+d3u9JY5qM7PFCRU7spVNfqJg3YvwhdHxUq2DkPskwZ/ENgx8KEL0Dg4?=
 =?us-ascii?Q?nlGV4x4Bz4oKyOUUweUybCGHY9ZcybctfD9TlZjo3Bu/kxRj085/WUuZ5Arc?=
 =?us-ascii?Q?IK+mQNad4E7gU4HYDtvqjrdU+Iw+YeO3fd/Rf1o+zg5/uPkZpmUGU0qaE6qm?=
 =?us-ascii?Q?KTW1g4r06MNI4Bhxft/H39E89P5ODHbd4KV68MZlJRvOkxdwzmrJkrRMH8lr?=
 =?us-ascii?Q?Hng8XSw8nDqa4xE6EHf6FCVFnnRR4Yq8Ks4kndqJNYiREA6t/rFhriUg+oYc?=
 =?us-ascii?Q?eUwNXW/VKUSLqHCkEh8KBmeS6xXC0lGsc8+eRBqu1sSe+pqV2RYt5ZwR9jtv?=
 =?us-ascii?Q?5eFGSOPhLMZd6ZOEsa1c0wWwIBq0li/GvehSwcCD9H+Osy6OaSTIsx8HNBec?=
 =?us-ascii?Q?KumRPidWmaqUCB/N20jN/gYEavLwC5Aat0xrTCT6FuILbpDk80DKiEwQ5n2x?=
 =?us-ascii?Q?e70Bt+Jqb9FHwLam9zVw4UflObYy/0wgeDpJkWlC1wsXmk72HBDAFbjda5KB?=
 =?us-ascii?Q?ToneiRcZQPIkXTb2UnGV3aLu2/mj4lrtwAtDsv7vZfPhqaIuKHuP1+lVny3e?=
 =?us-ascii?Q?RQ7lx3QzJyfGRlNcP7SpLvsw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d0c100-5854-4a77-6b06-08d9328630bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 18:23:37.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LStG4x76IZl1Z3B2HUZUsfvckfew3zUvLihRRQg2fYd/Gi+iCjPN5d5xEWU4UjTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 18, 2021 at 02:11:23PM -0400, Tony Krowiak wrote:
> 
> 
> On 6/18/21 1:12 PM, Jason J. Herne wrote:
> > vfio_ap_matrix_dev_release is shadowing the global matrix_dev with a NULL
> > pointer. Driver data for the matrix device is never set and so
> > dev_get_drvdata() always returns NULL. When release is called we end up
> > not freeing matrix_dev. The fix is to remove the shadow variable and get
> > the correct pointer from the device using container_of. We'll also NULL
> > the global to prevent any future use.
> > 
> > Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >   drivers/s390/crypto/vfio_ap_drv.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> > index 7dc72cb718b0..40e66cb363d1 100644
> > +++ b/drivers/s390/crypto/vfio_ap_drv.c
> > @@ -82,9 +82,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
> >   static void vfio_ap_matrix_dev_release(struct device *dev)
> >   {
> > -	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
> > -
> > -	kfree(matrix_dev);
> > +	kfree(container_of(dev, struct ap_matrix_dev, device));
> 
> I suppose if we're not going to assume that the release is being
> called to free the global matrix_dev, then if you are going to
> retrieve it using container_of(), then maybe we should verify
> the retrieved pointer is the same as the global matrix_dev?

That seems like overkill to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
