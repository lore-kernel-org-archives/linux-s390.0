Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012018.outbound.protection.outlook.com [52.101.71.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B829B206;
	Tue, 24 Jun 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771493; cv=fail; b=m0H5tusMEt5GHNjMcN2Ms9KzmhJevexPdj7/0qDA2IgSqDZJaKBVERfqX14C+jmE/DmoEWZ3A8QBV5jJG4+ZjPdb/t4Jpdykfp7sir3P7nNHrmATOqYQV6fhO+DiCyWQfm4Nzxsh0RFZk/GpxbBVO3tKMqXQMABs5DGn550NkFY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771493; c=relaxed/simple;
	bh=J8KK9tv1sA6Q9bBtz2A3k6BaUP95msTZG4pjx9+DpsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=egUPJQqPqgdL6g9v4G4UNDYjPegnUsPHY+DANKWeYpDDcABGEKiUWvy8Q3GRRdCuCiOBlxaf1eJkA5n28gY2JFJ19OAZEma3dGSZ1pbG9Q4qKqh2u3KeGrjvWFIc+bhc8czwVLkZdWpw0b8uOtWHWwTCJNOCTVCMZG1gzmQakyA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jqJGzqIg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jqJGzqIg; arc=fail smtp.client-ip=52.101.71.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jqJGzqIg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jqJGzqIg"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=N5nk5jC7/35uqH8VaY8b+yNX+AFlfRRdaE69Fq27TYkQdGO9WExc6aUrw+yVMNRVcBIKGY7WcP84V/nW9ZBZhXUXyZZPYkC9++rg9hH1EgS3faqy1ja/Z2Vko6rKA028vPrdofTd0kQf6iCthg7RooziRRTgGfZ6UJKlxNOKFJnT0pHhSLXisEbmUKIKI/Qhw19Kl7Z+xMLx34Nfag7rhtPIBm2zkxpUzezPfWZa4003l8jOb7mPwonHlSnRugqAOv4IY/Di1joAIuItKdmbA+9WzqrxV8pzK1wzKIaQtOH86qCiSOV36rwxCJA0v3yAhZ6vF/3TQCHhCoEPywUloA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8KK9tv1sA6Q9bBtz2A3k6BaUP95msTZG4pjx9+DpsE=;
 b=LX4eVYCDNmAavvrvqpIMWbBok1/W9pfhc2aP0gIyr0/3vD/XxcPsWGM8D6VfZ5Cm2t6WIVRt/QRmpIyxdz+Rs1j9MDKgi7klDWVnKlP9SspvOkcjlD2K+0hQHCPcCC/YXYgbRjWYDgXElEuLrgoMp7ItbZ/QjywYz1NV9wcE9bqZQDxbYodo55OzSF4VgEIobLEt0bCsV4f0hnvoktSn+pMmiFrjh6RfAe4WdKnhCTTUiEiPlHj9lSuVymHHItlAS7PqMhrhxrdoyd1ZzKXfzHefcnQ+8unnGpjE8x/x25NxwBAe1HIhaURXcut5jBt+dbUC2nNZXwgFPHMfrPkwAg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kvack.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8KK9tv1sA6Q9bBtz2A3k6BaUP95msTZG4pjx9+DpsE=;
 b=jqJGzqIg26blpAqxb1H7jgkHqhPMlGaZLsw27Ya6pru54WMsDQqM1O47FRxFaoCBOQV3Hvy8vQ3igUk+8oy2ZJGnxJYUY4cLY3k0YqwhLVz7ZqVdLsJQ2e7QtZL1l0VUUbGO1HKcUMiV+lwQNNJ4ehjMltz/C2QXyyNVaNyWTpc=
Received: from DB8P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::20)
 by AS4PR08MB7580.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 13:24:47 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::91) by DB8P191CA0010.outlook.office365.com
 (2603:10a6:10:130::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 13:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Tue, 24 Jun 2025 13:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHLdYeWk9+IPKS2jcMfPm0+MDiCgASqp1uadF6R1lShxyFfcoRhR7nq9kqanQuW+sRRbaF0w4DycgNfwVdYCM1CyFxR6r2m4MDrFiee88DUuP9Q6sKiBA+Zf09fFEiRFYytt+8fRqnhp43bipaP/B2zAFnWJitNYu5HW+ZfKjNJboNwjTK9M/mxHnk6qUOLy1hhk11BmN9L4IQMX1BR2ccWMr2Z3z3IctCtxMwC2UFJRV9cHYPKwCo9b5NOJc/B+/7BFRRIDj+M72Alnypuf7ltU5o9THbqdI+tfW8Cz9xkxcauesOqtthhmmMukIUHlVdDO0jpH20raFFfcq1LCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8KK9tv1sA6Q9bBtz2A3k6BaUP95msTZG4pjx9+DpsE=;
 b=mevIhqp1h5FFgaXqwd/q/Y+pRWQXfyhLyI6xd72gOWWmnvtavPGmO6kFWH1YL1AaoBB66M4R9bn4xY8K1u9f88cRKxgsv720WllgooR5zvvIQdODQlgA27xFs4/cPodpITXplmcNwmpo3v+i7b8VOxUciyqkMCBS9vTtk/59KzAncgMbzti9uclnn4SutHOAMzugB+Jqp05Ja0d2VnZuA85FTKz7tLDzll2q9nU02i0ZWmy50xtoAfnrdOxhbv5KYWI96C8EhJszkzhor/ci8Cx2N6HEKR2+Gk1BmtV7C51nCx7oQ0P4Lc5v/5B5E9sw6bvLcmpZYmJkj7I/zf1elA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8KK9tv1sA6Q9bBtz2A3k6BaUP95msTZG4pjx9+DpsE=;
 b=jqJGzqIg26blpAqxb1H7jgkHqhPMlGaZLsw27Ya6pru54WMsDQqM1O47FRxFaoCBOQV3Hvy8vQ3igUk+8oy2ZJGnxJYUY4cLY3k0YqwhLVz7ZqVdLsJQ2e7QtZL1l0VUUbGO1HKcUMiV+lwQNNJ4ehjMltz/C2QXyyNVaNyWTpc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB8741.eurprd08.prod.outlook.com (2603:10a6:150:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 13:24:13 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:24:12 +0000
Message-ID: <520527db-a18b-4903-b262-2318cdf06c35@arm.com>
Date: Tue, 24 Jun 2025 18:54:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/ptdump: Take the memory hotplug lock inside
 ptdump_walk_pgd()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
References: <20250620052427.2092093-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250620052427.2092093-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::18) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB8741:EE_|DU2PEPF00028D0E:EE_|AS4PR08MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: a156d524-0692-40b2-a65c-08ddb3227ced
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NWJRWnJ6M0NKWUtuNVQwTDZ5ZW5rWmZLc0J3UDUvS2xVRHYvOVNCRGkyZ0Jz?=
 =?utf-8?B?TEg1cmovV0VUTGJXZmdHTjJ3RDA0OEFmM2ZPTm44MllUSUZad2xJY2pEN3Ny?=
 =?utf-8?B?SzQzNFVTZ1Z2ZzlJLzc1TFZnd040NFR0Y3k5K21rWm1xejlEUVp5QnBCd2sx?=
 =?utf-8?B?VVp0dnNOSHRqVFQrK2FOTU5sait4aHpZQlZoQzZDSWVnL2R0bmp2OWRseGk0?=
 =?utf-8?B?cVJrZm9PSzlaSXZOTitxamtnVVI0cjgwbkl0U3ZvQ3JMR3g1eGk5K0JESGc0?=
 =?utf-8?B?TiswK1JKdDAyNW5CT0k5WmduUnFGanJmcnhINTNUeGJpVDVDeDZOYlV6Q21M?=
 =?utf-8?B?RURkaHBJLzhjRUV1L2tna2R2WDkrWTZneVQxQm9CRkNrMFhxVllvSXhrVVpP?=
 =?utf-8?B?NnQyRHZ2OTJ4Ujk1SCtSVGEyT0JUQjRXTE5QM2IxNUUzZ3pPTnhReGJ6TUJx?=
 =?utf-8?B?SGZvNTJMSHJSMjFZRUs5azJMblRKTnpMMjNrdlNHakhSSEZFMGhyWWtVYVM5?=
 =?utf-8?B?VGI1NGdaZ1B2S1ZxVkZUdWdXOGcyNk14M0hrd21WZmF0V3A1b2V3aTNIaGZw?=
 =?utf-8?B?UWU1Mml4NDVGQ3NjT1hWQTR3bnJFUXZUNlRIZEhTSWdLLy9yc25vTzlFeWQw?=
 =?utf-8?B?SXphaVlWUUZTUjlrb0dKb2tEc1NJWkI3YUJoVHo1MEQrWWgrVDFKL1RKdnpH?=
 =?utf-8?B?RFh2UUdNbVRaQklMdzBmQmhCNldVK2VQR2VSZng3NUhmNXZOU0dGQllQZkxH?=
 =?utf-8?B?cm1oSklXY1JGaFlsOVFwOTljeVd5MTVBaUprYzNtdE8vS01KZFRwK0hVSjZr?=
 =?utf-8?B?Y2s4NVVURFkraEM1T0dNTndQdjJoaU01dURTMjlLbkowQWpPWG56WERLYS9X?=
 =?utf-8?B?ZlMvU2JhV2hyMmRLR3RKcElBcnk1MHFrMmkwSzlKR1VBSHZDb0xFcTJML1dV?=
 =?utf-8?B?SUU4KzNsYzFSbnBxT1Zod2tNdzJKV2ZzYzRRS3BCbTQ0MWxaZEdsUDAxQkF4?=
 =?utf-8?B?T1VueWlxQk5xZ2hsdGJTNDAwaUJyUURZNFlhWDRLSWJHa0xpRjRoQzhVbll4?=
 =?utf-8?B?MHhoWEhaQmtTU3ZQaWhlWEtLSlhFbEZDNEdRb2V0dGhFQmJnOVBKVEd2TWFP?=
 =?utf-8?B?V0w1U0FLTE5LRGR3Nmt6aHdzalVrdWpnV1lWTGcwNmJidGMwS21YNmNuVS9h?=
 =?utf-8?B?ZzVjOGV2Y0tXaE0xT2NTTjY1YzRLclJDM0d2R1U0K3FIQzBOSk4wcm95bjI4?=
 =?utf-8?B?ODlOUitQNE1yb2xHcXdRMTNwc0NHOTEvdTNjQ1lWV3dpdldWdEN6bkUzL2tO?=
 =?utf-8?B?dDVteVYxTFZZYzNPUVpBT2RaeGd1QlJVb0lMZk84NUdkdHhkU3ErRG5PS2Fz?=
 =?utf-8?B?MnNhK0s0SlRDYXN6eUo1ZGhHS2VmaWdYVVhlWnBxUEVmbExUYStUVmxZOERv?=
 =?utf-8?B?NzQ1ZVQ0bG9GdjR6YjJSeDJUcW9VYk0zekxscmI5SG1XU2gvZTdNbmtCS1Q4?=
 =?utf-8?B?c1BQQURnNEJDZG50d01GOXl6RDRGN09MYzRtQStaTGdITVdrK1pCUitxNzgv?=
 =?utf-8?B?MGtwd0pwc0hEeFZEREFVRHJJVVJGeW9ZSVlYRkxadjNnZVJweG55WERJRG5n?=
 =?utf-8?B?UE5YOGhoR1Q3SENyaXpjT0hGdGUvQitNaElSUDdFSG12M3BxQlJnUzNPaVIr?=
 =?utf-8?B?bjhPZFc3MWlxZTY0WHJPd0ZBdEgxU1UrSFdGc3kvUERSVTdhU2ZIUm4wSy8z?=
 =?utf-8?B?TEQwRGJSdzFTRjNlQnhPZEpwV3QydkxMWTh4TFBzdkw5QnIzdm42MlFzZnBS?=
 =?utf-8?B?bEp3NWoyOS94N01kczAyR1FqU1J3cHFucHV6d0svZGhPZXgxRW40VGRna0ZW?=
 =?utf-8?B?OVRSZ0xSMDc0TGNMN3JXODJwelI4Wnk5WThPa2kzZHUxb2hYM3NOaENBbEgx?=
 =?utf-8?Q?R/BnBULFHSU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8741
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	765dc446-b949-44af-8b47-08ddb32268b3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|14060799003|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnlZaFZMZi8xUktWeXhYdTJBSHdRTnhRalVuWEh2a3c3OFhNcDRHUUxXMTlw?=
 =?utf-8?B?WjNseFNOTVg2WnNuZmt6Umo5TCtLcXBONm14OUc3Vy9Vc1BOekFIdFY2RVYw?=
 =?utf-8?B?RHZLNVUyV2oyRktyS21TOENQL0hJM3ovU0p5bDFSWmhkRi92ZnJDRXNKb1VW?=
 =?utf-8?B?UWVaYWVFcVk1Z0JFYjlKbjFqUjVqQVdwV1p5K3NMTTZrRXAxWUtpZG9kRHNM?=
 =?utf-8?B?eWNXd2pKclZ1NzNtWFA2WnZ6aG9zQUdXZVVFR2cxZ0FlSUhnTzVpYW96WUUx?=
 =?utf-8?B?UTlqSk05cjJieU5ZYUR6RENYUTgybzgzWk84NklSZHh1VGNQQnlDRnNlN0F0?=
 =?utf-8?B?YTMzK2ZYaDdmLzZSVTFLRFF5b2htaTNEdkk5YTViNUhTYmZ6MDRNd0lPZGFO?=
 =?utf-8?B?ZTlLb2VrTVVRd2JkcDRoRGFJOVFDMkRWbU9DRzA0cko4SnFqSjJDaS9Nc0M5?=
 =?utf-8?B?cU1FOVo5eS9pc3o3UGxlMlNlUllGWW1iM1p6aHM0UWtBT1d0TkkxWnlPTmFh?=
 =?utf-8?B?NExRendaVlRDRnhnS1RuYmlPbU1mdCtFREQrQTJjTzBPd3d2Q3dibDhLNDNj?=
 =?utf-8?B?bHN1T2tmY1JGR0c3bHdKVEI5MjBBNEkzM2NHNGNaem5BQklEbmwwUWp2bUVa?=
 =?utf-8?B?ZlpTUzBOSGhFWitQUko2QnpXVXM5K3B1em5UZE1iV09vRTRKcmFNemU4elVC?=
 =?utf-8?B?b0hKblQyUi9KbmI4NDV4YjRiY0JqVUJXVnNUWE92TDFxK2RsTExJWGZQUmNm?=
 =?utf-8?B?N2t6cE1xb2lCUW9iTnd3L3VhVVZNd2J6VDZtU1FLeC9pczZISmZ4OG9HTENY?=
 =?utf-8?B?NUIzTFFjUnlHdUZLZ1U3WXJBZUJ6MC81NUprRjNNNWVNNzd3aTRDT0ZjdThn?=
 =?utf-8?B?OXZLQVJtWnJNc0I1b0p2YkRnSFgyODdYN0QxZTV6RjIxL2xEOGxDZ205RUpD?=
 =?utf-8?B?YXFYQndFM0J2MDRwblZQTENKaVJCaVNBYndwNlBFbm81dFlKdzQydmFMWTJz?=
 =?utf-8?B?RmV5Qm96cStmc2Q2NXhxRFVjNDhKRzdOUHZiMzVZd1JjbFp2S0xoTHFiTVV6?=
 =?utf-8?B?aklBNHhuVVpHbXM4TWtrQWF3enJMRlZiM0x5RWRDTVJ6SzlWNERmSlJYWXU2?=
 =?utf-8?B?bWJmYWpvZHo2eGZZcFNpNE9FcWNlcjNaQ0hxOUc0cU1VNnRuTkgzTloyaWNW?=
 =?utf-8?B?MUZ2YlM3Mmk3NlhzMUFiYVh5aVlOblhzcUdlRnpReVpkeHhEQlBPcytGOGFP?=
 =?utf-8?B?R0tjL2tFMFlnZGlIajRuZDFMU1ZNQkxiS0F0bUdWazk1K29PUmVITFFUR25u?=
 =?utf-8?B?ZURVNU03RE5kV3BEcng2ejVzY0svUzIvU1lFend5cUdGQXM1Y1E1OVNrbmRs?=
 =?utf-8?B?QktIeWs1Z0NBbkkydlB5VkpCRlhQMEFONmMyaWJncnZjWTVPcFJxWWdIOHIv?=
 =?utf-8?B?cmxjbUtmeUY0VWR3MEhWMEh2QmhORURrekpsOFpxOHJxY1pEcW9TMUVrdU94?=
 =?utf-8?B?MXE0TGdQT0RzYVVyMm9Zc0doWDU3NnFjMnZMWENSNGZ1STkvbFdYQWEwcDQ2?=
 =?utf-8?B?SmtqdS9COUNTVitmNUxWdFV3dEhGcTcxcHJuQTVjV1AwR1V4RDZJZy9MS2pS?=
 =?utf-8?B?eUtna1RDcUplQ1JKSnpnMkdra1BOazBQNSswSmVtdGxuZGFkcGFuR21oMS9q?=
 =?utf-8?B?Z2M5dVFVbnNub2hDR2ZYSEo0VlAxY2hsYktzVkFMZFk4Nk5TQW1tMEpZa0Mz?=
 =?utf-8?B?a01tU2xhb0hEWW1KVnlRQXdrOWxCa1Q3dXQ4UlZuakdlNC9DQlNzSXpmMExC?=
 =?utf-8?B?VE13dy9CUDh2cHRueEJBWWxsWXUvellVdnBSTXNmaW85NVVHWkZ2UTR2TVRC?=
 =?utf-8?B?WkNMMGd5YklXSFFveHB2YytOQWRERlpoRWRwWnFMQmN5VEJUTHNoU0pSVExX?=
 =?utf-8?B?bkhkWTd1SEpHQUVUVUZUS0lnNGtkcmVGSHA0OWY3bjR6cUZjaTRvTVkzbXo4?=
 =?utf-8?B?SVBZK3FKMjM2ZE1QUTZ4QnQrcDNhb1VubzJEcEk3RVIySU9WMmhOL0p2MGlM?=
 =?utf-8?Q?2w1DSa?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(14060799003)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:24:46.1713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a156d524-0692-40b2-a65c-08ddb3227ced
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7580


On 20/06/25 10:54 am, Anshuman Khandual wrote:
> Memory hot remove unmaps and tears down various kernel page table regions
> as required. The ptdump code can race with concurrent modifications of the
> kernel page tables. When leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
>
> But when intermediate levels of kernel page table are freed, the dump code
> will continue to use memory that has been freed and potentially reallocated
> for another purpose. In such cases, the ptdump code may dereference bogus
> addresses, leading to a number of potential problems.
>
> To avoid the above mentioned race condition, platforms such as arm64, riscv
> and s390 take memory hotplug lock, while dumping kernel page table via the
> sysfs interface /sys/kernel/debug/kernel_page_tables.
>
> Similar race condition exists while checking for pages that might have been
> marked W+X via /sys/kernel/debug/kernel_page_tables/check_wx_pages which in
> turn calls ptdump_check_wx(). Instead of solving this race condition again,
> let's just move the memory hotplug lock inside generic ptdump_check_wx()
> which will benefit both the scenarios.
>
> Drop get_online_mems() and put_online_mems() combination from all existing
> platform ptdump code paths.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>

