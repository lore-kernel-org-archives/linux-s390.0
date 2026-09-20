Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD673B9DA7;
	Sun, 20 Sep 2026 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871493; cv=fail; b=n8x0NTVtW5wlSa3/5lXDSjIaigf5bPkYx+5gRoBMMMH4IPt8n9Ju34hQQrzO8FLHRovOFLxUEoMllZsVld9so4hnXZiLAvQKykPLLAOxTFF2IcckESeJoDMDAwEEgviC5mIafMZpz98SBqUS2L6SRXM7ly+3zxK9clT1iPZvxFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871493; c=relaxed/simple;
	bh=zX580Cf+uXCU1jBO253Wq368FAtRclTpkWXhsj+XT2M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LowDFk0SnPhk0eJvp4FLjDslfOR3tQDHPju2rpHmN28756cnStbHmV+X9EuCHM7i+DLpnvJei8bspZjepHoJKvCvVnKUfu/5J6dvxHlJ65buxFfG1nuj214FzZiJZFSoLuSZMncsKn3AWtWLj5tJ/Pm5TrGXet5MHTM3/vnfS/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Gkwh9O44; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Gkwh9O44"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcTPLtyKXC3Ay2DRqB3rnWLTPNvTnLBN65m7c2kYfgWt/57vPt5gXGxEs9KK4zvYz1LxaHTu3Pcs6iGS0tQVE5Z2bImx/KCJIHLeo4F8ojt/Si/huqBEB7lsnDBpY8DroaCy42wNew69pqEx783aUwkittUl0XOcP805K7vq95evQJ1Ao623GguMohm5RJFvgHA49hKnUWeDiYiNrxneZeDODYI1bxtToh1a2jo91mSF3THRm2NOxatbxpiJDolpNSZp4Uffcw4gMTQ0U+h54hMj0ZhowgkIKEBI/U5N0cmGzuxb39G8pUgNxm815ae9z8nKtdGfXPlLw1+EVQw4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywcum+LBXXoGqCtxT40RI+72EmvkUZSMrlCfqs6an4A=;
 b=ph3v1wgwS2neqYoUOZzPAv+xRzqO9zPm7AkbypKoxOJmMJBKgN8nkMwrgZBrPuCmz2kPTqXsYN8uPVjqQ4g/bSdkG/Wg+rNWM9QLwGYoE2P2CwSpIXUVO6+KNxrWHKdr+qX28CofEjduo2DgItHJ9wC9a1RH/2gehHBcnM7s2lxD2y7WKETr7q8HGA5oStJ/LDc+Ul4m1zdH2W5Ct1pEFNt15XzGOxg6OgxqmbtlyxtpSWfc4z808OlXGnvLjA2s+1hXn4syB7fku90hgXqf1s7zRBBYSHYhz7ommqAUlvWsAUJX1ixc6+JY3EoyhOOKk62pYX+6Fhm2fqTrxIyC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywcum+LBXXoGqCtxT40RI+72EmvkUZSMrlCfqs6an4A=;
 b=Gkwh9O44Do30nw279nYYPUDcl1bvfFy6y8BZrZIHLINYmzpk/IFF+fKDKGOQARduPZxo4eFg2nT3+CpM0eJ2r1E1sjUriIJC+EJqjiYfLPLZd4KGy2KvIGkm0c6V6jCjLVPhArJs1IxtWtInamvGnIBZwISUQDln1umaAxwsfb5fa/1GAyrnfBFYfVTpYWacfr8ru/w7sNu76M9V2ctHr9d18JlODCcR5cVAJnHc/eveqav3TviksILFXfsvL4RJWtvNGCldwFScYFgPMypJoZDcarMrPiY0+kKiERjFrVzmCrolf94hKtfGWNbVtDglnLPF1cKLqOYd2HUzI++fjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:30:33 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:30:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] s390/time: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:28:00 +0800
Message-ID: <20260920022804.3145894-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e60a53-4eb7-4409-0422-08df16bf258a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|19092799006|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	OBFnuOCly0o062FLvthUQejGajipc1weW8DUvC6lv/t7GBWIFFTWOC1T0nWc1z5cbQBb0C4+7u7x958NnMu+YJ5r0o9TclJi93LLp2u9CzXDp0Zxm9ctbIZKXzJwBu/ht6e2qEPQV929SaiomCFOo74QkssyFT8bdjU4eXvdnEyNEzq/DVQ07ggalGm1r2/MZnRP9emtoHKKO6Ozt6o/QRiYq/8ypHTDJqdtUDCuRv2O8kQAVfpgXBY5cN5rmi/5QDp2kQ1Xyj2cy6ZGt87Yus+5IZwdgiXznhCw3TrNQiNuVs61HqbGqaIr35gWdZ3p1NSmvgdqILWonSjuKhXRTGSKdgeibF4y60hGN/EymQu5nIevN90apf+0wXfC+xxm2uF5MW79SiUbc7uj652KMsyIXLlgKJPvTWTDA4ggVxq5t8SX+qU3arW6IT3YQagx5PRFzeJWHCp1GNHcAWAxmeaOG8vUqOWJpti49fK2H8B+oJqUHZgOUt11mvqefXNsRC8TWUFlRxvIGlFY36O3kGEJmR+4rwV0kEcf5rJG/9TOvDaic4SOgrGZzW1TdiuzlPnPFlvfnvX790jE4LrX69G3/iM7CngWFaOkeawbKQ0FPSDPZ3TGrD54eKZ0oWcZPoVnMF5ZUfk0VC1yQjZqXBQqMTg4s5SzzNokKTDYESs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WRLerQPpMRx4KwGMrXPV9CR0YX6Y9HKqhGL2S2UNSm2j0RoiN9D+Eep7DFKp?=
 =?us-ascii?Q?nygJ4zmb9H7agdKe4j0B4V2/eD/yg2BItXVbct6XpHVm4o8HPGOLzbWguAAl?=
 =?us-ascii?Q?5up+U/vwNcyvR0dLscjhSTLIMXOz/6lzKiOTHLL7gVVj5ti+ulYFXA0nOYS5?=
 =?us-ascii?Q?5YiyK0noD98v2hv64nko1EopSduE8uk0G2PLGpt6oa/laswqFmAQFM3fg/3m?=
 =?us-ascii?Q?SWYW5273MixJ0alH26ugG/TuS3qswBy55mMt4BL2heN233m3EefSgWykq92i?=
 =?us-ascii?Q?oGg+D8P//qmNcZsQEWXmgIMiNJonV3HISunx8s0zw+D7hAMjDQrPxS1KJyMk?=
 =?us-ascii?Q?spywKqT/xGooZ+xJZ4DNcAVF4MnwDG/5Ela4fm8oJ+Su4VBHg1exAuewN3ei?=
 =?us-ascii?Q?rAOyx89+dtTLczd77h0UsSbgDS8QOUR5fVcMY/4j+u8KFj6P1bF2+BTNwIqe?=
 =?us-ascii?Q?7rT92mpZPOJYUCWTAVHPAODnQfnEIvSfAtFWsQ0HEgGbjebMW42W0sQNXKfA?=
 =?us-ascii?Q?a95iXAlfrCQuzE4StV8j4FqLGYHEUS2bQs/m2Nq5lyZsqCwhiZWn6I58yNbJ?=
 =?us-ascii?Q?qkaUUx4HoaplB4OuGY9/WOK9dx6TGuU6ZiqJbfkxR4ifgh+AzQ5GIL2yaMdR?=
 =?us-ascii?Q?URDxLVM2d8VdNPtpMPLaE2IJ1YqLzcVrmbNGrpAQ1BsW+ZjHKs47wMs7D/e9?=
 =?us-ascii?Q?yq95KuBWe8DcxFfhmiaCbCuwvsDHmYLtL0rkzmSQKVkTB3FuYLC6N2jmfR1Q?=
 =?us-ascii?Q?aYJ4XwRRmj+4qfWhRi/GJcv17N6c6p81SEEeJ+HLZwXBDnbDD1QND/Tbu87t?=
 =?us-ascii?Q?OANrIhD+ddh9D7xmIXzk/a0BwApPNYo5Bkd1q4Uc3LWfG2bXUr5yAG/2yRFc?=
 =?us-ascii?Q?ujnms300Vn4z4coSIbORyWU+mA9guFC7eX+QGNGxHZGsyR3LuZBZmNEC4u8o?=
 =?us-ascii?Q?GnYMuUZDnkIfjjo6/gxdLrK1pHEp5EHabAyKGJY5q5bXPgYg6NQ+Lq7w6fcf?=
 =?us-ascii?Q?4TbzzElrna7dKSb7x9izg3GFzR+1YQ539fqZzZxWb22dRt3vvNWyyaDljP1M?=
 =?us-ascii?Q?QTurQmrddQQrXthP3uUWGNCVSB/U8NDtCd8eFcyHsiE6v0UXPLsbd9FjPgoI?=
 =?us-ascii?Q?hIhFh3alB1MxIGTwUdyDsjXTA6UxyMtQplfXR6JFEYFs4+qljQWyvvCbvl5a?=
 =?us-ascii?Q?jj+1OAkfmvVBLRCwBe8tFr4hpl6UQ5yeQkToyw1znZ2AlJtD//0vsx0k8j0E?=
 =?us-ascii?Q?Yb3KEUh3mFf1WbshpDpzLjqioLN6EbFMzM1t73Iiy6X0mzoaqwXu6iS5a3d7?=
 =?us-ascii?Q?Q9Ber2nrE17qHQ7sbL5TBaO7YXIXkp/7zV2Flx9aIa1Lm5WTVB3lYu1a+zKx?=
 =?us-ascii?Q?vr/uYmQtb7P7Mkd9US5rZpp6opengnA0jDNz/mD+CZrUD4ZELKEPcH7p/PSW?=
 =?us-ascii?Q?Kb3K69pwh/ASlXjW3T+X00s+SBVVyIP2Ry5FVXVQTcldjldg7nAPkClBmWLq?=
 =?us-ascii?Q?kw1zADzd3nwG7gfg0mcQM0viN3J+v9OO9SMXR0QZFqBnJZaACp4/nDaiRTjV?=
 =?us-ascii?Q?/7jTLWniKTjQIdW389qo3IAkhjca8d1XSBRK6pn8avWKpSZtX3MrwDxGghJh?=
 =?us-ascii?Q?QQ/wNtc1+rHdSpSgAHf8utbSOiW3A4k71sEHzKbDI2uyHSDrVKmJ5Nq1bhJ/?=
 =?us-ascii?Q?I7LUfjHp1SjLhjCIV3LofBMYYKGvABRRfOkyB9zF/+tJD8nbVYcyAlVOmw4I?=
 =?us-ascii?Q?4H7wPwHlZhn0p/RabQ5DsnYcT+9cJ772AP+NsM84d9zJC2Uva364?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e60a53-4eb7-4409-0422-08df16bf258a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:30:33.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUgVNyJsym+NU7PJ3OlZpx/McnF4aTlLz+QpxJWA7RjBrQPdOJONaqog+uc0l4j4vq/M/HsT0IWUnWpFLO/CMtwr9kHG9sFjmhaJFSfU0eTebP6UB3P1rWEcymVkT6Aq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/s390/kernel/time.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 2b989bebd220..3225a66abfce 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -501,10 +501,7 @@ static int __store_stpinfo(void)
 {
 	int rc = chsc_sstpi(stp_page, &stp_info, sizeof(struct stp_sstpi));
 
-	if (rc)
-		clear_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags);
-	else
-		set_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags);
+	assign_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags, !rc);
 	return rc;
 }
 
@@ -795,10 +792,7 @@ static ssize_t online_store(struct device *dev,
 		return -EOPNOTSUPP;
 	mutex_lock(&stp_mutex);
 	stp_online = value;
-	if (stp_online)
-		set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
-	else
-		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
+	assign_bit(CLOCK_SYNC_STP, &clock_sync_flags, stp_online);
 	queue_work(time_sync_wq, &stp_work);
 	mutex_unlock(&stp_mutex);
 	return count;
-- 
2.51.0

