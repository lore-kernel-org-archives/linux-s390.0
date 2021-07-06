Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A616C07E96
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AE461C22
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhGFPPd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhGFPPc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 11:15:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D4FC0613E0;
        Tue,  6 Jul 2021 06:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM7cODln26KXVapg0xmOOen7lueun2sft4VJQcaGVTS7APJyaXmFtHlHrrSU7ufLmsel4oGD8HBW2dWHxrsfDQU5MJjhlv7nRxhqeEOEVKf12iNbC//EZ5dfCMRHXYT9/MblQEqPXjgJg0UpwjHj0i4XaFajwrF6YhauQYOwV9fJfqQu7E9xGbTvZsHHZFa2pceQJwISpgrekixiA+TazhB5kUzfLHo3eVm7oJK2kiPZphXEIxmh0J0AwkLOadTmbhoU2GFnVHUJQ/dm9WylXYhpfCJU/V5eC8wZmfI5PajOVJAGuYQSI4fOMZ67ku9p0NFXQKbxXNSYli32LnBXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZtPZwJKtcnC0xaurdWbLUqySph6tDQFiLffsWOi5gE=;
 b=XfHkRrBvvpA7g1JfJ/sjdcPTVyTev6xnslOBaKyJRuE5Z9IbqVlpwN5ZZINJsp5fUOttfnkx2xQ01hV397uBLYk7AB56duW5oveH2vKL6m2diinWtfzTkL7Wfc2vh8o23vUBDaVnMeOkFJNwCWv5B6RzuQU8ZNHSVA8krqQjOx0CrIguL/ClHiiEJHxCf5WgZFbjqrH+3/VNew4HlNpTmf2s+1Wlzf9I9IKBO+sALcSX8QXuK8c/gu2K0Xu0Opfqy1oV3Rnnxa2yUhPGd2e9PE1MMMe/+a6vHwb7MNSoUmfKG9xMyFUVpaEVg1ODxsYOifxVpgv50UFCsXVZjliPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZtPZwJKtcnC0xaurdWbLUqySph6tDQFiLffsWOi5gE=;
 b=nYWKi8zTPSEkkXg4FZOXsQnGSQYCBCyzWAVvwv58NDoJKcXgOm4kwv4fUFPZ/W1Yr+3uHGF5+PcWkztCGEsr6a5TQvFp/3X7ydFd214/kJNnKrySEaJ0MzDbt2jra813+kVGu/7yAfNRoJ2TlGBQDGFsNE9kUn6dRXM/AK+5YEpX1xjwdBqrANhU3x4QCk191CewuhAWZZaptcbOfWtgJY0RFlLIDGtUWP0UbkMwz54pcDTqxhiqUG5ftwMP1iw/jwZ3Z8cMrzCeCxIfdbnGaDM3Icmqw6E232uzt6eiqwa545ESB9VAzzuWAXLKsEAdr88rYuA5CoBSZWfPqObPzQ==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 13:49:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.020; Tue, 6 Jul 2021
 13:49:41 +0000
Date:   Tue, 6 Jul 2021 10:49:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210706134939.GX4459@nvidia.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <20210628222923.21a257c8.pasic@linux.ibm.com>
 <25edecce-0795-3b00-a155-bfcc8499f1be@linux.ibm.com>
 <20210701003941.685c524c.pasic@linux.ibm.com>
 <8b742188-d8a2-cf4e-e9de-0ca6f3d829b3@linux.ibm.com>
 <20210705141348.GN4459@nvidia.com>
 <11025fe5-0751-b7ab-9250-b21c10382edd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11025fe5-0751-b7ab-9250-b21c10382edd@linux.ibm.com>
X-ClientProxiedBy: CH2PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:610:5b::37) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Tue, 6 Jul 2021 13:49:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m0lSF-004QgD-Iu; Tue, 06 Jul 2021 10:49:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dbe3f7d-90a4-4be6-6515-08d94084e771
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5078CCDDE736DFDF1CCB4C25C21B9@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5ByDzQt07WgfjRQIPWtGcjybLNQHT1iZ6qszPHN6qy9BD462Ue3CUD0gnH58Raoo8mt9Rp5UOPzFZpW5Ru5IPXiApBbZI6WJX4BFRgHo9oAjw/LFQ1d+WiCygQlo5sFtqbXoa81GzLmmxPXNIAKL8kZcBK+uN3onjLHqdCt9S9ws5fZJ7CKomSQuVltn9FfRfcvDbGUrCJymQM4m8KF9h8GNFWg3WCjBD3w88wIiJQVsJvhoo0FG6NaGa2jKrxj886+c318Der3OFUOOItelx1mRilfueK6T6egf+w5cFfPH+ppTpWLvgB6+LUZwEha7TzjI/30mITNAtyVHwkvD4c4e77DWFH6sLhSxONdcUJ5ouOHM9cjtC5QIe9szm7coBTjbi/0y1Oc6g77Xzn7g4GhGw/d7//jMFmYQkh0NK8Oc+dF35uVbTIfUPbvKplttFRxBgq2WQcrTdcZkGFW7i4pLk58C7+qAkLuhDvfpMQiBzfUeqxben6ghm0e7gvAsjQXVwN9413lakteM4mJY7ROtqqXi7icsYh4QL8SSRt8TnUGYx4+bFQKiIleb5Daoff79HY5u+pakGz6VvhIEop8OB0PxK8Tv9UQdQ/yot+TxmGMJ4i0O4nrsnUXpRME9sKo/0i4uWNVQmKB4H40iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(8936002)(6916009)(2616005)(86362001)(66476007)(316002)(1076003)(83380400001)(8676002)(426003)(9786002)(9746002)(2906002)(186003)(66946007)(53546011)(66556008)(38100700002)(26005)(5660300002)(33656002)(478600001)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FvM3dZQ2tMT1Zma2VYR1A0SU5OOFBhMEMyM3BWTjN0TnZDMi9YZ2pZRW1C?=
 =?utf-8?B?bEJEMmlkREMzNGNWem0zbityY1lFVm5NMmFGd1p4RFBNelJ4d08yc0pqRlJl?=
 =?utf-8?B?VkRMcThTakd0cTk3Z0RaUW5UeDdxU0lCdmxjVld6czc0NTE4OC9PVXg2MXNU?=
 =?utf-8?B?VWc3WlVXREVaVVMwSjdkQk9Fc3VoSm9hRklIS005V3c0TC9vU1Q5OXhqanVI?=
 =?utf-8?B?STVGOUJYMGZLMnpLbnJFcGRzS2JJRm1sZ3JRRmZZVlNzZTBvWnBDakJGVldr?=
 =?utf-8?B?Qmx0cjhYTTh6QTNWWUNncVVCdzJCNUJBaS95SUxDNUVuTDNVYjJyWFU5Qllx?=
 =?utf-8?B?aHRKWG1OaUIzN2pySFV1RUZhWGFSOTlyUDRzMEZpU2x5Y2VRSXB6YUM1SWtt?=
 =?utf-8?B?Rzk0dHFVZlNQeCtLaExKN2ZZWkRFTlV5bFMvZFV5VnVYRWdLSVoxOTlQbGhJ?=
 =?utf-8?B?czZ6L3R3SlQrZXEyNlBuSTZzRmh3TUdsSGFzWWY0Q3dsUDM3aXphL284K3VD?=
 =?utf-8?B?NkRqTU5UeDBvNHZpMkgwMDVKM3NHYm9vTytTMVJlKzJZNUJKNkJRQm9TTnV1?=
 =?utf-8?B?OGhybFBVVG5tOXhFMG0xMUFDMVMxd2xyU1VzWGlWcCtYSTBiN2RnWjFsVkFu?=
 =?utf-8?B?Q1pZWFJGMVZkRUJFdWY5ZFhUY2graXRaRkpsSEsvYzVseUJXVWhSVUFGL0Z2?=
 =?utf-8?B?bEpBbUZkZU9jeXpWQjBuRHlOeHRnR1pnaGZnS0l0MkV1NitRZlFZWXllZkIz?=
 =?utf-8?B?VkphZHRSbHBoaTVKNDFmdnJ0UWUrQTFUd2IvdFQ2bllHcHR5K3Y5WDdCaFZr?=
 =?utf-8?B?cktEVElwTTNUUG1vc3hOYklleDc2cTFucFJ0aC9XSDZZTUdiY1o0dWlJV2h2?=
 =?utf-8?B?Q2NxQTRmRm9sa3M5M0phZyt0ZXhheThzVXI2RUp1eVk5b1NGeFdjY2xyRGpt?=
 =?utf-8?B?bFZpcTNkNlpPTmNIY3NpR0xIRXdRVnN4STJGQWkwQlRuVkpBVlBVZnRDMkQv?=
 =?utf-8?B?dzFFRUF0NndKUFlWUzBtRUFQcU9EQ1JobmdONXpTZHhOMUV5b3Y2OUJzb0Zs?=
 =?utf-8?B?c1N5MTZ6ZUdQbVVWcWx0bVZpWW9iRGVqUkk3OXJVU3h5ZjV6Umg5TGNvRlpr?=
 =?utf-8?B?dzAveWtYQ3p6cGNReEs0YWw4RGt6S1NtSENOQUZLcWFxS3E0aENoam9Rd3BG?=
 =?utf-8?B?cjRQWGNsWmVMYVA3N0dmZWswNU5LdkduRkJhTUVqUHBuT2NjUjJWSVM2SGJl?=
 =?utf-8?B?b013bmw5Vm1FcVB3WGsrSEhMcm43bzI5b21zMitSQTNMVzVHOHU0dC9kL2hI?=
 =?utf-8?B?SGRVWXlhdWFCdis1NkxBYThlU3hjc0tkaVR3K3liSStQZGNHMXJSenV2NWU5?=
 =?utf-8?B?QkpuWkZteERWRDY5L1BFN0NGczg3OEFtWndqNXZVK01XbWVnTWVnenFxWXRV?=
 =?utf-8?B?L2tkeTBuaHoySkRLRzdBS01ZckVQbzJkK2xCaHZUNW5VZEY5dnFFLzVCTWRk?=
 =?utf-8?B?ZVJxcUFlZHN2ZGFtYjNpNEp2OGErRVA3ZnczZWlaUUdrNlNSOW9ORzRNMjBv?=
 =?utf-8?B?NnZYWHNkRU5sREREUVRiU05mdTc4M09yclhVdVNnVWxUczdheWMzdG51Z3B0?=
 =?utf-8?B?UDhHamJHQk9ReVNjOTVIR2JUVWphMWljS0xUSkNsRkV4eVNDTDY2ZVpOS3Jw?=
 =?utf-8?B?SXZMMmRTdDVDcHl5MDY4KzlxcFB5NlkyNGFWTGtOT0F3akJIYmZnN1R6bUtY?=
 =?utf-8?Q?NkBX97cE/ut7B9aqoNRrPaqEZfP6pRpniQAosNT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbe3f7d-90a4-4be6-6515-08d94084e771
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 13:49:41.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv9lRA1wiRCIShxr/HFg+Mjah+Q4/+HcMcj0ykh1hY0gFb+Iyv7qwhDivY8cfWRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 06, 2021 at 09:39:29AM -0400, Tony Krowiak wrote:
> 
> 
> On 7/5/21 10:13 AM, Jason Gunthorpe wrote:
> > On Thu, Jul 01, 2021 at 10:28:52AM -0400, Tony Krowiak wrote:
> > 
> > > > I think Jason was talking about open coding locks in general.
> > > That may be so, but his comments were in support of his
> > > statement that the  mutex + wait_queue did not resolve
> > > the issue reported vai the lockdep splat because it turned
> > > off lockdep.
> > Rgiht, if this used to be proper locks and lockdep complained then
> > whatever potential deadlock it found is not magically removed by going
> > to a wait_queue. It just removes the lockdep annotations that would
> > identify the issue early.
> > 
> > This is why people should not open code locks, it completely defeats
> > lockdep. That alone is merit enough for this patch.
> 
> When you use the phrase "open code locks", to what are you
> specifically referring? I am confused by the use of the phrase
> "open code" in this context because open coding, at least as
> I understand it, has to do with data analysis.

"open code" here means you write the algorithm of a standard lock in
your own functions instead of calling the standard library.

Testing/setting the busy and sleeping on a wait_event is exactly a
standard lock.

Ie if I write

   for (len = 0; str[len] != 0; len++)
           ;

Then I have open coded strlen()

Jason
