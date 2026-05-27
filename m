Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021080.outbound.protection.outlook.com [52.101.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54A357CFE;
	Wed, 27 May 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879275; cv=fail; b=a59nUKAp/TcYJk1vUKdvO4qS+hQZWvUtpF+e3lsSU5vOl+IPkjqdsxtZ8AinkGPxwtw0XLMk0pwBM0PJppWWQAUb7rT1HLFgdgpaTjNHun1A9wA5Qey9CBpysgfObObvbs5yv6PCLY1M1nCgyd9yNXDRru32HTGWYt2r0O+Ds9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879275; c=relaxed/simple;
	bh=Ic2kBBU1Cl9igtU0cquNDYq3Zm+lq43pYOmM7FpU07k=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=nibe3qmA8jiDz5cp34n5CLKSIMfmk8hQp6J7xcvtBHTVF+TJTYlKc53qicoFVZOwHEtEKsG4GQ9Zw/pFD6atq94U8emPK0NrKZIOc4QWMWWzdC0//3+24GuSPIdyXtW972MCAtIFfRTnnGUgpZ0j4jJudDO1j0Y8FjbPxwoubFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MZXIQ9rC; arc=fail smtp.client-ip=52.101.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MZXIQ9rC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okALZfM4hZ9FZZCyaaSNmT5RuMD/t6Hnf3IqGrInlo6YlTvIeDh7LVfQRm33IMWokpng6GLY33QiQWWArDzYDsY5nS4Drjt1nt+Ry1hPsWSx0LszfEd4loW1VWLYYeyajhEbGPzUipaimPzKU+4DmXbYw4mFp0bmJ1fw2itifbb/XYXDi1j4tsywSk/+MLzmgjqbl9roOZ1HdoXYYN/cGkeg6QwCOnmZJ3gHUOL2Q+NK5cxamsFNXkq0/v4WCtIecFjgUDRFAvR3UUE/SngFT/ZYQ8dWV08v+c2+s6vRtiIo4KuBXBW0yL+ngiEXZb+Ks9Zd0QVr215GghEyKHsubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqDS7wkVkcdoB/QVyweF9d8XJe2ABOga63/z21NY62I=;
 b=Xb+DcbvxRlbZH66FCJh2VIqPDkHixNluyPaSIRahLnYtdpkFVMq/GezJg9lF0HtGWtmdPUzSklR6aCkeXjubrzgfRZOFmFGmRtyoiwcUz6Ik0ejRxUPE/e21tfoDCaAdT/CHQaWPKCQWP7T7ofxFcO11KVtmC5KyKvlcCo25bW50Ky/hbIBmBJgLkR5hzi0298cANYyHoNtXFULMNw3faODZXPJoRWdFRE94nOzASmPNmbmNCsXlGgsZ/HeqCjyWBfCj46jO7BHwyzgVuSUzxQF4oY8TSPGbRg6b2ohzDJWMcAJiqw5gZWBiCTIFdHNHiKZj4gQ53/hjfgvTlQVFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqDS7wkVkcdoB/QVyweF9d8XJe2ABOga63/z21NY62I=;
 b=MZXIQ9rCc3xRirbjyQKPprEfF0HOfti9fLOz0Lacn5etMKxe2Aecz283ThStf+AQt7zpYl6dAyePOv6dmc227OYOPTHIS66phRqibTUzSe3+Rd0y8wrI8aMnEuPIQs5E+FMdVFjJQx/LbADRseaNimSaELk5UlC9v69q0vyXn6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2819.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 10:54:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:54:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 11:54:29 +0100
Message-Id: <DITEJKC6AXB9.2E1R65TGGTX5W@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Jan Polensky" <japo@linux.ibm.com>, <hca@linux.ibm.com>,
 <gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>
Cc: <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] s390/jump_label: Implement
 ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
X-Mailer: aerc 0.21.0
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <20260521165622.279953-3-japo@linux.ibm.com>
In-Reply-To: <20260521165622.279953-3-japo@linux.ibm.com>
X-ClientProxiedBy: LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2819:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc18f78-c760-4b67-b9a9-08debbde5400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|22082099003|18002099003|3023799007|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	34hGh/RGgJmdThUl49xyKc2aLnkDpq/PWF2Mnvdc4sD6/8zj1FS3yMJz5wLpQFzPmWujAS3H76FUAEPMDOT4fS+7dfu1g7WmBcGzcz9+9UNcri/jaGD4p87KCXignCyK4Sok8S9dnfo1MABYkGKvJYVN3ZhdOfPMzZ0NCf1ayPz7D6YvRspVohXUy2uiXs+Re1Ew+/dYrTl+T8yBcXLfnQsxnQzvGYi65FxUTyDJeai6f37nTGQxPUVL4XEPmtR2MdEnwj5+BAuuFXsloB4hPwp0pdpip7a1B+Y5kNx6+hsyt2D1A+spxy1Ja9cE7W0O+x2bvjbMP0xLCDVsWADGDBZ6Y+smpM8r2vGjksBYtATirWI6HTWJ2I2Rlg34np2mDctMb1kr9b746IbLEicmLiLd2U1N6po53wIYVlU4r7Hwspgh989m4DIFea5KkDiglsi5ApsalBBs8gROT0NRfeu7ZM91CbGJzMO0wY1VjiV+9vcxBEZ4Rlcp7kYNgCKdX5GJCPjlUp7eAF9GwJtTB8CcQQWY3cOPlhSBZzAsD40rPy+CA7xGY2kl/cI8JtKcagmRkDRY4peqFx3DrRPWVtmC1gQBqS9e9PJDKwWGr03kB7S5TU8HN4fz0TUb4trEr+72oKseMPPX0xnuAy4Tv2NDf25wJih/89KXr/08nG2TPJjo2pxNVPkr+KGS6X1K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVp2WnlqZUNDRS9zcEh2Y3I1ZjJrZzhSTFYzS3lBTFZDMDRqcVM5K254VVJs?=
 =?utf-8?B?YVRTUjU1cE9kNDdzN2dkMzNBL3ZUWER6VG80NHRLNWtvMVhxZEMwTE9WUkNS?=
 =?utf-8?B?L0h4akxZbXVseVZJb0ptYnNoTExLNHdvYnJmclNHd25MdHNSemJrYVdvY04r?=
 =?utf-8?B?THhHTTFTZUs3c1djS2VjZGdoK0t6azdydXJseEpxMGhOVDN6TSt2T2UxdGRP?=
 =?utf-8?B?TUlyMUtqMG5WKzVwZW84NmpTTDJ1bTlZbVdCdlZYaGpMZ1R3WkhubG9tNHpL?=
 =?utf-8?B?WVY3d0UyM2E2OUk0NVpodlRockRLMzNMeElOUmtKZGRtbUs1MU1zamFhNk9q?=
 =?utf-8?B?THQrZzFITmp1VThMY0N3aXZzZzF6OHM4ZERUanVKNnluZTNSRlFxWXN3UHMr?=
 =?utf-8?B?c2dUL2lBU1ZqNlBIK29CZTlJYmxJQlpqSEIrTUliNG9tazNIQlZ3TGQ3aDAv?=
 =?utf-8?B?RWtwbjk0dERxWDErciszL2ZwZGJnYks3VXpBcFJZdlNXWSs2Ris1NUxRcTVL?=
 =?utf-8?B?Y3A3TVRjMnlpdmx5cXBWK0QvM0VIZkpCWkhIRHVBMmlEb0tLcHZKMjBNdGY5?=
 =?utf-8?B?bEJVVnVqTldjRmZURFpTV0lqVWxxck00RS9MQWRzSkNVQTVCcEdidjlBcEdQ?=
 =?utf-8?B?RkNiMjZLYmM4dmZBZmNaR1lLUG04OU9yUk9JQUJ6RjhBNko3VUhpcGNXM242?=
 =?utf-8?B?emNBMzNXQkkyb1ZhdkRwbC80aERDM04rYUZBYkxPVFpPODFxZlVIWGxZbS9s?=
 =?utf-8?B?TWtvajdwcm1sUkljRHF3N0JHMzA1RFVPSFZwNyt5Mnd4TEpMaWhPT2loWnJJ?=
 =?utf-8?B?QWVKV1daY2tQV280MGI3Ukp6L01teTZ4K05TUHlFeTJ5RXozT0ZQMVZiTFFP?=
 =?utf-8?B?N3RCbWlTZWhpSWd4eGpjSy9LY29hMEFUVzBNNzNJdUZRcmRpVXFRNENQaXF6?=
 =?utf-8?B?QUJLQW9CU3Y1aFhtYjYvRXpvZTBFb1NlalRBMDVlU1V4T05uckpObmpzZlc3?=
 =?utf-8?B?UG14OGcrVUlnR09zejl6V25HUjM5aE5JT0plSGpaVEd4dHovWUlMemo3V3dz?=
 =?utf-8?B?RUw3VURuT2h4SnlWTGdhbXQ0LzY4dndvZFpQZXJ4T3hGcUppek81ekJydU0r?=
 =?utf-8?B?Q010Wk1hQ1lLaU03UHl3cW10RFJHQlhubXFQL3piMnpJdjdIaUFIUnJhU2RP?=
 =?utf-8?B?TFJwZU9zcFV4N3h2bWlWOVhyMTJOQTJxalFIbmIwQmVtS0tpaFI0YjFVNGc1?=
 =?utf-8?B?ckFjTC9NWnJ3QVBTOWFVdzN6Q2hjcVAyVFFnNERZZlFOQmFKNXo3MkxvY3Fj?=
 =?utf-8?B?ZkRhVW9LMTV4bHlmeDcrK3FtVlQ1RTF5c0d5L1dNb2I1SVJBYlpFNFNvZWd3?=
 =?utf-8?B?Q2FKbmV6Z2hrK2h0TWlTa25SVHpRSml4dmJOeW1LY3UxZG5EOHB6K21oVkdr?=
 =?utf-8?B?U2cwZWkrS1FwVWp5TDNPZnA0VUsxUnBOWVhLS2ZsbTA1TkxJTW8xajR4a1N2?=
 =?utf-8?B?TU16VkppcEVkT1hSVTBDTnJMNGF0dFhuS0o0WU9HQ2JCdlREeGJzSURuVmRM?=
 =?utf-8?B?VUVzVHBXREpRT2RXaXc1RlBSeVF1bFg0ZjZFK1AzdERVOG10QmZuR0RrdU4r?=
 =?utf-8?B?ZXltYnJVb1RaY21zS0F1c2F4b1ZWc09RMkJXbDFjbDF5Y1BDNjlPNEN2eGk4?=
 =?utf-8?B?bWpOSmwyMzZaK3BOa01FWUxTS0p4VVRFSmphM0Rpa1dYWlRYZVRKemd4UHps?=
 =?utf-8?B?cThWQktsYjJjL21CZFRkQW95Q0orQnB0VlFEYWIrVFRXZFE0S2pTTExwS2h4?=
 =?utf-8?B?UGdGSmhNUEhtYTFKbVVpQnF3N3JkQW9KVk9YSDVxWUNsQlJFY1U5QUkzamVw?=
 =?utf-8?B?RjdvQk9hQWxJM21zQnRJQ3pGVWRnKyt5Z2NFMk5Qb1g5aUFjak5MV3JpWVQ2?=
 =?utf-8?B?Q3BjeWV1V05naVQ5c2NGNzBoMlQ4N1I0Z0FwS1VtenhyUGFkUGM1MG9wZE9M?=
 =?utf-8?B?V0VQeWFJODltVzB2ek1mb2VKWVE0aUNOSDZNMXE2WDg4UjRwUkt1OTRiN0Ja?=
 =?utf-8?B?WG9YcTV1MDgvQUdxOGNtVnRyVjJmWkptdE5zMzV4Z3JqMWozUUNsZmRVM1FZ?=
 =?utf-8?B?ejZUdHZSWStYaEpDL3FoaXl1NVNiSnMvcnhldGpoUFFZUzlacTloV0tySU9m?=
 =?utf-8?B?U2toYUJ3NnFoMVUrb3ZUNGx0QkMxSVdhNi82UTU3K0hweFhEM1VHZWQzUkh5?=
 =?utf-8?B?SytOa3g1VDI1RkgrYk0raGw5QkUzR2pmSnI4UmJRalV1N3RGOWc3TzV0SDhZ?=
 =?utf-8?B?dXlIemdSNHlxVXlidzBidGx3MGVEbWgzdnM3Mk81emFWUG1RSDcrZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc18f78-c760-4b67-b9a9-08debbde5400
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:54:30.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiDz3bjFnhSui9pRfsQGu7vW/EYl6EMkKd3QkHBd9RvKMYBcjDF9UIL/akfOn4qWdy77ju8+QC+G0y6sIu2ZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2819

On Thu May 21, 2026 at 5:56 PM BST, Jan Polensky wrote:
> Rust static branch support needs the s390 jump label instruction sequence
> and __jump_table emission in a reusable form. The current implementation
> embeds the sequence directly in the C asm goto blocks, which cannot be
> shared with Rust.
>=20
> Introduce ARCH_STATIC_BRANCH_ASM and ARCH_STATIC_BRANCH_JUMP_ASM to
> describe the brcl sequences for the likely-false and likely-true cases
> and to emit the same __jump_table entries as before. Switch the existing
> C helpers to use the new macros to avoid duplication without changing
> the generated code.
>=20
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  arch/s390/include/asm/jump_label.h | 33 +++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

