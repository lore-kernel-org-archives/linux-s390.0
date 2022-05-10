Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA61C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 10 May 2022 16:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiEJQNN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 10 May 2022 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347019AbiEJQNL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 May 2022 12:13:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623802725DD
        for <linux-s390@vger.kernel.org>; Tue, 10 May 2022 09:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQyM+gNYaO4dMFJkXamO5MZUaLvtMbKWtaseb7Ea2MgYC3JK6QXssU8W6XWJYmhSNfi1fELP0DThSDukFSfcF4VBLtuvH1/WgxF1eEUP1vl3jNl6t9djQStn96ng0L/CrbMcth6/tsmZuAj18LD1LgPPOq9Bh9skXsL2Vbgsobo8Yif1/6V32/KYIm/KSH/l4IiGE2wxlinCi7ItPhXML5RFByw59/QXtmHTyiIeiBpdRG6+f/L2FqSr+oWwNldEMUKB6ZbTd3kw3FrOjpCC64ge82KHvdBL3f7aaE1nawrsvie9Zl0yuoFyCrgBgBrcNLcfw2Gc0zlUvbuaLlSOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOGmwgDP+M5flXLj39bkRO0Hl9uJtoj5kUmGh4JC8u0=;
 b=IrBzIiSjsohoSbf7uhbp8DtaVk75FXIIuplsBzjQbm8I8/wtmOhtcHMpkOnhpygixV9K/tfelP3LtgcDWntMUFq6SigjFYvonGMOa8pqS+fMaxoVunYaDEgvozaXz6WYMr/8ooeUR6e7wz43LaSApyMI/NB4P4dta2/oPGaBA/WbscZg5bjNFKhPYNJNWzTaI4bep78bCEq1s13RAxL46uwsvcoLJul3w3CFkuXzaICjS7nIFQOpsrsZucNFIEaPW3J4itrVyRGnYowPG/8urNe4nUVJHgAP9ZTGCn62h5Gq0TWIx+SSvu1PA0Ku8dG15Ple12cHUHPATg5kvWrVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOGmwgDP+M5flXLj39bkRO0Hl9uJtoj5kUmGh4JC8u0=;
 b=FqN8rfKC2E1EXA14XyUvvpGDC3v3bznA4fVgUNqF967aV8DMwAkWHWS8NCTZXraPo0tlZyJlU5LG+14jbtmFX1aDnPxtU0C6Ve3gKyZ6EfYM/Jd0iMiEgKXVHZVzRsYP0z2aDjf/V1W3F/0ghP6cOWFxPZ75yUmskXDiTki1l7SCM3o9yKAtaf0q31IF0vKBv7OoTihsGTYGufMvziJJaElCZk7VwjtK8VA0wk/HYFRV2s2FM+NgD318oqqFKTX13invxJuww6X2jnbQ7dm/6CBgrUX64SC/aZPuje8AVfKNmDYQu7YbsayLNw/g3eL846exyY0RXy1OJZ/tKGxOmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3092.namprd12.prod.outlook.com (2603:10b6:408:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 16:09:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:09:12 +0000
Date:   Tue, 10 May 2022 13:09:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: s390-iommu.c default domain conversion
Message-ID: <20220510160911.GH49344@nvidia.com>
References: <20220509233552.GT49344@nvidia.com>
 <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5caf0e85-44d2-4064-55f2-08da329f6c51
X-MS-TrafficTypeDiagnostic: BN8PR12MB3092:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3092F6270A8CBEF3F942B26DC2C99@BN8PR12MB3092.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tL+KsPcQ2YKoV7RGED+OGoqz6nJ/2v0/g3ueNDw0fCz9l1GoNW8PMrS/Dlo/nHcWFiVlkBFoOb9538u1GB0gCEFDAP7jemFTMPugY0BLumWu2nSh392ZSY6zakmba6/TED/TQaaXZb0YpR1IwVQWiREYvoDoKZcXbje/J0ljLXAo9PPMnh3TXW8mdGqxNCQ7fqlDdXYxn8kb31qWiMYKP6PPWSS7V684Na0YcpUGq044NqvTKjXyce1V+mWRpEo0wwN6ogqpJ5ALGw3PIjU1EfIVMRNZkTwlDx9PCoZ0htFe60SV9imeVoiwgPFGyy6qt/Jmj7aOrsPJ5M5nIyb2m+xxD+nqkBYSflpTaYHPWGbeSMLCIWnQ64mi0mwfz3xH/NKsB4rER2kZmnvMxTi63x60swoHM/xHQ2nVC9XWWg9GoGONMiUPs15/kEeiN9CgGWJPD32xzb08xXyL/LodzQ6eyVu/GT1ZM/Povpx+4gOMqsSuQuZRqmQiONYTmJH56819HMIeJzUCOpHezvJkV6vxnJ5XR3Zqcfl3ArfpSWrfKWTI64bwe70A1nzkkJ6heU6P4NccyawAukhLqAL/M66w6i84rkgWMwSdGq9N+LjKxmYQkuZgFldIZKuol9qxQQUxrlZRj2KQvRMbr8/l1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38100700002)(86362001)(53546011)(8936002)(6486002)(508600001)(83380400001)(186003)(6512007)(26005)(1076003)(2616005)(36756003)(7416002)(33656002)(5660300002)(2906002)(316002)(6916009)(66476007)(66556008)(66946007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g8N9+RgdR2+d7NA6Ja+bFon9icTHQnfz1FyZuDru+GP6JrPf+P86tzyjWjZo?=
 =?us-ascii?Q?6OR+TuIe4oTFU5z4DH5QEz+OjZqVV1c86J7RrsE3p9BzUAuRBvu7wnmEwVRL?=
 =?us-ascii?Q?GoGC9M8zbAYnn5fDbpDkDSfIxrNnQkySi/NpnF0g9lNh6WH4wuo8FBbAUG3R?=
 =?us-ascii?Q?Kxb0rDBeOPf30sNlt9KyaZv3aFO1t5orzcbb03vtWisCS2rQdoYxwpYC68l6?=
 =?us-ascii?Q?eMCvBynOM6trytsNGxWt1r65gSs+l4g7UCXdeq2wOBuTkI5sz+IF58EbYqim?=
 =?us-ascii?Q?Q5t5LEn7JfXtp2hzn2mRXo2bOhq08QyaZkivJCbc/CJg+65NjGkoYByIl2Ct?=
 =?us-ascii?Q?5nkZ56ugeCgZ0g9yMs+oo2a2u5Le+fwoe0SP+q5SIfZTigX6Ng94HTfXeSGr?=
 =?us-ascii?Q?Ge6do1HiGgZkt3SRL3TgcHLhY4vlt+D16Weo809NUIM3R2kY4kGyp0cCFMRY?=
 =?us-ascii?Q?4s8fQ1xtudG4DYHhSqjYCywYIjGCpfCT8+YIgh3UsQeBCW829HUfjTrZm+rP?=
 =?us-ascii?Q?HAE4SpbsiQ7o8a/GoV4ew+CToaLsgD89Sqgz/vei+YFXaqaEg2J/u0JFJGow?=
 =?us-ascii?Q?DV24W7nmNrvdGLd3SptOIGIPxTDe4B1vSmp7deynmJtkf59evNdxgUIpQYvP?=
 =?us-ascii?Q?J6AU9eOamUmZI4fEHNfNlhU/+yYmPj/8sYmqyyqdNnhvvI+FTi6xEUDh+3tr?=
 =?us-ascii?Q?TOMDwZ8QRXwOulQvfZmzjCWvSn6rIBQcK9Jt796rWu+Uo+6zS0RhL7BV3OGK?=
 =?us-ascii?Q?gW98ai3ZNnt2laTvZ8l3e9Up7KYy7vqI2SuwxXGnMchcEO5Ngpz1uxNpvTee?=
 =?us-ascii?Q?kbZYPw4uOrT/HK3S6HcTO+DhB245AuNyN9aJn1L/GvQ2lquzAkBNonm8YcgP?=
 =?us-ascii?Q?T2DK5BDvIILrYNF8q6UTZ3YVpMQtO9T0zRTfiZKDjK/EH+xcYkjYCJHDsEBV?=
 =?us-ascii?Q?d9hLJ3JNiiVxt1aDlAo69NC7H244y0Dl05rDCJIu0Bk7mK58dioYASyf/+zL?=
 =?us-ascii?Q?zBquKXnjC5qMnDKmkRMtwnjiZcqL31eAdO0J4eOd9T+QTJvSoabV0k7nsOQ3?=
 =?us-ascii?Q?9n3JPVqOYQmnuGVchpY9pZxeHR/EksPedQWhIFJXc3WX/Zeqbq5th7isjvY3?=
 =?us-ascii?Q?AOhNJxM+CwsXmOj7SBQGp6ezDRfcqSck86WHI28Tm3bU9W8ewZKNDDWhV9X/?=
 =?us-ascii?Q?s/i4S45GjQ0QdBILnUwml82Rb5bsCaKwLCEOChFAxLdl3bVhY+yOGjSDNUmb?=
 =?us-ascii?Q?tsUhhFayb5mowcjj2FGgLIcFr7Rk1dV6OyX+sZ79OWblkhLVhRh5qgGVT1Wb?=
 =?us-ascii?Q?xe/gm/s+SZgWXAuPBZoob33L0ciB3FFR/u7lcsqi1FmcQVg+UpZx1GMjzxzH?=
 =?us-ascii?Q?UO2EI6TidMLNOmibTcFW4L/DUx7aCXCqMFwOY7SIhWL1AYsAm+ajtmp49z/1?=
 =?us-ascii?Q?1SIWZi2T+ujE0vjmI2EoOU+1NhCIPgKDb38guNugvkkoyrdHTjg/CWm04bwB?=
 =?us-ascii?Q?JRh91gYgO8UVKKfDqUTW5fT32pjgghupfdweVl0kzxtyODHf38SablgZSWXs?=
 =?us-ascii?Q?pNZajNcrtGH3wPONcAISfk7KoeElIa/i8eR7ydPnHCSFKtiL/T7hKnS2tOiH?=
 =?us-ascii?Q?c8l//Y/ddXnDJU1qx7s4wm5e/mXsQmKMURKq1k/q0OLYSUv6dp5YesgZ9Gtm?=
 =?us-ascii?Q?zoPCc0WCCSCAjeS0b9Pr9YygewQPTiNJ2oDred6eWdqclA+3mtP+CL03Ng88?=
 =?us-ascii?Q?S5itTROIXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caf0e85-44d2-4064-55f2-08da329f6c51
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 16:09:12.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQ0+ymjRPocYH+uljr7ULbbPLt3znnnvFhEd5cbeZpAlzBysvNjhilx8VgZkxKQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 10, 2022 at 11:25:54AM -0400, Matthew Rosato wrote:
> On 5/9/22 7:35 PM, Jason Gunthorpe wrote:
> > Hi s390 folks/Matthew
> > 
> > Since everyone is looking at iommu support for the nested domains,
> > could we also tackle the default domain conversion please? s390 is one
> > of the last 4 drivers that need it.
> > 
> >  From what I can see it looks like when detach_dev() is called it
> > expects the platform's dma_ops to work in arch/s390/pci/pci_dma.c ?
> 
> Yes
> 
> > 
> > Has anyone thought about converting the dma_ops to use the normal DMA
> > API iommu support and run it through the iommu driver instead of
> > through the dma_ops?
> > 
> > Alternatively perhaps we can keep the dma_ops with some iommu
> > side-change.
> 
> It has come up before.  So ultimately the goal is to be driving the dma
> through the default iommu domain (via dma-iommu) rather than directly in the
> dma_ops?  One of our main concerns is performance loss from s390-ism
> optimizations in the dma_ops like RPCIT avoidance / lazy map +
> global flush

The core version is somewhat different, it triggers the
iotlb_flush_all from a timer, not just on address space wrap around,
but the fast path on unmap can still skip the zpci_refresh_trans().

On the other hand it doesn't have the limit of iova space, and the
iova allocator is somewhat more sophisticated which will optimize
large page cases that s390 currently doesn't. Basically it will work
better with things like mlx5 cards in the normal case.

The lasy flush is done via the IOMMU_DOMAIN_DMA_FQ and the iommu gather->queued
stuff to allow skipping the RCPIT during the normal iotlb_sync.

> I think the reality is that Niklas and I need to have a close look and do
> some testing on our end to see what it will take and if we can get
> acceptable performance from a conversion, then get back to you.

It would be a good long term goal, getting rid of these duplicated
dma_ops is another open task. There is a patch series out there to
convert arm, so this whole area will become even more niche.

But another path is to somehow keep them and just allow default
domains to work - ARM did this.

Jason
