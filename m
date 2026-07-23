Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65445D1AF;
	Thu, 23 Jul 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826192; cv=fail; b=SZvyqIxs+NTbqZ9r9Wv7iC1vSu7ZhgjmCsnWJBElomt0IuGLVxUxb6HQ+bI/DhiS9SAOyCgPciGfYTybEPbmf7bawWEJTe58sY+C9bnQLqiHdRtedWpg6XKKqqZcKnbc8i05rBUbEEWiQhSnhuiOhRpbVyTIVMRmQ/uHvfKp2Yw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826192; c=relaxed/simple;
	bh=AK/im+nQZPV7XcQT0ugsqDjUSuRW0KREpQvbpcLADWM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YePxhNErolyn8dhu2ts8pCsfnY+C6xrIkmZrjQGPYgHWTsUEmT0x0guub8kI45opx2n6tSN2qcBMSL3TOgnyCDNFiDB0P3Qvo3L+3ySPddcuBbFUWdEeYinFM9y8ZXZrmwMLATd/k8YgAU+0pYQ240g4Rha5Bc5dkkbaUALKiEM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l7Pj1zdg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l7Pj1zdg; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l7Pj1zdg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l7Pj1zdg"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SSMgymGLfw8ekxZfNkpFlNrJtBwGctc0MkmgIge4PJuzSBaM3+EwCKz4yV85SPAtrY0sGxad3djG5hqf/vmRqLuhUcqMKuxLJn0JKaOcgiaYKQAJub+fL5inkjL3GUz9sWr7VPVTn2yivjTG8JVkkqLpBvma4PKgNY482TEFWQhNW+FUbe7ektLTpThWzskkXuDQm3PMqXlklFePUC/4pSVFHom+IsAHN/NlEBnXvagN3TFR3VR7A2GkDth+4+7JyDIPu5UDmqGKxG7saVH8KleUeo7UpOolgIZKU7XuobnOb8/QEvHuTcHiJndM/eL+c2Gu+A9NqZ/Jw8Jggdq6uQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RzewoZLDE2rAlD15CzIQzW0NEiPr58IQ8Fi4keIROY=;
 b=CLeQO3RDmexaDVCDtzIjMiXtOupzUjr6hFfb2pva5ggPMYZJhs5HOGal7e1SkYNTTFtiB1SZ0UbBO6HVvIe5D/E9u0JCU5BEtlPm/tkpmNwO0yrN4CTO+2qLzcsBfVlM+3KhSN7rZKwrFAr90yb2YYL9CkHYuHIKe9+jRL8SLB5I3kyRCEu73lQjH6l19wNtrKUC51AB2b5MNtV/7HsP0sFZt8hl5BwtMJoFSj8PgH1BhVTRePtAkonRwS+/QONHarzx2m+k41fQt4Ro4wsLGSKVDhIc3yHTcEYc1129tIw9z/dpmAA09LVI32pFwSpzYmmhcIn9x4x8HqFuVoFsow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RzewoZLDE2rAlD15CzIQzW0NEiPr58IQ8Fi4keIROY=;
 b=l7Pj1zdgY84smYMC3AnEJwcDVKYtFlO+zmISQi9PWBB4LivQQRJ0dAN8zcdgyHsf+R2SU1KifjIiujjcWi0ZK615b656qtIbHy7PtLhARk1Cs5iN7guz7FZv7y2Tf/DsYp6/6d1Vxd3FegI39Sttf3QGLKke05TJr0Czp5iCtMs=
Received: from AS9PR06CA0060.eurprd06.prod.outlook.com (2603:10a6:20b:463::26)
 by AMDPR08MB11508.eurprd08.prod.outlook.com (2603:10a6:20b:719::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 17:02:54 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:463:cafe::37) by AS9PR06CA0060.outlook.office365.com
 (2603:10a6:20b:463::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 17:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Thu, 23 Jul 2026 17:02:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/A3n3hkhjq4QFpLYjDllwPBcRmmrhnI67RzIBOwUyHwUXXL2BRTZWYL8MSyqRLNqffwwGx5hSmz6tAobVExOoYetuZWOAP9mMJFhmsocw5ACUDrnQDZ2ke/p99MBroWVaUUXQ3D7he2esYbaHQooo96flB4whwP58LF3XWh6UgvnnHRTrKBtl5hhyl5bMJmNYQg3J0mCwI3S3AMLEFtlmoJeJmBectnm6+H+SNGeHUi24pwYCWs3YTx9HV6fN1wPaE4Vw5J2K3sXd5g6MvEA2LaikoaSzWNq7Y20iCLy8jX61YEE+cy3LIVVTPG2BknSGDv/p8vZqRs72gTQ6PJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RzewoZLDE2rAlD15CzIQzW0NEiPr58IQ8Fi4keIROY=;
 b=MQuxA6wapgtqpLLhFAY/3oSuyhBA/VTP2Mb86QBnCtUVIuDHoshtoVqMk4H/U1v9VxXn5sgGFUSIuiiGGw7jEaQ8mAUF/5jyByMieZfMP7QA9kVkvU5VGeiI3BBOz+SqI1feqAqa4qgOqo1V7a6/YcE2PkUpKhXsZmLSmAPM8LmxSwjx37mOhFz/Q5cfwEsWGGvKjTVwRbsgmtn148AYiLew2PRy3yqwvD2g1uOE78l8/n627FyIetnc9PBKOODA/iNPPLZSQJ8g6SqLEiAEXTcuVesUZOGj33gKyDHwvS+q2Uy72N547f2J4SLGfpeHCZjrbiC9kmZe7I4luOm4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RzewoZLDE2rAlD15CzIQzW0NEiPr58IQ8Fi4keIROY=;
 b=l7Pj1zdgY84smYMC3AnEJwcDVKYtFlO+zmISQi9PWBB4LivQQRJ0dAN8zcdgyHsf+R2SU1KifjIiujjcWi0ZK615b656qtIbHy7PtLhARk1Cs5iN7guz7FZv7y2Tf/DsYp6/6d1Vxd3FegI39Sttf3QGLKke05TJr0Czp5iCtMs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by PAWPR08MB10973.eurprd08.prod.outlook.com (2603:10a6:102:468::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 17:01:51 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 17:01:51 +0000
Message-ID: <47b4e62e-b001-465c-9c3b-ea0636925387@arm.com>
Date: Thu, 23 Jul 2026 18:01:49 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Zi Yan <ziy@nvidia.com>,
 Pedro Falcato <pfalcato@suse.de>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, linux-s390@vger.kernel.org
Subject: Re: mm: opaque hardware page-table entry handles
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <74182e50-b54f-4d2d-a27f-3a59a538d6bc@arm.com>
 <31d36023-d728-4eee-90f8-158c7066f565@kernel.org>
 <e22407d8-4509-4a53-9ba4-491b9d5c5ef7@arm.com>
 <4bfeb697-9c1f-4316-96bb-9bfd66f959df@kernel.org>
 <6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com>
 <20260721124057.2820903Adf-agordeev@linux.ibm.com>
 <3c21586c-0ffe-4ebc-97f1-803e8acfc5c1@arm.com>
 <716f73c1-41cc-48a5-b0e1-a47403a30da1@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@arm.com>
In-Reply-To: <716f73c1-41cc-48a5-b0e1-a47403a30da1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::8) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|PAWPR08MB10973:EE_|AM3PEPF0000A79A:EE_|AMDPR08MB11508:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe14330-8f29-4ebb-25a2-08dee8dc3c78
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 Cawm+FfjxnM7wLmzkgmEVFXFTZY0YMsJgthdJttvTxqwDA5xuCycNi6R0G7KFF5dHthH9JmLeFJswuMztpPii8MhndUDDmS9lmi6MKJSr5P4q7VLfzfgonjnU7JVKt+mAqTXSepIFq3Bnf42ltnM2MMDqVT9ov96aTF84di34SiCvteu80UXn4Uk4oXPq4tUvBbeW4GOOZufJhZDpY9rMt2K8kEWnsdhIvb5XplqAaC1f2o2ucUr1YO1OnCVSSWgFLqJ21XCGlZRW74mjH64Dzlxt8a33yc1DxhoPacy6vhDDwRea8DxgBwUJR2HqTe4XuuP6S5t6PBTZrrKjI2UKuxxs2/3Ia1j8IKEiiWPVv8AZA13AnY5CorVmQlPaFy2E7Vhacp3C8khoeMySqqO6ThPU4EqCn9KJ9+/w0hxojk5wU+8dLxsj2IiA4O/Y/ASjQ3yVBYfi0AwFCzKUvxa1bCluGnNlkW3JvGp2GTVSW8AzSK4N7J6COyK79tYOMF0uKRL8N/QYOFleIL9Tp/l9L60JrQsrkfTskSVyv7LlAkCayDHgeokFrQsCtO8eXyBblMjSnmQHfeJkdlfOkfYT/BbXusH/k/VDktrw79ZwRBpp55i6VxWZnqNlrLYkf01hnoiq73hoJWAvFgF03nNUHithYsAWt75cv4BgxsMa/Y=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 gQh8vBYgSPdVTncSOL3f6FF4kgNP/WGQsGezgKIawLZu8+5MJcyP6iQdEahY5QBUIru/pc3+DvVGlVx9e0YrYAicoYnhh6FblZcQ75F9Qje+JulMoZfX16SQU6+EFajThApylUp+wqUmgf/9t5g8292JVGYOISy+1rhiI9e80WhEeWirQNuXNlOvY3mF01QmByxRbpcXryJAfGsorpfq6AG9OxUK8cuTwF5zim0WbFGDhJmJJak10wNNpy8OD0R/kFEHd1tOe3Ozeu/FOpFQEeOo2MJtN4Fh1t/01FX5XJ3uUWZYkwdUt4ZjuhIt9osuLj39uyTZp5RAcDEmal3ZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10973
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7160bd6c-6af5-4e81-3b22-08dee8dc1703
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|14060799003|35042699022|82310400026|376014|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HCQMKbyDfOmNIiKHLzXGPrsIXJpb1dVgcal8fl7qnCm1qqO8wom0SQmMYG63eLrIj/L/jILL4U/jaURe9VNelfI7lMw0do4OUX2ODenR/KUgH/vM4uW/6qEhhyXxox/KEvCG6enP65R5AJWSvXrySkWMnstN2hiQUhw3IRdlRk0ZJTx7OaOyROftjfvY1pYCl8WsfwTxGga/K1GaS/6y0V+ACRDZFLUYEW+UPwa5A8jmuVEisWCPXjt5G1bgJ7bQAjllAgRzMl6avrPWLBbM8IIoZ6XFlns2HqUfctQA4pZUJEfzVz+QU0TYJbn3DWHgWOaTVX5RBl6PG/AmuF3EVj/VNJ+5zJnnL4CCCDZoiFAAoyx9AlPa2nDqK0uPZR79Xgm/TuxBTKnf9GhcExuB4FvMM5BpC0YKIMuxZiyT9yjUapDMzJxJfPF5O7nZftdLq9xd/1LQNkT4pg10gXCDHaO2EfJ+FEfYiKYI2INji9il0gepSH1suuiiXTVDhNkbGI/TxpehG7AeXL6yBzo3J/9Sey1VMXswcvAvl92nPSq8fYrXGgfvy/jJqvGeNUN0/9BVyo3Z2CNSgchc7H0yacvw4/rZ5ecDvbW+0jGQjElJ3SwLeirEqJMP8e5mCfsBeyDv6ZBH5xEfIjzizevY2gqbjxQ2jFU88TOpzAFlSbRxGVAhTD0XmlLrUfnqMeCjUBuX3BiG1lxaE3FveyqcKA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(14060799003)(35042699022)(82310400026)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EfROl10OGV8zCSeqHdPpYq3ow2lVeSGecm/impmA7wzt+LPtapgiruEXBa8tVCWtQa7Rxvu6FZuP28hnoyDYAyU9J/b+0Ulp1UhgKRCjm52S3QtpNcSJ6w4MyLzSI+pQ64UIbarpM2FPPozLn+dpU+qVEdz+0Ze1Xfb8dvYamBXhL8xCtgmxwKC6K1vWrrR7jnYiYh1Zd8sIlcBFGBR7o0j8Q24AybgkE8QGtFpRik5NpH70iC8M38a1QHdMNcKUYzWxU1U2wy1Nshdb9zPdF6+OdteHE/I+rO5lxQ9e0v79YnNt4VDPGQRB/nsiMkabJB3WlspwmVBM+QdI65XoRrjsDQ0lU/XOOujpa5saJE2rKarEyT0/hOWprLRU7Tap4h/vW8+p0k7MHmGfWpdpwcm+0PuskK1kiKr8XFbGnxu2RDHKmkpeCqKxXVva+M40
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 17:02:53.7252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe14330-8f29-4ebb-25a2-08dee8dc3c78
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11508

On 23/07/2026 5:38 pm, David Hildenbrand (Arm) wrote:
> 
>> So after the conversion, it doesn't makes sense to keep STRICT_MM_TYPECHECKS
>> around. Please correct me if I'm wrong.
>>
>> This brings another thing in my mind that in ideal world we would just
>> turn STRICT_MM_TYPECHECKS on for all arches all the time. But the problem
>> with it is that STRICT_MM_TYPECHECKS defines pte_t which will stay double
>> meaning still. So we want sort of STRICT_MM_TYPECHECKS with different name
>> and separate stack and hardware types.
> 
> I think STRICT_MM_TYPECHECKS is also to avoid catching when passing a pte_t into
> a function that consumes a pmd_t, and vice versa.
> 
> STRICT_MM_TYPECHECKS makes the compiler generate worse code today, which is why
> we don't enable it always.
> 
>>
>>>
>>> We would like to keep it, and I guess some other architectures too.
>> David had summarized it well. We'll convert generic code to use hw_p*_t
>> types which would be typedef to p*_t for those architectures which don't
>> care about. But if an architecture wants to interpret these types
>> differently or want to make sure the type is enforced and not directly
>> dereferenced, they need to convert the arch code a well. But it can be
>> done slowly.
> 
> I think what Alexander meant is: they want to keep STRICT_MM_TYPECHECKS (or
> something that achieves something similar :) ). So as long as that keeps on
> working, all good :)
Thank you for clarifying.

It has been a month since I started this discussion. We don't have any
disagreement on it. Should I proceed to post first part patch series considering
most people must already have viewed these emails and are on-board with it?

-- 
Thanks,
Usama

