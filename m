Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48869C48BD1
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209D5601FA
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFKRnv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:43:51 -0400
Received: from mail-dm3nam07on2042.outbound.protection.outlook.com ([40.107.95.42]:19040
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhFKRnu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Jun 2021 13:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9Vk1OYvDRfEie6uNocfeTNA9U0moZOdRxIA+hgHUPj9+szoV8QpFbtpbpOZHIgTt3JZQqHyNVINS5/MeCnAeGA3ZgvyPzGLr9qWMFcvpSq/gfMonpGj1gjR+nKbMAyKWA2o6lJOq2HzLhkOjmKzGSYke0Bx5k41h+HBfD9jaD1B3Pm024iWaEFaQ+uG0Ss25x/NOzDtlVnO0nTfsNWdfpPdDur9cLRt6cLz+KGUyQukrgwz8UOyORrUq01BZowesTH4nu0AZEFj9/qTTp4elhkxkPkCu+1zXr1dTPPgCFMEGOCUKhTFxFuDgvDFEFnr9KSyP8CF49dA83IsW+83IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsEPWM3dnplZ2FTYTGniMDIr0FIIXLaB5QVLu6DLia8=;
 b=MOhfWR/kwbosKZF2M+togM/l8EFvDokbfkYnYoERqHTCNEyue6tQFQjdmKgGnGfhOdxfyNImqy9EjvegPFEn0y+7cOifti0NiCpUMvsCOswtwitAk4hrjZEmRtzkd5NWPqfgLOs5RtNFlH0AwUVK4Es0+lsLQrc76XK1mwlarwCwpnoal0A6FR+sFzOdavIYbi+OC3vuF7+uGAW682elvaX2FGvuEBHdN0mCyHAgNgyst3Pf13AFPb7wMxeT8Ck56sH2M0cz0MucaXT/BY3xvDesF+Esb7Sktbl9+jpGl6l+1niVZslQf48eLQCHXATr4gAvphcLOpSaONWnuxlj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsEPWM3dnplZ2FTYTGniMDIr0FIIXLaB5QVLu6DLia8=;
 b=GMyqHLZD2njfTrQjrNodepsoRZJvZQNXXcaXaKICepfHNRoJYFGGn+l3QmFKW8QjqR48ZfgnR+uZnBsiId/SvhBIJCLv0BHPQ9rW+wryidqYMi/ZRbTNVv7kgK0bVLmw2ee265r7xn08glYg52fOOQPVel6+Kh+QRV4qPw9tc9hUMevXc6e40PaaBe7xnXjAkJmFQriELOauVsywTPx8tEhYWkraOes0wKfFti9jXAujLwuU+vPVzcIVPldr7tflLvUqg9FIqApALq88O11V9fuyd/QM8APKbz+xA6xNysEDmZj+kMvDIISwi0OQA5WakV77XQqdUqRmPH8AC65Wnw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 17:41:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 17:41:51 +0000
Date:   Fri, 11 Jun 2021 14:41:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH 2/3] s390/vfio-ap: introduce two new r/w locks to replace
 wait_queue_head_t
Message-ID: <20210611174150.GX1002214@nvidia.com>
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-3-akrowiak@linux.ibm.com>
 <20210611170526.GU1002214@nvidia.com>
 <7ed059b0-5d58-eeec-167c-280917b47c00@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed059b0-5d58-eeec-167c-280917b47c00@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0148.namprd13.prod.outlook.com (2603:10b6:208:2bb::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Fri, 11 Jun 2021 17:41:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrlAE-005hcg-36; Fri, 11 Jun 2021 14:41:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ae0b69-739b-4b5c-1c4b-08d92d0031df
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045FBADC2F0B5BC6FB8E29BC2349@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMQafXJ7/TllgP2lLCPQ6YoYYdLBOIN8fjfnQ2bOZkQKnUaMKgJUNnX83QCfNHDMuy5q2wgtyUC/iRiohzY/1VyYRxc74p9iZYKAQUkr+OHNbZtRpg6khLPyG0hYaDsyTJ5vNCD4xMUUzx5iL2kQ8lvRWhm7kYEuIVbv9MpdGEjJIU3LX18J9qo2xvB/A8SktsSIHTRtc/jlcX4tJ1DU+awYOtXflCqCts1RiYsTHy7MPaDFNTaibTj3MKj58vKwql62XTzC1DVJFIYgnFTZMaQ1+A2glIcVLkebigKs9A5svOOyJuKryeTThoQGQWJPjNHiB4hxestN9IzdXONmWUzbVY0I6M7HlqCirTXc/NESvQo0g4eektJi9xxTsYhasZGE9hVzdg0Pbwj/yhR1oCqgOn9l/gpHkySq73J5Ynz06Q2w/JgJqm3cMUHUlCDxKhC6mTSLrX2klBJ41jwaSvSwhM6IF3W75RU54ftMMXmebDoAErFyslCAoecs0RIRY7vJ3gBZ+sYA9XjDl+jepqRWam0ecsZwnpPQzd/xarbUgJtsDO7z3ADPKKHH/uS28bmZJDuS/LJe83aFXc/A6P8MU1EaK7MHbxNMzMnLBT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(8676002)(26005)(478600001)(4744005)(83380400001)(1076003)(2906002)(38100700002)(186003)(426003)(8936002)(9786002)(7416002)(33656002)(9746002)(316002)(36756003)(6916009)(86362001)(66946007)(2616005)(4326008)(5660300002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mH7xkTTLBA5eXGXWifa8YNPC5aVoM3a+JLGkY+SoQzBNH4ZrizafERKq2VMT?=
 =?us-ascii?Q?GNYNchf75wg/+3x3lgr1Dw3Zwa0qXPiwEZHujBBBS+0jl8PtUNOQK9ZiPYTz?=
 =?us-ascii?Q?h2IdvEtDsBaDTBTUCN3Vndh6n6dUXI3gLrPiP7S4KxtrGvG9mNhkRcQZOFJj?=
 =?us-ascii?Q?S4zZMr783DkBZb19CxdsK8jAEAIiTF6s87fbOFEuV/L6G/HjDCt9/rAtSWDJ?=
 =?us-ascii?Q?b5UH5ba+x9ZXn82cs1brn1lHxbu2n49Q1oAH2UD42ReXDCtlkQH1XTD/nXP0?=
 =?us-ascii?Q?5yYbXxIacpmYFXxGCBkQ53xjMNtmEZr6V98FsdSivgGTQcd3oU6lTm2wdhnN?=
 =?us-ascii?Q?af8tFiFU0OnW10XmqUKd4TiLoR3IH0y14qczL3Dgtidi0aH+0yu1YX7edFKB?=
 =?us-ascii?Q?Cvwa/qOXZ/+nmbKt8QkfyY7BC53vcAWYR0TaUNNPUS8kilqANqz45zzEZks0?=
 =?us-ascii?Q?V9AFSnI94gClbdrx7tLR5yYvmt2xSXAwzAC0xIPT0IkHBIOgnBdruV6bl2rj?=
 =?us-ascii?Q?qIvyi/b1QfOfEa5cArEMEWe4Vw3S/FVoslo1iT4GwTjAde0IqDhX3XbRwO5d?=
 =?us-ascii?Q?3ay7Q3bvjXcVownd5iBPHL8cnUVnS60Diuca0t5D2wodlZb68tW0ZN2EsjIc?=
 =?us-ascii?Q?S3je6M2OMca+yPLpyEnErC2V41DybPcCIpWqpi3RVSrJo6+sp48h7lkQ6avT?=
 =?us-ascii?Q?vU7j24iQ3wLYm/jhgGdHGKnjoSsDT5jYeoRnju3RVgBrERMEXuBKt7QekLTN?=
 =?us-ascii?Q?258PnBnlEEYgv179iFenAeMlUroh3o6h4se+/ZQ57vDRo3xxcztkg5+ajorH?=
 =?us-ascii?Q?AorBILI2U/LLbSP4knmGyvdMrVKY00M+T4P/wT1g27vRqbvPKWkh3HyRhxVq?=
 =?us-ascii?Q?8DZiL4sQN7aDKfJ/A7AnxonreVms0yllKIaIwGCC53yb/x755e8MOlua1b6L?=
 =?us-ascii?Q?vPqeHaTfIzPpV0lbBuSqzFdu3FOwrR3YRXuiWmc8dXWfr0q+Yar/fcGbTPYa?=
 =?us-ascii?Q?mYERcWh3vGyoclucbHCF4Xn/m7CmNn54K/aAU6jb66vw2/k5y9+GDFViRWKW?=
 =?us-ascii?Q?y5Ltlm1OM69r1Z5Po2bFJVPj6ChAovDJqghG6OS9fbRuIJpQDm3g+PfkQdlT?=
 =?us-ascii?Q?t4/pduMYz/Nln2JnS9j0YLDsinjB/U9FYAU6sA3XwvkPh8mdGSa7LmXstxm0?=
 =?us-ascii?Q?cPQicSGQOoZ9lkoVHBtAMr+PWwFyll3bkGgzUAijfT0tFUNamf64n/WpS+hU?=
 =?us-ascii?Q?Mc8vPAqqJXsQ7HQP+Q1y5vAfwaQWR6uFzzp9SJjLu36jqoueZIvEnUmmOSmS?=
 =?us-ascii?Q?orRlTwBQsXStuqNHcVLvOqGX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ae0b69-739b-4b5c-1c4b-08d92d0031df
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:41:51.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LofcJAUmi1djM5YaJunc/1C1hF+FQhHwaCnwnwb7zJqXkERSlqpUQqvvY0WLj/G5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 11, 2021 at 07:11:50PM +0200, David Hildenbrand wrote:

> > Also, not convinced down_write_trylock() is appropriate from a sysfs
> > callback, it should block and wait, surely? Otherwise userspace gets
> > random racy failures depending on what the kernel is doing??
> 
> It might we worth exploring lock_device_hotplug_sysfs() which does a
> 
> "return restart_syscall()" with some delay.

The ideal design from a sysfs should be a single
down_write_killable().

restart_syscall will just create a weird spinlock that is hopefully
unlikely to spin :\

Jason
