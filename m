Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599283;
	b=d4o0pUTGaomeJe6T2z80CaSboBs4qqIdgiTSEncDnYJ07wKgW7cT7J+Vi/cX+oG1mb+f
	 S1dHaESoq7dr/lEalDS84IJmTZgScw1ekbQNRlWFjC8KRT8rEtG8UsPfUQZlX9UzpLxLf
	 zkSxuRGqybRQYvQRF+1voaaopMtVYj4lL3paXc1LtdK9FHlDU4QuwAyve05pnh+3S/dh2
	 lVw1iQrFWpCEo7TlO1X+52B6kTnQzwQFCV19if1RloFpqUBsBsNIJYALI8GL5TSESN4eh
	 E4/crD55TucXYA1qSf4sdFyjINuOEL4qQy9eBEPgIgRJbyHSoMfxozU9RcW2lxwqoLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599283;
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
	bh=jJRREDE/gASpesh5fonT49kFnWEoyi/XOKrST20kd6o=;
	b=zX3f97dsiwDC5kS7X/ByKS6jaRmje8wNYsDo6EKz8WCdo5/asJ98geOCQBcEyEbOjzzi
	 +L1HYwqVY83BgEcwQ4BdAnQfXfdsz+u82B2ceJ5WuCZ6Amnyy3QYtMhakEg6fL+FNx0AL
	 GnlqOH64QwrxHD3s4tdRFCpPxGnj2V0f8/tkiPERKp07GwADSzOGZSiJX+j2wwXGjdMPM
	 0gvhIf5hJS/jcIDCF7EUiYVxFQbKWvb7hYaOqb/zr8MJpxvn98gWDU86cD++GHeKl3GE6
	 tKzRyV8M8oDSj9GGIAEm/N6Y17JqGflbuURm1T52gFXsKxIt9vzJogx5yutiwnX6WfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OGhRV9xg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1B606A334;
	Fri, 13 Nov 2026 19:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F1B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OGhRV9xg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ02zvCDZLtgWAz8RYFRPl+ci/Xfz50qWHOwlUpumHryMoqzix+M4rTLDhaeQ3yr7dEde9UJocl2qPzyzbq//dajUQ5e2vRrEHat3pzNXOgJ7BzbyKYFRJPFnO0I2yPxggt/gvijhpscg2ghuzeBB3wNh2JqQTJW/WI3m/4EtRu3u/bNQX6Py3oGdsevAl5mw7ffIsSfgJoq0jSoz4oZ4HYBvTDzidrxnRAhQ7GSY6soswdf2jXSj84rwD8MFllsmzWuFFRa3KNff2l9CFJ0MzDCSpw9S6z6FbJc0KGS2mf/r93zbD7uz1boW7bj+808Z7jKufYU7UESqrqEHEkchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJRREDE/gASpesh5fonT49kFnWEoyi/XOKrST20kd6o=;
 b=X9bM4/gQjY39+RGxTwBXydq+Y/SQ2Q8AGvb9rxfkxc5VNfsfUuYas4eACj6d49ggiKUUPeSkqbdvjqWoLAKb1nxsW6ceigd3Atrplof0lM82W/hNIY8rfQsLAjRUde8/ggP9g6IKodtqNdHm8LEyWqD/ZQrG5PjmlKKU9yJgOTs+CQE3BtS/NUSEGC4gq4R7dDg/ynE19L8Xyke210QRbsc6ZDIF62VtRLlHL4df+5P9HAMabXirSnz7rJac4wENKZtZ7sEERxOHNGTIGh7QD6jewPCAZ5i04qaWNh7XO4vOfgna0jQptHphjfoufpraFsrc7ySU+sdZYFWvhxwmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJRREDE/gASpesh5fonT49kFnWEoyi/XOKrST20kd6o=;
 b=OGhRV9xgJCtoMn7UTWrT4plw+pmZ0KNoATYCNz76McFa5pHDc/IV/a5KF4vucVgsrlI4nagdgIqZYForL0Uq9HaDC7yQrDjDCtLNiXLyMFgc6lk2pSYELrK1ZW4yUeXKjGtbs1LPdmRCp9jpqUyQF2iYu2V6CaF7RnDDf6SvAbzGEM02UmgQ1qubpriwGCyIrnr7HDlPvPw3mGSzbIg517b1a24dWQua6WxcbUIc9Z0i1sAL75u33McDq9NJAQzOlhBNIiqRwPR5ykceH8TGLX5k6bEHlRqMlcnXO8eiTd76qLn3lrV5l+3FIQrMYUhV2wiG9zg1DZwu+zDqCM1XLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 18:43:04 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:43:04 +0000
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
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
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
Subject: [PATCH 3/7] virt: steal_governor: remove the minimum elapsed-time check
Date: Fri, 13 Nov 2026 13:42:52 -0500
Message-ID: <20261113184257.621707-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184257.621707-1-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed1c0a9-632e-46f1-05fb-08df41b5f388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|261021123027099003|56012099006|261022113327099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lokQqawQdvj+yKdowwQT1eTRO5/bx1GRFf3I0W4qIFWNqwfxL4KhkoUwhisRBPmuHksAwfXXsjO+Af25BNGD+IGdYP94lbXnhFfg+yVGSXZCxd5RNNLDngZltZMaYmEe9JEEI48UVfyK6aYzdn13cLgnFtUvBJ2eFs+kySaNmd+ffkPUf0yo+HERuRAGBQ45au8Af1eheiSa0HMxa6qAArutBR24J4/cTrXw72xbNcjKQ5i1MZvKCkdXLTv+8BHioIcO0iEZ5t9If0lvzNE2AtsH70gofRet5DBMm6shyO1kDCStf5UnRfr+kxL2NTi8N4TWhhZQqdD1kosf9Pnj16KauHgH+XYsEi4PdmHWUE2L5AvDo65ORKeGN+bEPVkTid1BNlm+zTzWEuf4DR4j/DB8VnnT3MpP411OInhacYvGZ+eAgcSqOGa0kis9d6RNVFRhnaS2U+zNRORhhAREsFwu20QkO1uWsCKImtlvFrvPk3XExl6GpRiyNI8hm9lMBmmuw/94x7N5QchdvYgJOBznXmlxxZmklcbTv6rZA2sOGuC1wy0i+lHOoQHIPUyNbhMdo2+ZvLMOJVILRLxCqZBlBCIWD3K0PK/7SbJx/kY1xbA0r9ScUeihvKeEazdBk2RqrJutqcNRg4FxjjkRFVc0VA6Q1oOzIZBiguN8i38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(261021123027099003)(56012099006)(261022113327099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?isJzxuq209s3EE780cWU31LkOuMYbvb8uIM5m1yw2iFiXoEh3959GpO99mXg?=
 =?us-ascii?Q?9BfeRqymgBbI9UIrRQLDMQP1x41GvSFqYB3s+EYqAd74IFpj/3xrEfRmXF0g?=
 =?us-ascii?Q?4zMCGI53eIHylYSRvaBPZ8v9JtYWdaRlDkLfBJAC1DViM33yBNwuYZgsCyu4?=
 =?us-ascii?Q?0RMVdPeFdC01ywxjHamZujP2/3QPRbOKBe/QAqxaIrVuL1mXY0Os0o9wK9sO?=
 =?us-ascii?Q?kTS/DHrpZXLDBRqlmX1zzxLP0Uo05mzHA2tbeYf/2AY+5Qt1P3VUXyIUMZs9?=
 =?us-ascii?Q?1a2r4eYQ2dNJCse0+zPL3YO44Fi4Lsnm8k1azGSW37G72WwifCFI8RHuUD8/?=
 =?us-ascii?Q?+N3hbzTmXwIYViEBJE7ng2SXRRUutMN2r1iQS7SbjBGjX28CN88wAHQZhqIW?=
 =?us-ascii?Q?e7RnNtOPgQ5h8gslpMi0Y2K5AMtOQWQzmlU7jbgh6qgRrO3OugfiG1dcOdPv?=
 =?us-ascii?Q?IE0zIrXHfRtqFJQpNwrxiy4Qt+L1JAbkBtL+OuBg8J3ViVsyj8lwYtz+Wz8S?=
 =?us-ascii?Q?OQkt6U3Wd8RE6f9UtmVjETvVi1vpjjvW4Z5dzfR7wWkBoNwY/RwOYeOYKrT6?=
 =?us-ascii?Q?HuqcM1ApUBlKOgSeH6HAGhRcBiMO26Y8InctC7/BFDEFVd3UxxFf05I8auaw?=
 =?us-ascii?Q?tGHNLi/4rjseeK1rk8kfWTEyG6iTllJj9DGsLPt/yaFlMMTyfKIGIzGpmXQf?=
 =?us-ascii?Q?APxVZ5jmAKOtG5cH/ueY5q0kdga1TtiVOwW7xdNE3MI4m4xFZ1w5l+14bHdA?=
 =?us-ascii?Q?016OCpCBrjT+bqlZiXAvfymzVgFSu0WZyspG0KUbXPAbi4yC+BCczHNQh3T7?=
 =?us-ascii?Q?5bcH03JLQKKhiuZ5lZcJz0Q+d0NegBrPT041XnykJPv8QIVm1Rd1d0QhkZv6?=
 =?us-ascii?Q?PH3Eh/lWQlIYe8r0LWLuBh+1rkA7RgLQ3LEulCts2duk0xXMeMTJ8o1aUhVF?=
 =?us-ascii?Q?tOnDTPoJXNN8m07OI9KJuaEg1c6dG4i25idYtcokRGS0M06aw9s5TYqJU9su?=
 =?us-ascii?Q?ZJb/Oyeeg4pkISO46oRN+B9ZGBSuJeY9N7u3hlZTtl1JLxAGLbZJxaJX8XEK?=
 =?us-ascii?Q?UcWC8astan34EjaKh4tK6cVLbM1ZNXAZwLh6bRNpltD8+JozYmov29sZyILn?=
 =?us-ascii?Q?m9w2WoYY0WQMaqLGyVGHXZr19mzeh891QQ3x0anIyoK9yJ+hRNofPdFCMULY?=
 =?us-ascii?Q?P3oUCQxxWBgBCZBxT7ZgkId2qAortQil8lp68ioHeZNqEAEXKIqthFxKki1o?=
 =?us-ascii?Q?nyxkdWATDcbwPjpL4IWq1rgcOXO4RIGMoP+dkBnWzDGv7wnvkt/HnILeCO5M?=
 =?us-ascii?Q?bWE4g+Kc1xRJvSOIINE2uvvMBSSUgIvuIuoBNwG6HGqllyjmB5MCY6EO1acm?=
 =?us-ascii?Q?VU4035m3HXonhjK5dDFyh1hJhBi6x9sUOdb/hil+WPwPtOobkq2yHnya2+mv?=
 =?us-ascii?Q?KM25cejSbHLERZFtHR7TOrzM6L+UMCiyFzR4ebuUSv3C8tgbNuBt5j1z3LHk?=
 =?us-ascii?Q?uMtRfRq3SwagnEa5QkykeqlCcR4fI3Ij3zmqaWuBQti86Kx5JgiAjIMPKThF?=
 =?us-ascii?Q?tnY20SbLfRktzNFilBw2Px+fZXYy+kFVro9ohPfdhGxd6N9emXerUpjBbby3?=
 =?us-ascii?Q?73kl1FZKGEzLeM1pvVctPCCG60aYmi4sAVHQ0Q9U64LJesEFf8J4yOZwQaDs?=
 =?us-ascii?Q?b7v19V1+Xc3pFHP4Q3rWWQly55CW/TAYL8urknYXxsypy9hVOQIHSz1D8psL?=
 =?us-ascii?Q?5LDoawDEzwpRguwnsyrIy7orteFtPAKj0rVXTgb66MjKVhY1c0+6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed1c0a9-632e-46f1-05fb-08df41b5f388
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:43:04.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUTvQRuZZSm3DdNrBda3E9skHAEvgXfpeXBRpIMPJLwuGS7/nwyRxLrp93xlci5BCdcKDLlFJjnuGcHc7fdStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

The governor queues its worker with a sampling interval of at least
100ms, so its one-millisecond elapsed-time check is redundant. The
existing denominator clamp already prevents division by zero when
calculating the steal ratio.

This series adds a hook on hotplug events. It may trigger this error
path pointlessly. Just drop it.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 99bebd3dee8c..26b6bcca27ed 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -216,11 +216,6 @@ static void steal_governor_loop(struct work_struct *work)
 	now = ktime_get();
 	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
 
-	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
-		pr_err_ratelimited("work scheduled too soon delta_ns: %llu\n", delta_ns);
-		goto requeue_work;
-	}
-
 	curr_steal = get_system_steal_time();
 	delta_steal = curr_steal > sg_ctx.steal ? curr_steal - sg_ctx.steal : 0;
 	sg_ctx.steal = curr_steal;
@@ -249,7 +244,6 @@ static void steal_governor_loop(struct work_struct *work)
 		return;
 	}
 
-requeue_work:
 	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
 }
 
-- 
2.53.0

