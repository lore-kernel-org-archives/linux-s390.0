Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17D8C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1F660200
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 12:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhETM3F (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 20 May 2021 08:29:05 -0400
Received: from mail-dm3nam07on2079.outbound.protection.outlook.com ([40.107.95.79]:9921
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233879AbhETM1x (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 May 2021 08:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfRQL5WknX6TOqsqxpGZAkaZlC+BNBF0DtntyN2QKQ0RHHHvYR0dTZCRa4A1T62Q2ytm3fPiHpOIohVqVj+bY75HiRR/DSB8yzkaI1QoSxywU5my4MYwZldN+ZLqPsv4fvkYUh71AozHSAk8WfID1zpoVCzl0TSmLckLpXV9IOkiDdTtPvctlSTk0XmBGr9DMhGrykwS0VnSpmS9fm3UJiSMwf8mzq3qTaYsF3Ae+DjH32DJSWV5p5vfH2mI33yQH0NsUtJxT4u3Of7Pd06xjU14nLCcIHI2UPg1DIJ+5xSYh9FJ3nldxFYJu/XdfdJV4mQDOGj8/DaCiveZ6faTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQLGw+HoHm9byA0QymRKzwIvfuy00T6XNOWNlF/pd6c=;
 b=YWrs2FcHvD32Kx2pac9dd4qVDtYjHK90GyOAcvJP7MHm4WG0YVkisnImbBBJzuSaUA0X73j45/3X3RwWeq43G9hsKGDx5uQUailQQYIUrtjtWviokeqMx64AWH9UjZoezlUNm+6nXAdvnUMY3JG8kLZs4UrJldW2Pvs30rydF0FdtfnKP/KRJEynNjWsD7UJ9z0KiaS1SkQdyS3cD7/bjshRQFdc6gaEGjQb6fkFWhhBiGCKwZ15KdOAwvOZDRh8B+BevX1pALR1RenRYwlYXSmea+ynuiC4/TIIBSzfs9IN33njk1edj94hKHCbvZiXjaMFqlY+t6Z6IgMILi5MFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQLGw+HoHm9byA0QymRKzwIvfuy00T6XNOWNlF/pd6c=;
 b=pmSILQSwObAJclst9i7FUqHELiDWxVkzslrxWWpVWcOvjTQyDM+IkD+ATaSG6MzVhDgp6KtqJUSWZ1yJhZjnBdRTzaO/8U+zrE3oz890xVzpXYrZwB002NbL/3zi/ax3zCHbXWcrsYEVYJHqXK2mCG+jQKszcO822EH8h4MlN/qotBvR0m91psDZJ6ZL+d/ndNxQ8Vf4hBZEXSyx5UYtKCOVcW21N79qCrIvSIqk1vLyItupaxUiLOks8zOcaKCbw531STJDOkktPAhLXrKkOpK+wsVI+qPQTYIvcxDn64J+QULqkLdtIKkEmnbM9y1cH8WO2Oy9eLc42Q0b2dTH0A==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 12:26:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 12:26:28 +0000
Date:   Thu, 20 May 2021 09:26:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210520122626.GW1002214@nvidia.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
 <20210519161610.GO1002214@nvidia.com>
 <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
 <20210519232202.GV1002214@nvidia.com>
 <330f099c-3d5e-c552-3047-4b462b1c9fa9@linux.ibm.com>
 <20210520104857.65d75858.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520104857.65d75858.pasic@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:208:329::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Thu, 20 May 2021 12:26:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljhkw-00B8Tk-BC; Thu, 20 May 2021 09:26:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1732564b-5ce9-4da9-ac1c-08d91b8a7dbd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594C0E47A9C28F829D1558CC22A9@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHN1OfNKhgX+GHYS5KzCBrrfNEFYPI+d36C1/9KWAGCqj8Lot2xVzYr8KZ+8uHDDiNcwDkDxuUKrhAEpV9ndAetHntBSX5TnHA3Y7HBkHBz3hn3OOdaCPxNMfbU4MKZhUregjEwWQMbK5WPWZgt/aHU3hZqYGcef72+TUs7Q7mvCp2Njm8HF2H8sMcW6cTEhOWK6FwvtY3kO1B3DAw8MiYGRtVMAEbQlx1zPamCd0f7DVyisqKvyQzhm7niX8Xk9f1ivl6t+H5VfR4a1s7tVqgwrzqvNt0cD7ygVpHqmlLOeQzlJs/m//hsPfTDQaQYV1dP5YY6HHHHtLjT+JbE/OkfwytFonKzlV4ucBJF7q+uSyukllCe6Qy5/ou8lnGg0Ub3q3aEflCi3bDydJBgoI+YgcWlQckRe6rk6BroOuFN1N3DFSa/cL0qhAYriH61sAZqICA3UpC6UZgLKZp5YxBrUNHr0b/aZgV0/2Pn79fX4KoPJfS5SqK5mr7eN8o60AUiHBEdKTx0HC1rcL/zjo3c9uvRPbuHwxoZb2an66NKj5UZIsTbMIZEISlStbWU3xQj5llCJJznPgna/NiPu9NfsmYV1yIxnok5/6HSMU7rBaBxXvhzgyMSivGP6UyNzGBakSa7wGVh7zv9g0RFEmWc2B9U4Sk6WV/b5BTHuX1bQxGg6jJQZYYpsFcNaAYyg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(426003)(478600001)(1076003)(8936002)(4326008)(2616005)(2906002)(316002)(8676002)(5660300002)(9786002)(66556008)(6916009)(9746002)(966005)(66946007)(66476007)(107886003)(36756003)(38100700002)(83380400001)(86362001)(26005)(33656002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YplZuB8KEWwDlsJSFjgJpacbbT8EhgFyV9VUzxY+HzCjWbu7XUffTp6X52Xi?=
 =?us-ascii?Q?LwJBH7V1YIDMoEdgcvlgovmcPn1cfmMn7HlmF/nLM6mj3XcfXSc+CjlCD+oH?=
 =?us-ascii?Q?kyDzT3N3qQW+8NIHWqazUxKE1TA7YvhsgT0SAn6fJ6fgzmWumTRRrxmYdFqk?=
 =?us-ascii?Q?1pKb02l86alGCsfHQSTnqdzJM+h6J5TqbY7qRsc08nNbUTH1TfPNrEip4ydH?=
 =?us-ascii?Q?z+A3qaD12F7Q6G6og941WCCGa7pqd6G+9+ceUmxHMbiZ2XkuFmzzAIbzJgSp?=
 =?us-ascii?Q?in0cYNOGrrriq50c+hWVPrBAifa/Xqfn31Seyk+33ZQspqKa07eQUZL0ejva?=
 =?us-ascii?Q?5dcH6B2EYbSpaUxDn5cg1KRy8XND+5WAX+6p53fIg9PfeNBar0nLvYEeJlsj?=
 =?us-ascii?Q?4dKiGmRsG2LhU2rKEu/UnvsNDmXSIQXiPNeJ6O1phQex3K4/agGmz/Vb5DrB?=
 =?us-ascii?Q?7ge2a3D6rMCEtyx+Qrbw9JnS55BIbTHUnyeeE68VIlCImkrD0LBTAvxQn6pD?=
 =?us-ascii?Q?UR3C4klouQkCV83e4OlkKbUyiNCOg8CCqQvL/oaagC5bVLT1nUGCLGqm3hPN?=
 =?us-ascii?Q?taTOgfyktbpPftqTvwOnyjTVTCBVtH8mv7JlzxK8LPjyC+YdQkI95HptICbg?=
 =?us-ascii?Q?os4EBYZFVLvno9qyDV8W5JueufJ2Sx255B7zWYW2vEAu+RxeWpa7d5zvyVjl?=
 =?us-ascii?Q?HIr+oTWJCLjD+7EPQFYDz0Q4MXraAzW3RluTpCrUzyfiKcKUNavCrNj+PtFw?=
 =?us-ascii?Q?9ARCsrO9TkmU9ffTHJ6AjOpBz9kegdt5/giELTAqwf52mpBThls9i3XzeEUQ?=
 =?us-ascii?Q?M5d5eVu9a5iFvOn4L+pZ8X9zQ3NwuHwDmhBMVUXcEQ8mUo7QiTHWYSt1cdSE?=
 =?us-ascii?Q?YSniYQpUG4/d8zTiHL1whkBr+hxcJlHro1cZ8uRXBcawkoNdrsi6MYWzIiha?=
 =?us-ascii?Q?icK1OxV48LEta1xk/LKqdJV7kGsoyrgQOVZSms6lInN+hN0/L9s27b33ulJJ?=
 =?us-ascii?Q?R+wGplk67GBhwbO9w7dBdwK5THXPUK1DflpLXG4plsbEtzKTTJQbeStFd33r?=
 =?us-ascii?Q?Dx+zocosFDPSEXHadvNslEf72CbfJER0gJIX/lA/oJgoLAHRIvXOj46/CEav?=
 =?us-ascii?Q?1RapYr5ChdpcA5aKUT/Ttmz35b7iCUzhmWE41a4Lr2bO2Te6NvH2YWxVt0S6?=
 =?us-ascii?Q?/FRBHfAkAoRyfzts7qXUbyhqnShzdIM+ToRmzs57xn/0IV38YVmCKaXA1o6O?=
 =?us-ascii?Q?fLXtCjy+AlF3fV523t1KoGULDfBksvZK948l0UBqsydhLoYIgVWjA4Caddby?=
 =?us-ascii?Q?5VutjzWqKspD7AzrtcXu81Ji?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1732564b-5ce9-4da9-ac1c-08d91b8a7dbd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 12:26:28.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gcQJ4vMauvyXbadZKi8AkKK2CGjh44wB59LXsKu7st9fgZFQBLolRhBOOwNrYAx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 20, 2021 at 10:48:57AM +0200, Halil Pasic wrote:
> On Wed, 19 May 2021 21:08:15 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
> > >
> > > This is nonesense too:
> > >
> > > 	if (vcpu->kvm->arch.crypto.pqap_hook) {
> > > 		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> > > 			return -EOPNOTSUPP;
> > > 		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> > >
> > > It should have a lock around it of some kind, not a
> > > try_module_get. module_get is not la lock.  
> > 
> > As I said earlier, I don't know why the author did this. 
> 
> Please have a look at these links from the archive to get some
> perspective:
> https://lkml.org/lkml/2020/12/4/994
> https://lkml.org/lkml/2020/12/3/987
> https://www.lkml.org/lkml/2019/3/1/260
> 
> We can ask the original author, but I don't think we have to. BTW the
> patch that introduced it has your r-b.
> 
> > My best guess
> > is that he wanted to ensure that the module was still loaded; otherwise,
> > the data structures contained therein - for example, the pqap_hook
> > and matrix_mdev that contains it - would be gonzo.
> 
> More precisely prevent the module from unloading while we execute code
> from it. As I've pointed out in a previous email the module may be gone
> by the time we call try_module_get().

No, this is a common misconception.

The module_get prevents the module from even being attempted to be
unloaded. Code should acquire this if it has done something that would
cause a module remove function hang indefinitely, such as a design
that waits for a user FD to close.

This provides a good user experience but should generally not be
required for correctness.

All code passing function pointers across subsystems should always
fully fence those function pointers during removal. This means it
interacts with some kind of locking that guarentees nothing is
currently calling, or ever will call again, those function pointers.

This is not just to protect the function pointer code itself, but the
lock should also protect the data access that function pointer almost
always invokes. This is the bug here, ap is accessing the matrix_dev
data from a function pointer without any locking or serialization
against kfree(matrix_dev). Fencing to guarentee the hook isn't and
won't run also serves as a strong enough serialization to allow the
kfree().

The basic logic is that a module removal cannot complete until all
its function pointers have been removed from everywhere and all the
locking that protect those removals are satisified.

Jason
