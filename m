Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012007.outbound.protection.outlook.com [52.101.126.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8C2FD7B1;
	Thu, 14 Aug 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177138; cv=fail; b=O/k7MeML/KgJ8opsslrLlFFa1rJxn36oQm1lj/kFJ1zyUODs5e4plmgU4cqYcTSNic9HEOzsxDcp/mGRHSSF1YVwltjY2YBvEzFa68B5fmDrxUCQQRf0lqrxSyoqT4qZ8udrCM55PK6+75qXRsRz0utcZUGMiKnqXMC7XNEiSE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177138; c=relaxed/simple;
	bh=ZQR4YG36it+Yhd4utpsf6RH4h6iYHT2maIMovWQwuTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q5fPTsgOmaOiues33JYLpwHxNRzSObFfGVtsbT5/nlw9/VYrzSVxsaNr3kCx5nJ32NZA7qvilvIwDMrmhLhEuqDPeKDLSz6/cy94W/c+hvlYzXftVHriSv95+nS+yfTbu4AHJWuXeCIMAgGwYVEfIl4HlMSi2a5EUIlNVDtGGWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Dyt3EFrR; arc=fail smtp.client-ip=52.101.126.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Dyt3EFrR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQptIknd37Awx7gkLC0AuOS05lLWYnX2sNxgi9JfOqZNyX06urgWUSSMlnIF3j1twP7QsO3DDpgRxS1OxsfoPIQKoiJsP7XIZKotTBiw6KuuTu8ZqQVufFRlbEJ8ZZlVB/QnUsNCd+fab0roB0P1Zm5Cui53NbH6vttSwu4Gf7b4GyXCyszjDYOlsfiSBODeyO4nP1uPBDxKRc5ik8f6fVNcDyhw9Q+Aw3kvnUzlSdE9SaIQBR9sxNZOkj2uxKgZMsxD5FSW99XWGUGL6y2b2ujHlmoPJpZONGKA3dbjbCug1lmcEmzMMFdH9//29beEkkbwLHSv6UZT5wfh0prKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvVVr/+IMF26q+SdW43kIoGcdCb2DUCBaDdPwik7Q5k=;
 b=PyvNiyawFknpONz+l4dUDui4d+u7DFQdN5UXvVghP2/dumTlgdOFZPstwO4OFOBB+E3ecuebm/msbD4DYbrQZ7t8djjx67seSzZi4jiTFMf6ZnL1NTOHImCuarNtqzgy3WdmZAjENw6v3iTcR2Avbgd7WoY+rBVsYqmRoZP7ipQ/SzBQCwA1dAMvbPDd6M9puPuPTs39H8ABK5WzyMXvSdNeaKEpUhtIs1xQCNeLKL377N5Bn6NS1Ema4vlpsw6HhnuZ59RK1MQpzPg2ATemy9EWWkn0h4HgWtPWdBDnHBoaHt/w6iSkQAxzp4yCNgp+Psd0UWs0cjiovEci7ucuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvVVr/+IMF26q+SdW43kIoGcdCb2DUCBaDdPwik7Q5k=;
 b=Dyt3EFrRfRh8ape6hZg7+szOVj4nPCrZS8QgDoQEJDaz1mB7VV6OD3OLx2rUebUwIURNhH1v0D84hb3tYW1aWAqglQs5Y+LNJhn5LnM0prWoun2MyW2CyDPMK0f9KbpxU5SZYAXbHt1PHuK6SUE2zJ6uvknvDqbFl+fPhW4rBy1MEPbTHvCXIDbjDM/Io34Z3fS5mzmKlMsweSkG25GcY1RrU/7Uapb/32yAKvHINyHpri0tHL/CV0pK3NowTm73yCfCn+k2yJoWfsONnxY/4pFd5Q4VnssqLqtz14SLyR7Hi0TLKR4Hu+PBNM/KFJCDs0etD5gCFU9fdnqlX2bEBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KUXPR06MB8032.apcprd06.prod.outlook.com (2603:1096:d10:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:12:13 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:12:13 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org (open list:S390 DASD DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] s390/dasd: Use IS_ERR_OR_NULL() to simplify code
Date: Thu, 14 Aug 2025 21:12:01 +0800
Message-Id: <20250814131201.230724-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KUXPR06MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a412b7-c51e-49f4-f345-08dddb342ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q+jpm4BofqKh22XWYuHU9XDcT47tGnpJL09I1heNu3ScWDqGx8ntCkk2Gxmr?=
 =?us-ascii?Q?gZgvTiWvYRPXH0wbva84bCV/zbikqgiCgiTjM58kdSQwTI9Vz2klUI719ZeQ?=
 =?us-ascii?Q?fCwVrPiwrwipIZO3Zy8x7jou9wAAnXRjbrknvL4FUuRRGaQgWOgSQJwsGPDf?=
 =?us-ascii?Q?ZdnAhpzKG0e3ThAaU4geZLEjx4bVDvEmPxu4EOz8I0qljQZUem5P/1wV1fx+?=
 =?us-ascii?Q?m+cvxbIn+9+z6z7ewFcA4xPJgzQ5qjmNFjerO7mShVMQOkQj9XQ68liMbW3I?=
 =?us-ascii?Q?+FlK1GBgSK51ngO75QeaFBeF2WSIkZ8QPnkHkWzoAp7gZl89sHVF/606VoWH?=
 =?us-ascii?Q?Hk2rrWn6SQLLTNti91/6IRKRDg4ZsdLseaDnL7J5pSBNFFQly60WMYt6uzQo?=
 =?us-ascii?Q?TUfsI5/83V9C2BcD14DBfuUdDsmkpqLShodzdSdYryqyyZQw+Dq1t+1/0/1g?=
 =?us-ascii?Q?i/1Iua8rGRkfStXo2B367Uk5fDywGkOfOTGNSWqh/Docn8b5o7BEzUkOu2p0?=
 =?us-ascii?Q?Wzg+tkG1XqEB1yVw7lrghDR9vkwrNtKlPeWt86cUhZ4Q+CijEqSmpWwCZ5Sn?=
 =?us-ascii?Q?4YuxpUOBU1Odz32uu/Xf/af+d6IARMk3v7JFXw8plLnjjZYsvx/b4SclsYyv?=
 =?us-ascii?Q?x5SgIptwQ/suDGjDMqGYTekWs0FCC13ta1V+8hbQuP8BT4oegnwuDLlt9AKw?=
 =?us-ascii?Q?zr536GfVGJ/D5z6oUzligDtlm47dvUrZsHFhd7KSp9BBTTzJGlPoosv5jZGf?=
 =?us-ascii?Q?XOg/Q1EuLGJjBzdGYJH1CAL+GKWOLgdhDT4gP3GT7N6PT+ykx5iZU8huP8ze?=
 =?us-ascii?Q?PNteIJOwRrFwaL6IZ3Eq1v+kzsd7Q4mjhxNoL9iVPO0XgU5uAl+xRJVCpaTP?=
 =?us-ascii?Q?QGBi5BqQyPisaogUAU72TEDjyg0hkmJG/iulDavNHU8n/8d/iPXrZjCuAVJW?=
 =?us-ascii?Q?unmlUSU1B3t5J1TKUncDTyzNyces5oqnZ/OVJuk0LajpXU1MuG3ICx5X4tIo?=
 =?us-ascii?Q?TGJmX3X+hkN6ncG/lUBWOPQSoeTkVDGwAGN/76c4nr05MmG9T3wwD0QdZzAy?=
 =?us-ascii?Q?Dz4ytZewQ4JqmvuzzSzs3raaDmaqTeVYQBYJ8Qfh6INXay8Gi1RiIqu6QecL?=
 =?us-ascii?Q?YX0WAb4CNvhGfhCp4NLyhYnzMjbG1zioFs3z7wJ81xusespeIlGEaxTJTuF2?=
 =?us-ascii?Q?NBos+AbzTGGYYMYQkW62f8ytxgU/Ic6pQhTEzNhD9BqY0XLssvXtxo7qCr7C?=
 =?us-ascii?Q?SNKZXNSlegn2DQRWt3W3eXMY+GkgNbAB1A8woIgDkUYFTI7Y1T0WBGGO6B1t?=
 =?us-ascii?Q?DUot0t2C/RfkCXAh5pRlGVORVCUUrw9yyj1pwteMaV3xyHDAFgl4iUB8fWHP?=
 =?us-ascii?Q?XoXbUjGPD1SRUzf3bYh2GXPizZng/HZ+JbUgO4HBZsw6lujp3kp7DYcIK2Gb?=
 =?us-ascii?Q?NBqlDs9RFcbG/vFqBl26Lpif4o33aGmnUvq3uv+bXgEAWRcnSmemKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OaHbQA99lMxPCW+qhCIC5SE6+PAm4Q529ZZwQ3Ezln2L4M+bBnscipFfI+Fp?=
 =?us-ascii?Q?uj+AlA8TdZPt/eZVPHSPdt650L4XpH0tBWQFdDqAhXwJ5AOy/IoIGcv0kvoB?=
 =?us-ascii?Q?Gp141FUzrTBFrxUZ0i07VXuRtuTaPnmIYclefOmvv7J9a0wsRaN3aG0fAc9I?=
 =?us-ascii?Q?l4XweuCUqT+5BQ0cAh4f499riVrfIG6yZdgukINTcO7vbdvgaKhoye2sd7ex?=
 =?us-ascii?Q?gHo45YZzkA3U8mA+0u944XTOept/V1YPl48fqfHO6yUPJGKUypnryD7WlTN3?=
 =?us-ascii?Q?3qkZuWUkuBV1XnxAY97GQqmeNLyy7IprGVFFcHD8hvTzRboW9eIYIe9U45gA?=
 =?us-ascii?Q?nNPcJjSps8R5aNCL655Wd7azVDsdfjZGIQOsHq3mIhUfO9RaN1jKgkWwBlgn?=
 =?us-ascii?Q?hg6f/11UoEaCQGMbr/rlG+TEM2g73/1TO3uNcbwEqPrcqwA/OYJiZO1WXTsG?=
 =?us-ascii?Q?mHqc8tkmi5mg8SaTF0QBfOF+NPn08eU5+auIE5HkR2uxMNoxq8MPUtY9WC0W?=
 =?us-ascii?Q?Zsgk7s5BpAGJt35jM63t4o4ZC/LSQxd7FaADftZILwvvvMUzYpQyJlT0GZWM?=
 =?us-ascii?Q?AsAT6TrFVTpUCcqpU4ltEO9lhclUEtcyZ4A1HWY8WrVasyO/jsw0DUnT4KIh?=
 =?us-ascii?Q?ytBK6Pfj5D0wQMrRuWkGBWFHYr2aZm1pXJx7uSmacIVdpo2D6VNPPwuhEI26?=
 =?us-ascii?Q?RZUsekhJRCc50wEEq+aHtpgKrG+VYKriHeUgEEDEVRCjM+CpkaStEdYMaAB1?=
 =?us-ascii?Q?+X5RXigx4cRy8L85Z3wUVeSZq0/fCv4EEBmn3rTe6qGQJoZ6FQ42hcEKaA7y?=
 =?us-ascii?Q?bMWQVaBKvqwAZBQC2YBixbIRRRC69aGox2li3QeIk2+yPXTvtyPLG/e05wOq?=
 =?us-ascii?Q?ph144aalMWBQ4oFF18Qyp0EcO0Gw/d/05l5DGZMZ54nCnBr/VSd1t0UXpa6p?=
 =?us-ascii?Q?UWrXJ1MCf14vQgg0yi8J61qssQu+fVrTKtT1Hk5NfBb/FgiB7YPqEDthH/R/?=
 =?us-ascii?Q?vQflmhfrqj70EdqLUcVV8+lT/IDwwyCqFnqQaR3eYLMDFAGRCcgGswDD8QOG?=
 =?us-ascii?Q?U3Sna57ExIjl8ZpUP+tznYucT6ZAlXAiXstPrBhJXO3G8jW1NPl2ZoJmS108?=
 =?us-ascii?Q?MKHziQAk60+GQvRSmwUaSfne52PI6KLUBQ/UV41vdjzEECMUVetDYQRsDM2S?=
 =?us-ascii?Q?eqQwn/IxeCZkVShcd/XyIYGu7axjk4oQ542Yqe80mnVhPQQQGYSDl76co3sX?=
 =?us-ascii?Q?WA8hH/vRwAAivuGg2qdhUR8xaea4KdDlbZDMFIN6OkxX2KS37I0yMSYzunIk?=
 =?us-ascii?Q?ttKjDHKsrOw+LJgSD3Gm1JhVRyoTxieZ6J0IXcJ3Na5SVvjKuHC95nrtIJZ2?=
 =?us-ascii?Q?NpFozI4Rt6s9A76wF1ma/MFvqhY4oTkS3eDwtXviRg2vR16gDRDBoJXnj5vS?=
 =?us-ascii?Q?HYwqkxkStH1P8YFOaSc4n++z18u12Z0+KaOcYFAEkLpO7dHDVg+l7MzROtNP?=
 =?us-ascii?Q?Byzjq9ggxyZVymlb3/2WqaieTtl3neQFBvlOPhmElnN1BWWETTZwbii9cqep?=
 =?us-ascii?Q?qJBfBnhX4rLJOeYRc2Ne6ZTdJR7SWX2buK8QFZmy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a412b7-c51e-49f4-f345-08dddb342ed3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:12:12.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ged8A+eJuYZlLAiQDSAj5PVMIHOWL3ai7HdPW8wGzB4Z03ldUIFrggK3nQhDiPRCBMrLntT8HAwTAaX97sdgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8032

Use IS_ERR_OR_NULL() instead of the original !xxx || IS_ERR(xxx) logic.
This will simplify the code and enhance readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/s390/block/dasd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 506a947d00a5..78a9c8d781b3 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -215,7 +215,7 @@ static struct dentry *dasd_debugfs_setup(const char *name,
 	if (!base_dentry)
 		return NULL;
 	pde = debugfs_create_dir(name, base_dentry);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR_OR_NULL(pde))
 		return NULL;
 	return pde;
 }
@@ -1089,11 +1089,11 @@ static void dasd_statistics_createroot(void)
 
 	dasd_debugfs_root_entry = NULL;
 	pde = debugfs_create_dir("dasd", NULL);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR_OR_NULL(pde))
 		goto error;
 	dasd_debugfs_root_entry = pde;
 	pde = debugfs_create_dir("global", dasd_debugfs_root_entry);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR_OR_NULL(pde))
 		goto error;
 	dasd_debugfs_global_entry = pde;
 	dasd_profile_init(&dasd_global_profile, dasd_debugfs_global_entry);
-- 
2.34.1

