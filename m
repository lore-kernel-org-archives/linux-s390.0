Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF162D8376;
	Thu, 23 Jul 2026 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794975; cv=fail; b=YaOhagcMii61pOzjwyVdBSVCsXQal9E9IQ9vCHYlOE5IpWjK7VnEM293eRfLTSyOvS4MLwqqRxNEKiAVcWdoOFoO9Nhg9oa2iYRauqCxdn08GLjzWLFHjxPP4Pm9fO7KS3TuT8XusP2njZgrZcgp4NWsTOsLnjp2tDsWFmR+mfo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794975; c=relaxed/simple;
	bh=cGaWSwYZKQOItOv/TIIk1EW4XQ6Ou2fmdmQZu/jrlcA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLTOK7b9F6On5KNAj/Co2Oeq5umcDuhGsO+vApna4Joah0Yl2Uk0MEStzckiKZc19cwRljsCUZ1EBQFH6U+6EYDWYofOjdF4tG2rrfyprQFusQnSW82uK5eXs8cb00H2e7EtbwTCQY503jSST/Jsk6w4lWQsM8qRPWkioGeT+3g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WXXVpjFP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WXXVpjFP; arc=fail smtp.client-ip=52.101.83.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WXXVpjFP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WXXVpjFP"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u3jrr3o36XsOH+E6IpkdQpcUky1iAOhn6YGErpJphBwhVxeO5DC227gyoZblUiLmo4aaKeY3i3e6FcdQ2mYsNkDs1y+594YQ/9I9qzMQx25INJdEK3juPEYHO7u0e/wAGtZoPJY5E9ClhqmlqV9kRH9XeJnA9iSfN05vaw4Ai9dKSRQKnYBqAljAlONf3KX6PRizHqwtIAjm41fTzQKvr0WnREYhvluk5MXZRz8KKtWKqq3ABY0n1gfgeIN/rwmitUNwO9lJUAySoBXD6cGsvNZwc5j13dVeW/RmUgT6Boj3lPuc81rDT/p8hxQWYZimDvs7qnnxqwU+2+btYOPopw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6BGe/Wu3nmcjo7+jJuI4sFheFsf0l5rDoVdaLcYZWo=;
 b=tbPaYUDGJX3eTDOM7z9Qul5NLkxQHnJ0PzFAcbJ+nw6h8u2EN/kifp0VDpSbV/mfVPkN8n3wNOXeFGkGPvQm1WSNa/qprLaQeZxz4sbnlz9BQmmpVyIefL/rnUWW2SBr0EiKOC4GmJgQDaxeflFX03IUe/fRYtauMZxvcxuXjkNva5PJqAaT7XTmsi8wpGCVbLEM/KsSl7oKKFR45jrgw5rK+PgZEAb8iZcWQsfzBgGi4yEQlhhSQDnTmB2XuWnAPvXZPLV9akTi03kAL1M1sMipLTTcpMEsi3OQ9BGuDXshLPLKRyONdkT6T7X8w3S3msc9gtm+Z4JoSoiUlMw4iw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6BGe/Wu3nmcjo7+jJuI4sFheFsf0l5rDoVdaLcYZWo=;
 b=WXXVpjFPpRjLVUdrmv1mcBbJphSJZUKK7SCywBUbsZG7LHw0RJ0BoE3Iuja09+4pLRGzq19c3FJnso1ue/QTK5NMLko8PaLe8DzxUD1Yp7frF8UcE+gs62lGGTI8sFrx9MfyCZ8bes6nUsgj8rRJ1TD8Ri2vpavVQ+LJw/2mDBQ=
Received: from DUZPR01CA0258.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::18) by AS2PR08MB8408.eurprd08.prod.outlook.com
 (2603:10a6:20b:55b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:22:41 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::2) by DUZPR01CA0258.outlook.office365.com
 (2603:10a6:10:4b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 08:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Thu, 23 Jul 2026 08:22:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhlUOSJIO/caEcVmZI/Oq7QQtK3ELv3R8eT7gBRyY/rNrfPoxfjuSjW3Ed/66RJL1z1QbejRgdro5NvityFxs4O2lKrSuRguU5G2o2OYx9IxfM3SkV2TAhjtqGCY9Hg0soqB8xJaU9nM09GoCJCysOjXeB+W9gvzwGb93RAz6pyV68q9A4TjZJ5yo4M4Uy2tWAJoUxaSzivyp85s3uI4aQDbUyE5FXzHfvyqvpgtqsginjmeb35dS3+wemh7dYsPGqkfcJyOtUNncg8+I6iW0ySoLyTDwfohxhy5XqA+tQHYuiIXZxF78vrKoVT8Q6p6ex+YLa932KyC8FyOrq9AnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6BGe/Wu3nmcjo7+jJuI4sFheFsf0l5rDoVdaLcYZWo=;
 b=H/l1NdTPrK7SbYfu553wZE3Cntk5rVoy75rKcOfNB8mY4vY6mB9WQ3FoJDtg9CDyd5NUy5y+G9CWdgxdaFWnWvQPlaX506ao508s5xipRv7OQ1A6BMF+jabfdswHoK6BwqjXx7KrHPTOiTE6ItoO7a+0l7OV7jGWaoTxUQ+J0EPzY4j8lJ8iQsya1+/u/+LdfZAuWxv4cWRf9upZpF+K6BgHqZN/J6uDwh97u+ts8S5j/DsWUA0o37UQfeITgG5FuhMpyrB7+Xz22deeP6CagcN6+HVLDJYl/Fhcts8SEyaSPKpNWUsToXA4YsYoBXBMy90SqHIBWnPkGy2uHJywVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6BGe/Wu3nmcjo7+jJuI4sFheFsf0l5rDoVdaLcYZWo=;
 b=WXXVpjFPpRjLVUdrmv1mcBbJphSJZUKK7SCywBUbsZG7LHw0RJ0BoE3Iuja09+4pLRGzq19c3FJnso1ue/QTK5NMLko8PaLe8DzxUD1Yp7frF8UcE+gs62lGGTI8sFrx9MfyCZ8bes6nUsgj8rRJ1TD8Ri2vpavVQ+LJw/2mDBQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by DU0PR08MB7787.eurprd08.prod.outlook.com (2603:10a6:10:3b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:21:37 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:21:35 +0000
Message-ID: <3c21586c-0ffe-4ebc-97f1-803e8acfc5c1@arm.com>
Date: Thu, 23 Jul 2026 09:21:32 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, "David Hildenbrand (Arm)" <david@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
 Ryan Roberts <ryan.roberts@arm.com>, Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, linux-s390@vger.kernel.org
Subject: Re: mm: opaque hardware page-table entry handles
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <74182e50-b54f-4d2d-a27f-3a59a538d6bc@arm.com>
 <31d36023-d728-4eee-90f8-158c7066f565@kernel.org>
 <e22407d8-4509-4a53-9ba4-491b9d5c5ef7@arm.com>
 <4bfeb697-9c1f-4316-96bb-9bfd66f959df@kernel.org>
 <6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com>
 <20260721124057.2820903Adf-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <20260721124057.2820903Adf-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::13) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|DU0PR08MB7787:EE_|DU6PEPF0000B61C:EE_|AS2PR08MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f575f5d-9cce-401c-1775-08dee8939058
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|3023799007|11063799006|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 6SSkaNOUIpTCmQ2CzMcdRGQcJsrJakeUdBE8RxsctUM1+J4B7VDv560CKxwKPa3oj5ztVVaOZDEyajsL83tL342ItMODo5w5Lr+SzELBDlBUj6vBRGP0kpmKgHixFBQWax1SjmEerHbbYz9K7LRnZ8nWuHboFDV3L7UhQfMK2Z+iEDmIzzoUijEJzWhCbkkHxvAHXV3L31pAnWCy7q6JIy+9LMX+lBPkWq90g+APjU2NDU71mQ6vOkB3LGkATbsLUapTRfh8qjGUlBGqDQftO4+YrMJeOvwih6G9zZJtgMraBvUdE2sJgdhLEDWrBP8VbB3U/l4gsbR8CYwl5wCoHPFab95ZufOiesF2zJoeOsiz9M4ZDlb4UYTRYSdLHRuTzZuqIDxDGu1f1cA6obwXSd6ag/1mYUGVCL+M1GCboBARqyaAXWQ88E1bNDD4jNmIUSRkBdWhdqU5E+t8Yvn5HJ0+QB7k4J3faWW6upYpv559hdg/5V8/LrE41SjQvcXp4WmV0ex1UVOiYsAP228c45XA7zL1E4rwY3MWKi0oK1ITkkkVZ0s9gXOL7USK5Oz8rLbMkNMjuNWdaj7RF9YLCKP4Z0WQTN+DohFEjcGXeWi1kl5EvFtQXX9b69+MHqRd2HCADSqZFiRHAnx7oEOOf2Zq0gCBWBPJHZng8WN/crI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(3023799007)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 NU07Clx+cYnzlybSrbXSnc3/nBhPi9xa0BF1rGxvF04DIIuviNF15Gbz++w1R11uQoga8UpLFdyHo5rxs6o+k+JLirv4m5eVZ3mNnZFOpBLO8SWzrf6Y3D2fHGuVmHyJnsLlYYxfircs7rAeEPnoz88De81vVVrb6qJTtthENxKcRcm9xhTZLz+NkgnHa2Zn78ReekVNV4EoyKjIx//Fbt+PE6AzkWfEHC/Icbzt6PQImuQl6YUKSm/gZR4AJCjIjdpDlm2GXhYDY9G6KiyjXo0jCm/iEEUQ9S7uDNcfXV3y02JQhd/f+3fWs28PaNjFijz/agfqiZ4D2YM3H/DfMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7787
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9b9b8dc2-3193-4bff-d23d-08dee8936836
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|376014|7416014|23010399003|35042699022|36860700016|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	a6JzXT5ZoKfJZ31RKpFav1f0/dBd9rkraTdM664je4FV2u7aPzi7vVOw8M4s65eDgBbx280g0jZD1x0XbTjRdpW5zWJFitsuYYJ3SJWFdo2IKB3ZE58u3L/h0mfa36vMt5UVW+becUM/Vp6GMXGVtfxuN6+0rY9qiRtb6DuxlcEXeRrc717ZRMHbEusboAJqgYbIliht1T4JFNgbh5azHiCPdqLb8rxfo69bz5kKEglaN8sm/L1Lzwp8FXiyI7Pq0DeobEvqKbwaw3QKdkyHcwsqtN1mp1m4UQUJguJ6PTe9eV9Bs79GdV/sfWbDsL/E5I549jHz6in0JWaANhQKiooIrtodg1bozb7oN3fx0Yg4G2oUhkiLxF8XFPSRSJa4DEO2ytw8N9LndWiBeU1TxRxsFvJKfyjSpOJN2y0hHu0qZD1SRly36isNPSFslatetqpvluObM2OM0Y3YTt4YXxdtqrhT0RmD07Y8WB0mLBeYJVWIyGq51UPVcpzMZrsKaJBZxx5F9wYnH9jnKYpv5sNUlMQt5bq1ODNCR8sj1/nJsPHOKlXQPQmjI2/iJU6CyQwyMPcfBG+/h6GvVj4Dmj1Gk/qxzmBcAYyJzZ7dxwSzFr2Nbjw8ILkcMGBQUQWVN7OZ87lAkh7XjEQ5E8vf5sEDS8L/ShRzkZ3HjVqY9634evtwN7/IuAM2AF9tfO0RKq2Sp93RP6bufQ+2LmYhGQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(376014)(7416014)(23010399003)(35042699022)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pjeMf7P4awIvjBvTziletfj2p17zMnG+zwEtxSX+xfhn+dTHPREDzDaGJWF3wKn3qBvnXd3lzFxH/xPs/4N9IdGWMhY35BckQLsHh3v2ltoFCHtTzWbzmDWdqiYWYpFOfngZLWAhelWAkAEcmm42nJjibb+gE14jqD3H396mxwG5Kd9S1ZoWJe/rC6ASp2qPy4CcqYpmIrDkcP4LwbGC+k8+ctvm9RRFbzDQTo9rfGu2y4M9f6aMtZ4Weoqki+/4oeAtHTCznty/8AUa03krBAunmAHMzqTT3CjSF9a/qPuCu2+iXr9mtXipcerEy1FEF/w2ED5DUdjElXMOOPkBEBljt06NRynHn5f1bzJL6oIMMTD8t9YCV8RHwKEQnrfvAl1U8/NEMX9e3FhtbyxsrzOrRa6lUgnQHZBO4xJFBz04sCOFUZdoaQP8lSwrFu8G
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:22:41.1654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f575f5d-9cce-401c-1775-08dee8939058
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8408

Hi Alexander,

Thank you for reviewing.

On 21/07/2026 1:40 pm, Alexander Gordeev wrote:
> On Wed, Jul 15, 2026 at 05:15:36PM +0100, Muhammad Usama Anjum wrote:
>> Hi,
>>
>> [Moved some already involved people to To. So they can help with the plan
>> details mentioned below.]
>>
>> On 07/07/2026 2:17 pm, David Hildenbrand (Arm) wrote:
>>> [...]
>>>
>>>>>
>>>>> typedef struct {
>>>>> 	pte_t __pte;
>>>>> } hw_pte_t;
>>>>>
>>>>> And then simply use
>>>>>
>>>>> hw_pte_t *hptep;
>>>> Make sense. So you have suggested to just hide put pte_t inside a structure
>>>> instead of complex structure of pointer. I've tried to implement and it reduces
>>>> churn enormously.
>>>
>>> Right. And for most architectures we can probable leave both types be the same
>>> under the hood.
>>>
>>> So we'd only have to convert common code first, and can then e.g., look into
>>> making architectures that care about the difference (e.g., arm64) actually have
>>> it be two separate types.
>> It makes a lot of sense.
>>
>> Let's even divide the series into more parts as there are several places where
>> conversion is controversial. (Xi Yan had mentioned one example earlier in this
>> thread.) Most of those controversial conversions are pmd related. I propose
>> that we convert pte_t first, then pmd_t and others. It'll keep the number of
>> patches manageable and easier to review. 
>>
>> I think wider agreement for this approach will be very helpful before I post the
>> actual code.
>>
>>>
>>> Just an idea to further reduce the churn and limit it only to core code (because
>>> I saw some very ugly stuff in some arch code that would make such a conversion
>>> harder).
>>>
>>> [...]
>>>
>>>>> Why do we need this and what would we use it for?
>>>> The idea was that there should be two different functions to read value. Let's
>>>> leave this out of the first initial series. It is complicating the original
>>>> proposal.
>>>
>>> Right, let's leave that out for now. I'm currently working with Levi on an
>>> approach that tries to avoid the overhead due to READ_ONCE with folded page
>>> tables. [1]
>> So you are referring to page folding improvements. I also stumbled upon those
>> while doing a dirty implementation.
>>
>>>
>>> We're still struggling with some bits, but looks like we can make it fly and
>>> have it be fairly robust.
>>>
>>> With that, maybe there is no reason left to have separate pXXp_get() vs.
>>> pXXp_get_once(). TBD :)
>> Yeah, I was reviewing that series earlier today. I've not looked deeply, but it
>> seems there are still a lot of cases where (mostly) pmd is getting dereferenced
>> directly. To complete the conversion, direct dereferences need to be converted
>> into an API. I've been thinking if there should be a dereference macro or we
>> must always use pmdp_get() even though it ensures ordering. It may add excessive 
>> ordering in some functions if pmdp_get() is getting called multiple times. But
>> storing its output in a tmp variable would solve this. 
>>
>> Do you agree with converting all direct dereferences into pXXp_get()?
> 
> For the clarity (e.g. on the PTE level) is it goint to be converted to?
> 
> pte_t ptep_get(hw_pte_t *ptep);
Yes, that's correct. 

> pte_t set_pte(hw_pte_t *ptep, pte_t pte);
Yeah, probably it has void type:
void set_pte(hw_pte_t *ptep, pte_t pte);

> 
> While variables on stack are still may be dereferenced directly via pte_t*?
Yes. The conversion would force us to never directly dereference a hardware type.

> 
> What about unlinked/temporary page tables in memory?
I've thought about it multiple times and it is best to represent using hw_p*_t
type. Even though they aren't installed or live, but it makes more sense to use
hardware type as they may get installed soon. 

The difference between representing stack type with pte_t and unlinked/temporary
page table with hw_pte_t is that unlinked/temporary page tables are complete tables
and not just some copied value.

> 
>>> [1] https://lore.kernel.org/all/08ecabe9-0664-4aea-82fb-f9cb1739f762@kernel.org/
>>>
>>> [...]
>>>
>>>>>
>>>>> I'm still not sure about the _once() really, and if we need that right now. We
>>>>> survived without is so far, why do we need it now?
>>>> The idea is to convert all current pXXp_get() to pXXp_get_once() and convert raw
>>>> dereference to pXXp_get(). Let's keep this idea separate for the other work. Let's
>>>> discuss it later sometime again later.
>>>
> 
>>> Sounds good.
>>
>> I've tried to do conversions already. Converting by call hierarchy wise is very
>> difficult and error prune.
>>
>> Converting component by component (such as page walk, huge page) is also difficult
>> as code is tangled. Some helper which is getting used in one component is also used
>> in another component.
>>
>> I see the following way forward:
>> * Add the new type
>> * Identify which functions need explicitly pointer to a stack variable. These
>>   must not be converted. These variables must be renamed to a common name. For
>>   pte_t pointers on stack some functions already use ptentp, which is unique name
>>   if we look at generic code. So ptentp would be used for all such variables.
>> * One commit per controversial change would be done at this point. We need new
>>   separate function for stack types. Also we can do more renaming to a name which
>>   will not be converted.
>> * Run Coccinelle script directory-by-directory which would ignore converting any
>>   ptentp (and similarly for other types). Coccinelle doesn't converts in some case
>>   (pte_t *a. *b) which can be done by hand at this point.
>> * Update any remaining functions
> 
> What is the approach to STRICT_MM_TYPECHECKS?
I've tested after converting couple of arches, it doesn't
break STRICT_MM_TYPECHECKS. I intend to keep STRICT_MM_TYPECHECKS working.
But once the architectures which uses STRICT_MM_TYPECHECKS are converted,
we don't need STRICT_MM_TYPECHECKS anymore as those checks would be enforced
by the conversion itself. Thinking out loud:

Normally:
typedef pteval_t pte_t;

In case of STRICT_MM_TYPECHECKS:
typedef struct { pteval_t pte; } pte_t;

After introducing type conversions:
Normally:
typedef pteval_t pte_t;
typedef struct {pte_t __pte;} hw_pte_t;

In case of STRICT_MM_TYPECHECKS:
typedef struct { pteval_t pte; } pte_t;
typedef struct { pte_t __pte;} hw_pte_t;

So after the conversion, it doesn't makes sense to keep STRICT_MM_TYPECHECKS
around. Please correct me if I'm wrong.

This brings another thing in my mind that in ideal world we would just
turn STRICT_MM_TYPECHECKS on for all arches all the time. But the problem
with it is that STRICT_MM_TYPECHECKS defines pte_t which will stay double
meaning still. So we want sort of STRICT_MM_TYPECHECKS with different name
and separate stack and hardware types.

> 
> We would like to keep it, and I guess some other architectures too.
David had summarized it well. We'll convert generic code to use hw_p*_t
types which would be typedef to p*_t for those architectures which don't
care about. But if an architecture wants to interpret these types
differently or want to make sure the type is enforced and not directly
dereferenced, they need to convert the arch code a well. But it can be
done slowly.

-- 
Thanks,
Usama

