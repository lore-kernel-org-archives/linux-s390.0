Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7952C48BE5
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B137613AD
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 17:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFKRIL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:08:11 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:62592
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231408AbhFKRIK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Jun 2021 13:08:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wca1RdKtnvuMl/4n3RkETskLfAFfXyUUvmUr/o9KQUOUK9w6T2lHAgwIo7qnKaocS5nCpab9uj5q7agQ05EIizDyuoCwFvBOqHEwpnSW+M1n7/Jx9sugSMB6rhKKTvqzYYR88KbaLkthNprbboR4aPii7s13Cons34kpPWP14LNuRO/MP1pJgVe0zKgFtAaqaq2O0xYJ325s4m3FrvCVsQ3pFDK6YBGNR6YSZPpUKECQY+QfLpePv1bz6yMJjfuqU+mzNooO2kpk7fmZ7R52FVYSS7pmTr5NkPcxwoCefCbYPFrbcbEyG7L76GGR96GPKgoMGTPp3xoTJRAtr6D2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm+L5CfZlhht3vTJUMQeGXCSNML/Z6wiIPzHRjdhDHA=;
 b=UUZvvyaNNCvaUId/fHNox6yIsnuuPIdqdOjVy8daAATx1ZcKF7ef6VtHm3FP+eqNJQnyzaCTMaWGGMWGTr3MNFJAgZGXSzLA7otPbbDrpaB3WuVPr7ixhYncy9HAGZYw4AkKrH0o/WDNj3kq5cGht4OQABaQEQpB0nz3VM6w54CBzCMU23WrYqHGWPv0s0INS83FZ1jt9uwhZZqlx3mO1YhUyNb10bJ0I29QOk7m528cLXYp8rOzo5FPeAKJ+A8UzFQNybAIKGcDmzgwWdkTxk/RspDUuFiI2f7mjMQIwN4ouelx6yuunNuQZs4hAZ/awgciE1ENOF94q89gmHDjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm+L5CfZlhht3vTJUMQeGXCSNML/Z6wiIPzHRjdhDHA=;
 b=RCD7WmzzXmUNxxWivCYa8pYeKCx1DMcGBFL5oGl7XcHdiqHaCIupSlYe1dagbPuOyvk+vuAO45fjWP+pTQmXioS/AZW7eG2s83bb+joLIEzLdVHUXQx1NgsLxcn5q0H9vR5ixIz97fQlWd939DeWBpJk63EWb/bDFtz8vp72osEXEJnVE0GWBcqaw0j+ZRu2BY42qkGBk6mg1ci4MMybj7Jtztz5F51/+EuZ674W2AMqBqyTlSmfPJDzVpe4jcTcKvfV/Jx2eBj7DcrkwdHWf1eoNE94CbiZxNS14zOmryxMxOXfPX86cbZV0W4jyv9OvgDtKtyK2LFJfHgFJEJcyg==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 17:06:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 17:06:11 +0000
Date:   Fri, 11 Jun 2021 14:06:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 3/3] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
Message-ID: <20210611170610.GV1002214@nvidia.com>
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609224634.575156-4-akrowiak@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 17:06:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrkbi-005h5A-FO; Fri, 11 Jun 2021 14:06:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ecbb1c0-5d42-4859-2e23-08d92cfb3693
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52553B72406B843840489C89C2349@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myUqdCVOmNehU98Zfwpy2TEsECQkH6gq2hp7621BPpFnUSEvILh6VfXyzRctCZrRGal5Yto7IGNdXRAlgwBs6D7gGYkYAa3VcYH6qSRhILDGkTUh5G8IBz0dcF4bkf9hqBaPrOXiOfYV66N9CxfAZwRUWf3o0RMMcoiE+bImP3VoRgC1xdG4b+ukgJ9DhrMVtFj6OTT5R59kEn9Be/BJJZgx2MUoEcIgKdNL7HMryXiYIihWDEhCSDRW56yVjsqadUQK013h+7/wYRNmltKSZslayqBKo17xgKLHx/9gq2xpvq1BNdcVD4nWCvLIcDiXQsF0vj4PPoUACSdQzPnyp0QXKy2vWF/3ILcSZ8nuy/UXQ2hL6aI+FwIpTt9z6unHBlKD4RAohtUqmXlYPg4Bn6UcHhZ9gPCpVYuoa6KR4uuEKjFzxpIb5YkMBXUHyOSR4/4ZHwqGUYChIO/v7DyVQQeoR3vCAzkhueZ5Ynp8HgM+pxON3yIf8qstgK9agpexr/RpUjWdEdjrMgJhY4dCEBF6xn4pQewU52ikYbZdkD9Rk35NX0dWTznc5auLAp75TjbpZJ3POJTugDJb6oP0nEUUOkQ+bAHCmLGVUq2f0xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(66476007)(6916009)(5660300002)(4744005)(66556008)(36756003)(26005)(86362001)(66946007)(38100700002)(33656002)(8936002)(2906002)(8676002)(478600001)(186003)(4326008)(83380400001)(1076003)(426003)(2616005)(316002)(7416002)(9786002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n4eFk72wLE3+AYWDE5uxqZFTx+c4ywGzl5DBALI+ZmKuN4Xwr60Z95Eqx98E?=
 =?us-ascii?Q?E/xIqPNiOaP2VdWtpsGe7VkHd/CDi74WnNY40i8XpLkfENUSTRv0Iou1qfbp?=
 =?us-ascii?Q?mIt2SSlT79qyyiLk8fPbPx+sqBooIwMUJnI74BXOob2oswklAxv4XPS5JXQ1?=
 =?us-ascii?Q?kqrxW1qbwQDaTt0Jj/f/NwkYXTzloz+90AXeotjJA6+tdLW6pZrszAKZ1yAu?=
 =?us-ascii?Q?81Zml470+flBuiiv4WW45hx7JEN28AJjx01whPCwl2JzcLvYva4inCEWGPFQ?=
 =?us-ascii?Q?rjDAortfc8kOEj7KNIau3b3owJskyP87lUxXX1xbtvoBqNjxxdhNcGtcyjuC?=
 =?us-ascii?Q?qjCpzdzp5/8GTGruzSDgKlIrhtD+GwowDVYpvY4xMwSWrX49bttyKnwUEtfI?=
 =?us-ascii?Q?wKzGAlcaFKh+q/L2XvZthhMXwLlIVZVOfbbBTBlzy1ac1sTKTWQhyrTOwqKC?=
 =?us-ascii?Q?2NlhUvsz66Xu7SU63ODjNR4kpMbEPnUcUxddu6H1C1ma4dqHonR6b7ZDMuqZ?=
 =?us-ascii?Q?ZQ5W6bdDFeF/5OkoSAwKZBwrw9wtXbrLfUMN6YcXirArk9z8zhDLXKaYWa4d?=
 =?us-ascii?Q?Da4BUciLapP5t36BSFI1Ugu6Y7jIE1p7V7PrxZWe7UDiI38z8hWnC21pSvLN?=
 =?us-ascii?Q?8pODBtuABCpKd4okrBzBEFR2M6WL4RMyOnNXmHLmTA7jbK2o4PLdFpeq3dwE?=
 =?us-ascii?Q?pv7PdxK8sIJVFD+6SteieKQgVfLnrXlHgWzzV4VvuGBY/iEACmyH4/D2mBBp?=
 =?us-ascii?Q?ZdVIVJHXWjxilWCcB1GiIn+V4NdhS0WRKeKrnTkOYwXmAVpKhTrP90Wd+AcU?=
 =?us-ascii?Q?g3JP7iKoUyqBUn+QREJ8f57JAWHK8QrCceve3MDB+p5HlXIozlq0ZykChIlB?=
 =?us-ascii?Q?kqrQn9nhNEJMbJcZMYf13NyV9xDey+g0yvS+GLVmSl/6x8fO1eywcXhe9bKc?=
 =?us-ascii?Q?s5+14M5wXFPIPrFVR6q9JhT5fcxkmshjdC/Ot0XmpfnBkXsHFO47yYeKgi05?=
 =?us-ascii?Q?03gGJeWl8RYjWJTTa/JSeuVWb2TM2LV3G/aBmV0Obop/N5hZ5Y0GPBYgoehy?=
 =?us-ascii?Q?K4/ADHyXELoC/POPmRLkKkDNK+Fb/X33lVizRbKquzktZI3NKAxEQJT6TO5q?=
 =?us-ascii?Q?fgPzOLMC6sMOPb6CXgF/W0sKal658YxQ1MnLGWV8FE9y0moH8vCkf3V85g+5?=
 =?us-ascii?Q?2WXVCWQx4lcWF1vTpTPiq83VpP2vz6/PxaYz4R9/M+sxchyCyhkAQ65JvZpo?=
 =?us-ascii?Q?Vx51d86IAwmwGFUx8C96DX/9NqbkM5PcTwfuxiCce5m7Q+PYVqZL50dx+Orq?=
 =?us-ascii?Q?fcuyqR2V9O9qGGYlkHLLA9rE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecbb1c0-5d42-4859-2e23-08d92cfb3693
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:06:11.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knrOoacp70SIvNdVII3uV3mxcpMfQ9icECGsOyWalMHb/mA4xk1pjIgAFiSo2xol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 09, 2021 at 06:46:34PM -0400, Tony Krowiak wrote:
> The function pointer to the interception handler for the PQAP instruction
> can get changed during the interception process. Let's add a
> semaphore to struct kvm_s390_crypto to control read/write access to the
> function pointer contained therein.
> 
> The semaphore must be locked for write access by the vfio_ap device driver
> when notified that the KVM pointer has been set or cleared. It must be
> locked for read access by the interception framework when the PQAP
> instruction is intercepted.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h      |  6 +++---
>  arch/s390/kvm/kvm-s390.c              |  1 +
>  arch/s390/kvm/priv.c                  |  6 +++---
>  drivers/s390/crypto/vfio_ap_ops.c     | 14 ++++++++++----
>  drivers/s390/crypto/vfio_ap_private.h |  2 +-
>  5 files changed, 18 insertions(+), 11 deletions(-)

This is alot better than the try_module_get!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
