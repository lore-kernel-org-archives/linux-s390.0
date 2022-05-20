Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E60AC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 16:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351762AbiETQnK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351758AbiETQnI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 12:43:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA7517855A
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 09:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7036xfKuvUruZU/7o20gNS9UzfgNZ31uun0Tyb3zJV71rH+svnyU3W2fHbP8v9JwqRcS0NLy9cXSTqiQ3zT4TpUM9rftKiZVpujyfUVVZguhtoEL3EzF8FcKyJD62f3TepNrVq8eIoC2V/Gig3u/ERHXo7QYYjLMXiZim7Ddtl80VZkGN8UgfUoucEn4jGW301AnbDNxoVcjeVt1cd1awX2dCkapJBhGT1ZAxV4lbamrsINu+iqODkQ+/8Ul07v863K10Rg7drj9cHdtbtE4iUJlQBRXSTlhdckPobxO7Zj3lpiO9haWVllRPD/pkxuElcxWWg0A7uxPhiJzTsHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grfjA67znWEMytPGb7UKn0aN8Vm2s42u4ZDNBeZoTWo=;
 b=mJVh/KENpRVDAEiUOMgWVVd8q2WmcCDpIONesfqP3+RxNKuoc6ttiT+dqWtFVccWUAOUDgUebbr4BxqD8PE3F56PSHu//qrXx7SRSQAxc1HGB9Vt+aQ3yP+r1hXagGVhCB66yqwaQW5WRfmd6Iq6ZPYDmlS6w9TExNJWoqUjPSCAnrfn3NPInoylm4exKrwSdTsmeTfQoiVKUPcHFCVy7q1muYcXl6zSKssedXSB2vxZwyjeIdzgu2psa3F07tnHml8kPVvkhFtYVeB8HbHCaBBDxQ7sxCvH9AsL3vIR/I0hS9YNPqepCEeRt0SKc8PFJ1d89NPc3/V1fJEWqb8TwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grfjA67znWEMytPGb7UKn0aN8Vm2s42u4ZDNBeZoTWo=;
 b=uXW8fuwOnv6LCYaixSQm5JyF4VFxZUPBq85HG1A/fN8CAANEZkJ6ga8CfB7/bycsn3qJAwNGJFNAi9G10aNeLUcm68/QNUIQBjwnLFKCZFwawD+D1E/2Kv04gRDGftbtoX7VxO1qgYqCM+WrptzgJ6BuHFIldCSL5ew+tqu85Byp5fdJRg0cvFOAJ4oMX/dprE9w1hmm8QwhKMWR8t9XCmMLY3zLe9O2pZnGGnF8ymUvxO0kVq6b8SZHgFckrObaS9+kR/ixX6XCfaPAp+L4DQEHvrTg+CnKnd3z2p9kKBRCRD0EeuNuO/DdtTHDK9iF4p6Zx4o1eo8vZqpOAEI09Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1477.namprd12.prod.outlook.com (2603:10b6:910:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 20 May
 2022 16:43:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 16:43:06 +0000
Date:   Fri, 20 May 2022 13:43:05 -0300
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
Message-ID: <20220520164305.GK1343366@nvidia.com>
References: <20220509233552.GT49344@nvidia.com>
 <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
 <20220510160911.GH49344@nvidia.com>
 <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
 <20220520134414.GH1343366@nvidia.com>
 <6271dd24bfcf82b0c1b911a163ae9549c24691a4.camel@linux.ibm.com>
 <20220520155649.GJ1343366@nvidia.com>
 <dd2d49bb798effaeac55f4bf3625f376bb1abda0.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd2d49bb798effaeac55f4bf3625f376bb1abda0.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb5edbeb-eff5-4a8d-9786-08da3a7fd090
X-MS-TrafficTypeDiagnostic: CY4PR12MB1477:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1477F4495AA0076D1183B352C2D39@CY4PR12MB1477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IhvpQl7RJiuaAY/u9ZX3wt1q5HK6g4O2VdB5NwEj4Sj6WMoJUo5M947Dw4Z/x8a6rOGixd69E+3Ke0niqU3m1+lUSrvcEO3oWZPk/7LWBfkj7ffYqfvY81vQ8S2v218pVcGwIdMWHsxfnTzGkglkGeEjNaIbz9+NyEgSqjWJDUAo63lfPlgngvZ6/x3qH2OCjcB6X4FZA5R/35V4RMTxZTamSAsCE0uwT00+dR+wfitjcPKl2Wu9Bstw0tU/kJyO85HPwL9ra0THzF9bhJ9QAdwdG411TpoYcoYljkzfl1ftAdjaiI++dJ9nJs+2kPp71dE/EEEbclPhmDFXf1qI7IJM4Sr9GghZuHgRs6EAy65F46ovmW4t1p72wi5fQqj1pQl8dB9bPFPJEnnvs6h6YuzB5ItMmSBonbYr3ovpX3+7YNiPZSo8wFHkst6v9avy9KS4Mdj7drkCq2aKkvhhf69dXaWSOkxMSzn3alWpjuxY+ZEpVptxHt4KbG8osTvXiO07Q0ooNoT7Sf4XIEC48f1bnW7pAXIXcwuo2B+ILSDBywXSnXNT3Nd8VtSbpMMHgs+y0FKiRCSmrjodOztsXl1R1rWqiNOarnYyk/E8FTdJYUTmEzzN32q5InVg3ojOcxrJH5ka7vOu8fQLLp9Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(6512007)(66946007)(1076003)(66476007)(508600001)(66556008)(26005)(6916009)(86362001)(54906003)(2616005)(38100700002)(6506007)(7416002)(36756003)(83380400001)(5660300002)(6486002)(186003)(33656002)(316002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0NauDAudtytWOWAWoiJnRj0NXT/LouhG36OIqg3DHJLoYH9x4C2x/AUOjNyH?=
 =?us-ascii?Q?G86NjvyWZcjoQggE7AKtptOTyvoxzcdKJNlCj8B4iUkiP7vw+y7k6xWm8E++?=
 =?us-ascii?Q?OuaMi69U8pB7QAW0obLypyOWAeIO62av3GwsaNxtzClekgtfpZnR3rHD6uL+?=
 =?us-ascii?Q?NbQJjTO5QjewWszOt3wtSZw6lKBkP0epm+/TEvLmK49Fi4u+wD6EriW0D26T?=
 =?us-ascii?Q?TXs2DWfijkI40FEFcAoujwz7S1VQfDdgGX6NJ7hOiqwIAoZX05Rh2iN8KXmb?=
 =?us-ascii?Q?P+1MGUnFNnTnSXZ4G2LWk6GYTsu0LtL9wM+rUQmbYfXFajLCkbH3fuGPbcug?=
 =?us-ascii?Q?peHZaoKsctqY8whB2tyAi3pTIDr5hYs4K+sYtIRLY5Z3ixbSWPvOo0IdGzeY?=
 =?us-ascii?Q?57Ck35jxuu1k6haUX1dMionuw7RiWg0a081yAXHP7g+VoUB1s1Iv0plpSXYF?=
 =?us-ascii?Q?uLaWvf2+Wx7utPEVikMYT5zWNvug+dSi02Xy75vfP4mjELmZ77Bs5w0ahnkw?=
 =?us-ascii?Q?Tfd0jaCIeTXUHz3oCVqau9j2kbbuQuZ6k0jiPsIKKu16CjodNK9bqFyPDnfJ?=
 =?us-ascii?Q?HkVFDF2QKn/TAZ1CztDIiTWVyqN1/GVhUQn8EmOIZP/wWnljKXbBOwRKLPfr?=
 =?us-ascii?Q?fpC/QJSMC929TtHmSfNfGXoVeCc9pp6VHqvHLSYMZ87ku9VMspHNfe5tD5r8?=
 =?us-ascii?Q?efizJVwwL/5bQ8M/+ixAnIvcOaCO1hwUaa0NEGyVQ4GPWOGGLWAZSV7TsyI1?=
 =?us-ascii?Q?jMSsVprHBmi53VBFUh9qqwc98CH/GLyxrLKoEzRsINPpf+0YtdeBJtaGMlhc?=
 =?us-ascii?Q?nEBbSZjPXXoFeftYnnNAoL6chlmxY10fbFyjnrfIOIiGo8waLRQOrBjt7avL?=
 =?us-ascii?Q?kApYP9ZNIVHvtPp5wCGGedqlgUV17yM7aRZEFPBHe7R+GsCC8e14T+znhHkC?=
 =?us-ascii?Q?XABTuqiMllDvUNy+VibScF9fGFRyGaqBFZxx6SGaF8LXuRjkPms3cxnqJGZY?=
 =?us-ascii?Q?6/Z9LbTnFcDdiiZobC2g0gN87lAQQlPCo+dWpj7xpoQpWHpKwE9ahpV6eRxr?=
 =?us-ascii?Q?/Tw21oCCEFw0JYVemzQW4Wk6tymMeE1ArtqE7z6lAK8hlxpmsA2c08nVBLvU?=
 =?us-ascii?Q?kxmsy3tT9ZshHAHmaIlx69ui3w+2loAXdIAOfpk+1R3dL23CF7fCwEgwrm0b?=
 =?us-ascii?Q?QW33zlmggjuV+5fMfJCN2RHqDfWBmZsoV374BjaN1aOvSOIxTkxfAx0RcWVs?=
 =?us-ascii?Q?MLAII+QLAANPk7Q6dfA4rrXZwWhS71VJsUIJAhx8/XrRPDvNYReCzUPyT72X?=
 =?us-ascii?Q?YQQNUemZ0uRz9Nr1U9lN0rMA5rcbvp0jSW+TfzegkE5QQa2md6oZkx72+wbC?=
 =?us-ascii?Q?UqupmqoTvV1gF4FCh13CloZQhduqgujs9Ugop4KcJbWrz8mu0uwe4Govl35D?=
 =?us-ascii?Q?bA+XcD4cPUMntQwpD+cEctMLGBpDLGtMvi0tGcWEOJKDz1uPwdleXRQwOS6m?=
 =?us-ascii?Q?/wAFpiEGPefyDyGLNRpJ/64w1/hjCxP0+UJSSzmayO+awuLTLEzg+4+EdmW3?=
 =?us-ascii?Q?uHwR2Ok+MbYmsUhdw3IRf9ZRrlMTsm7fnt6u8AB9/GSrsX4UKm12wDPLtVwi?=
 =?us-ascii?Q?HTT695ZT4WIBIxuy1v44wA46exCXxpp0OOkosR1XLoUDtftKMLIpwSELJDj2?=
 =?us-ascii?Q?LMG6GEjrNYH4B25FW5oRV8K6VxS8aNBuRxM0HBiLXFAw18SPMfij/tUIgWhO?=
 =?us-ascii?Q?u+NMBIILJw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5edbeb-eff5-4a8d-9786-08da3a7fd090
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 16:43:06.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKYWdAIv6ElAw9cj3aTn8oHj4esgmGKo/gyP8j8E3l2Dih+kxZN7SeZqAYb/MYKx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1477
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 20, 2022 at 06:26:03PM +0200, Niklas Schnelle wrote:
> > So, from what I can tell, the S390 HW is not really the same as a
> > normal iommu in that you can do map over IOVA that hasn't been flushed
> > yet and the map will restore coherency to the new page table
> > entries. I see the zpci_refresh_trans() call in map which is why I
> > assume this?
> 
> The zpci_refresh_trans() in map is only there because previously we
> didn't implement iotlb_sync_map(). Also, we only need to flush on map
> for the paged guest case so the hypervisor can update its shadow table.
> It happens unconditionally in the existing s390_iommu.c because that
> was not well optimized and uses the same s390_iommu_update_trans() for
> map and unmap. We had the skipping of the TLB flush handled properly in
> the arch/s390/pci_dma.c mapping code where !zdev->tlb_refresh indicates
> that we don't need flushes on map.

Even the arch/s390/pci_dma.c has a zpci_refresh_trans() on map, it is
just conditional on zdev->tlb_refresh

I had also assumed that the paging case uses this path?

> > (note that normal HW has a HW IOTLB cache that MUST be flushed or new
> > maps will not be loaded by the HW, so mapping to areas that previously
> > had uninvalidated IOVA is a functional problem, which motivates the
> > design of this scheme)
> 
> We do need to flush the TLBs on unmap. The reason is that under LPAR
> (non paging hypervisor) the hardware can establish a new mapping on its
> own if an I/O PTE is changed from invalid to a valid translation and it
> wasn't previously in the TLB. I think that's how most hardware IOMMUs
> work and how I understand your explanation too.

Since you said LPAR was OK performance wise, I was thinking only about
the paging case.

You can have different iommu_domains implementations for these two
cases.

But if the paging case doesn't need the hypercall anyhow it doesn't
work.

You'd have to change the core code to increase the timer duration, I
think.

Jason
