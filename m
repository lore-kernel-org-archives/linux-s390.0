Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB526B080;
	Thu, 13 Feb 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459444; cv=fail; b=UisRNC0t+rGtBdvS9q3vAOFPsdN7TLKf2fMBlA/6PtU7hILZ6s/11X2ClHeYG84P32pZYDZgq8AMPFu8fq6g9FT7960FtQ54pJlM8a4aN0pi5exB0fvKGe4tOVZMuk3K86Bu2J41NBHI57Fio4PqDbPLF6LMo7gEnVtS2knQzXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459444; c=relaxed/simple;
	bh=6jAXZaVZoeEphm4mX1brInMMNYIrzd/S8OPiKMtWPHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rtLDuhNz2PWQq89IIttULZFKiaWZt78LQBu2rBW8Rx4I4MlhkF2LQ7cqW2N80vczInDOzrNlOsq+9IxBmUaGin6NNi5JDXR+ab4buKNaLlG9yWqNEoIaubz/3Rw/icRbqlkU/FkDaD8ohM14b+ccy21rWZiXbDo60nyehI7c8ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eUvbZn/Y; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eUvbZn/Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7pjeCnpicDtmkFPrGxkCgHkFAyJCI/0p4bEaCEP1FQa6ypNcmNQR5CsxLGR4wVbLNUO5Hu3R4EUZwS7e4l014dgZBl87pd8V1ejLOnm7M+x32Cy81G5vU4EJy7QgLEwJ5a/8lW8MRCyru5foLpvR3MnkDJapkM5UTzfA3BffzKPDeKH3Bt0qI+h/rUf5cVNqzNVbBLg5j5FDpFZQRElq4jwHtIkoIi+az6I1Y3YLSsTxwohlxfV5Drd9njxqMo+RehhDMc2oHbY921KkXF9R2NdnYcb/DzMbwkrl8ZlMZ3INg+jzPnXgxuaZlCOz49W6EMfFuDwRAqROhbYLNdORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKoVzwz8u+qf9je+FwqoylAo5xGR5FGYRL3u8IZo9Bg=;
 b=O0RwMfOqyHbra5NRjcuN5h6w6bqk+NMUhDIIMY89BqRWFfBamEHhONuYfqqOCmoFui7e1QGPgcovB9FRa8QTkWgdujEmlNrZM4GK284s3I5g0J1d98pR5olIN7vNl3uvc+JeOAcNZSXsinlMJaixq7gUvNPQpwJFNF3apKKcDRNUGnBQx677cKJehV7kurL0ML4IUBrMiwx50AMnyuKuOpa5TKeVhF13f+vPA0KAhBK6N8rNHwewXFo+33hT05xpd68poLQRxwQuSddZDfKMNjIiIm1hhcHJMB6kSHP/h6OCTOdPyTWkVra+TLnHg+gqn1l2PGdowy+UMHyiphQCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKoVzwz8u+qf9je+FwqoylAo5xGR5FGYRL3u8IZo9Bg=;
 b=eUvbZn/YKb42DIWamMhvdpLZLdHr/7qWVS56y2txxRxr1DAGopl0vbc460/z4umy0EHh1zN1DBOviLrOp2zMzb4iaseExeDBwH38k+HycGci2sdy85Rd41HGj1vlqo17bFimaQJVuEhTOzV/7Z+EZ5bkCz6/QCKakBBleJgfDz+94g4VQFbZIIcNZuvhs/07kzSAdLXG2X1E6aJr+35jP8GQ1x85YAJSfhfacC3tARDc28Fmb5zJ6ExgS6OrqS31x89ACoLkWszCjKGwGIbK+1bJsE1Xxv3W/QZDRAVVL6mUaWjlC7h2n8mQk6isnDiq19p0oGA0djU6fFy7/sh7kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 15:10:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:10:38 +0000
Date: Thu, 13 Feb 2025 11:10:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, borntraeger@linux.ibm.com,
	farman@linux.ibm.com, clegoate@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iommu/s390: implement iommu passthrough via
 identity domain
Message-ID: <20250213151037.GD3754072@nvidia.com>
References: <20250212213418.182902-1-mjrosato@linux.ibm.com>
 <20250212213418.182902-5-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212213418.182902-5-mjrosato@linux.ibm.com>
X-ClientProxiedBy: BN9P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ffe7ab-2bdc-4ca8-7ae6-08dd4c4092be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WIeKY9Yvuroj9CUAwBHQmAusIo78DjwWz7nv1ysOjcjICB4LG7s/nhDQ/bhM?=
 =?us-ascii?Q?UWUW4D5sRol23yeLYkmVgZNGYDteMoxkKKNQyOa33EVyDFvYgmRmCb7pq+WU?=
 =?us-ascii?Q?UhBzezAJ7t7SK2XP5RYauT2TNPPJVuZ0hm/FmeLEFVvM5hnlhnjVRE2fc1El?=
 =?us-ascii?Q?j0+irCRgNEJbQTykAaIwOcwzxsqrNq6dYl8uBUiMcitSQb0LSE5gdIQhQiRu?=
 =?us-ascii?Q?oaebBDPBGGawj9wOO2UPJZcMgzn+88RCuew2/J67rINb/rEZdNJVB8GYDirf?=
 =?us-ascii?Q?ZEkODsoOR2VngW5cpsHn+ckRmgngG//qOlqnQyGgh2nFtm+LcKx7541F792O?=
 =?us-ascii?Q?RB+81ZjCCOMNxk4xmblblCTT1NvqXkgP3BNwGoHu+VNAXKfgFzcxKbIcc01z?=
 =?us-ascii?Q?EnyTHBRPApx7mVg3g16BJraNdA2uIy/FocNbEg1e0RSmAWHhi68awtKRKGnr?=
 =?us-ascii?Q?8rgE1S8wu+1R5VN1qVZq+OfxRk0RjS1J3wq5pRkMTO1xWXk0bHxxb4Aq2Txs?=
 =?us-ascii?Q?la4EitZTrlvy00iWjU9SjQR5NESIltXgNfcoX/PEHELnKnyMGEdgkKFH8nSg?=
 =?us-ascii?Q?0XskjbNdkhk6Q9YmQvfiL6RT7uxtdqK0hhc1R0MwrYVsiAc4gfOKtpLqZZhm?=
 =?us-ascii?Q?Bk9v07Ue5ETxNEkytUVgqA+7DB+Ly+jyHmYoWVXNyOB73auj+AN+YdzEGQUq?=
 =?us-ascii?Q?6QUvlJn9XdR5M7FGw2Jz2xiA0NJQh7Smtcc1iI5lEj4L0UarwP8p7KbvOWQk?=
 =?us-ascii?Q?Emu+qVMndzbFY12A0Z5Q7CuhyKal7IHuxh6dRSkfXxEzPy6q6SZBo2GNazPN?=
 =?us-ascii?Q?YxDvyNNeuMP+rL+ZkFzA9ySgCe3wnTWqwV/7Y+8wHweh2B8MTsTrZg3xcuuv?=
 =?us-ascii?Q?Sm3m/S60Ldw8YHI+iJ+HJ4A9bKwg+ZoApojnmtKostWHknQW8FizASaAWer2?=
 =?us-ascii?Q?PYSWywF81Uy+dBZcLAhMF9SzI4NyqWoOaEYy5dA+JpHv1iMrsG8+nYuiZYNx?=
 =?us-ascii?Q?o76og6HQAxnlNI5hE6iD41MVAwbqksV3gz3euW64dzw89dwo9kTqn9X1IvCn?=
 =?us-ascii?Q?g9aDC3CxHP8uNBwtMbnRe0G2uJrovZsIh7G/ljavY1W0oLALQgMUS1C8zz9N?=
 =?us-ascii?Q?YJS8c0mF2kHk3XwZAMRtmFB0g0jAfqOIV/2nLCTKtZMic6gO/bxaiqPZbix5?=
 =?us-ascii?Q?Cm2+ALqUFO2COpefKvIZfViHoK87LUuEjbY9q7f3LuxZkpo6CJ1ak11ebTFB?=
 =?us-ascii?Q?lBjFWVBNAszdCYLAXtuEXj6N1xCv9zYHgnW5gK84md4KoikA240EiVQsBzhv?=
 =?us-ascii?Q?LtZFZgBRwNZsqc4aYcgRvc5CBzCX+RJxUcAG/iBh+ucPgH5gVpjuMJ2n4fZO?=
 =?us-ascii?Q?dtWcL6IIK4UsZUsF0AJQTKBcnWFy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fj2OQyU+CheEHUz9jQWecEFlH4IjOl/B9ZLNJGIVIBnQu+r8Dno6+oASC5mm?=
 =?us-ascii?Q?H0Kd8EExAWdtKymRlQyT/7M7aMoZ0+Z7Z1TP/jM26PK9Q7cKh8MeNMe6sRi2?=
 =?us-ascii?Q?gzNaPD6IFeOD/lR6zA4O7adeXavCKPfZzLs7Kqnk5e0WvnqKt1BiWnF6+1tN?=
 =?us-ascii?Q?TIiejBN+bHZYbeZOjoM9rtrNtcM+cPlEJqhpb9G3I7uyOAIuddKcCtUi0X7R?=
 =?us-ascii?Q?isZg33MB4G366oEucvnAstCEBuRochm2n90UtWw1H3W8lMj7CllZelF/5Jqn?=
 =?us-ascii?Q?NMR9G4eAokx+N2Pzqoc9BqkZ4gKCYeQL7HgoszAO06emBEu45p98Cs4/Ns57?=
 =?us-ascii?Q?12VRSu3EbTsG3mrSTrP6tnZMo/UMu8K0iSv0jFvi29fVG20SyFfON3cdiJPv?=
 =?us-ascii?Q?GjJ3AwgfTF6HkkJWzcQRS4fTj5zWW637KQ2iK8rZM+45gwEjJffqcT42dvSO?=
 =?us-ascii?Q?c7o++hNY1Q7EtwfFkiPJmIq7jxXQpJFAPPzcMhMZ/BeYoRmj0enhueiq5gB+?=
 =?us-ascii?Q?09DMiso1p7TCIFHC6/pF7oW6tOxGCC5ZymvPmYf0LXT9mQNibVFQSnW3naDA?=
 =?us-ascii?Q?UYaLYzgVyhWIGp2tsHY3WH4DEVYNYV32vFey8ErF8uDGwAU9FH7RXcNgnDV9?=
 =?us-ascii?Q?KGhL288I2YPEtQFiE1PsXXKwHmRur4D+OeE9iZWJH35wmAH0J3PXrctHYm08?=
 =?us-ascii?Q?5dijLcy+TA4jBWuubtQXAAFhGNpFTUrU4bG+NQNtXFJ7aGLugkOjiD6OqLde?=
 =?us-ascii?Q?F8xSflQ83mygNruZuy3WCTYnaNf9+FljqOikRMlMJXTViCKXjabZt5nfbNDr?=
 =?us-ascii?Q?ITnXyyj4Lh0PCL9BZlfqLoLZ5vDc1pk2dpGaD1njzJr4Ob93TR/S9xbzhu6e?=
 =?us-ascii?Q?oFzW31EO6uAoTzlgS0vHSki6f7Ycjvt4m1pkwGc3RKd404hUc4npTHD2PWNK?=
 =?us-ascii?Q?jaawtG1N9I8HS3bdG3F9MDfdW2TEKvXSvLaXCv/KRGzeGXn5cklA1o/E2kG2?=
 =?us-ascii?Q?EFrEC1V6Q+Yd2itEQVuBYO98Z1pcGKk574gysFCiwCcFoJJayOs/3jLkgMoo?=
 =?us-ascii?Q?AKJJwbuV0SxJDxFQDY447an+U4N2zRvdamiowLmpg/YT3EPFB3L0IJPi1+E6?=
 =?us-ascii?Q?hm8m8HWS5IfOZ0SjIrhLx/P7StTtYTMdetJopGryy+YSASjTbYebkHgl0tG9?=
 =?us-ascii?Q?azZaq1M7KP1RNX0pRLEc2W8nvlT92CdLtqrr5FtZQYZBwZfykHpZWS0c2y0G?=
 =?us-ascii?Q?/G4uIm0snSiD9ALIBof5xu1844QlB/DgKUgIg/BVDfZ2ePvCU4vNkhQXNeJq?=
 =?us-ascii?Q?KDjaLPAKQK7HzXXzWfJN/p1l6Rm/cj0u68kesMKk13RZe+iKJIIPf7y3h/PQ?=
 =?us-ascii?Q?Xj8Sy5TJ9c7wJDq1lXulSbhpyf+S+SDPflnKEDsHCrMrt2wQUnZZRDq8ePaQ?=
 =?us-ascii?Q?JqxddikXjLK7iux8WMRtTgj9XLyE6+TrN8bZSPtK/g4aFd4G3mW1x8UnBl0U?=
 =?us-ascii?Q?HsSuBB3eXXmTTbMnhkXQGyV4Cw094HN8d4O6fOH01B5ItI5onR697uI+zh33?=
 =?us-ascii?Q?aevCesa9SfETIyK+dCZnaNUBGYyBlkyu/UE6P/Ea?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ffe7ab-2bdc-4ca8-7ae6-08dd4c4092be
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:10:38.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skoaY9iyuieSI7JR4yhAxHxQi3fjG912uPDy3W81vfzyBYdePPoBiQCTXbk5LVCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On Wed, Feb 12, 2025 at 04:34:18PM -0500, Matthew Rosato wrote:
> Enabled via the kernel command-line 'iommu.passthrough=1' option.
> 
> Introduce the concept of identity domains to s390-iommu, which relies on
> the bus_dma_region to offset identity mappings to the start of the DMA
> aperture advertized by CLP.
> 
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
>  1 file changed, 72 insertions(+), 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This may want to be changed to use

https://lore.kernel.org/linux-iommu/2-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com/

Later on

Jason
