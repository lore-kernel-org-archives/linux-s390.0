Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03D6C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 17:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF816109F
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 17:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhHSR6q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:58:46 -0400
Received: from mail-dm6nam08on2044.outbound.protection.outlook.com ([40.107.102.44]:15008
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229549AbhHSR6q (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Aug 2021 13:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1FeqD3nNDyPimmjvy7qfq/gybHjmtrszuMkFN40/Pd6lNA3EXR46Q0H32KglwDICxFmLiBhonXVuBTflRktVLNy5XHMp1KycYTJbQ7cxl9G0SkbfZg2M9v1/ezSow8cDnTfNQu2VOptcb4DgmGC7nz8l9SOTyhx0EdmMW7PbzMZYul2Ltq5AImZ6SVfLCAmdSM76k7ZppSz7Pz/0/Z+66YTym/KpJMvW4cK420H7yySzJjWWsHmFpcd1TwemDiTvc2gUkEud+KMOc1O0I4QBgR3j+Oxuj8LmBTZT4dZHcuhKPKraPdai1rjFCMAwe14meON5fpUss4nXZHWfjsbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAZC2Rrv8M1AiY8sUUTRfgWldD0MFSsZpPp+Ac7KH88=;
 b=OQztCGBZ9j+hYUqAArBg4SLQ6YKcVMHt5GzPUKe8yntAA/IoJu6W/AWCwKt5TlRomqEg8amBUieafHlM1D8JBCMCnLnNFkHFFb4iproAQ5zILjcXllXnZ/VanmhYHidf36a+Hk2SCHba6XVEo57MOML7I36XKUPeTmz+mfU6I1n/SggiN6+L7Cvht/sh0BJCHOj77K9/MdPYm64CIBBEiL7OqsrAEtQjarV8jQP6cEToVUC9HafSHvvaKhKE/OZIvWv7ItuK1SimoCEoLfliUTJM3ObshEM8jg7dz/W9/sQLnziTdqsHHiRNqoU7bNe3cv6pYgxCaPeUyOOa81uAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAZC2Rrv8M1AiY8sUUTRfgWldD0MFSsZpPp+Ac7KH88=;
 b=WwcO2v0GpFDrrwHB3zOBmhcpiuIVEpZLywswxIujbJwDqlEXmGca03dBaluXIffA7DDpS28XVE9ywKB/mRmbHE1UzLJIrDc9dRLoM24vQIKNoH08THEGIzuHqqTn7NMRIfWR2Xs9JnfYqwAr3VwjI8MgfET1s6z5t/xuur+7RwbeCOjlOWIQ33E9VMrFbqfV0WY9MqYoGBAhTv+cSJOkSYW8e+WWqPCum2TLyhi0uAM7Gu3BYW2UzvPK3O3jmaPMGJA1uCp2rYVADW+rhMT3FXwUHjmT+36TSn5w94+bpB52WtPSuVdOWwqGfz7iVyr2Hsf8Aj3IuzYvBY3G6Llcfw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 17:58:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 17:58:08 +0000
Date:   Thu, 19 Aug 2021 14:58:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
Message-ID: <20210819175807.GC1721383@nvidia.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
 <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
 <20210819115433.76153ae4.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819115433.76153ae4.alex.williamson@redhat.com>
X-ClientProxiedBy: CH2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:610:54::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:610:54::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 17:58:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGmIp-001XHb-4E; Thu, 19 Aug 2021 14:58:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47349ac6-b9db-45c2-8c78-08d9633ae6e3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB522289358AB207DC9FDEE705C2C09@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYEb8u2eZh9yYww+dpPLNF8KGw6MkgbmfbcmuLctRyyxGaEnvFPj8cm5TO54VbSHW5aqKC+OnxCFCkLxmi1Wbd/uHjajX8YDQFl9biNLJSzvEPEnGNIARks1F8VSPH+j+DrkZFSf7OCm19uLkSapKcw0MrbS0SySSCJnc7Skd0eJT+qyBCqTLp9vzgyKc7+GvzqCBZJNnCawLD5L+SfFEgrhIEeYkPZGqULOivxlg+8ykOCvmu+aPqg7iZbky82iOeIlW0U+k7AtNxRP+kAZYLx0GPft5Dww7wxYpt5Aq1AshPOvP0X3/hN250Q71IurvxQfjwzR9LDI+T0S6m+99thyVISRQHdqIoadY+Bk2SZNnaKLZ4rht/wqihODImndpuI7yvb7uqPzbBft+UaQbhkh72+ZZPGZqGrJVJpamATa9p8svaL6A3gkkwft/dFbWd7HEph2C+GkCzRdwsam2CRz9fNM4lks/551FPAct6O2Z0PusLwQjmroQcFHokbJp9vSzjGNDEMDM8UM6bPYox2iyN6byBJIDUP0xZBdblpIFbtwjiThu6HaCOnL2lYDH00RQCPFTZN9sZysMY5tcHtOGquwzaaaSsVT0YUtpIyvg9tm/ErfUbxFDmYZmO61qSAc+juakiT/XhU27L0PNnQUcu6tKBsxJdJhH82Texl6yWKRy4Sa+YCjDMlZoq1QkSvuh/l9YKadGXZEPQXZodB2YHG1hPbLRUdgCqmH3vc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(83380400001)(966005)(8936002)(4744005)(1076003)(26005)(66476007)(4326008)(6916009)(36756003)(33656002)(478600001)(2906002)(66556008)(2616005)(316002)(86362001)(186003)(426003)(9786002)(9746002)(66946007)(5660300002)(38100700002)(54906003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGOXkMEf0JAaQbPjB4OUatmM2CKiA8wrL5TtLuMqUOobHN4y5GpYB7xwVmw7?=
 =?us-ascii?Q?MSPp59GVT0Dk3Knq03jObj6gSopAH3ds0XwF9ecMpTMarcTsADGUtpHlHuLL?=
 =?us-ascii?Q?6iUusW8AzI2E6sfex9ESep8R8b90XK8/A9/wMDqnUgr7mKpiwK/DdR6GtnEO?=
 =?us-ascii?Q?USX6QYzsNBRY0QUDh5VZqr3CjokC7M2Ilsomtfj8vbyZOU3Cq5YXGQVSPUSH?=
 =?us-ascii?Q?fNwTjCH/boGIm+dU9S44FdpL/0co/wCjEexIbM5UGeQbhs/HuItRsE4L4lMm?=
 =?us-ascii?Q?mGpxOnZoyF3gxUjRt7hCWrvgCxY+MvAz8Gx4kYKCKb6Qs0HpctSZG1bIPuRK?=
 =?us-ascii?Q?Iy1CImFnJMpaU36BkKFGar6+2WF7LZaSqNmB7I40rVbipAFkgFKiGwT1sned?=
 =?us-ascii?Q?ea23Mov/3Q7PD0zFz1M9a5GLicZi+W8Srms8E+G4bNM2oCXS9npPWcTHU+9p?=
 =?us-ascii?Q?g7HHcYwJrwx5qs+p4dbSz7Gj2gQ3+lIOu7fNvmF0NkdQfYvoLXPuRb7EVfNL?=
 =?us-ascii?Q?bwDZ/Pv2Sd+Pe5CSThLAIBoxguQlHS1IFPfc8fp6pgmx1NjbZZSsks4wbO7L?=
 =?us-ascii?Q?TTALvSkJgATyRA7eul5jAbbPqqFCFbxCZvRqqpExoikaQX/PQT38fTnRfLoP?=
 =?us-ascii?Q?NadBqBufqrLVz4x5qZjR/ZTO7t+TtuUd49GxZIXWQL1SurSvriOjnWQF9nu7?=
 =?us-ascii?Q?mU3jCCJGYCAC+2SrXhXoIkgKM81wFkHQ4c3vnRff2//80VA80iAmV0XpwOVM?=
 =?us-ascii?Q?HLUfFIslua0NYMjfJXYMsrlAN+CQeoXs6jyeOoQgp6rNX4/n5N5E8/tnrVbQ?=
 =?us-ascii?Q?qLS++PgsBjS3Jlu8yw+LEuEbQlqTtA9efS2ODt/J+4ovbibQt4MarJQiXEyp?=
 =?us-ascii?Q?07H5rH4iZffnSMu5g8jES8MHN46vhXkKy3bord9tzAO/d6BNS5T655lAfsHf?=
 =?us-ascii?Q?p90a6qTGrCHxvYojlY9xgBxaurCV8pccKAM1Mj9pMedeBfbZOkubfbXCrJTm?=
 =?us-ascii?Q?zeoLqUNS8K99+XeLK9gxfC58H29DWVtRmhw/nVevuWjRidlH9ktU9/ySLQBO?=
 =?us-ascii?Q?SUvnUz6b7wvoGDSC5m04bi/n2OIlJzHwT/fRjOr1Ra19uUfQqONaoPvAsJHD?=
 =?us-ascii?Q?bmN+yfLMey4B+cH/LFw1prfOtnnQrFpLh+g/C+drfi4BeOBGKNTRaLR4brVt?=
 =?us-ascii?Q?r+Y+NpPl0h0w08x+jqXOp5M7RQQp15xTTD+tUXJQoHCFPKECv8h9DJ9AUpN8?=
 =?us-ascii?Q?wqxPFYK3+BB1hPj4tEO39UUcnR3XT7WkV5ZYppqnmJIw0xhho6ohglbwh7IP?=
 =?us-ascii?Q?4Iar1N07iFu0k9zegmBJRux9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47349ac6-b9db-45c2-8c78-08d9633ae6e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 17:58:08.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV8ZXT8zKghHYJ0PTERD//Xd7LfvWtnBDqWhX1APv8qhcsoZltjvJeiZBdGX6dFX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 19, 2021 at 11:54:33AM -0600, Alex Williamson wrote:

> Nope.  The only requests for merges through my tree that I'm aware of
> were [1] and what I understand was the evolution of that here now [2].
> Maybe you're thinking of [3], which I do see in mainline where this was
> 2/2 in that series but afaict only patch 1/2 was committed.  I guess
> that explains why there was no respin based on comments for this patch.
> Thanks,

Tony,

If you take Alex's tree from here:

https://github.com/awilliam/linux-vfio/commits/next

And rebase + repost exactly the patches you need applied it would be
helpful.

Jason
