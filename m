Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D042AC49361
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A417F61351
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 15:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhFRPCQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:02:16 -0400
Received: from mail-bn8nam08on2056.outbound.protection.outlook.com ([40.107.100.56]:44385
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234183AbhFRPCP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 11:02:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6Q45rts9G530eCrjMWxcJaHUWMd5oNgSlVtVBO+JNJaSS7mABh6pp3q3tF+42+1zTbDyK74sI3nodu4bE3fJWaJfVdQN0/j9hXkM5gz2lXUEtkZ/3kzxC87OckH0R9t646sIGnzE5fLRXxtFMYavcUqjXglqMtulqItlEO2NlDKwDN97xrUcP8zgvkWnfTWJt8yzhAtaaV5bLM14iH67ojIzQjK04ckpzlviPWG4DT713iZyJS33+gphfr4tVet46CekOO1zQL4rzlfTAlCBBsKideQ2zlH94qF5gABZpIV48mzFS8JC9LrjpgX2U2ACv/20YrMAI0OXTYMJZ8HZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62IjmDe4wjcin7//5c777r2FRECWE20Ya2cuhRKJplo=;
 b=cxZUaEE3lk4IXyZU3Oe4HYp9iNlmI6+WykLiBRUVsfDT0NoPHPzMKhHOqaoI+4ECVwhso2sMw6QYyIM84rpXLaCsphfgI58wKZufR5v5O8Q2zJHIKbM5CBywnDfrk5OI/4WAVmHXEJAuhlKvbdMCfUKRhlpsiKQDG5s3zwsX6dahZN1NhSjnJ1+aD8mPuNMYnbVD3cagsSeoFys91pyIZ+CU7OfvtgwUYsuy6ktSdVdUZeF7FAA0+uSay2tTUqwkN7KsS5wHOujtB5T1azNmlid3BxxI7BSvBYi71xkEX4qKqHtrlEsG9PCmfz1MqwS88pSjuZFF3ZjYJ0DZ7sH5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62IjmDe4wjcin7//5c777r2FRECWE20Ya2cuhRKJplo=;
 b=g/xfYiQJKaKqpK1mB/PU+VN6jIJf8lzdcpF7/uVMophq9/iltoIh2gxFX62MlOfVZ+/3iOKQwrfDIWBRd+s8iRJSTX02Fy61UlWP8uO/jxa5ey4NKvBpIZ33pXV5Ux9TJ4oA5DS9xk3oPRxhUD2anudW9Q25e6COdUsy0pSWLDai6KO38vesSJH4MiKIHzFsCKwmLO1apa1kJI6hAbB5EkDCyO47hUa2JQcndSlVmVkuKZw1rUKL7w0u1AevxMArp9M9no8uThc904HyTozikGbLrfupASzPSwhjMffZPgX8Hi8ccKF8qSFtQHIDRNn0gzWjrz0zrxI4YzBi3tE8yg==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 15:00:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 15:00:00 +0000
Date:   Fri, 18 Jun 2021 11:59:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Jason J. Herne" <jjherne@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: Fix module unload memory leak of matrix_dev
Message-ID: <20210618145959.GF1002214@nvidia.com>
References: <20210618133524.22386-1-jjherne@linux.ibm.com>
 <20210618141018.GE1002214@nvidia.com>
 <4ea3de71-9d68-59c6-bfb8-d8258019e585@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea3de71-9d68-59c6-bfb8-d8258019e585@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 15:00:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luFyR-008Yg4-T1; Fri, 18 Jun 2021 11:59:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986d1afb-e770-4c93-a886-08d93269beee
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5176BE8A43CF13269EA13A1EC20D9@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZu2FapsMxFvAN1+chBGehSY99AOd+5draGbpuFZQ58+n4Qz9XxJDdgBR9KKiPiZ4AXZwjH2mtQlD84R8Rf9mHYtc5A4XIr0iGwXqzvc5exRT22lDck7ElBNX+k+QclPf5m35xhq9o/ANhLBFazORhucBRD3rUPhgTdinp3dKecA4B0LxhZlX2+3c3Uwm9U6LhULxCz9Yt2rasltcxFWgTu5WeWixZM3yTGbbEj7JWi1C9kzTA1F64MlEwalYvveRzvBiPkEXBoXwyub3lA522mtOn8xryxqNjHPKo1Va8yDEdnyG/AXg1MCfPnzJmtzmPLvkR6SUuFLrP5HQE1J4dFTtzD0q0JsHBJDOarz6e4hLsE1qFUbDntlzNj7BiZ1pz9nY++XvaDTPI6LUjsUm+5tD3oWb6HYXV0y5djDRX4kQrt0zwHnUn91SD2/UBaguB54H0PgMoPJSiITBU76ASGT5ImK35Nl7DfHquC87Ujyamzs8NaqiXOzl4zEBJ468lKG5otRZ+lcFBwO12z7gUaqbPb9K/MxeTq1on8Tjr3qHiIMKMqn7Fl2wdmB/QKZSCgJKQ3uz5atbYCGigQNy1REDfL4Wdy+T4qZnIjYCzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(38100700002)(6916009)(2616005)(426003)(4326008)(9786002)(8676002)(1076003)(8936002)(33656002)(9746002)(478600001)(5660300002)(66476007)(86362001)(316002)(53546011)(36756003)(83380400001)(66556008)(2906002)(186003)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?diBv2I2zpqAaT/ePoKWrcsgx5yY8rRCAkM8Y5Z4FuD2TqXRihekMIjZ3MuVm?=
 =?us-ascii?Q?ZVV0umCXhxtQ0ZHiJtMwub/AWP02Q8geo0hTFm7HZGlaodNTME9yYnyr9mM8?=
 =?us-ascii?Q?q3nIm+hynOo6XtSohCCA/0ywE2m+quoJ3N1KkcI2Hw88g96y7PHO47TmRc8D?=
 =?us-ascii?Q?2w/0XBBOd+n32e01SDtlTVL8IlDVUqyVYIIldXetki0L4cuAt5RZVUOjHfGT?=
 =?us-ascii?Q?JQK7qpNNykfGsp0olq4rGNdyVlrr9WiZYKpWwRA8VWxPtaobSQy0AK/BIu6K?=
 =?us-ascii?Q?CxEiXDvbHzwv1ksZRR7ksQc8IQNidXXHyQv3Ck6qSrX1PFCahpEN6QdnaWYb?=
 =?us-ascii?Q?X47/0zLP04JWERUw6xjeg8jjiR+XTsLZKetYs8qGGUSlVtxfa9FGA0F+phQh?=
 =?us-ascii?Q?66JVG7JafzJyGRVLOSUsokrGMbzCQFU3gac97g89T/g8n8zML3oGwPhmYI/Z?=
 =?us-ascii?Q?Hvv8PmfS6Mds4wYWGQvLCLoIqCPddPm9VK6HeNzlxagKua8ZR7wNkYCFUPFQ?=
 =?us-ascii?Q?LEkzC/aDi6N7VM6F7TxZKwqDUBbynEeQQWed+AXf7kYdO+Y3bX3n3QfEDxWC?=
 =?us-ascii?Q?DIpgLXt1d9fWZ2LSJ1/pvo9ppamsg+Wjb6aKUyO7GT8N1EEf5Ve2GWpMLiL8?=
 =?us-ascii?Q?UTqmPVVv4MGPbuSwZN90Go+ebe9cAQd0EXbWa9t1NOJBjIeil4Rcl9y+Y/DV?=
 =?us-ascii?Q?GgNRdV92AojVLcrZ+mj2x8NVUkq0rAYfPMYbe+pGpGnxHg8ZBA+iWqHKhNZh?=
 =?us-ascii?Q?Rh8Xj4seiGahM7r3WziUJk1reWFb9ariehxfNF3B86HtB+yXey1c7JVsWUpb?=
 =?us-ascii?Q?3wWkLOBt1FwPQ24br/VAsGeEmsU5AsoUimCIlnZnyI/e2BcBX9Nog6dZ7K8S?=
 =?us-ascii?Q?oqQNpmRxGQ5AWdHvpKDv8s11Xsm4GAj+UL2M3yHW02LCao4RPsYyPhYQYsUB?=
 =?us-ascii?Q?FAKk8fQDw/OTKruPxhpNS36iu8nwg/7EKn9fDN5M+XnAnSAH6DHuFhim3L7t?=
 =?us-ascii?Q?lxMmjgYqQ6dhfcnOxdBBuGSQgLUnhOaF+eeSqObNSHqy5G2RZsx84WyhdeuV?=
 =?us-ascii?Q?BXx70COKmlYxIx0gWdEkirfHqCoBkza0YR4ELdfr6eE5J9AbLTnc3PGu4X8c?=
 =?us-ascii?Q?sWU99vVpnjXOVZ1+svtUX08Bnb/Enuro07pRObsScYK6kBxRA+zkUkADdJ/d?=
 =?us-ascii?Q?zqurqmvCRmYtH/niWjEpH4hF9JddfJODCJ9yWUyWWGHZeI3KMMyP7rf9gucL?=
 =?us-ascii?Q?2XbjUoKmv6e4YNXfRv3o4lm38oXrZTXWLG/83nN8VvYt1gphGpghijSpTtJP?=
 =?us-ascii?Q?8UFqd1qe+b/NDmQeBN5N/UCY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986d1afb-e770-4c93-a886-08d93269beee
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 15:00:00.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNKxvRJ+Ay2sUN5SzRsiVEfnnPgoBHkY4HBPBxJw0xyhliv7MzXMctAAC/XqSnoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 18, 2021 at 10:35:21AM -0400, Jason J. Herne wrote:
> On 6/18/21 10:10 AM, Jason Gunthorpe wrote:
> > On Fri, Jun 18, 2021 at 09:35:24AM -0400, Jason J. Herne wrote:
> > > vfio_ap_matrix_dev_release is shadowing the global matrix_dev with driver
> > > data that never gets set. So when release is called we end up not freeing
> > > matrix_dev. The fix is to remove the shadow variable and just free the
> > > global.
> > 
> > I would clarify this commit message to say that the drv_data of the
> > matrix_dev is never set and so dev_get_drvdata() always returns NULL
> > 
> > And I would suggest to use
> > 
> >    container_of(dev, struct ap_matrix_dev, dev)
> > 
> > instead of the global variable, and probably NULL the global
> > too..
> > 
> 
> The use of driver_data seems to have been completely erroneous here. In this
> case the global matrix_dev is the top level struct. It is not contained in
> anything. matrix_dev is created upon module load, and it is freed when the
> module exits.
> 
> So I don't think using container_of makes sense. Unless I've
> misunderstood your suggestion?

	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
	matrix_dev->device.release = vfio_ap_matrix_dev_release;
	ret = device_register(&matrix_dev->device);

"dev" is contained inside matrix_dev which is why we should use
container of to go from a struct device pointer back to the containing
matrix_dev pointer

Jason
