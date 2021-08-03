Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABAC4338F
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C415604AC
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 13:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhHCNJF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:09:05 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:24831
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235635AbhHCNJE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Aug 2021 09:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYjUFb2rW5KMAtKARTLIl3dh3Hkh2584WMUjBFI0//4Zrsrjc0czsD+njg9skr+VvA8rmU14SbQKJRKwoZqF2mrpy0O6t9qRCZNCakQLM+m0XIXaviDsf3pK6RL+SU5rkZMFs7aiHeqJVKu4Ie9UDnzp7DOEagZ6eIKTitZA691BLjA6as6bAHagHKN5ZekWGS1ibm8BuuZdcuIlTqQq5SeFTlmDKwEPZbP9ImpYSftlBLpsKvShJtpW4E2C+tF1Xk5hMxi/0ofbMHXo4zJRt/AoHGvTEzat7Mda12UQdRHFB29FW4ZTTSQNrS2qxhKqCM0h7DlFhyY5ACiPGlFD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYCZZfVm5GNdhU0H8T/c8PNwMkXtpxCQlHPQ4xIZOZ4=;
 b=Yphrmj3LAEY+OT8OuOvR0HAUMxKxdzKN7kGZTNrzUZkGasj69Uh6I7M7zKZWtEM8r++qf22/8asleFJBPs6/OSePru0Penv/833Nx6RbQ06H6iafhwhdKHaN+GvrlpVsKNIMyfJnCB2Ybm8BXOi3LHL5RayW00c18ooPOHjY20sGm778j86ImJ1IKK6S2rmik32d1v91jlpfAC30bNqLy63P3YVxZ29J70c4B9fM3Kp0TAF0tEnjRLPq59ApnnIfMji9fa6p2/2PXPWA+L1KHZ8WqgiMU8aSvRNQLYHB5XrOaE+GFqx+He9dYvkSBit+Zhjvk3VNaERvbvya0SiHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYCZZfVm5GNdhU0H8T/c8PNwMkXtpxCQlHPQ4xIZOZ4=;
 b=Gio6a6oBHbA4kb9apLTq7/GprIxT93dqI/5OLbcnrhNmcebAsEIsy+wtjsRpO+xU90uE4uOYZS4Oi0AAcq7NollMXba8JdsLuYOBRNJIYyhj7B1t6dPJ1kly8jyrwyGtsbEJwHKuHodfpHbtYZarLv1YefMbRfYO/ZUsBl0licE5DsY4jkMmkeTSm/ISIcLvdz/QBSbsE5PZUKwF/61+jmo1gWMArxsWpIaDZ0kmbRzP8XTPZcgB6UquKO5aWEbFXduobLlap8iL22LdOBO/vGzqGXWg9lb2iyIOnbDFs6j7QCw9lC29+b3sYZhIUpd3hxFKCU08Va+rVJmmrCMcZw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 13:08:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 13:08:51 +0000
Date:   Tue, 3 Aug 2021 10:08:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210803130850.GY1721383@nvidia.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
 <20210802155355.22b98789.pasic@linux.ibm.com>
 <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
X-ClientProxiedBy: BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 13:08:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAuA6-00C0oU-5g; Tue, 03 Aug 2021 10:08:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2fce375-8537-4e68-b5a7-08d9567fd68e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5253E5FCE596ADC2585ED34BC2F09@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UM640hGisn6ZAhiHr8gBVZOODqy0PwsJcRZn7jhwCXdsAUVicbPwDaGW0HSvoBjF2ZvxZ+LnM2bUikja1nKJ7rhcIwDN0KlSamu9jfSx1pKtwlv/z126OeTGkIG3QCUEYYqAol58bos6k3BJmWBcIazjqD5f15EGjLUXdBBpWeC1ueQmb5HfR/9MB4dfKS5oW81esNa7kV3Ce+Ff7cNeeMaSd3LvjPZtc6lCZjNVdmXiBPMK1le86tU+30UlCbUkEch9OSIkHYjG++u4Iag7yeUlO7K72Mn2hW+/XIqCR0LUG81z++DWG2BueVKk1kykwqzX839ZdUS6pRx8gtxujujJXdxC0CEyeLbT3wXS1nGNW5mOffKfMpVwMdgJb65D1Ir7Kcu4rZaSolD/IK9yQAolpdMaK//pGy5m5mpv6SvwhJJOVtxRJky0puRzQJWqxoBSoc/5ly+QVeKyaakMcEwwuCIuxMLxhMXQCCLUB3KXGsx9i1++3eENY8wpAk5rFXJ5cQfbP+aHDbDlVgaY5Nc4+oqI/PHcje45/hWRth55a92bVIuohT5mDwUu5qjaq2tVTWTVxqjR2ZP7gArS/g8J4K55QMi0Iwj09i/Xo3LPxGGG54FJfVhfZWXLJfhfVrtvwOTvnrzn9NXqEd2W1NuxIBhbMPVzmaqhSH4WYjvW/D8uscZ6MazwJdvPyhtOLDe3NPbvc3NuMAliWXWfP+D0/OGwW0m3owZAo/HwW3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(1076003)(36756003)(86362001)(478600001)(6916009)(966005)(8936002)(4326008)(15650500001)(316002)(33656002)(7416002)(38100700002)(5660300002)(186003)(8676002)(26005)(426003)(9786002)(9746002)(2616005)(2906002)(66556008)(66476007)(66946007)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sr4czLvGs2bC/UU+kgoLdWpWNCGQVUDONcK2keNfev8GiiohghKCEcTU6qN?=
 =?us-ascii?Q?9XucwuetLviv4czMcla9EyKjXbcNJjPxrMZoELGrAWm1ePpk7m1jfH+VTGZd?=
 =?us-ascii?Q?0Yj7hICyGJ4CUELAdX4OgL58ikKdFyDoosdAcJJxwVYUoBI8zkvZaXQ2c+s+?=
 =?us-ascii?Q?NGE2Zoj8foRmH04VIx1TzP4pLAsSZ+InGPV9cn5H1egvZ9YVZk3wCKmev34+?=
 =?us-ascii?Q?gU66dQQwnCv/pUjFicwI+MZR9PLqEjq+BXOxtAxyZNgc0aJ/A2WxZObt6G80?=
 =?us-ascii?Q?/lruXgAjAcYpXYVH51z6lOtMHHR3/U+wp39Mv/TuKxq9ArusmwDGV4fiQNWw?=
 =?us-ascii?Q?6yip6nZO8Mq3ALu3W8Cax/qqdftzn6I0xC1aJZlgWArsqzCDxYp5jizqzfBN?=
 =?us-ascii?Q?bULl6W8eeaIAu9OJ10pyOip0iV1sh1FKs0EI7fvTlAQAgwAWwH0pokEgjybj?=
 =?us-ascii?Q?U7hxvhk6mnfKY1RdfrFzz0VTTS11P/fmtP5qsjjVkrMrz7zYYNzBR7+rL+I5?=
 =?us-ascii?Q?t/cH5f6l/0cCIsTTPP9sE9yx4qWwRHtlrpTvpZEGLr6WcV+ahGTl91XrG5ze?=
 =?us-ascii?Q?JiyOuKX6tOihbBJ7D3+RW4l1NOibpHdmnlnmevuBp6ZrzxO3TBAeeN1FjRdM?=
 =?us-ascii?Q?V0a+SCvxbjrkGGuW48DyBLVRajA4pxwJbY4/KzLj5VilLSHia6P1/hWRFa4+?=
 =?us-ascii?Q?rYGMPfpzNpsbA8zhkooZ5sOvp1FmsqLj7EveaIrCjGU8Gb9BfYofmXZCyhLv?=
 =?us-ascii?Q?r2Xr7ew67xKKZTAfYz+ir5Aj7syF2kEbAWpjfd5a/kxaD7W18AKp7JJC4fz6?=
 =?us-ascii?Q?WDqJno8X7CYpB42pakRY4rIFkLhxgO2lJUbz8per+9KgcXq6l1c9WhiyaPld?=
 =?us-ascii?Q?WZWn8vUpGpqBgzZudSPnDgItMX1X6T69fs0LcShpDo3KMS5esxXH9+tUwN9v?=
 =?us-ascii?Q?r2niW2B1YFRytqSh20HxokA+e+r3LRBNCs8ZXbw/YVzBWKmKCHJFvvkBAZuk?=
 =?us-ascii?Q?473ffn3vVOyy5rdvn0HaqmSGo8b4ApmdvusS3iHtEKKvP2soRU5jISSvg8Vy?=
 =?us-ascii?Q?kxGj+MBFhZDjNfsBCSA4Q+NjCckG8E0r15VAY+U4cQva48jXkig+boSc+z1G?=
 =?us-ascii?Q?3AHUi+BC7KU+3S+SwoQiuM2AyqBcMp/iUirLFk7Km37TU1L3rt1kl5BGrVDh?=
 =?us-ascii?Q?6ESM7Ke0f+h/4n7PzfN4fiRLa9U25Q2VuJsvH8Shx1PDh4UT9MvEqT2GsAzJ?=
 =?us-ascii?Q?1H4axSYSCGGvT+5fDKxoKgAzmAGu4zGz8hG/A4T3yWtKa4hpZhRA8Z6hn9qS?=
 =?us-ascii?Q?6fXJvvTfGJC87oX/sSnKqt4G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fce375-8537-4e68-b5a7-08d9567fd68e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 13:08:51.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22UwEGgOaNcB9+Mt7KiFMj1HGlPu3b9wSblIL4UGIhkaVV2Kp3EZ0Kl2JeKSGmTE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 02, 2021 at 12:32:12PM -0400, Tony Krowiak wrote:
> On 8/2/21 9:53 AM, Halil Pasic wrote:
> > On Mon, 2 Aug 2021 09:10:26 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> > 
> > > PING!
> > > 
> > > This patch will pre-req version 17 of a patch series I have waiting in
> > > the wings,
> > > so I'd like to get this one merged ASAP. In particular, if a KVM
> > > maintainer can
> > > take a look at the comments concerning the taking of the kvm->lock
> > > before the
> > > matrix_mdev->lock it would be greatly appreciated. Those comments begin with
> > > Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.
> > As far as I'm concerned, we can move forward with this. Was this
> > supposed to go in via Alex's tree?
> 
> I am not certain, Christian queued the previous patches related to
> this on:
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
> 
> Jason G., since this will need to be integrated with your other patches,
> where should this be queued?

I prefer changes to the vfio stuff go to Alex as we are changing it a
lot as well this cycle.

Jason
