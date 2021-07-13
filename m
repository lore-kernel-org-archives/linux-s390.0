Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A822AC07E95
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF37610C7
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhGMTYd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:24:33 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:65082
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234548AbhGMTYc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Jul 2021 15:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guI7xfJB6ecWf4Y/20cI24ThTy5EZ/a5mhQSQU6iDH0JYYhtoD1gJDF3DIr9LnyZtM4uj+6/vTYdGv9AobIVepk9xxsGMxnw18eXs3M8jH88bbaLBiQFrII/9UFdJPdwndRm8gY+lwteA0AaHqUELo2oAsM0fsGb006vsPvc4bJHCy2dwzKatr7fuB/dPDExfuArQp8QVMLadjU1Kg7cHhAqF+vup1lxmfCTKSV/j4T/KGfrelOGtBtepE+M16A4r/1jMWcpTNwv+IEb/pIbCiMmjGAkDlzIDO1pG7iT/LAupOvvHg3a313CUl/SYHHTetC7/uQWvNboPbMf3B/saQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdvFg9OWDGGxL3jEV4NCpHhUgQUMTm4Xi/qg3Ke28ew=;
 b=evX7/lD2zXNQBV5zhkimeaUjavw/hab2Gk0WJdAp+G7MTBOo4otxQbad5tLT4KR4HY4lVB+He6NqBF86M3OEpTIkXB68jZiTXD/t3ixby740u0JYpIWu/7yS4k4RC/Sn4dxE9HMPq3nqS6ZbEpKHvinXW8K4c5QDFjnWSMCxfeIC4mjCWGAm3scjsje8KzzfcLtQ3QkjMnALMmsFryj3Wn2lJWJMw1Ku9uyhbpbIgqlOU9/Jtgw09RvMPZPHHkUBsjCrtkCWR+PP450k9ya/rxO1nYGry5hFnMKt+15O+b7wdTUxCL869Ub0kavDswKvB4TBWWatYqw9vqgwohrgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdvFg9OWDGGxL3jEV4NCpHhUgQUMTm4Xi/qg3Ke28ew=;
 b=mh26R1e9h4xIkpkeIL260WOUb04Agx1kwi8jWXaOme0n8xpmwf5jnJ0udFXrpvtmJUc6dpPp2PpXIhJDO9BoY2MR95F+rMrmbfBPs5Ipja/nCLBVJ7c73cT92kID49MUWnV8JMC14xtsKB7sn0buFNS7HD4n522XgHKwGDP10Qv07ZJojU1KjBgHfAdmgVzPUY+VbfnOc25Xs1Q4hrTqVilpYMmgrd6O1cDKmBNuR5Ck65M0pL4AKpULZ1OWQkoXU5/uTRpisCfz0RqlHUtDGjpZ8KHw8vYanw+0ciLJkoEofp1h1pOcNnyQ+exJb1Mt9kvysJrcddInOzB2tIRynw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Tue, 13 Jul
 2021 19:21:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.021; Tue, 13 Jul 2021
 19:21:40 +0000
Date:   Tue, 13 Jul 2021 16:21:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210713192138.GG136586@nvidia.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
 <20210713170533.GF136586@nvidia.com>
 <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 13 Jul 2021 19:21:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m3NyM-0020Xr-To; Tue, 13 Jul 2021 16:21:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d0195d-7571-4bdb-1d7b-08d94633710d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53204D7F2DD15E942B99976DC2149@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jL8XYz8TrhonzLkRjcztPkGBXVI/3daERyaJ7N66qL/NK+s+hRuFne1mazNtr0GG3EgCSui1nvF1thL34VrudsIHCIGGqcNDGWMdoeeDLCkL5iQwGaZJhJqGrdTxPvxUM5kNqrLGPmTU7ZmAcsKaXvLBAB/Q5/gsQNe3CVeNwtMvCN1V1x/zK6njmx6zpEoaco+/dReypgMawPktTM4wQNWQc7aHlcgOZrHPqui34stR3M+U2HOKQHqagP6nUXnGGrxD0pEh5dPjU9C9EC6Xlm9OD1Lv1vxGRMaYAARlKzpR5S9Z2GVhTlTf6c108eNnTjh3B6RyQDFMlVSZxd2n2r8XdehQX2Iuzj9z3LoAxdTfnZd5SDvJLmGInFDF90XNEykpQm+YssblN46plTABPyhiR1h/7b5neuE5DlD4B0tjKWNp+6qdZhHy1SuH3WTi8ESUPfQZlXs+mBXW8ccdeWGHU16oz61f1uSYfNLvjhvjSji0BrpO1u88Fzd4It7B0T0oLEH2go2LWspPfPxQNtAIXn9PZJ/yt9u8Ijq0hcNcXvc4V7DyI3ynAlqzHhAnoBvUvfXjSxC2/N5o9ijbripS7bOoqddpJ4qTuCNx9USwyGEkrjzxjpclLz3gr0qsfp5+3lXueY7I7g8tbzHpy323m64DrhpVVk4bgVffyVqVyRDlhgqRxIKh8tp5pCh+XcjcvSsbnPx/nO4bLzU9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(8936002)(4326008)(478600001)(66946007)(8676002)(316002)(5660300002)(6916009)(1076003)(38100700002)(186003)(426003)(9786002)(7416002)(2906002)(9746002)(66476007)(2616005)(66556008)(36756003)(33656002)(83380400001)(86362001)(53546011)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u7LTsknR23u4ZIbTow1wkaOu4rdHbfMs9rfu1d3TogVy7xPeVamSPNSSsYBn?=
 =?us-ascii?Q?7kSXxPp4HZiFUIJNQpi9QRLXwGJo95oZazhFGTByCjOpCiPsKeNfGtnoEBJk?=
 =?us-ascii?Q?lZBX5QtsPpOavQh6ZT4cWLS4zU3Jbsnq9jBDwsdmvd+WatbAUCc0A8ktMw4c?=
 =?us-ascii?Q?8T1U5iIRUrYxBhJgzm+zHUFzqulMKM7v5gBBZefot0MXs/uwmjrjrDPmIYSw?=
 =?us-ascii?Q?I766KTRsUgRcpm4vXqpXE3yfmKG4Q66c5ZJ/pug+MchuirzRU2EEz4hJjvdm?=
 =?us-ascii?Q?UAbw8MlQuu8Rwyb90bUCFbAtoM5MwkRFVte0AwUDxwHeJnHKGE0Tk+TXoNBx?=
 =?us-ascii?Q?7Rll9wjeQgnFLrBrAKXLQ7ri6WIJK/qVyPwwA+jaJP2xhSiKXiWF1z0Z16op?=
 =?us-ascii?Q?TgDppcY4p93QsuEI0Abqn6ei3BCiw8D4vojeyzkx/Oc3mI2vKUc8ZrOdpp4K?=
 =?us-ascii?Q?vOnaFMMnvCoIHlEAqKzRUcu8GitojqiGDS0VnyX50sbXJjMGHEThLE7sherk?=
 =?us-ascii?Q?n5MpID2W3/kao0NI7TtEgGaur5gxYhZxDvz5340bgVPd9vjApnhXmkX9fitq?=
 =?us-ascii?Q?/SabpOYsCw86yqEQ2+2hSHIf1rioy6lwixGm7xz6KHvzEMBvX2BSkcoq2hsG?=
 =?us-ascii?Q?nA5mWJVbbGUMtZ8f2mWXB/EWPP9Td7DatU4MndVw6auDPShJHpfz/Y0vFcEi?=
 =?us-ascii?Q?XbQI1z6W+3PclxbxE0S9Fmgu7MuPLWCx6RFzAHyCOWACj0cAkm3LwwEDUb4W?=
 =?us-ascii?Q?qIFg8TpodF7Z1oDDMynvd+7ZW6PirTpSf/DlvgtTcfdIYWLwSDH7HIwTRXyB?=
 =?us-ascii?Q?M0Wn85Yrctl4vQb2SxRiglHV/aSmZ/5NS2zWoqXshW6PHotRwiA6vrY9TobK?=
 =?us-ascii?Q?Kfg3aV7MYWQ1ReQJOSzWRgJPlxKeBD5xLL4NeFdHuTeN99lWqlrEJNjZxkw5?=
 =?us-ascii?Q?fjH6OxymuM0TAa8+fbxIwPeIt72l/4GhxHacBS4VdgFLfvy+MAV6OkJv7p81?=
 =?us-ascii?Q?+bkL42d++ZDlbvlvIo4gpOSQoWgIhLlIGGBCe1ooWNzb2jQ5BwfzYHkprWlb?=
 =?us-ascii?Q?wZIxj2FzUddbLoGI+KQzKGLUqvx8X9DMKD1GA9jVd51ui8+p+7Xv0+00e7z2?=
 =?us-ascii?Q?Nwxg8I9RULKhqp8ICoVsCMJ/iGsddJ7TFsNPsvtQnTAcTBvLFLm1Dj5IT6Uo?=
 =?us-ascii?Q?07uSaCEmYOXoUGRRJ4PxqWuUrKW/xERNy4M61nznZB1SJytjE9hcU+nltrUw?=
 =?us-ascii?Q?gcWlt6STytPRXg/MbeWDUJIjoJaC6A8pA0ha293nbwEr4gX9W2QPWRbIcykw?=
 =?us-ascii?Q?HZeT9tXVm1iYbh+ZPgSOeq1U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d0195d-7571-4bdb-1d7b-08d94633710d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 19:21:40.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUM3Vzc7FQcY+XdybWHofXUsrq4IxvZ1C5FZWrIj7nVP/nIfVc0BvlskdqjEQR8u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 13, 2021 at 03:04:28PM -0400, Tony Krowiak wrote:
> 
> 
> On 7/13/21 1:05 PM, Jason Gunthorpe wrote:
> > On Tue, Jul 13, 2021 at 06:45:17PM +0200, Halil Pasic wrote:
> > 
> > > Jason may give it another try to convince us that 0cc00c8d4050 only
> > > silenced lockdep, but vfio_ap remained prone to deadlocks. To my best
> > > knowledge using condition variable and a mutex is one of the well known
> > > ways to implement an rwlock.
> > The well known pattern is to use a rwsem.
> > 
> > This:
> >          wait_event_cmd(matrix_mdev->wait_for_kvm,
> >                         !matrix_mdev->kvm_busy,
> >                         mutex_unlock(&matrix_dev->lock),
> >                         mutex_lock(&matrix_dev->lock));
> > 
> > 
> > Is not really a rwsem, and is invsible to lockdep.
> 
> The lockdep splat was due to holding the matrix_dev->lock
> mutex while the kvm->lock was taken to plug the AP devices
> into the guest. The same problem would occur whether an
> rwsem or the mutex was used.

See, everytime you say 'the same problem would occur with a rwsem' you
don't get to go on and say everthing is fine if we open code a rwsem
as kvm_busy

This patch shows it works as a rwsem - look at what had to be changed
to make it so and you will find some clue to where the problems are in
kvm_busy version.

In any event, I don't care anymore - please just get this merged, to
AlexW's tree so I don't have conflicts with the rest of the ap changes
for VFIO I've got queued up.

Jason
