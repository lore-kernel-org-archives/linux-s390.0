Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABC4C48BE8
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2AF6128C
	for <linux-s390@archiver.kernel.org>; Fri, 18 Jun 2021 14:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhFROMa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:12:30 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:10270
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229782AbhFROMa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Jun 2021 10:12:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiRHdBG/vKrB0ythYIaQEtRZAWvYatBK2kjc7dBi07TnNte7rSqKpZ3fo5yGEiqqf0tgOoOlxlNPTFUVDo7n/O71KgMD6YnsFfSeVPyNEZUFXkK05Cw6l1ihuDyU9BmzhWcJYmB2Yic8dHSm1Vvcstl+nMAujTPfB4fARj9kGNq/axNZ59/KgV0rBydC5vcSIKImiACTKMH4jm290UYUrmnnve0msYyBgHRRcfhpATcXLyK3qMBiTzEIQif5ctffJ/KKW3mh1xcbm9xwfk36GKgzxhP8D5L0pN2Ja1wcH+LskNGPFQvo2kMR3LqouCXzh/kD/Nmm1szggFlgr+WHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaxOB6me61eaWDjPZhLB9qN8cVvY05RlgVopUeGYBXo=;
 b=I2TWYuFsLWIHL+fM12IrH0j+XQ9G3kQ1yKKnBIx2onvK5JKmdmALJMdmYzQAKbB/v1E2ukbLi8UDZOeCJpbCgKVM2Z9P1/558H9WtMWcb+pIlXgcs/bH7Gunudzv6wbu+GO1/b+MPgcF7pdJg448YOzS5a40aCu03U31J60kfT0lH63l+9PRsPnFYHmeVCDX14LxHX+N9sO+zuhG1LNnU2o2E7MSoLslIsQM4aWbtpdvbDjhQYFr2pryaHXVSUmOJd/Q/tAZp+mVbPs7o23acV5v/ZwXVdjMt/2P/2ZgEo0Qrb1ZHdhyl/PVPei9QtqOASURUrxtfUrEZzg4mKlK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaxOB6me61eaWDjPZhLB9qN8cVvY05RlgVopUeGYBXo=;
 b=gPv8PJ+5TlTZOl0PH+u1rLFVH8AQ1jXJV03MO9EQlOIvCZFJAB1bNhFIrj4vFPauTXOV+tcRRnazL+Bi7DuwiJd1jSMlcVmJgKUjj8IUNW7C2eyxvBzf9w3Uemr6FczLjHxxLIAri3j7CQbZ6Kg+mmkz1aIPI3Mq+Ohsa0JhzHjLQG7thUcXyhXCc4ZzX9adsIm5QJzePTIB8jCpBWZXSXeBNgdHJYfPR9/7k+Aa55hfH5H0VvSWX8r2Ys5qj5e92Wlfn3w9Pbr8pnzaQCCWPIriuczfPrPxFVxrAASsAsQ/HHkHKE8jw+IIIuUTq85WIwfwq9+QGVCwqXqc0Y62Eg==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 14:10:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 14:10:19 +0000
Date:   Fri, 18 Jun 2021 11:10:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Jason J. Herne" <jjherne@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: Fix module unload memory leak of matrix_dev
Message-ID: <20210618141018.GE1002214@nvidia.com>
References: <20210618133524.22386-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618133524.22386-1-jjherne@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:208:2be::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0186.namprd13.prod.outlook.com (2603:10b6:208:2be::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Fri, 18 Jun 2021 14:10:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luFCM-008Xnc-CL; Fri, 18 Jun 2021 11:10:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96d0580a-341c-43ba-f723-08d93262cdd2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160D8785709469C910488BDC20D9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhAn3KoIT6qLwtF4pwjvUjq2Fw5j5JfCeugtOrGDTgYTXDryUtin2QotpKPrEThGksJC4TbWwCwq4uFZDQNRBhIbuW2dc/VAdcsDDm6/6P/Y+DCCmyj57MjP+SxWcGd2mm3ESanooGQtLcxKKk59otlOPGnr08tXkRvJxZgOXJd6/T3Wq7tujIBwvV9Na+XkCM6k2LG6rQQF6jLLtyzDi6VxWQNE3OV+JLb9bM5pfwdVRdCEDlfRAUGNvPKoSayQnP0C99hn4aUKKloi2/8L2qeyPijnoGGtJgtQfve5ma4574kXgdoGBu58wZXjJYZGcTwzvYJqzTflqJmdZYIP8delhO0vqIzKK804+rMDJLuu1zkH5zPyRQerZ6pDUoZ7WnvVF1yJxUESUw2OpoyofEIXD8uW0O9Pp6y09zAhv+jUf0N3j3qrFwGOpD37X8qFBns4IOdUIfDnseNhFDa/djdlz53OoCF42SutF3ACsiSWT9PMmOsUYzwar/CS4eC5SS7i3iPmL2ibE4PoDmXCR27Nay5abDEVr02cx1XNFxNtPjhKn5CQjGB0orpibS6Cqxpw07C+1eCh9ZC6eXuL8xaQZ8tbKaAwhpkNbA58Vzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(5660300002)(426003)(36756003)(83380400001)(478600001)(8676002)(6916009)(38100700002)(4326008)(66476007)(4744005)(9786002)(26005)(8936002)(66946007)(2906002)(1076003)(33656002)(2616005)(186003)(86362001)(316002)(9746002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BcPMO1j2ACIV/7gCAtWZXOM9xKOlN8xCBUUDMb/pLShkmbYSg1pxJt4hLAM?=
 =?us-ascii?Q?YHRZ0Ywu60USapU/276Hkx6BClLfJvbes3qwHlYXvhtiV0iWr+AZD24kyaA8?=
 =?us-ascii?Q?wLyXgw/bzdXKugaedMKNpJfAMejPaRNVhbe1Yl99aV4KY4r4gpUYKY6an0Sy?=
 =?us-ascii?Q?x2M5bMutbPDt5s497BFPgAxskFElFqmzRIjsfpWkTjeIY1uWj/fPttuGM9q/?=
 =?us-ascii?Q?3/aWF/Nv7eT82K51zUVT5fl1u5HFsr0EVCDE1MEX39EKrbZEt9VCNV7nYiK6?=
 =?us-ascii?Q?BBWDpL6Eqb8oT9M4MUrFTR9kNzT7BIfvO9DZcultR7npBxwCy3fG5g9pegsI?=
 =?us-ascii?Q?fzof81arXWImb5mEkUaWPND0GGknIXIseyKNhlQ6IPa6tgzc2d9+23XCMijS?=
 =?us-ascii?Q?D1hW2x8B9dyveYGXSIFy4x4Hy5qwi4ULYJ98SL7DT6GRoF/kgahw/epLCVSS?=
 =?us-ascii?Q?2Pnpd9znaTXLfwSyiVPvu3JhAEKsO7FzE2j0OlK5Khgtgg3X116sC4u+uo2Z?=
 =?us-ascii?Q?vJyBc6SBagi6VzQk/zb/Zmi3QCYZRnOk/OKEp30qRy0svcXH8GArEw8ZYrjq?=
 =?us-ascii?Q?ETXqEb6RoYJpafEmNn55H7kyzUSZLTUYtbjQrGik9C54UPLqcEwRB7k2zXCc?=
 =?us-ascii?Q?d7m60y+KSaCqaT3Oal8LAue+dl8JmRZ1b0Khha+bwhotWkGZj4Qd6It70Woz?=
 =?us-ascii?Q?7xT9pp6O6MZlZvKW9ifUrpMwZWetURD8ubibxWPs8OEeq4wMYjEUaLFC8b3c?=
 =?us-ascii?Q?scFDcZcQnSJlGunlriaFQU3Uvg6SGJxKFdhJp/mn/nrjQsnORoHZ4Xfh0+iM?=
 =?us-ascii?Q?vTfmleFaUD01GMPabilHdTWeSKL0assXgyzqScW+i4/h83+jF43ywM90MJWj?=
 =?us-ascii?Q?W6KidJvi2DD27c3Cmm/6sHhsRBqAlYaV0/I+rLwEmspwYJropFxPe/d21I88?=
 =?us-ascii?Q?kzoZbunQTKl3xZDnNDZ2d7AciWnmqLu81zroP+P0bezQwg0YdzDTABQfhKv8?=
 =?us-ascii?Q?zsNNQCMwF2+boD821FuwwwcxgF632m/8cF9dWUuYKhM+nJk/UiKzPm+/Yadt?=
 =?us-ascii?Q?C4KNx3QfGxPD9oZqA7s6XfTtMERrs1RnQFBqMjMSCL58PkQleifcOHJ1w0eL?=
 =?us-ascii?Q?7AGqeFCbMTBGPqjgNBggiKpf27+Os9QrMnHL9k8YCsABtWppJIeyvWiVRn5X?=
 =?us-ascii?Q?xYEuxD9pBL8UaAx5vguMT6AqHJb7EsC6fL0nn7W7Oh1+NljEVRCrXRek2cxv?=
 =?us-ascii?Q?4OvChTF7vL2VDgt2mNBZhdt0nFgvc/+L3rdjcXcTeLWJP2XC80Mri8meLfCh?=
 =?us-ascii?Q?LGEPlghUiZoz3U3YfkZWXs/D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d0580a-341c-43ba-f723-08d93262cdd2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 14:10:19.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3suRa9w7MF6HG6ltc5E0iaJ1MUQ6KuZ6pB8JIgbwMmIZypB1n1gTgnjEHvIEn8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 18, 2021 at 09:35:24AM -0400, Jason J. Herne wrote:
> vfio_ap_matrix_dev_release is shadowing the global matrix_dev with driver
> data that never gets set. So when release is called we end up not freeing
> matrix_dev. The fix is to remove the shadow variable and just free the
> global.

I would clarify this commit message to say that the drv_data of the
matrix_dev is never set and so dev_get_drvdata() always returns NULL

And I would suggest to use 

  container_of(dev, struct ap_matrix_dev, dev)

instead of the global variable, and probably NULL the global
too..

Jason

