Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3C2BAE3;
	Wed, 11 Sep 2024 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036967; cv=fail; b=MM2RvFf/NOqY2ujo24kMRN1C99JZRfLoePv4n+Zh7aZlU5i2H1BwtmM4W7DYvdIjqcURAm0RckIAVxoRgIIhASLBHCeBjI38c5TRjUHe6QLISk5kCT9euSgH9f1o4HkVXG836nhikvQbGZwGXJGRD0j6ctg9AAcJeba748aOooE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036967; c=relaxed/simple;
	bh=h6BVk3TLj1V0ElLJ2m4pHUoXbT/C9z19bvUdvFEiGZc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UiHKanDEATrD9oMrzhrSeC+uKwiKHQ28W4qfXFPcKrcGbaDVmQb89bJ4kFovC3aZhhlePu3InuTEN+1EbHd/75MHmHsZTW0npZ1ZbjlaMtW8e0+W2Jl+5N4ym+bsREqQP83bGxUOPBFf7joaElLZZAy/O4rFcYHGGcYI/Q/ccTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Bd1KIqr7; arc=fail smtp.client-ip=40.107.255.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Bd1KIqr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGhigmjsDO7vQIOoKKi3YGOhxwLROEPhfzlJpeE5RMwLPxphK7c4kF+VERWk4ZNTFGWb2vlsuBPZXf/3GQbeUiNR2WKbRYDcCeejry1E0dv1mTnID0VI37xNW8LUjTEEGoi8wbsVfOEitWU5lIwjKTqbX1Hbk5xDenggsXOnbn4dWldnftd7Tizeduho4kr1U884n04dQKgW/mFNRorZkEQSxXYd9YfDnm1uV9KixmeFAnGMPdtjORJpy8u7wQ+APJUZbsw7wSqcrJKHDqR2vggz1VXC0cW3YpzfrvR7SIrrY2A0THGSeAobILRTdoEfTI7Cl1v0L3eIz4NViOmAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9J0Eanrc6wm2PLrCT67HVaz6P8iSscAbM06vcqpsZY=;
 b=jXqEsr/F/Ig5SsZNIMNaFR28ckkdziu6KsMZDlTmZtUvEuBJjFUaiKIOvtvm7+aT8gFIUSJXUPg+raLx15eDIFlcataN8rjnPtHsi8+EG0J1+3+jj++6CfHd3dXYTPT1XfEJTUljmj0O1UiGloFw8xz3WaB+ZB5pmmonSXRFgFK+JSPTl428w0V0sT1Qf4rf2fcDFEkfxxqFzcGAASMfzmVqzI3gtE0yf47A/D7/A1ovJYvQHJZMDKIJ5ycPWEQAsWXdBWF7HJqQFZJ8fe4OErmTFOMnRssrZWKdahXPuLtgPnnCCp6u2k0TwZqJugiGszdEf4jVcrdlAS7hNKsjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9J0Eanrc6wm2PLrCT67HVaz6P8iSscAbM06vcqpsZY=;
 b=Bd1KIqr7aV5s5gCj1khcXXYdualmqAzOf8symbnj99rGKmn0dA5OsyqcLo4Nc8uneJvowdYpStrQSckQ8GhVtECz6C2vX3o33C4lHOIAem39EkotXr6NT0J4kxFGlZ5tfKc+7BDpL64P0P8W+uayVf9YYrg+hLHmMKAqYPbH8jrRY+VsYJnRzd+UNVaWtnmT3lCOQCUs6Ly9XUJZ7eULT81YfSP9Mq34N/0spMUimeQ9pnumDUg7L3jlQRCHUJ8IhrqryuJMWdDNIQv4Mp3uoLfVMADDMDpxs1bsUzG1ZqmaRKh1ddE+L7I+ZX56fk0Iqih79PMPjWMj7JY2mE4Cvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYSPR06MB7066.apcprd06.prod.outlook.com (2603:1096:400:46b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 06:42:41 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:42:41 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] s390/dasd: Fix typo in comment
Date: Wed, 11 Sep 2024 14:42:12 +0800
Message-Id: <20240911064213.3891052-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYSPR06MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f26066-b405-48df-8a78-08dcd22cef41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K058uonnpnOfXM9HmglcgTowK53n7uoiedeBcWG4n0OT0gEeQyf6S7MoTiYs?=
 =?us-ascii?Q?bFDjjNWlgDSxJwfWKrxNyLP1ZTKzLtiyscMSwq19b+tS/cjpcFtdN2J/5H3w?=
 =?us-ascii?Q?QCF9XM0y6ygQnFwKoZWInSyY3upJtTAtouYZatzc8EQe7gujzGiKJMMbBBg0?=
 =?us-ascii?Q?GikVsoTzEX9+c3rkWKKVMsfBNFZOoSQS9yhMcgXQqj60Sure2alyVCmFPl3d?=
 =?us-ascii?Q?cwLT8qWGsdf+SlMMMBikEncOi1IxqgRrPQJxFfNURjEt97UZ++ZhGvfysliC?=
 =?us-ascii?Q?Ta+JnCFiEBd5abAI6MrvdaQ3p3KhcD6kDSu4o5QE6POKLUMGH1ooqDEc1N3l?=
 =?us-ascii?Q?6AVL3M6aoe34xqOhyZHvC04z3854dl7GDs9NtCwycnUG//dPA9hpEIFbUOgi?=
 =?us-ascii?Q?sygvRM9GOR2IC686VevvufuJiyv8CKeIxxVaZLU+s7160K5RV2sFrJZ02wqt?=
 =?us-ascii?Q?X1XuBNjtPdi+HgKWo6zKowzLFjV+depD9LW4FvMYt+W2hP1Z2ZP2JYqKG1xy?=
 =?us-ascii?Q?T9zOLrTQZATIT5VHIK19+ivJWclkwBTsOW5uTKTikZmzIQxdOr08Znc6Sq5R?=
 =?us-ascii?Q?zpu7QjU7gdjsU/8HJMgtwIMxGCvi4kjWdZAoZ9oU9ocZP2taEqWFMtUpg403?=
 =?us-ascii?Q?KzuWXy371BS34C+h6VgQf9+xUeE+TuM2cltryYODKCZy4ZBkHjmGK6n/W9I6?=
 =?us-ascii?Q?VDw0e15dKpP+PSxQ/1ze0MIp4nh14KGcKkpBwY69dRyZ0pM3qnwN71uk/czy?=
 =?us-ascii?Q?9M2PFCjhXWzmYCBVsIRpc2cdBQCq6hyTnHNBeXRjqOFDE8q2YCzWwFsw60yx?=
 =?us-ascii?Q?Hk9xdSLC1lEpuTQ/RB8Uo1TW7mc8ePA4eKmWQLCYbdtnhsRwT28tmpONUVSW?=
 =?us-ascii?Q?ynHp0Pj+lIW1lGkQFxToQ0SvfjQmM+AJHJfpnVh/8k/c+o3xZfsdNDgFObiy?=
 =?us-ascii?Q?xtWkD+vuR4J2GK4tz1V320s0x5UrDetls8XzIOM4/uNz7G6chhLmL8tVcesF?=
 =?us-ascii?Q?fbPEJo5zgn2k0VmMlHLW/7id85dZ9KRLS5nIMqGrCEzGpwxQY3ycxL9tHCxb?=
 =?us-ascii?Q?h3Fp25FqfnFkN5He0H7IGZSAd/iPcAhs2Vxljhaq2Jwlk/tx4n3OiGSDII2o?=
 =?us-ascii?Q?9+qXiGFek9vqn5Y9fP7UgZ54aHTLJRkHbGhzIguRe3Za7yOofTBLdA+uwz2t?=
 =?us-ascii?Q?zOVFyIsnC36EAPbr7rvyC5442mm7OCJFaoqiIBhmOsWaKHkzH6ex08gxqWkT?=
 =?us-ascii?Q?7vB2JXAxhFjVhT/l6GQ+4Pph9MpuChotw+ZHrjiSNhmMo9B/jfvFnDipuz+n?=
 =?us-ascii?Q?UXwFQvg1dSfM0xzt5yAVjScB7j8Jdytivch69qzI3o1VmrNa6ufYwLxH0OBn?=
 =?us-ascii?Q?XC2lIU6379eI43NNNLa1p+Q6x2VknFz7oLESj2iXDS4RtQSq8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N58IDvtA7NjDGi+co93VR+PS4nzDsP4cdWlvehkecWt7/Wdbo3nsWwDaSbFz?=
 =?us-ascii?Q?IDOY9QUFyDCUangKtmmr/hbLlJdTmavODIkt4X9PiQEsrSYcA2tAF23B9nMJ?=
 =?us-ascii?Q?KK7uKN9XnpONgRo231CjiXM8qjIyokCScx5Mw0hESFt9/EuCh/e9KlIyFUk4?=
 =?us-ascii?Q?cHLbmQNc3LtxX2Ox7Hh7G+1bbSrjhIvzgla+Uhj4tK8NmfWp1duaVsXcr9qL?=
 =?us-ascii?Q?vJhvEyY9PlfzKwWhrtr2WDYSOOdrbK6rlTjHl8exCTsugJkAeY5jK2Nv06OS?=
 =?us-ascii?Q?3hdCMBl9+zDUfCLzD6Z41b+iJFJ9ZffRrel3jlNWEg9pn4fCzMpsQUNw04V8?=
 =?us-ascii?Q?5inpznGAGMrAkcOShzfWvQRjJAKO3RclcDDBk2F48GQTCt9zyryEO4FICNFo?=
 =?us-ascii?Q?qeHYwjk1i0nL4LTMm/gYLTBL+ddsByEloDm6vMeKPW9WXZ4GkxmN48OnZcQN?=
 =?us-ascii?Q?4dbw+xYqoDmM/u40s8HwvIUnMaOhpRMQ19ccQkPfu601OgYghybKfh8L4mg2?=
 =?us-ascii?Q?Vqy+BhbdvyB+Iiz7549AEW5+2DmFwTxWSYMJxUhdeb8wTTeS4DyzXaV0BzMU?=
 =?us-ascii?Q?3RS1KRsKdHvzay0S0kcsb7aiCA1S9MTeDogdMnyUTjqRzTHfkOl38bapC34+?=
 =?us-ascii?Q?eOzRSj3OL9UT7XJSoxjzJsTKonadP6zvPeOR4Fc+DYMmlLNY+Xfg+lP4+4gW?=
 =?us-ascii?Q?Wm3lMhuGNnZ2vabkcWaHdGdZ9c0fivak80SE13VOMTCreZUPofsZs8o5aNMb?=
 =?us-ascii?Q?R+Gq7SajMV3eS13x3O0fuF8rB1elygstdTxfE5DsZw5eprf6uczGlpzgwjYn?=
 =?us-ascii?Q?sYARdwpZaFApyc0BrugJEVODJ0jcuJZDpgM6vmkS5w7nCazWH82x4+1i6Ele?=
 =?us-ascii?Q?panUcjD5rh7btKfxlq5l3a+0mps1Bwm6QP9R0se4/ZGdYdFkz+fkN31HAvW5?=
 =?us-ascii?Q?8JXYau3T+ykbK8S50y8H3VnmAGMgB20tPjXJR3ifYUQkcQvgY3CWip0WgVjA?=
 =?us-ascii?Q?j3/jo4XIuYNcWCjvwTJox+DQBBwsx9x618HmhmEQYcbiTeIDbwilfrpQ51Af?=
 =?us-ascii?Q?a/hNaZA5EYkn2Mmf/QrITeTv9g6PSONEjfiWdN99gdspCxWoX2/5iawwLA+E?=
 =?us-ascii?Q?90qnLOedz/hEy18lm+k60TqoI0jtf955Xqabs2P6pcTInQdCqjlpynwwa47V?=
 =?us-ascii?Q?R4Nn9HP+2dccmmbzSXvC7Ngzo7ea5V0gmcPQgdfxg0eKGqhEc+8lW1gJBKgE?=
 =?us-ascii?Q?v5ns8y+OQYpZPANlZJrj6Q5NC117cZi+HqUA/d09UdMiIicRNmBM5dSIEtSP?=
 =?us-ascii?Q?jO1soaq2EKZV/6k/hzPt3vzagG/AKctsIxarJq6pH3ql7i5MbisJ7MI0FNGm?=
 =?us-ascii?Q?kYZJzGo0Si8WLKrZto4K6xvq8E5rQLMsm7WSg6IApjhN3OLeqTnL/4DgV5ct?=
 =?us-ascii?Q?5KZRnpX9srsgQs0cBG4hikiYvW+xnIlBnhdTIqqDw3PXziJbGmTK3Y+iACl+?=
 =?us-ascii?Q?BEOLXw8EbxxPb51vs+zWy6MH+3DB+UdtwVTU3DJpTKbLtDCroeCImR5FLo9K?=
 =?us-ascii?Q?7cnXcDR5oDPqN0FaRbfnwSnwi3X75sX79eoFwHT6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f26066-b405-48df-8a78-08dcd22cef41
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 06:42:41.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zvptpp5rTxMa6Wu1n9mt0dXQjeTfoz1bT1iGwX0BVQtD/1BAlujivy9FHCAYH9nxjn8bMJNull5FKIy0mn6tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7066

Fix typo in comment:
requeust->request,
Removve->Remove,
notthing->nothing.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/s390/block/dasd.c        | 2 +-
 drivers/s390/block/dasd_devmap.c | 2 +-
 drivers/s390/block/dasd_eckd.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 42a4a996defb..3ed642f4f00d 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2117,7 +2117,7 @@ int dasd_flush_device_queue(struct dasd_device *device)
 		case DASD_CQR_IN_IO:
 			rc = device->discipline->term_IO(cqr);
 			if (rc) {
-				/* unable to terminate requeust */
+				/* unable to terminate request */
 				dev_err(&device->cdev->dev,
 					"Flushing the DASD request queue failed\n");
 				/* stop flush processing */
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 6adaeb985dde..71d8fb86139d 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -855,7 +855,7 @@ dasd_delete_device(struct dasd_device *device)
 	dev_set_drvdata(&device->cdev->dev, NULL);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 
-	/* Removve copy relation */
+	/* Remove copy relation */
 	dasd_devmap_delete_copy_relation_device(device);
 	/*
 	 * Drop ref_count by 3, one for the devmap reference, one for
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 90b106408992..1ebe589b5185 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2405,7 +2405,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	}
 
 	if (count_area != NULL && count_area->kl == 0) {
-		/* we found notthing violating our disk layout */
+		/* we found nothing violating our disk layout */
 		if (dasd_check_blocksize(count_area->dl) == 0)
 			block->bp_block = count_area->dl;
 	}
-- 
2.34.1

