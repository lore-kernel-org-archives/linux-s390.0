Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290353AD506;
	Mon, 21 Sep 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974772; cv=fail; b=EvFjyg5laVarqSTE76qXqcC81wOICYYg7Q0Ti8u56VwVbuF9jUjExP2AUsGwN3vvADvW8cT2cHR+mkHQQkUxb6ZxSM5TbHJjtQCpQL5ol29aQwluOkgo0OCLLpAuR3NFFEbdLO8LOSNqattpa5ekGQ3heJAa+yIVkJgAqXrxt54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974772; c=relaxed/simple;
	bh=kuo1t91SGGtbsLmtL5dnXTzLB5Aum3aKRrPS+QkAVJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XhpVBXlP6ZM4MoPTjIawnDxbTp2mUyl9Tm6RA/Jcws+MxgIc9Zj8Fd5WnUCjV6aIv+88coQdofURES2emtpeze0c1CjdI0ahnGTSiYEik2Jjiqgb0k1Y7bTRZ2kpE4nIcTcgYQVp2QmD+yFRrCL/LZMyuwtwOfZjWx4EMxKFpHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B4XdY5mi; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B4XdY5mi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSWxCbgowaBALeekmoGVkefbaNgDeX4uYiXlT7IyxT8WCCdpfJZybUKkMjDUEBba0T7JRmVVobe+bAFJI9coNpy8eWaJGknOCAkoMGxjN+k/bPsDfk8eeFbQ33sp+jWlqz2IOIs0810VdmboJMnQ14fnXqJKyYrGqFX4KqUjqoS1Ul6Pg8+ow24Xh4Ou4FAUgSGlIluR5hqnbCC9SIspG3Nr+1ns0pEW8iTsLX0codhxRVneXqq4JxNUySHbQXMRQXxvBrWpljkyAI+jfeNe1bw/Jszf/LnpNhKJ8DxuWgzjQPJoz0aD9oc6IZ5u2Q+fabZ55n1QX0Dh7xySlNkfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5myqahzVMrPwyS5Fq4GhUpHJmMvzcwDAxiREvU1fbo=;
 b=SyOqIzagtLeZSDOAZ1TGG5N/vfnnUPaIvZXwWLg+KEqIn99bnvYGY+BZrfe+Tlp9EkKKLaQR0BW/6B1kiHrLQdxyjTU7IWD7Oh74ybK1ElGsIN+W+mCuvgCQKbbscT5zrf4E2LaqliIF7qjjh7sNs8dCl0Q4D4KJhzwd/SGl3IpBp55/2bD5J2E1Rca2oUHMiNvmpPN5+4/Q4lGsyb7LrGBiVYryo0wtpjq1FIGZRNH/8xKOMhT1Y5fkDVxznwJmWcyFAI8CAAt4+WGMfmeXKrCIPKmWbmPDHlT0DD/AWzBnSstw2yYEvV/HXRR/yx4Xc4H6anyEzRLbvZ++QjDTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5myqahzVMrPwyS5Fq4GhUpHJmMvzcwDAxiREvU1fbo=;
 b=B4XdY5miiMKfAWH53rXq+o6CKNvVfA8eLDITmN219IKZ1H/ksUmstuLdUOWxbGDGzCd7knQ2dcY3kClK8zM6iNbloLoc6ATZZs/RFkOC4FPn1Yo41VQ36Yl54My2taTsKgKW92dw3mHBBDh8lDKt33RFRiJ4LBNAsgXnLIIIPMc3hPWaumFj1Kqo5kbO3lIRlv51C2y+h6dbEojCgzAVL1Ydi4ZS8mkZblGzuAKMPYuuxnrnoIlOn3aZr9VgL8M18v6I1ZKGjuq1WP5Dyz/NwYpIh2Jk5EXDbmmC+hvV/a7K7d0pqq8BLnxWos7z0O+k2n0+E/3j1uldaOi17OV3Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 07:12:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 07:12:47 +0000
Date: Mon, 21 Sep 2026 15:17:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: gmap: use assign_bit() where applicable
Message-ID: <arDZ9SSQo0N5BsMA@shlinux89>
References: <20260920022642.3145674-1-peng.fan@oss.nxp.com>
 <20260920161808.18515Ba3-hca@linux.ibm.com>
 <06158c64-6d2c-4dda-a742-0ef7b2cd0583@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06158c64-6d2c-4dda-a742-0ef7b2cd0583@linux.ibm.com>
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ca7ff7-ce20-4f59-e9fa-08df17afbd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Dss0ThVcSAIiFovn03x51QlUKmZuWC0AQkLaHbFpJheop7ZzEE3tbuFwUP12pVnqoFv8dfXSsRbpyl4tE7jSpwmjp6MxmG1xyOFbtRQbGUBxZkbwpGIO5NSVrsszuubByx87Zd+vLg+qZd1LGzX/s2NN7Ws5lpnKwSqLLCMLmgnQzIlYl27c6bCTcm36G83baa/LbZGNcbVkQRg6W5lll+kPukcI//1vcvO0lf5U8BykhWcQOJi450zzuSN1yTALqCSDyd5Gq6ZKGQZWWlW/2QsFo8iEwhvEbO46HmplbX0wsaMiEiLApTmwI/7sVKPxzHcIXqBtVDAbr/L0nGEdyJu2OxkEHwqAoWjPFc4t6YMTbrnqElTJT0aETbgO1Ih8mAcDW4Fty5E+HaQAo8DuAP7PU/Bq6KoGCjrb2IxHDx1BUiLoi2cizHAjNm/0DDkAx+uU6gmJB99zvxLxwByi2WIRQMkVKQY0y9RhAJjPCLcD7/hJMvYiEtCqVUXLBAPpfwOzm4F85hBd/NiAvUi/HiOWOEnRb2bSZK12sXIdeeYESaOgVbEDBcI0RvBej5wc0k5xSztVQQiOEqoV/CxGdtN3ixHK3RamCGjQdxQegH/7Wc3b5QGWTp+j9MT397I46tzG5iyDC9Zytelz1vp/Sjrpbw7UbFgSo5J0AflcT+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rypap7i8XyItGmSnv7zGQdqJFq5pnJadVnH6Uj8aCAebXQJxFrjkU89dD1ur?=
 =?us-ascii?Q?FwA+byIbeeKdqCztSd+NwrxkNX6w6fhxXuUTdkXaB/0n6y0YJDvmwsUjiifl?=
 =?us-ascii?Q?dJZxkl1sppEeGGe3Srb9ZFQ3BpGWQsL6HWbHHP5VZhYE4ceunxsVWH5P3dpy?=
 =?us-ascii?Q?C7xuuokb9pKMjEZJ1CVN8veLxl/MncEqsH2h3+UVaMbUEL1i0pJarGwiQu3O?=
 =?us-ascii?Q?UEfqwfUL1gcG7hQOtBLY5htJ0hPpHl9sTCFbwjwu4/f0BHDOhtGYie82Cn4A?=
 =?us-ascii?Q?PsgJL9CuUkdW5sLyuT5nJIruBPPHkZztbnzTKR6RPsMdY5dk1zdfQCrW9FKb?=
 =?us-ascii?Q?cwbxiohr6LbIxadenX7uTVA+iGWExSY//icnl8KRL7vD0xJBtTLTRtmCgJYW?=
 =?us-ascii?Q?AkVpbWp38qR+U7zj96Oj9yWXAzvFXiXaCv5HZlc5t+yREcsV30TXVmnCpfpJ?=
 =?us-ascii?Q?9a+Dg0MUaQ5BQtj05aNkDNIc05wwFMS2CVGnzmphHO0eUTZgmLtyDybgmxu2?=
 =?us-ascii?Q?uMpydS5qqJ809lzl2A2xbvCivqsMThjpkgWVmJ64aOXgUE5CKWW8sJZlJ+Wk?=
 =?us-ascii?Q?njfi+2AC8FtPX5xnlAp5CeM0txGfqQC9M7wprc9ApOUiGrKOcMYHnXQt+Mtb?=
 =?us-ascii?Q?Dua/FvxMfEHgfB8VqOUILlxyHi9O80qAmK4jIXMIZkSUwZVhWtLbryQlRzU+?=
 =?us-ascii?Q?1XZNdQRPCPOtGgJVkf2JDJdhbwp0CkZRTHOvQB/GUX45sPW7916dWIIaci3j?=
 =?us-ascii?Q?+Ckp8u1oJm66k4Q0J7sZMHoa0fYBEz2kHtpbAMobRLMO8/R/qBlsiqarRaA3?=
 =?us-ascii?Q?ymLhRbxJfF7sFpFYhRrDKp3sTrmMKm8kSgxfov5E+2ATbqXgDfhtg14L/Tpi?=
 =?us-ascii?Q?mMv67ggDTHCO08Y08nTmc5h5koL3Gv3Le3IEtt8iCuiKhK5mTcWLcTpFYS6s?=
 =?us-ascii?Q?mRnZALj9ExSH5HpTsErsQxzfKTS6UZx2PaWITbNBnrukvJ56h2p718K/78WH?=
 =?us-ascii?Q?Pt/nFbkgxS3cZOBiOyuWgTispP7K7Gk4ACTSR6y+lwZdA8GGTWB7TTBo7ZsC?=
 =?us-ascii?Q?Q3WAyv1yP70zpIrJrW3NwxXVkiPs+mre1147u8wqYbUwcOu5FPgCdRqbWqdL?=
 =?us-ascii?Q?E6ONE83XFwhH8nurizUqsY7k7BxCWVUFxO6kxWxa1n5HQRxe55JD3VMFN7SW?=
 =?us-ascii?Q?TbIIisjh2jrGTiKeNJ2m4hr8WvI/40xBop3R5DlxPXcZ6Kz5v4uW7RkcM0Hw?=
 =?us-ascii?Q?mg3443lpS+fDtRL9MI4HCiw/Gv6j2ok7cC7JGpYKa6VfHPtr7vbJJio3n0G6?=
 =?us-ascii?Q?TzsHZxpDMKozKEqqnaCWrBYRCDzKwE8ltR+fLQr2jtl763u9122+Y+eb+3hX?=
 =?us-ascii?Q?N8Z+QE8l5VB2v17zaZwtUbxCesJFs1blcg4YfjAxA7Qusz1J0lyCFINN1YQm?=
 =?us-ascii?Q?kBJMr8pZHKv9ax87qrIDNoe/LoQHI2ATMjUfO94+oVcpzi2Mup2ey0V6kO3V?=
 =?us-ascii?Q?cNoMHAR547szdfTcIiK3OvlEWxOalGgtF2BZTAETsia7vUEmlOTzmff0uAdC?=
 =?us-ascii?Q?WmkP4XX1CX2M8zh/NvkDrD52aRTfJxNWAplF1C4Fu5OP++ucNDTzW8wqjQga?=
 =?us-ascii?Q?YLbQqneJzuwmyZNkcuJa8M1sa2tiEhEoMjoYVMZ7caqjBi5us0uxosYg2BcV?=
 =?us-ascii?Q?//vB8Zb1e1MoupO4SMoeXP8Kw1nYXU81jOHxs9PTs4Py94/h6o7v9ofCWcDe?=
 =?us-ascii?Q?UPkJ78tPKaN+fT79daMJnFv8+G6A7SViFPTTVeCCPIVlwo+I+SOs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ca7ff7-ce20-4f59-e9fa-08df17afbd84
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:12:47.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ/jxoBBE+308Rg8ull/X2yz8pp7Cscq0cEs3XxmCKtr/Hq2ZTJvF82zB280qC3WcNi7Vi3RUPC3BnS45uO6FCNXAvpqBrZlwXBv8/VbwFKVp/Ky1R2LURm2XhX57hGq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Mon, Sep 21, 2026 at 09:06:26AM +0200, Christian Borntraeger wrote:
>
>
>Am 20.09.26 um 18:18 schrieb Heiko Carstens:
>> On Sun, Sep 20, 2026 at 10:26:25AM +0800, Peng Fan (OSS) wrote:
>> > From: Peng Fan <peng.fan@nxp.com>
>> > 
>> > Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
>> > 
>> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> > ---
>> >   arch/s390/kvm/gmap/gmap.c | 17 +++++------------
>> >   1 file changed, 5 insertions(+), 12 deletions(-)
>> ...
>> > -	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags))
>> > -		set_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
>> > -	else
>> > -		clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
>> > +	assign_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags,
>> > +		   test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags));
>> > -	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags))
>> > -		set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
>> > -	else
>> > -		clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
>> > +	assign_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags,
>> > +		   test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags));
>> 
>> This turns something which was easily readable into an unreadable mess.
>
>I agree, this is not a good use for the assign_bit helper.

No problem. Let's drop the patch.

Thanks,
Peng

>
>
