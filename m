Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74083B52E7;
	Sun, 20 Sep 2026 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871375; cv=fail; b=Hh/mkqyHHo8/aTBprq3KLkMc2uexVXyumFjmiz8HPp6jz8gfeeXQpIe8VxAyUXCXYGz/klg/EUs9kdTMW4XP/fv6WiW0XiSaGVkjhb1I28ZVKJ8w4HNE1oQ+2HfjQjkw1DJ747BcNi3EUrcW83pp+9DqX1aN6hMrr4rbpN+qAuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871375; c=relaxed/simple;
	bh=QrL0jtc1oewA+22fS7dTIRj+5kQOn7Zbv3jDS1/jWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cDJ2fSicIwLBPsoZxFCZOv9/gWjNlRmUpsPU7lHmBgbWK2SVFFTXuS3hE1TuPmsqqj1iw7M/5Yjgj1IxqB+5KNPNnCre6espGbafDhLEkpvOH08Xa30v3/R71OCUaQ6NfmWAxP0IS6raeJwStHPoxxodLBuCyFQA71qoMBtsYXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qnjkSdye; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qnjkSdye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZf+nUcQwRrnuDsnBP9LuHInNsAkMGXrSgrGjb7NGI5mZVLMJQTY8yGLeItUhFYwrX0Ui20B/PfeRD2gNettQPmV7h3z06md64d3AOBuSn8J1gxm0cOQsda6clYEZWApdM56gsjbBviugFg/39sV3DvGmgI3NWwb3fuEUA3WYHg/iE7v80J3T0IVsihBM3+Im/H1OANdicqm29BAvY8JcZE5jUDMb6n5vEQauFjSkBjUbw8mNRtjC/80u6CykAKdVuerSMs41J6+sV6Ri9xcOz50L8yMxjOAY/9pv4C1S33eLPu+CXcQ5wfcL4ry3N9UvKS7XDNfkoBcJ6VdCLgYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYeajpUJVddcYuY8SdCeG3dsyeolPeYRaVCgk3p+k9k=;
 b=HRzpwBNd9llFsr5h4ljyrBhJr2yeFdWghx2bCa6TvXxb+K+KYEJnlxMCBs94+drSrUWea+mpZG4O3B+HtpAxuwJfuEz6FvFoVCANtiFCtebE7C++yQ0FZnEU/trH7h7DI0A6s1Pu6wIcEfHd4WcgdijSfwXVXK95WmAj8boevDaq2B/880p12sKp2SiVME/m/N9hO648WAe5mdRkMtpIiTzfkDh3ofrLeAd5ISe4aEIzkaSYrN0FGJgFKX8hzu7EwIs6p6UZOXS+i3jQ8VmEqSggJmAzMM09LXq8BsKkYsUy4R0yn9jrGX5E3LbrwIaUSHjkvmpO4RGhLYKxLgzy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYeajpUJVddcYuY8SdCeG3dsyeolPeYRaVCgk3p+k9k=;
 b=qnjkSdye8nnkzM3xgg2vcEhm6krezw1yyydXQCMkLxeiTktnFtjWBSZ8atnu7cUJ8a9CnXz2Y/bmGQLEV+B183MKHMIqSsAwYqk3l+fw9/ovMbW0VC6ztRSKaaqAWho6bqk+eh+WDW1Nt0Th1fXvulHahAX/fZXseawZf21zIM1XC5vhGCdkaXoSQ3tma0pEB0CJxgOKRoauPsarhcmBGbuVU0eJd3F64AYQSaeFaos+85Fklv0O3+NOw6tyjENJ/hV1+MlWDiwyIJTwWjExyX1YbL3gbIl3CW/6/n7Du4hz5tNwBfraUaGmgn+mou8nJw2HPgxP3nxyydMcZ0bZTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:29:11 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:29:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] KVM: s390: gmap: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:26:25 +0800
Message-ID: <20260920022642.3145674-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: da5cbad5-de62-4c19-6e23-08df16bef4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|921020|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	7MafzgKBfKB0ct1tzPUGbyJ85jTHweBkI/aIgfhts2vYbDBcNyNK4EajlDInm48IL9rmEmTqHuWrCnW+bRZc2UCfoZ//qbozkTg+icGiVQKB89N7Kvyza4M+SwFwkt/zH87wDi+RiwpD6ouASeIRu4+chkqwMgTRnvPXstIsZS3AR9/Rv1t4+dkONtagIKNY4IqlPp3T3RHvSBt3Sh9AjhDkjXoCQEyEUDy2llqhN0+7TReB+rg6UZ7Vpm/3PTNRMXuk+9JdS0ZP9fg/le8k3E0wBNjdTMV9boOrak/+dJiAISod8tPF1LYzG0xLGk+TUuA90/qUQzW0yF12dG/6b2/7x+KkoKvKPas67MNMfppoBudQ/8ukPi111fj2u9Xawsye0+DpF+xSjz1K4Dx8WNxx0p7kwZ/CUww5EWY7aMdfoWNFbwwCP7twex1lMWTUP3bVuiu6VU6wdPM8RMB4ILspIDCUX7Q5IYt1HSOLQdOgExijn1F6l1KS0wlcm3Tif9bQpBvVGA6qR7n/7kFtC/7WZBaQYXINQ6lyTDc0i0F0ax3qm+adPdZXpmUlILSfzO8VOsuNnKGGPpei2fRQf0qJ4/LwVV+HWediOBsHVmzeWx+w+ADCB+uspWVfFvxkA5TuiK9g1Q7iTDzG1yMwrbegjGv4epmPM3B3xqE30JSXIfGDBiFtY/OPlnUda5OHlZ7xHDIpsWYfoj6wEEF5dQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(921020)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JShBPlG5CoXyNToQ0YChGVHXFh6Q0rmF02n/A7nz70fGtecjugk+W2lBAXu6?=
 =?us-ascii?Q?JeAUWS3PSiQ/MyUbUD7FpdoWBl0s/G+YnBdK3ogaW8WrZK6l8iGD77/oyTkf?=
 =?us-ascii?Q?mb1RLMrEnQlbrpcB8+sp8q7jM6aelgBRYbbal+uBqRKP1FnTmWVH5aHVYm9v?=
 =?us-ascii?Q?2vMrBoi8G6uOOPSXW1xDM9cOSedEiQSu/Rioaz5IeMzdH2ZJ8wb/sNXubKMZ?=
 =?us-ascii?Q?43WRhESpbu8yOQ7mjn0/5o7YpTG6syY40hvrzMqaIyKoBOvsCUzpaTmdYx0v?=
 =?us-ascii?Q?3YG4hy/mMTbVcJCdiS0WrEk7pB54kZrtR73wn5EvlOUxuf7hmR9HydhZTb/M?=
 =?us-ascii?Q?y8URZkhViR3SoLryt4b+1GWz/l76vZTj8Gfsp23XT/3jaBlYmziHykIVJ5Cv?=
 =?us-ascii?Q?/PyrI/7fbK9X/PqmZlThXiqnnEUlzS1Xc3QhZw3R4Ze1nkModzth5lH+4MsI?=
 =?us-ascii?Q?V7h35aBCfxykbcku/lmM6s4hVE8FBWn08KtHhRqDTUz2Z6XHeKUgyYU0ieoS?=
 =?us-ascii?Q?mO3+8OPM6RZ2cemDfYUHI7/Iy2TvEsn+TBOCiD3HR6wMmEYNujntyTGBKSMN?=
 =?us-ascii?Q?C1642zYsCEcRPdktnt0hZ1NfuoPDq8PGwn/jIUxLeGYP1b1tsS31ADtS74Sz?=
 =?us-ascii?Q?q836k4RX4u4r5MHL0/bgXCGLsJmVqRCf/cxp4BxCpFIEBBUoytCFFnJLQGoY?=
 =?us-ascii?Q?XSA18tOkyfRLzyRDQKhudQ2OrlNfP7i26IcXuoqdhSRpVA8B07ZW8qUrds+S?=
 =?us-ascii?Q?IhmfCImNpJ6BdB3EOSkjbG+a43ThOnx6qfIjYExRIA5F97zSRfqYKszPARK6?=
 =?us-ascii?Q?27KdGQBYLPm2XU8gFOFVPVBnz9N4g//6HQrISKtnxcl9+oKq9MCBf8PSOulL?=
 =?us-ascii?Q?P4SpnLEl+pLBjvSEJxe4tpjljGtT4DXY69foYwEZ+gjvDfK6c8lb5cgpuJBx?=
 =?us-ascii?Q?SUpftvVQlOnAFpWRSYzGLrXanJg2XxfuiIeJHzZ1gEURzvoQVyY6PwkyNM6H?=
 =?us-ascii?Q?eQnsxHvp0kmSPXh1iN3IrOwdeEsi9C1VS3e9VXZHUh0tRk8ICo1MSdlzlt9r?=
 =?us-ascii?Q?MyAquJpMJGDJ2UdnBWTzUZ97fmyQ/6108D/C3ffzVj3yJnBEnvrfj+ZRCfst?=
 =?us-ascii?Q?lrtXk4Tx0J+S2bvW3WSgH4joETfMXt7oQp0DHVwdaCpZ2Ds2JqJCS1K45Rcx?=
 =?us-ascii?Q?bvw05zFuneL5rocJYATzziYtCIGpRSoIFJgijNnTKd1GhE7/6OYVHOwygeAq?=
 =?us-ascii?Q?z6bvOyjW+mek3LMMrJIR/3yJe3QkhRGNNfAVQYcW0iGglXek5iN748bsTjP6?=
 =?us-ascii?Q?TyyhW++SaMn2t1EAb466HJUCr80yZcntK338C9ISzlaTVU2X/U8jRJ++ilT4?=
 =?us-ascii?Q?B6639O8MKRywmHfDvrdl828a2hD9BrDbZikYNmCrOaCzxdpyGtFi9fkumjiU?=
 =?us-ascii?Q?v/OyGGdoY9iAMT5w8RR4i9Kl5lN17Kebxzd5lSfggU3DF2N1Cq0VcB+olH3/?=
 =?us-ascii?Q?YAgXN2MFgcXoT2hxQKAXbxhfg9BiyAyVk4oSloYRd155CsMLhtLT+8rS28SD?=
 =?us-ascii?Q?/ZwcD0HmhBWmQKwiKoi52mfXh7oo6Uv2vuO+JfExacDT2/21g1w7ffdahSfl?=
 =?us-ascii?Q?R0r4DUMLzPB5nvYHJQFBCf4IJg1JSg92PO6m9Mh6sv0m8H5ySCZdX+2bwDil?=
 =?us-ascii?Q?5dTgkGuEIUXvpNQucmafc2+m/PAZpBM71jv6UJj4Ct+2MaYRfEdwqFZDhrf1?=
 =?us-ascii?Q?Gln5PcfJBH3ug7wIJl9bDeEQvZSKX4ukH35fj+vutv/Ysmk71oVB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5cbad5-de62-4c19-6e23-08df16bef4c1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:29:11.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pZtLBu2eQeFW1lXbDTJT4o4OCsotggRJSGKIhwdQYgyd1aNRVtQoIqwrHsQPHPGQXM1YHFyCuyte4gOiEXpscaHAFMlJXyRgEl2mN3CLlsOTic2RQc9QByJawA267Sj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/s390/kvm/gmap/gmap.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 3f3fa864cc36..89a5ed4ac440 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -90,20 +90,13 @@ static void gmap_add_child(struct gmap *parent, struct gmap *child)
 
 	child->parent = parent;
 
-	if (is_ucontrol(parent))
-		set_bit(GMAP_FLAG_IS_UCONTROL, &child->flags);
-	else
-		clear_bit(GMAP_FLAG_IS_UCONTROL, &child->flags);
+	assign_bit(GMAP_FLAG_IS_UCONTROL, &child->flags, is_ucontrol(parent));
 
-	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags))
-		set_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
-	else
-		clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
+	assign_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags,
+		   test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags));
 
-	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags))
-		set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
-	else
-		clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
+	assign_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags,
+		   test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags));
 
 	if (kvm_is_ucontrol(parent->kvm))
 		clear_bit(GMAP_FLAG_OWNS_PAGETABLES, &child->flags);
-- 
2.51.0

