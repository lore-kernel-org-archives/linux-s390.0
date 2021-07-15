Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B3C07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7FE61360
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhGOPAT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:00:19 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:51264
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237992AbhGOPAS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 11:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EACDTVZPaEVlQs+27gljJ7OtGszNv/4fOY+UK7GGienLssecTad1jY2y6iA8DshuS9dtRNnimhn7DfZTMbOTD7vn6S4IFkFJOVivvxtjpEdUJIvtW/AzYJH7EVe9fRFfgx6cBEZFxn3xJUdAHw4PUF5aLheMCXGjMbCW94/sf/C8Bkx2adoaQqU0JIxFMzw7T/t9KJGD8hD8R9XkF9yCzutmoO4Ox/Hp8/Y2eJ0vQ/6AUs0EG1MgQ3002kUG2SBCRdnqLVlAT4AysNxqnegXfg8tHZCZqujbQY7G8gT6ITubsxQ8REZVLY+RMC2OL0mqbUIBDB0SF0WwKdq/mm33fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89pYmtz38sLlvGdwL4oLNmPNHQ/3waru+czYwGXmLfA=;
 b=K5e5j8HAWcX25zV/a/5EPR53f9/cB3urxDDPMkBuvESU9YJLCv7wO7cWhHLi2qSs9LCxQfZiqujwkDDvOkcHbS3rpQZiqADvVeC/NLn2GAZ7dJ2seVfWtFdvZpoXfgAWXurEzlzUYdWS26CdrbUamIjrNrWx/dF00H00fN1njk1drJns9TRXCZ3tQAfilZUKJT+8kMV6tE1YdhNY3MsNoyAPO49o4tmrr1oJaOMVR+d1pCCWzmq5ZJODDCEYhx4LeFmnMKif5qUqKVAdO/D9GWGyCbTvMQqe1QbN+TpzfsPh0OH5qvDtjEhePvf8uMUs2OUK8ZTqSjnuVEOlffex+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89pYmtz38sLlvGdwL4oLNmPNHQ/3waru+czYwGXmLfA=;
 b=LZiVR8tszGCSVmZvGdE7am2UxyC9/HfUm5fFERJ7+rB5HgE9pWkMUcTer1cNgZnhC68modCPCUWY23cedLLhouh8lAK76xLmmM/pwf1WBJgfv4vojEHAz3sgJQsEPmIJtP63zrYde6pCe95BeKqUQHwtSMimbww3OTgGhvqz+IXsWG32FDuvQnWHbccMgz5epJB7dkXrWPBMkEaMBS5pYf9eM7Gk6Oq86rSJYmhtF7sjZMEJP2AnA8s4DGtfkv+Fhe5qf2SR8ZLjCJm3NBR22yw3EguYcldPQDWhc8LMsr+ey7d7Ol91MN83gAMkbx73auWPi6b1PFbnuTtQKRhI3w==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 14:57:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:57:23 +0000
Date:   Thu, 15 Jul 2021 11:57:21 -0300
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
Message-ID: <20210715145721.GE543781@nvidia.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
 <20210713170533.GF136586@nvidia.com>
 <20210715133136.420c40b0.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715133136.420c40b0.pasic@linux.ibm.com>
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 14:57:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m42nh-002gpP-Ig; Thu, 15 Jul 2021 11:57:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3820fff-7be0-467e-4ad3-08d947a0da4b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB525342487004FC6F6DAD9CFDC2129@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omzvHVO7oL4SQ2acgnMbg/QzdpizILE8BZNs3UejeWgwjpPL/yacWYsB7jM9//bs3WpVHm3zJZPaMVFsnd2M3BCMaVR6FSqD+oKkrPfSwYJ72kF1xPuad5JaYPF7o4xiHkaTsShCUAFo56L956hrlMPvGj56U7r0/2KVaxgEUYevNuv42UX/KjKldnZ6tbSYFVhjHkH3+LVXtHix3qMIPSgRRc+CyT+hBCxkm0/kA9FR8B26zEZ4mz7RcCMLa1X41tNKoRgS5rjSVu4RS0pS7dTbQmYHQjXWeqQc0M5dcRgiMNhe5xaRCg75F/aW24R3/fTNDikNG++ATyHAucG2Cj0N0hKMvflG4qdPu+h1HsZcJYgbdt8Ja9HQocZtRTKp6pV0MSq7vSGLq2zBLbxmxCZJdI+yjEt1z4SPOZW5PGyKTjhQlB4FpCSkypskOCWyoEgU09VNxMXiQ0IqvjFbOVd/cySzvH0Jnc3st2YV29z4i40KGs6RCGRdPACO2OOkf/o6yoanymTbUN+dd/wp/lknfrpnsoZbD9Qy1vd714OzPFT3N/eu3HvQzNlg8Z/DxJc5fyiMWsPCFP+EeQBUT6dfJWWg4YE+X4pWI0519HzazQ0ss0RIzNo+nj7nKCdA1LxxAFH59k1HrPsGgmEEUslmIGYwRCGZRJH+xQplhZ5ZQpNe4wOV6gqLjFPE9KAp8Mu9Q2ZTppOWdwiWvnHJig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(26005)(8936002)(8676002)(9746002)(33656002)(9786002)(66476007)(83380400001)(66556008)(186003)(66946007)(86362001)(316002)(4744005)(2616005)(478600001)(1076003)(6916009)(7416002)(426003)(5660300002)(2906002)(36756003)(38100700002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skYLw256oSGI+AdhjPQgjASlpxqvGOtKW/6afidjw5i9oHk02q8WKNs1vyG3?=
 =?us-ascii?Q?zrbzOIU6QK3Scq0xNnZcert3LeWHW8wgiEGS0FayXSMy9SMKccBTlPrHoRnE?=
 =?us-ascii?Q?hGmwkNyZFI/4QdPsmxsuJJMM9zw5YZetDbDfL3+G4/4F6bxgISn3dFFOzmJQ?=
 =?us-ascii?Q?ZUR+1ceLPt0PlbUhPBQeCi7gwcLO/QppZGg7ONS8sJBVH/82+HKkwxhlltmL?=
 =?us-ascii?Q?msynL2985iZkVFhowi2gBdG9a/fcaErKz6mLeq0iUVFvOjL0oCoQ5N+inOi/?=
 =?us-ascii?Q?SbK/vCtdK4pcN+7w3BnnfKgEpe5mqeXmuQGKhjn32wjjqMhpXzfzDXBajkqN?=
 =?us-ascii?Q?mq6aN7Z6oG40prJLm7Cwdn/jH4i3SngOI3+R8moFeSPIQ5k66Gucqhs37jXr?=
 =?us-ascii?Q?lhUB4+Vt99qNyQ9zy2E7FKaa8hLgtqHFVw2YN+Bpcel4ExnQKhTNVGbbkvA3?=
 =?us-ascii?Q?pXjQOkUzz/0w8IuJLS0lTC27xyl6b9WEK0tHBIcujzwTgEnvZnDrJQ4pbBWW?=
 =?us-ascii?Q?camEAwwxvhN2Abz7VZW7qgOgiU23jMRU4GVSJG3OoYtX5q+3J8Wz66yWv4np?=
 =?us-ascii?Q?HmUnsscm2HWWMbbMdHT1PbJEAdOUSw8pYuIa0WkLEBmZzJjzX2FJxMGMRKWq?=
 =?us-ascii?Q?gPPzgaVMc9Ed3nq+ZNLdkRAkCiwccHYZrJ+Nphkv+YccMuRlgC4d9WY2hpq/?=
 =?us-ascii?Q?ASVXPGrP9HL1iwuKpv9NKZgoAEcwq9MuhEjQG6ORhnVV/w7tkuOT50az2bmW?=
 =?us-ascii?Q?dlP/Ho4FJObLM6dbcsDjKLtzoMLsoNPeGoTGP0MiJzJGQWtG4ayTEk8H41Ug?=
 =?us-ascii?Q?moB7ALOUaZMpHvjNx4FFptgr8XX5MZkui1z+9s7iF0BvwcR4QNwCuoEvofIr?=
 =?us-ascii?Q?4Y4j3ADQSgl+Xzs1uc/0gLbVpxMcae6JQ4Bjh9oyzuqDc9Y9NoyBsadRmk+N?=
 =?us-ascii?Q?Teg5NYCzGSZ2da0U3JJFe0aN05gTu8LcvKdWGFBvdTlY99ZXFaLMsolVuBCo?=
 =?us-ascii?Q?Api5sXGkzJGwHSa+GG40hlOQOg22HR5I+ynbKDh+Kb0gRjd1IDEQU1OvaEF6?=
 =?us-ascii?Q?ebZ/xJE5/6WDhlRhBmX+7jOueVjGz+waYn52cU2BxVvBk5+AT33Gmbq7QbkX?=
 =?us-ascii?Q?+xBNgOYNUKe5c3L2ZqpxBfBIRjEUrJZr14FBe7CAuFwplsM4MQBBqr0fjydN?=
 =?us-ascii?Q?89E4BUQ3Ya0FC44l1Bl7k2slyaGckJbkdeGNgPd4brUW+gT31qh3KKZXmmZW?=
 =?us-ascii?Q?RyB4HdoU/YIk2de6XHMyZsbpAxJblFf+SWp9BxOI/bK2pzY19iVdif9gR8Ya?=
 =?us-ascii?Q?FjUpmBcOK5RSjMuLgGrQya8H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3820fff-7be0-467e-4ad3-08d947a0da4b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:57:23.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmWu8bosZLGDXDrA+FPnhTOtlRqw4p5Fx1wuq6ZeMKAjFOQjXP3nX190ADjLKXD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 15, 2021 at 01:31:36PM +0200, Halil Pasic wrote:

> I'm in favor of rewriting this to use rw_semaphore. I'm not in favor
> of proclaiming this a fix for stable, because for that you first have
> to prove that you fix a real problem.

So Tony keeps saying that a rwsem couldn't work for what kvm_busy
does, so it should be trivial enough to put in the rwsem and capture
the lockdep spew.
 
> I hope we are on the same page.

Sure

Jason
