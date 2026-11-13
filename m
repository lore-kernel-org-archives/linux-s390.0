Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599285;
	b=HQs1C57/f3embjll0VJeDFJZfhDKZjHFb/nXphqD2Y16NvpilK+ui/DKYR/ixtck3QXU
	 HZ9UDRBi/PeIf229MAOiTbf5EUMGNLe5xS+9gYGWolzJtA9uVGmF7Deny7x9zVIagSPbc
	 GUvNlT7YzpExC60uVCt/QiM/N4iObyUb5JRrL5/fgMCIreKgk6Pnx3JI839bu8VgUjiqG
	 CPijal6Hqbz0uq6Z1hmErGIbYjEFGtW9Kk3uuhbp2TX+YB6Bgin0lR2HO2V0WGAUiX+9d
	 BJSJMrHU1rGRBTB4HmLi2SjCVChFs+lhguYX+KJrEvsa4ez0EodYvR19nci+vmVHEHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599285;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=572P3fs5L0aE2ZBUX2LGTjefHmWDETaMk+vg+KJRZO0=;
	b=Ky3yTvZQWAyVBnj/y3w47LcVQyZWYeJdYXOK3NCNMsg1Gt6YgS/142W7TZwySsuPbMft
	 cKuZrJZNLnB59CwNK3UX2h1zX2AzJPV8nJF3pS/WCG5rrelCc/04qWdM32zj27p+iaGm6
	 +qT5lsrRiIDe4LNJ/1I5y/9G2YSfLfH2UVllHM9kc3hVybaqVFPurK8pYLjwSdlSX9PSQ
	 riuEcylTPr27N21PgTbBSdNR9T4o2yDyumn0dy2W/OV/s0qBYSwG/5RZCY2bci5eGrGl1
	 XUsxCmHN1QYO/iwnX70RbQEPnN7SYragUBTfFQAx2Ev9Vivgj7IPeXhg9bgf4wK7PZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Pd8RlUwP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C9606A88E;
	Fri, 13 Nov 2026 19:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 039C9606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Pd8RlUwP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I97rdz2/8eLviVcryU8iPnEWgh6FDjey1k0ZFcG33rWcUzVKSmbgHY56s1ytq8xDRKEKrEsutKxUX7eQzaZz8iPMcm/xV2urXNyju0cP8B81gaZepWjsylrliB7GqsCxk14+XNdmX1zheFXapjbkhIt+OOlm1f7fjKCiyx5FR06qFnQadXZfGwS6vGc1oX/DHR0QN3psGA473n5i/Y1eVohb1oeNt5oW5NzYSPtA1qF+FfrdGgMcL8zXOI4hS8gE1CPpcSzqm4AsnpqUU27QS5poMbRwpdobMHW6H6YtKUuH6eCW7IpuPLi2Vxc6Bv1nV7KD1/kk/FJDMpCW5NTGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=572P3fs5L0aE2ZBUX2LGTjefHmWDETaMk+vg+KJRZO0=;
 b=mogZ59RUyY6WSXr4bf6wdHGWuNsnOb9SFoWolq247ZQFfTjhnVrMe4VKr34PY+wEOpYlYr7Xd36lvU4qoT8JH0+riInMu6PvTnEZomlWLvX4knGPQnksRRev4yMxyDO0KxAHyUndls0qdDAw90K951/jkeKLVo4Sx1C3VmuhydIRl3lbtRSiGycLoaIFZUJuWrnImWae0znOx6mD85WBZ2wnd1kPuUGRX9dWb828XAomVLTAf23Ag0hO7g/7WQ59/17uIIPnIx3l7gAARiTeOxFDyh9WBXYJmZvT/7APUGHM4flgwiiU7R+gGN3dqOS1oCgdh19O9BGqR+Mhivo/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=572P3fs5L0aE2ZBUX2LGTjefHmWDETaMk+vg+KJRZO0=;
 b=Pd8RlUwPBW9tNBxrO5cpv/u6SOjLnanPsbQ+VJNr0LpqK3gK5uLWuh/dk1vNHUI8AXfUvMIoaSPRHXmofopQwh4hJtVH0wYuGvWyBQRx/K46pMHA+orod/aAZ+JfdMNwebTrGjSSsuMa90SgDSKxwAm9zXV4OhovIpa0DoFgraF/ifXDjdeaNzeUft2NUjLIomhUg3ID7yM4k3vnwTqaACVz5ycrE8+8HiHDlMHBFIUSX6ZxX9txkk2CsEgwdi0LGsgX1kld2iyfBoXNLK5Jr4HDC2DhZWCGvBsg/kdHdTw8WFEZKLdbxBIhEJ0WiaTwFnZBJF30hn6bFqMQ7fsGeQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 18:42:59 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:42:59 +0000
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
Subject: [PATCH 0/7]  Harden preferred CPUs management
Date: Fri, 13 Nov 2026 13:42:49 -0500
Message-ID: <20261113184257.621707-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:208:2be::11) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 99d6f12b-b426-4047-01e1-08df41b5f0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|261022105027099003|261021123027099003|56012099006|261026140227099003|261028144727099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	K4cqdTucxezgwzJ6agwxD4Ab2jexTLRlY8Gf+9+PnKnKsBs0LaZQOjt4JxcfeY4s63RuEG25Qu70I7P+wL3XqAdGmo4Ai2Bl6lnomHA30P1tqi8j4L9KvQJzpXik5sUKpbQW2J5ClvUzKv+5DP1uuENmqgsf2T+6pjeZ2uIE6Ptrp7dbVufDN8pjZM0NDGHi73nsuw1YbhrplqR5NZeJzM83F1AMIW1tXlWGF5eh8uws7WXsZJjcgedDOmEftPY2xXtRms2oBL4gBJyyHNcaUhxe0L5IdhzsSm+G2jlbne8kxGcKvt+YscA68U9meu//Ulr2DNCj2uLmYl8IPFnGAbVT4L5f6DudOUxDiGkp11zYFZ7Dyv6cdgfEjDhaVup+5F668H9YJbhD8i8s32E9B0E42OQTs4ZQi43poP6G8f1+84KErKrOpZJ/gR7M6OZpBKaHqEOWN4POrJc5Fe65313i9gHsc11C92q/FFN8TdKxpbSarYaPGQqEwN9F7lt0c5cDH6faxUNizWnjL5ldB6ifFgLAdscK7RWhUksKPN7lfgjnHC3ocuFAXsA0w6HalXjP49pOLwnzavOCT51SkSG5mlPcwbDKtqgeqEu230xHqDWWy7SMzGHoZaDwp6ApeiFIj4deNnDyR3vqlCLbQD1LbvF5X7CnL/GqqhJhpS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(261022105027099003)(261021123027099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGdUeWxCbncrZmo5U1lBTjJRKzNvZTJEK0d2VHVwZGNhR0hwSkxuM3pueVRp?=
 =?utf-8?B?WnRlNlhOZFNhVStzZ1ZSMUZGbUoxdzRpU3h6SFU1dHdlOWJoNUp1Vi9BeWFk?=
 =?utf-8?B?RHZpdHliTFF3bEZFSG5Ed0djTFhLdlNCeTZ3QVp3aGVFRnNEdVpEOHJqalIz?=
 =?utf-8?B?RkdNbERpamMrUTUwUlBFNnlDSHBIRTVUZTBjSkt0NS9hVzY3dWtmN3hpZHhH?=
 =?utf-8?B?dlMvWUpsZlZmQVRScHNyNkZqTEd1OGJkUHZhZ1AxVE4xUkdpaS9QT3FkR2hW?=
 =?utf-8?B?cG5DQ1hoU3JCa2oyZmt5amc1ZncrSTNIMFkxTURYaTZmbmVsUW1seGwzZ2Zt?=
 =?utf-8?B?dVZQVkpuR2xJOU1EcjdTQUVHdHFFWGUxMUNkdXJGUlhmRTFjWC8wdW1RZXUz?=
 =?utf-8?B?dVhoWW02cm9PNWJSMmJRQTJzZ3JvZURCbkcrRStHNzh3bWZLRGVMR3JYWDZ5?=
 =?utf-8?B?RjlMOXVENjV5VkhpdkNhbkg3angxWmkyVzNTTkovcUlwb0pCM1Y1RzErTERV?=
 =?utf-8?B?OEJVQzMrRGZhME5OdC9mR1FDRU1BSXQzWnpFZ013RzM0ZGEvTjdTaVgzWlhn?=
 =?utf-8?B?em9TOFVPMTJnNEtYdjl2a3Q5cDFjSXd0MjVRYjRTeDZSZzhnaEZ6UkhhaUp5?=
 =?utf-8?B?R01BdTBaS0psSzViU01vcE1FVUtOb2QyV05JWWJlUWxJRUx6bjEwUEdIRXJV?=
 =?utf-8?B?UWx3NjRUVnhFSmM0NE9lU1NFY0JZVlR4WDBTQUFHLzEyMVRwN2Q3bytJQUh4?=
 =?utf-8?B?MWtJc2ZpdGZkUXFtd0NqaEpwcU1UbW1TSnRtV1h4NGk0SHhjclo0dXU1MlZ0?=
 =?utf-8?B?Vkk1VVpPVjU4dzczdlBFYm11VU5KWGpFQi9NenladWNCVkpnOFRERzhWR2Nx?=
 =?utf-8?B?TnRXd2diY2l2UFlGNWRDS3ZpQnNyamlES3VKenBDdSs1L0l6bTQyRDFKL3gw?=
 =?utf-8?B?cnBKS2NTb0RCMzVvTUMvVGdUUk53N3h5dHJYYVJiVnBFa1VycTkySDRFdjU3?=
 =?utf-8?B?UFJ6WHBITjM2dnBHTkUzaGFxd0xsNWpkcEFzbGJEcjFFb0pzZGFWSnRzamw1?=
 =?utf-8?B?blhBWE9aTHBRRW5PZGVybG41MXRKNENWU3d3cXlJamlHVy9qdGJOVTE0TS9W?=
 =?utf-8?B?Ymc2d2luYnBvbVg0eUFwWnhkSEtkS1I3aWVLSjMwYTBXVWlTN1Fyb1FqYURH?=
 =?utf-8?B?ZjZtdXgvWCtWb0tiOTJBRlJjUDErTjZXVWpjcUo1dkxWVm5ZWTlNMjRERlFY?=
 =?utf-8?B?akNtOTNBZHhGb3VacXlYZzVZMWtpWXp6UUdBbCt1ZzhGbVdMdVNjeS9lODh1?=
 =?utf-8?B?YWNZQjVPZ21UY0N1K0V1ZUMzTy9BRlE0WkVxczV2QnJ0Mmt4WmRISHozdUFU?=
 =?utf-8?B?OERMcEpFOG4xR0xYWXpBK1E3Tm5BT0krT2F5Y2xpeitRdExWenEvNytualJU?=
 =?utf-8?B?WTU2QmxoVHBDdkJFZXdKNWdnSUJrQk9LcHZEdFVFc0NqcGlYRnBsRDY2cmtk?=
 =?utf-8?B?Vy8veTFKa0NtZkgvSFRMcXc1c0tGWURqeFJRTSsrSzV0NVZqc0RQZm9Qd1Ur?=
 =?utf-8?B?dDdxblhVTjZZb21WQ0k4VGNzRkRVdUEzWld5eDEveDFZNnJTTG9KWWNYNlNU?=
 =?utf-8?B?VmE3RmZiMytyKzh5a2dZdUdMUU80bHVzdytGRGcyWktYZStqSmltaGNpK0Mw?=
 =?utf-8?B?ajlkRnF0cVRtaU5YU1FzWWlsYkt1WlNMYnExdStTemE3M0NvdnJzdGVyV0Q1?=
 =?utf-8?B?SnoxM2RXdWVyTmlkN0xxMnJSQU1sZzZzb1JwOUlIYi9Qa1dYRlNuUm9rM2ox?=
 =?utf-8?B?OTFyaE9iM0dZcmg4ZFFBa25NeW05Z1JuMjhQa1pYUGRxVndKRnlWd1NybXkw?=
 =?utf-8?B?TjhXZTNlU0dEMjNEb3hRbmpCSDQ2b0JwbEhUSWMzN3kvcExKUWRpc0hXRVVG?=
 =?utf-8?B?K2dlVWVXNm9XN1ZGRm96MmhiWFpvbGhXVUw2ZTAzZitINzdTZDhqeWdUclFh?=
 =?utf-8?B?UnlhbVFKYkpBMzV5cG9GaUNxZUNEK0d1ekpmY2lZa0pHUE9KUUcrcGlQc0gx?=
 =?utf-8?B?MXhZWXFweGdOc3VMZTFXOU5UblFmRGNhY3NkTFVQZG9sVXMrOHFCbmxHL1Bk?=
 =?utf-8?B?MFkwUjBUaGorclpSMGczelJTbWRrWngweHlBUkErMzI0Rm0vR2lzSDlhS1BL?=
 =?utf-8?B?L1ZEZzdmbzhNSWwwTUlwK25maDcwVys5VlpXVTZ4aGZoalJsR05mMS9Yb1or?=
 =?utf-8?B?aGdwbTZGeVlDUks5NHRjdTNwbEgrM2JJUWh5bEV1OUVMTW1nakJJSjZ2NGpt?=
 =?utf-8?B?YzBveGhRTVUzeWVLblBZc3RFeWRDZDQ1THp2VVZ2VjZ5NDhycHRMVS9Wa0V4?=
 =?utf-8?Q?yq7sav6XAqAEcHjSSHAZz/p7mEuoYHdUxj7Qu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d6f12b-b426-4047-01e1-08df41b5f0dd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:42:59.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pX9RMNz3+Xx0ykwItLox5/2VEKTHwtGTgREsdTKEN803cwk/sijaxkJG0DWrbVbz76Z5+aEzKPL6UdNB2Stfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

On top of tip sched/core.

This series hardens preferred CPU mask management against CPU hotplug and
prevents competing governors from overriding each other’s selections.

This is partially a resend of [1], excluding the write access, and
partially the new material.

The write access to the preferred cpumask is a subject of the ongoing
discussion. I'll submit it as a follow up shortly.

[1] https://lore.kernel.org/all/20261101192203.6979-1-ynorov@nvidia.com/

Yury Norov (7):
  cpumask: add reset_preferred_cpumask() helper
  sched: restore preferred CPUs when hotplug removes the last one
  virt: steal_governor: remove the minimum elapsed-time check
  virt: steal_governor: serialize sampling against CPU hotplug
  virt: steal_governor: warn on unexpected preferred mask states
  virt: steal_governor: restart sampling immediately after CPU hotplug
  cpu: make preferred CPU policy writers mutually exclusive

 Documentation/scheduler/sched-paravirt.rst |  2 +-
 drivers/virt/steal_governor.c              | 82 +++++++++++++++-------
 include/linux/cpumask.h                    | 30 ++++++++
 kernel/sched/core.c                        |  8 +++
 lib/cpumask.c                              | 67 ++++++++++++++++++
 5 files changed, 164 insertions(+), 25 deletions(-)

-- 
2.53.0

