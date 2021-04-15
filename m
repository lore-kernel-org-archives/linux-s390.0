Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789FEC433ED
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4897261152
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 18:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhDOS6U (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:58:20 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:43745
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234130AbhDOS6U (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Apr 2021 14:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbbkxfGXT1eP7fqslMI+7VAO5E0Dycy3XszlPk+8rQp5CSUa22OydodwvTjra9zne07CiPWiiCV4IC9HuLAQAsJ2wgmdLFG57AWpIAdWMkiqO2YzQ7gGTRNkeFhEQhTnoGao3nmQiCWoICJyZLtaEuNjhUYAV6A4R6Y9COYjFpHm7Ztgj+EwVPxj6FE8j5TDXIoeP8NZo8w+tRATPwKccasQ6kOUwwVLsmhk3C5K1t3prBwjfRMH+hCb2qQzoY64AQmAdfI7oeQYq4BRzvyrw+ZU5e8apf0SOxyq5PRoxPY0pbA6MOr3EXkB1+wFuBwjW660h/ctw3NkZX7YiyTAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J62YH5FCCUUVcuCNooTtMaBPvjqxUUPixH96BCCHLpU=;
 b=JbGFH4nX2kCJXczn7o2r0wubrFCqjAl9afuy5rsBZDtOrmCvVw8w7Znr3LPQ1A7SDjRYPq6q9JpxrTY7AGMjv0TSuIUm42Sa2hJq4hU5wQmW4QO3VyAQgOxmc496fDIWp+EsGitqK4d36YMxyWlkV4GnP91V9TTLE9hpjYwm2LMe+QDHDwctcUinks+RIAFYhKXozYruhJK7NYIsYwN+GKzkhaBmnSsxiwZmp5pEB2hLwnT7w0bBWrR0/KfctulO5cEy7kny5gn8WI/fEWh4Awq1rA84JtZ0ccX61Jtudgj6RqhgcJk/QnWg0pcCXTtbHb6RX4P3sWm2E/ZTsUtWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J62YH5FCCUUVcuCNooTtMaBPvjqxUUPixH96BCCHLpU=;
 b=q8G/PQH/eGrkCEHN9/dFPNmQ3LwdHSkFnRUcZDnqHZILLufQha2dQh6diBBAMc1yuGDme7Hf9lvdXFwx6KUM6yBWgPLLPtTvUm2yRK1FKdZsZys9cIm1Ga6JBcclF9P9Uws1D8x5VB5CzUbxwVujg5xkzw6uoTPa3zMYDx8fZGDPFvVtozEN4QoHDipEv+x7ixIBq4aGFHI3esZkyEEJz1iE7yrMlda7dmtEDdtHWV68sLsdvFl7/CTfrC3KfkQjYBlqz/IAd+CiYG3Qy1GYqrGs7dQFIYc0j2OfS6TJs4dSn40fUZn6yg0cwIAPogRTtnoxlqSSiwbcIZPO7jNM5g==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3917.namprd12.prod.outlook.com (2603:10b6:208:166::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 15 Apr
 2021 18:57:55 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 18:57:55 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     "Yang Shi" <shy828301@gmail.com>, mgorman@suse.de,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 6/7] mm: migrate: check mapcount for THP instead of ref
 count
Date:   Thu, 15 Apr 2021 14:57:48 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <F357B0CC-B7A4-4140-9009-BD0A5B551F0F@nvidia.com>
In-Reply-To: <87fszsoxjx.fsf@yhuang6-desk1.ccr.corp.intel.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
 <20210413212416.3273-7-shy828301@gmail.com>
 <87k0p5sh7h.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <6297AD92-8D0E-4BEC-8E1F-5C5AC32FA128@nvidia.com>
 <87fszsoxjx.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A9A8390C-48C0-4277-8E16-F772BEBD8DDB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.61.222] (216.228.112.21) by MN2PR06CA0019.namprd06.prod.outlook.com (2603:10b6:208:23d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Thu, 15 Apr 2021 18:57:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ecb6acb-4a58-4d73-2f38-08d900406072
X-MS-TrafficTypeDiagnostic: MN2PR12MB3917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3917991FC56C8975CBE12D80C24D9@MN2PR12MB3917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51Fytv3yfcMlWrQRb+1+jz54TiY85G4+pCGUvdrk3iRob8JkARMq6Y0yhjEjhztmPAoFZ5aLg4Wp5m4iUKQ0RRfEY2nDZXg/PUqczlIFM7pKfK9aZQaVqaui0sJj3YQmzCfoLiDcArXwlvkeYXDZJpCPO8V0EBn64Z/UjpQMj8bCMPJ/pjMDQ79DcXcd1rsP7QIXSzF4F4l0uwFrYcuG4lBaOkFTMslHVdeyA03fWL4NGADR/pwDXUG9jWerMdA5RmyJeqrv5iIWCqyGZ5sH3QawmT1nDXeE9btktQP01uaNAdEfFjD/wpWxCoBGJb0OoKf0G+gov16HrKJqtvDlmYq/iiv1qB1C5qOUqp7cuJpEJqQgJvqYCiMQt1Js5fW1klz3fvNdjttzokN4BV0PT8G2/+8yUX8goWY+5vmwEoHNL0Yq7fjbKU8UKU9dghJgajte5YrLDs6WUdOUTkWPHR8WjTOClvO8ygKYAWbNSAE4K6KcxBT+STunnasHoUAIyh4nODLYV3mcr8Tw4pGWRmHh2YHaQmyum/2kHMd8n3tSxklhIsuJVhJLGZtuPERAd8DMGg+WDNuuGg0EKg77Mv8ZllEj/2X1+UsEPsp7zYW4F18TCe1u3tESvAG48Lfc8J1MR/AnAzRyLNNLLZmcu07JYgh0kkIxMStx+e5PWcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(6916009)(33656002)(33964004)(38100700002)(6486002)(16576012)(956004)(36756003)(2616005)(16526019)(186003)(316002)(2906002)(26005)(5660300002)(7416002)(66946007)(8676002)(6666004)(66556008)(478600001)(66476007)(53546011)(8936002)(235185007)(4326008)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bFN3bTJEQWZBeDFGbjU1YUZCeFJpMWRiT2RrQzQ3V1BjWkY0Q0NVb2h5Z1E1?=
 =?utf-8?B?QnJJVCt5akFINVY3aEc4cVY5cGsrMFBYaUlJbEJJNzQrUTR2UFJOMnFpVkE4?=
 =?utf-8?B?alZpNW80UzlVQU1nWTZDT3FmNFY5V1RITWdlM3JIQVFiRjdMdDV3emNld2pK?=
 =?utf-8?B?cmUvb3dGai9CVUdrMndhQ3pseUtzQ2Q5Z2Rtb0VqZVc0SFYvK2cxYThaTHhl?=
 =?utf-8?B?ZE5La2VyQWs0K1BZazc0TGQ0c1pHQ3VoejNOL0xGeVlzL29peHM1bDVwY3VV?=
 =?utf-8?B?aTFGY0pFdXRSS2NRRUFhUm1ndDJrYnRKc0ZJWjRTOXBiejBDc3Z5WEtCQndL?=
 =?utf-8?B?b3ozWHdhU1JiUTRZTVY3cEFDN3pkTHRFVlhtOWZHVm5RV1k4VGRiMzNGbEc0?=
 =?utf-8?B?aWl3M0R3YUdxRVRjOXRZZXlKTERHcHlLb2M0OCszLy9CT2dkaW5KSTl5WUR5?=
 =?utf-8?B?bTNFdUJSQ2ZYc0tLMExuWUI5aktEWnErVzVOOTdaVnppUVp2NXFOOFZocnJG?=
 =?utf-8?B?Wm9yZ2JKNytnUUNaOXgrMHd5aTl1ZTNrSkR1TXpOb0FhVG91c2laNExBM3hE?=
 =?utf-8?B?SnV6UUxCTWluUkxpVlc2OFZ1RXhxdEM0NWJsV0xFUUF6YUh1UWtNZFVOd3ZG?=
 =?utf-8?B?SFRrdG93OHExVFJGV1NITE9qT1BNYmord1Fheks5NDU0djZmelFDYlcydFdy?=
 =?utf-8?B?WFNEUm5mR3JXUzZ0OEZmNnpPcnl2eW4wMEtLeHJCUCs1R1NLbmZVeWdJc3RM?=
 =?utf-8?B?TG9tdVRmNkU5NW1NMWZpZ01TSEJRU3ZtQzdYaERONy9WbkF4Z3h3VGJHaWJi?=
 =?utf-8?B?aE96dFpBZUJQeEUyVWpZcERHOEdPd2VaZHg3ZHp3eC9uR2RCUXRpbmZMWXBa?=
 =?utf-8?B?YW5vOGlFVlgzQ2lrdFFXZ2pCTHhMRVdZVE0zOXdmZGZsWGtNNjJLd0VGWDI5?=
 =?utf-8?B?ck96MmFBdmZTQTMwdHRMV2NmOHp6L1BYSWlUM21tUlJMZXRPY2w0eWVYUGhm?=
 =?utf-8?B?TTdGNCtWdFVzaVVQdTVETXZveHdLUU5JS0xzUkJreURqaDhycXlhWFQvVU96?=
 =?utf-8?B?VzhWaElnam1vYjFQRUR3SEFhQnVNV29XZ3kvOHdBQTdyNU56aXpVZWpQRTE3?=
 =?utf-8?B?L1lWV1lSeC9yNUFmOUU5Yk9ZUWJxTGdqTkFjU0dwQlpCMHllZnYyejZ1N0l3?=
 =?utf-8?B?SlhucDZHR2lKYVBROTRsaWpYdVhGcjJYY2pHT3lMSk50VitEZFIvRTl1SmNv?=
 =?utf-8?B?aE9pd05LQk1qRFBYTVV2aHFqRDEzWU04eTZ2RUcxVExjdnVOMHR3RWxCa1Z0?=
 =?utf-8?B?R3dla0pzdFlWVGN6MWROZkJaR3k0VkVtbEd1L1RRVkJzVVBFUHBEaGxaQTJ1?=
 =?utf-8?B?bHk2cHRHVkozcExiUmoyU01jMUxMRDdrdTc2THZSVG1PbXdVdEFOMEtJaGVG?=
 =?utf-8?B?aGFYTGFsL3IyUzcxQ2U1K0tZOFN0RHpwaWp4bnRrV1hqTS9vd0RMczhDdDNs?=
 =?utf-8?B?L08yRjQrUjdrbE9xVjUrbEkvYWg4V0xiQm44QUh3L1l0K241ZUtRZzJrdk5F?=
 =?utf-8?B?L25iSGtGbGMzOENxTFlPUWszQ083dC9UeTJ5SDh4US94MGdIOGFaRFlmdjNK?=
 =?utf-8?B?Nm1tSTFjRmxwbDhkWFhZWXExV0NlWXphMDVWbkpGWDM0Z3A5UXk5b0FFclZL?=
 =?utf-8?B?YmRpN1N0K056aThLYnNuZytBWXc2OWdUNWVQQTNxWnJYTDhPdlVyTy9hbVJq?=
 =?utf-8?Q?Ga7A32ZushowxGHgJRc88u2wXaQDEOzuSEbMzhx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecb6acb-4a58-4d73-2f38-08d900406072
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 18:57:54.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xVUKyqemOrW4gZgVPsUxCJYiL1sbVh3oscDDYBGBomz2HtvmW0DuhbpH7R3eXuT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--=_MailMate_A9A8390C-48C0-4277-8E16-F772BEBD8DDB_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 15 Apr 2021, at 2:45, Huang, Ying wrote:

> "Zi Yan" <ziy@nvidia.com> writes:
>
>> On 13 Apr 2021, at 23:00, Huang, Ying wrote:
>>
>>> Yang Shi <shy828301@gmail.com> writes:
>>>
>>>> The generic migration path will check refcount, so no need check ref=
count here.
>>>> But the old code actually prevents from migrating shared THP (mapped=
 by multiple
>>>> processes), so bail out early if mapcount is > 1 to keep the behavio=
r.
>>>
>>> What prevents us from migrating shared THP?  If no, why not just remo=
ve
>>> the old refcount checking?
>>
>> If two or more processes are in different NUMA nodes, a THP shared by =
them can be
>> migrated back and forth between NUMA nodes, which is quite costly. Unl=
ess we have
>> a better way of figuring out a good location for such pages to reduce =
the number
>> of migration, it might be better not to move them, right?
>>
>
> Some mechanism has been provided in should_numa_migrate_memory() to
> identify the shared pages from the private pages.  Do you find it
> doesn't work well in some situations?
>
> The multiple threads in one process which run on different NUMA nodes
> may share pages too.  So it isn't a good solution to exclude pages
> shared by multiple processes.

After recheck the patch, it seems that no shared THP migration here is a =
side effect
of the original page_count check, which might not be intended and be wort=
h fixing.
But Yang just want to solve one problem, simplifying THP NUMA migration,
at a time. Maybe a separate patch would be better for both discussing and=
 fixing this problem.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_A9A8390C-48C0-4277-8E16-F772BEBD8DDB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmB4jKwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKrBoQAIAt05chzW6ZndajzF8MaiWJNj4ZthIGAQFq
NkboCE7r5XME2kIH/Phx4oiEcTLOFdeo2R8n0nAbE+RAqj9GpYowbqF6sd7DU28u
qTN1yivWe+tw41LVnwLslN9yAURSx7BJU/Wqg9c5bId/YvpVdqOXNdD/5Flbepw3
ZigLJiJXcnijEEHEzAEiOD/LqfuZTSNgsWGQ3ZFDsn7vJa004P1mVQWVv1rzNaeA
vGlbFytXhQ7zusiVlbhk8wejc3Eqb3m7Mlt7ZRHR+9+W4acf3NAz/ckMPfyFrq/R
qfVfnRM6zX3RnWNLdltHZjEEHdHvK4IjHEmBFmxj1QusR7jTyPYq+RBX/sIFTiDU
I3+XG/gtV6fKW9sXpRtbufaRwOuJ2AcRYp0rjdnUxd4jWn68VlAGHvXpJ+bI6iKv
fwmBTRVn0zOYxlTI18YpeeUBf2uujabRjTwzdoLM4Oxe45m5zuHmCuwL1ssERu1X
NEtDJyJiqx9NrDpr4XyDWIpCj1d00M3ZrHPD4EnykkBY31lFa3D+ERXfdDFwIhdD
mANO0C7fC1Js2FLoJWTgjceciOqBmoERW/97gNlBjj2HNdn9fkZ+qU1h5KdC7RqJ
EiH0GGyqrprDBvQSXOby8URyKUxb+jrRfIV3Y3W0q09IY2jbkoImfDJ/0m1GLxjj
jrX5+M8a
=PV8A
-----END PGP SIGNATURE-----

--=_MailMate_A9A8390C-48C0-4277-8E16-F772BEBD8DDB_=--
