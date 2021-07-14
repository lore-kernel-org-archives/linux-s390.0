Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98677C07E9A
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 18:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBA561260
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 18:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhGNSqA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:46:00 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:63457
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230282AbhGNSqA (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Jul 2021 14:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D749d4o7qXE8CLzCxqrq6C/lwoUloCg0EU8vihUUzEijISmyuyNtQCQOTdfFc4zLAtDOEDjAu+9bKi5NEisQuUEGXGCxNC+x0qCcRFHZQjVuX8hPazhAVJqNztc45/6sh4Q4j/kOzqByJgo+JK1f1p3V64PBJWRJkV0Ki4Z67zICXM3edX13uknH1mK6xgvTosjpgkgFts1dPC8HY8NNA/mA/OKcvLZU2c7pa24hgzmmBqFHXdSXWcPRrFqXRpe6UGqUVtIMqGB8RsDyvZPvLan+la7dOLYdXdZFhuRZpfDRmfL98mmrsLCjqxyLV9ZBIgpVRRkHCYP7KWFff+8ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyDhrkjYLXRllGIbHvIamFDBfLqqM9BTil7jyksiN44=;
 b=BCCiPMVo6xkKSZDGQBHCO3x6zNIlF9Rl6x/eqfF+qJ6H1Ses1WpqnriucbwGIpVVscAVYD+ufxW+hd2MzStPc7rmv7oIULPzHvwBEtsZhOIHkS4oeSl6qnvOwQINy2iG8tBci2bCpCHE1F1jCNyPx9lf15/awYOelKz7ddjLI215VDb2ydmwWxOSXznPjun6OLysJNMspBuef5ptrX+hO+CKVd8AzANnevhwmJjZ5mn5qEFEkstsdwDKqCm5//ZD+HOt7Y7CWyOCVwAw5toEBBWMe8zW6Wg32DS9GehOw1xL8bhiqlgct68f0uG3GBmpSusWErQFG31oszA8M71dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyDhrkjYLXRllGIbHvIamFDBfLqqM9BTil7jyksiN44=;
 b=OPr0QSNqOMhIkzuXVnjWwd489w4E2vYeU8RDmMQfSWtCigzDWGr1nPlh81d5Od0IPxloy3ygNVM8qNdeCmFkQ7EPoGuLuc2FCYD/kmb5T8zyCvcRTwdrLAwnczhCfhJMX7FeEzM2dMP9b/1oPy+lVHvnQp8pR4TP5L5XLvyYqyeHrnvYO0xT5wH1n4bk3rJgxUOQm3np77nhxH0i3OC9T9t+3lt3PUno3+lbXaXmjzAb3IvAoTQuV/VpKpPyHGzwerslChSOBxwi46RxwwIbB5nF+DJ2M29DpNgIuTNEdJy3X4+kxUWUKKBrbmO4WMzIkrB++50ig82n/+nIu2QjJw==
Authentication-Results: de.ibm.com; dkim=none (message not signed)
 header.d=none;de.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 18:43:05 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 18:43:05 +0000
Date:   Wed, 14 Jul 2021 15:43:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, alex.williamson@redhat.com,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210714184301.GA543781@nvidia.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
 <20210713170533.GF136586@nvidia.com>
 <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
 <20210713192138.GG136586@nvidia.com>
 <dc18ff02-80f6-e59e-5f08-417434e74706@linux.ibm.com>
 <9c50fb1b-4574-0cfc-487c-64108d97ed73@de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c50fb1b-4574-0cfc-487c-64108d97ed73@de.ibm.com>
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BY3PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:39b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12 via Frontend Transport; Wed, 14 Jul 2021 18:43:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m3jqX-002Lrq-GG; Wed, 14 Jul 2021 15:43:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4424dbc-9ec8-44f1-aeda-08d946f7377f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51443F673EA20D0E13B5138BC2139@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ff7tOwOAsOSH5i1oNW9mOvR+SUgI3WWihhjDl+rqwmYS19kGNfWfUb86QZz3fbeU4uyJjgKrNYhVE0zCN++w0Nr+2F3OI6GwM7NXll5yIB/6kzf9BvsgR71JBhhpDUsaM2V8DcNQk98BgeH7JEF05o7FLIJ2ikHaRwIQR210D4mA2Og6sMl052N9v9AInb+AWunM56Ikv8TVpS+NgM4O0Z36fCPSRf+qkEkM2qgdkmm7NnkOJuzgS0lbUTchEdXPXnavFI79Xan578TiFQrEIr08tT/2w40VW1zqf+CAS72RqN9GOdQk37GK8l8f0m7/OWpCn1mZ7c2ox73GINhzOownwCS4Uf5Cjhx+UQ7LVlGO5DwvscU+tjAYnQDyHUpi3QwVQ1nwXKHPN/Tumpl8aBrKAczwsC68jPnNZB/Y24y8i3BEf1q3IPPt2SAEMwyF6h3kYLbUeJjYzV9CrkobIq3HTfzhqBB86wPj/REIorKz4RCi8t88suyY2c6D4gUGsyIrqj9+6SFhL/gP5nB+HfOOz9wxsM0rJWr/BJK9m/zzUMPjaBhLKeBG5w2cv2QTdbJ5GsauEDB5id0wG9WuQW/HxW4GugSITQ3gsSf6USrG1xJ1XhX55SfZRjx8InsGzmZZVmeBEBYPgjQqcTOTjCW6OcjW25SJXxu4wFFe9RnoZlBPIhINa2rNjN5U9nqfoPvRazMVjukYAMs0mhJx9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(26005)(8936002)(1076003)(6916009)(8676002)(66946007)(5660300002)(9786002)(38100700002)(4326008)(66476007)(66556008)(316002)(86362001)(54906003)(36756003)(9746002)(2906002)(2616005)(7416002)(426003)(478600001)(186003)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YGTM1XUQmk3O7gGeXnnS107knOvX9dYpLPcOUEHYzHGN4h4XqFUjYCVEd0Ow?=
 =?us-ascii?Q?NeDQ+Zd9VUD2vVMsHJOnsQzvRrXhHNMM4lCSZekRrOo+YERgvE9T8GcHNfMb?=
 =?us-ascii?Q?K/Qdigh3ANwMJ7Edxo31PgQIkh8b6+TI8np9khIjO6Bn4OLi1H48l5Bgb3tL?=
 =?us-ascii?Q?N2GAptT1lFGlXrXi7o5AKo/mRgJEoi0IBmvfH2NJcDj9YWXX8mZpaPLzWPya?=
 =?us-ascii?Q?zMa0gMEhMfbxudz+kM94bXQt5wdyGJu1V+RwSwtDwQhalKbNdxEq0ZO5FSyz?=
 =?us-ascii?Q?1cdFR52lVVPS4plT0z2rrPYtUr6FHDVk+dZLq9l1HYRq3PC7zirpLk9sYlo6?=
 =?us-ascii?Q?ESF1XJV4PjU5WbrvCS/E1mVJzG0Rnr+59Ky43GEWgbUUYpCTYY68nsHtN7Ji?=
 =?us-ascii?Q?NetemVDl4HrsNUGfsSHKpc1hMnjB10WT9jrnThyTZzSxrM77h0lkrk0xrUDo?=
 =?us-ascii?Q?ey0t2mAje1qd1ko5nv63KLN2Yz6jEEz1X8fmSE1yufKjP+TSmysEPrx8iXCS?=
 =?us-ascii?Q?DgI+8jx6iiGr/cnAg+pp+6K9PqAQiCbuvrfvOM92vZbfdnb2HHWHLNir6tFt?=
 =?us-ascii?Q?eAWI8lU7Dw4Xn5OT4ce3xtGw2BfStDwW09W5rCX5Kg5/XXo3O/gTXIu4rWdX?=
 =?us-ascii?Q?jVK/k0eFszdpYs36Ye11Q6DrVPL48dpWRCZrHCa01CKB1jSyzSDVTq/FPcyr?=
 =?us-ascii?Q?BcpEIfX0wY6AOxwOaL8HBC/+Ws3DiQpwWM1eUIEXtVMoYhlvYRjv87xlaADy?=
 =?us-ascii?Q?5A495wSiW041dN/+07aDvW20MYNqa4lbvUha/0HDllFk2OiCskFAd9BxE2/c?=
 =?us-ascii?Q?GcJWP/oe342DvNykslsgQ3xsAwXXgNbAiR9mkFN+dEXNFBe3W03Qt+3TKU87?=
 =?us-ascii?Q?TIasdZe5zzOC62gULWpY9WB1p4nBg/bjeu13FxJcFWrgchQNjmbPcjN1+g5A?=
 =?us-ascii?Q?1bjPXTlVvlfoxF/7G7H5SuhbhtSg8nb8BBdY+lM/oQH8k/Rl5HWIej/uplHn?=
 =?us-ascii?Q?Qovahfsiufur49FtSVBAtSsoN5mTlbGYxCNIHf+aWeBtVCaQpA83a2nmX5+l?=
 =?us-ascii?Q?Na1LiH2IWGn2PO/JAlub20dvYSN28JMh1hyShy/2m59JYVQP40ZBkP1eWetg?=
 =?us-ascii?Q?H4fv6LuSPlwPSy2MKgYNE/C3fMK5yHPRcIvAly6dYUu/HmP618qC6IqVyZD4?=
 =?us-ascii?Q?lA01a5rCWLZPJ8WEGJPEyrT9nNo7FnMgTL4t+WTIA8FTZnsVr3SZZZrlJoLo?=
 =?us-ascii?Q?CGE3Qmz0JwtwE9ZomsaWcL95jLPBZ1/CIAcURc1puAGlN9rTGESaxxYZEnv4?=
 =?us-ascii?Q?am/vrfm8+5tYp3DQMIk1jfH2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4424dbc-9ec8-44f1-aeda-08d946f7377f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 18:43:05.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+BgSrf6w/CZQ1dFDqX9kYcllo6ugqra08zK2lvEgUmBct5IAE0954nTOQs3XcRv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 14, 2021 at 07:56:42PM +0200, Christian Borntraeger wrote:
> > > In any event, I don't care anymore - please just get this merged, to
> > > AlexW's tree so I don't have conflicts with the rest of the ap changes
> > > for VFIO I've got queued up.
> > 
> > Christian, can you merge this with AlexW's tree? Halil suggested
> > the 'fixes' and 'cc stable' tags ought to be removed, do I need
> > to post another version or can you take those out when merging?
> 
> Normally this would go via the KVM/s390 or s390 tree (as Alex did
> not want to handle s390 vfio devices).

I would like to move the vfio driver(s) out of driver/s390 and over to
vfio. This is the normal kernel process and after some discussion we
decided with Thomas Gleixner that this is the right thing to do for
things like the new Intel mdev.

But that can be another discussion, thanks

> Alex, as Jason is waiting for this to be in your tree could you take
> this patch via your tree ?(please remove cc stable and Fixes for now
> I want this to settle a bit).
> 
> To carry this patch in your tree with my kvm/s390 and s390 maintainer hat
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Great!

Jason
