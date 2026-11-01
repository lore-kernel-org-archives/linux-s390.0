Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560932;
	b=QrZA7lvF8nMoBve/F9+hyVGbZykCVJmbGvWHBCmT6qqQVzACkwTHMv8wAvuqlATzJJfV
	 5W6R7/NWixW0HU1tWsS+Z9sLUbAsTr2z+DsSEkRH80x6hENQUhHu8kIVi//u2al0b0c2W
	 VQMjHupKJ29ZeEYnEZNswZnycUpCgZuDkTJ5Scy0vO5v0aP72mUK6Pn7RIdNmCWLzEUy7
	 UzUZH1Mi6RY/+411p06ygFJuplgeAPbRK5u77LmGF5Guj+dDDjdTWOuY91lvwlGXjEClv
	 ssXJ/HmKX1Sv8r5gaHONyXp2Yp7RofRkLD8R0n5nWXtuo/iyyGRSHXhFeJm4aznFNbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560932;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
	bh=ZKAziJy4+1qwdImzKZqX4gHpaSP+K1BCegiCHQXFMvk=;
	b=KA7Wikn8mLJZR6IYWOmn30iqyjkGor14iL2brxzOOu7qf/WzsCd/Mf53vY0HpmbKZqVM
	 4acPj+3mGvgfuckTicPw+BQiQRBmiDyaMI22SVc+X1RiD4wIealarvhS35CBe8HS7ZfrT
	 1s0Rw/jHBKsmKH348dvf6XrOfGCRpfjaC/OPlKGm8tX0TJTGfc9dkArm+6mvF+mvIMVE1
	 EUbSKSE9lKVCJI1WcCby59kazUl4Jk2mgGFs2/VbabZsa/yRZ+yJKR4Vc8pTpFXHVqrn2
	 xrB0UlwyhzG68I8XLMyLuydBj+y+A1cfs0VW73pWUFGH6U5DIGbH4zjicTj++L7dUmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DfQxcfXl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D5606A325;
	Sun,  1 Nov 2026 19:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576D5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DfQxcfXl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUTd4GG9Or8awWPiZGKQ1YI/ur0xh/Xt4U2mMTNTIMSs+N6TH3E4WQASpkuVJbinIRs9kXWDWDNDUu+e5vzF1fVABuSolOY9RgC4eXMJCFk+Zkrk9wurTsQc8Ppje1RIthRM7ewBrPg1CWRR2DPwoZ+dY7Rm5bx6FVDNQIwDyqnzjr+YmqvYtX78pyhxSUgIC29hQhGY9JeZTCeuZUemzVx6WCZZTr8/4c5DfwENRKVzIM0oNNwfRJQ7nibmTLhRqRQJfzEfIUej0mQSYbOvguE4xYGDBDOoRgFPN5zseO4xMhTLZPC/AoJCw/dqdB9Y10ksI8khLc2tIDlZ8db1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKAziJy4+1qwdImzKZqX4gHpaSP+K1BCegiCHQXFMvk=;
 b=Z/jt0uDVQb31uMqZMdba//vqIKsZNNE4u3Nj9JLGW96ZuDP28lQoHcAXjXuw4hF8BXgKT2DfHub+C3D9dm4nNIQbmYDn33/DH6/98Obo6OB9tZ5cuMTWbwgoM7rDM5RyjU0PNS8YbDang5bSWgqav8sVTYwSTStAHZ2Xcjm629aWPLblAYvVnZPZznAnX2brCJs19c8rc0TEtFTC7REXc5UV8MhDDAneLBoKajAJV21z4QYspdNg8TpkF5eEsRQ29zlHpVabarcEy+ny/b24YfuYuco+ubA3x09EBxyyV+zZiM2ksd3EneNoY/2o0O7peuJQU+sDPOyq8qAjqH+BZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKAziJy4+1qwdImzKZqX4gHpaSP+K1BCegiCHQXFMvk=;
 b=DfQxcfXlxJneyob6u0hIMKd762JO91rZRV3DUMExSj7zSyjiNzQXaLCNicdM54F3HX9jJ2t7rhLeD4e0AbPmO2kYw/Q/lu9ivl9RPjqx3TSDoMwSDLi/V8DJ6bqJlDkV8t97q9warAgx6L7BIcIRhPUJ7YW7SzxnMa9gM/ecN73fkirFPuRgGFOm/3ozkrHv6es202NoAFYiKjweAlq92ny5lfrwJ1cIVw26Al5T62cx0//hkyuivEuOTL5ch1c2Gw1YusYEpSx0GC7tjQa88BqkPIu9cddA5HzWLhut9tJPNFjZE8BGgI8sC/qsjvoruc9/u8cGispjfNnTDdRQog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:22:06 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:22:06 +0000
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
Subject: [PATCH 0/6] sched: Expose writable interface for preferred CPUs mask
Date: Sun,  1 Nov 2026 14:21:56 -0500
Message-ID: <20261101192203.6979-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0251.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::16) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6756682b-677a-4f8e-7116-08df384d6a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zVeJxrASlJVQZPEIegLBsy3qoLt6d4wSkhqID4YJg4IMPg5lrHO5wem+d2uMNUw5HbQOhMYmTPk52abChZ5NUv1OsPWE+4iSD5rhr/Qe61wKJLunS0Xw0lIUFsPzhoL5Bm6xGXkzrOi4lfdOAvPEPZpOw5yg07zkKLP8oc7V2vHDBVYtx/kiilwRp50fxLK4Sne5K29Id+0vr57YcKlcucLJOdA8fotAYSlo2t8P3yFcTngg8LnU75b9aJjQypnNIVElqwnPz8tGpdYtqhuiEYlQypjqoxR7AXFzLedHDSc63TV7e3f0Pmz7V/l6jlPnEGgB4hF21PtqL9+RUcaVusUVmgJWR0Vbh6DRZlomn85SGPua9fV9T7QLmFVrgBEY6rlBntiim4QMJb6dBeJcf+kqrviHUeY2FYbL9rY/Yzw/Y2ZFUioTAnTYR3+HoSmy00newIuezHDlYF1eFXtcDhNsOAuPGqBrge/tx3pJhc3UNW3RJkltEh7h4hkmGXY//+3WAiIChAtHzGEBgHX53oMHbnw2mZcTmmqUkQ7pgY74UNUkt2Luq+QpcNjnEmCzCRX56R1+VekwgkUBN9N9LQ52d1zoslIolf8DaGUUU+1IviJ6ek9bPdh+WU7u0NsogyRolTSc8Pf5javKqDpac5jooxjfKTMnXR6slII+FzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBkezUTnSr488rDpPesc1svjxVKy0uESaeOtK9OMTzgSWmK1lPvdEyF3FBqv?=
 =?us-ascii?Q?oF045jfBOYt7K3enWI1GF2Hm9nkhYfCvF/Rn2HwNZo3EJq5MNLaAsdEzYB6U?=
 =?us-ascii?Q?qtY2GZzhZTthMSGWjIDjKK84OkXo8BSgutDPM4dUwoBLhGQc3NI/m/17uhNG?=
 =?us-ascii?Q?haSmMeGpQiWEre9wxUE79DH4ujOHqp41o6Ef4I7JWbkobDcKOzs0mp9lqhM9?=
 =?us-ascii?Q?+V6aFC/ITiUJTDu1MxDUNP7084WIeaGPnYtwTpHiVT9bJIGrujRxQ0zAxzmb?=
 =?us-ascii?Q?7wT0Bb/QXpjbI/XgCkZ+VhJZibcxTVVGRtpzUbBT1QPGocF3o6WEUbwxgc7Y?=
 =?us-ascii?Q?08byZbWuF5nVMmMi1ycG7CjIhdkWm3CDPe+ajtagw0ImYFDTJKRQeiDzAYkx?=
 =?us-ascii?Q?pOU1u2o79aSo6NTljdAZVfSQ5ehU8EKMASLoqPenR/FKTZEtd4cl343OotIh?=
 =?us-ascii?Q?XlZ/Ps+3P/fxaL5ywTDIPtReocrQOu/aAEZ0KBDgv45Imv3WuFojP+jmNS6A?=
 =?us-ascii?Q?9l2y9Nhnp5TYsA58Jzb/5NI6L2j1zMkpwMe+GkgYIxvZOZvQ9YA1Ik/ZcQcW?=
 =?us-ascii?Q?LAqhlg8Uwvyah5DeQ5kd+fMLnSXjbTALDp0pLzDjtK9q83MvhUiY+6P55WGe?=
 =?us-ascii?Q?MJSo/y9qRb8+mjEUjGDBaRYfIjfX+aBGRfeeJEUq5svFycNZruV713e8Lnv2?=
 =?us-ascii?Q?rkJ+BMc+V1ynMBu0wkFEy1MtE6Q3l9b1I9ZJiKnjAphLFdbHE5esHTUL6TP3?=
 =?us-ascii?Q?Wo76l1p7z0dDXXfDVn1Aprja3WoP/SzZ0d/PGv5SAWyoOpdyahcOkRwNW3vy?=
 =?us-ascii?Q?8DnB08F5IdtqNvHekE9WGdxAKmASC/3723jeo+hXzqL9YpuUS9P4MouAYmIU?=
 =?us-ascii?Q?Hi8huqRTdxlrNtiIDi/AIhDm+yzcfqyOVanwAANdqwEjKiPcHHf+sQq81kgV?=
 =?us-ascii?Q?QJEyD7j0yptONKqKJbcjRF6pY6l3Qrtu+IMf/peI3TPW3Ewd2wLGZTzxbi4t?=
 =?us-ascii?Q?hV0HnmCwtUdHpw1OhFpa24ExrskZzFpMhAVXvT/Sti0U/RrMpV1N681aUaAR?=
 =?us-ascii?Q?7DdarczKaT7sjPaKsgKjDJWC+3yHnnCHU4mrHkr51FPVmBdEn8/iAD1Db01m?=
 =?us-ascii?Q?SydHMxeDMc/MfFQQbol1Ypgi3Kd85BEjFjOLB2liUfi3cHmsRnEwY6sQL/i3?=
 =?us-ascii?Q?9PHblmAhyMRJrsslVEGTmP5TPjyAiz0z2uxYrE0P4pfMrv1XP9Ui8zOcbv30?=
 =?us-ascii?Q?pYyPUDSU9ZcAaJ7xnv3UWrIGiPBGPgUAkpMaUrrGBl0hjrZu9tU7bY9N3GfP?=
 =?us-ascii?Q?Zuc4Tpw0HZF5sd12JEZDW/nWVsyWlNUfnyms8VJw7w5yv5VHjB9j9b+IbBcd?=
 =?us-ascii?Q?50F7qWK4eKbQx2KS9vP/ZrgdSNS1qzQkNAEIy1cxyH5Y+OjzFEUo/qlVpiNE?=
 =?us-ascii?Q?Z0mOYtDzPjOuHUl25VpgV16FBzSJA1SxFuKqZd14wSEFyOVbqaDKd0zI7GLE?=
 =?us-ascii?Q?tlLvBSFKRkG0pK2v24/N1WKRtbnTpYvSnvB3H4SL6edeTKSPJHnvx/WBuurt?=
 =?us-ascii?Q?Prii3SoTNJLpUJR0Mu5n7SA0w+PYyLcDmNIqfk05dughAsRiOXsVfTEG7/f4?=
 =?us-ascii?Q?sbL8AphH0U76kjPDh0SZGu6T4//Gn4YDe/oousKQbZe8emQrL5VzfVbzl9yl?=
 =?us-ascii?Q?i5/3lVyG8lH/nj07QcrWOnLoU05yazuJGvTEitPYzzx7G8OjU7BWX5/7h8DX?=
 =?us-ascii?Q?1xSpHQ6Cn+DJBLlzXf+aYefp3pYLk1xZsEA6Ye3GtNvUQ3wRPoje?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756682b-677a-4f8e-7116-08df384d6a5b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:22:05.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jznJGZ0qGhIlwEwZw8d4r/38VSHPJMPdFhFJrreNIiZ0o+O1XRHVXOy39I0JX42asav/Kee0YQsPi3dfmXefVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

The preferred CPU mask currently lets the steal governor reduce vCPU
demand when physical CPUs are contended. This series adds manual control,
opening more use cases.

For example, setting CPUs aside for selected fair tasks at runtime while
steering other fair tasks toward the remaining CPUs.

A user can mark a CPU non-preferred and pin a workload to it. Fair tasks
whose affinity includes preferred CPUs are steered away, while tasks
whose allowed CPUs contain no preferred CPU can still run there. The CPU
stays online, task affinity is preserved, and the selection can be
reversed without rebooting:

    # rmmod steal_governor
    # echo 0 > /sys/devices/system/cpu/cpu3/preferred
    # taskset -c 3 ./my_workload
    # echo 1 > /sys/devices/system/cpu/cpu3/preferred

The current preferred list is still readable from:

    /sys/devices/system/cpu/preferred

This provides task-placement isolation similar to a use of
isolcpus=domain, with a runtime interface. Scheduling domains remain
intact, tick suppression, RCU offloading, and managed-IRQ avoidance
can be configured separately when needed.

Different preferred cpumask governors may coexist; all update the
same mask under common locking. Manual settings are not privileged,
and later governor updates may override them.

The first patch relaxes preferred cpumask dependency on config PARAVIRT,
because the manual control has a broader use. Even if preferred cpumask
is intended to be used by steal governor, it doesn't require config
PARAVIRT because s390/LPAR doesn't enable the config for their
hardware assisted virtualization. Thus, patch #1 may be applied
separately from the rest of the series.

Yury Norov (6):
  sched: decouple PREFERRED_CPU from PARAVIRT in Kconfig.preempt
  cpumask: Add reset_preferred_cpumask() helper
  sched: Restore preferred CPUs when hotplug removes the last one
  sched: serialize preferred cpumask update better
  virt: steal_governor: Warn on unexpected preferred mask states
  cpu: Add per-CPU preferred sysfs control

 .../ABI/testing/sysfs-devices-system-cpu      | 14 ++---
 .../sysfs-devices-system-cpu-preferred        | 37 +++++++++++++
 Documentation/scheduler/sched-paravirt.rst    | 26 +++++++--
 drivers/base/cpu.c                            | 55 +++++++++++++++++++
 drivers/virt/Kconfig                          |  8 ++-
 drivers/virt/steal_governor.c                 | 36 +++++++-----
 include/linux/cpumask.h                       | 20 +++++++
 kernel/Kconfig.preempt                        | 19 ++++++-
 kernel/cpu.c                                  |  4 ++
 kernel/sched/core.c                           |  8 +++
 10 files changed, 196 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-system-cpu-preferred

-- 
2.53.0

