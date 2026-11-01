Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560932;
	b=EBUwqigKRISzbCCRaR29ZswwD3ED0AfvYm0y8guBgI412afdoSEj3e30P/fqt/D33rXU
	 jFtx9HxM7Ili9KwTmzt9GBmMnYKF+lfRi5UUyCeKj5ij/rORH9+ixof9EWX06EM+Xdu0H
	 8lAGHMQhXewYETinl1obRebNFENn/lVO7utUUFmvsDJeAq4zZx0JnX3bYmDcg2IsCGDB0
	 EF8u8zOP3UiuNZI17zNNJPiiZ0wXB5C4G7UjOcbp0ppZei5ltokQfwGV3G3TUOByrBctU
	 WbPoXPWPi4gdwE3IQd2KDmI+c2/o7Arn8lyOW4Xt3ulVaW9QDpN4xCqHSh0ZbVN/RaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560932;
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
	bh=/7YB5m627xJTh/Ih3HR4uLHG0eyhSXyYzQgkF79lAjY=;
	b=F7QwaRkEL0L9481I6qm4qGf3FqK4MAYDbOLoKTY3VZijisTlwPd9TStTTowzXcgVR0yL
	 2+QHolpiJdVk06Xb2xUE6R6/9xF4AfId7UV/tXhEcIe+Ik/tbpxfSxYN/yRRaOM+c88BZ
	 tjSWO0bROWPZlUf7NA5zvdh4ElUhL+Osb8qt2Mbxy9mGuoR415o9ssKGCLfQgfrjmZNHY
	 fGyawsC3xevGHtjoG+nUwhUA/fxlObrlNzQm6HDL3jzw5uL54YBMxxwj+IZdwURaXZ1+x
	 4HjY5Z6q0CbYh7Rat/KiWrKCi4vNIBcCdhw2m5rrdZUBPkPtbL/N4Hq41NRrYb0z/vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y7qCjCb3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D619606A32F;
	Sun,  1 Nov 2026 19:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D619606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y7qCjCb3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmBL1PcrK9GqjGEr81L/6OboRTc0oK6ektpfNgM7wZk/yQ9QeE+MgFmb4vfQbv/5nPdqtUtS9dFkwYoL2lQ+yIlXDoPxfYJIJvgCXKYj8ThfOsHBsj822+QVfHoajI08l4wgqkrARWaU3Zjqlzh1KLomW4/oAlE0hFdgIgBXP5OD+a4noFElmBlMVU0egkG55kwiRSJ7cpSFrQVSKssgQ5vpGEdShe8mGeqpYRFNVRCe6PPxSndcnnkapSthSqe+SyBUcZYZp5FoSg+XNIG734PgHwaPdWtjNPCRSAMe3+7Y76zmeRMuqTiw93Uy6+z/ov+uNTPik+pl3uwsgxTeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7YB5m627xJTh/Ih3HR4uLHG0eyhSXyYzQgkF79lAjY=;
 b=jNJZus6jydxeQZffeIOd5Ul7awQ5vqu9egP29rezOXsiwwBrV0QACbFHRjXUXglGgBFdZIwGuzUmfDHh5x8zPCcM/YPursfqu+WkpA8m6uhJeTTbRqMwY5s9UImBKHbixUdLLOl1DPmYMo5Uk73pCZNob5lVmg+d3nHCD6RctEk731DwGjnNZ1LTr/HlDqOoM9iX40bIa5fUjrL//yn1rqv5eWDI4N/taEwOtTDU/kiBuseYY1isjWD51azl8TVrituees+D0yIHR8mcixv4EmqH/1viBl3ss713cUy6XGiVFmMsI/MvU2LGst2vMoj1fQhKvP9PBfWlzf6shzhViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7YB5m627xJTh/Ih3HR4uLHG0eyhSXyYzQgkF79lAjY=;
 b=Y7qCjCb3qrEZowdU0yDP56Em7GJXLSmuCBUPaaVVOZIPLMqCQG6C5KMI2Qpa2m8fuFrp5sevEmjQ+WsPMMk3G9FugZyiRlIsvbseSN40ctnRqw+H7wubvB3CkRIy0M62ptK36FuQ9HkQabGfiBRjQDbFoDd+o6EV6NrTeyQRFFoinbh4xe610qKBC7DCxBS7j3ZbpZmFksgt8+MZlPUv3pEULSb62lGFMb2ybiPAGlFhIjuEkXos7pdzOm/5w/fT9lYdAZkootd4TbzNvQ4aR8/+Ub1eH8Im9nmg5n7XE+MK4VGee5QBbTGYXD1ygo/xsWXLK842fZE4SoqXBy7vPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:22:07 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:22:07 +0000
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
Subject: [PATCH 1/6] sched: decouple PREFERRED_CPU from PARAVIRT in Kconfig.preempt
Date: Sun,  1 Nov 2026 14:21:57 -0500
Message-ID: <20261101192203.6979-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:408:113::22) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 36cf8ff4-94de-4041-c99b-08df384d6b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021130227099003|261021123027099003|261021121427099003|261021133027099003|261021135927099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|261026130827099003|261026140227099003|261026121527099003|261026135527099003|261028144727099003|11063799006|10067099003|56012099006|260925022911599003|260925021911599003|260925021311599003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SMk95LXgq/qh52GPE6UTfa65HhjrfsrVNtp8HkpATFWBTmBjz73LxP5Iuc0nMQBKzREbZejVE3zFBGThqxJiwD5niDRdbz72Ei54OqUx/fcQoypBlwX+f2Oe3+WwMwbztsFZ3uwIIvn9iEeILl4PB4lPbjslCL7divjCN5RXHT+6IVyzhhJ4qVOryPdKZW2f4b1OSW/lfZN8M3vBEb223NaCXnHDuLljMs1LiJKWICLwhAIUT8gu92eGAf91yXuQLfFRqcOWLTnzRPcqWG0cdmWkC4ey+o/yJRAZ9V+CxuGdpXKjevWeAk3+dtXbum5w01iswzmM1ydTq65pNXzlMVKb/yQEXHQ4gycK9BmDUebG9SA4L7+4gDVtiuI0YY6lLwT1QQ7VUyZ20DqRBvNxrGbB60CPIMlbEt21pzAVmCGIJ/vf15FI/jlyrnfcgVjploZro/y+Gz6JvZkWTHSTqOehcJBVQRQWal8aev/tHfzYWZv9G0mfRvX+DUfhrEybkfhWBZSQylKGwfz4rKZo2bcUioiZsK/z7xKIBhJV0qlZReX/m9o33Fp0DAMejcsGrAeuzR7L9DEi78GE9uudUrHsphyh1hXlMOGlKVmE4c5NjLlqoufdvZnxyvVLMT4uvFM7vV2maoeBGfBTk+XE7XjnZCSOHHG/HokXbVeQnPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021130227099003)(261021123027099003)(261021121427099003)(261021133027099003)(261021135927099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026130827099003)(261026140227099003)(261026121527099003)(261026135527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dmw9HI8y0w2gJI2ZOqtF5qwhQLZ+DAs2nvagXKlmSr39HTT+/ZeiFcjonxN8?=
 =?us-ascii?Q?9lI545r4G3oAz7SjBP5jOjZ6nN+Qrbv9GS2YOceVWnLHISbpuJUTHaZNUiUd?=
 =?us-ascii?Q?pT3Gb8oZ2bejcLG0ocWg+j+Ab8R9zq2O2d2pnzBs0zJULzaHcT6XNXW3NhQI?=
 =?us-ascii?Q?7x3GG4Ufp5dBUpmrIJzd783yLrnhegjp50OhcpjBauJUBMM8B1XoKn+MaL22?=
 =?us-ascii?Q?cu/DG82q+/UrAqV72AzQ+QX5bYSE8Wj2TlvcYnH4HCllEoMFVpjNICwDmzs7?=
 =?us-ascii?Q?rBVnuEkOaiJBJDRaTe8uEiupUVrVVrXYGHCCViVCMoVioUl83A8M8Axsv23q?=
 =?us-ascii?Q?bje/NSq8sjw4p/H4SQta3hBqP1/dmDqNMKdEISGmzu+jQ4rRIHl9Owf4ekuI?=
 =?us-ascii?Q?thIWxg1YliveSzwgFkaFrQ0ZkL2h+KuJHiK9aKF3M64qTiFChUhXiDegAmO5?=
 =?us-ascii?Q?6EwXzHsh8DEJqJpgsCYRh8XpVDgRj1Llo7UjXJzvKGVgHs62JOsJkHfXgr6T?=
 =?us-ascii?Q?lvd0DQt6xJhlNf7jgn0iQDwAV/ScBzlC2qMgRa3pNQl84XyuaSDvO+LO/mux?=
 =?us-ascii?Q?AvvJcbGUlBCMFUZTJN7b8XxHJyVTVYNHC3xgRT4JD2Bj4jW6ZHm/Z+fuL/kU?=
 =?us-ascii?Q?xJcNFignmMLxZQPsJONxcXN004gDRQizW6RxWn1ZLodFe6Y47nM+PABvyzXq?=
 =?us-ascii?Q?qaAj/BPl0CP1brcuaH89KTDlajeg09RFO8LU5ZGGiC8MGQh4I3w7BLyzjpPq?=
 =?us-ascii?Q?jhdvqWXo+Lasm8VxhwMMD4wH3ot1VvaFnsdTHXXotOS0kTjAzoydBA8p0uCG?=
 =?us-ascii?Q?yjIhAN3uXoMEXFbfRkFcMXhuGdX/89OzXl/uywA9DEWTFQ2rYaQDXSxC3QTV?=
 =?us-ascii?Q?/plZHAjN5pHm0Kul8X1LB9NaS9sDpGst06dVgRMIEdRNURqnHvJi8yvY97og?=
 =?us-ascii?Q?DdK7pVDvalY3Rvq6jYmP9+9+mzWf7Y9L/65VjSzU+vXmv1h8YF6DCpAnNAhr?=
 =?us-ascii?Q?A8yOS9Du93imKWnw4V+zdV/NnrvIDir+WKOEOXwcDb+8MMKZB3PRG9Y15qpS?=
 =?us-ascii?Q?pLeuvdsefD1zOd9oKkd0bYbje5ntf609GlXw/WSsnuReasEnBgcyXCFdSzAv?=
 =?us-ascii?Q?snzDZgOqYP6ZvtdkRaGaws/sYBKO7p+dY5rUNICa4uIATWhaA1BcjGsKrzAI?=
 =?us-ascii?Q?BssZA/69FXoP23ZmKRtUHptAh+n4SxczDALqM6rCdc9NPsLh4vs5H8BuJwZ3?=
 =?us-ascii?Q?XjHNfHeGKBsufd73gy8FIntF0xW13bFhHOOwL7WJIjNJ9NF4Y2mFFlgJPL3i?=
 =?us-ascii?Q?AQxVWdegkInhXEIRvwcxtlkBomIfrAyyg5AK35FdXtnHIV77VcyDLT8M32Tn?=
 =?us-ascii?Q?8d/aiV4gz1hN/DDhHKHBQQwBeh76T4lApPYuW12MekEvS2ajpqPDdUZ/IrZM?=
 =?us-ascii?Q?m8tqKfgh1+xkvbe4oGEnRtcxxqrI+cxPP2SmG53I3LfmhsstPAXEwVNAK8Wz?=
 =?us-ascii?Q?KUTMx/tU5kVDV1x0QHKLMkkiD3jyVLKnM0rjyDGaSwhOnun9EuimqDu6A84T?=
 =?us-ascii?Q?oqh708ftgJV2LBuZE7OaL7Zs+KRF7JQz6IxpxZwhTykKPhnr0bAcbrk3Rmb0?=
 =?us-ascii?Q?agBzFPvsG7N5Vr2+X8pwYceugwgMINFnv6x+1ydjPYTN+btkhY3zhxsToemB?=
 =?us-ascii?Q?xpIhogaX5jwUhNhkAus7r7y0nKM6it91G7Q9j9QeuGaeJYPgRt9lziNjzvZE?=
 =?us-ascii?Q?9vSf7/8yb+3mP09tcAka2fno3GtmD+MxF1azMeoLMSAj/O8BGscp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cf8ff4-94de-4041-c99b-08df384d6b3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:22:07.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VGlbKKKe+7Ruzz/kub+IfxJOywVim5fepEKRl9ZOfRNQ3b2MJtfYalSE3vyvHbjKBrx7ZMrMlHyTG7ChUPGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

The IBM s390 doesn't enable PARAVIRT config for their hardware
virtualized Logical Partitions (LPAR). However, the steal time is
accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
is enabled.

Preferred cpumask doesn't rely on any feature gated by PARAVIRT config,
and requires it to minimize the configuration space and runtime overhead,
with the lack of non-paravirt user. Now that s390 wants to adopt preferred
cpumask, there's no reason to keep it coupled to paravirt.

Make PREFERRED_CPU a user-configurable option, even if paravirtualization
is not enabled, and drop PARAVIRT dependency on the steal governor.

Keep the default module selection conditional on PARAVIRT so other SMP
configurations can opt in without enabling the governor by default.

Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com/
CC: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
Can be applied independently from the rest of the series.

 drivers/virt/Kconfig   |  8 ++++++--
 kernel/Kconfig.preempt | 12 ++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index eeb84e578ddf..2e79ece24a77 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -43,9 +43,9 @@ config FSL_HV_MANAGER
 
 config STEAL_GOVERNOR
 	tristate "Dynamic vCPU management based on steal time"
-	depends on PARAVIRT && SMP
+	depends on SMP
 	select PREFERRED_CPU
-	default m
+	default m if PARAVIRT
 	help
 	  This driver helps to reduce the steal time in paravirtualized
 	  environments, thereby reducing vCPU preemption costs.
@@ -55,6 +55,10 @@ config STEAL_GOVERNOR
 	  preferred CPUs could become subset of active CPUs.
 	  More details are at: Documentation/driver-api/steal-governor.rst
 
+	  It doesn't depend on config PARAVIRT because certain architectures
+	  like LPAR on s390 don't enable PARAVIRT for their hardware assisted
+	  virtualization, while providing steal time accounting.
+
 	  It is recommended to build it as module and load the module
 	  to enable it.
 
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index edc067a0c422..fa6d0eba5b23 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -196,5 +196,13 @@ config SCHED_CLASS_EXT
 	    https://github.com/sched-ext/scx
 
 config PREFERRED_CPU
-	bool
-	depends on SMP && PARAVIRT
+	bool "Preferred CPU scheduling"
+	depends on SMP
+	help
+	  Allow the fair scheduler to favor a subset of active CPUs while
+	  respecting task CPU affinity. Non-preferred CPUs remain online
+	  and can still run tasks whose affinity requires it.
+
+	  See Documentation/scheduler/sched-paravirt.rst for details.
+
+	  If unsure, say N.
-- 
2.53.0

