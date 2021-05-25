Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE6AC2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F80A6141B
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhEYN3Q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 09:29:16 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:39232
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233409AbhEYN2H (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 09:28:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdeVVfxUWncXh5Vzrk0iRDgBApyUs8nUsY/Y97uf8OKHlzczNqDNRc3TgfZVTco5zZ15XT+qBoCJYX0FH8h5GhoPrgvw9ttrxnU43UUuMNYgHsxPOK34jR6ZoFtIaeDuv6/pf/wq70O38P1WiM069LNQfQmNFpUhrEpE9dCHh/c4NQUer6IuC0xpcNqNB39nPkmPT920FlK/+1fQAGQbyPxDRbje4LharYmCA/Lrq1EkKKBhuJYBnnT7MNocKlopoIwd2Lwdzi/BngFXsPSMnKqlMLtA0eeS6E2pMO939j6/oZ15v9YF6/NySmm+6YS2wuUusZzedSDodDZPHTj7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Estf+jZ+jFoqd7CO1bC52rr2DkRvXMp9Wl/YF9W6M4M=;
 b=TXqreeKmZfUhKKOjqP9AcGZJWOcavOexhcYfe/F2dSCcyDv8mputd0fujQkZWhyqGoi8Jd4RlOdLv7ff7ljtcY7CslNpzW3gnjezYHLmr3q+31zS711BH11oQO6rSPgakhAK2WHChhRAmid0A8oaAc5cgH5GhfEz6u9K3in/nyeVUnCiju2izPAaCfjBbeA6x3XSfOrLr4RnBqYiNcHUDdtO0Ip3ZUyBP5RRPGfzg0FEEYuTRiso4qascXOMPuHiHxnxXCrB3ujnupemNjbhqgcDvfSOtUs8hwLhBmsP5YXiVxhmh23gbtFL4iQnM782dSca5BEje+smvIVpOaT42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Estf+jZ+jFoqd7CO1bC52rr2DkRvXMp9Wl/YF9W6M4M=;
 b=acGD/tOmifDy7km6U3OXm8ypWkpZjGjvPAI1j4u6ciLj1H1QVNtH2zBum1AEER+5RrlM9wO6YBraXza8U5CvM/8/M2tmf0ew039Mdo0wWbn43OD93jzc33fUBaGJsudZEc8YN9a5dFTm4SK2NZovCjnqtqargCbSYYqkC2WFrzuxc4Pi/OL8ZYSIuM3IMEVRs3H54LlsSBNrPII1mzgL23Klr7xyDlcZFzMOit518VYmyCuyg/h7kP2W97UL3Xrber4y4lGo3GznYsZTkPCFtVNkcz9YBWpTujAHpvUvMAZsTQistyY0+VP5gwoNMmEim+UXMUGQV3bzVKIn9kPQ5g==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 13:26:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 13:26:30 +0000
Date:   Tue, 25 May 2021 10:26:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Jason J. Herne" <jjherne@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210525132628.GX1002214@nvidia.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <20df4cd0-7859-4727-42bd-9ef419455039@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20df4cd0-7859-4727-42bd-9ef419455039@linux.ibm.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:610:54::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:610:54::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 13:26:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llX4m-00ED4n-VV; Tue, 25 May 2021 10:26:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07df59e2-2bfe-4210-e629-08d91f80b4f5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51911CA3BDCE94EFD0C45F9EC2259@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DWVxV0vn7b++cr0uB/tYywt5zEver72T6vGcIsUkguecD3vajvrQNjFBCyZXHz+A/cScIz4aXBEGV8nyetpYeHwDphu1C7anl7BCsVCi04eGA2jBhIrz3wGJwQaegIv9pJ+SJm5h63XN2QbzNXSCYMIgjdmomGmyJlNcW+rClis5WnIfZSHo+pt9npNC/w54XtmKRXPocxc5XAxRf2afuiV32L3iJWeS5DXr4qiKDYva2ykvTqMbJ1Jk6JIcdubo5R5NPo6PYD5AJ2j70ZDTO+H6uwsc8IqwJqfjAXB28vvsolYaEEbvl5UkZCfZSNhKIArBT6V0EfISVwVpPeuHX6FsMAlWx2iJwQ8eGuBbOEaNSZGhwpj1C6NkU5QUXEdSdftFKHUfgIRxsEnRUAOXaME8hw2l6UJdAi6K1rEAfODTqjfvVfSyTTvNCeZ9KXopp5kL1itkNlhUV1gW5m/UXTBHfL/TWF2NVhipLVKu8ebVjvgfxDE21Tr0Egy5FQKNiyb2SDFqu/u02lULY5TKsSpGWREyd6W3nuKnbln7chEWrAHtenNpYEpAvpYpvJOgquZ2qnL2A+LHkaKDHARWd/T+QyaIyBLvutebKluYPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(1076003)(7416002)(66946007)(316002)(36756003)(2906002)(26005)(5660300002)(186003)(83380400001)(2616005)(8936002)(86362001)(558084003)(6916009)(66476007)(426003)(9746002)(9786002)(66556008)(478600001)(33656002)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D9RB51QHtuxUAqCvu7RF3r2cJQiDX9E1hp8Nu19GtRj9nqbK9C6PWeYPWWbY?=
 =?us-ascii?Q?puHKEcTxUp1RbyJXMJxYgfm7PQT0VHZyA254qF/P0u/fJXyMRfJUjzYvxnPf?=
 =?us-ascii?Q?OxM+AwvfPyPkbfyGmLTfIKStAQ3Ae9bjvmioj95cXp/aGx6e31aRW7Y65v8w?=
 =?us-ascii?Q?ThKmYXNszSRrEcr4InooQob+SuerJOLtWEBNqC+LSKQu1peiITQA2vklpYln?=
 =?us-ascii?Q?b5FCN7S/PtyxGKk9tpgKUFVRptWLuPxSPvqpdVpJz6KQCv6KwZS5LmB/WzXU?=
 =?us-ascii?Q?eYY6gTTIfHsLdo4SZrpWyXnuPKTHvMEiv5iH5eAqQ83GTqpgigMcAUVtNDXr?=
 =?us-ascii?Q?r9HiiQwkFvQtvVpX732zmYTCCRlFO9tqX7o9K/35ir2w7UcW8wZM2mY8VWv5?=
 =?us-ascii?Q?FDDDlPfPqgpcC0sU+cAa3d+ZNIyxw1J+kvloR3yim6io7mSj1wZnoQbqMDks?=
 =?us-ascii?Q?2dG/bzKHbqX/HXwDcB5UovK+CfAgTkejE8cCXIpl9ISWqZj0cybN+jAfE6nq?=
 =?us-ascii?Q?tWDKJTumtCWDHC6zooHQscA+jQuT1z/l+w073DxAph24uRujwF9PLuKhVgjE?=
 =?us-ascii?Q?MoF3tNvONCO+Z2ayvU8C83QzbuUTxiNdl1hNSYyXMNgPEM8+w9NNQKS2A75p?=
 =?us-ascii?Q?Gpzf+tGBTwfA9Tw7lDBFNN4b+TGOy52krScDWUlDh+AVZ0VQUR7RmK9/S5u+?=
 =?us-ascii?Q?DZ86zhUbQAoU9a3kS9+OvxqIkVEmlUgAaQWuuXoRpfFLzuRsAv5JEI/mUjtz?=
 =?us-ascii?Q?TZlilALG/YKwTBEJUFuNEX8z05/HRSCEyiLre0RvmtCd14jVTjx0jwmjzuxN?=
 =?us-ascii?Q?TkVX0+wiLy9knu1gVsA9+JLibBnp05w3lkQTTwOQLgUUoGVBn200yYy4K4dj?=
 =?us-ascii?Q?YNvR4OA+QlnQcSc9z6BqSgMVTFRLT1RKB/1At4qVLZ+xARAPVEL5ih3Arg2S?=
 =?us-ascii?Q?v8KHLKHf6e8/4RUOBI1/5WQ3o6rseUsl51tdHQbYEVumc5Jb7768RIhltJdO?=
 =?us-ascii?Q?aOQoVRmaoZTDhgRA+wzwjO0RpWNQnb5HcokUXudizvj4ZnTbXt9xL+FeV3k/?=
 =?us-ascii?Q?RwMtxPmG4hExQpGrqoAfEpMiXBoTkxcIWFgpB22cz03OjwY7lFBGD3X6+Cc7?=
 =?us-ascii?Q?dsGkSY2PHLD6aJb9Q1lI1LmEoINkVQejrzFp9+fdQZllG4l4PtkBjYk/XjuF?=
 =?us-ascii?Q?JwBC7/rBdbCTdR4XWGJ5pFgSuvwN0xyj7ey64jPtG39MH8sOOb9DiwCFHXLY?=
 =?us-ascii?Q?2m1AlsOMN1b+om4WtxNU4fy2Lft0yTnBQeZNMKM8iD0i9BR/6DwbDiTPHisT?=
 =?us-ascii?Q?mjK/Fn6/3EK9wZ235R91M3K1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07df59e2-2bfe-4210-e629-08d91f80b4f5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 13:26:30.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZqEAXG4xT+4CsOj15P0bi+uxPFPIp91Hcb+eCiXUEteLy1s1r1yUCc/lWs81/e+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 09:24:59AM -0400, Jason J. Herne wrote:
> change the function pointer to point to vfio_ap_ops:handle_pqap(). When we
> unload the module we change the function pointer back to the stub.  The
> updates should be atomic operations so no lock needed, right?

No

Jason
