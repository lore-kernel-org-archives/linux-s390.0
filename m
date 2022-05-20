Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C37FC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 15:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiETP45 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349583AbiETP4z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 11:56:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432756B7ED
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 08:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM5zzc7e74+UMD7pMbwzrr/eCMBt0g4tKLtqswP/4Kuqnd0uhklYYgxjHQrDdVH8LiTsPTQCDJVe75c3UiDPxEUbBnltqjgoJ7Mb44sAuoU6w1kVWlV4eiMO4jXPUfemzj7ezBjieW00nJFaDhTGdcbMA3myDNJ/ZbgJgAvEWc1vKtohEfymZdD2SWjhe6IcMsi6nTIEbRU+3c76My8dCZ55wcfF3KXCibxa1bOtKiBxfuKxU6Oa9ZYPdqRxlNc6A61wnb0w/RWCsedSO2mA2SEXRcIfGo2+kuFINu4ojc9Hl5JN+lVTQhK1B8PhmPZiZ9kwEiQqDGYM9a5DBbvlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsPdhWU3s0AGCuK99SjoIRc0wwwt30/7QNlAhqbV+O4=;
 b=BSwhW5pzLv74dVpu59wEBrJTekvAHF6F/XwtQfwjRPdGlIOrTUXU299WZeEZXPGU7g2loVfeJtfWnFupbeXErZx6IVlUije6J7TdvhvElkGkMFCP0/b0PFmx7cLMRKsYZBUV0IuHBMkUH0Kq7vab9z6IKu3Vc/vlPMeoB9/0u+RW3VjRY8MzHitDdDVTH3z97SGMtKA24EuECxaz9inM5Pk+GIL6KBGPpaN67mAu4pdxDSiaSBv2Sh4oW/XKaeaLwAnyJwIrfTDoqjinyOVeUiO4K26dEWsDFhtrwFjdmu87ppPLXUVbZxX8I0fLmbYGNWU9BpZBus5okBybefgjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsPdhWU3s0AGCuK99SjoIRc0wwwt30/7QNlAhqbV+O4=;
 b=cSEgeMxpC5YP+8RMOZ0SUGUfPhVJaE3yaYQvLMqJjSQaVUHQeHhN1g40+pLP0D/QISrKl77p1+QCggaMYy/+HjMDH9cMCYhY84Uz9NCu4GUaNUJ8Ur/BS2RHZIZQCEsWpqC1hqaYif1hIGMpe+OdOlm4VaPChc+DV3qHdvLsudPlg/wBQU/bZ1mzoYmcWVAAZ2UB5kvGqvBwKirX4YjMb/Xh4qwu2xqEwBBXua2ZnpJig7+daUB9e4ruql/BNUcOnqLr7wwjhPJUnPchxvCW9Hs/27Dq1KrKESVXZ6od+uPwaYiIKE2EMlhZTkGUbn/Kn0pPGZi1VoRpjJM4c7Fqgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3676.namprd12.prod.outlook.com (2603:10b6:5:1c7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 15:56:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 15:56:51 +0000
Date:   Fri, 20 May 2022 12:56:49 -0300
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
Message-ID: <20220520155649.GJ1343366@nvidia.com>
References: <20220509233552.GT49344@nvidia.com>
 <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
 <20220510160911.GH49344@nvidia.com>
 <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
 <20220520134414.GH1343366@nvidia.com>
 <6271dd24bfcf82b0c1b911a163ae9549c24691a4.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6271dd24bfcf82b0c1b911a163ae9549c24691a4.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02679a4b-8445-42df-1d00-08da3a795a76
X-MS-TrafficTypeDiagnostic: DM6PR12MB3676:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3676ED9C84066403B7ECE619C2D39@DM6PR12MB3676.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMF6kVezxPSZsIB34iqbDepUHrE81GDd1PHbsiDLKrzxXawrCEn9AhwXpyyIgF3uN1VSftXG4+zVjeR90c/UvI86ClpPLYdM+P5CWV/Kjmjf+81O3y3RDToaZaBBPaCv23nUwl0baWn2GaqdHu3K2L8lSCxNB4TXULCTVaovuKJXp4t6zRO6c07ehCYKn2ZjWcdmYwaOee/9yGVOPgEUvFD//K+M0RVVuzPytyPTY/Fd6MQ2Vj0XysuPvY69kEo/SINUWV8tTNqRMQEGUzCP1L41bptZMiwrMBKrfyTd5Crq8B5HRm3Hj6Tecednq81bINZt47aMPJbJJnsbjJSQzC9zNNnkB1KQROG6cynVbhQy/081zsgkqg4FRwcNTop63XTI2X/SYkrT6J5cTOrI3uKiLRVxFIPwKr6XKqnX3w5hqVs30ZRbmMMfC86ZKtt/GjbfNHCvWoM2ZP+FYVFfk3SEvh9G2/88BSbRmjiSjMjrWyR860z+Vy2WkG/9tJSiNvuPR/jn3M8MQtEANoaMn793lE4ceuIH06Xh8wuEBxeD3RVxdZN0xJodk/6zeg0JTX0ls0PPq7/BjM/VbVsDsZCN6bYdP+vNssY6j8XnyKco5fphipizS+FLWC7E0wTy+CyrguK2GNFr+c42L8yi9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6916009)(54906003)(316002)(86362001)(36756003)(83380400001)(6506007)(26005)(6512007)(186003)(66556008)(8936002)(8676002)(4326008)(7416002)(6486002)(2616005)(1076003)(66476007)(2906002)(508600001)(66946007)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2fgbpG8o0ZpbTwfZzey+V3Q/1eQTRSqlbuacd4wZTv6do98EcRgntIUsWhj2?=
 =?us-ascii?Q?+kjmrMZmcX5nB1pD8lGiYYaUOxZPIZbcwZ/6xM6sxSkhcrSGoqIFlMARn8Hg?=
 =?us-ascii?Q?Urzjp/HLKjYVtOFGzglrzINr/E7g+4Ua9nXrlI2QJxfpgEcWMXkFGtrHV9co?=
 =?us-ascii?Q?akkQTTkF2SeCj1xDau9A0fFNpNJLXo3V1qRoQMW+l0cWhBgpl9mv6Gm2PFMu?=
 =?us-ascii?Q?p/KUyCmGz0LARaxemsegGBf7+8Iq8mXFZJtnqYIQ6cx2OpWQzceEE9/RnTV+?=
 =?us-ascii?Q?ClnewOe4pSUZoWZ3G6Ug7Snk1V+EArZMoaTIRBjanX2Xm/tW+Jq1LXzEZfPY?=
 =?us-ascii?Q?b7ZCyX9X7cXe7PCyYw7k2sbBt11Z0gdzLm3sFkx2PGuMHLJpBTcwKHSXl/+8?=
 =?us-ascii?Q?hsEpDfQVykyARpiXT8k6QIQ6Gsm4sPBnPh0xOrEiZxeqyMeNueWKDXXlkk63?=
 =?us-ascii?Q?M4yUIw7xM+pJignwb6CKu8XhLzA8V/hmtvzJETrZVnMNoFE3DyqG+g7ZwTCW?=
 =?us-ascii?Q?r+Ohs8zvl+oYxPqs4VZMryh4wludMG3yk5raIeovm7leOT+Masuq2tpHuiJB?=
 =?us-ascii?Q?TbegTFbfie9dNc90pT9IXOT9NQpegPi8PgHA6pEJRHl6fuitRy2paR3CWBbj?=
 =?us-ascii?Q?eY/5rm+9M0uA3p2gyDBCDTkBmrh+ZqUJfDSrbhg+rSs/E5D2TSUKJk3kuzzH?=
 =?us-ascii?Q?2Ck6IFqK8gmy8Wlxlt8KsUzuQ2ZBlvCwnnPdKOriP7dGYJ1JV5fhl4wWYJVh?=
 =?us-ascii?Q?6ImBlH9fHoYy7Vr3OxH/Sw3ciTAgL1zMszPF/kBTPrXgtg+y7GuK0njs8yO/?=
 =?us-ascii?Q?j6EEJbtxHeKp3+cVgOsD/yP0c7MV1RzwdwG+VPbuoBnzjqee+Qx0llsaLko9?=
 =?us-ascii?Q?2322kmev34jpgDW4sBETQDso4evNeszqs5Vl+V0Rj9CCLxP1tSKm+gCRswCc?=
 =?us-ascii?Q?c5DWE10ZqtpmsDLpmtQhf2HEZR2UkkKCJkvRGIGBU851oxETlwqHG/D3agE+?=
 =?us-ascii?Q?NvziJX6ujCiKvO8hNKloiUdVNbhe+Z3uc/uwdb8r47KSL1f68t9H/zS7Gl/+?=
 =?us-ascii?Q?HxPSd1ngEvD3B0mSswXMRMrS/yrY/Us846UERmfGoh+5i9PsA8PCQB1x5EMM?=
 =?us-ascii?Q?Jmb/Usx8jGs2a2wfWO95gtonoZqh2TR1pHtplQFKp8OWhm8Xjb4awu1seLlO?=
 =?us-ascii?Q?t9MRLRYyB8IcgYw7tYIfaY+Y3xyvNPFQQRzzV4oM+qBSRobAYnBe5uCF6tHU?=
 =?us-ascii?Q?Bc42oZqtMkQ+4aadJkJpDssOrJioLxyUr3SpXNVijcKP4KbaeLmJuGjSQPRR?=
 =?us-ascii?Q?b/IPUiv9K2IW0Gu9wHL6/nvqB8LRdM2arKMXrcJzt1zQ6EzX16rtp4NITQgh?=
 =?us-ascii?Q?iisoFQTZ7ztI94e/CQGOI/amhmcQIFUUEv6g36p7pxr0hAez6duP8XbBveZ8?=
 =?us-ascii?Q?iReFNGh0I75TDvP/ngAoAy/km9lKEWqBdrstONHiPl1fDIzSlgD9ItMPsMDd?=
 =?us-ascii?Q?TdlfbccoivloO3X2ntrAvMYpYBF5+qBKMZil1LC4bBaOmtxl+Mz+wtrrgKYP?=
 =?us-ascii?Q?znjAu8c/C/G6XEC2WakUVPxQLbyftLNTNEqkL1pWXxY/2aEInt4NNx/2dHev?=
 =?us-ascii?Q?GpRyeYJRhwnswwegXxv23v66RDubg6yjPzrr/kmJ9zM0yK+VBQGtEIp6v4Ik?=
 =?us-ascii?Q?902APsGvtbvNpBWtGYC6bGDqzK5BrFf25TAFmfQ7vdtxF2/BQZsVoZHi+G4U?=
 =?us-ascii?Q?HxCDTQ1ruw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02679a4b-8445-42df-1d00-08da3a795a76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 15:56:51.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0ca4UNz+FuYhYH/hJOzj2nCHIDL26l7gTpbQW/s0cn9HwI1mAYqMBOnxRwbqruI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3676
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 20, 2022 at 05:17:05PM +0200, Niklas Schnelle wrote:

> > > With that the performance on the LPAR machine hypervisor (no paging) is
> > > on par with our existing code. On paging hypervisors (z/VM and KVM)
> > > i.e. with the hypervisor shadowing the I/O translation tables, it's
> > > still slower than our existing code and interestingly strict mode seems
> > > to be better than lazy here. One thing I haven't done yet is implement
> > > the map_pages() operation or adding larger page sizes. 
> > 
> > map_pages() speeds thiings up if there is contiguous memory, I'm not
> > sure what work load you are testing with so hard to guess if that is
> > interesting or not.
> 
> Our most important driver is mlx5 with both IP and RDMA traffic on
> ConnectX-4/5/6 but we also support NVMes.

So you probably won't see big gains here from larger page sizes unless
you also have a specific userspace that is trigger huge pages.

qemu users spaces do this so it is worth doing anyhow though.

> > > Maybe you have some tips what you'd expect to be most beneficial?
> > > Either way we're optimistic this can be solved and this conversion
> > > will be a high ranking item on my backlog going forward.
> > 
> > I'm not really sure I understand the differences, do you have a sense
> > what is making it slower? Maybe there is some small feature that can
> > be added to the core code? It is very strange that strict is faster,
> > that should not be, strict requires synchronous flush in the unmap
> > cas, lazy does not. Are you sure you are getting the lazy flushes
> > enabled?
> 
> The lazy flushes are the timer triggered flush_iotlb_all() in
> fq_flush_iotlb(), right? I definitely see that when tracing my
> flush_iotlb_all() implementation via that path. That flush_iotlb_all()
> in my prototype is basically the same as the global RPCIT we did once
> we wrapped around our IOVA address space. I suspect that this just
> happens much more often with the timer than our wrap around and
> flushing the entire aperture is somewhat slow because it causes the
> hypervisor to re-examine the entire I/O translation table. On the other
> hand in strict mode the iommu_iotlb_sync() call in __iommu_unmap()
> always flushes a relatively small contiguous range as I'm using the
> following construct to extend gather:
> 
> 	if (iommu_iotlb_gather_is_disjoint(gather, iova, size))
> 		iommu_iotlb_sync(domain, gather);
> 
> 	iommu_iotlb_gather_add_range(gather, iova, size);
> 
> Maybe the smaller contiguous ranges just help with locality/caching
> because the flushed range in the guests I/O tables was just updated.

So, from what I can tell, the S390 HW is not really the same as a
normal iommu in that you can do map over IOVA that hasn't been flushed
yet and the map will restore coherency to the new page table
entries. I see the zpci_refresh_trans() call in map which is why I
assume this?

(note that normal HW has a HW IOTLB cache that MUST be flushed or new
maps will not be loaded by the HW, so mapping to areas that previously
had uninvalidated IOVA is a functional problem, which motivates the
design of this scheme)

However, since S390 can restore coherency during map the lazy
invalidation is not for correctness but only for security - to
eventually unmap things that the DMA device should not be
touching?

So, what you want is a slightly different FQ operation in the core
code:

 - Continue to skip iotlb_sync during unmap
 - Do not do fq_ring_add() tracking, immediately recycle the IOVA
 - Call flush all on a timer with a suitable duration - much like today

You can teach the core code to do this with some new flag, or 
rely on a custom driver implementation:

 - Make the alloc for IOMMU_DOMAIN_DMA produce a iommu_domain with
   special ops: iotlb_sync/flush all both NOPs.

 - Have a timer per iommu_domain and internally flush all on that
   timer, quite similar to how the current code works

 - Flush all when detaching a device

 - IOMMU_DOMAIN_UNMANAGED will work the same as today and includes the
   ops.

Jason
