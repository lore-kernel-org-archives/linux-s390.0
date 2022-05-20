Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F57C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349911AbiETNoW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349932AbiETNoT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 09:44:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702416D486
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 06:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUZv3dMWVaxfIPlM4KlGpIssnZu+imFPlW66RxZDYfZep/Nw12NJ9PSxmWEelfpjarQiqs07gpBWeXOgPWZQC0kS/feVYxlL7bH1XlxPiy7mHnZekvfx/VMn0CKo7TzH7VX+UFRQlmNcHBrxWaT+KpPJieKtySdt/YyYd2/PnfoaJUCCrGg1UVbGLeAugkbNsoyX1A/Vuo1bsEFKnCzecMBkFe9+STi7G/BdFfr2uOezu6EydFfERPhxKJumwxBg3+1e4WDwwgnUXIdFf9bk/aCVYgOFR7wvHL/x/HF5/iOczRZf2V12ohIjWChzpQuSZVQFduArE2xiJwuTAPCh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDFGMOXWniqDVQWjr0CAhaKgXJyiSM7yuTZVVWq8VFQ=;
 b=Bt/TE60gg28pXcIMfGjcLGOysb3rvmuE9SYLMiz9JWe2KB9J+dTW7/7dc5G+DT8962ogVnVbuC08vOeg6VlZXupi5EeRWBcOedC/caDe3+7ds6Je//0hbLu8dVNzkdtoq4VbGUSzRvFt/C4hmHcDxU8sV9OXfevMS5aNzc2RCVL5qRFhfla4BNfqB2H/2XHEzXm4WeQ8pQD8D51MaFAmay6SWDtGSsTA9Ow2mA3JjDguo/UDdsiZivEeIYNJEQQX9zbXzg2JOEq9ZzLSB2MF/Wg3zjyoolGGf3ftq2Y9hZk/8IVbv4nAiewnhQ/SIuNrfKbnc2PnkX8mCWm6XusOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDFGMOXWniqDVQWjr0CAhaKgXJyiSM7yuTZVVWq8VFQ=;
 b=StkZC6WZqKrxDrhYSTrl2N4P3O3fIE5KSFg/DA6N0juVznl2PaJBcna8Ii0bC3UkgE/uPhvNYgz6nw9RuzB0Ea3xJw2Dv5hamqunWWQQRzN9xuP+jnZaBqtDs1WgcJqznk4AT2DCP/tf+91zu0EAYXlyoxSuh0Lbh5taGpjF6FC6XNyA3jpOtzBggPaJ/5rJiaxIjjmt/USkMyFtSHqQmkt1Tpoc3dgo9S9ohLqGt5LI1xi1Ude+YLLdcKDfluUfh+71atjKOIaFICVbicMCmDYivNw8jZ5EqYrXwPhJdu3OzbBf0aJK3ZuQF1+S5fGul53/P5vbVmCLvVi+oRbQ7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 13:44:16 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 13:44:16 +0000
Date:   Fri, 20 May 2022 10:44:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: s390-iommu.c default domain conversion
Message-ID: <20220520134414.GH1343366@nvidia.com>
References: <20220509233552.GT49344@nvidia.com>
 <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
 <20220510160911.GH49344@nvidia.com>
 <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:208:134::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96bbc8a0-7883-41f4-11d6-08da3a66d50e
X-MS-TrafficTypeDiagnostic: CH2PR12MB5513:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5513F35A2A8DADAA5640C4D6C2D39@CH2PR12MB5513.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Aw7vK1PO/UP5YOocsiTbzHJN6IhdBNl2xMCW7e3DGi2Y/Ia6xocbyOS36njh5YtrUVUAYd0UmO92SWzH4DIQZxmha5o8HFu944esg+pVXC/7jdTc8HfdxwcBgxKYJogU7Ipx32aABkFbhUWlLSB4vDodz6N/FA6D0AAJqE5mGi4aoUYu+gfaXwuXkVM1XbQusB2ltzytzGAtHEDdlTdVDcLNevCwqbBOf84R2rWx1trJO7jqlbwZOkeH8dXcSKe2HOEPxFfJK7x+t0nBh3bfNSzwzAKcMF3Arw7Ow8U6pdOjs66sBQKFd4Od9uffD2RSbuHnRE6IECLfcGGFcQZXxP0VWwdQu3eNl65rfULwAf2SmZWcESOlwP0ostq2XDvdYhCeHfD9A3oBNLQ8445cg3Yy+x+qNxMcXs9X2kgfOvXlaVAw8KKnN2lmK7hIhdx+zemzsKplxRx4hcr9T7lQBlxJVIDjNlcBJuMGOCMxUJ//183PZ85M61IaUVirDF2Op2BwmgXiqOmc+EVsFmxWtzka2ETHM1MyU8Rasf6Y/r4suyjUaA7qelo+wpH2q4jUJxccBAWUDesAZjs9FVXcMILxiuts0sfX4RhFbObTo6wU05Q19cAatJlqnH/NQTqHx/ICZxw//b9Fozeiq1JkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(2616005)(2906002)(26005)(6512007)(6486002)(7416002)(86362001)(6506007)(66556008)(66946007)(5660300002)(33656002)(186003)(38100700002)(1076003)(36756003)(66476007)(508600001)(8936002)(6916009)(4326008)(8676002)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXDL/+pH4FxP8b9kyCPOzGY2+JXClbNMI29ze6k/RVGQ3SVL0zRmohSa3E0N?=
 =?us-ascii?Q?oOoWnVSbUgXXIKNOU+6eKYC/8AiqENnIhw92bPFw6WlqvzRMOeiIWXJEXVM7?=
 =?us-ascii?Q?bn0cptBN6l3ghT3+TLsAGbVpmxmS0rTX7Qy7WX7KpPs1GmXR4/UxuyiUXqZK?=
 =?us-ascii?Q?IAiR7irKryeMpgQ4eOBOFxvNgxW2ENhfI2I2+f/JCly9EiKPz7HmV7GsTVPh?=
 =?us-ascii?Q?jGkvEFIu6DuEcKTMXbR71WVxeDXH/ucyIQBZ9qcDBYzWXIlsBHmB41wYmV1r?=
 =?us-ascii?Q?lOXG4vizwqx7ylWtNTd5+uxhcrgGk3L7hQ/xx/b1c/reLMAc+gMHKAf19+oW?=
 =?us-ascii?Q?Gsh87gn03admkq0V2jBtvNvzIjwPMTcVtWgkyrScd+ysk6PvslHmPhQupwRh?=
 =?us-ascii?Q?xGV+gJqD1OBFRwJIT7uOZj1Hyd5Tuh4Qg6oqqvrY5d/64QDMlgepEXts7R7t?=
 =?us-ascii?Q?zfPZR0zjyuEd98h09cJP9Z8rXFlpiv8PH0iKHjD3vw8SdX3uPE6sY/uJucze?=
 =?us-ascii?Q?hJD6Hq+U8agyHKRm7CRfh5IN2trshZwuNCBjKSAXe5dII5+Bes0kPC4cJ/LX?=
 =?us-ascii?Q?0pJUlbUnMNfqn9hc5AgUhGTSf1xWfaOlGt1H5SaNgC+qlIcLf6BJDXacicuM?=
 =?us-ascii?Q?wSP6++7NeiKOb44ME8IRq988sUq5tYqxcRk5ApQyiRB5JW2dNreFxd8fCDCV?=
 =?us-ascii?Q?gYL81e+tU4pg197EQNej8hG7f97tzS5VHWArsvgdhx7j9bD/LN7WE1ZyYpW1?=
 =?us-ascii?Q?fNL+CcAjk6UzlnK8K0WTOTVErXyRHdtkGNZY0nCl2Iu8jKwHlr+tL3Els+Ws?=
 =?us-ascii?Q?I/BMfsAKdq8pK/ydXTBSbiYJl74U6Q8N4qIJiosxZ1w32o+JjvuBdHFYwniM?=
 =?us-ascii?Q?VxZcbj/1hhX6Y40X+316RskWMHavt9WdvkYJrPpldP1AIc0lF6x/JmqWcaYY?=
 =?us-ascii?Q?EB/1OnH30WhJvwcVidXEm9O/AXvIhxGYQG/4M5iSS3h3UdC5eXPzgR1Yt13a?=
 =?us-ascii?Q?R6Ya/86iypHz6tGh1MwXLrxhKWe60GTqj/74ZlFV1MesvzxOntaqRGBf7FR0?=
 =?us-ascii?Q?NtHD57Nwo1wR/90ldpqhoQMi8wV3RnCOvGqxuaCs3cwakwR775i8OF8yiZdC?=
 =?us-ascii?Q?QjL5xFVPXf6oKDaLu9PRl7RoVN7ur0bihhO2bNxlENBNgEFjMm4Y2qNzGS85?=
 =?us-ascii?Q?6dI/hNTFKWbGvJulVmPJMCTSfK+jiFkvrxGiyTu4r2yQpGaq25TkJNB3Vwx2?=
 =?us-ascii?Q?w/uqblnkE6KYNfdxrnLcHeB/kqMm3Q9lRl6Rlwprzu/BLso2ava9RzEWcqZ9?=
 =?us-ascii?Q?KB+pFrij+czcATuziKGrSayBcNFamPMhmKWu60ZD+WZIg+WOsRfWup3fMbRr?=
 =?us-ascii?Q?TXXXNUiAlDlKWPNjOJHHN6915oMtrrYbkCAI9vOrjc/nWckicGrti33ZY2P6?=
 =?us-ascii?Q?0fUDlj4jKHTHWG/qmqfkI/azCw1PeYX5dV71JhOxHUdT4Ry4WRocHpsVT9s7?=
 =?us-ascii?Q?HZ1F9g1mFiV6wg2Arst9VUBbiCO1hnZc3dUuZbTbu083uQt0LyIhsWQAzMAv?=
 =?us-ascii?Q?3nQXwBysRTGPX1X8ZZ/pp0WXC6Yeuxcdg6Liq9ua/micQHUk3y+PSVUMMaqI?=
 =?us-ascii?Q?6jPk07QcW7AJwmj1h9se2V5ibJgFN8ohvmL/MceCDAaLSQWfMX1g7tD0KCGz?=
 =?us-ascii?Q?QLgOMxLiXqd1FZaVXhq0eTbyBFFV2dumF84Ll3cCSwh+W+wXsQfMgJTUf+QB?=
 =?us-ascii?Q?hRMirjaR4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bbc8a0-7883-41f4-11d6-08da3a66d50e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 13:44:16.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18W3VUwlXSfOsS/0EGA9KRDlr//HN0bzOH2mIWoVETXgUB6KOkOqXXjE/YJ4gcIm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 20, 2022 at 03:05:46PM +0200, Niklas Schnelle wrote:

> I did some testing and created a prototype that gets rid of
> arch/s390/pci_dma.c and works soley via dma-iommu on top of our IOMMU
> driver. It looks like the existing dma-iommu code allows us to do this
> with relatively simple changes to the IOMMU driver only, mostly just
> implementing iotlb_sync(), iotlb_sync_map() and flush_iotlb_all() so
> that's great. They also do seem to map quite well to our RPCIT I/O TLB
> flush so that's great. For now the prototype still uses 4k pages only.

You are going to want to improve that page sizes in the iommu driver
anyhow for VFIO.
 
> With that the performance on the LPAR machine hypervisor (no paging) is
> on par with our existing code. On paging hypervisors (z/VM and KVM)
> i.e. with the hypervisor shadowing the I/O translation tables, it's
> still slower than our existing code and interestingly strict mode seems
> to be better than lazy here. One thing I haven't done yet is implement
> the map_pages() operation or adding larger page sizes. 

map_pages() speeds thiings up if there is contiguous memory, I'm not
sure what work load you are testing with so hard to guess if that is
interesting or not.

> Maybe you have some tips what you'd expect to be most beneficial?
> Either way we're optimistic this can be solved and this conversion
> will be a high ranking item on my backlog going forward.

I'm not really sure I understand the differences, do you have a sense
what is making it slower? Maybe there is some small feature that can
be added to the core code? It is very strange that strict is faster,
that should not be, strict requires synchronous flush in the unmap
cas, lazy does not. Are you sure you are getting the lazy flushes
enabled?

> I also stumbled over the following patch series which I think would
> also help our paging hypervisor cases a lot since it should alleviate
> the cost of shadowing short lived mappings:

This is quite different than what your current code does though?

Still, it seems encouraging

Jason
