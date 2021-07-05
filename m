Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC0AC07E99
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982026193E
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGEOQ1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 10:16:27 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:55136
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230414AbhGEOQ1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 5 Jul 2021 10:16:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILHtBMFJb1SvAj5PTrKNRYe0Ck+/4YSyq571DbARWcAeGbqxpWs3X6H+EjB6SqzytWANMoIaSPqxi5HBHL4GToGdzE+B1ni1LyOTtSl+cVAtDiATYKxv2qPe11uFoCtpwg8mX4IvLXXhO9Nc975vgm6IIqsNEhur3n/P+RwJ+s2fE2nf/0Isu6+angrLFGkCD2eG+ugplfMQ7Hx6A37va7dt7Di2FOZb3cpz6j+OVELpg7iCs2OswTBhqX/i3G94uaHH6Jgwl/fYnQHJ/Tz4IX9in8vlkRHVI2aQbPjAy37h+S3DRuc+jKUsbWmt8ulPZ+u8L8DD73hxhJOTSAcuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugoHHh/DfKI6UNtrpbNWT6uwyiqDrJ8A8fxE3cQabp4=;
 b=X6obnmS88KHv0TdLLrIbe2CHHs59xa56mEhaCA0nHA/iPcp24pKEuGzmd4ozr82stg/6QMZnZcuYB4hqMqIaBvQFMFurEJk7XCBsXFLGmjoayLcl51ibpctSjJZzq1e9T9irMW5yPmy41AxZ5mQzlqxNNonn1DfL5WQHUbYWOO75lmmcVwfVG1LogYPmIa/DT80q99nvFukl3iIWjE11fr8lo7VXSkUDnGnHdHlsvz7eJX/pSqe1usQ1bPi43zGatTCmovR72yJNLWpAvU9uauux2dnfi8NEsi+vB73eDzissV1kdjkcMyVegVdvGKjrXLua2PAldazaK90Orb/Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugoHHh/DfKI6UNtrpbNWT6uwyiqDrJ8A8fxE3cQabp4=;
 b=bGi5LMVAWw+ynf1msMoSJIYs7z6AF++UghGCbImJM+ISzsKlTgBaWqo0HnNs0P97WwUGaGhZxS1yV3mnkWwlsZIm6xiH2q7r34bjzxlY0xwej7u7ly6dYvYenaBKKBPU80ADTrFdPMbJMsgYpXfIPE7GOSuDJy6ceUR9xHB5ZoJ2enxc7RUzFmxHlfml2UAEg1c8V7F9xpnP3J5fS72Kej6W6hcfbwrXUbwKX4S6o1Rut1yhXcqmx9ul7FUKW+hE7Rqci4drXoFVMrvDfgPlgOYcoxFCIcc/MOXlVCPnqaR6xBY4J4c+hx8ngYfAfF3S9Gwatvjz1qhjYMISH+tV9A==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 14:13:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 14:13:49 +0000
Date:   Mon, 5 Jul 2021 11:13:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210705141348.GN4459@nvidia.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <20210628222923.21a257c8.pasic@linux.ibm.com>
 <25edecce-0795-3b00-a155-bfcc8499f1be@linux.ibm.com>
 <20210701003941.685c524c.pasic@linux.ibm.com>
 <8b742188-d8a2-cf4e-e9de-0ca6f3d829b3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b742188-d8a2-cf4e-e9de-0ca6f3d829b3@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0105.namprd02.prod.outlook.com
 (2603:10b6:208:51::46) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0105.namprd02.prod.outlook.com (2603:10b6:208:51::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.28 via Frontend Transport; Mon, 5 Jul 2021 14:13:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m0PM4-003og6-3v; Mon, 05 Jul 2021 11:13:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ccb8ba6-b591-4157-6418-08d93fbf1bfb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB519126342E3B33F4D2FAECF5C21C9@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7s4PVQ856H5BJUSY+ekJMBXkl7tGYex/xPXA85HA9WUjLjK2V29P5dXAOfRWi7Kl5l2DuPGi16W/7noM+fqmpZrs9V5HaejtaMlveZtooUdpTqgin6PWT7fSNWKVIsQyRhhqRlSriIqdAZQLDDE6l+iUTMMG/kJygktNHnxwB3nO4YzZm0LDtmpz1VJP8RPG6x0XxfgduDCOIlZU8LrIs/sLCKjFzep8l3fDwRksRIoHe8crNBcKn7UgTKRc+/SLX8QiKKFHn15ScyfSUVZXaqEhgTsWeZXVXGQVM9RALQh2iT0YHWKfxiErcg1TcTQMrWHZ+ctG/IpZzKn23igRHgEliKJ6+DwHz1FykTIvk7vNtlHMtcNDE5hDlualymrxYGxtSoVD0RJrHyBCKHuItWr+JajL2hjIt/9AXWUm+KrIX2gdpmCwkRDapskNg7E4LZSGNOLT5Z9EpUomJPGetXzChxqha6IhXzeKtZyFRU3WlGRJdMs5ivEZOd51u+O9StcY2xehVC8bmSSt7vWagujx/KIxmMfZNw0HFwrIOm95hSAjFxf4ZtKa5ZFyjfb1aN8WMnvazLV7Xc9A9BlhxzyF2W71lVWx1Rmf66wj2AiZAsGMUygx2P1gYbBlbQrRHnCgrxtsmSGVYxoQ/ldvJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(38100700002)(426003)(8936002)(186003)(6916009)(86362001)(8676002)(1076003)(4744005)(9746002)(2616005)(9786002)(33656002)(66476007)(5660300002)(4326008)(66556008)(83380400001)(316002)(66946007)(36756003)(26005)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHJXYU9Qb0RiRlFucHJYS050S2RwRmpYd1d0TUV5dWFrQ0MzM3JLYk9JUVZo?=
 =?utf-8?B?c0dNNzh2dU9BRDhrdll2aW03bGNWYkh6SEt1TVNySkpoaEVKOVZBTDRoS29v?=
 =?utf-8?B?QzQyQk9qb1FoMlR5aXUwU0F2VTA2Y0lSazFORUYrMGdiSXdDTEh5bjBqU3lq?=
 =?utf-8?B?dTg4MThKT1pjeDlQVFRHdTRETm1uaWMzRmlBVkxQVEF0WjNUQVJTR2pIVncy?=
 =?utf-8?B?dEN3M2cwVFZBdWVKVmdVSzZqWERiYTRaL2JrcTU1OHdaZ1plVGFqRkRTcms2?=
 =?utf-8?B?TkhKeW1OSW9zTWVqdjczTnFkNWMrcEZUeFBxMUhuZkhPQXE3dzZ0NzFKdlVk?=
 =?utf-8?B?VXk3dUt2eEpyMkhqNG4reFMwWVZKUG90VFFaYk45UmF2aGxzcnE0YnFJOE02?=
 =?utf-8?B?NW12T3hMTDVURkJLTzJsb2I2TFM2RnNuTzlQeDcwMWwvSTJuVVoxb0R0OHk0?=
 =?utf-8?B?SUxTL1lPR0lhZDZMbThTZXR5VE5ReUg4ZGlPSXQ2QnpOa1NDREVzVzJCYlhH?=
 =?utf-8?B?MGh0eWdwSEsxZ1lmZ3p6WldjVjVNWlY5eGRYUUc3MmRnQTF6T0MwbnpkVW94?=
 =?utf-8?B?R3ZpbmUvbXNSTG5EYTNlaVkxZ0t5SjVrQnpGclNhY0owMExQRGVRc29MZVQ5?=
 =?utf-8?B?RnA4NWZmN2ZPQjFmZHRCWEJHRk9YNG01RnJPOFJVUnp4UjRZVFRHUjlEMFpC?=
 =?utf-8?B?NjdhdXlFZzN1VzFlcFVMUzhjT3NFYlhrQWhadnVWdVczRjNWR0xDK1ZIbkVs?=
 =?utf-8?B?N2dqdWFOZnJlczRXTGFNZGlQbFM5a1h6R29PQjRqZjE2ME0rSFVWS25heVha?=
 =?utf-8?B?NEN3c2lNdnloNCtPQVZkb2loS1ZJcll6UlBaaTFlL2NRcCtzcFlwT2lWaHlT?=
 =?utf-8?B?NUk0WWJiUjZMUlYxSUNhcitIWWt5Wi9jdW1EaEM2SmxBd2dtZitvbE9VQko2?=
 =?utf-8?B?WjdZNGpGQXUwc0J0RVlMWWFVVmZJUjNXRU5icE1GWW14MndXdmRnYnZ6K0o2?=
 =?utf-8?B?QncrTmFhMDF2SGliV3JNU0EyWmFzYXdMSkh4N1NoOEp0NWxBRWtWQVJSTUg3?=
 =?utf-8?B?bnhWbzBkM3BrZk5CMERmOEJwWVZ6V2w1ZXNraGhDaWRzSnBRRlVTTnBxNVNl?=
 =?utf-8?B?OE96bnpaTDlybzlHb3huZ1ptSEdkMXowSC8xckd6a3hYOVFQR0V0M3k4ZVp2?=
 =?utf-8?B?MzRTVEdoa3ZDck51ZlVtUkFlYzkvTnRBZk8zeGc3QVFyTGlrV2F6cWtQcTE3?=
 =?utf-8?B?emxXZjYyR05aWmlocEg4bFA0TDUyTE1abm9MTXZSTWszc0Z5RWtqRW5CZ0VB?=
 =?utf-8?B?VHhiR2c5TjhrNXkwVnVqeEFUY2k3VkJvY0owcHV1R2ZFb0x1OHBPeUk1eVpN?=
 =?utf-8?B?U1ljT3ZGOGhWSkJOU2EvTjFTMXlHeVNsS2pwMEZCdzdwSlQvd3hTTTltaFJT?=
 =?utf-8?B?T2lidEpyZ1hnSktrb1hUTCs2TndsNGNlc1hOZU5Ua1VaSTFOWHE1c1JKVGhB?=
 =?utf-8?B?NGFOOVNMbTNCbTFrMnIrTGdqRmpQb2I1UVRtVVhLVWtaOGQ3Sm9WQ1oxZGQz?=
 =?utf-8?B?dG56cFZiK2ZCNWxhQlNjTFoxa01wb20yZVVCTDY2TnBrVE1hNGx0cDVMcnpj?=
 =?utf-8?B?SFFMVktZRkNZWHFZWmFCNjJmR0g3ZzEvZVZubVl6ZUNYUzNFQXlyc3hvQmg4?=
 =?utf-8?B?b0JYdm81TlJ3cUh4cklNT1RLbU9WVEFsbWoraHlBbnBhdkpYVGsvekJwT2pC?=
 =?utf-8?Q?28jhpbGwQ0GhcKmWO6V0IGH8xTObeTUR3QMxZMG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccb8ba6-b591-4157-6418-08d93fbf1bfb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 14:13:49.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFEKKP3N0iF/xYmElTYn0neaOBR1ea4AKap8MUZyAKrJEyyqcqxTD3dNZCR2ooY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 01, 2021 at 10:28:52AM -0400, Tony Krowiak wrote:

> > I think Jason was talking about open coding locks in general.
> 
> That may be so, but his comments were in support of his
> statement that the  mutex + wait_queue did not resolve
> the issue reported vai the lockdep splat because it turned
> off lockdep.

Rgiht, if this used to be proper locks and lockdep complained then
whatever potential deadlock it found is not magically removed by going
to a wait_queue. It just removes the lockdep annotations that would
identify the issue early.

This is why people should not open code locks, it completely defeats
lockdep. That alone is merit enough for this patch.

Jason
