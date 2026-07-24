Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FDA422E36;
	Fri, 24 Jul 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889366; cv=fail; b=uqvk+pGWFt33GDa7fEIt/wSDMSuq5W9q+hXQbaDFlTAZgtCS8fhi8wtco4V1i2Ty1S8/o84sYmRnMrKal9oUHy8m7hDUVp10Rpb32pYx8fprBnV4JjY6LfzjTMEsOR5xXIqGTBFfAkDq+0o+ookgVbqDw45oqCyUi9NlBxCPlbU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889366; c=relaxed/simple;
	bh=8iUSk3OSyZIQlBVe2NeXsKT0eEX/CExH0vHXjWX+GZQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=teOLd0oIwapSDepwx266OKaX0KIUp9rEtgwYSrSJyBRc4FoeAc4VsUG0w38Q1gn1Gt2k+vPA0d5kTTa0AMD2I33V9B47IGv7KAdsOvE/f1kELEAo+z/gtPuYQp3wphJ/ZwXjw5GsERY+DMuu4UlmmHqPcCeQsnfijmpUs2XMZdw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YQWi9t6t; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YQWi9t6t; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YQWi9t6t";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YQWi9t6t"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=R3XDlnhI3+1wtopVXltAZRJUxix0nmZjGYp/PdiqIxEn+GEZS1Zmdc2w0ojFWeIC4EdyKJHi2wFR48IUmvxFKlODjA1mfOI2/S9j20FlQL4L+IY4hTXGLUeuGyDkBvt4tJKFDgSjFhU/+pwAuTbjkkYRTlCxmfa9xRvd52xs9Q08k+xDhLFz5BVaEbwQ07FGneGDYYzRILkDsxFpV1N2IAyqE7uDBuVpGRU9NShFFmXlhHsW3qQhjJcQUdwYukidYDKlRfSJj647UhYXB0OCupqFEXJGPPCBEPzCLWhvvgX8btj2IXQ9lfMSOkEsUViAcIKDc47xUaiBg6crkQmRDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkWBEsmxBMA3JWnTNBH694W+L9zBhhhKMHgg9fjEfsA=;
 b=RNoOBeOOqVOmYMdoQrVsSJBBn3Hz41MpFvy3dzXH0kLzWo2pvZptkU62MRWSrZYBum5RS7k2MNSOLS52T/gjfQtmexGJSMphAhw9VT9dJ6qMG57pZdnvbla2hswo54OPO7RTirMzJRl4sBi6mDktnAB4Cp8dzabTrLTwfsoIOhtluvk2Eo3WnEjIVVyT0kQXH2faaWVUhErhSPTdhnU/yMPXcFfARNJmXqKVJt9kdJ8RlslwJ9E1Ndct40x9baf8U2CtY5EmRqUGbKZXG0FT+vZZOmZnNDap05pgBaxG36NUKZFDfPuIf68BxNxJN4NzLKEzFTB6EQLBtBmHftN6iA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkWBEsmxBMA3JWnTNBH694W+L9zBhhhKMHgg9fjEfsA=;
 b=YQWi9t6tZEwFVAtPeBGHd6GVtO32lDsIGOfm8AqjuvoPpaXmWyDZELKEjGhYDdGn/X0Bxgf+iT84x+PbC0MZjx9nKQhPK+uOReIEeWmYHitAhRsajp5CgBBiNKSdrbiLNysg7t+PHoL7dap2+T0RxyBHTgKWPFnudopF088eOc4=
Received: from DB8PR04CA0001.eurprd04.prod.outlook.com (2603:10a6:10:110::11)
 by DB9PR08MB11461.eurprd08.prod.outlook.com (2603:10a6:10:608::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 10:35:57 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::96) by DB8PR04CA0001.outlook.office365.com
 (2603:10a6:10:110::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 10:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 24 Jul 2026 10:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euXcwNIxuarTaxxewu2GYAzkI8fH1O0JRlRBcrUMXsqAq1scuuRGhqjA8gC2OxAA4IX4gCYBRYnsCfn9fq/hEmbCnMJGX4q5EmVYYToPT5Gzyyn3lNLv2f36TOEszeZ45gv8D3wurUysQAwWf6hbiMSVmDylKHOiXdCyPl0qCGdxE2YO8rokz4ldycPGLGBQg2UxH4V49IVfCuOcyqxyTzbPwjp4X0EdIZgMsB1TCmj0ValowIhN4vzi16HM9Z7alUBTkUMYZ4GY9AWTZri2658x7W6nkrfFLNRWiyZ19QxtjjlBxr+50DvZizDVTjTRXcpE6iIgBBZqzqg7oUS1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkWBEsmxBMA3JWnTNBH694W+L9zBhhhKMHgg9fjEfsA=;
 b=TAZGIhM/TdqP/3ztPmnIWTsXBS3rE50uHHZiUQRQ344Dl1lLw2+p0P/KyBdjPiJWED77U8m3yGm3sDqOMvgLEaExU950pNbO6bAlyYwZcpOaV1m2ebFtt4bY/nAHyD/HS/5q8tUeN4Wx7ycakWXTO9bh7se4Ms3kQSBooZP+Tq2l5PjjM2q6BCmRcEOmXAkQd2B2JWpw0l+9RwOKhhRiLO/D36VzYgA+3onTD7GsirLyEi48NtHvRmttz7WiUkSXivbhuPv8h6cT3R0tZBh2OUWZTxJIuY9djnMeDgbJpjJUJK2CoH3cg3+sWoZvVF4Zifyyd/dB85t8Hf+zn7IGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkWBEsmxBMA3JWnTNBH694W+L9zBhhhKMHgg9fjEfsA=;
 b=YQWi9t6tZEwFVAtPeBGHd6GVtO32lDsIGOfm8AqjuvoPpaXmWyDZELKEjGhYDdGn/X0Bxgf+iT84x+PbC0MZjx9nKQhPK+uOReIEeWmYHitAhRsajp5CgBBiNKSdrbiLNysg7t+PHoL7dap2+T0RxyBHTgKWPFnudopF088eOc4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by GVXPR08MB11448.eurprd08.prod.outlook.com (2603:10a6:150:2c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 10:34:54 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 10:34:54 +0000
Message-ID: <67ee9da4-cbf9-40d1-92c7-49710fb15f1d@arm.com>
Date: Fri, 24 Jul 2026 11:34:52 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, "David Hildenbrand (Arm)" <david@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, linux-s390@vger.kernel.org
Subject: Re: mm: opaque hardware page-table entry handles
To: Pedro Falcato <pfalcato@suse.de>
References: <74182e50-b54f-4d2d-a27f-3a59a538d6bc@arm.com>
 <31d36023-d728-4eee-90f8-158c7066f565@kernel.org>
 <e22407d8-4509-4a53-9ba4-491b9d5c5ef7@arm.com>
 <4bfeb697-9c1f-4316-96bb-9bfd66f959df@kernel.org>
 <6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com>
 <20260721124057.2820903Adf-agordeev@linux.ibm.com>
 <3c21586c-0ffe-4ebc-97f1-803e8acfc5c1@arm.com>
 <716f73c1-41cc-48a5-b0e1-a47403a30da1@kernel.org>
 <47b4e62e-b001-465c-9c3b-ea0636925387@arm.com>
 <amMvuPZ0tglCoi1M@pedro-suse.lan>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <amMvuPZ0tglCoi1M@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|GVXPR08MB11448:EE_|DB1PEPF000509FB:EE_|DB9PR08MB11461:EE_
X-MS-Office365-Filtering-Correlation-Id: af072100-b024-4022-cab4-08dee96f5915
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 A2r4vmhvtFj9EXLiSdRY1spsyBl6Xy/8v7pGhuEI1xLaiNVWJm16OeQgVy1wrOxmMnaMhBCawylGvKodAknJsd66LptVR9QOknmAur1QgHQYRSbLsQCrDsQbSWGug6BK60eV2cRJa4tNiYizE7dh4uplrHU/VWXoGVUfIwUfa85QN3RUjFtyMBsl7BH/Y00IE29NvtOxkEKRYzbmf/YJQgOaT90y4xpgILkyf24mPO5kWI8EaGsPacr/K6QD3fpaZTHuqUWBUy4jut05aB2BTlSmO79bgRa8Nhw2M9464liTx5AkZ7wLezpH/fuwiSMfJI+g6x7qkj0uJUJc/v2VrtMkmIG8RSUUWWUVxKRAEf+wvVnJYJuDCngXLLd38MApDWEWlOJ2e4q5RcAMTiRyU6w1850Tzyb4TVHlloUWn0qjHPKdDJPszgz2C8hvDXXVKlTagGeOPL7VGxbW9Yl3hNlFFwZJOuedJAwSd0r9mlwBWRWlHuluu3eo9NMGA0AMqT7S7R3b6F/2i1uJHAG9QF+0izub1nd01PWx31NwFmLPsjMs6KCJTb4gjZiNwji7HRb18K9hd6cRRQ2ENNpbWmGlYmYGnOnOcoSGfhtguTc0qDG/WwlvFGGiNEyRVsd+pa3WScgX/lIWolRoDKydrzOTMP0QNfYcyaW+y0RjaDw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ArHLBD2S854XboqsVLnZ2czD1UAL5tdWYRC5wfcaNYlzDd+viHENSP6DftCSFgHU+zhjZfScwH2SVceMzqrP7YX6oGU863Tw3ISXNq6KLT2N3o7+yLBFw5ENeS2JoVhkjPj7haVRvFpUjNLAwNbWMQ/eFVzEI0waloDxnzC2t0SK0ulq9/svmP1FCVoRginHbWx9GmlQeKUdXxwyu4x0wr3G3eISR5Hbvpzwlo2c9VxMki7HtgBIyJSc5w1HemT94C/tizzf7tSu23Agjt7vFoEQrOMgJ0rOZMUPdn23wrlruSaJNUE746K3x/zL5ab4FahcrW2kUv8oZ4Sz3ADNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11448
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	69443013-fd42-4f8f-a986-08dee96f32ff
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|35042699022|23010399003|14060799003|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3lhdaNvxyBnPlSZ8VIAW19AFQPF8mZ46MFCdfb9a3GjPCvJiPLjwQNxPjDWXBr4Rxamg3xUlMl8UjkbrRrNmutOw/+ABLAM2FaERLYS1OHyS9FD9yK5MXm7tO8p7QL41WyMOGgY88PVwYAS1wp8OZjZBBc3VEF/B4tQnvl9xbgfGFt1EYjTG2NGS2ZlZGrmO7A7X8pnhgwgN+PaX6rWKi/Ok7fWrSnK0ctd/Z2B5MtEj/ZzWfxVk5ycbAi97f87Zz356wyE58Wchqmfivgz/t8KDBnVgUQ2lwViVZaSTCcVsOrZgZqpGj2Pcz+tJoGRRLBXES7O8pwzURR118OmSHXFzaEtjc6O5tAWUd6+2NHSUGIh8dVNK6q9CdnfpI95SsbT+265hXoAQAYkNHwQnCAYPxUKbi8sZ4oNGZ0BapnY76dVZuI79z9wQc2kFT1glMyZQXmml5TdZ4pdQScDE7VlDli0NcTaf2gdVKYfTYtMB9nWaTAKH5kJFpH9maDurIjaUm973zP4YpRVgtYMBuv71hrPWUw+82mJpQ/JWNl2xP9xl8hU9gd+G6tdFMuh0drGleDweNGZ8uFkYWumjSRIK3N5FH/gGwStNCloRi8wTcjMOiZr6k3D3/LaQDCILkczioRxIuu14rFNmho4RXGpE8w9lfUMJ6gWgK5ZH1gHLPqpKnU9lE4JIcEy4H4InP+FvaBmPMsvYJBvCq0VqvQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(35042699022)(23010399003)(14060799003)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b7vTL8BHwNOTxKYLplXbrPWfjX34rWPneVdy2O10zqsoxxSBa3HtGWTSzF4N30Z1w1PO1GU8hY/WNzwk7LcLgX+6drtxOxHqUEf5mq61e6JbOGva/mXsEHeApx8N5eBcPABem1FZ0PPbAkMYv4fhr3jRV8HlZuXJ2ggt5UBQopEdVU/ndsTzz+5FAPW2rM3l0Y5BSk5zD1t2xYguDkDy7ZM2PXFoiMParkYn43YJAQN7R4QfHBJzQcg/rA9To6IVX9wm5xpEvIQ5XolaglCcr7fFmZFbPolJT3xELwx5inBLokKiRWNF40dwXwYd0C8K4RH7ks0K8vRb3a0hmoIpcGbqSxMb+bM3ekdEisMh1za3SmNqkhqdJUKjqlQb+9Hlq/Bsf3HuPbik76+uAnvTTS9ljG4Dvhc8W4DHamXDL7RuYdi6QBNy9qdzddi2sIni
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 10:35:57.7408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af072100-b024-4022-cab4-08dee96f5915
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11461

On 24/07/2026 10:30 am, Pedro Falcato wrote:
> On Thu, Jul 23, 2026 at 06:01:49PM +0100, Muhammad Usama Anjum wrote:
>> On 23/07/2026 5:38 pm, David Hildenbrand (Arm) wrote:
>>>
>>>> So after the conversion, it doesn't makes sense to keep STRICT_MM_TYPECHECKS
>>>> around. Please correct me if I'm wrong.
>>>>
>>>> This brings another thing in my mind that in ideal world we would just
>>>> turn STRICT_MM_TYPECHECKS on for all arches all the time. But the problem
>>>> with it is that STRICT_MM_TYPECHECKS defines pte_t which will stay double
>>>> meaning still. So we want sort of STRICT_MM_TYPECHECKS with different name
>>>> and separate stack and hardware types.
>>>
>>> I think STRICT_MM_TYPECHECKS is also to avoid catching when passing a pte_t into
>>> a function that consumes a pmd_t, and vice versa.
>>>
>>> STRICT_MM_TYPECHECKS makes the compiler generate worse code today, which is why
>>> we don't enable it always.
>>>
>>>>
>>>>>
>>>>> We would like to keep it, and I guess some other architectures too.
>>>> David had summarized it well. We'll convert generic code to use hw_p*_t
>>>> types which would be typedef to p*_t for those architectures which don't
>>>> care about. But if an architecture wants to interpret these types
>>>> differently or want to make sure the type is enforced and not directly
>>>> dereferenced, they need to convert the arch code a well. But it can be
>>>> done slowly.
>>>
>>> I think what Alexander meant is: they want to keep STRICT_MM_TYPECHECKS (or
>>> something that achieves something similar :) ). So as long as that keeps on
>>> working, all good :)
>> Thank you for clarifying.
>>
>> It has been a month since I started this discussion. We don't have any
>> disagreement on it. Should I proceed to post first part patch series considering
>> most people must already have viewed these emails and are on-board with it?
> 
> Besides the vague disagreement I have (about whether this is worth it or
> not), I have an actual objection: I've been doing some constifying of pte_t*
> for various reasons lately, and something that just just came up is how
> hw_ptep will _not_ work with const, unless you do something like
> const_hw_ptep, in which case welcome to Win32 programming or something :|
> 
> (I'm assuming the idea still is typedef struct { pte_t *pte; } hw_ptep;)
We have moved on from this as it was very disruptive. Now we envision the
following:

typedef struct {pte_t __pte;} hw_pte_t;

With this, const wouldn't be a problem.

> 
> Have you tried sparse instead?
We want to ensure safety during compile time. Without going into more detail,
more features would be build on top of this type conversion. 

-- 
Thanks,
Usama

