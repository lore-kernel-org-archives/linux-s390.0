Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C73C433B4
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 16:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B4661177
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhEDQ4k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 May 2021 12:56:40 -0400
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:52449
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230285AbhEDQ4j (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 4 May 2021 12:56:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxAzWY1B4bcHHjsHryUAQrb0ubvh4g9QRwPC8uknqI+Ghqv/a3b+Z2osHSnHU73dkDPb8Ily/XeqKimdQWeHDxhmf1kLI9wqhPhChyvVec50AhTVQWlcoyMS8ramiCsffHp9j3RBnR4p8X1M8VUlzH7674e++02sG6jUk+wdfgzlD1QkfC4Y3ln902ojL5oPbYDpGZPfCBaAJzLf+P5Zm/Exs18EwXM6fffRl+0kMCx6KDiTlfeGQu27rOwgWHGsTNSPJ1JGgyhUDvWQg9F+FPDTnXpWmqETymaOo7vLal7fcTNHoKLL1FRAv9uo7jRnaNZzJ0DVE+zLjc07vS+rlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsY7eDw/cGkYn3RMsBbl2T2PFsT27ZDONLgNcmyKo5I=;
 b=E5P8LbFURaVD/I6uieA7S7UnuukcR+h0dj5Gu3LLtASDKzJbKejdBFHriZu2M0Xk13nhmwoinqHUltpBCmycZwtRU+5GVSqqrU6l+2H81fTuA+j3a9Kiqr0DO5tsRIVvlWxpJPwLRz6Jdl8p/wH8vY7fAnZVDzIpovKCT1lfC4tFs2rMX72OW0jmxeT/HOMS/VmJ30t7sG4Y9204sY4gjXoOdgYztJ9cXhjuhaNYsaRn69UF4VXXTO2WPvPF8VKTSs0QREksPBSTouotE+5fMxqKJ6to36UivtGUZsSg6W9LxYLa3ypIVY51BuEW2JllB3hm5ADgLacZnCUkyyKAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsY7eDw/cGkYn3RMsBbl2T2PFsT27ZDONLgNcmyKo5I=;
 b=WkGJnWICoL/FwboWHHDP6JkywuOUqzpl+j75UJpXV1sgKjdueBD/5W2kpQAaCoyN12BFgMZ3rjDtNb35fk7mhYD/XHyOQ9fZmXD8h0JTITTPnMEylJF7P56mZe007Q8+15u7KO8boVKmx0eMjidwydutgcBNreBoRcuK+huFTY6Raf+oDUvhjAE3dE4xJG+h61QA53KGiNltGi3+s5EVl5R/qWxHIxorO30UKLYD0L8GXxsRg4ickID0gEEi3t7ZVtcAFfVcyOKZsJaropytC+bimX13aRADHRYgYn6J+qSGveJC2WN/jWtFxXjvANoGtLeAfIC0S5XpGb/eEAJtmQ==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2902.namprd12.prod.outlook.com (2603:10b6:a03:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 16:55:42 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 16:55:42 +0000
Date:   Tue, 4 May 2021 13:55:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
Subject: Re: [PATCH v2 06/13] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210504165540.GY1370958@nvidia.com>
References: <6-v2-7667f42c9bad+935-vfio3_jgg@nvidia.com>
 <80caaa31-3918-c96d-d7ff-727ddd1a4d1e@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80caaa31-3918-c96d-d7ff-727ddd1a4d1e@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:208:239::35) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Tue, 4 May 2021 16:55:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldyKi-000Rh2-8G; Tue, 04 May 2021 13:55:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0bf1dd8-7003-4cae-6116-08d90f1d73ac
X-MS-TrafficTypeDiagnostic: BYAPR12MB2902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2902DF4CDAC09D64A6231B5FC25A9@BYAPR12MB2902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xM8wZhl5CgILJuTjw/f/33vMbHf5KUf2c6+eWcbMJchRWO4LflteyNaYZiELqF9th/7ID8Rsmo7LyAYaVZGwm53aIwMZeEjfndNpQxRWvAHNQAs3HOT3ExmZoI3lrLC1VT+jNxIEbSy7/HSeyn3Y2VW5pVVrhEMJQZ9iHvucX7cAcYGUj0EwshF0G24zKtqFQEGcl8vg86bfuQRmkDdXawOSdRMrYCCEiWSEbsYt6U0Jes1FrX+6K/QcB+zdOXhJBiiGi7r8kxJJrjl4o/wgCJukB113xaPwcJLBkqSqZ4hbWG1AbeTWJlKegME47p1dW1fxoig98CD8Pbqimy8Rr/58ga7PGpGoFAwLBajGBmxC2FAvWyXDg/maKwXzmIlG6rWwsuBmcBjTyUu7q4gMgdfWiWF6JGgSbRyZZgB0jeJYUGgAaCZ+qiXkiyN4y0UnRy4+UV9zTvVvNYDftVsLHIbpuNW5Y0xoLCvFc3WoT/vBIy93ST5OpGIRlBejNHHRWov4XlyVBFpXkgnMjRDwq2p95LHAjQA+e49mjuRw3S8YURw+TVNov59bxVVZvzM2yEVV/ZA81ItIQgwoczDvMNHKQ7fI7kV6/ea0HknNwZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(186003)(5660300002)(316002)(9786002)(26005)(9746002)(8936002)(7416002)(426003)(107886003)(38100700002)(86362001)(36756003)(1076003)(2616005)(53546011)(83380400001)(478600001)(6916009)(2906002)(66556008)(4326008)(54906003)(66946007)(8676002)(33656002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5Yv0L9PQFYd4WLOxCKEtULxBDZAG271OmvAluKliHaUtz9NZRmnjxS25H6r9?=
 =?us-ascii?Q?KKDsaXiFSC8sNwyn0mEJJtnyFSuUVSxAH/667mN6Lyo2czPN0TZREYKiPLby?=
 =?us-ascii?Q?25h8XqEMM00+kWspSU0Oun1f+poiBFk4P4R7jVqgui8uLBynMa8bCp4dK0b9?=
 =?us-ascii?Q?swkLkIGl6+lrv++FEs3vhzd1DVpzc9G5043wKnklfGE94g1wmllBpe+8pjjx?=
 =?us-ascii?Q?Fdu/DByemW2I18YiOTyDRkz9xk8OA0fh99GpKv246Cv1D8f6q8Z2XRX7wPk+?=
 =?us-ascii?Q?ek/Xy6leNYWQLC/cMHEEf21uJagSfJI6u4Kg9i1dRUbD+J8G+ylB3Xv3Fe0e?=
 =?us-ascii?Q?aLkCzcgxKJ44I8oB16/p9lY17Byx0S6x1arOzMV6hhY7W06qQ/QaaMCp85lI?=
 =?us-ascii?Q?swLFAFMJgS1QltzxTXWWb6s8rODX70qRoUhyaLSZQa2rdvDd/wzfhn7nnPC+?=
 =?us-ascii?Q?wX2P/FPNZ8B4rd2nBy5J5qBWpG0GnTxNw52NwEIyqe2JAX1ftuaObdnRvw7b?=
 =?us-ascii?Q?nJdLkg3U8FQdedtNX2s0ZVaLyiR6p10tB+673dAz6NF5w4xoeeJ5+kmmEpIZ?=
 =?us-ascii?Q?64sTStrhrZd8BuCdNqJz9Gg884HROrJjoJ0ryIt4uiN+tle8YlV8Y5tQOqQB?=
 =?us-ascii?Q?x9Tn2Hav9Y4ikfHGWCBsgNvvd5mxdlUb37YyZiYtqtR5x+oghzNrM7NOJN61?=
 =?us-ascii?Q?HbWaLUxk0BOil7ZDB629lUg2XXE/k2grGV9x4OiaemKHfYxsMdFM06L+Sfsj?=
 =?us-ascii?Q?zr/oUfM0kzQWncKnXtG34rCH8COpgelHfk8TdLntAkzJ6Aa0rkLO+z3qzXgv?=
 =?us-ascii?Q?0ueSy3XAt7P05L/Slem7Asa28wBMmRn/2roXusNGRFVvSqWhdfw2G+ZFyypF?=
 =?us-ascii?Q?ubGW0CO+dflulnpQBekcto64hMMuwW2zLOrfGLx7YdSvicQQljwTQTK9iFfu?=
 =?us-ascii?Q?9hWETLOEo4/0LF3D8WfcRZNAL8WuLqJaOKXlIp3oxHpibEzWGXNHEtymTZBl?=
 =?us-ascii?Q?669tSxF+vqO/m8AbLHY/vi5TyYeY5w/z3SVtlAdLkwzN8Hk19X+HTJLn83nb?=
 =?us-ascii?Q?/VTLdP7zS4APpgfxPbecPvpUcZk1Yr6JKckY7uma4kGot2qFOGPrVp3l/QAG?=
 =?us-ascii?Q?OATnlL2RgBi1jPsf8+O5RspTFaKdIvzhYGzUQ/fh9MAnQAWVapYCxM+6Ro/d?=
 =?us-ascii?Q?Ir1pH60fMpl2cFYuaLtTV42EyT0HkbnS7CzuamicVB/pBpf2aAQtXrKo0nmw?=
 =?us-ascii?Q?mNPwTMOJUjdeFw5SKJRVFkeO2QmzQfcoA9vHjGXXRQJLnrGjjQB4vI88H34l?=
 =?us-ascii?Q?JKxZa4OGb3ZF2DbWf9wuUydk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bf1dd8-7003-4cae-6116-08d90f1d73ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 16:55:42.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLw5RwHy/962NaoUt7OwXLzC8kBfsoJ9oUuy8ghlVJUmhNSFjNSJcJOvfRkLTWG/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2902
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 04, 2021 at 10:42:04AM -0400, Tony Krowiak wrote:
> 
> 
> On 4/26/21 4:00 PM, Jason Gunthorpe wrote:
> > This is straightforward conversion, the ap_matrix_mdev is actually serving
> > as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
> > simple container_of().
> 
> This is a nit, but most of the mdev_get_drvdata()'s are not being
> replaced by container_of(); in most places, the replacement is
> dev_get_drvdata().

Hum, only sysfs uses dev_get_drvdata(), but OK but numbers there are
more of them.


> >   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
> > -	mdev_set_drvdata(mdev, matrix_mdev);
> >   	matrix_mdev->pqap_hook.hook = handle_pqap;
> >   	matrix_mdev->pqap_hook.owner = THIS_MODULE;
> >   	mutex_lock(&matrix_dev->lock);
> >   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> >   	mutex_unlock(&matrix_dev->lock);
> > +	ret = vfio_register_group_dev(&matrix_mdev->vdev);
> > +	if (ret)
> > +		goto err_list;
> > +	dev_set_drvdata(&mdev->dev, matrix_mdev);
> 
> I'm wondering whether the code above should be done under
> the matrix_dev->lock. Does the mdev exist in the sysfs at the
> point the probe is called? If so, then is it possible for functions
> that acquire the matrix_mdev from the drvdata to get called before
> the drvdata is set?

The sysfs is inserted by 

  vfio_ap_matrix_driver.driver.dev_groups = vfio_ap_mdev_attr_groups

And if you look in really_probe() you can see the order is:

                ret = drv->probe(dev);
        if (device_add_groups(dev, drv->dev_groups)) {

Any access to drvdata has to be protected by the device_lock or inside
one of these special ordered regions like a driver core created sysfs
callback.

Thanks,
Jason
