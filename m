Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.93
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619821;
	b=QK4bJGzcAsIbv3LEwxw72/hqOPmreHOPQOhQeGYC0ezycokbusYYfIWlJDFMfPYultU5
	 c3gv1u1kuIwqkwcCIsydtE+z9GGctyU/Fdcw6ugL9nytUhaXUtD4NZ3ihj57ULt3RY49l
	 nTKrPDQe6etuTzBGNvG1Tu8MS4tz1KFz+Cdn2I15GtAckLXqBcBFpsjmDXbL7TvUmpg/I
	 Q5dQcKWKrOBsy3VEstG9QYASe66DTzuQFDs2kKO6La3c+5FFz+vY1J4wllRzpTWrsY09r
	 /OqVlcKVEE30D0d8ZtzEbv4PdS7wziwk/6L+5GVJtU/dmVTzVtpYWW32QgO5ca40T2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619821;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=uZG1s0368q8UN44TW+17aousOwlOrZDCKGkefaog9iM=;
	b=CHoLtW5cYS690k8MQx2xOZD4S3j3n7bEw+Hw5LOTrcRb/kQjcrUNi/jcqys2LxJBwsRs
	 EQRpcORZh1EtU8l773dmJwRK7nhz8alUYLYVzb2TgZtQuWo7mgVFywuHCV2s+eg0LERaT
	 EcDlbsm5IkrOlcQ2PI9LuYE8mVTfGeNAffnnq7wQlfeplRSlDu5RGfr/PCafHK+kKgAFu
	 USFffpdaH3RVMIdXcFnw9l3uzpzZ5+ImkAbST6tpfIcajSAApIoAdVwxnl7Slpu771rZP
	 dTV7kyDZG/vnow+dsM5a0A6d2kKk5Xrvq/4ml4ZVn4JduwNoeUI/jEP8jtwe/WmqF7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyber.gent;
	spf=pass smtp.mailfrom=cyber.gent;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.93
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022093.outbound.protection.outlook.com [52.101.66.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF18606A31E;
	Wed, 25 Nov 2026 15:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF18606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyber.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyber.gent
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7T7baHI+CfvwzDhNmaPhAuChpLAW+QQgqELJFWrIqXZobIBoNo4Cx2Zkg1AuHqv50hJ9h4t+FBwktMa7dstCVHdhJBF52SLsdryV3LyxRfQlPA/t5ZPyNSk3gZrytAbYFp/mtZk60PvQUO3mvthc9YDRNfMB/qm/x3ACQQkJQ1LXRj1DYwKkGYogwsQOURqCO1y0kx8Ih1ojK5fiVAR5QjYwu0pUdmlBdhdSPCKrk8PJcsppHXQEDqaE7uZaPtIJ61TQd54o/wOLBeFTu9PGeKFeTQGHDiUrvuFXw4fxcDcRb3fxyrCNpPqxm/BtgMDyRldXIWcOGEhHP5Ph8QveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZG1s0368q8UN44TW+17aousOwlOrZDCKGkefaog9iM=;
 b=u9JlHMRfCMk7ndCnSHsERDxGHNMkIVt4UsR3ThZIOwpEqNko+w0dLUTWowfMPW7Pp3YGWv1z1fZ8QqOtzzpbbJAuCqyrlQSt+p2MBLeXMwWPLO6NWGhRz2eCTSbSBHBZ6wc3RJOWlgGBCNI+cSSCET8YoNQwuaqg/cxc01zQ2RSFgOGJMoKU4ic8tXf3X7CgQlHztd/TMv22uc5pz/jUSzM7gZx+Ag3rFNCxrlRxQoBtCB2WL0cTQxmcSuaEvkaBcIfiujs9c5eGCm2zVerTX6Q0S8EhpbHDthesdYFjsXZMu4MmPJ9dy4D5HlCaAnmhDsT81b0WstNIxoaQxNfI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyber.gent; dmarc=pass action=none header.from=cyber.gent;
 dkim=pass header.d=cyber.gent; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyber.gent;
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fd::8)
 by AS8P193MB2127.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 15:16:57 +0000
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452]) by AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452%2]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 15:16:57 +0000
From: Yvan Janssens <yvanj@cyber.gent>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>,
	Eric Farman <farman@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: s390: vsie: fix instruction retry for nested guests in ESA mode
Date: Wed, 25 Nov 2026 16:16:05 +0100
Message-ID: <20261125151607.3039477-1-yvanj@cyber.gent>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR05CA0029.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::30) To AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:2fd::8)
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
X-MS-TrafficTypeDiagnostic: AM9P193MB1508:EE_|AS8P193MB2127:EE_
X-MS-Office365-Filtering-Correlation-Id: 1416fc51-93a3-4c9e-2850-08df4b072527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|10070799003|1800799024|18002099003|6133799003|261009223027099003|3023799007|10067099003|56012099006|5023799004|261102123227099003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	EnMM4g3fAzxdSH3h1T9+qW8M4suOc6WPmeD1oP3Y+LB64bVpGjsNkRhzCPBh7Apnvmk3YDhn372/TTW30MPqPfgqPft14CCFG0YLNRhkbNM7uqcVP8i8bv5a/MCwfxj11LAMGh4ZBJwcmIsmn+/36mKtUyr+yoip7My7flTGM+/ir4AJu8ZziFgExi8N2ohwtqt8H/yAjiofstuR3KKnxeCNgSTC5fBrHLPBzU+HhJ0O+84qr90x054wR1y8yiVyhmOj4FNSZgS2i3npZVqpLwBnBvnrp8q2KNqA2+MninmlDUqBtMQtWxr2lN5rEJfoXhBT8LZ+oMs+FuGRvJg8dm+VPImq4xFv2LUbZVuM2kTlgM/055o4orRIgQBr1mhH+63CdzzPqnTArByJAt6LPTSApwPGFrpOrWVrxCTTJecctlF1D+t1FhEjF1SimK0UKGFtLE2CBQsXuvY+f1q6qdjUSrDRPspbnRsOUj4cGROOkQ1xe4BhDjYgsYY5zA2KVJVNLaFGQCCMxBZWNp/3HCK733JnGcQo8gX4qDOO0vno1rwdu4SPz5RwJnEXkpQ9DIftPG763EXMeIQb/TPakLPvYrPDy+UZrY1kdwHuCsJtp4kueyIkdwcqwGOuWQIL1TAiujnucr7o9NFPhhYX5FaKLnAaT36Kfc1nfFdNzac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1508.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(10070799003)(1800799024)(18002099003)(6133799003)(261009223027099003)(3023799007)(10067099003)(56012099006)(5023799004)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLwtNCoce7fA1K7CVBMUgRXJUEhBGRHV9d/AXTyWdH7TRY/rUZfHlSM/J/VQ?=
 =?us-ascii?Q?qeqD46xsQDDccGsHkNZ+5m3AcyXIl0zAUCD9ijfWT4yl9ep55C2jnLLzKPZx?=
 =?us-ascii?Q?TO0PvrJif1IVrSNNE3Tgl3BiMDsSIYuMKzxIZfFG5zgYWSRfZ4EJPROf1DWO?=
 =?us-ascii?Q?EIm3x0YaKw8LWD/2kdjyCIb0HIemSHyxr3UNVJ//Ymlbk/7IRL+RaZOZOLyN?=
 =?us-ascii?Q?dKTV07HVILXz5SuEy86Iv4It1Hq8/MaJz2dGVjX63xlHK4Yj/TalYfl9bWfP?=
 =?us-ascii?Q?KpEW1gIM/edhyJVoVxgPyEaU1xbhlBdD3QXpbBhxYV83lksLrZC3Bi6/zwdZ?=
 =?us-ascii?Q?SOf0xp1er354fCYXKgKBlDFEBuaQavHoReB7pxgLmPQBT8s0E8+xFSbkUOvw?=
 =?us-ascii?Q?Ga2dhiDihQlwSyqZP55iULvO4Leu8iSr3ByT33ceEN0t6EicgnS5TXeKJjdj?=
 =?us-ascii?Q?xXH6ro2RfZWAZPzM2ekMoa9rsCGemRZwqrPxI0KLI8PbDecyufmkzg1F6dXm?=
 =?us-ascii?Q?BoP1ou/xV5XQDPIOTDqc9GToa1jGCnYKypuy/hoi0ELmmsuIQfPcgvojyRj3?=
 =?us-ascii?Q?aYH4fcSHxPfoA0jJkA3DyF58Fb9nPcXw0BzLqZf3qbeKXl/Nt8XefLWfr4p/?=
 =?us-ascii?Q?KEgWbuv9lH+z7MpPvU3c9RfwOFPPIoYXPOe3k5um4hcbuy5dO8moL79Ps/x1?=
 =?us-ascii?Q?bWzlsqIi4hjT2zhw+W+ZFZpZEz74yT/hN6XDNRtsVI/G0NEDA9X4AL4pigOD?=
 =?us-ascii?Q?4kuUfv8kklsHPD2eQkzOm9G92ns/66inp/oLvCQLbwcAjpiEfRn/bO7SrVG/?=
 =?us-ascii?Q?WpoilGzTlIJkmZvpWNdbhk/MpphHvbC+e0pFzTbGby7YgdyyU8Vpo6joIY9E?=
 =?us-ascii?Q?+vQoGSWWZ/QDh/HB5AzBZPTZys1sX+QTY64RD4lSaPlyg45uV0yrhNYNGqcO?=
 =?us-ascii?Q?VZgqHhccucsC4ssQDwiGfbJwNTuvNBCrQo5UjjUz6m8v65If2FIlkqlVPzKU?=
 =?us-ascii?Q?CBmw0S1fqUiMfLFaGxEALcPhPKbrBAusrcABJUZq2NiKLzbHB6zhUsCZdC9w?=
 =?us-ascii?Q?OsGnkNXDuZqFJ73XYPWV8ZB/pPzR/1McLvzaAEPumj4XjEXyo7o3FuWleuug?=
 =?us-ascii?Q?2eCAYMH9WTeWDByB4DXeu4vzIvfCGPjMMTc5AhKEZvKs56bL+KeVwwUB3nPF?=
 =?us-ascii?Q?77PCmNFv3J/CYX+RcMCRiFhJw/KG3rIEK7hcc//9nWrYOxDv5lKwGSSWXiwh?=
 =?us-ascii?Q?vmjobQu9LCmA8ltKXnwjovDByMY/tetaU1xJwwZvJ1a+mi6QJ2ZPqeqODRkA?=
 =?us-ascii?Q?ASoRFJhO7Lrb7WGBt1HCTmyyPbwaqyqNgRrmRcOu2MSxdSZh+2+AdM7SHJdV?=
 =?us-ascii?Q?u0hZe+Ml9qF8yDBuDd6c1p8pgdzPyj/Des4Xeo9ordrITj7PIm9Z/1B0C38A?=
 =?us-ascii?Q?eCMrKZ5nllQ53GLUZi3KnFhc9z9B9SnvAK48rAtYcilPDKrSFIn3YK26/xZ4?=
 =?us-ascii?Q?NqgZdBgRgr0WUqcKv6Z+fBUCT4Pcrg55OCoHbKHKmBTNic4X9FFzAhQfCUKf?=
 =?us-ascii?Q?GIgHXRaHecaHLJ9zQ/XcvEV63v7XiDQOQu6wZ9vMf57QTt+hvWK9xj2HNm1t?=
 =?us-ascii?Q?NjpToi5Kkk4yR7vf4w82iLEXe2USzPfhm2FN2ML1EIny8kozRqGmkKyOT8wv?=
 =?us-ascii?Q?Hy7Ccq3/id0ihcVsIFcZlgyTTSJNxbJT626dNMu5LtGlzm9ooHuaNU5bAT4H?=
 =?us-ascii?Q?a7cU35yL/wp9VGnGSGfK5bz1WzE3RaBwzhxKhGU7CexLUdzzD7M4?=
X-OriginatorOrg: cyber.gent
X-MS-Exchange-CrossTenant-Network-Message-Id: 1416fc51-93a3-4c9e-2850-08df4b072527
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 15:16:57.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5a0a0d6-18b4-44e3-8e5e-e5dbe37f9ee2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4uSkv3egf+tkH8QZIjMPE0NDpwqhtHukGGoH3WMjSSpu5xSZryrBP6l2QwxjVDq+1dplbvsLz26ELvIJBdAHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2127

Since v7.1 a nested hypervisor can run its guests in ESA mode (the
ESA/390-compatibility mode of the machine) when user space enables
KVM_CAP_S390_VSIE_ESAMODE. One piece of vsie still treats the PSW of such a
guest as a z/Architecture PSW: the rewind that vsie uses to have an
instruction repeated. For a state description in ESA/390 format the
instruction is skipped instead, and a stray value is left in the half of
the PSW field that such a state description does not use.

What a nested guest sees: the first STORE FACILITY LIST EXTENDED after
every entry into SIE does nothing (operand and condition code untouched),
because vsie intercepts it to shadow the facility list. A program that
tests facility bits gets zeros.

Patch 1 is the fix, patch 2 a selftest that reproduces the problem with a
small guest 2 that issues SIE itself (modelled on the vsie selftest that is
queued in kvm-s390 next). The series is based on v7.4-rc4-260-g4dce97c6c265.

Why it matters beyond one instruction: backward compatibility is a
defining property of this platform, and the ESA/390-compatibility mode is
the architecture's mechanism for running older programs on machines that
only start in z/Architecture mode. Any hypervisor that runs as a KVM guest
and gives its own guests that mode depends on vsie handling such state
descriptions exactly like the machine.

Testing (z14)
- On an LPAR running v7.3.6 with patch 1 (the host owns SIE) the selftest
  of patch 2 passes all three checks: the unused doubleword stays 0, the
  PSW ends behind the last instruction, and the first STFLE stores the
  designated list.
- Without patch 1 (v7.3.6, test kernel running as a KVM guest above a level
  that passed ESA mode state descriptions on): the unused PSW doubleword
  comes back as 0x7ffffff8 and neither STFLE stores anything. In such a
  nested setup above a host without the fix, checks 1 and 3 still fail
  with patch 1 in the test kernel, because the defect acts once per level.
- On a host whose lower level refuses ESA mode state descriptions the test
  skips (validity 0x0001 seen by guest 2).
- KVM selftests (12 s390 tests and 5 generic ones) and the s390x
  kvm-unit-tests (37 pass, 4 fail, 21 skip) give the same result for every
  test with and without the series (v7.3.6, nested setup); the 4 failures
  (sclp-1g, sclp-3g, css, edat) are the same with the unmodified module.
- Built with W=1 and sparse without warnings; checkpatch --strict is clean
  apart from the MAINTAINERS note for the new file.
- Not tested: MOVE PAGE partial execution and the addressing-exception
  path for a guest in ESA mode. MOVE PAGE is not available in the mode
  without the ESA/XC facilities, so the first should not occur.

Assistance: the series was prepared with an AI coding assistant (see the
Assisted-by tags); the defect was found while tracing why a facility test
failed in a nested guest, the analysis, fix and test were written with the
assistant and reviewed by the submitter.

Yvan Janssens (2):
  KVM: s390: vsie: Rewind the PSW of ESA mode guests in the right format
  KVM: s390: selftests: Add a test for nested guests in ESA mode

 arch/s390/kvm/s390/vsie.c                     |  23 ++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/s390/vsie_esa_test.c        | 180 ++++++++++++++++++
 3 files changed, 202 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390/vsie_esa_test.c


base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.47.3


