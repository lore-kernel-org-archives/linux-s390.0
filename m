Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ADFC43470
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4181C611ED
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 17:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhEERuP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 May 2021 13:50:15 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:47042
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235620AbhEERsl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 May 2021 13:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0ATaKuuoOOwBr7WWXnoKu3hMx1BwZ9f92grYF5ir96T8VOxTVFGiMQCYjmz4mDu2VKEWA2JL0GHHoRp839mc/iDT/WAhOBL3ZYJBD3Il+ynb1lfhgH0Ftgw+V4pF1W2zOsLwcblk27FpFA+MYlzcjxH3PggcnygJg0ABtK89WNwYnzXb7Jv6O/KXOqSdNztrKp6C9ERuIds/qzbdGqEFWhAQjTcVM2zEPI9nPpE9xjNRa6gH1B2n6QQDV8CLElCA41Evq9ncStQI78nAQVFb71n5COWkqS1kWeCWsM09wNexkB3LPaZDRGnrpt27zRWDws0O1VI/NHEzRp46hxT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k5PyzwoNKCC1u7dPvU9KdRgt6NRVvR78sfuxTY6YG8=;
 b=Qcg1U+GhNeLJjBqVTm1PhaGeDdd3Qg6Iyw/qGxO2l47t4JUH7sMTBbx/quV8fBypNLnluzR7hkiHKI07tD3oABh/RCMM2sPqRiP4vfDWE/NQCF6ISv28MdgxmuBez5tfIBYwa3RQpZaOmXvg62/ez3GQlmSDV+i7lutTMOxXy2tCalA4FSgugdqw6HoKnszmzWCEGQdZAw5Diz+qU2DOCCMv7H3f6/deLLk2u1Wx75RkGFkJqjrb//aJE8oL0VRzf7JJvwSsJfZrirNtHWdEujHX4pXG4UTNJQiK0TkpOqVZvx30UvvXfUqh5dZWFdyTFBC04PJou965VQqviYb2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k5PyzwoNKCC1u7dPvU9KdRgt6NRVvR78sfuxTY6YG8=;
 b=FwgMjf1wH53Y/WUjR2kj3uSlQWK6SfHYOKk5kUNePvEuJ2y9IOQgueKvOOra+9hGynxyLQYx7P7cHNbAic7HYiEq5uAgGa+BieKRNoaOGvlkGR6Qhj7aH9B8U59E9anw92Cvj++Pmyu91NZ80rYgKkEOT60VNBkF6fnjH9j8jYqmXKdnuO2tekE6mJOwue/Qn9dXxeccwFc5rkEo38oZIOXeUCFO2RxzKo8NoBMv0xzEnzr5n3Eb+bhAQbjnMx/jITF/lUApclHmdsp8Mh7mrXIzFtHsN9xfWWFUX6uejnes2zn/MVGBL/mYJ9FG1tLYG0VgVmRbLrifcKlpq5qanw==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Wed, 5 May 2021 17:47:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 17:47:42 +0000
Date:   Wed, 5 May 2021 14:47:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
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
        Tarun Gupta <targupta@nvidia.com>,
        "Jason J . Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210505174741.GI1370958@nvidia.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <20210426194859.1665730d.cohuck@redhat.com>
 <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
 <20210504173027.74552e19.cohuck@redhat.com>
 <92a0c58c-c891-bdd5-3c8d-3ce33a4d7d0e@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a0c58c-c891-bdd5-3c8d-3ce33a4d7d0e@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:208:234::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 17:47:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1leLcb-0017gb-6n; Wed, 05 May 2021 14:47:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7597d356-63c8-4c00-1da6-08d90fede207
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1514787DE92CC261F4558EF3C2599@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Soporqz/haD0PYpaMICPIkAC0ApNQicGKSXBxd3Pip5PSXT7oOW/hz5pkmjZlxGVRA9oDci1+FsP0mCjN6ECUb9Hn1R6FSsepkBJyn3yDFuEcHqSNX1fdH2J1ZhZ6cnOqXw9aRuDWDNceyG5yXHnushrSb8CuSCvyZGrSGsi/y80k8j3/9q2PG4BY2Goa7Ut6F/TQ+yPhhDPtRkBEFjp5gG/1Np66nCv6oJaKlLd7LdXiJ+1uZ7qhhJZBwaZTali9sWgixRZWxBBuxdtSwku+yPVm6vE0x+PRrEwiX/tmfL3KKBHPEIvkLfsnDi/3GXcsbHgHtfXFvy/1yr+zFedqt6Wit5KpWQrWngd/fZgogCq7gC2DAwHu6+tc1AoDr1rmjQgMeyEVoMbTb8yEvSJiIY/4+v20JQ/SDknQG440xZJaHiukoJ52FR6s4WtBCnOx6vW8d4tsqWxLNcl5JGDXLE7a4S5Y/4oNrGmJCrk2dcCFVIPmvnApiTzqhJVU4DJpAlkdFPZss8s5QE6dklxbsZR0Ibc1WzS/rfGvU2Psqe9SnhRQBFLRhYk8Un9acDerY1Yiuh4LJbKlz1arHO5q3bFWrQqhZGaqEs2Cu5Of0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(33656002)(53546011)(8936002)(54906003)(478600001)(2616005)(7416002)(316002)(6916009)(36756003)(1076003)(4326008)(2906002)(5660300002)(186003)(38100700002)(86362001)(426003)(66946007)(66476007)(66556008)(9786002)(83380400001)(9746002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mojHdqkpXyGPI297gPCitWHaEYO+/CarNbgRXA3ngvF9s77AxiRC2wl/+LR8?=
 =?us-ascii?Q?O6hd1gpNkGmfPsZxesIUDUhLkpvh2yJmsSVdnzOqOOHsElcwUc4lkcCTWK09?=
 =?us-ascii?Q?iq8Yg/nzQCNN5ZzFtpLl85Og54WevO7jr/Kwvh1BaaIEOfKXSYgEuKoIV4Cc?=
 =?us-ascii?Q?B11Lx4Bx/A87Jf2u2yW5FExVsbryFTP5YBlWJdBHqmhHlmJv9ojS8mg6iTed?=
 =?us-ascii?Q?+YfPmLZ2f1fk1WOWJOSX71USsgjQdCcCF22YsTGifOdpqq8oWMGHWFQAcjNt?=
 =?us-ascii?Q?H0SqHseBIIP11NdDsicA4UOCTU3eZYgnroe+m6PpazRDz+SRKNnoG7klDGvY?=
 =?us-ascii?Q?6Wh4EU5VlF8XGgLZ+T5vbfbXBK71OKPdDAMtgVGFyLCUwuysYflPs3Sep2IT?=
 =?us-ascii?Q?qp2UVUM66yySIHnQmzzpys/JY7nJKf2teTrnYsx7rbgukw1XnjstdVKTL+qy?=
 =?us-ascii?Q?PfwdvbEsv/SJdQM1uyCdTlX9hVDmho2gZ1kf8g4q8kbijZ+cWECVu0NQGhEv?=
 =?us-ascii?Q?28ySVyenT9htLvdFsSfaOJkkgiBx+G+S7lxowRVvl9sDMKr3R7qQtKgZnIGP?=
 =?us-ascii?Q?jGVTIbML6RD3K+jUgM2SCxyULXxhs8jmxKGJDFFLQLZ4hUh1KHeqw0euJrgB?=
 =?us-ascii?Q?vICPIKFprcANv7fjmFxRFTnHyZY7ywuiVNBelN2KdcZJeUmsFj8b1TBGLLS9?=
 =?us-ascii?Q?H0irXWxYUdxSVAcaxQJyP2iXmgvRoSEJQXk1qLi4w6+1FLCCGLTm0ZpL0+hh?=
 =?us-ascii?Q?krFNI92pFSx3cOUilH21l0hxI+PUVTHQkJmVmC6J0AK1Ug90dUznn+s1tj+1?=
 =?us-ascii?Q?jFP+uonQb6uh4pVJgy10Khjt7KhJUP4GR25cnxbQMXuW3HuXpLtER852vBIH?=
 =?us-ascii?Q?q60Q1VNXpI9qvMorIaHw6MDvoJSUTFxS/xw8gDT6w8ytLHVnfwZpC48upQAZ?=
 =?us-ascii?Q?O87rcVoLX/snemes7A5VWQeHziA2NAurLQomNijBRRVVRVY4EqQOCMkNUHzP?=
 =?us-ascii?Q?YLSILvpoopawJDChzMzSKisesIfzEjn5X/JMMQ0XklusygBv6fe9uzY3TIv/?=
 =?us-ascii?Q?J23cU9G5L5k2E2SBkI1khppfdRXq0GEHGBN+KlPl7SovhFnRGCY7EvlS8wSW?=
 =?us-ascii?Q?MHW6j2oZyVNNcwGJZDw2gF5mkU2MwmWysCu/GRTjR8pz0bawqOrwaOka7G2C?=
 =?us-ascii?Q?VeuoBN8jgU+rW/YJfFRxu8nYkVz/FVCO/1gnlEFzkFWlQHqAwmwcrsuTDyqi?=
 =?us-ascii?Q?GcIGp7rfGnaejyEuq6zqFs7QyKbTmxJHMKGwzpJgv5bk6AyMmFm8NRSYz4Sf?=
 =?us-ascii?Q?2hDJfwJi0u2o0CWCyeJtOEql?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7597d356-63c8-4c00-1da6-08d90fede207
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:47:42.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GalH/KfMbNFatkMaahieZ+bcjd1Okk2CA0dB+yTRKvx3zodZzDOuJ/kFrxctGaQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 05, 2021 at 08:30:54AM -0400, Tony Krowiak wrote:
> On 5/4/21 11:30 AM, Cornelia Huck wrote:
> > > So, it looks like nothing is done with the mdev until the fd for the
> > > mdev is closed when the guest is shut down, at which time the
> > > mdev is removed.
> > You probably want to wire up the request callback and notify userspace.
>
> Not sure what you mean by this, but I also don't think it matters.

request is triggered by the vfio core to expedite closing of the FD in
userspace.

> After coding up the fix for this and testing it, I've learned that
> if a user attempts to remove an mdev via the sysfs 'remove'
> attribute while the mdev fd is still open (i.e., in use by the
> guest), the mdev remove callback is not invoked until the fd is
> closed

Right the vfio_del_group_dev() called along this path and it blocks
until all FD related accesses are prevented. After it returns no ops
callback can be invoked.

> (i.e., the guest is shut down). During that time, the mdev is
> physically removed from sysfs so no further actions can be taken
> on it;

sysfs files are removed before we get to the remove callback - this is
part of why remove cannot fail, the damage is already done.

Jason
