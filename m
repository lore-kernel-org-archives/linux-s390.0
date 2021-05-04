Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE91EC433ED
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 16:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B7E611AD
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 16:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhEDQFb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 May 2021 12:05:31 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:9198
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230501AbhEDQFb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 4 May 2021 12:05:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG00AsdiLT45P48FQ5rB3HbUIvE4gytkMWJeUzdPU79ZplcvleXMYJbjeHfLVPLGmII2kN7BHLQ2xXIQpO2oMSS3AG+uQV5LrFetvovCKvZMV4QKGGXXMg9hxU6Kultgt2qS3qhQTujsR6JelMxkyNMpjVbSbwrTb/Is6TYkOoM/yvgY3TuqZGEkUlo8HMurYUrIWX+TGhAKj4WALHogcjCAEpQQznlWSVvFffhGLBnZfCZ2tpDy7Pf66S7oqFx5b86FgnQ51k7ot6kSxMcPYINyWIuvG1S6gq+W94mdX8FhSkQc5XJfAZcttKx0Me/jvgXJ+QMcoHNchrj3YtC7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkebixZm8eDbBztk5AiAv1Roi6bB92mnu5NEfmkOMRA=;
 b=cGzVLvryyvQjWqDglceYUJSTEfusI1L9WdlGDld9IQLh9aPxI/qswjigAu6L+Hh68H22ELxsfHRP5XJf+CH8I3jzdvL0cuTq5Ehd8C10d57aO0fhgArek8a0ZVatyrX1mW3Zo/3DIJaGgUig+bXUeJYvNZeChhwLMQkp3B5z/K2zvt9VYns5OQb1awka5H1FHCNxxeVA+QOrqoSocrWEcLPJ7F0cRYb/PDkzYS8CpK5RvHvytfwd9t6DMvBktzUkkx0ARlbHNnz7MfQYtoLe0BZh/lr7HxkB8fsgPz/HnENZ92ImFbkkqPWzP7iOCPc1b2FuypOa6IDvY8hrolI59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkebixZm8eDbBztk5AiAv1Roi6bB92mnu5NEfmkOMRA=;
 b=O5CCZQTobTwzHgQPGcThYm05ZErsRF6UZaZ2ONqfuzcB1eU1uo8QgzJ87D4lMi3S9v+6tDDdJNSyRh5+fUc+h6GtOk93gVJHLTgZo7LoCyGOyqE/jaGKc/8AjUi+BQIB2Y7d5j/b0KENY6iLkQD2JW4SJVetlwxTge16WpXgR4heXdNbJtVqzzGs2PrU0Z2VCe7Cbs807M7sd2/KzyJt3nq+TepPE8xqlsTL9aWMVGedsba5kJe765gexvQvu3UmshEVQjTu1WofQm2DRHSs4aubzdxuUq3wMhW5l546UvVXAO6CS6kt4UQBuL3plmGjuBDJMNGm3q65YncqOwtk1A==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3352.namprd12.prod.outlook.com (2603:10b6:a03:a8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 4 May
 2021 16:04:34 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 16:04:34 +0000
Date:   Tue, 4 May 2021 13:04:32 -0300
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
Message-ID: <20210504160432.GB94750@nvidia.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <20210426194859.1665730d.cohuck@redhat.com>
 <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
 <20210503203319.GP1370958@nvidia.com>
 <01ada05b-ecfb-491f-9a34-6d6de54262a0@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ada05b-ecfb-491f-9a34-6d6de54262a0@linux.ibm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:208:32e::26) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0141.namprd03.prod.outlook.com (2603:10b6:208:32e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35 via Frontend Transport; Tue, 4 May 2021 16:04:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldxXE-000Qjn-OO; Tue, 04 May 2021 13:04:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad3ea20-4d94-45ff-e113-08d90f164f4e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33524231C59A6F27A4426CC3C25A9@BYAPR12MB3352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fx+9XBbDvY1HS7vQKrm2Xpi5UdkeQdXc9bWikGbCFV4h8zQ5Tg/6DgNjRvOa0zBUVkgmkeqgMH/X1BbOxlCDKFEuV7yTUeG43oEtyqSPOfF7X7bcCJMJI0tyRFw64A9DYZCzvmXRETZi+3ffw7acjbM1979x67DQ0MLK9YP6zuigWBnVPEESiiDE5PLI7Qwjgxa6EgJ+64Z8W7SGbLRMVZqT4O81FWkaPRAUwCS9eyVDG4BW0URL4v9Vz8XQaOmurhMd6CldwD1ytTrS/bDUb3MCpSsdApcN6scwhBYbccgEjuD6tviLXBeKeBSNg9SoJ6IsKOYV/0yMAzwlB8Gp0OsrUxFxf5JocNzBAy+VYwe+1njwNJYsvE8KDAMv282DkWdKrgFXs4WbbK9cqPHiVaoFGJ5s+ubW9OlZK66fGQXjqJk+nSO3H3bTDkP5MhJOjmo5uVi/roZOHHPGbaZaPihp+SPBarTNGTtL5bwrqhvIzoBdy6hx1EzPxzoou6qQ/xzDSznDD/UxCpwL7itw3VALHzopHyI7itbj4R+Wq9WXJLNdgrfmCZ1mV/R7TTaJ48vo5q1fyEIwucWg/6nIlwdia9Gnj11IrRGTGOhxZp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(66556008)(66476007)(2906002)(4326008)(36756003)(9746002)(6916009)(5660300002)(9786002)(66946007)(1076003)(478600001)(8676002)(86362001)(2616005)(426003)(53546011)(186003)(7416002)(8936002)(26005)(54906003)(316002)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TqfEG6IvbmQPmaRueI6WPx5wBAwu+txDfuhpnQm6Lmm0CdNOf/a8eU3kRINw?=
 =?us-ascii?Q?Q/LIt5ywuGb5k+vCtS8NdpuDRxa9gPchTyC7Rkx6hF/tC5su2plBTRP5b1/8?=
 =?us-ascii?Q?lWDItAO26xkM6QnrRRRt7OPe4oMk1oK1Bqsci8eLfAkhYck1onhhOkiwVUYI?=
 =?us-ascii?Q?D78KEuBQU+SyA6GWN+FICJa1rTmNnXjuPKll5TrjLi+IPkhYqhoO5y9EzAnr?=
 =?us-ascii?Q?dk8uVFyNyOXF+ddC1z6thfEqLr/47iX3N//9dDX7FiQZ4xwyhgoFA4DgiAyk?=
 =?us-ascii?Q?EMCnzP7J+tVux5ymj/zERkyNBVNuQc0xQvkPWF6U+flINTmyvf5rRyTEpjAL?=
 =?us-ascii?Q?ip6avzXZfVkKlpcRKkkl53w/+HkOPSZ0yRXq3iLK26kh+gt/tvwgAhSBHj6b?=
 =?us-ascii?Q?T9l6hrMMJagrB4rBdgpiPJLsRSM9O1nxHh+FHB7r/tphE/F6tSqXofoofyMR?=
 =?us-ascii?Q?YDCLStOGPRd7CE2D/ammtcEJ97KB2LdadZZEq1Xpldq0T39uafGi0W8EZkT7?=
 =?us-ascii?Q?o3wfilahQlluL71wp2qvs5pFg7yCcqcmVnEjvqhEGzy2bO/s/An/3s8aBl8+?=
 =?us-ascii?Q?TzPBCWlco5QNNaIKjekDKAwqYA2bVq7U32SX9OHjfEPV5SQ+Xgpyg3wla37c?=
 =?us-ascii?Q?98iZDievvxp/U/LR74HQ8mkdwuda1oo/IoRzAE7bs39kwJeN7gHpsW7Sl5y+?=
 =?us-ascii?Q?3vO0OZUkxn8bpH47ag6MgLPnN4STlQONfdiiGl30CYvnqncUoet3LIcfUoLD?=
 =?us-ascii?Q?96WJ5np2Jw8TqALp1UGmKxzCpV8McDSD5ydtpapnUFNptDuaqpfpMfOnMGaW?=
 =?us-ascii?Q?r83+2ttvm896l694NRT5kw1lrCC66u2f50LISPRjfrdmNsIqhM8Rak7WcPrq?=
 =?us-ascii?Q?fx52JELOsRgMKuGlZZt7WCVKU9c9xNhES+YHKjxuxJ0lAGixEy8eWN4sc5+n?=
 =?us-ascii?Q?CNrLqkN3uDW8TmVEgs1EyTsVbzXI7bhbtI8K5r3j4mpZ/xgTV/9UHuYGCRQr?=
 =?us-ascii?Q?bapeDyLspHh357GR8z0jAxf6bj/pI9+/jX0SMmK5KbfNfXrzxNYNuI/8co1F?=
 =?us-ascii?Q?PcYJxaDiBOB+KLGWccGMY67pDygTmkWMPtWKbO1wcuV8eVKsiTSmTp6cN3kl?=
 =?us-ascii?Q?8trr2dRjpoV6mOCa+WCod5J9KbfKSLhfwgfnVhPwPgJogd5+AObZGTgmYjkG?=
 =?us-ascii?Q?VcSfcslKTi4uI8wSBXaGqFWOZTtkrxv0bpI2EoAYSoCnkWRlbticW5Ohd8/0?=
 =?us-ascii?Q?3ejqZrlAGr5u2yIWo4BQR7uw3ONxA1hPvypC+BisnYssSurV/5l8pyG3XfFH?=
 =?us-ascii?Q?hUQH1wicfwUT7aZV9tZXAeIB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad3ea20-4d94-45ff-e113-08d90f164f4e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 16:04:34.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cny9PnKe6Ur+rFGvh2m6IDIIYfeRl6vuO6/gJp2GUT/ic7P6807GMUwq7SKgSGY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3352
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 04, 2021 at 09:58:45AM -0400, Tony Krowiak wrote:
> 
> 
> On 5/3/21 4:33 PM, Jason Gunthorpe wrote:
> > On Mon, May 03, 2021 at 04:14:43PM -0400, Tony Krowiak wrote:
> > 
> > > This case will occur whenever a user removes the mdev
> > > by echoing a '1' into the mdev's sysfs 'remove' attribute
> > > file. I'm not sure it can be considered graceful to take away
> > > all of the crypto devices from a guest while it is running,
> > > but there is a way to process the remove callback without
> > > leaving things in a "weird, half-dead state".
> > It is acceptable to just sleep here until whatever user controlled
> > condition is resolved.
> > 
> > Jason
> 
> I suppose we could do that, but the user that tried to remove
> the mdev via its sysfs 'remove' attribute will be left sitting
> there wondering why the operation didn't complete. That
> could result in leaving the user hanging in perpetuity.

Yes.

If the driver can't implement a disconnection then that is
unavoidable. What it does today by leaking memory under user control
is not acceptable.

> IMHO, the callback should continue to return an int and
> the caller should display the error if a non-zero rc is
> returned.

Nope, there is a reason removal is not allowed to fail.. sysfs remove
isn't the only reason the mdev driver could be destroyed, the
underlying physical device could be unplugged or other things.

Drivers need to implement a proper remove.

Jason
