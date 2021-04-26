Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AEFC433B4
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 18:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8967D613BB
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 18:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhDZSLm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:11:42 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:33373
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234108AbhDZSLl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 14:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niZOVDew4zmcuQUhETjYUSL1EOUh0hfkns5fACMT3esYHmiU6iS4OTnm6R6zr3ivDnBFWFAWW7El5aNlXr4GjmoEbAovlA4foSTKhBkz+7QSbtBSnFuxUe66BGgXkf2v9ORDeLK1NtwqEluqv3rCN14iu+UwMiPrvnRqbra9BRlKyIYgNptOOzwrO0cmmDc0d9G+iCTBppX9Ior88F+ePR3yZUyCN7Z9kxX4y2tI4oRarDzZoy8cv0YLfCrFoFEfDdPtQCVJOuBT1GOTvZwup+nnG2q9gxH1F578eL0n2hO9VRu4pwI2xjifuqwGu2EF5WB65yLt2kMI8VRfkZgH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psLGLPeW2fQsrWRZzPE/b2aBx438A7Z5F8TgU4cWGGY=;
 b=JGwspJ7kFUrwFV4OA56SB2hT96VP0RqIssvjktZzvEj3DlQfT9otaZuVCyNzVSx2OmZW9J5qvtREsXMoDnuoSQo6cbefz9OI8W0P/HkFD9buI0gbqYs+6aC5g4lp2HGmHC36mJBhyB5qxcLivz1bigiTKAYxR6ieWVTGqECxIAR5gYALK23xTzBziu+Sg9ivG4jEfanKR/pwj9iojL4eOaw6D0CZhtoRI21ZIjrK+aZMZxwA1J8gEwCDwiIaPjDS+DHYtl4DjV0tiNg1bIcIsxvBkmo0bYXNmoZ1qKdOFvLlOAwyoujqC81g1kqkd5fZIx0I+0NHxpvrUYxvsCHMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psLGLPeW2fQsrWRZzPE/b2aBx438A7Z5F8TgU4cWGGY=;
 b=I2/TJ5CpsmrJW2H2NU4rDy00rlmRWDJ1Yfo16OUDWeGcQH6B7xdaqj/kPaQn5FfvGkO0M+5CoGqPBhBHFhOIEN+6jgc0kO2xQWyx7F+028Wrw4u/HE2sHnU7LcUet98ROOadheq3T5nHgffDopExjmyqjhDDtmYIhFXuhJm5pmGDRqHgxGeGzwHc33b0PrSppNDbECbDede8jDcffUOEBSkIxFQySMUDn2QoAfzSuUI5E/7NC0Que3/SQU8Zl7MvIDQQJ5/IToUZiwmLQejKLZ2TtCKpd+ToBrVWlTXqRVfJkTpeT45BoE4zz9CEiOs01hHnl2wLBepuh4ZqQIRQqw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 18:10:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 18:10:58 +0000
Date:   Mon, 26 Apr 2021 15:10:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
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
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210426181057.GX1370958@nvidia.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <20210426194859.1665730d.cohuck@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426194859.1665730d.cohuck@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 18:10:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lb5hB-00D8j4-8k; Mon, 26 Apr 2021 15:10:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d629d8eb-d812-4dcb-5798-08d908dea462
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042ED4DD02217FEA64844EFC2429@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwL+IU4dYqhJGMQU1gjY58UvuU5OV823/aAI7CV/+tm6Om2JNCsEEeHQFfT2qMbOGZmW4xeNU7WSZKPPjDtvkq5jT/31nDxKxsGGCxFjxGSuz1Dzx3xWJiFhijXSVmP/vy2MX6lom0s+u5cXqVrZoX6Z9UF8lHjr7FUR9tTyV7z2Jadg9gjb9kzQoupY2tAKimEOygeGInaLh669YzMdL7JAA9INa0VzRr6/gGsJnAalgFijmmnfiAj1v8LFdcYpv0cD/74tJ5W271HWYFrV6X5K/ZUe3pIKs2T0YEBe9NUo0+EoIx16wkQOEHyvTLwO6Gxz6TSbjYKQTHVBeFymMAzRPXNo+kGUK+zyOwFW2XaWJHnLHCZR1ocOPs7aiqxsO25ie6sW1TvItwJhIg8uC5fW89eryRxJa6uRy9BDyYKCVxrUmy/4b0JaNb0Hr6N1A2h5EAy9eaThGC5mfcIYzyub4IoYXCw4qNBRnFCRxClL4U4v+jEYZKRUt8iXZsi5+N2nyGDRye8pK9Fs55TTyZpderpNRqMAH//hCgmyW1BTQcAQHiCt2Y/ZLiW8Jl2OCBHZOqMYLKVzAqS8TSIHmTbHA+5hqnqYPFQzxoQq5+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(54906003)(316002)(83380400001)(7416002)(86362001)(33656002)(66946007)(8936002)(5660300002)(66556008)(478600001)(9786002)(426003)(4326008)(8676002)(2616005)(9746002)(38100700002)(6916009)(26005)(36756003)(1076003)(186003)(2906002)(66476007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lZDmRs+5s8VHXMEC9iq1g954zg+Kt0tYwDCt14tNC6/Z7gLyOAjW9GHAYD9l?=
 =?us-ascii?Q?M/XoWrW5G3TfNaiSIQ+3TgGiv8FKJUdZbFzgAZyloo46/tE+CQJ6688IjmRN?=
 =?us-ascii?Q?kZoh5YP6LlIuT3dgQZ+1HSwA8czZQ9gmg+fpUD0dCwiUVVSYe0UwtGICvNaK?=
 =?us-ascii?Q?7Nvb1W3ey0cQ12XYn85mrFvp/z+sJdUqzr40CY/4mNAUE+wmRxYNB0ZwAse4?=
 =?us-ascii?Q?cEGOeCrLDo4aAjJz58dkMfOJHlvRBuY3DW60IwmpSH+FIv7hr9Sm61hgEOBB?=
 =?us-ascii?Q?7q8UrsiaBOJLjv5duHas4hX1m2/ZuM2wRBKNJURhk+cmSDx22WEAw28c1rN9?=
 =?us-ascii?Q?Org7xkInwoHmExTL/wW8+VbO6w8W6BPEAk2t/Yt93wV8jFOCiCJ1Af1Oi9ND?=
 =?us-ascii?Q?YyZXQ3YmgB8rd1588ch1WsDvFo/AHRxGa0PeMlwqvHVRH3Xj9v5s+oWSDUhm?=
 =?us-ascii?Q?36HuejyaZEND7bbUgE0Z5KiI9um4FS314ze0S/IQYxjH/OsIP9YLkWPePa3c?=
 =?us-ascii?Q?iqF8uqbQrwvhqt8dUfqyRlLziTS5oCNwdB3akA4UBQ8wH6qIgOlvUrxobW+5?=
 =?us-ascii?Q?d2mjI/xEv/7neFL5IwbqGd4jeVLqhhOqONkVYF7QfvB8nZJmGQjDFfE9OF4x?=
 =?us-ascii?Q?FQQwqC5RhD1O7pWGtN0IYae2d/NevVytTI4w92nbC61y31EgwI1sNJ5oTVoK?=
 =?us-ascii?Q?Hkwpf53GaccmkTHfKAzxHECw3M7ew5nduxG+uPqqKHQXadyGLZlCy578doD4?=
 =?us-ascii?Q?sbT18nPdsvhM1uqmXZXPwKCJLTy0eXWyUHzcGDu84j9baShSWlFIHCEdIsW9?=
 =?us-ascii?Q?fWQLhalQnfgeF2cYWV8mp56/rg2HdQ1Zo1yjA959KVWQ8WyCA7B4PiMNZoBt?=
 =?us-ascii?Q?T4nrrD3yrNTOhLBU2xmAOVzlVBl2ibW6wzy6pkBlXJ9sV5ugKWXGDg9J5iSc?=
 =?us-ascii?Q?I94IAdhXXzYthlOMNg7Yhl19iRnmD8uVBi6SE8uBq7OY9lYY4T6xULcxXI9r?=
 =?us-ascii?Q?a5CSfE1+adqEhfo+f2gR+uqp066levo0RRYI90Cmg8VPTTcHvBxotIY+Qaoy?=
 =?us-ascii?Q?r+MnGdmZ+B37yKdTFBoaTMAQRQ3tFf1B+/fMeO0EINUX56sophtFtm+ugdnZ?=
 =?us-ascii?Q?p4omsMXZcbljGI71gKdq5sva9S04GXYzSqweCchmY3S3MSwQ/umT4lWKckJH?=
 =?us-ascii?Q?AXeL+qAsoclavVbeUtskni9tCYUP7CfBBk2ntMv+RXDWNbTzYEn5rgNz0Ogs?=
 =?us-ascii?Q?VMoyiKivWVnXfhK93bPGX8rt8C4quQ+phkLgOo5BZF3T+jssw9YA8Nks3M3f?=
 =?us-ascii?Q?5L5CSoONQ+M31xWrAyWM9u/S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d629d8eb-d812-4dcb-5798-08d908dea462
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 18:10:58.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvcD/ozL1xbToLP7tZu5HQDy8YtI/tcvUNIPcT097MUbklAxynN/eILA3IY5fX2r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 26, 2021 at 07:48:59PM +0200, Cornelia Huck wrote:
> On Fri, 23 Apr 2021 20:03:03 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > This is straightforward conversion, the ap_matrix_mdev is actually serving
> > as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
> > simple container_of().
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/s390/crypto/vfio_ap_ops.c     | 137 ++++++++++++++++----------
> >  drivers/s390/crypto/vfio_ap_private.h |   2 +
> >  2 files changed, 89 insertions(+), 50 deletions(-)
> > 
> 
> (...)
> 
> > -static int vfio_ap_mdev_remove(struct mdev_device *mdev)
> > +static void vfio_ap_mdev_remove(struct mdev_device *mdev)
> >  {
> > -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> > +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
> >  
> > -	if (matrix_mdev->kvm)
> > -		return -EBUSY;
> > +	/* FIXME: Remove isn't allowed to fail */
> > +	if (WARN_ON(matrix_mdev->kvm))
> > +		return;
> 
> This is a pre-existing problem, but the rework now makes it more
> obvious.
> 
> Previously, the mdev code would only print a warning and then continue
> with device removal, even if a ->remove() callback returned an
> error.

This does mostly the same, the warning was just moved from
mdev_device_remove_common() to here and changed to a WARN_ON() because
it means we are permanently leaking kernel memory. I think in this
case the vfio_device is not deleted - though I could re-order this to
make that happen.

> Now, it's quite clear that we'll end up in a weird half-dead state.

I don't think it changes, after we print the WARN_ON we return to the
driver core which does the same put_device()/etc as
mdev_device_remove_common() was doing.

> IIRC, the check for matrix_mdev->kvm is intended to protect against
> ripping out the device under a running guest (I think it needs to
> manipulate some crypto control blocks?)

In that case it is missing locking too.

Jason
