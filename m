Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124A1FE479;
	Wed, 11 Dec 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938115; cv=fail; b=DaZya+JjgTQe0Z8T5zoZdQbhk576WLVDpO+Shdc/5lARMrGmrCTqROC0+CQ19U6SmecMNzVYGoo8wAtHuFUmYXpcK5Id+Fd2J4i3Lh2jvhYNxYAkrGKdDdC1xBIqZXgp4/BTvKET1C66W6IkexT2IGbb1Yzfoh7BJpFAJUJSDVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938115; c=relaxed/simple;
	bh=e4QA/Bs6Tm3d2ukAw7m7oQ1fXr+UdIHhqjSN/7Ub6EY=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=EnGttFWsCxID5Bc6hR1JzxxUYjEcSXQdGDdsjHgCDcJtMVuoa/tlVZF28Xc0wusQBnYOG9+UfhqDiIAoFZh+HZYyDq6BPgcfKbQ2EKCQihQ5rfjoMAHxxyOU/KgiuKoptseHgaqYKGUb0iz2dguqeMl5hByQd+C3kx8ueH2qEy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s83Fb3IT; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s83Fb3IT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBxw5NdFcx7LnC0qtNsIeey5CcEVlAvngvdFCvsrTNuIhLockyCkypl1Fg1zGRXt5WzatIAqH53t+StBDuE/4oOl4mEXqSfiiFxvjbbp1BKYGMBWQrb+yESHICFSGC6B/B7vFpENKprioVP5gTVs8NHIbG03g2ogf4JeYXG7U88qlrOJEmZOA0rEsWYkDUI+eqiCinezKuweQw8qGhT6eSEpkc1/M+K1z6zCJr2ZvMRMHp+4XQwdz21TeIC/L0q+7G1pZKc8TLiZys7S9EjyLWZJeTgTgLCtwBwkBfdqGMjkOkbkYpMS9aKR52zdYfo5sKBMdmZ90M0CZIzeAIx7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWOqrWVDjJxGW5o/k7JmbdPttJRKIgMcgSpNX4olI4s=;
 b=ElsSeE70lFR8tWAEamHpJJokP9n+hjVFmv7ZD5qFljq6qx3nYxxlAL09JdlfNg5F4InWi9qxk0cq5dTUjr3E6zkHSyY8vW2XX5FIwQem06QHHCZP9fxFTFgtkU43OAiPG072DlJHJfx04fqnHo7/BGTy++mpxh1Kb0vsusP6fK7ChJK8cISCkjtbF14leQ61hiS9+2goc2gAv8iGFvN3xEQS6NGZ8zvYLd8pjCzm+G6b87qcdajti6KL/NXz1hpendmgH/EYoMgHX6aILJCzMimgWoXLNdr9RrUAAEFYovpsQchvIzDSbJKq/r96/ti7sSKYK1ezzF4TrGiWHYI20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWOqrWVDjJxGW5o/k7JmbdPttJRKIgMcgSpNX4olI4s=;
 b=s83Fb3ITacvD+Xx+6wZ6njp+XYuPDOiBHzvPwvUa7GkpNFdgTc8vfjyhIT259zHl0a5w2H/cZut9hIKf1T+lGscWrBgSoyqday3JTq+roLWe6opvpOne54Sk7EM0d9AHlJajdBNSgFx9V1TIE3XPhTBSyRo61CftnhwVM0jRZMYoHDT6r0dnk78YNzNoEMOC+EdDSnxvv8K5T5pqxh9gXNYv6shCuEz8HmrGJktaX4wQHL2c5oNLsk3qDNbpXDlkzk6UoZEXadI0itpMbwHk44QEahuu1WqagjBzkV6E66kx1ulBTl9cZ2YXRHZN7oNwqLfhhHDFsYy+Ukqe0vtfWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 17:28:25 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 17:28:24 +0000
Content-Type: multipart/mixed; boundary="------------SWzPp0eAnpAzVe9mVeNnEp58"
Message-ID: <89c67aa3-4b84-45c1-9e7f-a608957d5aeb@nvidia.com>
Date: Wed, 11 Dec 2024 18:28:19 +0100
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
 Thorsten Winkler <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
 <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
 <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>
 <54738182-3438-4a58-8c33-27dc20a4b3fe@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <54738182-3438-4a58-8c33-27dc20a4b3fe@linux.ibm.com>
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ef8a23-3540-40ab-88d5-08dd1a09377f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG5EUlZ6MVZHVElQWU52b1M2N2NkbHpJYmZ6b2pHVkVqcUJ0SWpoNDVZYmlY?=
 =?utf-8?B?akM0Yk52a3NGb1MvT3ptYXNLbld1b1NrWUlVNkpHaC9MbXpadVRNR0JPOGYw?=
 =?utf-8?B?V0ZvbG5kcE1ua2VFS0xVYzJmN3l0UjFjcDZBYytCenplUUJaY28xMUZYYW1D?=
 =?utf-8?B?cm9ZLzVTV3NMZHF0aEg4elczNGt1MWU5VTRKZ0JoMWtOQjRQODlEVTcwRm03?=
 =?utf-8?B?SXRaVzJwTmpLTDBSVG90OFJMTHBpbEgrdWh3dHQwbmxyN1ZUa3VjamJ1LzVZ?=
 =?utf-8?B?alhaSC83cnUrZTVNOEdXbFkwWk9zbGc4L1VkRGhuaFBGKzVuc0RGK08yQnRr?=
 =?utf-8?B?T2MrcElvZllsS0oxYk52MzdaUXdlNnQzay8za0FqTHp3bjhOVU9MWkliNysz?=
 =?utf-8?B?WUtQNFJoL1JpUU9JbkFiZWFNYnpYQXNRQ3ZJVUhCaW1yV3hjcWRzVzhkbVIz?=
 =?utf-8?B?aU1OLzFVamJUUlNZTnZENEJ5RlNUV1dEamV3R0FHeWlMd2lUY05RcVowSlRo?=
 =?utf-8?B?V2hHM3N5cisrTDAzcVJVQ3Ewc2VsYnVVNFRrREpaTHRCeEZiZ3o3U21aYUhh?=
 =?utf-8?B?YURQTDhNbU1hdlpDUjZ4d3YxMzZCd0krV1E4NHVtZTNSaUdrbjYveU5UU0F3?=
 =?utf-8?B?RjBNL2V5MnNSS2x5elprNWNab1RvT0pPd1Jjd1BYbjJVaEttTElOMCtoSmhr?=
 =?utf-8?B?VkFRSWxleXBzdWlHYys0VWxSbVdvTjdmUGMyTFc2QURHU2NEMnNxcE9nZkdm?=
 =?utf-8?B?aVJ3bVlmU0JKeXIrOStMdEVKSVNjVCtxMjZiTTJpVUpISEFSRC9WWllTaGVB?=
 =?utf-8?B?YXplc25ZWEZiQ2VBdk00bWd3bktZbkk1R0JmbVZyYUZtWG9Zc1I4WWcrUXVG?=
 =?utf-8?B?eEt3dWdoQzZvYVBIRG5WaGZUbklscmVteHVSZGsxbDFyRjhFTWd5VEZ1MWgy?=
 =?utf-8?B?TGtnVWppUXR0UjgwK3RteDJLYkFWRG9kMW44dy9nQk1mVXV5WklsRDBRRlp3?=
 =?utf-8?B?Z1lReFFwd2xVZG52RGxJMEVlamJoK3Q2OVlhaS9ZQk5yZE5IUTFzV2R4dkg2?=
 =?utf-8?B?ZUI4MjIvUlRtQktLdHFDbmFoYndjcmExSTBSSlBXNEppZ1FCanRYTzBzOFJz?=
 =?utf-8?B?emNMRjhMMHVLK0Vva0Y0a3hpdGlWdTlhbnVhOVpOVmYrUndxektOMThEbEs2?=
 =?utf-8?B?ejkvMzF4V2cxOWlaY3ZnaUJyTThQcVRDL3hnUXFmeEozL0N4aUh0K3dZQ0Rm?=
 =?utf-8?B?TnhMTGlOakdBRy9VL0hsM08vYlNLbStPaHFHcGhheXRDMjlITkpESFlkMzlH?=
 =?utf-8?B?Qm9YSjBaZEJlYS9ja0Y0SUxkaWpNYmpwNHZwK2NCYnVGRk4zRm4vOGVyK0VL?=
 =?utf-8?B?QmtqdWVqSE0wVHBVWENMbTJrbEFvNGMyVGpwWjVlTEFUUlZzTkhGbVVWcmxL?=
 =?utf-8?B?TnRpTE92V3ZwMXdEZ3JUOG81RUNnbG8zNUw1SzQ0ZjZSbGZQbjZuWk12VG0y?=
 =?utf-8?B?Z2h0QzZQeG1nZzR4dWsyOWRHeHJvM2FZTjByY0M4aHh4VjY3dVFodFR0MzY5?=
 =?utf-8?B?WU9RVDdETFZMaVJQQThCVXNleUVZOStYd2JXTS81cWJSbjdScnBDRnpPb2ZL?=
 =?utf-8?B?ck9rSC9KdmhBS3NTZUY2Mm42QkNGbkd6VWg2aitUcy9TS0tZUkl5eWpkNFFW?=
 =?utf-8?B?bG5VYW5MZ0VNdHkxNTIxOTRFQUNQTVY4QWdHVjk2SmM5Um9BTElUdXVORmUv?=
 =?utf-8?B?Uk1JMDAyRlhMQ0FYVzhKd0VGSi9qNG1vSUl1bW1TWEljT2ZDTEZoRThDQ3lE?=
 =?utf-8?Q?bHeTigrNU1HjOAS8a/vaTTWTdzN0uh+auEY/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09UNFJnankxRjlXSnExWFZFaUJVdk9KZVEvOEIzWTM0d2F5K1lzcUVzUmFF?=
 =?utf-8?B?ckZIaDAxek42Q25kSm9ZeHhXdUhoNSsyendjYWpzQ29WQVE1S1krK045VzZK?=
 =?utf-8?B?N2VpMDg2dHE0aExSODc3eFEvZUhUTC8zR2pGZC8zd2g0ekJSMHNmOXBYZXEv?=
 =?utf-8?B?N1FTaTlRVTJXMEJDMUVEMVI2VFhKdDhXWlRiaG1OeVhsZjlPU1Frc2l5RFZu?=
 =?utf-8?B?UDMxN0tSdy8rdE0veWRieUY4TmI2VXc3a2ovanIzd2cvYVpQK0lkV0lNRDZn?=
 =?utf-8?B?SFJ5RmdtSTFZbDVHd0hRNkpnUzZyMzNEbTd1MVdUbm1US0hEbjNTVExzbmlP?=
 =?utf-8?B?T3NsRGNnQkdBQ1JkcVNJRkl2K1dhUVMyKzhXL0h1V2NSdkdZMzhZZXNMOHBW?=
 =?utf-8?B?ZWJyVGgyakRVM2lLQ1diM1Q4L1B6K2pUenVJdlgxMlJSSHVOTnBXWlBZZ3ZB?=
 =?utf-8?B?YXNaWFhuYndZQlVUcFBIRStzdUF6VFZzZG5LUlJ3N2V3dm0rZW9qTUVmRHVX?=
 =?utf-8?B?ZVNuUzhQNC9MU2N3TFNwTy9vcEJ5MzYrb080a1p5VjJFQmh0aEFocUVuNm4v?=
 =?utf-8?B?dnlTcXJqd3ZYUHZmSkwrQ05nVXNIbG83VkdZY3huUTVaSDB0amMyR3FmdDhl?=
 =?utf-8?B?RGlFNSsyYytMVUp0aXRWUkI4Qk9XQmJBUjB1Mnl4STBYcTEwYlZMTDdERUFa?=
 =?utf-8?B?NUJvc1lnWDY3bUhJN3lpR2JSbkhvMEVIa0dvQysrRjUxaGhSV1Z2cHZ3WmNP?=
 =?utf-8?B?U1lQcnBSbHIxSDlMenN0YWwrbHY5c3dlcm5XQTRRNWtEM1U0d05HMHY1NHQ3?=
 =?utf-8?B?b1NpOStyQVRnamxjdkQzek9kSFB0K2xCY0FhRUdGc2JLa0t0TE1HOE4rV3lw?=
 =?utf-8?B?RzNrdkNEZFBrOWdESkxRbk8yeFltc3NjZmJJK3o4em1VZ2h0Y0w0S2ZYcjlq?=
 =?utf-8?B?RTJXVFZyMk1WQW55SGFjOWVudmhtc2hqemIwa1REMDgvY2VBaHJQUUlTQllK?=
 =?utf-8?B?M3Y4R2cxN044V0FVeUY1V3ZvOGQvQmVIRW5NWmp4aDNRMXZxa1M4OXRjWjFI?=
 =?utf-8?B?SHcxbzZ2b2lvK004c01LQWcvY1BZbVFPWk0xdEpybElKS29CdEVXZ2Y2TWZR?=
 =?utf-8?B?WnB1SktoNEZiVGdSUkVpSDluVkJrRW9tYmZxUUxJcnRrSDdQWSs3OWtXRTdX?=
 =?utf-8?B?S3BXQWc3b2RCdkRJQnhXNnlHc3dRekh6bTlhbFFWc0NpZE5wSFBCVys0aisz?=
 =?utf-8?B?aC9Pd3pNODdnekd6eFhNaHQvbXJRYUdFNXR1Mm5oYlFhNmYzRjFTZXFZWkZR?=
 =?utf-8?B?OGdiT3AybVlpU0ZyaUpJelZ5U3A3SVZvUkxzWG45S2lXYzJkMytXTUZzMU9V?=
 =?utf-8?B?TXRyRTg4dzk0KzRkSi9ROTJTdUtQcjlBRlpYRGdXRWtVMnhQcGY4Z0dIYTdI?=
 =?utf-8?B?WXp4MVc2NHl0U0tIN29rNkRLWUNoRS82TzBTUjBDdXFlMmdSanhES2VUaUNB?=
 =?utf-8?B?TXFxL1lKZTV3SSs2YktGUUdyUWpQMFc3WTltZkgyaXRKenk0Z0RnVG9taTIr?=
 =?utf-8?B?QXVuVlpXaG5KMHRGUThlREJ5WDFXaUZRVXFCTU4wN205d0ZyVzNLaEEvdXNz?=
 =?utf-8?B?TGhPQTdGR0ZJelo4bHR5cXdaNklseUY5Zk9JNml6T1g5MXB5ZHhIR0gyaEhk?=
 =?utf-8?B?cGtJVHM4MWZzcFhMU1F6ZFp6RWU4RTBRWWVQODAxUmQ5Mll3VVpzS1NCMHhY?=
 =?utf-8?B?SXhIR050MjJ5SjNiS1QvMVFTeDhmcHlYUEVMdXl1U1czZXBHaEtodGoxVm54?=
 =?utf-8?B?ZjhjZVc1NzNpYzcxVHJJTllSQ3BTUVd0MDExWElFQytuajh5Mk1pa1hDQ0ZZ?=
 =?utf-8?B?Qmdjejl1elBxc1dCaWFoNTE3aWllWkEyaFY5MUlvd2FLOVF3TEc4bDQweGgx?=
 =?utf-8?B?eTh4L1lGWG83T3FzOE9jUHFHT2djWFR3NE82UlY3c1M2QWhOUzRCazhxWTF0?=
 =?utf-8?B?QjZOSm03OUlBS1hYZkFkdGx0RlhBb2lrckF6dnhxckVMTnhKMGgrQVFFa2d4?=
 =?utf-8?B?ck44Qzl2aStSV1l2ekkyWG1CVWtqb29rQUJDM0dIUUoyUFQxZHZENXpyQWth?=
 =?utf-8?Q?DCQiRExztH7AbL0kgeyhrGMer?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ef8a23-3540-40ab-88d5-08dd1a09377f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:28:24.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXWc6WcD5HUTxk+e13vvb79wVjxUkakRnpBPCh2aVrtIY/iC33Jk+YwUq6MR/RaVKXH39jLviCCzFSBQLs528A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

--------------SWzPp0eAnpAzVe9mVeNnEp58
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexandra,

On 11.12.24 14:35, Alexandra Winter wrote:
> 
> 
> On 10.12.24 14:54, Alexander Lobakin wrote:
>> From: Dragos Tatulea <dtatulea@nvidia.com>
>> Date: Tue, 10 Dec 2024 12:44:04 +0100
>>
>>>
>>>
>>> On 06.12.24 16:20, Alexandra Winter wrote:
>>>>
>>>>
>>>> On 04.12.24 15:32, Alexander Lobakin wrote:
>>>>>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>>>>>>  {
>>>>>>  	struct mlx5e_sq_stats *stats = sq->stats;
>>>>>>  
>>>>>> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
>>>>>> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
>>>>    +		skb_linearize(skb);
>>>>> 1. What's with the direct DMA? I believe it would benefit, too?
>>>>
>>>>
>>>> Removing the use_dma_iommu check is fine with us (s390). It is just a proposal to reduce the impact.
>>>> Any opinions from the NVidia people?
>>>>
>>> Agreed.
>>>
>>>>
>>>>> 2. Why truesize, not something like
>>>>>
>>>>> 	if (skb->len <= some_sane_value_maybe_1k)
>>>>
>>>>
>>>> With (skb->truesize <= PAGE_SIZE) the whole "head" buffer fits into 1 page.
>>>> When we set the threshhold at a smaller value, skb->len makes more sense
>>>>
>>>>
>>>>>
>>>>> 3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
>>>>>    it's a good idea to rely on this.
>>>>>    Some test-based hardcode would be enough (i.e. threshold on which
>>>>>    DMA mapping starts performing better).
>>>>
>>>>
>>>> A threshhold of 4k is absolutely fine with us (s390). 
>>>> A threshhold of 1k would definitvely improve our situation and bring back the performance for some important scenarios.
>>>>
>>>>
>>>> NVidia people do you have any opinion on a good threshhold?
>>>>
> 
> On 09.12.24 12:36, Tariq Toukan wrote:
>> Hi,
>>
>> Many approaches in the past few years are going the opposite direction, trying to avoid copies ("zero-copy").
>>
>> In many cases, copy up to PAGE_SIZE means copy everything.
>> For high NIC speeds this is not realistic.
>>
>> Anyway, based on past experience, threshold should not exceed "max header size" (128/256b).
> 
>>> 1KB is still to large. As Tariq mentioned, the threshold should not
>>> exceed 128/256B. I am currently testing this with 256B on x86. So far no
>>> regressions but I need to play with it more.
I checked on a x86 system with CX7 and we seem to get ~4% degradation
when using this approach. The patch was modified a bit according to
previous discussions (diff at end of mail).

Here's how I tested:
- uperf client side has many queues.
- uperf server side has single queue with interrupts pinned to a single
  CPU. This is to better isolate CPU behaviour. The idea is to have the
  CPU on the server side saturated or close to saturation.
- Used the uperf 1B read x 1B write scenario with 50 and 100 threads
  (profile attached).
  Both the on-cpu and off-cpu cases were checked.
- Code change was done only on server side.

The results:
```
Case:                                          Throughput   Operations
----------------------------------------------------------------------
app cpu == irq cpu, nthreads= 25, baseline     3.86Mb/s     30036552  
app cpu == irq cpu, nthreads= 25, skb_linear   3.52Mb/s     26969315  

app cpu == irq cpu, nthreads= 50, baseline     4.26Mb/s     33122458 
app cpu == irq cpu, nthreads= 50, skb_linear   4.06Mb/s     31606290 

app cpu == irq cpu, nthreads=100, baseline     4.08Mb/s     31775434  
app cpu == irq cpu, nthreads=100, skb_linear   3.86Mb/s     30105582

app cpu != irq cpu, nthreads= 25, baseline     3.57Mb/s     27785488
app cpu != irq cpu, nthreads= 25, skb_linear   3.56Mb/s     27730133

app cpu != irq cpu, nthreads= 50, baseline     3.97Mb/s     30876264
app cpu != irq cpu, nthreads= 50, skb_linear   3.82Mb/s     29737654

app cpu != irq cpu, nthreads=100, baseline     4.06Mb/s     31621140
app cpu != irq cpu, nthreads=100, skb_linear   3.90Mb/s     30364382
```

So not encouraging. I restricted the tests to 1B payloads only as I
expected worse perf for larger payloads.

>>
>> On different setups, usually the copybreak of 192 or 256 bytes was the
>> most efficient as well.
>>
>>>
> 
> 
> Thank you very much, everybody for looking into this.
> 
> Unfortunately we are seeing these performance regressions with ConnectX-6 cards on s390
> and with this patch we get up to 12% more transactions/sec even for 1k messages.
> 
> As we're always using an IOMMU and are operating with large multi socket systems,
> DMA costs far outweigh the costs of small to medium memcpy()s on our system.
> We realize that the recommendation is to just run without IOMMU when performance is important,
> but this is not an option in our environment.
> 
> I understand that the simple patch of calling skb_linearize() in mlx5 for small messages is not a
> strategic direction, it is more a simple mitigation of our problem.
> 
> Whether it should be restricted to use_dma_iommu() or not is up to you and your measurements.
> We could even restrict it to S390 arch, if you want.
>
Maybe Tariq can comment on this.

> A threshold of 256b would cover some amount of our typical request-response workloads
> (think database queries/updates), but we would prefer a higher number (e.g. 1k or 2k).
> Could we maybe define an architecture dependent threshold?
> 
> My preferred scenario for the next steps would be the following:
> 1) It would be great if we could get a simple mitigation patch upstream, that the distros could
> easily backport. This would avoid our customers experiencing performance regression when they
> upgrade their distro versions. (e.g. from RHEL8 to RHEL9 or RHEL10 just as an example)
>
Stupid question on my behalf: why can't this patch be taken as a distro
patch for s390 and carried over over releases? This way the kernel
upgrade pain would be avoided.

> 2) Then we could work on a more invasive solution. (see proposals by Eric, Dragos/Saeed).
> This would then replace the simple mitigation patch upstream, and future releases would contain 
> that solution. If somebody else wants to work on this improved version, fine with me, otherwise
> I could give it a try.
> 
For the inline WQE solution I don't think we have a large amout of space
to copy so much data into. For Eric's side buffer suggestion it will be
even more invasive and it will touch many more code paths...

> What do you think of this approach?
> 
>
Sounds tricky. Let's see what Tariq has to say.

Thanks,
Dragos

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f8c7912abe0e..cc947daa538b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -269,6 +269,9 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 {
        struct mlx5e_sq_stats *stats = sq->stats;
 
+       if (skb->len < 256)
+               skb_linearize(skb);
+
        if (skb_is_gso(skb)) {
                int hopbyhop;
                u16 ihs = mlx5e_tx_get_gso_ihs(sq, skb, &hopbyhop);

--------------SWzPp0eAnpAzVe9mVeNnEp58
Content-Type: text/xml; charset=UTF-8; name="rr1c-1x1.xml"
Content-Disposition: attachment; filename="rr1c-1x1.xml"
Content-Transfer-Encoding: base64

PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjxwcm9maWxlIG5hbWU9Im5ldHBlcmYiPgogIDxncm91cCBu
dGhyZWFkcz0iJG50aHJlYWRzIj4KICAgICAgICA8dHJhbnNhY3Rpb24gaXRlcmF0aW9ucz0iJGl0
ZXIiPgogICAgICAgICAgICA8Zmxvd29wIHR5cGU9ImFjY2VwdCIgb3B0aW9ucz0icmVtb3RlaG9z
dD0kaDEgcHJvdG9jb2w9JHByb3RvIHRjcF9ub2RlbGF5Ii8+CiAgICAgICAgPC90cmFuc2FjdGlv
bj4KICAgICAgICA8dHJhbnNhY3Rpb24gZHVyYXRpb249IiRkdXIiPgogICAgICAgICAgICA8Zmxv
d29wIHR5cGU9InJlYWQiIG9wdGlvbnM9InNpemU9MSIvPgogICAgICAgICAgICA8Zmxvd29wIHR5
cGU9IndyaXRlIiBvcHRpb25zPSJzaXplPTEiLz4KICAgICAgICA8L3RyYW5zYWN0aW9uPgogICAg
ICAgIDx0cmFuc2FjdGlvbiBpdGVyYXRpb25zPSIkaXRlciI+CiAgICAgICAgICAgIDxmbG93b3Ag
dHlwZT0iZGlzY29ubmVjdCIgLz4KICAgICAgICA8L3RyYW5zYWN0aW9uPgogIDwvZ3JvdXA+Cjwv
cHJvZmlsZT4K

--------------SWzPp0eAnpAzVe9mVeNnEp58--
