Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A5C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 12:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1586100C
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 12:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhETMyC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 20 May 2021 08:54:02 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:60608
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238600AbhETMwp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 May 2021 08:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5z++hArubgIz1MC5pBI+O2+p49ZHEg3H4Q8tkB5Xjhj3Tidbhh/HdhxlWjwnD5o4tfmykQmxO8GdegVy+j/kNjWTuLacdEVvHytAKe9VW/7E0azH20EeZfXrq41ulRuNDi4Wyjfou3PHrBLC3l6wTHPZ1jArMcjkR6CYkDxJF6+iUAg7vsL2cH1eddAxSei6JOH5ARBqmZhD6RQxyXL4n19SMEl1SPcWWDFkq2Mcth5TRaylI60m5gu1n7MseXjk8KryYsD73LDOvo85HEpviof7xHgd96DQfyfbqD29GWrcocMcRYD4nwUgSBSTAIQL0SHnZE8uqYirghO3sJxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDG3CM2C3VcnGNqPsG/H6ll6MuZ1kERIwBUrZraeiEU=;
 b=ApkJTVMXF1yZHLSBtG0wa8NNke2oMhoIrdxH14HsZNzTGr5LKPuvOp9vWwgK8hGwHf27EsdkfGteKbqRpL5sY9rag/x8rd7rnmjeSpKpRilu6cHmP7O0Nu/K9qIcv27tWCTOyHsAnegk8xqdC9M05aJtvhDJRmstqagVy720ovt4VQYk2E8jVlWKJam7PHc3vn1HGYkQOOgG8tlny8iE/CT7K+WcjUs0RFmGRJoddbkodlpEBdMpD7V8B4uBcqccccHX8d6vKB/TfG3iGGJ+tVwsQ6+pxost1QdlCOP0CJZTBxy388QUTPZe5+QZGrkQvauwMnk0EktdxnrXmm4hXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDG3CM2C3VcnGNqPsG/H6ll6MuZ1kERIwBUrZraeiEU=;
 b=m4N+FPZnelNG8e3K7UzsUnJ7PWieIckncKpMwKA0dCprh0qh/LlukDEdZTeTm+4hq9v4s3HwJm+BeZnJB2vHW0Mi0pL3aySzs3andv9aNFVnUqiTNxE8xqQwr4s/8gfm3IAoLdIxmA7etNBoXldrEephVEqzn0WTEiQBZE44QZ+43EmEZUQ98a8I5CjfD+2GMMELvt6V17T4uAxZ/7+Kv+6HOgqykqOnbJJd2bINDvyCUxRYymtYZnHdSJD9dtZ0LW0tutGq4ui4nHPR124rPGaj/HdTdmxfEHifDtmEy53wKH9AWSKI4K91BNjo3BlyYAdavwctHm8GsM13yinV1w==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 12:51:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 12:51:22 +0000
Date:   Thu, 20 May 2021 09:51:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210520125121.GX1002214@nvidia.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
 <20210519161610.GO1002214@nvidia.com>
 <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
 <20210519232202.GV1002214@nvidia.com>
 <20210520103829.0913b6de.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520103829.0913b6de.pasic@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:208:134::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:208:134::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 12:51:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lji93-00B97s-3M; Thu, 20 May 2021 09:51:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 478e5c5d-2e17-47a1-7f2c-08d91b8df880
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4778CB5C31401A915354586BC22A9@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xkb6GaSFtBuMdXreo3VB7P21XKVBs97Kvygurl+iJIuMkU7Q/FWZwymqyZOLAxxCLol7AIT5MS1DGnAVcle7mbs4ifCIIzW8NSRak8j/Cy8Y0/Pw/l4ZDky98d2FOlS+VoqSw8l9+Ug7jzl70r4v5Hmi7eqSEsuD2yIab8FLpPenpocWNHw+W762pB1U5UNAy+Rea4Mo51ZWIYTn1ZRvGuLfbl8MroIPnMfVNAyRLCNfefk0jbvu9iTBz3i218/rxaAeTaKOD1JvMkNKnrdW+iQhEgNTVE+tiVVzci+SL8LYCWhz0g908Em1z/49AANtL07miJ3nelLGTQUui5ZOZA1WogWCpc7GkiS6gtxyi6ENbYcqKFX7/ODsgDhxiTDbmY+KM+MNutKC1cK7IukJAWSuivPebomMO15ZhN+a4BqBUNuEPP+LQ3Juo7AXnSHmjnphu0Igiwc09W5SJXQYQIGKJumb1nWvVgr1+IPBBgCh+Ll7XdB164X2IjDP5MRi4VbF4YJS5Vj7bd92D4PF0t4V90OZYYfpgmuuM2yzX9xvGtHPsSe44UythzdpCCssm7VHaOmJ6ckBfVSFhSsBwKarLEmixeylZeV/Y0JffIpYPxlrY/gM9p1OrvNSZv5rK5sTTPNgLXb9nRnz2Dj3O66tAkKrurwhkNqkgckcsXfTDeeJtuZbzooyUmEdYixsA3yjwPaUYObz7VpJaNN4eW2TxZ8KMNF+SRlXJYW6oI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(66556008)(66946007)(6916009)(66476007)(83380400001)(9786002)(4326008)(38100700002)(966005)(1076003)(186003)(2906002)(9746002)(33656002)(8936002)(8676002)(26005)(36756003)(86362001)(478600001)(2616005)(426003)(5660300002)(107886003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BIWeIu3jRzz3xOghJ0Adq4rsiOlOCW1NS90q1TabCJFNRdg3rfT88dsKlJt0?=
 =?us-ascii?Q?9ataDPDZwlk0N3FjCiYtCBjOxXQPYwKYCQMcUFRnbjsI/Exew27c9bfa5VMO?=
 =?us-ascii?Q?SeKgNtUoTlypwMEf2KSgDs95eoQXrr6ipLIDp1OGX5peq5yG48qfGAQfJM4r?=
 =?us-ascii?Q?rPBmxCYA3jWug/Ev8UaXkebsXTZUwD4RDzjdonivd5iMleBooTytvGZckZwP?=
 =?us-ascii?Q?VGzpT54l9iP9RMJXRYc1pVCpiD/Ggo6Tw4zg5Q0wy1wg46ncAk+iVxFPI/kX?=
 =?us-ascii?Q?+UpdWBuyyoXO/FSBUq1mt3rVwEMJyHBZ/mtoCLj/Sao4cPmMllUwvJR8HVFM?=
 =?us-ascii?Q?OSmgkb1iYTMJpsuiYeSu9zLkJFhip6d1YykSZtZiRyNW5UrQhBXLzUXSpxNO?=
 =?us-ascii?Q?jaoMUnqfJMuXdxGtZyA9y6HV0hE2rcqvn2HI3FJsZ8X7vhfe7xdDSGyu85wS?=
 =?us-ascii?Q?ubN166DVbkHh5IqsukWDRSCKk5Gauh0I0hadOUdHtT8ViKY6Y46jZzWqWn6O?=
 =?us-ascii?Q?c76VgmEAuDHXdjz0RLTGDQ0mv5VJvm4ZyB5JEt9KMt1cou+DWVVyUlkJWwxI?=
 =?us-ascii?Q?8Ll37t7pNb0p4up3H46IUWG6TrsH4pCZ05Y56a366Oi9r2Yh2fBYr1+jDfcC?=
 =?us-ascii?Q?9s8wJMOWO4WjJ7YRfMi1gQJ+IoThGRyfrGhZTHG4ucx7sQIL+NcUza6HRl9y?=
 =?us-ascii?Q?j+7vgdam36unuUhY3juP/TGDibI4yehx7nvzamJ3KLQY5b3LdWT0K8ftvRHY?=
 =?us-ascii?Q?4E1y/lLtvcXBJzPBMfS5z563lblTCUwdwhWin7R2B1bvFs0TM7h8cYzl4S4B?=
 =?us-ascii?Q?41KHiM5ze2mgNTiLU/6bvwC7DrO9qKmNqb3OWbUtC+HzDhBdN3SY2zKeF9cH?=
 =?us-ascii?Q?ufXBL5yi/1vqNGUvjqACBGihELPyiVyXX7pgdddON+nveZAV/iFBfSMIZGEq?=
 =?us-ascii?Q?n5brF3IOfelSiEhUUyFtQW8a2KdZvcq/ACsCqoFnMNsVsAB8J+9dbRGNgZdK?=
 =?us-ascii?Q?B64ywTi7R/NpSi8GJACm65Kg0XV3K36iLaRYBZoodRon4wwtKmtyimg/XyDB?=
 =?us-ascii?Q?R/rEPz89QlkaqXJdb4yCBbAIOAfVBF5xMWamVZai3jiaXxths9OuM+pfb8tj?=
 =?us-ascii?Q?A17akGi1K9aVuipBBZhK4z9i4+oQY4KNiJCSBmAdKH9kbXwV6RZVws5X1PFh?=
 =?us-ascii?Q?y0vnuywPXX56dTwFCr9sb8DgCvy/ADAFXv8kwA/79W06/HQWfwcEvJwsEsvJ?=
 =?us-ascii?Q?SjlUPKv6yegmrpDvLff1A+7m1gYQ183HjF9qgJjo/oMJ0yv/BI5J698jcZGi?=
 =?us-ascii?Q?PLdrRYmcg5CI6siliUkrEzeW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478e5c5d-2e17-47a1-7f2c-08d91b8df880
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 12:51:22.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bu/tz2X7+YuBslYMy59dyPs6t6uw+JqIpJf3CUAgGcdcg4U9g+NLrZrrsnlQYH3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 20, 2021 at 10:38:29AM +0200, Halil Pasic wrote:

> > It eliminates one atomic from a lock, but
> > if you go on to immediately do something like try_module_get, which
> > has an atomic inside, the whole thing is pointless (assuming
> > try_module_get was even the right thing to do)
> 
> I'm not sure about this argument, or that RCU should be used only for
> highly performance sensitive read workloads. 

Fundamentally RCU is a technique for building a read/write lock that
avoids an atomic incr on the read side. This comes at the cost of
significantly slowing down the write side.

Everything about RCU is very complicated, people typically use it
wrong.

People use it wrong so often than Paul wrote a very long list of
guidelines to help understand if it is being used properly:

  Documentation/RCU/checklist.rst

If you haven't memorized this document then you probably shouldn't be
using RCU at all :)

> Can you please elaborate on the argument above and also put your
> statement in perspective with https://lwn.net/Articles/263130/?

This article doesn't talk much about the downsides - and focuses on
performance win. If you need the performance then sure use RCU, but
RCU is not a general purpose replacement for a rwsem. People should
*always* reach for a rwsem first. Design that properly and then ask
themselves if the rwsem can or should be optimized to a RCU.

> Yes a simple sleepable lock would work, and we wouldn't need
> get_module(). Because before the vfio_ap module unloads, it
> sets all vcpu->kvm->arch.crypto.pqap_hook instances to NULL. So if
> we know that vcpu->kvm->arch.crypto.pqap_hook then we know
> that the still have valid references to the module.

Yes
 
> But in my opinion RCU is also viable (not this patch). I think, I prefer
> a lock for simplicity, unless it is not (deadlocks) ;).

As soon as you said you needed to sleep RCU stopped being viable. To
make a sleepable region you need to do an atomic write and at that
instant all the value of RCU was destroyed - use a normal rwsem.

There is SRCU that solves the sleepable problem, but it has an
incredible cost in both write side performance and memory usage that
should only be reached for if high read side performance is really
required.

Jason
