Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5635838E;
	Tue,  4 Aug 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853264; cv=fail; b=ug2ekT11ZMb1t4P2n/c6+q5CGgGngWCtyp3oKcduUPJdjE1YTpINBZWvd/xvOMpDXQDCzuAay8LLejTIeL3+WhVpHOQc4DcciWBKfWm6qF+Z36ZxmiZWOAfebFavDUmQBdCDgSXkJRDdooR3vidPr4sUImA9yGQrl2//JwF88ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853264; c=relaxed/simple;
	bh=KmPnVVHfOZPqmY6g1632Jsi6cvdnGzZqsiJm2qrLvf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IqNxT3uQYWvJGeRFcxnq4riyPiH6s9Ip1B8omGd3QrhbNDHDZbKf4JjifltSzzw2C5CQ+a3gdy+JtWydN8Be3OtpADSDf/7ZK+Aj/7s8u6JvY1Ww/DdPCy2JRS5A0qpDJsdyQYsDFo/EGJS5RUyvXK4lEjqUY78vSLf+YpMS6B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b4IgOeA3; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4IgOeA3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uioQEZlYSV+z1MVt9TpiFghRByMcT2Ch362VGI2cv0dWg2s2VUAmPryw+OEBjS7/w4fJEKy+dnXKXlKIflw1zF1c5seabNAG54O0+tAR4xXbCWKoP+3Y5Pmt0k//gdl9eybS7UcB+xKyoyfd3XSKL5Yx4QU6c3q4511m70hdm2C84grlv/VRyMcAXslbd06ty3ZXA3sSZNR0FLiXg8XUCWXjq3thuIJybw1+pcU6EddSsPL6Sc6qWL3JLzQfoUFAPM/XHlgyAwRux+fgm1IK8+lDcB1ACHkPk+cAn8SEZb2PBytFkoR0wtaDwvrAAYjNR8CzK3tO7Gq8b6FXB/dzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmPnVVHfOZPqmY6g1632Jsi6cvdnGzZqsiJm2qrLvf0=;
 b=CqFHzT2sM1spayDCKD0LfiN+DXmqvPsiYVFqBlPjFaXEVyWyLYou+jvO8wL8AAiT23eNqfmD+o4JaiiJ4lfcw1Gx09S7HeUyCbGxiadvbV6GK0rs/2kHTrLk998QOUn0TDlmgkrHVMVE2mXuJ6g3F2vPIAFFArt2nEfwbEEwmUP2lZ34IWRvRxq5giC0O2Bye9MZsyrspxaLWEitmTMAJpOH47+eVgzko7xHYCu+1S/j6hnuWFwG6kw+V+as4ZpWINKDPKMs+2Io5Kzv+c1Ksy5CgC7/nQLRHFkPJbxVELuJ6YAeFD5UZ/GO2Al9lkDdPh4kW/RXqQjfzjXKe69vnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmPnVVHfOZPqmY6g1632Jsi6cvdnGzZqsiJm2qrLvf0=;
 b=b4IgOeA3hLrfjs/RYLCmO/IT2oaRBLpK8sGzZv5l9GU2VDdctC1gBFgszQcl8olRvxuMlwlD+9MceyLCy2VRpV3NLrgRalNAYTnThTe4IGZa9d55JrCThW20FcBeHpY0dWFzIryuNS99zJN+uRyyU2/nhV6GhsPjwn2ZkNYBB4+joTkVyzCbKxsQeEO8KxI0Gcr/Jck+TL2wP4biDbCAE4RunPK/FNMBJ1MM2tp9fzkT/YoVsO+gDMMUl5KXa+25WHIiNjzS9tyiOsU5XP0+shvCQx1/A5l/InIZX2ZXh6jBoAWGDJGXfFigSKlr66GHf9BKE78orUifQmeP3Vqmjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:20:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 14:20:33 +0000
Date: Tue, 4 Aug 2026 11:20:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <20260804142032.GC27883@nvidia.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxw6dl1d.fsf@kernel.org>
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: d933b639-f37f-4973-20ec-08def2338bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	y0XzE7i2bktET0P2E4lJqv4vDJV/DalfYt1jt7DmuHZSXdJpkpFqCN1Qcq0HMmJa/3E/Zm7eqVuAqfwzD+lptrqJlGxNj5S39j7VfUtv4Bvq/MfFmB/ffknkTyRRKIit0e8Bv1uHb/QvnXUu2DVLqTzDq5XcyE2w+i6uU+fqR9x93/GKl/OyNNlY9xo1NQ3BYnUkpbTvRnLqbst7VgWxx0kGNJJITq6RpEg1X0xQp1A7dEKkQp79bcSig+ke3UbkwRHjGiu+c0CNLAaDfxWK/eYP0k5MqrZg0XJi+O2iJkE5MeyVuM7sfVNiCbtWOJ/DUf41lxOO55YDiY2WvZZsufd+onoKnmaWa7twn77SS3Yib7pm/qee2YPK59CtCn7wLEunJCggamZ5BsZEK5WDl7guIFKBwUnJb+LEukjVm02AnSLTDguIDfqQ3RFHjYIkb9KgxoSv7717Zq+DawThCKWQGBg5melMc2/WEq+UhQDhVZXSohsDHPOq812p6+DOzIaHv2R1n+VrU1180vfTxosn1CcO8PlXWFoMJUiyfo8K9Qbe30g0mDzzMaNRxI8m1rW9aJ6jEh7zTnXnPIm21R2ASRvcoVNdpqevUhlVeypIK3x3T2+dFeOVm0FfKe4DJcYVDR6zpjil/RUDMyAvsK57hnkHo2/uffWTcInx1Oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmJ62cjpSKqKZL3RGh/L2bTFRteNT2V+AdFaa7l1TJYD3FQICOP9/X6BGLQK?=
 =?us-ascii?Q?tHdy1dUWTwQXX5PPusxa9ze2PvRW1KCGWCQInDkOE0KQzsxiD5rsulYsXNUQ?=
 =?us-ascii?Q?XnYAnUL043WvPaA0aCO6Va6wUsM0A3pV/PWIOiSPKoCriyVB/jza5AHQ4Ddi?=
 =?us-ascii?Q?YYkoe90DAUnKnFw3FKSVQ6EqwQZbhGIjQ6BK0mm9kS+vIEtRX+pQPKcgEaeM?=
 =?us-ascii?Q?VfhuaJAjbo18oqRE3SSrYHvX4LV7daEkPHxOOByVVjRTXYaQbNviOwKDqrYS?=
 =?us-ascii?Q?THf5uMDf0qSXIW4rdX5P8tPvA6aFjE9UH9+OHtNc0xN7tZgGpZ+FLCx/nW1i?=
 =?us-ascii?Q?5RaL7gPYA/MMHN48c2AOqdV0r9krW5I0wZjLlUG1GskymIPqPoEs9nLSGLRl?=
 =?us-ascii?Q?t2jUicjHPxrvKoq8C6VAMPbA3vysw7WEoTfi/URURI/zF3UhDoCYMQIwL50p?=
 =?us-ascii?Q?7OLrSep9sNQjiwIZmSAnUNrZ+6h3rKkgwj+W6f8nYhmF6qrzOXjws6G5l7s+?=
 =?us-ascii?Q?flVMzg1vhKQWIZtno5GEXtuK55GQntucwMzKWMDel5X8eKV9XM0SWoK7kEP9?=
 =?us-ascii?Q?m58R6nluRZLKKmttpR28ZpNwGEWz8TezQ6vOOnQuV+lEZKezuEEdu+NNpTgu?=
 =?us-ascii?Q?+e2p+MCk2d1tFNh8aaOB/Dw9EeEG/q+Fx7mGK8zCtND4MOwwKpyImnzMuSi9?=
 =?us-ascii?Q?+0pdHDapb4+y6ztj8T1gXGG2rPa0a3HJViUBKVv8kQd1GErNZz4zshoi0FwD?=
 =?us-ascii?Q?jvQlFdi0bd7kQvDta8a0Xd5NMt08eoJB6HRDM8DH2erASCsue9T+IjlSqtXh?=
 =?us-ascii?Q?vG025q9RSDohCZLazxSJA60gX81jrjzx2x1iB4uA3Af3xrpp/jkvjBtsKSCJ?=
 =?us-ascii?Q?hC15V8GTutAcN2kaWX39c+SjkidSKIsdh+iW9SJKn/mFpDJpS1SmU15JSEAH?=
 =?us-ascii?Q?y4wWGugEtfRgDyoOIdba8a/lW8dbPf4XxDrWzCTWA8Jgy2f3RXCksgwNRjz3?=
 =?us-ascii?Q?Zs95jDHkRR7Fe4i5qRxC0NUiGzXriIvnjfJplHHg0du7GiqnikBkkywJ5/6w?=
 =?us-ascii?Q?Pk/DX5ovEICRDWJFRtEkZFk6gFKJxcadWRmJ4bFxLl0sgTL1phq9rXMqoIGb?=
 =?us-ascii?Q?+/e9tlYYoIIdygAXNLB7ofCmvUyW5zMqi017GahsHpT4sq02hnBLmd9aeZOT?=
 =?us-ascii?Q?BiPX9iAp79QR7+fnYdVLfC6zzpkZtmd863THFXCUauTFwzCi2XZgAEI7e15g?=
 =?us-ascii?Q?1PWqEgdKaCJcK43sKGY4muRpRuqjKfzCPjnV6J31MtTx7//DbOQlAikmLmka?=
 =?us-ascii?Q?QJbljSgeuWlolNwfxkfH4E+TBcbjewb20Hbh7lqzyKAGO80HdUzim6MKn7DT?=
 =?us-ascii?Q?ulnvk49w2ygHmUqs5mBwCK3PY7jehPObN62uvnXK98LgyJTXRbPemtTC81AQ?=
 =?us-ascii?Q?xcJ/5yq9jRhn/Djx8nzMBvkhu2WAamm68kSL+P3HVIQbhQm/uKdr7jJ4b9GN?=
 =?us-ascii?Q?x3YTnSILdQBRqVsvWDT57Ca2T2JNyiISdo7inIEG/JoOiQzZ3Wy1r0hO/1ja?=
 =?us-ascii?Q?fJrPrPHvyNgl1ctFFN9dpCkvtnR69y92AH1fkdDNH14QoHjM3iFuP/NMoO9h?=
 =?us-ascii?Q?DT9DnRywROtGSBM00M4G9oP52l0lp2dypbtQOa5y+f2uKAvk0LMhNLsvqORB?=
 =?us-ascii?Q?Rf8tjoUeakSdvVYuAM/702B7P4oM16a9tBZ05qyCzbtR8ZCo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d933b639-f37f-4973-20ec-08def2338bb0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:20:33.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWMu/91ExHlwUzdUUHGEKGx3KYAHUoiI11dVqLYArwQpcV75mMKbaH+2w6Hxich6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

On Wed, Jul 29, 2026 at 06:12:38PM +0530, Aneesh Kumar K.V wrote:
> There is a possibility that we may support io_tlb_mem with cc_shared =
> false in the future. As a result, only swiotlb_map() knows which type of
> bounce buffer was used, making it the only place where the attributes
> can be updated correctly.

Yeah, +1, the attribute should be changed at the same effective place
the source memory is changed away from what the DMA API user
provided. Only the thing providing the new memory (eg swiotlb) should
know its properties.

Jason
