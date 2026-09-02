Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020124.outbound.protection.outlook.com [52.101.195.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAA440656;
	Wed,  2 Sep 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351539; cv=fail; b=iIkRNpEUHhGSN/DWPAkfgZ7KdDzgW/bqtlCWwNZM74ODkQ3HWCU4aWYF+mJq3tXOg7MklEU4YX3caLwLCLedwnl/UKdN1vOFDEZNbJUET72HeTmbSD+S6iP3cSIPCRGpqvjD55UpgADds2xnYXnDQ9FJqBcD4nGU0Jh+V40h+3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351539; c=relaxed/simple;
	bh=+wNDtvzM3d/ADXog8+g7dJ0Fp3+syWoV8y+nqSUt0c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eViIS/aLYHNzW3XUTmiQGVeyaptsUXITxFHz/XYRPvDPQJ1LZWIXzLt9rstBPe58VZhJvP0zYoIl/JIRgczXAIqcRoFhvAANb9YCZaQAFx0Rd6HbAykvBi2+CgX2dLvDYo3yvq4tF1HEWYb4gRMMVqPWuwBOgv/0BHMt56Fz+/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSmIRPkXPh2ZChb4Hg90ISyyAGSr1XhzP1O7+PKTs5Z/yx9ZW4LHkqYUjP1I3tJp3MSg+92iZps1rvISPZUih8RrC1CFsXy+Z0QXC1W7P1OO37J7cJQ3wMj4UtlT2U+4ijvWUyKQk7T0JlcDoWAmioAecBufhGSTDeh6OFpDwhelp6aNuCyk0zibDZQt93iRglAzSIAawVKkTogauH4kH072yDOodHC3PxJu/BWtETxiwgNgX0ziXxJHyVrS2l9fjlgPsFEn3r65kFsKDk8LSLAl6ULDzcEClOJaRiP4uqpbPfWVVCtTAd1vAiO3sXq7Pv2Z1eX6ZvBhZp/7c9GiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=IPggiN7nVwebrQ2mxG6QALJjUMRG/OUnAKQXUQfKONI=;
 b=gKzi6e3r9yR1qGZnKoFYxgsMjAGZC+ENR9FSpLAipUNdHIIhuQYgks0ju0aeJa7Z3ulbNGXHP63VMFgWCwzamtmkgjwJNqsdkMbFTrxpbQzMgbsJhAIJ02zIH5clxgXsfkiDxIwwwrN3cW1HnvcXvNteGoIkiE6vwVAxp7X0bVlQUEoteBQpMA/1Yax62RzEGYc0/ab1zsE20rEVNUaEcyFnkXiUNK4OZHFaGoPws37TneFtC8YFfzpz39pZYqlw+WZA9ts4DHfW8f15AD9s7yDQ4j1ysJuQch334vJ+oZ5iYzgDLOr8IalrnxA5ItsF8ghzTXgvr2KkQB92FzayPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by LOYP123MB2703.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 12:18:52 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 12:18:52 +0000
Date: Wed, 2 Sep 2026 08:18:47 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, irogers@google.com, 
	agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com
Subject: Re: [PATCH] perf test: perf stat tests fails on s390
Message-ID: <rlsu7drdktf63ciklftjzv7akwnt7v3ti7rd4bnxxjge2t36od@2epugpq6xara>
References: <20260902115218.2977412-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902115218.2977412-1-tmricht@linux.ibm.com>
X-ClientProxiedBy: BN9PR03CA0968.namprd03.prod.outlook.com
 (2603:10b6:408:109::13) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|LOYP123MB2703:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e7252e-0c4a-42c8-83fd-08df08ec595d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wKOekGtwolht+HMKresFdZSAkY5Lc6WctJmNDOlZP1oNCdh0DqnBX49EdF/FDcDqjBmDjzWU9VchUswMktV8XjSKiVSXho+drIWNEoR5vsaD9RC+zvvJ2ZqzCBSEk7pBYw7uK8AutOAHJdtdD0vZ2fUkoA+pRnd4+q5tYxLRhZdjfvVlTqs/Ev149dUbtfQr0avHIqZIN6mQn/3Uw45ElMC+TPExO6e4y83Gnru/BbPL8oRCTE/FoNDowvVrmWPgMO80908QyuXkLbaxYJL4LU1xY2fGo0FkInV74xMILmz9UlDS5YKhK5thOcVz6GO12j8OK54hnHYKvDblLyVXkUUmdg5ak8/1s3cVwaYFmTGtnPMISlGAWe1YliPJ4+ovammJ8VSSK/+SafoxAETjfYLicEX/cJI8WnraeyjCIey7J7G/+tgcqhhUkX4Hge+I5aWY7gBFmw7FImK9Nsn6y6/LoL6LGGxqwQZby6D7m1hEROcmX7+x1zQjE4b3BFsisKE5OYH6yghVs4yXlu7Fgra/TRDmBorqYiODH4aqquMAlpINS/gZ3k15iaauVmWznyorjH+Ir4LmjwXRUPoSX+C64ZbdGwPPfauLdwN3FYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEx1ck1HVnVPNXJoc3dTMitOeHB6dnlqSjNRQ2FTUkN5T3ZnM0h1RUducGJp?=
 =?utf-8?B?U1Q5ZTA2Z3JkMkRka0pobFZpRnhJajN3V3o2aTVyZlJIcVRVOVFEZ1FSaGVM?=
 =?utf-8?B?LzJkcDdWdVVxcGd5c1dueWVkOGtSU0VmMk9hT0N2T28xd2g3aUV3eDIzSU94?=
 =?utf-8?B?Y0VRcTZBUjVrRjRZblNQektLbHRmZnk4dlNLVUFMaklFK3NERmlUeG1vRWY1?=
 =?utf-8?B?SHV0NDRhQ3laMWxKOU9SelZMb1BoSGRCMmY2bEVtMTdidTd5Sk1wcVQvb1RH?=
 =?utf-8?B?cUpROVhWbUZkeGFBcGxTUFkvRDI2Ylp4UHlYSGlhdXhFR1lJRTZKakR4QWFW?=
 =?utf-8?B?OEtHOHg2MEczR2FiTTkrUEdlTGtLUkEyMG1VSnhQNE40Qk5DcW9CZ2FuQTRP?=
 =?utf-8?B?OE1iU2lVVVdRUGJWQm11NzBrT1hoQVNGUEZKMWZpNDhJQVY3QnlnYnczcmps?=
 =?utf-8?B?UWVaYzlCbkJkYXNqT1JUWTRUUDZxcUUra3hsWllpK3ZoZStUem5BYmdKQ21i?=
 =?utf-8?B?bkFpVXA3QkxIQ3d6a3lCWDdvSkdvc0h6cTNJU0htTWJQejdqQ0pnT3JsbGFt?=
 =?utf-8?B?THE0L1Uwci91TktHUTQxdHVPcjNoblVGVEN3dThuYUVDa2wvK0FqbVBDVWhz?=
 =?utf-8?B?MkdrZ09jekhmUVZrcitFQW9HcUw4Uk1IUjJibGtuV3FOSVIzVllTbW1POFY3?=
 =?utf-8?B?KzdBVDVGY21lRktFMGZvcC8vcUcxQ3k3RWx4RnRnMEIwMVcxVmlKZ1Q3amtP?=
 =?utf-8?B?dkJnYzREZ3lUTEtQbHh0d3hNbUdnN3Y5SnhOSzFneTBDK3VOaitJV3NPeVFZ?=
 =?utf-8?B?Q0tBSmJLQkQ4aTdOby9lZytKdTFvU21JRWZXVUozSGtzdkxib2YrV0tjSlZH?=
 =?utf-8?B?SUM4Y1Y2YnlxY09sR1VmUjNOaEF6a1BqK2tzV2lrSjdGdzlsR0tFMXZOL3dO?=
 =?utf-8?B?RDdId1RQV1MyazJ1VnBUU056TndYTkk3K3RkdXBPOWl0K1ZLOEtpM1FkYlJT?=
 =?utf-8?B?SnM4MHFLVG11R1VEVGZBRlhRQkVpZ2dvRVg2by9nbTBTdUY4cmg1bmphREVX?=
 =?utf-8?B?TEx4Rmk1bTkvb0pFNm5CSzJXRHRwUUxHcWFXMVZiejhJdVh1YU9oVUE4bThR?=
 =?utf-8?B?TXNDZjJWWnRtTU1FRDRrZ05ES0xGclErTFNnMlNNdEozOVg2Qk9mdTQzbzRT?=
 =?utf-8?B?RForVzUxVWlXQXRhSjZKRDV6anRuVzVVSVcwRUtyZ1FXSEJnODVoT0d1TG42?=
 =?utf-8?B?am5YVHgyd1JNRUcwcDIrZjZwWTBqWVNQUUp3d2FreVRBaDJiNEd4Z3ZDM3p4?=
 =?utf-8?B?OVdrR2I0NDJPeGdiRVlVZ1lUL01NQ1JieFhDem5pSE1VMFpFUmMwd1YxcVJs?=
 =?utf-8?B?SVI5aHpiaUJJblhmUERVUjVLM1lLVnR0K0Z6QUhTaFFiU0FnZWZSK01kdUJU?=
 =?utf-8?B?Tm42NGhYZlFLV3VGc1NCeHU0MytQWHhXQ25xNG8rSG8yd2l0Yld5Z3VkUlhR?=
 =?utf-8?B?ekZFWXVTZ1NoamV4QUFFRDBuZ1lBQ3c4cEpwNklzZDhhTlgvQ1o0REZ1dkd3?=
 =?utf-8?B?enVUSXgyOWg5MFNEUW1DMjVwQlVEcmtMZ2xKekxOSmtkaEgxWUR4SWxSVzZ6?=
 =?utf-8?B?NDRCQWp0R2JnN2hpdWVOVjh2RUx3RFU3K29JOWtacWdPQjh5Wm5URXhwcHZs?=
 =?utf-8?B?VGg4OEdTSllaaWQwZFBHb2krblpsN0VJd01GdjFLWGlOOEtPWEkvVFRtOWpo?=
 =?utf-8?B?Q0hJV1NIRkxvUDVldHBGWWlEUUJEVVZCNnVLQTRNQ3A1SHVJREZscnhhK0I5?=
 =?utf-8?B?TkJ4cVUvY2V1QTlxQUNzUFoza01TTmVYVEpXc2w1WnpFWTI0SFlIaERwVVZh?=
 =?utf-8?B?bnFtbk1SSmdLU3lkRnlBWERRcXYwVlJVZGRLbjNZSHhhRFBIdWlFeEl6dDdk?=
 =?utf-8?B?dmtRc2tIUDdpMXJzdmM1aVFqdUZWU3J6VUlFTzVYdm1EUGJFandJNXFpc043?=
 =?utf-8?B?Rk43bzJud1p0RCtGbDJNeE9LMXlLYkRJL1l2NnlSQi94OWxEam5GZ081Q00r?=
 =?utf-8?B?NjdCY0JkWWR0MFk3ZE12VmJUTnU3Ymlmb0tXMUwwRm8zb0Fub0orVENvTnpE?=
 =?utf-8?B?Z2ZKNEk3RzNpQXRNd0dQRHJ5emhHZ0RaMklKQ1F1NkJHNFlWYmlKdkhUNkdU?=
 =?utf-8?B?TkdlN2ZIZlM3MDBERDNUYStDL3NQd1NDc25SWm9jOHhJY1NXYVVCSkVxSnNk?=
 =?utf-8?B?YmlPOGNKYzVSeC9zWGZ5b2F5Zjk4VmxuMVFQK0RPL2h0WDRNRDdzWjdiZTBV?=
 =?utf-8?B?dGllL3dsOVRFVlpKMXlYUkNlSXpkUWpsUXpHQU9oYnY0YndaNWt3Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e7252e-0c4a-42c8-83fd-08df08ec595d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:18:51.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTh5kmXx2H7Vpozp19vhBS+XHqaUv3frIdIui3lbvvpregdZCwJEj7klxNk/XVtOdeeYbTrG1aEaDvs0++kM4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2703

On Wed, Sep 02, 2026 at 01:52:18PM +0200, Thomas Richter wrote:
> The test case 'perf stat tests' fails on s390 z/VM machines. The
> root cause is the unsupported CPU measurement facility on z/VM.
> Therefore the events cycles and instructions do not exist and
> are unsupported. This cause the subtest
>   Hide zero events stat test
> to fail.
> 
> Output before:
>  # perf test 116
>  116: perf stat tests  : FAILED!
> 
>  === Test Summary ===
>  Passed main tests : 0
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 1
>  List of failed tests:
>   116: perf stat tests
>  #
> 
> Output after:
>  # ./perf test 116
>  116: perf stat tests  : Ok
> 
>  === Test Summary ===
>  Passed main tests : 1
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 0
>  #
> 
> Fixes: 64724095a33f ("perf stat: Add --hide-zero-events option to suppress zero-count events")
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/stat.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 298ce454b45a..41bac99300a1 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -583,6 +583,11 @@ test_hide_zero_events_stat() {
>    # Check that --metric-only works with --hide-zero-events
>    if ! perf stat --hide-zero-events --metric-only -e instructions,cycles true > "${stat_output}" 2>&1
>    then
> +    grep -q 'No supported events found' "${stat_output}"
> +    if [ $? -eq 0 ]; then
> +      echo "Hide zero events stat test [Skipped - events not supported]"
> +      return
> +    fi
>      echo "Hide zero events stat test [Failed - metric-only command failed]"
>      err=1
>      return
> -- 
> 2.55.0
> 

Hi Thomas,

This makes sense.

However, please see the valid feedback from Sashiko [1]. Otherwise:

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

[1]: https://sashiko.dev/#/patchset/20260902115218.2977412-1-tmricht%40linux.ibm.com

Kind regards,
-- 
Aaron Tomlin
