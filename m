Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4138CC77B61
	for <linux-s390@archiver.kernel.org>; Mon,  1 May 2023 15:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjEAPZ3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 May 2023 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjEAPZZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 May 2023 11:25:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735CC173E
        for <linux-s390@vger.kernel.org>; Mon,  1 May 2023 08:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO87UQmqo9U3fmTG5ekVORbii10rvrPB54PwjxJ1wdd2PLpU9CoqFM2X1GmQICG//qv21ASFKkY0fVVMZe9Du3AvQ88M50Rm2VxbRgtell1CJ0nM5qlI2NEcxJ8Hy4UpO3c5Yk9Qj3Eb9EVzE8A/xMiFHqq+PWTmEKiN9/qbkMHJVLw155oZVWYInri5jkPGmi/8gcFP2ImeCE90y2J/fA0dnavi7ptxG/DbRzzdVaouJApLFJaLNvzhMGl2idVyj4WSy9JNEEf5UdUDKt4zCJnWihJwftnafwzENXsiAKEMzBrpX3PNCi1N6iNYKSz00nkhN7dJ2VAcDlpdCPEnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBgvh9abnYiVx6D/VZDAGW8wU/bpFqZuwglm2ljc8/s=;
 b=COVZuESLmlEn9sKV/zTQJGaM1AsSw0DQXvZaH7lGWXusdrM6630sqlRB99ILPSj2gOyszGLzaaK4pAPtQN1fdkC8LOJFEqMb5vyf/V2v1ci6IuVvqw/GLdEMQoaAyOhqxJKR8eozxZjFdEjI/5/N/3o6MPOowUOjlVObjNH3RTPLXW+c/xFRSEp6GLlQSOH+6r712U0IT9A2fFGUDe1pn/m4t/0N/rFMhyyEoaaG1qAfHQmFo/3dCAMASpvct7YrX1uBl1tpZp52tImsVGRvXAvOldK10Ge/J9CGqZSkLHOmclygv1iAPuT7srn/Lkhh8JDnB6E1rtpjzPDcEKaARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBgvh9abnYiVx6D/VZDAGW8wU/bpFqZuwglm2ljc8/s=;
 b=LYB2y+ssmv/zlFuoQaSo6j4SnO/FsJdWFJnajrPcoivIZPCEqZjA56W3px17sYJCHvlSPaRLarZYkDicaVpdsxaHM/+9sf9X1YLczlxfK4l3W5XUln84R9UoEUuG4J1+7aTW+HeBL1Sm3lpql7JyxgiTR9rV08QJcmGbyyusGZgbpae4/NFW6Wj7yWwCKCiYKLiaPBg7/N0myy10SnQKGt627V2lx/Kc5ilQKHf5IpFGg0EAKBztN+p9opnKRxG3xSNwy7M5d2Mh8w8sgbC8UmgQcrv4fWCbTkH8i7EOwSwFA/5B57w1PrnzAUlgWcPePrwT5nWyWAOrP4AmWNjDRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:25:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:25:22 +0000
Date:   Mon, 1 May 2023 12:25:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, linux-s390@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH] iommu/s390: Get rid of S390_CCW_IOMMU
Message-ID: <ZE/Z4GWFKCS8z610@nvidia.com>
References: <0-v1-11a50d289ac9+b6-rm_iommu_ccw_jgg@nvidia.com>
 <07a891513e1083eab901af4dfa630bd60f93479d.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a891513e1083eab901af4dfa630bd60f93479d.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:208:238::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be74dd9-5483-4dc7-42ce-08db4a5847be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckdxF7bvQFWWmY8xZwjQ4vnLTRqeLmnaOWXA1WE5u7EVjhuUJR9T702dNKNU+exlD7fwLxeasRJgwFFZJF6T/P2awqGkO9STQJw7Z2aDr1F7xcCzZbEu8BHbeC4AMG3bxA6YfNScwIrfPnEwgfdbuuA/irGxpauvAfFg6y0A5I9H22asDn2hfu6137EIGgwvWYBlyhhhsD2Dv7ow2yibopBGjxHxP5xsjyrNsZyFEZT3FIKAde0YKw09ATRQjyvOwgdtIT+O1/DHyVwTfJRRqiE1i/ps8XoIIfg/32PgYl+1a97lNZPXSWI5tiTuk99MBN7msCWQrCO0oHyaCRGyK36I8tgJKXlJtiPsfCw/1ytjQaEc2YmRY/rfKNI9y5Qw2Ojl04npMG+vfVDEQ6wl1D4gwGWIxb9bTi1l/67m4YPvrnqvAMT9HwX4q2u9ZG4oPvBklqdqQX9hGVjgjUu5yXKNl0pN6ds2jZQv5Jt4uypXFjS7FkqCQ2TZ1Rr1kKhyno61/pRl7ACac08b1VKYJ8y1Y0HH40UX3Adt9dxhgXIxZ7ZPtDi8WRwrUyTavHrr0MDFl8vQ/E+tYygbdIEsOkj9fEJDXDxLpekuvCK5nOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(5660300002)(8936002)(7416002)(41300700001)(316002)(36756003)(86362001)(4744005)(2906002)(38100700002)(8676002)(83380400001)(186003)(2616005)(478600001)(6486002)(6512007)(26005)(6506007)(4326008)(54906003)(6916009)(66476007)(66556008)(66946007)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6/MK4IahtTnXPEMSjZjghO9v+qQ4vnDGFZt0uhUEAIwkklCCyLdJY1Ag1Mna?=
 =?us-ascii?Q?lAPFkX4UYdqCEVLhHC6zvHQ+JJJyWwHPwDvDIcKoHRUNpF+m8ARbGN7dpxsC?=
 =?us-ascii?Q?hK2Stvks/cIqzTBkiixef5ulFXJMy7wYEn/22z9mOfmquq94ueA4CCNf9KOS?=
 =?us-ascii?Q?AZGvZ5UEh878cfwj1SRnjGUx3D7yb6bgzlMwKulEtux6PcNdd+cQxKs37mKO?=
 =?us-ascii?Q?c0eM7qFBvfaK/bUyD9zCpjNm2BU5SzOBLGMwFbBAfQcFcKMADjMN24T5Gloc?=
 =?us-ascii?Q?owzus3QzdctuBicIZjHZ/3B6OPYZ3VjfsWT5pfXLWEZAYP7P0dlWAspKFPJF?=
 =?us-ascii?Q?zOfh4b6gsc0U+bFWSNcYC+a3uFjaDYheEaHEvgRMxfQJOU09/V7E6WUlPMni?=
 =?us-ascii?Q?xIvRjERbSNjRibuPPMoOoa/t49gPpXo4XuYll3HzVLiTFkfZ2kUmGao57N6c?=
 =?us-ascii?Q?OsNrFbJlhDpwrPNmUUvwu0qRZlqoEhfw3h4VXEhhd69bYI6BaoI2CUGlxsmC?=
 =?us-ascii?Q?lH1FAp/gA97DPTXHHXLlXeS0YeqhJA8fuUZR1drXkDnPpABXPxKxgisLrOrP?=
 =?us-ascii?Q?Yqq+hTVC4Ani88cN9Yw5I516LCVX6juyQtwrISm7ut9sppo13Ge/pVpcvRyc?=
 =?us-ascii?Q?uKekeHgoB2isV5R5qRxMLQDNIHgFCnTGe32d6NnTQ7yDtHFkM8xu0yX7m9I8?=
 =?us-ascii?Q?MiSTljtKYevh3qTN+mZhQyZv2kJHS2KUwOSuRNyweZ1OSjsm9QuZBvWdducW?=
 =?us-ascii?Q?vZwsT0Xn6ZDz6zqJj4YSZb6vpEPhmqWXurBnWbrrDPT3aJi4JuBJ1OgLCaDA?=
 =?us-ascii?Q?piaUwq2Tkt4a3RnT0/a+qgSNmPhWEdtV+ca+Cs/69i3VVMD/Zu18UDzQROqi?=
 =?us-ascii?Q?WyUVymmiMcfpQD+lCrsh0ro3N7Yt+oiS/Zq+2WYkhbD3SXJYPeIemJO1e+JD?=
 =?us-ascii?Q?u/Op89OhrOKW0lKTiI4RuIcGnaA6J5HFnWRUxQKuB32IsOqxefJLswgzVxDi?=
 =?us-ascii?Q?pqeccr8FaiynxHl2tx2lXoIn+ubrk70ZLmvCswaauA9toYB4gvRrHUKnoOFU?=
 =?us-ascii?Q?Z2BHuTCvwmoUCF9lForG6pvH/3ra/27RIgbqflXcYVAe1/NEYwWF0bJDRHcf?=
 =?us-ascii?Q?ZewVB3b4uiriNy+6FAclOUVeNM7XH7BdssnYOdAUffvh3s668cC/JPA18cm7?=
 =?us-ascii?Q?b18Z5thapRq9+gCRb/a23RqCJNpzCuGwmiGFHGISuveYkhlCuNNM/TW9QwDt?=
 =?us-ascii?Q?dAzex5pMqJ2ibM+7HmWXaiJ7a4bzQ/Iy3fXwXmUUB4pBCa7PXcgrBV9TfUv4?=
 =?us-ascii?Q?SHCwwaaUeNevr2m9OdTA0oOly9nTj2VrMzHvXcot3tSYBaqSiXMNqsHTsmT1?=
 =?us-ascii?Q?+E66rDSasHpHuk1wkZBRJCfaTHoHu3NopKAlXWJQe406GdV+FolKf/uprWi6?=
 =?us-ascii?Q?uZQnVWovk0AbsI2N8HimFnTgaq+dzQWx4gHy+kmNvBH6evK43/CUwv1tRCGH?=
 =?us-ascii?Q?NjPUlb46vmvu3eT9amhgzdO4Kit4yeGsEzvoF2zD7JIZuTUsIlsn2pjvVrdc?=
 =?us-ascii?Q?jTfGK6CW+J2agGHMopMyVAKBiL3xeCSmfUHFop9W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be74dd9-5483-4dc7-42ce-08db4a5847be
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:25:22.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d238iMVd8A92yyWD5O54M630fToRLe5y49aDh5/+GaIvQ4Sjqq27cjBfx3NpA8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 01, 2023 at 11:06:51AM -0400, Eric Farman wrote:

> > which
> > required some mess like this to ensure IOMMU_API was turned on.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> What of S390_AP_IOMMU? Seems to have been borrowed from the _CCW hunks
> being removed here, and is now equally redundant (though I have not
> tried).

I didn't notice that one, I will fix it too

Thanks,
Jason
