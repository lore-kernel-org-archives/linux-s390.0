Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA31C07E95
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D263A6128D
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMRI1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:08:27 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:57185
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhGMRI0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Jul 2021 13:08:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVjswc1nshV5ZwiJAK2vPbirySDfwtcxVeBG1CT9zAE0SRkRrV/BNZ2/Igi++ZS0vdzttoMzB5wM2Rf3qGJn6RTlyYgfQLHSH0QQK16Mrf2C/vuoVHwiz3pH6W2HXAcaNwRC6hyq9U0r71GmOndedxC/qAwXmC9hQC1bN3EYXc0e3IMw9iYIooN+BNOXaiPNRQBwleITsQ2LaGMxBsOKdx+EJ/51QiHegoiZX682pS0MxGx/0Rs3IRHmPQgIQ4mzENBlvAQlWqsUGCDuO4Ivg1MbRhHwnQeeex/Lanhk0qRRvWV9z4XFNYKLWETK4oaD60KVQD40H7ho7bKnGJYUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E09XlC01CnOJbl8rPrW0J3ZpZcpK1iJBK9lnk466FU=;
 b=hXkYeuH2wDiPT0WbbieQRwcoDEQJM+ARDysyjQg+tdXQQHaHVMp9OUexXhN4lO+dF6i8mYm6F2HfMsUDo97ODw+/hx9e6Fv3t+KC6JwCaXsEzyl7QI85CtUh/9cwyGDoD11dLNcy12U4xqyv2NE0V1EwGGv8zsyxaSSuXYikbHWmWDI9fQzdhCnzNgfZckmhGJHpp7u5lwBUUPLPHXOxosQi3OLbv6+KBj5zTY8dWKZS3vn3SfdlRC26AtU55HFxhVN7+YAo33fGoU/YMd5xDsBLQySCtH7sKyMcoodMbhnp6/nm6bODHC0cqFhwKzdfFyt3RPFO1R+pWnOyrR+uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E09XlC01CnOJbl8rPrW0J3ZpZcpK1iJBK9lnk466FU=;
 b=ktT+Z/jHEY4EagtHz4A5ob9omOiLhvPq4xNbr2I5v7xZH2FguXQgZfy/Pl7894Wo/3qPZpJU6MsOe5gkcHEQCuW9J4hq0roffrXCCgOtxRo9m6AtO3id0+mYimBVS/Ck4lRanzS7ljb6Yoa7ab5U8Hxaz057Ws4qJGIhYnqcaMexCN2+0wasF2mBxPrTkXmVXRIQdDNjTRFHft6H2mXEmXB4uAvt3THiB782+a5nfqhQj/r3nn9BCS7UE063EJYvkyQnZ63sNZlb09PaB1CaQV64IQ68josdxsivu2pjwk+gWHtElKTMp7bfOfc86OBZSKTGV5VMqZOyjgjI32USKg==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 17:05:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.021; Tue, 13 Jul 2021
 17:05:35 +0000
Date:   Tue, 13 Jul 2021 14:05:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210713170533.GF136586@nvidia.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713184517.48eacee6.pasic@linux.ibm.com>
X-ClientProxiedBy: CH0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:610:b3::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:610:b3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Tue, 13 Jul 2021 17:05:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m3Lqf-001TjV-Be; Tue, 13 Jul 2021 14:05:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ba60883-7b29-41d8-5cbc-08d946206e0e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5143650B0F0A37A11322F09DC2149@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkHmNkTI9GVeU+SilVR0WOAOBJX0CytJl9onD+7/54acBfmspNCCfI3nAR1nYRRnqQw6d2nRe6q1iw6n5uDSgVWKbOGhSE8sAc5TZ2WuAcd3z5Pn3nGwjORg0b0YqKy76DeecptFVO/5ev+v5bDyjZBLKST8RXIDRs4UsyKxMHWsaEPeLPkOttlye1/XxiaXywvdNqbqG1v429rHRiqctCNbAuV7LUfxm+wc5wevlzcwCeMo5sio1dqEp2HJsAHL5g8KpP7NVD87HmtUvnUWKBKyVjfB66zKlKqYsyi174+5r1KsvjHmI2UyLtJSWBRhoIE3TeuaS4Xk7fgxGb2cGwO7BhgNznlPy+Qb7hJZHkw6uGwXHTnsI9SIczWewFYnj5cLZWOnVCSVJ6i7Fcl8njCUqHfbRLCHy765c0pzK/DVgVF918MG88iWeA4AUURODH4hFe8Y0HntZbkGNfZVegw97yw8nVpfupQoy0Aj3/EeQiUF4HFOBddp4nUEVO5xv5MfLt8ePKcM3EPu/JKffatdSuQWIkiK8UTQHWokGBYKWGmr1otFlUlfugyKpA9u5Vs1hJt0aOiFFBBKwJw3EvE5yAuUhJmFgCBtcIPBnSUOe7ivLC3i+a+HaVzW4j13h2khO/tNy7/dfF5iqYod+ghkRsFyQK7p/PUA5Mk9VBmMYowthZmTilY7pKhdClW+sAJWrbrl89F1elpEpLfdHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(2616005)(478600001)(7416002)(186003)(2906002)(66476007)(426003)(66556008)(66946007)(38100700002)(4326008)(6916009)(8936002)(9786002)(316002)(9746002)(4744005)(1076003)(83380400001)(8676002)(86362001)(33656002)(5660300002)(26005)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sALT8+CLQ3miJ5AOuiVYxEf3ptjmfXvw8NoHIe8EmNNZdOCtv/o/xBLirlX3?=
 =?us-ascii?Q?rAQyD1/9TuOh46HmLUxhZv6/xVHjDnNXFsqgGPaosflEm2Shvk3nvYItFsJk?=
 =?us-ascii?Q?UkVNtM2p7i+x/AIIqbITJ8P923jYoKQe4xbJj7iOSIKWDveiPj6CPHvuEwTp?=
 =?us-ascii?Q?Vfz3d7b6hcJGxO+nq9hQsKA26mdgP7cTcKLsdjzsCpfFZ3QHn+RWvEw1+Qmg?=
 =?us-ascii?Q?+9K0a5b/QjwB69R1yuV2q+UaGmGDNU158x0li1j+jHXMlva8ybAo3PMAH1SU?=
 =?us-ascii?Q?1c2sPwZq0L3cbCcfJgB5/hq+lA9aK3P+pVo7YkhJk3A1qlcbU1TPHVZnZ7GW?=
 =?us-ascii?Q?OM3zg37YAzA+wvM9Zlj+p6aVVy2p8XFt3qno4fSpfWSNQIQwQUfk+EHs2frI?=
 =?us-ascii?Q?EP0c5svhjhfx+7VNiYpv6Ypyis03s6QR6SAgKZ0SFEFIUJSJjDBHmBL2/9d6?=
 =?us-ascii?Q?0HV3ZY0TeZtrbVUDG+vc8fYhU3QC4yZ8n5QM/TU0BVQgU9IgMj1p6189e4/2?=
 =?us-ascii?Q?BEgrEEkAFHwk9QMx6YPY76lbNqYn8MWcQ6+MwuL8raBlX6z3CP54JAABTV2/?=
 =?us-ascii?Q?7EQx/QDHNMI1zOdkRDw3l/95rOoduJk0wFEyN87NZcNf+nrh8m5kSRijsQBo?=
 =?us-ascii?Q?WgR0zIJB0gEYQzasOj6X4GcyxVPfo9FFnRMkuPSGGcsE4tq7Va66U7a5xPE8?=
 =?us-ascii?Q?iMDJuKViWQ5oPF2h7YPpKgMp8cQHLVIM6HZFv8U3dKaDIg1cojfRMIqAALdL?=
 =?us-ascii?Q?EH0jXaYh4c2YBaN4XViHiGRgDYZiu5czuDpYkDIAsqLlpNAKHYqPALbLKIR/?=
 =?us-ascii?Q?VKDgvB5V02y9W4LxxLj+kMOK9bUCrkz4PaEIVpJUKjw+qM19BSp8p01t3l4Y?=
 =?us-ascii?Q?tiO9NbfLWrSR88etF2QRmT/uFAJRbEER9NNkFlg5ALCEWbIDmw5D6KavP6qo?=
 =?us-ascii?Q?gSSF/SbxoFh53lbX7EZK8Url+0Ks4qDoTuC0EVHNfohRgJxXixvOHY5CHseI?=
 =?us-ascii?Q?jvhqNpH3yNt5SPRd6Te+Nx6eukiq4kwYYNLDd7lL4K+Z5Z1YbVbxUDpEGRgD?=
 =?us-ascii?Q?DxOyvLtKrCUTTLmSDUG6rI8Xe/B4+MtnQf5NhHZFRZxBsbLtBCeS0nax4DEi?=
 =?us-ascii?Q?QgCHkpd3C0rkpUq13k9K4YujGN7xOsHUbxMuihHn5dBWMn5QzQHHsGtAhPky?=
 =?us-ascii?Q?T/gzP11MhQhBxq4KG3S0csEcfrq67bhN/WYlP6wAdPd7MOqusxjNoLQKBO93?=
 =?us-ascii?Q?ZChcJHETXqrg5/g15dr+IahOdTNlks8XTL9n10vbE4yGX+xECc4sE5FthcH2?=
 =?us-ascii?Q?pYLKg8RC/1+QL99ZTcYMAGHa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba60883-7b29-41d8-5cbc-08d946206e0e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 17:05:35.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dV74SNqe8Bd4BGXGw9Q4PiHw8As0yagRlLi/pRxi1D1y0geu8D3iYYRvWrdP/98s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 13, 2021 at 06:45:17PM +0200, Halil Pasic wrote:

> Jason may give it another try to convince us that 0cc00c8d4050 only
> silenced lockdep, but vfio_ap remained prone to deadlocks. To my best
> knowledge using condition variable and a mutex is one of the well known
> ways to implement an rwlock. 

The well known pattern is to use a rwsem.

This:
        wait_event_cmd(matrix_mdev->wait_for_kvm,
                       !matrix_mdev->kvm_busy,
                       mutex_unlock(&matrix_dev->lock),
                       mutex_lock(&matrix_dev->lock));


Is not really a rwsem, and is invsible to lockdep.

Jason
