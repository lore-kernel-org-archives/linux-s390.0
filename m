Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB4C4707C
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403B961104
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 18:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhEUSb6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 May 2021 14:31:58 -0400
Received: from mail-bn8nam08on2071.outbound.protection.outlook.com ([40.107.100.71]:63360
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234895AbhEUSb5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 May 2021 14:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXx/mAxHNs6e9vhLNsUyud43TtLE6iCO1xKaVQ9Djc5JgC3qsRbmFi4hR1/YgcwtBHrEcN2VVtkUeVU0UAUa5qAHLmRDYxmLkSFaUtiE5s0D1DRtf+AeupWDQtWu4g49IgpZbGWtt2llQEgnLbLr2b7XgoaRBBHWpMzrZ18QqFXdy9QIqHXMNZOWhvP9URZc824hvv5yZ8Q6h2q9bbX5FAQr7XgaZimxbb3fFidS/wRNrnvNiVFVzBh4pDrppz27322/0jLfNXA83aSZkprEFZpaImM2muYgJfU1QusZPGMLno5+5gb2UB5wXDv9Rbte+Zu4dDbhCGsIrt5ExtK23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ra5PAuaEYT3SZjERc0yt2ufY0HBTmHAbpdHvob8ezg=;
 b=PT7FV/pSaEumcD3ppIrjmm3PYXFvhHTwsxjPjihbAQg7ryDG9sanLdbPBERZod1snNLVvqUInp6Fp0KFhG6dOSUj2fJOm5DFire3xTpTWzkRW9FeV174ws1kmn6zhwOOItmvXnyhb25p+nuinPJTvQZ+0E0TOa6x+5bEqUQDHyeZGLlr4erKXUOtXGMbEDMqWmlFquWPBaPCsVD2pEw1gWHUxl21IAZa4qzwdHZuBf/TuEmuFOlSPEXT3YkZsVO75SbzReFoHN4tL50yZ7QzipX5EmV9CY5oSbstdqI0xv1IFv4PWSh8HjQuoX/mkwmN5cmupGt6FQIfxjvRNFKhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ra5PAuaEYT3SZjERc0yt2ufY0HBTmHAbpdHvob8ezg=;
 b=ZefDY6MO6f6rtQkKl+y58jEsUhLIHnuNexsn7YFmD3O85slxw89VJ+S7xORIQ4B3Qu+EcDa2/donfR2uJbKdyqz4T0Y60RnGojBy5IPBX47kslN5vtBhSTXdqfuRgWYE3MkNfTI3UEA+MfBetH9U2m3JZrbxj/buUefzkPYBLaPl9+1NlNssDKEAoBBKZwNlqTo4WykgSciFTGjPEJ0Um01Wz4l1Zfwj9jB+8EpdZZi99qwzSOTdvcOl9DK7yybJ1AiILEv/+7t80m6mZhWQNxesaJdkE3CSp7AiO+vU4CKjkKuRIuFFOHMI+GP9JZsU95i8mYJ2pq0XXSIz6KE2/g==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 18:30:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4150.025; Fri, 21 May 2021
 18:30:33 +0000
Date:   Fri, 21 May 2021 15:30:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210521183031.GC1002214@nvidia.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
 <20210519161610.GO1002214@nvidia.com>
 <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
 <20210519232202.GV1002214@nvidia.com>
 <07dfdf17-f56e-6dd1-8011-eacfbe741e9e@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dfdf17-f56e-6dd1-8011-eacfbe741e9e@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend Transport; Fri, 21 May 2021 18:30:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lk9up-00CZWw-F8; Fri, 21 May 2021 15:30:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc73a69e-8c3f-4a44-f675-08d91c8684e2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5521F9514CF24836B5341381C2299@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMoB5lY0kc9D9zcz12afkaNERVnaQ26qvxQ5+3BfiakxyDk9G5jtnN3ScSHpUvZRaHMpHHFlE8pJd499hcOstSdQy4uE7VxWSMaIm+f6cT8+DZorjDQvJKhSjh81Kqnz+pdEjgkbU1tcq+QiL3L079qDKW+x6HSAlpe7R7R9uwtcjtd5bpcCp16WI7FpZHE7EVye9y/72HsFLxNdNg/nI2nBM6elRgX4sxnpOjUS/NeMotMEGNDjrCeJOb/lyYkCDEWiGDGWpAMxX4HvZKYNHp9cH+2ii7OYj2uuPV63ZwACQq+Unxn2oH9d55ggMRBQUJLr26k6t2vv+Mr3cfk6IZFLCo+olo4fjZRpGI+v50EafgPFEaAQRk/WLaQ2Nrs+ODddfu3ghosmP6YTt3NBGrFzihAhUAa0cuJ1/T3xckWf0pNZWIz0bPp+RV1RCTiYq3jZ9YTMx6EYo/LIFxGzypR5yO7Ei0POy2aOst15GTW1c/08mkc0TCoIhjKdCvkF+uB2tG+BoP5Cdn1wxjM9CNYD4EgKmofKxNsW6BlC7uWl0DTpOwiR6+oXIKJd1c3fSQOiPdEjFfGRzRnRvTdDOxukRcPPJXhfKM9HiCPhMy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(1076003)(26005)(9746002)(9786002)(2906002)(2616005)(4326008)(8936002)(426003)(186003)(33656002)(38100700002)(66476007)(478600001)(66946007)(83380400001)(36756003)(107886003)(66556008)(86362001)(5660300002)(8676002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Wd7Pj7xF6LauSK0CtIxEWcUtSZMxnspBL0vCiCbHJiwJWXBMB3GR57Xa79FA?=
 =?us-ascii?Q?w22CDvSbQc5l7In/h7NU5aklRM2k9nUNdsLwH0nim8c6dGiztVnTLpxIPkDI?=
 =?us-ascii?Q?g1AeZRtU3D6vpAvMoT2CYDaR1tFtGQdRtsajTH80rOfrfk/j1xOev0PonnAk?=
 =?us-ascii?Q?bsjHof7jHo5bUsK4l8vnV0GYGEczUpcrZgM+fiPrQX2np6xFzwaFPuqmHu25?=
 =?us-ascii?Q?wfqX48b6V6t02cvkbrCYlnJJBAjb2W1krQ+S9yol6b4YCgCVzJ8NpInEwqyt?=
 =?us-ascii?Q?ruyKVVCnnw3cfwf1Buy/hpbHAqBXTjWrroZh7BaAAeTeA8uiXOa4E/IQl5y0?=
 =?us-ascii?Q?GBfvwd5GFswdlUvwl6f8eXDTVlMxKcC+JS5S9CJSwOnk6eRoJUJf3u60Nku5?=
 =?us-ascii?Q?d9PQcadU9BQ4tNv16B+X2pZkx7sCQ+Ssa6es4ShUJDsjVaUOLudjGd661rp2?=
 =?us-ascii?Q?wzuKtK3WkwpcWhBzrkfoJZfvYtmxT+VOVGt2AVWUmsyDih5oT+zhdK5Nxr2m?=
 =?us-ascii?Q?68Aiklz9LGZ/hXuRU4n7EWDAQVvzuG/chda0Zn2EpB0npAZLozaFWJQ73isC?=
 =?us-ascii?Q?ImKocx9E+WlX7G5P8FQN2mSPVSOTA1vvpesj/Khyo/9zv10WO3aMZXpbl+7E?=
 =?us-ascii?Q?1O4KG+5OEE/xFcK5t9/KGIWibq/TG0fPNyWQSVnXshG9OLIz1E5FG8Dg1waO?=
 =?us-ascii?Q?Enhtu+fAxFdEAQcXnV7q+m5Yw6xxa7EosvwfD6fHoVq87ugxXAwiAcs5HJgj?=
 =?us-ascii?Q?a4E8OhMWrK3kFdcMOqobh6zezFcar0qA+Xte2c6cmCfDkz8OwssxUhNEP2Jv?=
 =?us-ascii?Q?PhII8YwCxValuUZhAtyuCUjeSKWa0CbFl58x5UYGmZMwWNlTfoNHV6G2NjJO?=
 =?us-ascii?Q?wCa6ev4QUByxTTQNCGlbQokq701vKbfmHoMvuf/GSMr/9+2PKTZWJTrh0qey?=
 =?us-ascii?Q?tkwKuMIhmcfTjydZ9pg9mZyFUsHfRPEVmnKsL2oMcYpJJpeyDL0Hcg6QaVWX?=
 =?us-ascii?Q?trTn80bLxyd1Qu6sBPZ4DZ2edz8fBlkaAvUmFnHzh8T2uL76k6/Lyr9CFOjH?=
 =?us-ascii?Q?v+DeH5mwh5lT1qzAdE9QPsyrnP6nt1N1MVypCNktjUe30veswj7rFSKX138F?=
 =?us-ascii?Q?GFiDSq3Tp9aTLgpmbNYM163m3D9W++WmU1jAQpjTGYCc9YdkVuFrBoQt1V/G?=
 =?us-ascii?Q?Z0JlgtPjnPeE7URtf3LhBTsBCCxPsosIEyIJ3iU47bbBa286+XC8plUalkfZ?=
 =?us-ascii?Q?rvvno1hMo6kgB/rsoxJ8XLfecwGlZMnxT9KzcQ+J37y+3lr/LQhZzJHyOPWy?=
 =?us-ascii?Q?l74wblBLUvDiCQjZI1FI9J1G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc73a69e-8c3f-4a44-f675-08d91c8684e2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 18:30:33.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9uNW8VbQIP48Gq1K7ZRKtRecPXshZVcxp5lxAtApTHbFlaW6CrtFMeXx9dphi37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 21, 2021 at 02:24:33PM -0400, Tony Krowiak wrote:
> 
> > The simple solution in sketch is just this:
> 
> The code below results in a lockdep WARN_ON for the
> reasons documented in my comments interspersed in
> the code.

Sure, to be expected for a 2 min effort, but you seem to have solved
it by trivially putting things in the right locking order?

> After trying several different permutations using RCU and
> an rw_semaphore, I came to the conclusion that setting and
> clearing the hook pointer while the mdev fd is being open
> and closed or when the mdev is being removed unnecessarily
> complicates things. There is no good reason to set/clear the
> function pointer at this time, nor is there any compelling
> reason to store the function pointer in a satellite structure
> of the kvm struct. Since the hook function's lifespan coincides
> with the lifespan of the vfio_ap module, why not store it
> when the module is loaded and clear it when the module is
> unloaded? 

Well, the hook function isn't really the problem..

> Access to the function pointer can be controlled by a lock
> that is independent of the matrix_dev->lock, thus avoiding
> potential lock dependencies. Access to the mdev is controlled by
> the matrix_dev lock, so if the mdev is retrieved from the
> matrix_dev->mdev_list in the hook function, then we are assured
> that the mdev will never be accessed after it is freed; problem solved.

This just transforms the problem into needing to hold a lock around
mdev_list while accessing a member of the mdev_list

Is it simpler?

Jason
