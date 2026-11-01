Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560947;
	b=JVKhNb49WBstk33n89ajoO6UigXIb6cs1MT7xzeSb2qg4lHRVG7b62bgxrM4Y2e5/z3+
	 rfhuGjU/43lIuCYXaQCwvriLqyrLZG9l6KFuAJoR9XI/UIrOtW2SmO0O62BOG0PyQ/yva
	 yhVdqkmv4EaD1is4u2JBy5SDGCrHKCQ2n3IYziz5JJybESGk4gsfg9SoNcvqiIUwV0LMx
	 8pGiV/N1f5HLp+ayn/WWg0jcZh1ciTbbnAohKIUoPKsgzdf/qoPWlLSPoOjkWGVk4+sww
	 hQ92/KvOm5PmXOKweJidYudrtV43i6qnjk9VMQaxgrsE8JlQ8uwzyt6gcqV9+zqCt+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560947;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=zaPUC3UUtZ/yvK44gMMvnW3YDOPQD1FoYIAiopeeduI=;
	b=Y6EJBl63b2/tlKTBaXA1yT9stiRauZw+Nsev2bTTVIOQOUIaI7xw+qN+Z65QnEbgcXOB
	 qOZgPzsclDa4PsFKLJ0i5Rt8Q5T8BM1kUB55sEbY8HrOCJzdU4fdG07UXNfDEe0NOUZ4g
	 /oBK7XdUFgXLUk89f2oC/4uICM+LVI1e1rhpfPKEWTP36+2Q5fxjlzEVDmwXiNQCKBlij
	 dBNPWUuW9kZ3G9Vadma4cu8PmrLhRpGDOl9UINAocz1tOVAtMgdob+EJQYiF/IVnrDi12
	 ndhniH2qNKjxjrRgXWmmjOs6hpzC461ELlgg0uoSENdwKcsnEtd36ddsWNP5lRwOBXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dQGCbdxe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB24606A32D;
	Sun,  1 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB24606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dQGCbdxe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaatN4GQ4Rjsv1gBav/bjh8nZlBbcd4/sgTP6iPSRkhKdwTBKpxoYhWzicq/YwZ9W2vUf+gzWPyX1VQi8SQQzHQ7A0H7/LNWFenZw4qubJ/iY8EPEEydtP9ALQAxZxOKea87/hX08ySU9fEUJXNNua5V8+TBqlLNWYoo1MBR3Eah3vP7bYyAh9g6qHP0H7nr2ek7FwQ/trN5bYc+2Z8u80tS86HteNRXwi4LNWSpjyNuwQvNAut9Z0CRwJbiTg9UsB5ubfhFj0JJ+gDTc9kAv/1OnqPK2T7QONnJbjjNSp1rMHrp5zHhXUXE7YY7jaUg7x5sJFP0mULWsOHJViAnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaPUC3UUtZ/yvK44gMMvnW3YDOPQD1FoYIAiopeeduI=;
 b=goFv9y1fjRtirpjIS/mxvVYukhnl186KOO24UstADf3lu6Iq+TD3nsEzNiRtnm02wBLd4M7PTdWPAMl7dEPU/UyOArIW+mgEPjg7SfMh4/XWqXSCzS6D9oze2KAOL2uICeIFx2b0dqH53aNvlMD+j4xVCUnNjVkjnVmhd87ElL+Vqbtv8qFfZpXsFmg0Nd4p8pjQNipZXR7V+k3vFE0Q0r9t9outW3tof5IlbCue9oUjc2IdWW+yoQp1UI4zxuGODu2dQeRWTo3gNY6RRXflFetNmhwvgDsFP5WV1zys7Mkfr3KRIeAHsR5JFFOp32FM2g+Br/kS895xVMVkBp63nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaPUC3UUtZ/yvK44gMMvnW3YDOPQD1FoYIAiopeeduI=;
 b=dQGCbdxeifRhizU05RL0GwDN/aBoKat8guYom8oMIWeti2BuLMPlhoFcbEE9Gz20pnQ3B9GsAU9VvBI6f11ZqZr5SC239PkvJ/B/s48I/jy01BV516lpgsO9RjUZ7sHtqm/adezqiQVGrjWjxMJaM1i01B1LOTFSubkrkG0Ap/NLTZLMJsPfzpNS2zHff508Uo6U+ZIRjlzh8k15cCO7fB4p3ZkC5RQKuKOrztigNGQ3+vjyoKRTSXmlyGqccuHnVkENZZsigP61Ezl2FHVwKYgYQiPHHiRoOgLJhVCFrwstjz/Va410MXmdKlz9nhlG2I35iv3nKrMJPe0+i5GXxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:22:11 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:22:11 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>,
	Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>,
	Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: [PATCH 4/6] sched: serialize preferred cpumask update better
Date: Sun,  1 Nov 2026 14:22:00 -0500
Message-ID: <20261101192203.6979-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:408:ee::24) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf2e147-deb8-4c06-39f1-08df384d6dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|5023799004|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5cU5CAnamzNUTMNpDhduu6+ZM2JuWjqwT7PSHbQ1Sfe+DxTh5RaDvt4yqRv5xIBmeRMBCa1Ivnkphplysg3tHzx+ZbPtc3LROd1RrhNgM65j2VEQTpFBo+M6qyayOUb14y/52oRWAO5wx1uVqMXUIvzpZ7M5ce70hx1y/ho6h5JBiyF8aZvy529FdHugDQklEVGOy0x97YCQKy97TvlbV2Z94qi35gTAiyKJJH+aCaHDoo/tQC7s4KFl/FaziPw+ha9vuSFemjUm4uAxbv0So+Qy3GduHA/LLgvxrf348Z+M9B5UXnRzNOlr3CdMtfItK0yRiaqIc8OE8ktJyrOv7WC+W/0ECAD5HXOuA/mQlnLSPPAoXvZDeqMwlbkBtuVL2epVHcf5G1G0xBmI1ibBGrE0iF/JvEAJoC5C932xmXmGT4OxKWiu2F3tp1kWB8yhTgOOZntEKn+Tf1WPCl8cfgmDLDoKOcV58zpEbCt1Ud5Is6pY9LsjZo6euMNG0XOJI07qT6JdZUkgqtkM0BIsvhXHdXCEGOifiGIRmTwgFVD9POEGordai90S3acnZsIkGhStx1Shwipv7bwjbR6WpYnlRAA5PWqEf9+MAq5ifg28/Cl58HTEv61gQHLlUaUcjoBbW0ZtAyFveBtVroiBeA8i+dUArX2CzpOwU7MbhHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(5023799004)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c786o2lVwW1Bsj2cbynpGsux29akiIWlRVNWQNU8J75D7+3YCE8vASVW+X4W?=
 =?us-ascii?Q?ZHirt/6Bo3/QbDVip3BeKq89l8wPgehsuV6c74rkWCw9adiC9P0Qtm2FbkuU?=
 =?us-ascii?Q?wbLvsMUL7fS0u3bpA/b5Y3RAKKz+K4WcapLM1kUYpGbU5iZLiZEoKHkjtMZ4?=
 =?us-ascii?Q?h5h7a7vPwPqTHsCKB+coQeM1pWv8QerR8p0cbyFilkZQMbiE3OfhBa6PXAOT?=
 =?us-ascii?Q?HUUnCld+lwfZuy/73+87gigRQLXq0zzS/7mNhz0S9iPPwfj2+b1dQ5nd/d9r?=
 =?us-ascii?Q?kQ2iW3xZjfls9V+XZx7e/ODD2Xhv0ttCtrTTmrB7huL1c2FBJCnVczOdmd8w?=
 =?us-ascii?Q?F/rkWjya30uuwsaoav6rm7Pv++ib2d2S075OKRbZD6DbZfrZ8o1AFWu7lDn4?=
 =?us-ascii?Q?Wjpifu8wQRpskOF5d7PGxGqg8/MUhAKP6sOjCAwg/YDqDQebu6WiYLZV9DlN?=
 =?us-ascii?Q?B7FqtuMpjEo5Uxa03VGrX5tAT5jKTG33ilP0Ija1AWz5FB6M9irQnZ7l9i72?=
 =?us-ascii?Q?bJFdwYvoEmx102MU9gB89lrc6B00bUr+Fm2VkENs4MY2RRBmdvFEapCXoTZ4?=
 =?us-ascii?Q?7EgglT0sNaDCnPGiH2VKcoLG5PbMRpE5KwTzPnQgtbYQVRDMnw2WJicgjJkQ?=
 =?us-ascii?Q?gIWaXY0TOTgZnB3ROrj/6CQ0oIqNMmk/K1Wmj0YvBRYPkN+mH1WFOmOkvMHo?=
 =?us-ascii?Q?IVHxm5UivKqBHUd5uY2skbf2fIqi9I8Tbi49IEhEUoJUKd67p6HNY6G0i17k?=
 =?us-ascii?Q?jZqC/zg2Zv1cLg1bg2c7y4mcyeNWy7d5PHP3t/tbdTA5YM89ei9hh5DO16WC?=
 =?us-ascii?Q?CJ0BuCbUWG3zYup3TVxCEltv9V5pVixPOaMkpJbwzvdGFr28018CRDIB3jxp?=
 =?us-ascii?Q?SwaR211khEhcV89q5jkfmfi4MTI6GpPB54Ti1Uz1ga3GpeyZYRgXCoOwvq4R?=
 =?us-ascii?Q?rXx46RqboQUt9OKelZ5XGwCqDNc9l+T2ZVScXjZDukguxDBllbkZBDawnMPX?=
 =?us-ascii?Q?lTkd23fCN5joH0rwv6YCuOErtTmsvk52KnQfwiZRwflIYzzwQ4KQTEEwykAb?=
 =?us-ascii?Q?h4icX3DpCqX/kyHvXTM2xLah4NQ0Vpat2gtMC4tIaGXV9+wMioPWxLxlevVJ?=
 =?us-ascii?Q?wqi15XuJgntimTCwvgR0YCX8LHK4sPc6qZSGKQS4CU5TyL8ZelZ2Fk/4jAlt?=
 =?us-ascii?Q?T155TT8Af4TYd4caibfLOReKymQbB0LJT3cnEqOj67mXFF4uDrq+L4sY34Cg?=
 =?us-ascii?Q?CikHCAPGc2ZjGlXU7wXc9KlcVOQIQf227kDT2P5Regjmmgx2kBBw2ounh/yS?=
 =?us-ascii?Q?B4fv3VIgsZbMcb7aqOKlqIb0NGCn6FKScm9bLhbxTJsmuA2dveAriQpsz5OO?=
 =?us-ascii?Q?0WqamOfnkfD2cuakGDqCsdZJ9RUMjW+68WCS20HzFMGHpQjFnflXxVcL13Mc?=
 =?us-ascii?Q?z00jzadhLSemd65JAmIzil7OoCDFNk1jEEVHogv6ZUAloCsrNb2EFGVWIk6r?=
 =?us-ascii?Q?Y4pOzC3nf4PDqRCxXVbKi4EyiekKNb0PTQY/iyioO+eFGBcXWs0AAwfuuEkK?=
 =?us-ascii?Q?oSud/fwVJciyIlld3qb7PvfSzT4WjRQiL0aZBeMxmmw6ip8xF4iugRFxQ04M?=
 =?us-ascii?Q?8j4uU0FEGczCqwlKd1WPl7V8Zc9kgMLk+30x/XAaFGALuJfVmZ3MTiNy0dDb?=
 =?us-ascii?Q?rX3Xm3Y9nI0qt4ZW10mYizeRDIu43/ZXI69YaI8dPWoMNyX1MrGEap4CL9or?=
 =?us-ascii?Q?JsSUN7VFlosmRQH7gDTkPP8+d0cvWybtKRlmBobjUDeI3kkPLrgq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf2e147-deb8-4c06-39f1-08df384d6dc7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:22:11.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cWvy4EjbmA5puM7UJKwoWYVzeMCigK/d3Zy/x1tMm/D1RgaOVaaaz+jRiY09dcso/XHc0RsOv80HkjXp98NuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

This series adds more flexibility to control the 'preferred' status of
CPUs, so that multiple modules may access the mask concurrently. Thus,
add the cpu_preferred_mutex.

With that, the scheme would look like this:

 - if your code takes cpus_write_lock(), it's enough to write-access
   the preferred cpumask;
 - if your code takes cpus_read_lock(), you'd also take
   cpu_preferred_mutex in order to modify the preferred mask.

This approach also fixes the existing race between steal governor
sampling and hotplug/unplug.

Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor policy loop")
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 21 ++++++++++++++++-----
 include/linux/cpumask.h       | 15 ++++++++++++---
 kernel/cpu.c                  |  4 ++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 4cd9971fec45..bc3936e69eed 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -23,6 +23,7 @@
 #include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/sched/isolation.h>
 #include <linux/topology.h>
 #include <linux/types.h>
@@ -134,7 +135,8 @@ static void decrease_preferred_cpus(void)
 	int target_cpu = nr_cpu_ids;
 	int cpu;
 
-	guard(cpus_read_lock)();
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&cpu_preferred_mutex);
 	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
 				cpu_preferred_mask);
 	if (cpu >= nr_cpu_ids)
@@ -174,7 +176,8 @@ static void increase_preferred_cpus(void)
 {
 	int first_cpu, cpu;
 
-	guard(cpus_read_lock)();
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&cpu_preferred_mutex);
 	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
 
 	/* All CPUs are preferred. Nothing to increase further */
@@ -188,6 +191,9 @@ static void increase_preferred_cpus(void)
 
 static bool preferred_cpus_valid(void)
 {
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&cpu_preferred_mutex);
+
 	if (cpumask_empty(cpu_preferred_mask)) {
 		pr_err("empty preferred mask. stopping\n");
 		return false;
@@ -208,6 +214,9 @@ static void steal_governor_loop(struct work_struct *work)
 	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
 	ktime_t now;
 
+	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_preferred_mutex);
+
 	now = ktime_get();
 	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
 
@@ -238,8 +247,7 @@ static void steal_governor_loop(struct work_struct *work)
 	 * module restores to active if CPU hotplug breaks those assumptions.
 	 */
 	if (!preferred_cpus_valid()) {
-		scoped_guard(cpus_read_lock)
-			reset_preferred_cpumask();
+		reset_preferred_cpumask();
 		return;
 	}
 
@@ -276,8 +284,11 @@ static int __init steal_governor_init(void)
 static void __exit steal_governor_exit(void)
 {
 	disable_delayed_work_sync(&sg_ctx.work);
-	scoped_guard(cpus_read_lock)
+	scoped_guard(cpus_read_lock) {
+		guard(mutex)(&cpu_preferred_mutex);
+
 		reset_preferred_cpumask();
+	}
 	pr_info("disabled\n");
 }
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index c65abfc8a97f..fc911a153b44 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -123,7 +123,14 @@ extern struct cpumask __cpu_active_mask;
 extern struct cpumask __cpu_dying_mask;
 
 #ifdef CONFIG_PREFERRED_CPU
+/*
+ * Drivers must take cpus_read_lock() before cpu_preferred_mutex and
+ * hold both across mask validation and updates. If cpus_write_lock()
+ * is held, it guarantees the exclusive access to the mask, thus
+ * holding cpu_preferred_mutex isn't necessary.
+ */
 extern struct cpumask __cpu_preferred_mask;
+extern struct mutex cpu_preferred_mutex;
 #else
 #define __cpu_preferred_mask __cpu_active_mask
 #endif
@@ -1199,12 +1206,14 @@ void init_cpu_possible(const struct cpumask *src);
  * reset_preferred_cpumask - reset preferred CPUs to the active mask.
  *
  * Callers must serialize against CPU hotplug and other preferred cpumask
- * writers.
+ * writers. Requires cpus_read_lock() and cpu_preferred_mutex; or
+ * cpus_write_lock().
  */
 static inline void reset_preferred_cpumask(void)
 {
-	if (IS_ENABLED(CONFIG_PREFERRED_CPU))
-		cpumask_copy(&__cpu_preferred_mask, cpu_active_mask);
+#ifdef CONFIG_PREFERRED_CPU
+	cpumask_copy(&__cpu_preferred_mask, cpu_active_mask);
+#endif
 }
 
 void set_cpu_online(unsigned int cpu, bool online);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 376d297a6292..dec08a90ea77 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3106,6 +3106,10 @@ EXPORT_SYMBOL(__num_online_cpus);
 #ifdef CONFIG_PREFERRED_CPU
 struct cpumask __cpu_preferred_mask __read_mostly;
 EXPORT_SYMBOL_GPL(__cpu_preferred_mask);
+
+/* Serialize policy drivers; acquire inside cpus_read_lock(). */
+DEFINE_MUTEX(cpu_preferred_mutex);
+EXPORT_SYMBOL_GPL(cpu_preferred_mutex);
 #endif
 
 void init_cpu_present(const struct cpumask *src)
-- 
2.53.0

