Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168A563FDB;
	Thu, 15 Oct 2026 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088029; cv=fail; b=f5GdlPVDkjWn3zQrxYLqI0V6VwD+wpB5ww0pLdDoyM+KGzca3nSWXIaLqskkJ7H4PZqCyc16NcJvxscLdG5k2buQexPiFEsgadqL7U6Oq1GZ4zRBXyutgApDzaJs8GukLHrrUsBv1xGWLuRRwq4dxIX5gWs2AM/2NHq2YiBhYbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088029; c=relaxed/simple;
	bh=haQXwOd7zdSrHNgq/1iy+JAxCpsYQL00njrEgTmLPHE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D5WzCUxqG1CdN45q4s7MPmF9PusfZa5pNjcaRW9IbWh4mqDtmJGocjBZ731XRgDG+FepPh9tJGRvCkLu9My3apNZMtppBoIPwy0LQA0Qt+cYbdipoIyoGZbz88XSA3yngYSoFz/INZD536Aawhlr4BBsbnPRTPRkn9JoMr6DQtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTDH38sz; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTDH38sz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANNLSsak0rGMHr7LK/HNh03H/TrD2iAzZAqbrsyNrntyqUWOs29LXHVpdqN9Q71zvnrmJ0/T690TMxSl2Nizr8Cd1TiAnO5L533JH5nD+snCY5uGhq93YrTjC/F9IEQTEkYtv48HIxnEt1/BkgCrzeSRqLmNWgk+wgpENlootrEFl0fea0kPBkliELy6eB9bFpdMdNz3dwSOv2Xpa9rY1yRRzZxSNcy9D+bqlcVv/W9xSC8muwbZGqVkwjkCOXfP448w40xKnd6dk+oaaETOFDGljtrROoSzqriucMStKIiNyacfEmXpTrprfJDQbPtpCO29Kg+azQ+fbP59NXerpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RPmnAaQPjZe+jzEtzDeDLZQt7rc6Dj+85hXtD5gVDo=;
 b=Zq1fYgSpbOoR6agCQSf5HlyhOGtjlZkjV1EYY0DqRtobNsxlvVNDEna7JpPclV/rOiouUsEgM8TGb3tRSGeBFgc0QFqDLwPB0JAs0r/KRaEvBeSiOl/p3cOfMj7Dnfqq3JL3LJoI/SQOloGi5wjK+kTFxNNQ5mYkHnQdKD3ZIQmcTZ1g75/aMu+i0KYr0nbzphcj9tqcI1dTvqNow5gvUxKUSTXN0ketIPHrlu2KjI8koTsK87/X3B7tzOWETy6Cpuv2lWkDHdt40N20o32zsgcxWS5CXolRTgRizQTO3zA80WqdzlWXJQ9SUeRdkdhdcSPR4EtQuYNsDsPsSNzDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RPmnAaQPjZe+jzEtzDeDLZQt7rc6Dj+85hXtD5gVDo=;
 b=UTDH38szc/WAFXA6AriE4OqJA1GEqJBcFVufB+A81EBvCt4drfBMip0ZYxBuHlHqi27968PRd3NmHR/sIhhYfHi2e8HNtZGYGh61uL1FNg0Mw9bQ2QEjKaCedY7gWzpcsMWaX8Q54KKfDjn/hOw0esLTzaEOM+wSEUsOJ6p6fCLQ5ki3VsfQAEXDKGTN93r/Y4mjxCqeAtP220LmoSS8afNQXTQ40MLY/X5SOUdIJKXIRmIRIsC2y1YQyM2zOzvogX2fJgwUsxBa1vkDoIv4jUyRu7rDzQejPJRV6bTjQd32Rc1+E2l6444XTiMm7HMUZShRlFpdjlharjJYYCmfwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 18:13:19 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Thu, 15 Oct 2026
 18:13:19 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 15 Oct 2026 14:13:04 -0400
Subject: [PATCH for 7.4-rc2+ 4/7] s390/mm: always clear _SEGMENT_ENTRY_READ
 in pmdp_invalidate()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-anon_vma_uaf_fix-v1-4-7b977303b42b@nvidia.com>
References: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
In-Reply-To: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Kyle Zeng <kylebot@openai.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, linux-s390@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: YQBPR0101CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::31) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 9092811e-ae93-42e0-7098-08df2ae7fdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MDPTr7kna1Bf0y9OCBJ1usa5u4YO/bnVRDGpvKvZEMJN02uNNonYOf7kAdHwU4GSiGyJumitbEfLawNhIfB+1pS0Jc7Mh3toLqfK1G/6SUKJlJFL7IrmT0DNrNQMrYDEI8FD2jXtM4U8PmYnJCExpzaWDCajMALlXnKbTZH9FDhOsllCZt4fveFjKGy8uAgahATel/rja1viRYA2zLGJqIMftmv91g4RCSK9eyiY/m/LvwF88TJQXDzhYEBNrd8VHzOO+yajalmwldAYmzO+vlbas1LSeBo2OZLYCIpsPLQzgk6gbvUs1TcW97jwhF3F+i/1P2jgGO2ndulr1S1aXm/9XB9QSwsMqZeKxUp/+OgV9EhP9YR7rahJiWp5+Un7dNM5n3FiJmWFAMI0LQHY6P8gpO5byQHtDyS4WrwVKAA0HIMZC/JBW0l4dS246Y1W0JMdf4IbHfAx1BUBrGbKO517NW0fAOnq8pGSJtxwZsyzUwt989Fyrwy2xMoYUxLRkywzIoSRrFBYPfyunuIJ7SNt9D7U9IeUr87CXu+WGqHoS/61e8TfyNl4DLitAcRDBR6RY7mvbGMKtUUafgj+rsNvER/h3iBGt9QOzCsh6qKs0jRZkMD8PlPh1WVCKvt6HLAQOyQQwRXt+VJCDA3BaQBGWxwF1QNCvaeoCi4snUOb41zxGBcYMME1Ao1xdO1j4JjwgdlYcljM2yADePYYWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXdDbUJXQnh2UzRRT0haYi9XN3NlQ3FtbjJxTnZSYStQOEZxbTJjZ2MwYzZX?=
 =?utf-8?B?RHdEdFd2STMxNUt0aHk3V0dmZjRNQzVIM3B1ZjZ0S1lXazJuODV3cHE3UFBY?=
 =?utf-8?B?TFJYUEw3L29GOGg1eTFkbVVFc2NkSjk5RnJWL3NPZ21XRWIzMDluaEpveVlY?=
 =?utf-8?B?eTNzelFMTGJRSHhqLzEvd0diRE9YS01Fc3lESjNuTWoyTmV4clR0Y1RCODN0?=
 =?utf-8?B?TlhJSzczaDQvSE1iUXVsTWE1TXhSK3ZkeDZ4d0NVa0hGZkY2LzhIUUx1UU1O?=
 =?utf-8?B?K0grYVF2N1hoZ3VqUUp2ZmJTUnMxTXVrdlFtWDBVa3hSNWxMNFZEdGlVdDF2?=
 =?utf-8?B?dzRjcndqS0lDVUk5QjlsYzdUUzVvM21ZU2hubUtBL0dTUFUvWTdqenM1cnRH?=
 =?utf-8?B?b0E3L1ptR3dodE5qQ2dNZzJyMmhkaGQ0U3FqZ2N5ZXRqZktacll0MnNQTWhF?=
 =?utf-8?B?cnlESXNtMmVaMnVEWGVFd3Ezd2phYUpVYUxrdGo3NnEzei9VcTQyZHJwK21D?=
 =?utf-8?B?ZGJUL3pxWGhqbUtlV2VERWpyWjJRM3VmcjFIb0l1cGZvbVI4bUczci9lUFRm?=
 =?utf-8?B?NjNFSTBxTlF6YUdYTXlmaFZxR1NwQXJqbXUwbkVtRVlkYURMcmR6djVBemR4?=
 =?utf-8?B?Rm1ZZDZ0bzYraFBXNWRHSlJxbVk5c1c1OEoxWms2SkdvN21QN2t6UFZQM3Uv?=
 =?utf-8?B?VjZqaFJYSTAvWFBWSXNxUTlFalpOVzRiNFFIYmFLTEJhUHdZVjNGYThYZjFl?=
 =?utf-8?B?QkY5YVpDdXJmd2lXM3ZGZG14bHNrckJLVGtZVUxzZlcwMVA1NVk2cUNrNUhq?=
 =?utf-8?B?bldJOWdaRFdNUUUySngrU3dxVzhUeG0vV2U3RDNrNU5MVHFKaXplUWhzM09S?=
 =?utf-8?B?VzFxQW5xY3FVZGNRdDFWMUpmeFJjVnM4UXZCNzhRZHVoV1JNYVZQNkhUbnB1?=
 =?utf-8?B?aVNBTnA2SGxMeWx2cjRycGhodmtKM2U1RnVwa0xSRnJtaGdpUndvdUc4SDhK?=
 =?utf-8?B?WGlLQzJRSVJPTy9YZktYYlVIMnhrblR3c0FpYkxNeG5VcjQ4UjhTQjJEV0s1?=
 =?utf-8?B?bzRoczBRYkRVRkRLMklPbXp4RDA3alRRcGJjUG5BbTM2a0wyWURISXBVZitQ?=
 =?utf-8?B?MnZGMlhsdjBOTkJEamRxZjBXYTIxYU1HMVFYUVVjK0gyNVY0YTNmU2FZTEVy?=
 =?utf-8?B?WTdPbnZxN2l4UFUxZndtQ2prRjZzSjhCOHB0REtmRjVOTTZBNng1TDlSTlFt?=
 =?utf-8?B?SXNYUmk3bTBFdzJSeUlqVXJUTXc4UlZTZDFRUzRMNjR5ejc0K3lKdjlNTGpB?=
 =?utf-8?B?RUVBQnlrTExzd3ZxM3Z0cmptZmdPUVcwVVRTRklVekpRa3A4Q0JQaXNsVXEy?=
 =?utf-8?B?WThjTXM4cXhSNEgrdzNBRXlnSFlSWTBCUmQva2pFU2pMamtES3BNQWcxK0o1?=
 =?utf-8?B?K2Z0SzVQekR2SnVhdEJGZk5yYjAwT0V4a2hwRzkzQUF2bUdmdWx5K2gvOVlr?=
 =?utf-8?B?N01DMGlGWGpyUmlCMVQxTzIyd3hZUGNQaW5ER09jMkhPR1FzUFJhT1J5d2Ir?=
 =?utf-8?B?aTJjTEFCQTZRQVZRaFN3WWdQeDc4OGo1eFlRY1IxRUNzcWJSOU50RkhQUEMz?=
 =?utf-8?B?Ykh5RDlhWWZSNTZjSHRtamlUNFQ4U2pEbGhNS0lwWk9Rb2ROS2RRWDEyRFZx?=
 =?utf-8?B?UzJVbDB3Z2x1TTVnRnFGWTRRTWJkdlF5UkRJdFMxYVc0c3drTUJrdHRqT0pp?=
 =?utf-8?B?aHVwUkh2bnQ0Y1hDdTBobW8wTkdnSmovaERWMXdNNnc3QnZETi84M0tmT3hF?=
 =?utf-8?B?RzNlK1l6TytFcmJUTWVITEN4TUNpQURTcDE4WW5NRDY3VUlMWWZFbTE4dHVW?=
 =?utf-8?B?N1E3eGttekhHQXVwc1pJS1hjTzBCcnQ2K3BKWG5ZS1NyWjZxblQrRjdoa2FX?=
 =?utf-8?B?V1N4ek1uRXE4UlpnOHRUTnU0UDluMXl5Nk5PTWtzc2JpYWcyRDBWMEEvWVl2?=
 =?utf-8?B?ejFoSk8zcDNhSzU5aDFWVkM2cFpjWitzc3FDeWdFejFIMlRpb1k1d0F6Y0JR?=
 =?utf-8?B?VWFZcmRZTWNvek9JN09KMlBJWG45MklTV2pSTGxTeXlCU0VLaGJyalRreTdN?=
 =?utf-8?B?NWMxbVFMOVZoNmZrSW1xZHZHWWVpYndSeEhHQXJrbkF1WlRuMm4vVFJ3NW5m?=
 =?utf-8?B?N2xaOEFQNEJUdElxNCtpL3p5UXBsZzNMbFhuY1UyTGFobitCYkhacm0rRFV6?=
 =?utf-8?B?anZpV3JIMFh1b3ZYVk4wOFRRNW00cGRXaVpWdFc2RUlQelB6cEZ6aEUrVjhU?=
 =?utf-8?Q?4NUdpe5aEVRBTULelY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9092811e-ae93-42e0-7098-08df2ae7fdf3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:13:19.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4n/1BODQBbj7zM2cb4D6kT+oERxJ2h5S6nCpPRli4nPzS03VJ7r1xMZXpEs3b8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

pmdp_invalidate() sets _SEGMENT_ENTRY_INVALID, but on s390 that bit
alone also marks an old (not young) PMD, which is still a valid mapping
that GUP-fast follows. Without CONFIG_PAGE_TABLE_CHECK, an invalidated
PMD is therefore not pmd_protnone(), so GUP-fast can grab a reference on
the folio and, as the PMD value doesn't change until the caller
finishes, the recheck after taking the reference passes too.

Code that invalidates a PMD and then decides, from the folio refcount,
whether it may drop the mapping relies on GUP-fast backing off from an
invalidated PMD, like it does from a cleared one. x86, arm64 and powerpc
already make GUP-fast reject invalidated PMDs.

With CONFIG_PAGE_TABLE_CHECK, pmdp_invalidate() already clears
_SEGMENT_ENTRY_READ, which makes the entry pmd_protnone(), so GUP-fast
does not follow it. Do that unconditionally. As noted in commit
7b4dde5e40ad6 ("s390/pgtable: Add s390 support for page table check"),
an invalidated PMD that is pmd_protnone() is fine for the remaining
pmd_protnone() users, which run under the page table lock or are
lockless walkers that should not follow it anyway.

Assisted-by: LLM
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/s390/include/asm/pgtable.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2d5c2ab06de98..fe1ba746203ab 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1781,10 +1781,14 @@ static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
 	pmd_t pmd = *pmdp;
 
 	VM_WARN_ON_ONCE(!pmd_present(pmd));
+	/*
+	 * _SEGMENT_ENTRY_INVALID alone also marks an old (not young) entry,
+	 * which lockless walkers like GUP-fast may follow. Clear
+	 * _SEGMENT_ENTRY_READ too, so the invalidated entry is pmd_protnone()
+	 * and is not followed, and page table check does not count it.
+	 */
 	pmd = set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_INVALID));
-#ifdef CONFIG_PAGE_TABLE_CHECK
 	pmd = clear_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_READ));
-#endif
 	page_table_check_pmd_set(vma->vm_mm, addr, pmdp, pmd);
 	pmd = pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
 	return pmd;

-- 
2.53.0

