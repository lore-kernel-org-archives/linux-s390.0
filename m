Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1656C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DDA61040
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhHTWbb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:31:31 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:35745
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231274AbhHTWba (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Aug 2021 18:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USHCj+Bi4CVE6fyRmpwtnJ+ck58RbVJt8w/eo+52k2chOe77Cec9pHgloAA5XMpZSJofCtFkZ6N6k9MWPcxDxydaRqemXv35do0iGY29xnuIXiF9pmvh14SF2Tgw/cgMyIJRwZU/DwtaiYySHZxSq3nlbZSCjtAlW9KzzK95Rr8LGf6KbDngUtdSWdxv+JdKB/r6Cn1+6T4JE8r0l6qZYEfpD/w4koeT/xrWdh9h8bPxVS7B5Yq6KHD+NUifwcukbdCxieK5UV48jvt+D4Tr5W20kOTD31Pca5UO+MJZmxmx0DeqDaKEWwTCwaJKvgm4yfilYRhf+LtblHK1Eic2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcxb74VCHGrw9I9O2Fke7DwnF2MioTUTGbr9Xu1InH8=;
 b=eyrpQPtMfPsFSpglllOdu2hSBZ6/iWf2Low8mQ3ngdGRzpTmBAHtaz8qScx0SA/OwhFHQW1x/R7eAq0BeUfmXEO6EgA8GTtzrNilsXWurZk20HpaigAfxDFfHY7NjiF387u3oj0uDZC7fQdnGTcQ/xzCxfJx/npqAY3O97WJDLAYjBqTdhf1F1jyaly+ylz81EoXmeJJ/okY2TvhS3oD5FjBUCe03bgDEt1eHWwC3Hffn+V7b8mdRtukDAKmn/n9zxbMDxBNGT2Pky/rQfK3/+iciseLCKlpyTQcg9szqpBB5gefpyphXMMmVdMYu8TmWwLkVCIE2Ol+cdoFdcwXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcxb74VCHGrw9I9O2Fke7DwnF2MioTUTGbr9Xu1InH8=;
 b=DSGsLSxE0+wxjERIYu+d/yib4BMn9PUCogAEE49ugLtE0Z4tHHClxARRfRktQXNkeU3gQoYF4uNE8Z0NpEcpLk/o19/FReRLbwr84ersU6nsy+Lgght250eErDHwPl7bibEmb6kliu6lPTL+RXHwIXqvY+3TvhTi9NDbvqjoa2e1uSG9C7eAFot3XSUVqX+Dd/zQo1mRJDd8Dsj+54X58QuNVVfgMGGSQ7WubIFWjt5di6RTb6Kj+tgEID13ZdnvTNQ7cmcfPG19zfiqIxr5nI3/Tjw3L4gpkmFabQfI49Y8vIVlcTc5DJ8DShwuRXYj0g0X80Ky7Ajb3wx9dOpBCw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 20 Aug
 2021 22:30:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 22:30:51 +0000
Date:   Fri, 20 Aug 2021 19:30:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
Message-ID: <20210820223049.GJ1721383@nvidia.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
 <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
 <20210819115433.76153ae4.alex.williamson@redhat.com>
 <20210819175807.GC1721383@nvidia.com>
 <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
X-ClientProxiedBy: MN2PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:208:120::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR10CA0021.namprd10.prod.outlook.com (2603:10b6:208:120::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 22:30:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mHD2H-002SJY-VT; Fri, 20 Aug 2021 19:30:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f4d5e4-78c4-4a85-51a1-08d9642a2a62
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52086984CBA79FCB0EABCEEBC2C19@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKkjZnu7JRPOdUNLhRcQRo2vU6/rOCk2d7HGFR8bNJzTJ9R2jEsJlPNMk2VRDmv6ddELpnhlBP+UO8+lmgkDC+bX3ybhFZmdnBp929skW9mM96Wy7YKtLIOXqBbaBIaNLVyYXzOaTTSj705nCL2AGA9NEaZcW1cjAG8XvdnaI7CmxnUFbDNy9VjWKNxwS4jGeXMU5VYGFHAtAqfjtdWk8RwcxWjv1MHRvuNtBU810m1EnB8H+L1vE8LFHaCHdHc7a2RxvEKf7SBvd+6DTQ05Uj7SffZGdM4MtFFEK9xYZ7dFEwRlQRfMCjNETz0WosCwJoXM1jw756pBz5j0j1gM0j3qlmgXdyUw+j08g91pFyXuyJa+bHvFTwk4ifHseK0Rg3IzFUBYq/xPeQphqhIBIuuYKB3sp5pnijTUJYs0A6frKDA0UaTYIj82zZM/kEuKbx7ppuN6rWGQAmEpU+6nPzPjnZGeu15cWQrt24w0JgRWciK/P0fQd5rP5heTl7/aecHaChEBh85MZFwxnnxHeW2f0OToqK+SVu3H9kI6RtUTMoEZu4xlktD84pgC2Aybr6ikH2E7eC2F6azZxKsgOrG3wONma8LH4YcTcMcoEHtIdvzeotVy4Tx4F9rvDwhJHW2v0zikXC9lt5wvTQ7UqFNFjGgdZNlTVyny8MHyymWSc0flPmT0sUE9l3gMp23igsHPcWt8vCq8IetfbDJ3Ux5JsppPULPK4e5EpWr4+B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(966005)(186003)(426003)(478600001)(316002)(26005)(86362001)(66946007)(66556008)(66476007)(36756003)(33656002)(9786002)(9746002)(4744005)(4326008)(5660300002)(2906002)(1076003)(2616005)(8936002)(54906003)(38100700002)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LlaCtCnnmboWDAG0hkdcFhlYbilGpFqrCHCuoqrODYglQMyFCipAGvpU7Dv?=
 =?us-ascii?Q?ZyZRa9X8bA4cRXX19pyien4DQYZg0ZzNOpMN221iDNAfjs941RObAitoivHY?=
 =?us-ascii?Q?9rldQFOXeAwaNTAla/z+xX1sLlxkoY0CnBQknM1yCmrIRJC0jj54Ai2OBukO?=
 =?us-ascii?Q?JgqCMaYhmdIv9HVxGUr7WFKF8xhiwKHhkK13inKCL6wJBjE0ki7vD5jTycNj?=
 =?us-ascii?Q?vSRRcnDHfO3W9rAmKcVzJsOfFCXlyYWHqJA3oza0BzSAtuMqr7wItQK4Dfze?=
 =?us-ascii?Q?1E6WyzaIYnd2Got8hLEg9TP6zcwlDjx3FrYYA/bttP2gkIVQxVAMCnevlfZe?=
 =?us-ascii?Q?uDF/3PI5gOEBM/uLLy4L+CYTZsC2NWfbw5H0Rv0jBMfTBq/TR+HV2cfVQTlO?=
 =?us-ascii?Q?ty9hV+tIxhDH8pev6+1cpdCplVTe89wUUIIxH3085Z5KT/o0SPuHG6GEj9l4?=
 =?us-ascii?Q?fmJjEa7VlEAptrRCMyIBsqP4D4moy1GW+26X1TbAxRTu8RnYZz3C42r+zxeB?=
 =?us-ascii?Q?P94Mm4gRCymJ+z9368eKE1e7RRPcplL9EsNmx4AKtU9I+WZ/mlmzRKO+xAfg?=
 =?us-ascii?Q?f64HsWtQQHUw8Mn4Dn/2VXzbdfvyUZzdtZ0QeGoebzVwx4Nw3cbScN3zdAQb?=
 =?us-ascii?Q?xuGxP9Y2FAa/ubuL+ybqX0kBNkmxlyqZ/KzGHRa7ypXTEkHdSwiNPOI0eaYA?=
 =?us-ascii?Q?+7jjkgvsGoX9DrdvsETo50LGtCjQ/LbhQWnrZAsZjEl63zAHBiabzJiAfbOv?=
 =?us-ascii?Q?j2nOBHJNY7nMSPEzGC5RFObzfZdx8lY/vuN0ZnUWBmbUjm3ec7niFqciY9LG?=
 =?us-ascii?Q?zOrztaPlO4EDsXBmgCy3iYW/JM7SQPbAx8lz1f5bTIMGc/FODOKizJUDvPjK?=
 =?us-ascii?Q?z8HEi5RxIgb+dTeZGw7Pxkl62KRyaoefC6ndymz5TYPNTbKAsCsy7sTpKPdR?=
 =?us-ascii?Q?GX7QY9Lqd+GljAI3VpoZ2VLyEPmMmIgAAN9UYXCXaWiS1ncgUjiU4Bck5SYy?=
 =?us-ascii?Q?Kouo5gcyOfWTl3SflRxJI4XzsTmQh3j2z+o6wGQoZl84BKVIjxEPX2EMfviR?=
 =?us-ascii?Q?4sfc31wgDqiGINaA5oWNmlqQqV2tntaEThlRnupqnr4qLEIWqJDL+nl8oDFw?=
 =?us-ascii?Q?jjxeRrydQh0jMPW2rVI88ZS1oY1d7/pKCmcbp3ej3EJpjNMr342XtQvxA78Y?=
 =?us-ascii?Q?drZ8XKNUcJVphFy3q7dBjwCsyu+rfkRouQxfrhGp6K5mp3D8iKHdiPG0zffE?=
 =?us-ascii?Q?bfymJHa883kZiEqpyPn7Cxck5e28G6nuIhuKnNVMfdA3L42roCg2m56nqGA5?=
 =?us-ascii?Q?uUY1Ze71TSSr3IXo6Nr3X2v5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f4d5e4-78c4-4a85-51a1-08d9642a2a62
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 22:30:51.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRM6Td58mMSKBrZQH7WMe5YHJYjV5lQK0XTKfjNEJwDXoS7PtZCKWZbzWCjMW3A5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 20, 2021 at 06:05:08PM -0400, Tony Krowiak wrote:

> So, the question is, how to I get the linux-vfio-next repo upon which I
> can rebase my patches? I apologize for my ignorance.

Get yourself a kernel git tree somehow, eg by cloning one you already
have

Then something like

$ git fetch https://github.com/awilliam/linux-vfio.git next
$ git reset --hard FETCH_HEAD

Will sort it out, though there are many other varients such as adding
a remote/etc.

When you cloned it from github git checked out the wrong branch for
you - 'git reset --hard origin/next' would fix it too.

Jason
