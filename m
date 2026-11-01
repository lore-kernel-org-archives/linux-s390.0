Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560933;
	b=0jXTY45gKW8/axfU0j/O4fBLPgouEPQRpqRJBW7VecSnkQwkCX1Qc/rpMnmlHGbW0AUw
	 R4gRyQyshSw1/UsO14JU+/E6MJWhTyhNApIv9kgLLRf5vPk2EXOPTHhA3eqHBFPtnCF7W
	 L65pic7FwVPYX649+hxBWKKYVluORwTSWco/sv0ps4zJ6pfCpyAgH4srGPkvwrai1zCde
	 cgvOUBvzPgSK3WJ+1eb8rJXaa2edH2qGERBPOjnG8YfIpFw5SNDefrxSUhmDPY4XerFI5
	 iPwvph1cuGE6E9Dr1wpnRtrZdJLpAMm0X4qYa5u1S70Ktj8dX8rZo1Ojenscc9bXBlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560933;
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
	bh=9Tr49vQDh2Pw+ecApXN2PhWiEoHmLkRvGNaujRP136E=;
	b=xjMM2Gp9ntV5Z5Y0x5V8QoIV7HVFGM4FZNIgxuCdWnTh3NflM0x53Yi8+FrvpH/qH8nI
	 JjarlaZ/WfImBhXBugB3pl3fKSh2j2TBCGdquciTFROf/LYJEbH1k4BE6DnOylIEftWEo
	 WpAOZv14+0hb50mX0T/us8oFVG7ATJ+5zMpZZiKDKviGDnn84n75CL79/7a+GZMb01iQL
	 n3jNlNGd7dBuFeIVyK0av/3+S3UM//CjN5iT5keFKLI++tR8bC2jVjLZizimvC0b4c6yW
	 7HOIs3yD9OT6d0LrJmVGrg5IDewB133sEDA5ZsZAcXBXoHgrSioqEwAKKBkb2S16KYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y7rhJaid;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D5606A335;
	Sun,  1 Nov 2026 19:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1D5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y7rhJaid
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6/WqJNIVpzRag1D5wRzG1rPYiZmSczUkaTLy+/+8bvDcOhYJXTa0aHqxtwC22JH/RTeImIBFQrb4D820d4BzxZQc4LexN6ZX/bexcXNCyGs63160O/xbRW7IkEK8foS12mC/K6QwKvY5XeBFBZjG5HElpcGZwhDcjIP8hNuM8nlE8Jx+xXJob07Gx6Pi61xW/k/KPA5Q/fcjWoI+HO1XAUC/RozfGvw7mPPMn3ey4H8N6axsJsWhG41xwmJAEwDpXygSUg/nxKXOrMQtcU/zzkoU0jlPd0FpbY4joZb0HbLP2r9vgd5NQNXoZtGmo4ZPafSpB3z1RPbDV4dZbp25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Tr49vQDh2Pw+ecApXN2PhWiEoHmLkRvGNaujRP136E=;
 b=wIvjGbfPjt2shjMXTWal4rw+O4VwcSGZXGS3+mU43akH4HJn136+h7vIPnZaFKVcFnCrp5RBrehO0mi1v6tbgF0vvvIURY5LPZFBtadUHbZj1fVlsSz3ihw1oexn5ijY+MO2Yyp6RyWrBZmdnfndK3VYjY+eXWudDufgqnKbYNUB78nfyFTfYleit6WU212Z40U+eZm2SvSBTRMmFCwsKeW0uBTwEjOz21lIefNU73FK+a9S4rv/DFFjqcbIzpMdQ1wUsEj0IF9fEXZXT50fV04097++FqywpF/sRQp9bj5+8X6YiPr2LTNZ0Q6FO0wZ2ombOK3KK+lU+1BMoXQk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Tr49vQDh2Pw+ecApXN2PhWiEoHmLkRvGNaujRP136E=;
 b=Y7rhJaidkr0wIKa4LPnq3jB3fe0Z2ckDX6rjpgQqFyX8AOOivMs76PQznyXDpAkze2HBDoEwB4N3GOOVUsP2tlgWDFfw4mfr/oaGa4BYT+2+BNakK01oAzx2hr2lkfydPvJy7fAKO/YZVu9WkTVbhPvINmrSUyZ3I+LfKGrxGLtaT1sLMsIWApM4J7jVyElOWb4bW4zlxSNc+QSs5CA2LkNDYId10Z/b6QkgGH+1jXNNcOi4hVpMk6XJfCSuxx5bmXaphDqwq14//PMn9rnQ8mxM/jiGLSo8xEc0BwW8av4h/zXtk10c6R/MpB09ogBsaBNM4SRkmWJmsdlHgjB4Zw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:22:08 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:22:08 +0000
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
Subject: [PATCH 2/6] cpumask: Add reset_preferred_cpumask() helper
Date: Sun,  1 Nov 2026 14:21:58 -0500
Message-ID: <20261101192203.6979-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:408:ed::29) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 596d96e0-2251-43c7-88c3-08df384d6c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kVoYyaS9WupZJ87QGcfuwA5iIokXLAPqE1Hwsn2nbbWiEasWH090TzSA5xuLFaCDLQU/s+AZk19en829gZqRqzNKgHxRY/jYu90+Ly8Nlu3HUDpH12dQVJ04AZLL+YH55ydhqjX3zaEBs6YZHmDFzBKNCBvRw5ckKvQXvhCznTtXl6zNTFOWzoPprCAQQDCQlp7jQ4w8krnBL97r2km2f8B1PxSas+QjxOGoYs0DZ3Ru+nHPBE+Sqm7DlH46uhwfTf/Wab33nbPBZsiimJoAZaATP+Sf/WWJL4TgnkAqyBFbk4tl1nVryC30Wtmcf2ypn/1iwiROspGxn2pumK6dXwL4FV7SYGBnwWqr/hEUxzns6h4hUq8i+vJ10+9rFOAuuCu7T9+cPHjv8ZaOWIih1R3xOQWo+2fqDfFurWa+6yKAGkw9BANe46RWvVt9iDij2b5bUEMgkXsKiFWLMG1ZE6che8qc5H18OuBsKMzKS3xM1iOtPRqDIs2UFyGvgiBhICNBgUCdqv31xn67H/K39kzOtxvcbNAaryzz/FQ+UAF77fdcdurPMeoT7OhPBBXn9RVfMrcLRDIR/BI//reSHVol9+pDSNKLtvHlN80wqcgIrl1Id41V9GQDdZswLSgQFt5IBGRcmoIRPntDAaSmukq5C09CKiOESi/8m6dwTSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XNDIeKKaCeXsamlRRF5s5lqv3icbj4y0F+0b4Mg06deamyqaAnwf3nlf/+w5?=
 =?us-ascii?Q?adkB+Odcwd6JUwtim3LZEIZM3IsIc61jaC3N/5zwMPPcGkZ+XjDFQFGFqQTH?=
 =?us-ascii?Q?nyPMluPi2B0fbqmR0rN68hjzAJwB4bEaYPW8qHVuEDStpU5nakY9b8A+MX8U?=
 =?us-ascii?Q?bDVzAaEf+P6Wkjc65oNAa1owekPbI2m5IGtgdKn3CkeK/2YKlDUJtbRQP2Jg?=
 =?us-ascii?Q?wi4lI8DPQAu/1B511ZeOUBOwOZifD3/umltDB30G+ETty2OtwR6ACBHkUVyd?=
 =?us-ascii?Q?GmxaQq1hE5qBkNdXNFKHgHKnl1M+wzEpoXwPmeSU2nyJzmL2nOnbjbWT2TOe?=
 =?us-ascii?Q?GlKDX9mhp0e9M+J9xW7lmXziPyhe9KoA4j0C5pvBuslio3c/2gf2v2fat+2V?=
 =?us-ascii?Q?BpD0HW+8BaJ7kG70K3LSVV+p1iqnCJj7j7s5c6sjdI9GX0Q67a5T9fMKU0Mt?=
 =?us-ascii?Q?sfz2YyttmrD6bjhv6kzP4HcpLg8ybTZkU4GW4JsDDImXggGaYfjryOfq+gu7?=
 =?us-ascii?Q?XVax9oY0RQmD5JIJ2DqqpzvHqLyCkSHRghznBLCHOeVoeqz+DRKodDWZ9rmO?=
 =?us-ascii?Q?py1tAjxqaZFRi0FMhPW41iiiQF5hv9wWB1A2DY7+4n0M7GnCrT6JTvbcRBmr?=
 =?us-ascii?Q?wOPkqZ8JjeC7yxmQScrR83MyN5AqvsXf396DlyKd+2Pyvtvzw3GqppU7hj0M?=
 =?us-ascii?Q?8u3ENTy2f/5NpBIXX93OGXRoEaVqQABAtTc1DzSY+pSJtXThRdb+xGW9esDj?=
 =?us-ascii?Q?uahPa39CRYN0fshaTdiyxoUfZBg6wiU9V/4YvxFPmcZvBe8Clkq7yFqkwIRe?=
 =?us-ascii?Q?OHNe7wn13hYeQvlxW77f+en1DJIq/PSbkKir698lIH6/NdnsiG/OSa8TXuEc?=
 =?us-ascii?Q?peWwo40RSt0SlJ2l9xHOvuDP/PF0UXtVmFu/Y8lFL39moazL2W03aOtzl/iY?=
 =?us-ascii?Q?UotQ3kVFbV9qHhiZk77kmpTV087Y4Ry7OVfYtthJyOaOnJV0Azt5A2V3uFrW?=
 =?us-ascii?Q?82Fpu8c3Fx5agbf4SL3MpksOiCOrc7jzPvth7fgcqCHmuY0dJEItVosJR8e5?=
 =?us-ascii?Q?2Hckbn1oYrnEukzo5RIvE6t3zivK6gte5fo+xPclq+Y6IZuajXxVNfXDM6XF?=
 =?us-ascii?Q?qc2aI4c0OGFUJqETNtR4BYt3z1jmEMZ6QrnGAp9dGfAXy0B348mGhJ3UwyLE?=
 =?us-ascii?Q?Mg9Hucde4oJy7IVzfjeGIdvrqCJQNaXljSNSkTVcy7VlJ/+QYf1NPiaFEygT?=
 =?us-ascii?Q?v7paLMGFFtGscVC6P4eQZJhRxdNMz526YBDzqNL/Y4aUJgZ4kF4seABwZSj5?=
 =?us-ascii?Q?UAZhQhIqJ2axjN9bCW35RqAdJDTSd2qWJRruL2EhzgBQgS8pTxT/t2jr0oR6?=
 =?us-ascii?Q?5FIue36aQvpWagEWXM4Ti7zWAAKkjOBr5bfz08zbu79jkT2B51NT8I80vJPH?=
 =?us-ascii?Q?S916UXKw5fRrUUw1RRNQGqLikfgBFyJPqcYS7maVZSLS1s8QCrLN3YweIcti?=
 =?us-ascii?Q?O3hzok5K3iDaduRz1NcRLCndfLG250MY1UJkuRaaqP5MNNRnC2Jqg5QC0L3x?=
 =?us-ascii?Q?yy5opUh286O+k5kQbxYIryY9Hr/IPO1GM7zZFi9t4TjHqOKbF0W3leslItJc?=
 =?us-ascii?Q?vTs3HObC3hdL++VxcWZXxdhBUI+GFUseWo5V+JoTYKstpnZrcCx1oQhrLopv?=
 =?us-ascii?Q?G+iphSMEwvEA3M8ajPHCkSHssDzrOfsXK6tNYqgIFZ9NeTnzdcMMzifNbYjR?=
 =?us-ascii?Q?6roDyFRDWbUe+rwEmcDCpuLYyZqWTPLyXQKn9TRyWSClWgko1qF9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596d96e0-2251-43c7-88c3-08df384d6c03
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:22:08.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSN9U+GlX6HrFymQbYBdUIqDPajLg1MUYv+9PMunm4ualrAvXEzltvsyE2aHvxzS8dt+kjxYWdk2UA4wNBWDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

This series adds more flexibility to control the 'preferred' status of
CPUs. As a preparation, move the steal governor's preferred-mask reset
into cpumask.h to make it globally available.

While there, rename it to shorter "reset_preferred_cpumask()".

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 15 ++++-----------
 include/linux/cpumask.h       | 12 ++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 6e31f9923dea..4cd9971fec45 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -51,15 +51,6 @@ static struct steal_governor sg_ctx = {
 	.low_threshold	=	200,	/* 2% */
 };
 
-static void restore_preferred_to_active(void)
-{
-	int cpu;
-
-	guard(cpus_read_lock)();
-	for_each_cpu(cpu, cpu_active_mask)
-		set_cpu_preferred(cpu, true);
-}
-
 static int param_set_interval_ms(const char *val, const struct kernel_param *kp)
 {
 	unsigned int interval;
@@ -247,7 +238,8 @@ static void steal_governor_loop(struct work_struct *work)
 	 * module restores to active if CPU hotplug breaks those assumptions.
 	 */
 	if (!preferred_cpus_valid()) {
-		restore_preferred_to_active();
+		scoped_guard(cpus_read_lock)
+			reset_preferred_cpumask();
 		return;
 	}
 
@@ -284,7 +276,8 @@ static int __init steal_governor_init(void)
 static void __exit steal_governor_exit(void)
 {
 	disable_delayed_work_sync(&sg_ctx.work);
-	restore_preferred_to_active();
+	scoped_guard(cpus_read_lock)
+		reset_preferred_cpumask();
 	pr_info("disabled\n");
 }
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bf89bb3f30f6..c65abfc8a97f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1195,6 +1195,18 @@ void init_cpu_possible(const struct cpumask *src);
 #define set_cpu_preferred(cpu, preferred) do { } while (0)
 #endif
 
+/**
+ * reset_preferred_cpumask - reset preferred CPUs to the active mask.
+ *
+ * Callers must serialize against CPU hotplug and other preferred cpumask
+ * writers.
+ */
+static inline void reset_preferred_cpumask(void)
+{
+	if (IS_ENABLED(CONFIG_PREFERRED_CPU))
+		cpumask_copy(&__cpu_preferred_mask, cpu_active_mask);
+}
+
 void set_cpu_online(unsigned int cpu, bool online);
 void set_cpu_possible(unsigned int cpu, bool possible);
 
-- 
2.53.0

