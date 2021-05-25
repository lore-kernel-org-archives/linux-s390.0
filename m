Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0B0C47084
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19416141B
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhEYNUt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 09:20:49 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:7969
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233127AbhEYNUp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 09:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoOHRmKAgBPIZbpNuNUgxH4omnu36LXbi56l9kxVWSuDLO3iEjRH7PsHBJJcy11y3nFtff2H6er7+/Qhdaxs36tA27qV5F9lIXsjk0uF/kanstGoofpatMLmDKpyZL1CXXE7hbal/swhOmvR+7p09cgverolFp09P2hi6+rveqz3biKCQYowU4/2opEPTLOnVMfCIdbNzYEWhAN/cTmQE+doixun1uv4FScwuf5Lu4xFOj67NXaitd3LlEw42etUWZE5DXUEHRznijM2C8bmc09m1ITNktI/QA22daG4rcPxlb8MGwsXrLF6opEHsCwdxqkdz1ZHEsi0D2MgIkjRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plfOR4CxnYcku36FuFYq4+ioAR7JBEebcrFzCfWtthE=;
 b=dmNNO5wooIMI674l2lNoWJlR0KrB2YrrnQfYgQr4Ad5VG80ypmUiK9GA+v8QHGJg49BPLSfatDAi3SYypnf1VoT0XMPCKvYEtipHOMHlIc+Pw9gLipCSzNlz4HSH1+5DSVX7kkpcjikINtRsM5qr/anet0DAuK6GZanmqZh/hgmlUgitANnnk2K4hO61SDeDJ5Ug7pNUTMmnJVtxyeZRPP3dm2JPWDr3v12ENkij6ts8FDtsbds7yfDl2YwIJ2CInf3L1tdHKItqrrZmwFeUKKe7sHyU8kBKo3ItNPIhBTzhyOQEibTOYQjHj/v9xTjImFIlVZcbmeoAkfMGihKtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plfOR4CxnYcku36FuFYq4+ioAR7JBEebcrFzCfWtthE=;
 b=BvdR8LxINrXp8nvSm259icS8PNkG7SqDghtOy3oQf+5tTaQ9HKKukSEZ0LeC2vjjK31R7UJx7L6oELz9XIFBQIm2LT0GEzI5WIiL2G2OjO/e9o2+fGWIMwFHgGNYLNQGOJFwFD4oQwkx4kyy5vJRoOod6HXDSXkj7OSDAonViXYgoSfO329gLh6XMioSht8lDY8LU6krHDMdm76S1K91jMZq1O1aRDe02cOI6pMuknvePPY2rDBSuriY876y/wokvjFhPQkjTt9JLTIQ3TyqUc49gTtrtOUUt0jm/qBRlyrtYcES03k8EsBa+0l1BqBfbrkJSu3nsQ4pbgZomVB9Cg==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 13:19:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 13:19:14 +0000
Date:   Tue, 25 May 2021 10:19:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210525131912.GW1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:610:50::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:610:50::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 13:19:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llWxk-00ECvA-I5; Tue, 25 May 2021 10:19:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ca0e4a-8074-49f7-6d75-08d91f7fb0e3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5221D8B0EFB88F496D5D825EC2259@BL1PR12MB5221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEN8n34XrVQM0/RsvJBIvthx1JHYjm9kj8at0W984msRVItDNPDVGn4diDfSj0ESa6Lp31eR1vRjjKXfwm30Cs4y0ZkOG+73BAn8jyliaR0aPOU7YlxezCtugf+Zq3Hu/ZZBg+/mBHcqqg9Pt46a6mbaFe0k02NGVCh4q7ojBouxZ8oWz5dTDQPLsb3x++vmAwZJyGofqW+HrdreH4s54UU7oY3HYjUx2Y+TS61lTYOd7MaSHwqnCqwdn/En+jBDUXbtr3MIqbh7AsvBPfzftsmHDyw8K1BAhg30SAjhqkkv1zYanV0RKOaIHsndB6aAzKnuegJsr5bx4+3VvPkzUIAIYh+q3JBKOMaaE7XfXH4aP/gtJVPA0BE4UqyRIUl9nEIq4ouz5Id3ybdv9N3DastzXIllO1XxjbXo4/vD413J0LcfEOVeDU/rpJxKQMCrgl36Tm5wkY4OI5/bELUJkx6xGQqK15n4xjPfhuXAej/gYAWQHOMxRnrA7dRUc946J6B2Cc9NXXlwNgsPikV8dCs8I8+kdbN6FrYiQi0nBZwrdTtqo/ZnMaNUtUAlvRQZqCeYFG7VopdWmWcAtB7XjPYxXvbxE9tbQyT1IzZp0SU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(2906002)(1076003)(8936002)(9786002)(26005)(2616005)(426003)(7416002)(4326008)(9746002)(186003)(5660300002)(53546011)(86362001)(83380400001)(36756003)(66476007)(66946007)(66556008)(33656002)(316002)(8676002)(6916009)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?blZ0V1gyVDNsOHRWN2lCTEpiaWlUMmFLMDE4OHA5MHVGNkpzM3hEK2tBR0lp?=
 =?utf-8?B?MGRvd1lUT3JVZ0N6SzU2V0toOGt4VWtGbnBvVGRod2RPOHFiekJsblpheDVT?=
 =?utf-8?B?SzJhazdCVEZneDhtTEdMai9wZkZuZGVYKzEwRUQ3cVlwYkE2TXEvRklFaTI0?=
 =?utf-8?B?ZTljMUNDVHA4T3ZRWVVZREZmUEpCLzU1L2J5SG4vY1c0ZWlBRjRaa09LY3Iv?=
 =?utf-8?B?Nnd5S3MyNjJHRjVhcGhmblJnZDlxNjk5cVc1ekt4NCtEd2lhQ3hWL1ljQ2Q1?=
 =?utf-8?B?Zm1jcmJLcVQ1S0FsYzJHNFl1aWZjTVE5Z1VSTG5lM0ZsYXl5K2NFTDJwSmgv?=
 =?utf-8?B?WGtmbzd2TitNZEllb3BIOWU2eTdPQ0FBUG4ycFJtTTExWkFyYjYwM2VrdmJ5?=
 =?utf-8?B?MDdTTzhvME5uemRaUm9oRTBvR2puUGJRSG9kYkd2S2JORTB6ZWs1ZTFpWXJ3?=
 =?utf-8?B?aEovcm5paW9MOVhnQmR1R2Q1ekt2YnBBcTg5aHNyb21GZjhkRm5xK0drbkZM?=
 =?utf-8?B?UVdmcnE0czhCZUpNTXVpSmg0bTRhZDB3Z1huRy9sUitzNDRUMXJwVVlHWldG?=
 =?utf-8?B?THg2WVVZQ0dVMTc3QzRHMDBQMGlGSGpveTlndFdWTGxwd1VTdjBBcUJSV1o2?=
 =?utf-8?B?SmdMY2VSUm1WdnVNa2JPWWIxTlVUcTJQeVNPVGtDT0E5aW44Y3RsRDNBS0RC?=
 =?utf-8?B?TVhqMld5eWpxNmRLdzVZbk55SDAzUFBkdkk4ZUJ5WjI1N2hPcGNVeG9ZTUtq?=
 =?utf-8?B?U3ZiRmorWWZKVnJvMmhXU3RQMEFLYWhERXJxa3lRUi9SaEQvK3FQd1IxYUxR?=
 =?utf-8?B?R2w1L1FldEphQzVOWlJNY01NZkdLZllOZWtwQXdTenU2T3Yvdnl1UHZ3TEFM?=
 =?utf-8?B?ZHltNmQ3czNZVFR0Q0lCN2NSWDdQeW0yWWlxTVplaWJIZGJXYURPOWR6Rm8w?=
 =?utf-8?B?L1NqdTFpc3JZWnk0Zlp2MjQxUlZlZVU5YjJqVlZqNm1sMkU2Y0lHMDJDS2ZB?=
 =?utf-8?B?VFppY0d4NUZWQnJTcTJFUkhBdmd5eVBvWko3bHlOWHhURkhhN0xMSFVDRXI0?=
 =?utf-8?B?NDIrZlc1SnZnNFc3WStVUmtKN3hkQzdCTnZMWkx3bC9XVTN2bXJjV3pJbklE?=
 =?utf-8?B?RFVLM2pPM1ZuYTYwWXpnZ3pVVFJ0Vzc5aXZ6V1FFRW14Y0FDWWxuTlh3aExF?=
 =?utf-8?B?S0pzeU5od1VuS1hhNFlFamlnWW5EUUpXUUVQa3dyUEdMSkV3V3JUTERlZFZh?=
 =?utf-8?B?Z3hqVkVJaiszK043UnpqaDgxc0pvczJOZjg4dk82c0VhRUgrT3BKeUd5V3pO?=
 =?utf-8?B?YzZMOGRPMzlJT2JHaDF2R3Ivc2JDcXl0SzhQT0dHK05Fd3hwdHRUVXhxaG01?=
 =?utf-8?B?THYzeU82eWJDOVZ5QVF2SmFlZUpjbU5FQ0NxbWlSdUpIQlhDcC8zL2lHbW4z?=
 =?utf-8?B?SFhlMEpML0N4aDZIMFJlekUydWt3bGx5WldLMU9Ia25VdEtobCtGNURRMG83?=
 =?utf-8?B?ei93NEw4QkdDWjR3Z3dGMlhhcTB3MExqdkNTUkIvdTMxUVV5Uk83M1pqNUFz?=
 =?utf-8?B?MmtoWCtRWTJtbmRiQ050bk9qYkNDSjZRUGlLTGR4VUNlSUYzcWlDWU13N3d2?=
 =?utf-8?B?RUllV2U3UWJqWEhtMmxzMk1mYUtqa3JIc2tNNUFVTllBcVRmN2ZCRzEwcjNR?=
 =?utf-8?B?M0hDOEljMUQ2L3NJb1VobnhURTEySlBpNkhuSDBweUhxK25HMVFnd2RDQXZv?=
 =?utf-8?Q?2AYQbbnCCDISRDkOlaY/U2BOAZo3JGYxkT5Ob8Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ca0e4a-8074-49f7-6d75-08d91f7fb0e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 13:19:13.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mGV9FBCXmiCX7+7D72EreXE704O7qFbr1QqMyglRaPOgt/ViWZZZ/Q4fY6Ullyw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 09:16:30AM -0400, Tony Krowiak wrote:
> 
> 
> On 5/24/21 10:37 AM, Jason J. Herne wrote:
> > On 5/21/21 3:36 PM, Tony Krowiak wrote:
> > > The function pointer to the handler that processes interception of the
> > > PQAP instruction is contained in the mdev. If the mdev is removed and
> > > its storage de-allocated during the processing of the PQAP instruction,
> > > the function pointer could get wiped out before the function is called
> > > because there is currently nothing that controls access to it.
> > > 
> > > This patch introduces two new functions:
> > > * The kvm_arch_crypto_register_hook() function registers a function
> > > pointer
> > >    for processing intercepted crypto instructions.
> > > * The kvm_arch_crypto_register_hook() function un-registers a function
> > >    pointer that was previously registered.
> > 
> > Typo: You meant kvm_arch_crypto_UNregister_hook() in the second bullet.
> > 
> > 
> > Just one overall observation on this one. The whole hook system seems
> > kind of over-engineered if this is our only use for it. It looks like a
> > kvm_s390_crypto_hook is meant to link a specific module with a function
> > pointer. Do we really need this concept?
> > 
> > I think a simpler design could be to just place a mutex and a function
> > pointer in the kvm_s390_crypto struct. Then you can grab the mutex in
> > vfio_ap_ops.c when registering/unregistering. You would also grab the
> > mutex in priv.c when calling the function pointer. What I am suggesting
> > is essentially the exact same scheme you have implemented here, but
> > simpler and with less infrastructure.
> 
> That would be great, however; when I implemented something similar, it
> resulted in a
> lockdep splat between the lock used to protect the hook and the
> matrix_dev->lock used to
> protect updates to matrix_mdev (including the freeing thereof). After
> pulling what little hair
> I have left out, this seemed like a reasonable solution, over-engineered
> though it may be.
> If somebody has a simpler solution, I'm all ears.

Why can't you put the locks in the right order? It looked trivial, I'm confused.

Jason
