Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.127
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795659213;
	b=CBLmfo5/1dyI1LdOOISH2W2Uj/MX/XrU2RrWNRrmtp8BmmBzc82f/wQRUrMOUP0+GKwt
	 efcy1FfCVTWk0RCfQpU9jMfhQMWNqsHnSGQcm9ak1kkrBISy8jwmofMZCM3acfxUZkVc8
	 GAkMJFDj5RYuVMlochSPVxo4S7HYyjs02aQib8j+NWdc4Bz4JkFq7S4KmrlXAHOkO0lX2
	 dxUaTfbfpbK6ahhUjxYTX4rNFm1NEQbmK068wvUxwPy1RYT9oFef6DaZLrUblh/WEb/P2
	 IzpQ74pbmFXhBwpHVxp9axaZj8Lxfy4anOladW2QRQQpPh6GDjtEkaxRpEf95d73aUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659213;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wQAgwCFtaZYw/5H0dfCkFCzjH+zjuUeaUjo67Lp/viA=;
	b=q0e51dGygByxbyRSqkmCJax7/22Gl3Ecx8u7Cgo+mAQgOaSKyS3TH8ICM6bQwzN2XUoV
	 /2csXam9EEFqtWJHmX2bzhJ/HY2s8nEb2TClHFk6YBl44mTMes6xF+oGnlh1mDQzlhi+V
	 KM4lKUFQDSE0+lK8b1Z6QukBpdZbarGECMg3gNZjw714Xq6Mh6kcQk7r8S9qh7skOwDuH
	 sq9JyN0lA2oUVRRH/FR4+VsJAug77rmvjGt4w2AG2YOX5aYs3fKKyLp4wrOFDXv5hgoK8
	 I7s3LXSVtHQpGLC0jfWxjmwouXfi96QfAxq04+eXHeflpfoSpmQZmHDBFvzdYorSt4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=mqkdCmOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.127
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022127.outbound.protection.outlook.com [52.101.96.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1263606A321;
	Thu, 26 Nov 2026 02:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1263606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=mqkdCmOj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWMk9HwoOb5/uKfhwWFo9V26Uz2ItM+pNe5HJW7ZqsQz0DTbpjE8wrtAGKNsW48Evuf0c/nfBMtxRVxhb05JKukmUyhBubfDkzJxwIeT6BIzW0sdsVR0GzZPvSi7U8kSUl/TpN7s0wFymKZS7w48D0oCqmk/uifz6iDNm0D7Zvsa4ipx7fXilio4GKVMvUp0TM4zGQ+pQuhDEwCs1Fa9Aq7rNS480+IVO0bCknFBD/IChaser8R5XTHzMJsUHt5hZ/6i7PrjNlQ7OBKrZS74uGPWqf84Y8TXl1iG3UKnsTd4iP+yIWeBpSt8o9y9SecIyCIXpoknYWjqxG82YvgyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQAgwCFtaZYw/5H0dfCkFCzjH+zjuUeaUjo67Lp/viA=;
 b=pdEDSExfGWlBhhk2/+hC5Zvzdc9yqzPxzF84F2vIXeIzSVio1MaGCuON2diZ6iUdPTjXj895kYahtgfTGmF9+F102FKsMXQHZ+tpCB3gajnpo4OMIPOVkfW++DQOuCvIwZCwaQsDJYP+x5eJFQFnwkWWJVg+agEkcUDqjdwotdh9Am4diPBRDti0tcWAnf5xb6AqJfpPugWfxeZgfI44U1fUx4/qP8cPgJw/FPRFVk8+PpcpSpsFIDqeFzBRpGLUXYBZnoYmB3caO+NSEqgkblAY2jopPZVkKCK9napnSpXgzELiqKCoDjEmGh1qsSOl9DKEfSmLwh+QMMwupT1cOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQAgwCFtaZYw/5H0dfCkFCzjH+zjuUeaUjo67Lp/viA=;
 b=mqkdCmOjHBor1/5HAlm4bhLFtGhhOGfsQNyS5qOdF4g019zEFMax1sAbqUBJF8OklxX+qFTj6LvV4Yz5BR9ITOew6kXh9epwIVx5hS1DeluAUFMbdaqTugjroqSxQwHMUuJFtXcWILThZPzyQZk73JMeUGica3zeGVIvfTNI990=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO2P265MB5887.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 02:13:29 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 02:13:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 02:13:27 +0000
Message-Id: <DN4S2C127FMU.1GA3O72TFAC0Q@garyguo.net>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Bradley
 Morgan" <bradley.morgan@linux.dev>, "Armin Wolf" <W_Armin@gmx.de>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, <linux-doc@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Mostafa Saleh" <smostafa@google.com>,
 <kvm@vger.kernel.org>, <qat-linux@intel.com>,
 <virtualization@lists.linux.dev>, <intel-xe@lists.freedesktop.org>,
 "Vineeth Vijayan" <vneethv@linux.ibm.com>, "Peter Oberparleiter"
 <oberpar@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 <linux-s390@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, <linux-clk@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, "Takashi Iwai" <tiwai@suse.com>
Subject: Re: [PATCH v2 00/10] driver core: Disable driver overriding by
 default
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Danilo Krummrich" <dakr@kernel.org>, "Johan
 Hovold" <johan@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Nipun
 Gupta" <nipun.gupta@amd.com>, "Nikhil Agarwal" <nikhil.agarwal@amd.com>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>, "Longfang Liu"
 <liulongfang@huawei.com>, "Julian Ruess" <julianr@linux.ibm.com>, "Ankit
 Agrawal" <ankita@nvidia.com>, "Brett Creeley" <brett.creeley@amd.com>,
 "Giovanni Cabiddu" <giovanni.cabiddu@intel.com>,
 =?utf-8?q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Eric
 Auger" <eric.auger@redhat.com>, "Eric Farman" <farman@linux.ibm.com>,
 "Matthew Rosato" <mjrosato@linux.ibm.com>, "Tony Krowiak"
 <akrowiak@linux.ibm.com>, "Jason Herne" <jjherne@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, "Holger Dengler"
 <dengler@linux.ibm.com>, "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, "Dexuan Cui" <decui@microsoft.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Mark Brown" <broonie@kernel.org>, "Abel Vesa"
 <abelvesa@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>,
 "Bjorn Andersson" <andersson@kernel.org>, "Mathieu Poirier"
 <mathieu.poirier@linaro.org>, "Srinivas Kandagatla" <srini@kernel.org>,
 "Sylwester Nawrocki" <s.nawrocki@samsung.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Jaroslav Kysela" <perex@perex.cz>
X-Mailer: aerc 0.22.0
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <DN4RPY231N71.1XDIB9HKGBU0O@garyguo.net>
In-Reply-To: <DN4RPY231N71.1XDIB9HKGBU0O@garyguo.net>
X-ClientProxiedBy: LO4P123CA0119.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::16) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO2P265MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: f4548ec8-c010-42c3-51c9-08df4b62dcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|7416014|376014|1800799024|921020|10067099003|261021135927099003|4143699003|261021123027099003|261026140227099003|261022113327099003|261022115727099003|261022075727099003|261021121427099003|261022105027099003|261021130227099003|261026135527099003|261009223027099003|261102123227099003|261028144727099003|261026130827099003|261021133027099003|56012099006|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4Tjadm5PXUwyJcL8Cx8YB2j8p66sON8XUAfyloexpoM+Nw4Z4KJ7/E8U7sL753DXkU3dJLy9+p/FEW8KnDn2vukcZFxmnbjkrUQoJInkZxg6BPT4xEbV8DcuLYDFO8V8b1BfcFOLgjswi/TPyuGX8dh9gbPsEQU4Hd9ZThcLlcFgjONzxV4Zk//Y+wPhXN/j8hOeV3HB6gCJ1b2BGUXin/8wvP3b8hEOKe/OU0q6KHErMxlmJ6GH1y/qUQ+d4uGoet07wafrSJ9BW1Tx0bd67C38ouKL7PeFZ56FpzrrhRo9VHSKQ02ISAH9IQYHfdnJ4ABiCwGsBVZFhhEtLh8hSqBvmypTXxpix6rhITqGeajCk5CACXFBTz7FCpCLenTi2oIXfC6gu325plwAVdQdOUpX9E/FV8jW3DrWsFLX94dxQTpoirKXuFTMRoN2tHLTuGgKLDrvpDka7gpcUjuutRdEue13T6MG0PAFUdn++DOqJhfJJp0NaqsFsA7X5fBCnwm1ldQgoibaldpAyr495oRN/EFRTSxqjHj7PuNhaV+UIxY0FBQoOPZvvvPd1z0DJ4YF5mtjrRkFoAR47Xk6ULLTrMmgl9LiHWRTrtwMjiBbwtnVZK0zbVDHhV/QFkC5Ee+yAAzKSza5w7r8AVNplSWkVz/Eg9U2q54LWK63XK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(7416014)(376014)(1800799024)(921020)(10067099003)(261021135927099003)(4143699003)(261021123027099003)(261026140227099003)(261022113327099003)(261022115727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261021130227099003)(261026135527099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026130827099003)(261021133027099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVdxY0FSYi80NVlIN3ZCWlpWMlhITjNSMzRpV1VaTmw5ZG9Od29RVnNFWHlq?=
 =?utf-8?B?S0J5blpaVUFvU1RmaW1YVHp6V3ZYUC94VlZXMW1COVhuazRZK2dITjliTUsw?=
 =?utf-8?B?c1RHM3RSYVMzL2NITkViVVQ4aTZZTlkvQmVHZVFyVHRwN1c0T2NXM2VNbmdC?=
 =?utf-8?B?cVBEWmFKV1czSGZYMGJjbkM1eVZaMFR5R0diVWkxS0ExU3BwV3djSTlUTzMx?=
 =?utf-8?B?TzA4M1dMQndYbENLRGFQbEpHYlhWaWJOakVqZmhNQXVtekVxYnVPdHlkNFQ4?=
 =?utf-8?B?S1ViRm01dmQrUUZZOGNrMUtRUXVXMjJTMFRDUW8wWk1rdi9qWkROL2F6Zm5v?=
 =?utf-8?B?MnFhZzE5TDdxWmt3U0xaNmpFSWVEUEJLZ3RPR0ZGdGt2QTdKKzQrK3A5am5t?=
 =?utf-8?B?cnBLRWFQWGhtYnFpTjJiVzA1bHhVY2ZnaHBwZzVUNGhnd0dyTXJBakVxR2lZ?=
 =?utf-8?B?RWxydWNUZFE1TnppMFk5bzVrOGtaVGJsRkc1Mm1iM3hESmVIemRVV3F0bDdi?=
 =?utf-8?B?M2Q0UWZxZDJmaTdtdGMxLzVjdHdubFpkbnBqTE13MENQa1Q2bG5YSmVkbWdM?=
 =?utf-8?B?NDJhQW54d2kxaWJpTnJReE4rTC9TbmVZOXoxK1pzNFd4UlUrM3BLRHRWUnJX?=
 =?utf-8?B?MzFTMzZkcExhQ25KUnVaeit5U1lJeGtUSVZzOVpiOE9GWmtDYktUdGpITXVK?=
 =?utf-8?B?SVY2ZW5RdWlFQTlJRmdHZ1NXT0FIMFBsZGlGNHFoeENqZ0ZOUlJNSDBxaERv?=
 =?utf-8?B?N1dpdHBVOUNIdmlTTXFValY4RHM1blZYVzVRM1QyWGh5aktuM0xhT3ZId2tJ?=
 =?utf-8?B?WnZtaDBmcFJ4QnY0Uyt6aHM0emduUCtIZmE2c3pzdEVtZVl4TldrV3E0eWZR?=
 =?utf-8?B?RDUwRUZqM1JxZk9uTnZpWGo1WFFhQ3pxOW1DL0k2amwzU2ZxYWQxM05zdCsv?=
 =?utf-8?B?enpUWC94eVZsRHR3NldCSytpcVFPNkZOVXNoMmRPY0cvSkRKMDJMZmNLZHY4?=
 =?utf-8?B?T21MN0U4T2ExWXlIWndmSlF4OE9LZU9DeTJteGE4OUs2THBYOFZSekM1Y1J5?=
 =?utf-8?B?NzB1MnkwOFBNZ2pMZnFPanFBM0Q5OXJVSk9Gd09xa3Zkcm5HemIzNVVjOUVR?=
 =?utf-8?B?NTJieW45UzBrMTRLeFBjcmZSWWtZS0tnQXZYNncyd3BVMEJBQys1NFVDdE5O?=
 =?utf-8?B?eEFhZjRYK0plTjNZZUZuUEZFTC9KbG1vNlk5UTEzaEJ0b09jdks1S3Y5OHFq?=
 =?utf-8?B?TVR6TWtXTk9WQnZuOE1pTDkxczJtRDdiRDZuZTZOalg5YUdXWGlCVktzbklv?=
 =?utf-8?B?RjJFMlpzczZkLzMyRlc4dHZaQXA5SnJSeFowZHRPZENMQTRsVjkxNHF5STc2?=
 =?utf-8?B?d09DUDZXYVJQYWNRanBrM1dYd05BeXpGV1E2eVdNVmR1dVUxTGRCeFVJMG1u?=
 =?utf-8?B?eTJsWG40bUthTy96S1BEMkl6VHg0WFNaYkNyL2tnSlUxYk9jcTJSWEtPSHJO?=
 =?utf-8?B?YWZCUVlXc1grdDgyS2hhd3RjR3hoL1pyQTFiMVRtSXpaTEhmdzRIQ3hObFRR?=
 =?utf-8?B?RXVEZmRkRm95Y0JzRzBsWDRoZFJ5eTBrdkFIRXYyQTg2VGZFa0RZcHJ2Mm5p?=
 =?utf-8?B?REYrald6aWdocVI2MXhwZDJPTDRrcDVpUnhvb21XbVROaXFWZzgyLy9Ec3ZC?=
 =?utf-8?B?aUFLTXRucC9PRXljZnF1amJyamxvOFRjMnAvQ25xZnpORmQ5YnFRY2dkN1J1?=
 =?utf-8?B?VEhmMVFKYmhoRFRSY2ljR28yTTVNcWFkektVc2RRM2FGeUtsRzlQcjZENHBs?=
 =?utf-8?B?eU9TOHk4WHE5bjA3OFZ3Y3Fvd2kxRzNuS2cyNTNMYld4SStDU1Vaay9zSnBq?=
 =?utf-8?B?dFJhMDM1UXNYWWhXN3FNSXNQMnJnNEt3WWdGcHM2M2FXVlVVZU53NGwrSEEr?=
 =?utf-8?B?UVpmbVBGRjZacWtZVjZ4MnRzT0xnek5LbzJjNmpxeUNHYTlVZ1FGdStZZ2xH?=
 =?utf-8?B?WXNFbkRuZGNFVndYVmFSR1VCeHJYYk5IRFBLOFhXWWxkY3FSWWNpb3AwcmJ1?=
 =?utf-8?B?MmdpOFZUQlJNRmJvRlNEWDJqZ2RRbHJOTTlKWnBjT1NmRWNnYWR3NWpyZHZ4?=
 =?utf-8?B?ZFFwT2RCdXhkNlR2VElzUFFRSCtvQ05kMVByRDFMWXFhRytua2tVb000bzNX?=
 =?utf-8?B?bVBWTjZPemxaMVd4ZUUySmdqSjhOU0FhQVFqenhkMmIyT29BeVZLbEpZM3Fn?=
 =?utf-8?B?MjZZa3dtbUtkeUtoa2E2WC96TnFwZkxOSWdRYmFKdUlnYVVoODF1eGNNRkIv?=
 =?utf-8?B?YklDNmlVa1pvODFsMU1uTWhXOHNZSXdiOWZnVXpHaitXUkswdTZ6Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f4548ec8-c010-42c3-51c9-08df4b62dcb1
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 02:13:29.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/guHY35yw70xzV0EMM2yxQMcKR6hXFiEvyhxI6qIHgbL3qi7yNU8zQND/P14Sr1VzKIJPxjBW7GJEQZW/hDnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5887

On Thu Nov 26, 2026 at 1:57 AM GMT, Gary Guo wrote:
> On Fri Nov 20, 2026 at 11:11 AM GMT, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>
>> here comes v2 which addresses the review feedback I got for (implicit)
>> v1. See https://lore.kernel.org/linux-kernel/20261116110853.3418077-2-u.=
kleine-koenig@baylibre.com
>> for the discussion about that previous submission.
>> =20
>> The objective is to deny force binding a device to a driver that isn't
>> prepared for that. There are many drivers that run in a null pointer
>> exception when this happens and only very few drivers are supposed to be
>> used like that. So the first patch implements an explicit opt-in for
>> drivers and denies other matches; the remaining patches implement the
>> opt-in for drivers that rely on it. This makes it unnecessary to fix
>> individual drivers to explicitly refuse such bindings. See commit
>> 1e50a0349012 ("iio: adc: mcp3564: reject devices without match data")
>> for an example of such a driver-specific fix.
>
> For PCI, there is actually already a mechanism for it -- override_only. V=
FIO
> devices already have that annotation. I think it's a better mechanism. In
> addition to providing a useful id_info, you can also say what IDs you wan=
t the
> override match to become possible.
>
> We can do something like this?
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2398f03a77c1..2cf4659b36a4 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -218,8 +218,8 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>  	if (found_id)
>  		return found_id;
> =20
> -	/* driver_override will always match, send a dummy id */
> -	if (ret > 0)
> +	/* For a forced driver override, send a dummy id */
> +	if (ret > 0 && device_forced_driver_override(dev))
>  		return &pci_device_id_any;
>  	return NULL;
>  }
>
> Where device_forced_driver_override your added logic about parameter and
> tainting/warning logic.
>
> I suppose the issue is that only CDX and PCI have this mechanism via ID t=
able.
> That said, other buses can gain a bus-specific allow_override field and y=
ou just
> do
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 720a72ecd174..7539b43961e6 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -563,7 +563,8 @@ static int spi_match_device(struct device *dev, const=
 struct device_driver *drv)
> =20
>  	/* Check override first, and if set, only use the named driver */
>  	ret =3D device_match_driver_override(dev, drv);
> -	if (ret >=3D 0)
> +	if (ret >=3D 0 && (sdrv->support_driver_override ||
> +			 device_force_driver_override(dev, drv)))
>  		return ret;

To add on this, from
https://lore.kernel.org/all/7008c5ea-58fd-4452-a70a-2162cc3d562b@linux.ibm.=
com/
tt looks like that for some buses, the "driver_override" is a mere preferen=
ce
mechanism and not forced override, as ID/filter must still match.

I took another look at this direction, and it seems that s390/css, s390/ap,=
 cdx
and vdpa all have this property where forced override wouldn't occur, which=
 is
probably a hint that this direction is worth exploring.

Best,
Gary
