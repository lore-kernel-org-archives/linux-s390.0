Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68247175AB;
	Fri, 13 Dec 2024 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122476; cv=fail; b=QBgcMD1KgveWIoKwbGMT3PnAKTDKIYqkOfrLANspkaV4S9EgVlMNT4HhyO94+rlug7HF2alhki9DJEpfGnlhILEk+2KdYZkNAcOiEUVYWZ5AP5rynJJYqmtmbu1VT2AK+/Q3CozlQifSUIXox3iAgJePklaf48Z3uSpeL7moDwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122476; c=relaxed/simple;
	bh=BioHXjMcxiw/8tabEjoi2j8SG82LDNZ1SsGqlewTIKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQDbzniL5ZTxMMdIIn5+HyBWzS+40ftBj/ySlceXNlgXMKg87rYST8XrogldfCMScAPPEiQpe34w9LM4L0ef494v+PwmFbrcxVKYc/bx27jBDEtgaQDlMXpa2IC4d0F8f5WkbIeapnsAUmIBZtwaoSkcJYwIM7IotbMFDEFuNeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qDyppHHm; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qDyppHHm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpZy3flwqYsE6bEn2I1Zwa81N4h7dnOL17msDl9bOpjEVNar6AOaWM5ij2XfQrlWw4HCtzjyDfJTuvn1Q+1qRpuGUAhOZMya1VYBAJRn1yPksbG4e30JV19rf2JXtWmReQ3jRsRrIYClbHgm6oEjNESwIBJ84aXAXeCMUZY9xAouObpQHcm9OroI740YnqiJwgWrb/0EKOGUp4he3Smchz9Lw51lk6xi+JCCDwWcwOhdG271P4z1kFBUGcNi3FOg9zfvCBvbX09Nx7j5qqu3KuWCBprsuwiDl28Isjjj8HUWGAwp1//zK/vMSnbUnz6aRiFJmA8+8oGjUyL70kR3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0gzqR+WD3nYMfHth2qQwoYABcYZWg5zeVFJ0YJrpNw=;
 b=yHrW10jXa7uMFzDbhY/jAUqOCboJNETgTbVM/peOOxEyYDy9j4oBr2XenV2hhX6drneo8R5bIf8hTcQknmffiDegAI8El8rVGw9oYLHqsFqgMIS7uTAF1nO48I+7cFpDhP3pYjAY+k1lnkGyVOr/aWc3hg5s/0PsvBV9zhzxQeoGJRBK6kWkYsStWzZDT4NcWu4/2wc9yxUMjrq5+j9Wbb/cQyZH9L53YpYzEH11BASgl6bDlsY2ny3opUZ9u0w0B/lT1WdQ4bXkVzbdo8DA98P/B11S7ch9ol8x0ym45wVsddAUExKGVNWKErjzpRB93qcuQJi0SpCawwPeOJCEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0gzqR+WD3nYMfHth2qQwoYABcYZWg5zeVFJ0YJrpNw=;
 b=qDyppHHmYLt3npIMyrkfBpbTIqU58aTUMEE5lTBJGHvQChsT58+r3dt7sif01bNrPopOQz1UdAROq0pFdMCjdv9WwsLCXMOva8+EQkLJYnePtz5Ejbl7avcatquc4g/fPGhGr4mM8nXqjAkWzAxRFhyGasRmQXpn36RHOHtBQ7TqLi2p18eFswFhyd6Ym3VkQhiBf3PoTgIDs9UsZ/VRbblv7UIdQJfMXn1xtHspzukDRbkTAaeru6jVoTR9mTzAllrYb5VyVtZEL3KhfiUWFXT0fgAF3MsMvMDghknnBdOBIG9t9gBDUSotLKhqkkbrx3phkbDhRD8Ve/cfkgfxPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:41:09 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 20:41:09 +0000
Message-ID: <20f488f1-8f30-4ae0-8e9c-9910e81e0e1a@nvidia.com>
Date: Fri, 13 Dec 2024 21:41:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
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
 Jason Gunthorpe <jgg@nvidia.com>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
 <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
 <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>
 <54738182-3438-4a58-8c33-27dc20a4b3fe@linux.ibm.com>
 <89c67aa3-4b84-45c1-9e7f-a608957d5aeb@nvidia.com>
 <a0adafedaa41a135af28b3dc8075b8eacd22a396.camel@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <a0adafedaa41a135af28b3dc8075b8eacd22a396.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b52ae7-60ab-47ed-08fe-08dd1bb67961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZTS2FHbGRJNVFCemdiV3ZRc3hZVzloc3ZBQjRITnJwa010a3gzOXZCZEp5?=
 =?utf-8?B?dTdUVHBoUlR6TU1UNzJ0VGpaVForZFgydjZaUDVnMEJrR0c5SFpMbGMxVXFr?=
 =?utf-8?B?b2I3YWtvRG00ekJjRmdFb3I4aGRPK1lkdE1yTk5wRkw2MjVLN2pacDZScE1t?=
 =?utf-8?B?YVp1ZVRMd3AxR2huSExhNFUyZWJJTDJLSnNXMUV0bURuK2JWTWdNR3AvMS8y?=
 =?utf-8?B?cHZDT2l5Yk50aXcxV0pqQVNkbFgxbFkzM3lQYUt0RmxkSWNqamdTa3RXdG14?=
 =?utf-8?B?RXppU3J4bGdleVMyYWNmUXA2aVpMZlBFNFRJcExsaFN4N2VKa2JVYlp2VlNY?=
 =?utf-8?B?Y0F2OFc3YU81WFBTVFdXZG5nU21Ibnh1SjZwTkxWZFRud2ZwVFFnekFxcEk3?=
 =?utf-8?B?emZ0bm5ncXFvSlM0MzM0OStlYVllbklHZVlkeXp5WTcrZHpaYjhwRmZMNmg2?=
 =?utf-8?B?QmQ0eWc2R1dGRTlDek1GSU5JeGpQUXJSKys2bkVKNU9USWhNNmc2KzFHd2VR?=
 =?utf-8?B?M0xTNWxkZmtSc2toamJpNGRpNXBxdTk1b0IvNGc0bFFSMnRodnJ4aks4eVk5?=
 =?utf-8?B?NXZkMm4rbzRDK0J3cDRKT216ZFZXTlVoUm54Y0ZEOXlwZ3N1eVV5amc0LzI4?=
 =?utf-8?B?dUY2TjZtUXhJNjJ5WXJUbkJESldhVjdzY1c4UGZvejJXRzRkcTdqUHlzMk44?=
 =?utf-8?B?TFNZSzdMZ25zTHRSaU81T3FDSW5xTElHdTVwdlZ6WW9CUW5EZGRwSHZMTzk4?=
 =?utf-8?B?MWZvUVRwZVc0T0Urd1VvUVdCTGpZaW5aU08xT3pJT240L2RIclBqZkhpU3hC?=
 =?utf-8?B?RnorMkNjazk0d1gvVDdnVDMrVVdyQkNLaW5kTFp1Q045T2NpYjBxOVhsTXdV?=
 =?utf-8?B?Rk0xQVdaZVRWaFo1VVlJTGJsaEhVaE95d1U5Y2dRc3oybTdiS21Od2k5YW15?=
 =?utf-8?B?RmJZbmdDMEI2SXJ4ejdJZFg1UnFicmZQTzJkSjBKZ1Q2WjR5WHJjZi9ibzFr?=
 =?utf-8?B?S24xMVk1ak5WOGZmMkgxQ0d5WngrZHZ4azFPREd2TzlIRnFDbk1vVTY1VlUz?=
 =?utf-8?B?MS9sL2h1MWNxMmpMVTh0dVRkYmp4YUhVVXZ1U25zWHB0ekx1NHZQMkRXM3pu?=
 =?utf-8?B?b0I3OU9LQkhuUFQyQ2pMbzdnRHdRQ3VId3ltN1BWclk3UXMySTNtVm1MWGJz?=
 =?utf-8?B?MjhGLzRUSVdtUkVDZHNYdzZOS1l4aXZVU3MrVWptcHA5Q1lNbVhPU1JuVWFi?=
 =?utf-8?B?Vk1ySzZPem5TQ1VpcFdjOCtTd1NML2JpNjlreHJESWNZby9JQUlNQmVyOUxK?=
 =?utf-8?B?MUJTZW84ZVRSdGF3Nlh2N2c4Q0QvNDZvdjZqeGdKcEJJZERBWisvbmxLNTk0?=
 =?utf-8?B?M0R0SlFlUTlVWkZoUG1jb242T1E2bW40amJWVXlLdmdIZHpDUE5hYXhtRnN1?=
 =?utf-8?B?NC9mZzRIcWpDNlNDMXZjdU9uU3BVeGlkRWZhUzRpWUNQM3RQekpjdWtxMWk2?=
 =?utf-8?B?ZEdDeFc4b1JBS1FRR0VzZlJMTGVpQ1dIZEs2Y2lsZHJ4Nm1NZ0NoekxiTlMv?=
 =?utf-8?B?bnpTS0hGNnNKVk41Z01aQ0hIVEp5NWxuK1VYQWk5T0Q3L2ZiY09XdGdVN1g2?=
 =?utf-8?B?RXZLWDB1WW9BNE1OdVB0YklZaEdQaWRoMm5CV2tZK3Vad0sxM1lVb215d24z?=
 =?utf-8?B?T0ttQVFnNEN2M2pJZ1BZNTlyZWtYM2pja1hwU21xa3NkdzNkUFlsK1pjTGEv?=
 =?utf-8?B?cjdBbVh3UUJscjB3RmhwTU55c3BnNkE3VitYNklwSkxJQ2xXWHpyNlNPcFBo?=
 =?utf-8?B?cSt3aGJaSyt5dk9aWEwwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWUxT09VYjYwbGN1TzM2R3drd25LQ1RtZzhzeHhETUpxNGRreCs4TFRwZ1l6?=
 =?utf-8?B?TjJCMzI3RWpjUjFJTlZsL2QyckpGZkNiVWJNNi9mNjIxZVViTTdtazlPRzk4?=
 =?utf-8?B?NmtzZ3Z1SnFrcms3K3hYTGhvL0loelI1ekxTWG5OVVlnaFpDbzhJL2Vkb2tW?=
 =?utf-8?B?elgyWnFQdzh0VWFFL0FLUzVkYkNxYXlEQ3ovQlRrWXd5eHNaZTNEdGNBOUZl?=
 =?utf-8?B?UmE5L2EwMklpVGY1dG8zZzErQkl5d0N1WXdGdDhXOGV0bFJPZk9kelRxWlBO?=
 =?utf-8?B?Qkg0TFdyNEdYVTdFbVhDTXBrTGsvOExtSDBQSWpqTnd6WEtnWCtVbUpreXVw?=
 =?utf-8?B?QTNIdFpXbnZyN2NjYk9RTzZIaU5lQTVXNkdXUXFvMUY5ay9ZVGZjWHl0OFRr?=
 =?utf-8?B?bW1Cd2l6dnpFYzNzQU8ra2lOcUUvdStGVEFtUGFSZU9BclhoVExLcXc3dHcz?=
 =?utf-8?B?SlExOXluUmkrY3pHTHhZb2trSi90M2lwOG9obDFjOUM3MVhsUlNDb0RGOGFP?=
 =?utf-8?B?M2JiNUVRUjdjQm04UHVvN215THZHRDZhK2ZBQ21DZTRpZkJGMHhwRXJteWkx?=
 =?utf-8?B?VG8zRmhPVmZscGo5eDJXRDltWlNDNU5tamY2cjFESEk3NW9laEI1cW16SzRs?=
 =?utf-8?B?Z2tTOVpWUFRkYkJUTEErVEhoc002eTIrVW0zdTYyMjJIajRjclNtWGZSMENY?=
 =?utf-8?B?NFRkTE1abFlLZmVneGdxOXRMUlJUdEFPVHNqaGJER0N2OUR5OEJtNWlidTcw?=
 =?utf-8?B?MWQrbHRtcVZBYmNRME1aZmhVS3ZJNTA5dElxSUZzVEIxNXNWNEtjbFpKbGU4?=
 =?utf-8?B?TTMwWkhnNDFqaHlZbVRNRDFxSHk0THpkZTRnOGprRnVXNTVneTluYVU4Mm1y?=
 =?utf-8?B?RWUwR2czK2dRUEhXQklhSG9xN281ZFNkMytsbEl0QWVuQnRwT3V3NnRLdzlF?=
 =?utf-8?B?QlZ2amg0STJ2TU9jbUhkRFFDdXlCcHpqc3RDYzVOa3V6ZUZ6Z2t2bmYvOTRs?=
 =?utf-8?B?dUNaZS96QVFid2dyUlJFekJvWk50RUxyZmNCNWRaRmZ0c25YK1JtK1pQTDdV?=
 =?utf-8?B?YTU3RmQ3V3VZaGt0bFcvZ1dRTDlGQ3RVTXdwMWRhanF1enVhWURDcTlmTDJr?=
 =?utf-8?B?eUxtKzNMTFpOT3N2WldjTFYzTEJZTHZlMkxVeEZxNmxOVDFib3hNUmRPTDNT?=
 =?utf-8?B?em1NNDAraDZCclRqOGd2U25hOG81S21uYkRPbWdsU2JsOUtxdDM2ck8vOTBq?=
 =?utf-8?B?U0IzSkVhb20ybG5LR0ZLRk93cjZ1ZUdHanUxaEFybnVQUXI1R2M3ZVZ1U0s2?=
 =?utf-8?B?cVNBTlZCZEpkem1UUmdoU1BibzViKzRaS0dUQ1pPRUtaZXVuUFhPL0YwMkIr?=
 =?utf-8?B?WVhuQTJraUtra012T2RMSHhia1ZVSTBnZzBwL2VmMUlGRHFpMnRJY1RqT0Vo?=
 =?utf-8?B?Y1daWkd4WkhScUJoTlJBdGZUUkVXcEJFaTBEL2VyVlNyY09KN0Nsd0tRZWNv?=
 =?utf-8?B?a0RjUEhVRER5ODVnNGFlMTdNYWwremFYc0RaVGo5cC9zajVmV3FSRFRWVGlZ?=
 =?utf-8?B?aFRvTVRuWS9WYjljejNDTVlyL0t4T2poOU1GL3RVRFFORWJCYUZVeUI3bjhG?=
 =?utf-8?B?MG5oL0lhUncrQWhhVE5jL244Y3RHOEF5UjhxaWZRWGw2T01BNDhML2hkd1ov?=
 =?utf-8?B?dmhSVGxoMGtpd24yV2Y1RzBBakU1Kzd3VTVvcnpKdHVmOUwrOGFncXZCZCty?=
 =?utf-8?B?cE1lTmlQVHpUQnhGMCtiNTRDanpacnVWQVlRM3hTN2dCTVljRXM3R1RTYXN2?=
 =?utf-8?B?WFN4d2JHZmlNQ0l3R05YclR3ZjU4elpSdUl1M3FMQUNLY2xNQXk1Q01ScytG?=
 =?utf-8?B?Yjh4endGSnc5UzczNVlJYkNrM1NrOStTbFozTTI0ZExtejhLU2hiYjFOdDVB?=
 =?utf-8?B?Sk4xYkhVeW1OV21Cc21NdVN2WERnNXY1TDg1ZkdLNEgvUDJSNXp5L3RkN1N4?=
 =?utf-8?B?aFdVaHlKKyttR1NsS0t6bmtYamNKWXRQejRjNzVNZnJ3UTRzdFZ2SkorQTlh?=
 =?utf-8?B?YU0yVUFsVmNRazBYc24vS3Rja21kK2dQMVg2Q0s5NjgwZTBFV1VFMkdRZXlT?=
 =?utf-8?Q?nHFSAxyrjiuZiqt/do6FBJHVr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b52ae7-60ab-47ed-08fe-08dd1bb67961
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:41:09.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9ceMjLNKQmaLbmBsVNuhlOzCXJWRItnKybpjJtDZvOedaTepJRnb3BF15K/xC9g1tzSFUo8e2pHvN4dKv0nEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715



On 11.12.24 18:50, Niklas Schnelle wrote:
> On Wed, 2024-12-11 at 18:28 +0100, Dragos Tatulea wrote:
>>>>>>
> 
> ---8<---
> 
>>
>>> On 09.12.24 12:36, Tariq Toukan wrote:
>>>> Hi,
>>>>
>>>> Many approaches in the past few years are going the opposite direction, trying to avoid copies ("zero-copy").
>>>>
>>>> In many cases, copy up to PAGE_SIZE means copy everything.
>>>> For high NIC speeds this is not realistic.
>>>>
>>>> Anyway, based on past experience, threshold should not exceed "max header size" (128/256b).
>>>
>>>>> 1KB is still to large. As Tariq mentioned, the threshold should not
>>>>> exceed 128/256B. I am currently testing this with 256B on x86. So far no
>>>>> regressions but I need to play with it more.
>> I checked on a x86 system with CX7 and we seem to get ~4% degradation
>> when using this approach. The patch was modified a bit according to
>> previous discussions (diff at end of mail).
>>
>> Here's how I tested:
>> - uperf client side has many queues.
>> - uperf server side has single queue with interrupts pinned to a single
>>   CPU. This is to better isolate CPU behaviour. The idea is to have the
>>   CPU on the server side saturated or close to saturation.
>> - Used the uperf 1B read x 1B write scenario with 50 and 100 threads
>>   (profile attached).
>>   Both the on-cpu and off-cpu cases were checked.
>> - Code change was done only on server side.
> 
> I'm assuming this is with the x86 default IOMMU pass-through mode?
It was in a VM with PCI passthrough for the device.

> Would you be able and willing to try with iommu.passthrough=0
> and amd_iommu=on respectively intel_iommu=on? Check
> /sys/bus/pci/devices/<dev>/iommu_group/type for "DMA-FQ" to make sure
> the dma-iommu code is used. This is obviously not a "tuned for all out
> perf at any cost" configuration but it is recommended in hardening
> guides and I believe some ARM64 systems also default to using the IOMMU
> for bare metal DMA API use. So it's not an unexpected configuration
> either.
> 
I got hold of a bare metal system where I could turn iommu passthrough
off and confirm iommu_group/type as being DMA_FQ. But the results are
inconclusive due to instability. I will look into this again after the
holidays.

Thanks,
Dragos
