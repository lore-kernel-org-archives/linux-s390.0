Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CFCC433B4
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345B0610FA
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhDNPE7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:04:59 -0400
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:61409
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232014AbhDNPE6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Apr 2021 11:04:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvzbWOvLf4btWdL999NatZ96Glo63s7Y3twH9sRu08MpeFjuKbh6PTceOBb6dHtWSHVZCYtFXxFl1wXlFeCrGSkFxbDSs3MsDbTCJRBKMxICjM1SdDvlrkjbLIX5z6gK9s+yE6/JfUe1lNeov3opFsZld6mpyhx6mDUegeHll8sgcCRkBGr7MG5g+Y8tX2VfDtBxgoMF3RlC0GwQOD7R1Aqbx4X2L97P/gChwn/xS2d+s6ENk9nH208M2jEQfync0WafXdPOl7umXWJ09ndGCmF/jk8s7XTB77xyOouIfgkX98Z8DFu7HWX6rDYxCyximRXigCjrjxk6wZHHp/OehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvqXuDCmEqQ7oLzLlb53kJq6sfvatWaPtnB/oihor4Q=;
 b=KVMrG93/kEzDySAoH7YmCR2/MOvWYl/Jv4AGbh9SoZd6j3A0JhD+0Z0A1X3dh81wIWwARCGFBGeXYe+L896Aktgc0KClghItODPVoXhrWgjqpXN6PcYEC67jai9I8O2ya80709lhlc6yvWKX+svMjjNyT0daMhLO0WpqFDFB5QLncaEtnoBK9ny2H22F8BHbFgrz8q8a4PL1SIxn892PrwR5kr7HzExIP5DzBXMG0ochfs/ij9gvqvvBdvgpBpakZ2Rqsno30mf0XI14mRLXI0cKu7Bl+Jb2dhXC4lmjIqxDFx4bv+K9nCK4I0B6XLbC5NCrEcGYihSS7s0WUSLHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvqXuDCmEqQ7oLzLlb53kJq6sfvatWaPtnB/oihor4Q=;
 b=i9sztO1dI66sOFgCetx8TR2N71rnx8tozmjdJwQ5LCMXGjWzi7DNtbGpRINr7F/cuwgVpPSIqp31HrCxK8QMOotSNMa8XsWSCLniYL2Ic+y/vTTjKIGiS9d3F0yWYr3a9OLSL+xPHKO5n9SoX65n8NI0+CoqzzzVX8GvVjNqQU9mSnwDUdRM2OHH3/y7eThxU08wzkwvBrOQnx2RLHUcIcCHJ6hPNcxc7kxyVtJCx1CsY0NpYImldxBtj06SMYD7nHM1z4fIE/aHfgiaMkrRlJpbpdwvikRbG/cSM7+3vTmQmiJ7s4HVDKZ/22aUNZq29+1kWtuXDdQ04TiU90uEFw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 15:03:50 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 15:03:50 +0000
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
Date:   Wed, 14 Apr 2021 11:02:58 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <6297AD92-8D0E-4BEC-8E1F-5C5AC32FA128@nvidia.com>
In-Reply-To: <87k0p5sh7h.fsf@yhuang6-desk1.ccr.corp.intel.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
 <20210413212416.3273-7-shy828301@gmail.com>
 <87k0p5sh7h.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B5CD6AA3-61A0-4FF0-8BF6-0D07909D1921_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:208:160::23) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.61.222] (216.228.112.21) by MN2PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:160::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 15:03:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94715c8-4148-4427-6c63-08d8ff5682e3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4424B073FB0B0BEF47EDE5BAC24E9@MN2PR12MB4424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkSZCzaKjTexdYDIqN55BkPwMnFMLzTB3pGEU5Kn6qqjgfOS3M7FuawEBl5Yo1aOJCJkDnGmo12yNNAOeD4oBLhROkxNsVObodoVq8R/bdu+giWOKnQANWzdKI9W9Tnml7v0VbW1sQ4fibAtDAkBLy2SJNts2X6AVdFJ2P78JrJilc72RrWX1/45sgpMRZWjyZ5L7VKmFtFkwKV7y2MsFa9EK5oBfbknjG8xXoJRnTyltixioTsC82a/eM5FsB5ssySCS8JcNo8kowluFwsqFRXKnGMJHhkT/th4dkIkxIrbflVMDWlw0Jhp9LA7MOmtRk5y0rZh37VAYzjvlsnrneEMOYh5Pw4KPP3HoWFHKxIzFMzdSmeu7urNHnlwGrISxrQ+6etFXA61XBjbhIN6VDQjQRAcEPZvr1+xEUYKtSkWsayzB/w2EDkdOQ387f+SCNjS0vBetn8WYUIgcYRV35A0KDCv0vLn/zuLOIjsH7pIRpU+y61W8bzng6r4OhDN8qRbKOfyusZtim2pbBGvBugZwXKdNikZI2LW4TtDn7Ue/Ov4UTb5VQ3bUBYT0coYjKjS/5JdKe9zS9wfgWT4DpPtpzkfOxgzXjTVz0khheMLkqho9BPUR2gWpHgb6mV2qq4wBoNCIzX9Zof18Xu2sGqg/U7L2CNxr60hvafEwks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(316002)(186003)(16576012)(5660300002)(16526019)(86362001)(6916009)(2906002)(6666004)(235185007)(83380400001)(4326008)(33656002)(38100700002)(7416002)(36756003)(53546011)(956004)(8936002)(2616005)(6486002)(478600001)(33964004)(8676002)(66476007)(26005)(66556008)(66946007)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?anlPV1N0bVFsQ2NUejEydUdDUlpNd1ZJajdZc1dJMW9ZQjdFcDA0TUoxazY4?=
 =?utf-8?B?U3pUR3lHMjdCMkhPQzJESFRZM2FZTzZIa1FWNDYxaWozUTVMK2xSV2hJRXZy?=
 =?utf-8?B?RGRneXR4M3RwZHpnK1VDTFJxWW9mMEhOQ1N3ODR5bStKcXRBNEhmWm8xaVA0?=
 =?utf-8?B?REZ3UUpPenYreCtST01UZi91dFIvZFYwdUwxTmlTL25tT25FRmd3T1NkU0JM?=
 =?utf-8?B?ZHZZSzNmcGNybW9jTldTTGhUNTdxNkNNRGZXMHorMXpqMVpxclBFYzhtaDQ1?=
 =?utf-8?B?SWFVay91Zm9mN0htK3JZYXBMaC96Y29uMU0ycU5nUTVkYTJxdFpxSmFRYi80?=
 =?utf-8?B?RlNUQzVlSTV5TTA1dnVKMzRLd1c1NUIyRWlXNjR5bitZWFk0TzF1YWNLbUpG?=
 =?utf-8?B?d0JWbnZwK0dYUFFBa1VEZXVYUWxHOFNSZlVzUWI4N21vRTh1S0NkTVNmdk9h?=
 =?utf-8?B?cE5ST1BYbW50eEs5OFV3TE9RTU43Mnc2TktsR3hxQ1gvZ3FNclByZnJkcWxJ?=
 =?utf-8?B?K1VLTkdVMGhvRytQN3plTFBSWVkrRTJHNlg2bEV1Y1hHRTRDTWUzbkFmaElG?=
 =?utf-8?B?SVhsTXZZQWhjVEZheGNQN3ovVDJEZERCQUhad2hnTnBZc2dyT05nMUhadExl?=
 =?utf-8?B?Y2JHMnVwM1RNb2tXbW1Zazl4TTV0aFZBWlJrZmVVOHRVQ0diVnJCcVZ2bk1r?=
 =?utf-8?B?UDlpNHBGeEV6R0FTS0l3ZTFDWWxtVHA5MU9YNTE5VkRraXp0Rk9mUXg3Ly9T?=
 =?utf-8?B?UFhiOGk5ZURRbmJONGdpVEcyejBkMjZDcGZtVUVRMFBrS1JFalVCZ2tJb3p3?=
 =?utf-8?B?Nm5ZMGdDbk9oSkdFeEJtZFU3YS8rTmswQWVvZTdUL1ExalRjdU9qR2Y5TmNG?=
 =?utf-8?B?Y2FnUG5qWm5WdDJjZGx4YlNiRVNCZEQxcFIyWnBlbzE1NTlkOTgwQUZ2anNs?=
 =?utf-8?B?REpneEhyWDJsbXhNejYxdDRFZmR1bVZ0aHlwUGFFZlgwQ2tTaU1nRzNMZU15?=
 =?utf-8?B?Lzh3QjhBYWJ6OWNuVmVtZHpQSjZ6VmtReDVxazJoQUVGUDlXNTJSbmlZd1I3?=
 =?utf-8?B?N25OMzhBWGVVYnBHNzUydjJCcEU5aFY5Vml5eEFSZndvOVdUZ3FDUmFIM1RL?=
 =?utf-8?B?UmZjL2lUU21jMVJrWVJ5S3NidmVoVnlaVDdwVW92UjlDdjc2N25uZG8vbXBZ?=
 =?utf-8?B?SG1WSDREZ053WXlRZy8rbnJtRTVkQ3ZwWUVSVG1UMDl6S1RYSHdwdGdwQ2Jm?=
 =?utf-8?B?QXJuSGJrZFdZQmp2ZG9vL3lkdGpPYU9jUWlLMlBZTXE1eWJ3MEYvc0liT093?=
 =?utf-8?B?TmRGcmJiNDRNVm0zaWFrQ1ZFVVI3eTBqSEJEOHRDTGtDN29IQnNuNHN4ay9O?=
 =?utf-8?B?NGcrL1NMUThoTXVEQnd1NjMzcjlCMTRENytVeVpLRTJhYnMwNjlSUHFXS09R?=
 =?utf-8?B?VnRDcUFnNHJabU5MRjFGNTRVdDdQa01lVFJvSVBSb3lad0o3UjVCSTYyZUdS?=
 =?utf-8?B?SFFYSHRjZGtQc3EwaklER1kyQVlRLzd2bWRRdjU2dWRYc1ppTStnN01uUTI4?=
 =?utf-8?B?OHl0QU8yVHh6dW5hUzc2NUxIKzFvZUlTdnFWMWV0OVhDZG9JWVdXYlBCbWxm?=
 =?utf-8?B?VUZFY2hWeXlvL0c4UVVqRFA3cHRJamRZZExSMkIxOEk2Qy8vYXVJZlFXYS8v?=
 =?utf-8?B?U2dkb25rNGNlYUtHcitnUlNTOE9rWmxJaUg3bkpGVmhueDFUTXBrbVFQRlo5?=
 =?utf-8?Q?MSE2mf7MhL1m+monQa90r4R+H2tnWvctHa0aA2c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94715c8-4148-4427-6c63-08d8ff5682e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 15:03:50.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkTDv1r8M0KMjytKQB2XbNA7vriWNO0/kCXii2p5jCsCyMW8yHr5XKZmmweuYdfY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--=_MailMate_B5CD6AA3-61A0-4FF0-8BF6-0D07909D1921_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 13 Apr 2021, at 23:00, Huang, Ying wrote:

> Yang Shi <shy828301@gmail.com> writes:
>
>> The generic migration path will check refcount, so no need check refco=
unt here.
>> But the old code actually prevents from migrating shared THP (mapped b=
y multiple
>> processes), so bail out early if mapcount is > 1 to keep the behavior.=

>
> What prevents us from migrating shared THP?  If no, why not just remove=

> the old refcount checking?

If two or more processes are in different NUMA nodes, a THP shared by the=
m can be
migrated back and forth between NUMA nodes, which is quite costly. Unless=
 we have
a better way of figuring out a good location for such pages to reduce the=
 number
of migration, it might be better not to move them, right?

>
> Best Regards,
> Huang, Ying
>
>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>> ---
>>  mm/migrate.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a72994c68ec6..dc7cc7f3a124 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2067,6 +2067,10 @@ static int numamigrate_isolate_page(pg_data_t *=
pgdat, struct page *page)
>>
>>  	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
>>
>> +	/* Do not migrate THP mapped by multiple processes */
>> +	if (PageTransHuge(page) && page_mapcount(page) > 1)
>> +		return 0;
>> +
>>  	/* Avoid migrating to a node that is nearly full */
>>  	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
>>  		return 0;
>> @@ -2074,18 +2078,6 @@ static int numamigrate_isolate_page(pg_data_t *=
pgdat, struct page *page)
>>  	if (isolate_lru_page(page))
>>  		return 0;
>>
>> -	/*
>> -	 * migrate_misplaced_transhuge_page() skips page migration's usual
>> -	 * check on page_count(), so we must do it here, now that the page
>> -	 * has been isolated: a GUP pin, or any other pin, prevents migratio=
n.
>> -	 * The expected page count is 3: 1 for page's mapcount and 1 for the=

>> -	 * caller's pin and 1 for the reference taken by isolate_lru_page().=

>> -	 */
>> -	if (PageTransHuge(page) && page_count(page) !=3D 3) {
>> -		putback_lru_page(page);
>> -		return 0;
>> -	}
>> -
>>  	page_lru =3D page_is_file_lru(page);
>>  	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
>>  				thp_nr_pages(page));


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_B5CD6AA3-61A0-4FF0-8BF6-0D07909D1921_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmB3BCIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKkHMP/jSOHoqrybKlCx1WQ8xcXNWFP6rw+sR4P8+Z
jeoGZ424T0QUUYhnPL1zakTT5RGLG9GCCufZEABL+8Muqjg+DiIXBsZMdR0+FOa6
XcnQjLVQEeZK68F4ro1yxjNyTq0pJ4EgtK+juZpAC6J1knoy5ESOiv16NLfLcKcJ
EiBOn6rG1zvkzpfXnFgH13UOxlZ6H8mSqc7CYUPRV2q940V2vWTJHZBfmjI8IiqW
Bd0TwNd9xLkI+dwwR4GIVNEtIHb/41aD8+c2B3H23cQcWvVSTjG4XROUz5X2T1vJ
Uw+d+S3pOlS4+5n/AVKZaqddzlHWBdpGlkUmFFX9NXKBzL56v9w3sYQX9u1/363R
jqi5lSpSSJn67IzZbvVpGZ9Mm5hQaeIcHNdhxr2CbIAEREdlIIHwAagQy5qBt2Wf
JGbroZnKHgBlR5M7Ez2wDrfYSmk2IA6bjGZKLR4EGFBX/ZpxiYY1WlKvrFyvXVbU
XBvfHi/B8gAg3yW0tzdWEGCFd0HlSyLhbwnk54wBMrbXxyYq8mz0+t74SGaWHUA7
g9LXoS+YwAKdFhj/3xEA7txcYcpZHrRGl+EG4+r61I7BNFDfCYs0ObBKN1z1giyV
C6RIQ1tfY+L+EddhNZWT/uy9w+h+PWUEQAwikL+FR35QiqGVAKiFv09oSTzf3gvy
zYYKUJpx
=0+qD
-----END PGP SIGNATURE-----

--=_MailMate_B5CD6AA3-61A0-4FF0-8BF6-0D07909D1921_=--
