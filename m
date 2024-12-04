Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60916BE20;
	Wed,  4 Dec 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322883; cv=fail; b=Ww+UkFciqYSNIPAQt1a1GRf7ZNOYZjjns2VvC9ClydaI968tOjyLm+zCr/a2ixLcfB+Bw4VwrUbFuq8QvjM2JfD+DUsyvt/SHY0GENdc7rs43nEuHeX+gZ968a+ae5XfPyXNEyQPeGGQHPguo/6NWXzZRnHjFMv0NkD/3mmOXHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322883; c=relaxed/simple;
	bh=m9Npk4XxzYstQu0P2TcUrpJWK8X/Qhp7NhQ8uUGHB2s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYKFAgWUqCsAG2SGEgh8wmS/EQvJe/qqwPxx1oWtFF8m2+22JOPbj4io8njJi0Vql2QuFrGhHlZvNFwVY06ew8IKIXsWm7bUT2OhYWeScvduyAiTXiGXSFK6VPmHnWM5htIIJ4C7P6xjwmMDLE55URxiHhJWgzp29llEQFvt/34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OC1nvXd4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OC1nvXd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733322882; x=1764858882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9Npk4XxzYstQu0P2TcUrpJWK8X/Qhp7NhQ8uUGHB2s=;
  b=OC1nvXd4IO6rVaWBmcdQJpgQFmEXQenkuaVWzBYNrWarUDUcOinOLTrm
   xgcyvw/ES1qCblTn0WTArQGFrQw8yDunvu0S4BsoIIjtBwPhRav7QBXYo
   x/0OJksPz4qeW/mVi10Dli4K69fWwm5UTCT2qXrmzPc3BTWNCrneBRqKR
   fFpUxg3F2xvvqtGLGsgwwrgCjVN1uYuENOR6O+vgWBAfiYRkdOMP+/QWA
   SS/wE0m6iGpNjyLF9wXj3N3IOFqhmiFbGTaQCTF1VnYoIBG6HAj4vFKsw
   l93kt7ryaknvMMoGEfYOGjeTJDMVv5O7CyaPKjVrezSR4fLlyRMC+MnHj
   w==;
X-CSE-ConnectionGUID: 5gXMIgWoQISS6MEmGolawg==
X-CSE-MsgGUID: w9J0g/LRT2i20D+UdIiXmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33721423"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33721423"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:34:40 -0800
X-CSE-ConnectionGUID: 4B9RYotsR6m3SujvOoAJYg==
X-CSE-MsgGUID: SuuEIkIyRl6AkHjarNQysg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="124715951"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 06:34:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 06:34:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 06:34:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 06:34:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9Az2sWxypV/ymZ0A6HSSC8ZE8iMgVFFxYQiRlKt8naVqlp4wfS9s36kY2kSvLuGf8VTsQcWHO5iq3uFr9WJ6R0qDYBTE3tc2SQ2qKkUWISQkWz6LDM/6ZLPXGy+vYGnPaqDnvwpEuFFnQU/XA1smzLVRLb8Yrqw0EoqfhfZAXu5Y7ouuFCobnpX0YVSud8Af37eogb9AuX5j4se8670pcKHlXwWl2lQarpe65CDMd88kobfjTQTSwbzjsmAtpkhDlUW90HtHiGDDltHhOYVQW2p5Vbd72jx4h1jv/zpS+djYF1/06Sj5l1UBg8+tO4RWrbc85yb07ZZyJpJlxjVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzpgA+hcjrljoEkB4zOIcKQ6sb3gN99kNDt50evXf8s=;
 b=npQCeqLlCvgAb/ExY+2avio/Nt6MqNAYxgXGHYN85kMBTMmpz+AryPZnLBoxIZr0DhKWi7iU6SM+puoV/af25r0w5i+Uf1MPpKBpizHBbRCyXwNei71i80L6MUB2N7Tykem+/6txOFz/oqnMnpaMrqxnjjSXqY6Cq5HIR7qvn6bnqZosKBPlFx4r91APX5sEdKuvhRSJTS0vAUcAF2A0HUNN2pQ8REinhw28veeSQ5SnnnwCDTaiobA33lIUH9L4ILcLVmwsQNPJQdI20spNxDXMpZfU1hglKLY2hkjLdiTer3EG5xETmJAX4tV/XrmGM5mQiPI7OmkvIGhzRcsBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 14:34:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 14:34:25 +0000
Message-ID: <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
Date: Wed, 4 Dec 2024 15:32:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexandra Winter <wintera@linux.ibm.com>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nils Hoppmann
	<niho@linux.ibm.com>, <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Thorsten
 Winkler" <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241204140230.23858-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 02076a99-9b87-41c9-1fda-08dd1470c03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFY1K2pJTGVBdUF2ajU1SCtRTUtIajViYWpOZ2xYUmc5R1E3b3V2L01yd0lS?=
 =?utf-8?B?ZGFTQzYvQlYzRTR3RFI3bWNoRVE2QUxkQWVrWmtGSnY3Sk9YeE9zSnl3cWYx?=
 =?utf-8?B?aGxiTHVoMzRFc1RCeW9oK2dUNzVCcTdqWGNCZmIwUkU5Q21nUW9HUG94cURm?=
 =?utf-8?B?elVsRUNpM014emtpdCtBL3ErZkh6R2trMi9KaFkwbEplN1R2cUtUYkxUMFh5?=
 =?utf-8?B?STUrK1o1K250UU9sVGFQUC9LZGh1VnFyY2NvTXpJaUpKVmd2MFkxLzMvZTly?=
 =?utf-8?B?aWpneGRKVFlLVmg5dnZjYUpvOVBqcW9VZzRudlVGMmQ0Nk5zYndPbDdoV1Vo?=
 =?utf-8?B?TTlXVGhldmNpbHhURGpWNUIxZEtzWVhRekRGUDJaWjZmR09QRlA2Ym1QN3Zq?=
 =?utf-8?B?QWF2eTEvWFhJdHBYVXFSdHJpUG5uMmVkMXdNMVdqc2p4bmoyVFlKM1JLdkdh?=
 =?utf-8?B?KzZURlBoOXdrZVZhNys4dDYwdkJvWlhvVlhOTkNET2lZRjFWYlBFa2VVWWp6?=
 =?utf-8?B?eW9raWdEM3FBUXFZS1poRk9ETnBUWGNuVlNWb2lBWUlYS3g0RlZBVEV6dWhG?=
 =?utf-8?B?NmttM29RV2w4TUJnQ3RZYkx6VU5QbFdFbFV0a0x5bzg2S04zMlZDMmdlZlIx?=
 =?utf-8?B?U3E3NVc4aGlsUFRzRjZsc2RwbHpFamxGQktWM3ZYSzVuSlhrZVlLaEpyWDRB?=
 =?utf-8?B?bEF6TmhzSCtaYlRyOG5pcUZTY0M2clVQVkYzeUVaNElja0FHK2ExdmhPRTRO?=
 =?utf-8?B?Z2lScjA2U3BRU1JLYmtCWWZlc3NWZCtUbVF2RFpyUHhWSzNUNzEwRlFEYnRs?=
 =?utf-8?B?NHJOKzBvU3crQUh6MTZpK0dXV3VNVFdjV3d0VkNaQVdsdzdiMnF2L1g3d2Iy?=
 =?utf-8?B?alRVL044ZFNXWVp0UnVWcHdydEVYRFZuY3FUNUNlWnpFbkJvYUNiL2xhdjhO?=
 =?utf-8?B?MVBUVWhIQVdpUFBORkk5ekNxUEJPdHY3dTRHSDhlQzNZOEdTTmJYdDNST2V0?=
 =?utf-8?B?OEx5Wll2K21EVS9kYXJxc3QyUGxtaElQQmx2STVXRUI4anFKUjJxZkV1RUw3?=
 =?utf-8?B?TDBaaUdwamd2ZSsrbTBFUGVZREFDRW1wSzFaMDVkSGtiK0g2c3dEdXN4UCsz?=
 =?utf-8?B?SEtMMTBFd1U4QjF0SXJYd0FVN2l5R3R4bEQ2aDl2OWZaOFc2SE5kUXNGTWVY?=
 =?utf-8?B?dFNRRGN5a0JjOFF2czdLelFZV1liQTV4Wmd0a256RGNSaWx1Tm1CUGFzRnZC?=
 =?utf-8?B?aDIzbEM1ZVA5ajB1azdOT1NqK0JDbG40TkwrZ0xSUmFYeXFQWExxRmwwUUxz?=
 =?utf-8?B?clg4dWt3M0Z0aUoxTWVkd0ZyS3dyaWptdDQxS2VKL3BjdWhobE0zWjBsTUJC?=
 =?utf-8?B?bWg1cEhkRXFwTVFyYmwrdlNneFAraGFGN0dZM1V5VjkvSmVrY0NTVEJNQWVQ?=
 =?utf-8?B?TE1wS21hTnJVc2VVbytKVHpWbi9YaEg4a0RneUY3VWFBS0s5ZFNjSTVTcFVn?=
 =?utf-8?B?ZHZFODBaTlNGVGkvQnE5dGx0S3ZWRmJQaTFjOFNxaS9rbnFuNy9oUlBsZjJB?=
 =?utf-8?B?Um1DUkxwaFFRQmMwa3dHME9hdVpaK1VkWHIxNForYmFDaU9sSitXS1lLRmpI?=
 =?utf-8?B?Rjg4aDhrOStsNnRjd0JEeHo5dWpJT1YrenZaMGxvNGxJQ1NPamhhV0cxOHI0?=
 =?utf-8?B?UVNlK3ZwbTBYVDRWSDNXU05iU3hOMVVBSFJVQmNUREYxNm8xdlYxVE9HOEZz?=
 =?utf-8?B?QTZZajJFZkhPOUVvQ004YzU4SVBnTXRnNDhQdjBtTkdVdUM1cm5LVWVtWE5G?=
 =?utf-8?B?SDd4RGYvcnJrRXV4Q1dDUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2F1ZFVyTVdGdC9ORU9GV1lSWGJMTFk1anVkMGhqZkp0bndheE5rL0hOaVNZ?=
 =?utf-8?B?SjVmM1VsdVVpQkVIaGxVQndqSFZwSW5vNWpjMnlHSzAwUzFlNDJvYlRRZkJw?=
 =?utf-8?B?Y3RWdGd4RVdGRlk1VXpOdnp4N0dVL1Fsc2ZYZHM2bTZTeGMrREF0RFR3ZnZk?=
 =?utf-8?B?cXZJL2xBcSsrODd6cTg5ME9QQk1ySkpjSjJDT0YzYkRQWFlva01RWE5ENHEr?=
 =?utf-8?B?N2VJQ2tvU0huSlczcmpPbHBVVFhMbjFWUjZUczZ5bGdSbzRyM0hqYk1lWkFs?=
 =?utf-8?B?aVJjMjhJaTUxd29Tb2tZSllhYmRTeGlEUFVJTEZzd1NNaDdwRm5aUG8zTWNo?=
 =?utf-8?B?U3A5RDZmekxLSmgrcXJjU1ZoNlFNU0ZsdGZOU2JMVHZPcGxLdDZBc1BuZjJ4?=
 =?utf-8?B?dTdwODZGZTU1czBYNVpsaDJSMUkvUG9DYk8wc3JneWxvaG5HTnovT3QvTy9H?=
 =?utf-8?B?NTZpMEorVWNOWjJ2bWdrMTNlOEx5QVFneFMzZjZvblpybHhpYnF3WUx0eWpS?=
 =?utf-8?B?c2QrY2d5ZlZ5N2o3SXNVNGJsRUk4WkxUdzFoUzh5Sm9pNm1aRWxQSDdiSnky?=
 =?utf-8?B?STExV3J0eWpCQ0xrVm95Z1ZkUzRPZ0p4MEFMSjN0WmxhZTFaVkVwYXB5d3Mv?=
 =?utf-8?B?YThqS1I1U1hOdDIwczVNb1lQc3N5WUErS3BKZGtzWHJZUlIwdkcvNk1JRy9Y?=
 =?utf-8?B?NURZa1VFKzd6ZlNhYndPZTlEVWJtSDlHOENZaHhxeWRwcnE5OGxoek4zcXZU?=
 =?utf-8?B?aTU0b0lkTmxPNHN1OWpsTzFhTjV1L0Jhb0IzdStmQUFPQkkrNHBsZ29oZWRa?=
 =?utf-8?B?NFlBekZ0bzdFVFdSUXlOSVcwa3J4WFBoVGpxMEJDQ2dQV0dRc0FWaXUwaUZo?=
 =?utf-8?B?Wm1vbWJBRDN4aEFEd2hnSGRKMWdjbFA5UkdWK3VLN0dKZkl0UzAySHhvV2dr?=
 =?utf-8?B?UzZtQmNIK1A4VHlFYlJ5c0RSU2plOWZiYkRzOURBdnkwbGxYR0lVd2Y3NTE1?=
 =?utf-8?B?T0c0Qmd5LytKUXpWOFNCSDE3V04zUllCbGw1aWtCNzRONXpHdFBkMk96cklr?=
 =?utf-8?B?aHErZVpvRG85KzBDWmlPaFREczUzaERsVlZUS0YrRnNqY3Q1VUtsSGNRdUZk?=
 =?utf-8?B?VVZVVWRTTjc2OFVDaDRmbUFzeURwK25ramJrY0JOQlJWMGtxeWxQekIwOE1D?=
 =?utf-8?B?ODVYdU14RSt2YnNoMjN1Qjk3ZFU0ZVpDcDliZ1FKeGVINVhLTDZZdGRpcVFj?=
 =?utf-8?B?clRseDFsSmZ4ZmNkVzEwRDlmY3lNSGxhN0VSQ1pycGtkbmhPZmRBd2gxMVYz?=
 =?utf-8?B?R0x6cmxWNjlBTTJkUmZ0QVNRbkZ3My9RN21EeHA4UUVFS2RhaWkwYXAzVXRO?=
 =?utf-8?B?aFJPanUzb0lBcGwxNnVGMDBpUnAybDlXc2hLZmRQQ2owWForMU5pSEZ0dXpy?=
 =?utf-8?B?VTB6YXBMVGxCcCsxcTROMURhWkIzaC85a1JzQXhFbFR4UUtwb201bWRxellY?=
 =?utf-8?B?dGMwejZld0VNUVIvbVM3Q21kTFJxS2dDbXUzM0EzU0FrSnlZbXZoVVUzQ2Jn?=
 =?utf-8?B?b083blcrZVlzTmZZRm9GU0F2eVBnZFN1T1JMdlJFMjZrWmlZODYyWVRCcXpV?=
 =?utf-8?B?cm5DNVQwenNJeGhxUkhRc2o3NjI3enlGZi94MHhLRVRPN05zR3phekRreWZm?=
 =?utf-8?B?WEJnOHNpSTd5Sk1Ud0xpTi9mby8wQ1grSFJJdjF0TDA2bjhxMzV3RlB1VE5L?=
 =?utf-8?B?ZytzWGxhaVZMQkh1d3lOd29MbC9OMCsxTUdYVDY1dEhiYmk0eVVIUWx3eitI?=
 =?utf-8?B?Y01YRkx4M0pKcnc0bDdJYkdCUmhQb2RXVlYyZmxjb0ZVZEljdzlqdWdYNmlo?=
 =?utf-8?B?aTZFN2loUGhLTmg4d3JMMmFTYmJobmFVSVJ1MGhmRzhGNzZHSC9XMitRbHZC?=
 =?utf-8?B?dWtHZ1hKSExUd2M4dWdHM05IUGxJQnZzOHpLaWZqd3BSZEh2SmdySmVENGZO?=
 =?utf-8?B?b3JGOGp4MHNzcE5TOWhlakVJYUdMa0R5MUw3aFg4bmEvWlFOZUYxZXgrLzJ4?=
 =?utf-8?B?WlZFOTgydlRBWGk2WnBmbmlJMnN2b0FrSEE5RTBaTTF6N3pCZmM2NTJjczdu?=
 =?utf-8?B?bFN2RnZZbHZBc2NYUmcraVFBRThLeU8zRXU4dkpTZFBFUzl0TzhBU3BQMEVi?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02076a99-9b87-41c9-1fda-08dd1470c03f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:34:25.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbOC4egZtTzfDSUSOvzncBnulGABwA/N4w4fRPLY+9Ka7VCjfDD7aHHz3t0M9KF2vaF9Th6z46vqwnDPyOSeH2FM1WiHRehj5tUyLTN4g8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
X-OriginatorOrg: intel.com

From: Alexandra Winter <wintera@linux.ibm.com>
Date: Wed,  4 Dec 2024 15:02:30 +0100

> Linearize the skb if the device uses IOMMU and the data buffer can fit
> into one page. So messages can be transferred in one transfer to the card
> instead of two.

I'd expect this to be on the generic level, not copied over the drivers?
Not sure about PAGE_SIZE, but I never saw a NIC/driver/platform where
copying let's say 256 bytes would be slower than 2x dma_map (even with
direct DMA).

> 
> Performance issue:
> ------------------
> Since commit 472c2e07eef0 ("tcp: add one skb cache for tx")
> tcp skbs are always non-linear. Especially on platforms with IOMMU,
> mapping and unmapping two pages instead of one per transfer can make a
> noticeable difference. On s390 we saw a 13% degradation in throughput,
> when running uperf with a request-response pattern with 1k payload and
> 250 connections parallel. See [0] for a discussion.
> 
> This patch mitigates these effects using a work-around in the mlx5 driver.
> 
> Notes on implementation:
> ------------------------
> TCP skbs never contain any tailroom, so skb_linearize() will allocate a
> new data buffer.
> No need to handle rc of skb_linearize(). If it fails, we continue with the
> unchanged skb.
> 
> As mentioned in the discussion, an alternative, but more invasive approach
> would be: premapping a coherent piece of memory in which you can copy
> small skbs.

Yes, that one would be better.

[...]

> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>  {
>  	struct mlx5e_sq_stats *stats = sq->stats;
>  
> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)

1. What's with the direct DMA? I believe it would benefit, too?
2. Why truesize, not something like

	if (skb->len <= some_sane_value_maybe_1k)

3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
   it's a good idea to rely on this.
   Some test-based hardcode would be enough (i.e. threshold on which
   DMA mapping starts performing better).

> +		skb_linearize(skb);
> +
>  	if (skb_is_gso(skb)) {

BTW can't there be a case when the skb is GSO, but its truesize is
PAGE_SIZE and linearize will be way too slow (not sure it's possible,
just guessing)?

>  		int hopbyhop;
>  		u16 ihs = mlx5e_tx_get_gso_ihs(sq, skb, &hopbyhop);

Thanks,
Olek
