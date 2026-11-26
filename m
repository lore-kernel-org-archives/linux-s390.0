Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795658243;
	b=B5OI/S9TGoqNEhVRmVNXDGMK6v0JQbA+XY1qyzdSWlFa4A1q2PF4cDu8IX2hklomTS7M
	 X5soeIMeXHrs1qi3jdsnhXVfYWVzhj/G9h0vOQ44tfjmLeoDK9tzCOHBQe3amNMttgRLU
	 Vgr476/uNLb8xaJu+V18q0lg9ww4z4zw2UZQFqZXymg0AN0+Qk8d4uyx9tM3w7J5iZKYC
	 U5Za5/1AS8YNYh8wY7Q5YJeiJLf4Rfo6WVTP+rDwNGC3Ma//ILw6bhAFx89a1tDPJt72i
	 UWvFZic7ubsTlOwNyGy5Cul4ffoJgx54Gv49ws7OG2ZB5yqz2maEqvMhFYlE9BqYkcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658243;
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
	bh=wQwwexXKfYFWLv1n/CIfr1L3KdteJx8RrqGgVwMsGMs=;
	b=wxf38g1PKcsppfl1XyZIWb3Tt0DJl3ZdSiKVWqsZB/cDIe8y17bE1ai+hPAsvf5Vxu58
	 YT5ZyhtaiCsIiVZdAShKhf688SF8AAZHs2Dam7diTD3w2zNCW4HZoiUn8o1y/eDWQWCkG
	 BGY41CaUYkmPe9Vejih+23tuCj7rr9IIbcI4VzpLVbm5zMe0JbbBrD5uJyf6TLR9Ztno2
	 EVt0Xhq/aocGVoFIJw293fXI7/k8PwXgvZjGvPVTYAU0wYro1Cx66N0LO6SQ4RlUEW58i
	 ilOICWxIsj+hCWlmUS+/yajcIfZ7ohPKRgLnkfuMursTcJvI6fnaGR+wh2yBBR+3PAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=LDPMac3Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.74
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021074.outbound.protection.outlook.com [52.101.95.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA945606A323;
	Thu, 26 Nov 2026 01:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA945606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=LDPMac3Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugfqusank+TP8RlvX3IDp3uNNlNYMgA/pGtZlpT6ERo0HOeSiz7JowvWrPwd6pqreGz8kGZDPTiEN98Simxg/kFBG+xuxLG6rK5wtouDZSqroquswv8HD30WudB0OkXmq+aohbqbkNSG3ILeQCscdShWpOwsG0/DvMa56FImzZhCpV42vqbEG7FQEKVPxvQm/T/9uc3RhrCpjnDISZfTdfAUiLX3FWskMbho/8ZXXPfsdHfYj5xHypIUrCr5/YJnEU7CO7Q6Y85z9YwWQymkLjMX06tCDavMP8Fb2FKT3I5/27rgskDpemRPz1eUMMFmlpTit/uwmteF93jqxged1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQwwexXKfYFWLv1n/CIfr1L3KdteJx8RrqGgVwMsGMs=;
 b=MyvVld5HyWosyAlQ4eNIATC2OJNSNr4sqSl5izwZxj2nXlXXHeV8jyVSphViBzVv7tSSZ3QSDtN9M9hniRFjDpkfMG+D5OY/TK9H1UoWRxmUa7QFnw1pzd+SZfMFylUzUm9cHuFYIcnwRahLHvEM5O+e3mP8fVGOMstDZzQRoocgvHH2dOClYqzAltdtdWXLkvx0KiHKOP/zrCMvaqjJKTQ4Np+Vz++fF4Dx+goh5fwe6cNWPlozr+6GjNwHyByxCuoPBiJC/njpLZ1Ayx1zkD+PK8UI6lUhoyWoZ2v5/hlj0KGx9fD7538mkjN2q41yJKWvImgrxvKWnlixNucrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQwwexXKfYFWLv1n/CIfr1L3KdteJx8RrqGgVwMsGMs=;
 b=LDPMac3Y6lLbY06bE/y9PXx8ip7DqHVV7X4+qs+V+Noy8Iy1yRt3Cx6jgWMi5bHlYQc7UoiTx45FasGzBeHv4dF9VA5Vj7OMLmoNnGt56TU9e/4rY0LRxRWHI4/w/nuK2ijlsm1xh0mebNcwIg5Tp9SunCFxmqM4rGw64A9CRwA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CW1P265MB440877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 01:57:18 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 01:57:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 01:57:17 +0000
Message-Id: <DN4RPY231N71.1XDIB9HKGBU0O@garyguo.net>
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
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Johan Hovold" <johan@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Nipun Gupta" <nipun.gupta@amd.com>, "Nikhil
 Agarwal" <nikhil.agarwal@amd.com>, "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "Longfang Liu" <liulongfang@huawei.com>, "Julian Ruess"
 <julianr@linux.ibm.com>, "Ankit Agrawal" <ankita@nvidia.com>, "Brett
 Creeley" <brett.creeley@amd.com>, "Giovanni Cabiddu"
 <giovanni.cabiddu@intel.com>, =?utf-8?q?Micha=C5=82_Winiarski?=
 <michal.winiarski@intel.com>, "Eric Auger" <eric.auger@redhat.com>, "Eric
 Farman" <farman@linux.ibm.com>, "Matthew Rosato" <mjrosato@linux.ibm.com>,
 "Tony Krowiak" <akrowiak@linux.ibm.com>, "Jason Herne"
 <jjherne@linux.ibm.com>, "Harald Freudenberger" <freude@linux.ibm.com>,
 "Holger Dengler" <dengler@linux.ibm.com>, "Haiyang Zhang"
 <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui"
 <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Mark Brown"
 <broonie@kernel.org>, "Abel Vesa" <abelvesa@kernel.org>, "Stephen Boyd"
 <sboyd@kernel.org>, "Brian Masney" <bmasney+clk@redhat.com>, "Jerome
 Brunet" <jbrunet+clk@baylibre.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Srinivas Kandagatla" <srini@kernel.org>, "Sylwester Nawrocki"
 <s.nawrocki@samsung.com>, "Liam Girdwood" <lgirdwood@gmail.com>, "Jaroslav
 Kysela" <perex@perex.cz>
X-Mailer: aerc 0.22.0
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: LO4P123CA0280.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::15) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CW1P265MB440877:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6b3e52-7308-474c-3d8d-08df4b609a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|921020|10067099003|56012099006|261028144727099003|261022105027099003|261022075727099003|261022115727099003|261022113327099003|261026130827099003|261026121527099003|261026135527099003|261021135927099003|261021123027099003|261026140227099003|261021121427099003|261021130227099003|261102123227099003|261021133027099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8V8vcfFOw3oTrfc5RNxlZ5r0UkjYbCTU8eeisaf9JPjmuGWUs6rUGsW54CbWqsDGswx0m88s9bF37FBMRApCiYCcEY4owfPaM5HyBlKOnm/tviHhAzOofE/ITqM53k6oZ355aKBKCIuljeBvojZq1IQk1oRcK/bfPgNKbPaB+IQabbSWHPfbZJBe/WLAyx27ynBmbxqzhADC1Azk6Gi2sUuvYxCkH5rBxBr9GusLXf49TeP/kY0fAxhnH6I3yDrNLwXMc2s6fIyOrykAJH2LxCux4bOWcHHB1TdY7P+++OD/U5ybfgf0dDmXoPYt1DHqoZQssSJtNO3iqNHBUdpHLW2KlahyudHxNwj/c09SmDj90wycSVMzB7kNwrKaro74J+IJ27AX8zdQezVwhebAJ//FJcCmisGzK8qwLezvNj2ZwY6xwCVEhljaIEMBe4YwnoMB3jqwOvn3/jDCzvkbLr/w/UlZwF0yu8ya0LmsvlD65/CJvkZo5yivCAOctyYBdQULFzCjr3BNtOWz27oV5d9Suto6DURERR1hQ+zaZ0ji/Vw9dO6thGjdfrAoWZy2fc79LUU8ge2TiqwLUrGFCPGuUSUzv2wdwRqdFSC0ldUddjm3P4GoaTj3iIAHngRZegpDFawCRB6870XfYrYR0fqfrT/yeTZmm0SGOP40A94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(10067099003)(56012099006)(261028144727099003)(261022105027099003)(261022075727099003)(261022115727099003)(261022113327099003)(261026130827099003)(261026121527099003)(261026135527099003)(261021135927099003)(261021123027099003)(261026140227099003)(261021121427099003)(261021130227099003)(261102123227099003)(261021133027099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlE0dHFLNmVlMit5NSt0aCtqVHJrS2dTaGN5WDFsSXlIckIweDJiWlZURDFN?=
 =?utf-8?B?cVZucDR5SG54YTR3NXNUdlZ2VUw0TDdRdVR0Tzc0Ulc1YmFvTWFMRHU0TW15?=
 =?utf-8?B?em1xd3lRaCszUDZqZUVFc0hzdjdCN25SZ3ptbHhPMnEzK2w1ajArbjFCM2Ns?=
 =?utf-8?B?RmFSOFNYc2Zna2kwZHlkVDZzQVcvbVoxcFZYYVYvODYzMDhMNC9rVDdydGcr?=
 =?utf-8?B?cGZpaUQ1RUJMaS9TdjlRTFRRTE1YZTY1Mytwbm14cWJvK0Nydjc5NU1aSVpu?=
 =?utf-8?B?dThobzhQdzNhYXdPWWprVlF2amlLUTBDNzgzdzIyaEN3RU1GR1ZzVUpMc05q?=
 =?utf-8?B?UzhWUk5jSW9nMnIxNHp0Y1NGNXM3UU5Fd2xMNEttQU5jcnJQZ3VaOFFPTktW?=
 =?utf-8?B?dGtoVXI0UlVQT3IxemFlU3hFbXVJd3VIOG53Mm5LN0NhWWFwY0J6bk5SNGxH?=
 =?utf-8?B?SzlNOEdCQWVwZU9zNmJiUTJyeElDYUtCUXVYdWYxa2k3aWI2Q01wa0paWURv?=
 =?utf-8?B?S1B4OEpkMjZwME9wZUlObU44UXVJM2pKbVFVa1UrQ2FYakozeDFGbXlJaGZH?=
 =?utf-8?B?bWNMWGtoZGhkdkl0V3pGVmZwZlJibjBDNlkzeGt6dk56cW5OelMrMzluYzBZ?=
 =?utf-8?B?TlREOW1rMU9tOEQ0WXVTT2YwdVlybnRVVnAraE8rbEFVRmtCdG5oL2NYbGh0?=
 =?utf-8?B?ZzUzaGJScy9ZUmhhYW1kSGJndUttM29HaC9ZTjNKcmc4akxYbXc2T1dFT3Jh?=
 =?utf-8?B?T2dzR1ZLRXBUajhOTlMxR3F0SE04eE1xWG1QYkN2TVdnZjU3TjZYcm9uZTZa?=
 =?utf-8?B?Vk5kSVRJRHFNZGlUYld2RHJVaHgwcXJQblA0ZENVVjk4cVpxdHF0Tms2N1dS?=
 =?utf-8?B?TGZiZXk1REtYWHdZQWlLV2Jrd01IalNaM1dCQzc4RUh4U3hqYVl3b0tIR2l1?=
 =?utf-8?B?VW93QW5BVndNbzVRdFg4SERweXE2TDRFcFF2bDBqakplOWFTV1FCdmVLaGRw?=
 =?utf-8?B?Tm5XNW9BNHZhdHF4T1FwV1BteERaWUNJTWdBZEhBVWFFaVNRNzR3LzFaUjNF?=
 =?utf-8?B?ZW9PdWRJcW1wK1E1b0FrRTk0T3pXU29aZThyN0JranVWSnN5WmY1eFVZbk9k?=
 =?utf-8?B?QlZNNGRFTlhReGdJaXBNUkVpQ29tejNZT292UkZOYXh3aHRGZlV6TVFkdHQ5?=
 =?utf-8?B?UGtNNlNQTEtDNVNZaFJZcUdNcDlDczJacnRsMmVtMW1XcFAxQW8rcXBNWnN2?=
 =?utf-8?B?dFcwdHdGOTJva0h0dnlkMlE3VU5QMXdtMmY5ays4Y1lucXlYdzNMNDdUTUNW?=
 =?utf-8?B?N2lVSy83RjdTNGVyZmNqTnJ1STBKOFNLNkNCY2lOamRRdnBnSElySEU5VjVx?=
 =?utf-8?B?VzRpSVlBTkIyWkF0U1NnQmxKajVhU3dyYi8vYmtsK0xVTHRUQkhuL3hmUjB6?=
 =?utf-8?B?RUJVVEpuTHJ5Sk1rU3pVUVZNZncvYmhHczkxNC9yWUNrZHpVN2xLSmd0Lyt3?=
 =?utf-8?B?VnpFTXdlb3I4RDJ5MHRPTHhWTmsydUhwVDhNVW1BSlQrR3FJN2d4YmpOLzNh?=
 =?utf-8?B?Sm9tdFI3clQ4SSs4ZlNxeTJvTDhsbk1maFRmOWRxaVpDNUNVcjlLaU4vREt5?=
 =?utf-8?B?SVptc1BVU0FwY21Jb29iUm83bUpDTUxwUDYxUExiSzRGOWV4UXc2cXQ5b1pm?=
 =?utf-8?B?WnJiZTJHSzd3Sms0b3pkWnk2L1orNGlTcldpQ3g0SGtxa3VIam1leDlIeUtX?=
 =?utf-8?B?REdWQ3EwTHAraE8xekRBdmRlZGZUY2V6VFJsZVpSNUpMRXNTbUZCMTdrcEhG?=
 =?utf-8?B?OS8wSDNJa3Q0Si9hak5PSHlPUnFqSHFCcWFOTStybHIzYm9kRTRjbUM3Ukhl?=
 =?utf-8?B?RnpPUUxNbDRLVmNpd0t1UktvbmowaDZCU0dZWG83YjFjbkZzQkU2cTFuSWps?=
 =?utf-8?B?S1B6MTdGdGc3VE80anVxTjMxQ2g1Q090ZS9iTk5nVVlkQUFKQkZnVzVaUVd0?=
 =?utf-8?B?ZTFXR1lVblRlME54SFNqU3lpdzNJekNoSXJLcWRqalVmSkxnZC9VL1MwSVN0?=
 =?utf-8?B?bVh6MS9HOG1XendIS00xbmZoTmxoQVViTXlyVFBVZVVWVEJsZG54bzFydlc5?=
 =?utf-8?B?YkMrL1pNUjh5Vlk0VmRXMnk0bjRPVFZIdE5oVGo4UkY5TE9IT3hWNVhCZURP?=
 =?utf-8?B?U1c4M01QV0MvVkU1SEc5QlBURVlJYjllMDB1dWFGZTUwK1oyVEJMK2lnT1FB?=
 =?utf-8?B?Y1ErVVgxdzBjdlZueXpmZnpKbEtMc2hEbnQ5OVMzNXE2a0NyQzFwLy96R1Ur?=
 =?utf-8?B?MlpwUjRiVDA0VDFrTXpNSkE3Y0R0YjliRzAyR1pYdDAzSlB1aERWQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6b3e52-7308-474c-3d8d-08df4b609a1c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 01:57:18.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5UFEh+CYdQxw1WOmqNHFXtH2C08DBwEU0PoDb2ICDRigteYFynBMSa6mCshbH9bRHtvHuhtyHKtqrrkb13sag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB440877

On Fri Nov 20, 2026 at 11:11 AM GMT, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> here comes v2 which addresses the review feedback I got for (implicit)
> v1. See https://lore.kernel.org/linux-kernel/20261116110853.3418077-2-u.k=
leine-koenig@baylibre.com
> for the discussion about that previous submission.
> =20
> The objective is to deny force binding a device to a driver that isn't
> prepared for that. There are many drivers that run in a null pointer
> exception when this happens and only very few drivers are supposed to be
> used like that. So the first patch implements an explicit opt-in for
> drivers and denies other matches; the remaining patches implement the
> opt-in for drivers that rely on it. This makes it unnecessary to fix
> individual drivers to explicitly refuse such bindings. See commit
> 1e50a0349012 ("iio: adc: mcp3564: reject devices without match data")
> for an example of such a driver-specific fix.

For PCI, there is actually already a mechanism for it -- override_only. VFI=
O
devices already have that annotation. I think it's a better mechanism. In
addition to providing a useful id_info, you can also say what IDs you want =
the
override match to become possible.

We can do something like this?

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2398f03a77c1..2cf4659b36a4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -218,8 +218,8 @@ static const struct pci_device_id *pci_match_device(str=
uct pci_driver *drv,
 	if (found_id)
 		return found_id;
=20
-	/* driver_override will always match, send a dummy id */
-	if (ret > 0)
+	/* For a forced driver override, send a dummy id */
+	if (ret > 0 && device_forced_driver_override(dev))
 		return &pci_device_id_any;
 	return NULL;
 }

Where device_forced_driver_override your added logic about parameter and
tainting/warning logic.

I suppose the issue is that only CDX and PCI have this mechanism via ID tab=
le.
That said, other buses can gain a bus-specific allow_override field and you=
 just
do

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 720a72ecd174..7539b43961e6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -563,7 +563,8 @@ static int spi_match_device(struct device *dev, const s=
truct device_driver *drv)
=20
 	/* Check override first, and if set, only use the named driver */
 	ret =3D device_match_driver_override(dev, drv);
-	if (ret >=3D 0)
+	if (ret >=3D 0 && (sdrv->support_driver_override ||
+			 device_force_driver_override(dev, drv)))
 		return ret;
=20
Thoughts?

Best,
Gary
