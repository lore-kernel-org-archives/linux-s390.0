Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2478F4E;
	Tue, 10 Dec 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831056; cv=fail; b=u+GJfJBw0Cr9UyTSPy2lAJKfeFwC4lPVZXGXyG0CXh/JM5ydsuqIfNuLeijZ51Gp6PT2gic2WmZWCWg7l9tJgXUfH3YAvGx3OzTVQCN2WyzVDEbTg7P9h/1Oonx/Hmddqdw52+3NqKA7LMlufDR63JHaxc7WjMG9TVYapUNOzq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831056; c=relaxed/simple;
	bh=0mdD8rHxy1UfcsWfuAugGy5ZrlOnkd6qlh+V6Klfo98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgkSqAGRQmC5S2VMTrp3fGIAxunSCGO1QfBQl7YtWCCcSnGjjmY9LBU1Hzq7xLyNw5Rz7bVm8WKBu7q50g2w/f6PbgtsOP9KaOffvPQo8flmYdS3L2EOSCDC8AgeN8tkphrNNs6C2DicgqxhwTV2K+erI3xG3igfztX2z4J1e9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBWjReKI; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBWjReKI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNwlkMEQgfVyap9K0B8lfharZRL/Urg/mXkge8mnSM5x3oL6AN97mlicVKJ+GuVaZsJ2ory3Rh5nSurVOlvlBerxX9f8esgyZG/D4Gqb7y9yYll2mzdvAo54Y86QraLe5Gno9Bb2K7E9j735/vT0lPfejv1pZPRKxzwoxfQLA7emWvrq2jTg2ViypXmZtmhtjcbxkWffOTi/0Rc8SW0+gr0W2htpvgXw6fMmytxsno9uWToOwc+ggGf4IoMtMnm6UmSxF/CLi8BoB8W+V1Noc2OuuImum8kV1S7YKXsbkYDpGjMaf8r57fQ73ZTfaf0cDIvmzaAPPyQNAb8MZzmjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE279r2v7fQ9AibUqybEPfYtxy4WnyZ863SA1oOG7QM=;
 b=WLpYSAqlVMH8HlcaAO3lp9rfcQ0h3TxJjuEx271d6kBt1RrCxZqcQP8w/IE/zKxs1FrVMavTd59zPYQNtj/VWqIb/ypGqfKUz3Eh+tdRkl78VhDdHQeFyMHAni0jG/Cp45Ae/1Pyah89owz6FVu7mm100h0xavo1AEUsrtOS8dDcBTTbqNshDVarowmBlR4zweUR05N1+k3DBtx70eEAmDyLY+tfJxUJMQZgNlrxWLWPZ5m3eptmQ3ywwpuyW7PmnWcvLBk0vqAJI/Z+wFlNAe73SazP9wGn5+ykqgy41c1fnMR7lNtcUwJhR8y17hlM5dZigQOaqWfAA0vnKDtm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE279r2v7fQ9AibUqybEPfYtxy4WnyZ863SA1oOG7QM=;
 b=JBWjReKIEzgCJcXHyvUz4koBtV0hL3Nr/LahD2s56Gg9XyfqcxlU3S9X8yP3sI5CC1wprGt7dYU7Z3pH01OMDIzO/SoyPweAgfbc96MKHdjI5pEjoa5+EUQ2vYY+2AXcds1I9WY5dPvqajs7TFZrGZ1QnV/4e/3S0xWB56YBueID6EiAIFUm9Bjrtw99ay4B8eYzOQjUmY6hClN7HNzEXW7uEil/5gE2E930fe8nFm/V9Keg3s9czBv5yn3HNpNv1p6gRENY5+RiRgRLwzsg+0v/7GdIl+XUzElbqMFtO63IDj08CtJ03vDuw4Y2N1eK35xVBUFgVa23PoFIE6wtDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 11:44:10 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 11:44:10 +0000
Message-ID: <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
Date: Tue, 10 Dec 2024 12:44:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexandra Winter <wintera@linux.ibm.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbf55a0-17c6-4231-c057-08dd190ff65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1VrTUhYNDA0WXNOcWZsMTFMREZCZFlxZkYzUHUrZzdVV3NUbHRINURtYXQ0?=
 =?utf-8?B?WDQxS2hMVUk4ZFpzL2tZZ2pBMnZ4eENDL013WXRGMEFpdVFCaGVsUFAySjVN?=
 =?utf-8?B?WW8zekx1Qk9qTklkTFdoYmg0dW9xMU9TVkxQRGZjZnNROVhyZnZlbCtrWFpL?=
 =?utf-8?B?bGFrazlSTXZOZ1dISXpFSHBza0VEMDRUa3hvelZCdmtxMFpOckFEMTlQSE5K?=
 =?utf-8?B?WThINEh3MEtPVUt2MUhiazhlc0ZPUTgzMkpaOFU3YTNoamlzU08rN1F4azVY?=
 =?utf-8?B?bmFFNVc4eU1hWEdBbWtTZUNQMjFmLzN4UGN1RC9id2FaaG1yNWg4dCtGUHZa?=
 =?utf-8?B?YWswdHJCdS9melMzODFCTmVDTjRRRzJwaGxDSkcyV2k2QU42dG9QMWF4SHkv?=
 =?utf-8?B?RjJaRHNpbGZRNGUya2lVN29hakl3K2hMaXVKY2drWXVwK3N0NE5CVzU1cGNG?=
 =?utf-8?B?cmF2eDVvK1dHTlptMkMxYWxHc1l0SnhGaThwam9xcXgrNXVoR1E1eS83Qzhw?=
 =?utf-8?B?ajd1a0RDR3Back5xekQ3VlcxcjhlazJnbWRqeWRmUHpFSHlFRkNiWUdMQVhM?=
 =?utf-8?B?U1hGMGFGNWdKbUs3bUFzOEhjMXBaN0Y2N0Nod2lIRytKc240K0NaUUJFSXNx?=
 =?utf-8?B?SlNJd1JMaXFoa0V3WmlFWlUrNjE0L0MvL05BK3BOeFNnMzFQZTlPckFONVhP?=
 =?utf-8?B?QUlGQzExa2NBelRRZ3M5S00wcno3dEFUd2RUYmVVRC9HYVNlWHFYWm40bFZ6?=
 =?utf-8?B?SlVGbWRkejREOHpuVHNub2ViRFFLUm1kMFpGTUhhcTlWNWtobTR6dStzZE4z?=
 =?utf-8?B?U1NLVVI5aUpnUUpQUkJ1b0JjWERaWUNwUHEzcUtnLzBldllTdjRZV3hCbTAr?=
 =?utf-8?B?TDVNZHp3Y1E5Ylg0enJoWWlGUTZZZG85THdjZEw2ZTVpd0NhLytmV2FuVXZx?=
 =?utf-8?B?K1R4TTUyeklGSlpTVFA3S3VKYzNXdHJWcUZUdVJJM2NaSkV2eXczeFBrck5D?=
 =?utf-8?B?Q3lxd1AvSXZicjhxOStzS2ZvQkJxNGRjTVkzZm8reVp0RGY1QVJhb0dBY2xs?=
 =?utf-8?B?TWdiSDJ3MmpxTmVFbjBOVjJxczZXdHhORlJoeStzSWF5TTVhNVN0T3U0QTZi?=
 =?utf-8?B?d1hMZnBDMEtDQlIzN090Y0xXVzE4R3JhYzlVWnZHNzU3eHRUT3kyalJwOFpV?=
 =?utf-8?B?b1R4VTFSMGF4QzE2MW9iSElXSy9LUWVuaG5VWm1mbVRISU9MclozWDY3TzZr?=
 =?utf-8?B?bjEzajdHckovcEZlS250Rjd4T2EvQU9TNzUyM1hBWG9OSTFHY3NyREhKbTVw?=
 =?utf-8?B?NmRLREZ0b1ZHZjRsczBxa2FZTDVBWS81VmJsNy9PYjNPWjhaT0I3S2s3YTkw?=
 =?utf-8?B?NC9SWU9CdFBuUnk5enNnV2FhZ0srWmJCdytYekV0RE5qYXBvWE5jZkpZUHRG?=
 =?utf-8?B?VjZJZTJVaDRxKzRWeU5mS3htVVdocFY1dURJYUN1WktXY3NyaTFJTVkxZ1lV?=
 =?utf-8?B?L0ZJQzBKYmxJalU4UFNrblI2ajc4NHhNdFlGb0tNblNmaDJOV0FkRlRtOTJ6?=
 =?utf-8?B?L3V6bW8waWc0bDNzNDAvaWllc01NelcxZmk0bXZ6M1YzeXdtMW8xQ1JXSmFi?=
 =?utf-8?B?azNBSHNpSVN3WDF6RDVhT3FLdi9GMlo2dG13NEhMNnFaL3JpYWh0bVpxSGhr?=
 =?utf-8?B?VVZQcjB5NWE3QStFWmlqbS9SN0s0OFQxRm0xOGk2alU2WVltRDdHTS9rZWRO?=
 =?utf-8?B?VzByc0paeHRNNWJycVpLOHBwODJ1cUIxcWo5Z2dPUkhrd2M0TGR3RHVZVG8w?=
 =?utf-8?B?Tlh2TGlibU5xOTFRUjJXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFBaRVFyUmNqK0xjUk05aUVBc205eGJodnI0cTVQTXZ6NkZOUzlQSWF5RDkz?=
 =?utf-8?B?UEtLRWRkbExJdmlKWlFDUHdYc3Z3dko3T0xkRkx1QkphWFRrdk9VT0JTTHBR?=
 =?utf-8?B?RlRLeTY5cVltVVVmdUJyenJieVBtMHUxQ3gxSzBJREZvTWEwSzRHdlp1S0hp?=
 =?utf-8?B?Z3Q3dm84a1BKQUY2V2xBQnUwVEMybmZkcWlYRVZqSklZY2JiOEE5UWFsRHRT?=
 =?utf-8?B?SG8yOG5FdXc1REtjTjQwczVRSkppU0xtVzNCdndUZE5zNDQzeXFLRW5rdGwv?=
 =?utf-8?B?akpHVHNwNXRoMjhkQnZ4VUlkdXNCcW5BeEJzMjl5ak9JOE9FcU9TWUFzeTZi?=
 =?utf-8?B?U1NVUHl3WXE5MW1ZRE8xeUV6alJlZ0hyclpoY01iU0QwVFV5Y3JnbWpNbkxx?=
 =?utf-8?B?REt6SElERkxGZ2o0M3pUcjVtUnptSHQ2TGkxL0JmWTNnSmp0WEJPek1hamlL?=
 =?utf-8?B?SjQzWm9FWU1FYWt1Wllzb21OMUVsazlsMHF4QzhnU0ZEdFNqeXJGdU1XUEhs?=
 =?utf-8?B?NDF0cVFCK1NwZGVQM1h3NU1ROTN2U0xQNUpUbXJCam1rUkx5eWlSaDdWV0pJ?=
 =?utf-8?B?MTlYclhZZHZ4Q1NRNXRURlNOSVlLSTZtWHBIeEM2eEZQWUNJbDNPeUJjalBh?=
 =?utf-8?B?MnhCSU1IN2QrYkVOZUUyaVlCUWJtem5FV2NadktDYWhvazJJcm1uZ3gxOUhD?=
 =?utf-8?B?NEZQNUE1Yk1zd0p2M1JSL1RJR2RUMXB4R2dzMVhyOGVleGQyOVphMnZwd1NT?=
 =?utf-8?B?L0M0dUh3VjJ1OFlKQzl0UmtnWk8xcUc0UkV4Z2dzVkZLelFwdVFCU3BMZjB0?=
 =?utf-8?B?Wld0ejc2N3VCWDZkOVovNXRaR1VpWitJVkYzOUhhZXkvcmdhZmpwK09YSkFh?=
 =?utf-8?B?c3BRMERVWXZFUXFYTHZCVTZBZGM4aHlTVFdtRWVVbDNmTEUydkFpb3Vka3Ez?=
 =?utf-8?B?UkJtU1BOMWppOWFXR3VpdjVVQVJJSGVBQTFTWk5aUXhVTmVUSTFvS2NrMVpD?=
 =?utf-8?B?UmdqK1RkM3B6NkgyNHFIVzl4QklRd3hkUzYxOVlUdkRLL1A3VEhyUFZVQ1lR?=
 =?utf-8?B?Njg5R2NrL1JtTFRtQWl6SDBHWkhQb2J5MzlkZktiOEEzTmM4YnZWeFcxSzdQ?=
 =?utf-8?B?MCtFZVNCUzRwSG95eGp1alNUcVAwbXhTemxweUZEWEFhWFF0aEZsQ3RlRjVU?=
 =?utf-8?B?SHFFRThaYUJwZ2ZUVUdRZ3Y1d1d1dXVQNmpyQWJ1Zy9SbEp6WGtsNXd5c2dl?=
 =?utf-8?B?SDRHVGlyR0xUcVQ2THlPRFcxNXBIeExrUTZnSFdWWk92bVdrY1hhM3NBT3Zs?=
 =?utf-8?B?bUNTQ2RBWDhjTDRIYU1GY1BUSElTbDlYNitEOGRkbXBrQXN5TW9VSVFXdVZP?=
 =?utf-8?B?R1VqTnozRHVpSERtbWR1T0VQTHRKcGQ2c3FzS1h0dlRaOGFnUEhDNXVDRm9y?=
 =?utf-8?B?OXJXR3lwbmZ4azl0ZzVoQlBobXYxWUZ6WllsaWM4TFFCc3JaZEdXUXgxZ05W?=
 =?utf-8?B?c2twRG5qRDVldUpuVG1JQlJHVnNjQ1FaSCtxRGNHcXovZFNBNWZLaVk1ZEho?=
 =?utf-8?B?TUFFWUdsMEx4cWJpVU1iaGV4L2h4WEprN2dsTUFyRk9aTWtzRUtva3ltZFNh?=
 =?utf-8?B?RjJqdDVsV0pLKzFyOGtwajJFOENKZU9STWhFRENqT2xjdmQrdHNGSXp6Q254?=
 =?utf-8?B?TUhVMFNsWjBMOXpCQTl2SDRGVTN4T0p2RHQrMW9LQlh0NThFMGFkT2FiTVJu?=
 =?utf-8?B?dy9MWXpnN2ZtamRVR3g0c1AxZERlVDVlcTdRZFFCNGNEekQweTdLdW5lL3JD?=
 =?utf-8?B?QVE3b0g5Z2RkMTBpTUpWU3pudUtxSzN6T2Q1SCtBeG1IS1FHMmNnS0JKazVl?=
 =?utf-8?B?eXRtS3VQVCtSRTBTWjJjTERMTW0wQU4yWHpvbHZNY2w0cFo1NWpmMUQzamdN?=
 =?utf-8?B?TURkWE9rL3BmOXpndE5XTk8wcWgyT05NK2g2L2JxTndGYVhxaE4rSjdpSVlk?=
 =?utf-8?B?TEJPWEszOGJtWUhJMXJqcWZ0VmFpY0dVV0VPRnZpeG1sQzRjSVlSWHhjWlR3?=
 =?utf-8?B?RVJNWW1Id1VLdkN4OFpOd0kwMXRuaGowNTNNZTFHdVV6YVVpazZPUUgvWjB2?=
 =?utf-8?Q?tevM2RDiYgMIVBeNocX+q36Yr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbf55a0-17c6-4231-c057-08dd190ff65c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 11:44:10.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLIUxHM3A5MNY8BpJ5dqmb+PPxLcH1gWysFZVBQr4IohCxzlWXM/dPANtLisUSJ7+WJoKuyt9GtWDDstqPHvcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347



On 06.12.24 16:20, Alexandra Winter wrote:
> 
> 
> On 04.12.24 15:32, Alexander Lobakin wrote:
>>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>>>  {
>>>  	struct mlx5e_sq_stats *stats = sq->stats;
>>>  
>>> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
>>> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
>    +		skb_linearize(skb);
>> 1. What's with the direct DMA? I believe it would benefit, too?
> 
> 
> Removing the use_dma_iommu check is fine with us (s390). It is just a proposal to reduce the impact.
> Any opinions from the NVidia people?
> 
Agreed.

> 
>> 2. Why truesize, not something like
>>
>> 	if (skb->len <= some_sane_value_maybe_1k)
> 
> 
> With (skb->truesize <= PAGE_SIZE) the whole "head" buffer fits into 1 page.
> When we set the threshhold at a smaller value, skb->len makes more sense
> 
> 
>>
>> 3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
>>    it's a good idea to rely on this.
>>    Some test-based hardcode would be enough (i.e. threshold on which
>>    DMA mapping starts performing better).
> 
> 
> A threshhold of 4k is absolutely fine with us (s390). 
> A threshhold of 1k would definitvely improve our situation and bring back the performance for some important scenarios.
>
> 
> NVidia people do you have any opinion on a good threshhold?
> 
1KB is still to large. As Tariq mentioned, the threshold should not
exceed 128/256B. I am currently testing this with 256B on x86. So far no
regressions but I need to play with it more.

Thanks,
Dragos
