Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571493B7B66;
	Sat, 19 Sep 2026 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823479; cv=fail; b=kc6/SVz6IAwhFpHpbTWEBLjwusztMqNBy/SwkZuYMCKWYLYW6lXJgHPeM0QQREmjvmXqa68XQCYhoPKzDCOczN70Tjq+/KhDlMbjDVwVA6klL7HkkmuLt92HBHcPio513//CQzMbAMR0dC1MSTRRFMkcSvmCzmDIsxfLF2SKPDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823479; c=relaxed/simple;
	bh=C9sGZdw0tK9FMzM/0jDzd1s/RXoJpCMZk1094MpIsBA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FnYu3YY6vTrMRx/lxGJ8k5eGMBv5Ne7cH/MeM0MBjY99ew6pzSkVfG2uQ/LaqB5Y3b45vXoqdwvMTyjJqJQzkhTjZ/7PH7Vnl/ks10oTL2tsARtYFrw4Ubx4pqyRYFEkHssq3+sSaBBd0tY88HFXERVeWLxmCiKuJSE6OpE1sjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sFyvM2t6; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sFyvM2t6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSYBK4nPp/p/KFrwehnhRZesoqJuSbHciiaqq+77E5sXZ1n5sWdVfkRYF/ZT5dGi9sWvl2cz0r8eg/Yw+jdjZ09LmCywpBPvaEY1Kl4ns9qE4PCHGn+LquCQ0dEA2e2cTGM36KJGpXr4jx/dH9a1JAd0THBYEgSsI2aQm69wTSULlV50enNJtMkCpK2SzpDRPeEmUo8+wNA9s3EZdbAQvo/jL3TleT3/pUlyKcL4bQF4WqvbdTNG7CcXxxJvt7vyFKlR63fN3USJs61VD3kTS2AIRCMbfM2IIdfR+5TD8e/0yKMDszUdCk0Paa1aw6OveSYpTpJ/KraXf4vY8bhfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUW+61W9J+6D7u8Sspht3ttq9uG5V9UarFsJ+hP7UVk=;
 b=HyAqo6lCQmnjs+HqdKnoTbYPbBJLv0Do5nxL5ciA0Da07CHeWi9YTGbny/pB4dnYrih3SLSS6tkgfFwsZk0JvgFGRupHr2Go2s792bezvqRmtwufTYSOW2tKN9xS8aK2x55rZKYdIxDsp1lh6MBGPywZ8f6pSBaanq3pKYprS8kmdTp7vrxdUhsnA01gbkZa3syRkFupvVZj+6CE49A59UGT3MuyiWrlbI0viYDB3Fium0C2JpxTptbGq3nwAdLG/PPh/SKEnJn8PffgFpjxk2/hCubAR+1nYhU7ZkeaZFcQj1rcHKTAfk8NQp1ytnIMCYo8YBDssMN48tYQw8Ix4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUW+61W9J+6D7u8Sspht3ttq9uG5V9UarFsJ+hP7UVk=;
 b=sFyvM2t6fVdlTwuEs8GDC8oEyoh9SZRZLM8RKXRRgzjVzS/vDyf+AkxvG0bbAz9KpBP9TKKbUo3aztkXSWVEH2yk83kltA+/NU/XAX8SIdrYatTg3HWwAx//Ivjg9n1Z8x0FplGRQoB834OPMPMynKBh6tykV+Hz9nADnCAnn3FFpry+ldCa+cSgF6iYMqXO548x0Skan/XBOb+XO707sEzjM+BwwRztUHIQJCOPJw1rGbYmxL3ZlZoY3UNukoPrwd2IbmV6tenVeRq7+iHmWx1YKodCE2Xld8fp/ditJhF1b+ZhXyzUBt0YLc6B0cVfFYKJ1oet/Px1thOkz+EcXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 13:11:14 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 13:11:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH] s390/cio: use assign_bit() where applicable
Date: Sat, 19 Sep 2026 21:08:44 +0800
Message-ID: <20260919130844.3041591-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0275.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ea42af-b322-459a-ea3e-08df164f7be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	JFhsrKaHSLJwylyU9aXrkmdLgEdkCIaRon1tvimhYtx513HvkrY3CUANOeCWawNI/xvhl9slhS42zIM9LW1MrYOuoTizaR2ouCwjQyyHCcb125901uPik070mVKumzxCbv/f6KM9Jyo6LMoU7WUTOefM//uiTxZSV8uqmyaLzl+jZ2/cBng8xIPFh32l+nAZsW9N2Dih3aVQdKZTLI8GJeBgo0YgPHGCPULXQ9FR6nGNg4A6tScggeCOKNSF4HSOWQTLSfNlqIzjxObcOoSkPNK5DqJyFkjThd4ywsVFWa2Ntsv6n5wngahvxSxJEDppbzOunfYCIdb4jxu0F4Pv0jOVFZ7UOKFzlsgbeH8K9r2DtRPlgzzZhv5rZK8cXyY/nqhna7nEiGWbfmFBP4usLyABCGtQbq0GgwBDhbsyP255hU2pP+FeM2GsVaclQD39XdnWs1PxPy5rrTKwhkJI8NoZviAuWabwOVYRNx6NURVr/IbjnHogs+o0QjmQgQR2fyHaEXkOYNJC/Nu2imd1WvMD7OB+v1T3TvPNnoG5Yxl0XhAKIvNKALA/H+CuCHUrDqZ6kvaT3+Gg7xZiDrVSDRkEu30bOaTm69TXPS6u93yNQFsiCWh3fv/DhTsEd/bevPoWprbHQxlN9CJH/nb5/HEErfMTzwB6w3lZZfN98Io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjcBo0PRoYYJT7SoYKivuMrKP3X+XhJ0cs2y29RtbKOuqfsmzwsnSDnPMp2f?=
 =?us-ascii?Q?1U/p96YkJ7MhMrU5SgCpwtDv8W9Ns5x75AqB7i7tNnAXCCQkhFg3t7UsPMTv?=
 =?us-ascii?Q?giN8ouDRQBRgJSmUkYeinauyDBlLYVY8OmxDEDwMUnU64XyQwlT88GOIh6RX?=
 =?us-ascii?Q?9pa+tXzLsKgh/Tp7qhSWaWdK2t46zrUUJHZIOuYrQQwJg23O64oWWWClNcGA?=
 =?us-ascii?Q?Gy1YMccbMKdXYixOSGaaxHaLcGzFQyO6EGFHohF2b9XvIHr0IMctRgtVyxm/?=
 =?us-ascii?Q?2hh5YeHrND9/zlFmOrbadevYs8hy5VPqqC7rdvc0Vp5JbK2Xq4Vz0iSeVuJI?=
 =?us-ascii?Q?x0ROY3FszDGpM4yNh5wwn3v0eb1do1pI6R6fsSW6YS0VS9zFESQeuT87BvpH?=
 =?us-ascii?Q?Rd/v480ZRdSD9tO3GCXgnK9rpankbIOZq2+JuancEqyE5ilGigOp0jkXM5ys?=
 =?us-ascii?Q?FKSuqNcrsTmP1yMng7fmh9HxpsvZeEanc6drA+4Z1Ee9PJrQQX0VduQcLwci?=
 =?us-ascii?Q?Ac7QzX528hGuGW017xwezNzeEserXviJzTFNbyj1tEhVV+rzRS/bVOWcualm?=
 =?us-ascii?Q?iJi2Q2dgoTAucOkTfwBjIgrFPdBBKuv1i/kILAwDDe4AWew9S+abrTF2CFgA?=
 =?us-ascii?Q?mhQNZ9lMWBWK7kpZAXaDtEQve91AWTZeMEQ3EFQHjuKM+Xr04T6TfHhU5/dN?=
 =?us-ascii?Q?3FYs/Wm2zTcloaxmK/qsRmhYCzwM/LbkqK/ugXS+F6rbp+LU92AJsEeu0Vs1?=
 =?us-ascii?Q?lFWNcK/hXJqzkyKQ60XpOLGIA1sl5CqjYgH5qn/Go0cLDGKaT+fB8N+X5VGf?=
 =?us-ascii?Q?vpKAHEbK7kiOtc3aInXQQopBukibuTNqElUbzZPAYNCGpXDIdnezEQRmrNsT?=
 =?us-ascii?Q?G/SPnvRtIXZUCUqcpJcbGQBkfEEpbk3dcKfbMGhdojjD3Z5MZV6/QxWmcBCc?=
 =?us-ascii?Q?C498h6Pic196k/bu+Dt6jUyNsys0WHoZekLx19hAU+nPPnvlZY2EZmj0aDfa?=
 =?us-ascii?Q?z4VnUisqJDN4bigmBdeJMpU8EMiPolEep7BBSPtHU+xSvkhbsKEVLoekVGt5?=
 =?us-ascii?Q?pxhqzRzHXCODI5s8WMQcUZ/TCX7C8hjvc6kx7TK3njf6NPZlkXfFveMphJAg?=
 =?us-ascii?Q?OdEfQH42UC65sho7qrokDmzSBpI51AK+GRg7B2SfSnjr+FZhK7B95Z4SCVRm?=
 =?us-ascii?Q?sDEnN6YuNL57V0Ku86d5cOpiT9MlDa145Y2EtsAFmY6JwkCnbAZDfDYMLoka?=
 =?us-ascii?Q?biQVUwQuTWpSe/zUUXyd3gKFRDj1CRwcsctY3C1H1EC3G5IluI5owDlOp7ES?=
 =?us-ascii?Q?w8OWNaLVSpJjvN3Vji1GtntV7JuhnjYCMXQjPYih4mFGN/qBHLZkPy+OWjJ0?=
 =?us-ascii?Q?7lOCT68VWopTyZupVR9UD/7XHhVWlOzEYMGitHwapckorTinfgVpFhS3u1HF?=
 =?us-ascii?Q?R8uvATYJ8Hnjee/h1Ls7qJHnaxkGZQg8dsiSetFdhoC7j9Lqv4oV3h/nQ++O?=
 =?us-ascii?Q?Y7mLvFECPBukNIs2F0mTEIL+mqNfaBkANc+KAWwBDtIRfdPMzLvqUgiY1ZMw?=
 =?us-ascii?Q?2WFKu1V+w53zztlLQYlGB38uGTHOjP0PqRgqtig9MXFUCry6uK9zYTfi4bNN?=
 =?us-ascii?Q?J407m8MwiS3SCs3ry2od+ASo1wtTy2WRfmHxn3gB/TcOMbBkYc9ee5GviZ1S?=
 =?us-ascii?Q?mdDyhvziqxxFgToNDRlkgHTJ8ScnLDnd/iGblufIYaMAPyAqbdSK7734zfzo?=
 =?us-ascii?Q?P1kcaRDC88hN3CfNnDEesSQuWHW1Di9E8FgB8Qa9DAWWFiwxjfHf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ea42af-b322-459a-ea3e-08df164f7be9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 13:11:14.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vmemi2KkITTYwSyQMZQmet1cI/9oCqbIkD7wjFZwnWgYedG6v+y0ZalNoabH5AgKo0bllR1d/W8RhR//reqKfov3mJiR3F30jKi/uRFQLS2Rk0WR7pgYkM7IMGT52MM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/s390/cio/blacklist.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 020d210bde9f..c80c1f527bb1 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -60,10 +60,7 @@ static int blacklist_range(range_action action, unsigned int from_ssid,
 
 	while ((from_ssid < to_ssid) || ((from_ssid == to_ssid) &&
 	       (from <= to))) {
-		if (action == add)
-			set_bit(from, bl_dev[from_ssid]);
-		else
-			clear_bit(from, bl_dev[from_ssid]);
+		assign_bit(from, bl_dev[from_ssid], action == add);
 		from++;
 		if (from > __MAX_SUBCHANNEL) {
 			from_ssid++;
-- 
2.51.0

