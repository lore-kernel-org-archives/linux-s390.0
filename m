Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625773;
	b=3fCVEgoSvVvV9Vsn7MUvcBUUsUTbRN/O92W6fhE1mI+RA1A0dN0LSHM4Hia8R8kUfiA1
	 Vsgn4LPRxP+JIxCXl/Yco3owFGv2Fr7XEOKjQDoDJzbLoc9OMGtXeBVcq61Nr/nzjPiBH
	 K+gXuzCRR6HmMEY/uF40W9LyGsVH2k0KLxh5hpBvvKfsDkgdrq3qsOyTJAt058aMVwDW0
	 Zw2PH1ZdQEHOiHoC3RTkLk94u8NVHF1lIjMKADyX7SL4CTb84dKmltSb7Kx29DMjVFgQ6
	 WrNz/z71SBHu5pzsHJhGFf8+vpVcKy4f2UE5WiT8+pZHgweVV0+TEY/uZpUfdifoaxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625773;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=9qnDj8DaI1Yo0p+ji4UdkToB1fFXe6j6QWe7EtnOB1E=;
	b=tnHtr0QVTlH7LqstrvxxVUiZzpI877wrejtddied3TEbuLkl8H8nMuwlcxNKE2rIpYkn
	 xtMdWkE7p8cwbNj14RVqPfgkcBUEqnDrK7dzzUzEI34i8tgUNaVeaEGbZnh+A+SqSy3YG
	 RoLbc26gAca3P0B9ih1r8Omm+bWnPmOoaqNlCOfTmTI++q3BVVL3rEP/YrgDvQzUMGpn9
	 6kaCegPeOUPoEN9vvJlYKFUeug2UKVKe/E7180UwH+AvhwCIFI/dU+Yy067lizaY9wpM4
	 Mwb+xiw7eeAi2SIRIDOTO1shoNWBHEGMFLcqZ4vTAUO9RE7AvxC8TJcebgnZXjT0aQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyber.gent;
	spf=pass smtp.mailfrom=cyber.gent;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.79
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021079.outbound.protection.outlook.com [40.107.130.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F1606A689;
	Wed, 25 Nov 2026 16:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C0F1606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyber.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyber.gent
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQrtFILdOuElGW43Lc+u/BkLMfHxE7VyUi0xQO4qDwF4Z3ILxsKnASMEVlP/stfst8i1SAEEbLRK3GDqzojI1Y+YKi3ofMeKEoOaPRjurvRkkvKZ7FPgrmdRen5EdD/MymvmZtZ2ZEYidWO+3aNS8QgFDs1+U3Mv4nn193aG0H7eRSoOuyTFib7esa8eTcRNn+aMPfwWbfuL0iHSYWiEm4rGfUmhQcLeRh8cg/So+IObglISv6VIsBStvsptN2D5gG5n6vd3PhgGIieTa1syPVDAQlGy1HP2LE4ezkPdPEkQygJj10w+Cu1whcwZHwqT8ZMfduJ2M/EhsxjYT8Wqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qnDj8DaI1Yo0p+ji4UdkToB1fFXe6j6QWe7EtnOB1E=;
 b=NCMR9mIZN1XH32ZWRzj1PLIOgM3NYhGxmu+w9pq5KS3RdP6xBmjMwi8F0yXGBx4RH+E0EhpmlEFCXrPDctqQE9tdOZZmCcJ2S6Gz3rFPMZ4uugv7QU3fRgyYY1nLkKM+8e5bXZqqfmSoy5vdPW3gE5WZFhfEYWsoJUJFS18MXDDsgfnPn0Dn+IKhEZ7JchOJbTBEbp4pD4q+WnHK6zOmYOScLr/klTJAx5MJC2ga64R+CkxptH/z6ScAn5e/0oEo1uV4WXBmr42rWaoh6SBvgRymgxkQv8NeJfbU5cp0uKgl/W2tNaCEjAPOl3MYT5z/4yrZsJj3Go6n5ixCl897bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyber.gent; dmarc=pass action=none header.from=cyber.gent;
 dkim=pass header.d=cyber.gent; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyber.gent;
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fd::8)
 by AM0P193MB0516.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:56:12 +0000
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452]) by AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452%2]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:56:12 +0000
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
Subject: [PATCH v2 2/2] KVM: s390: selftests: Add a test for nested guests in ESA mode
Date: Wed, 25 Nov 2026 17:56:03 +0100
Message-ID: <20261125165604.3074595-3-yvanj@cyber.gent>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165604.3074595-1-yvanj@cyber.gent>
References: <20261125165604.3074595-1-yvanj@cyber.gent>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P189CA0058.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:458::20) To AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9P193MB1508:EE_|AM0P193MB0516:EE_
X-MS-Office365-Filtering-Correlation-Id: 094ca5c9-5e57-47f1-ec7c-08df4b15028d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|23010399003|366016|6133799003|261009223027099003|18002099003|22082099003|3023799007|261022113327099003|10067099003|56012099006|261028144727099003|261102123227099003|261026135527099003|261026121527099003|261026130827099003|261022075727099003|261022115727099003|261022105027099003|261021130227099003|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261021133027099003;
X-Microsoft-Antispam-Message-Info:
	B/CBlBxbirfmvhrIRqb5BWKwMrK1QNjkADEwF9amMDDeU7SMHB8tJxYoqTmOMyh+DPjl6MKwNz6JIUiYK8QteUC+YHcfcVzyfEjVioX64BZ7hbWunoyyF/Fm8q3HZTANUTuiD8U62Lu4YZt0ls+AWrn696sB+qns1DY9hFc66uR/bFeW/zslaBHevY78e30tfNEsk4MYFwv2Kf6HbFmFMIzW2eAxoL2HVH/unme5L+k5snovpx5ShG03+o0lKXdl1EN6ZbRgRBYxtVs+MA7BN5PGJVKhWNUsGNhXVddmC+kOeOwytbT61zBQYRPONEORT6EvqwQfnQsrgQ/EiZ6f12nYL31R9Xk/GbptV82dg5EqckD8bo7zEGGpNoa2qAthhUPRG9FUN+yiVHpjBP2UcWiY2Sxyc5wvkKiBseRry9Yb9t9aD9QU74oy8Z9FDJOe/HFiqykWIIX5+xbnIXlKZ6iwVgtjObAWiV402HkO3AepTPGZjkLGa+FMpfygMnIvQgpr6rc+TTQTqtw4gcua0/nLPWA3M3jxm2Lid8mydcvH3Y1NWov5pO0B3uf2DN/p8v6ZgwW1cbV9RjnDxcm++UIjmUVLc3RvbK+Qg6ZslKM9VzQv2z9N16+dNj83j/Vy5JTxpNpDUH5e7s9Q9P6LXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1508.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(261022113327099003)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261026135527099003)(261026121527099003)(261026130827099003)(261022075727099003)(261022115727099003)(261022105027099003)(261021130227099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261021133027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wUJ9QBdQCx49ZCJqvNhIbbAIat6+MuYmLCmFOuUNhC3Ut5uYSNHBuCzRxUe7?=
 =?us-ascii?Q?fb51FrYBivZNAglITMn/B1qT4fcMJG1ZcjGPJUOc0eO1sa0HPDHUn0zVPk4a?=
 =?us-ascii?Q?9a9uGWo7mPsHLghhRhFT6EA2o9dbzSp8nUlwRH4mvb3GLKLK0rh1p6DO/Uvl?=
 =?us-ascii?Q?S73c6k+hL3tSODAhT0e1YfrM0jj7l43Q6O2CJ/14xyD3nBn9eJfegdN2ZGzB?=
 =?us-ascii?Q?znXtL1xv4rWa0TvEIvqOdgoyVeo4R52Bk1WuA8fRQop2xYnIRuUgHbs0VQEp?=
 =?us-ascii?Q?SFMZpgF1RK1RVXr3ut08wirovael5o6v/LWpWUXjsZ3blyHsULYecODIfjVt?=
 =?us-ascii?Q?LSYdMKqsmbgkGf9yAroG0YPufiwEMMYlotQRSgQSk9AF8W3DwMY103vKi7Gm?=
 =?us-ascii?Q?lZ+1B1VJX4BDIHmDNG02YctxkVMEq55h2rnYx2Y6fYPoieCEmh25TBUK4XfG?=
 =?us-ascii?Q?qCvd914FQleTeUien7kNVDbRefB6hnokRXr6Ft+tg6/6a+FLMT54jAcszbKh?=
 =?us-ascii?Q?YrgXM3krZ/vepsv0ZR7jedmuuPlTmZs7gopAc6a2oaWHzpBzchWkxRJ6QE/5?=
 =?us-ascii?Q?+swrs1MyETr2qp2zN1BW8te8/KtdK6Odl22dPUXEC3lCiaxaieGpFW6Dsirj?=
 =?us-ascii?Q?eCXFWEOtZStt/lEtSXshmeR6jNTFkOfv8+86C/lh8XJxC3FMvsc2JPN7Mbkc?=
 =?us-ascii?Q?ax2mIOmctC1ywQA3bZDVXxgzCU4d22B9/2yc8cWpVUajNWq2l8iu1TLsQdPM?=
 =?us-ascii?Q?dnAHoIyf73/f8Cizadx0TtW7ZczAEuK5FeoNFUwUE9UIsVbMEuu1BGHOigcq?=
 =?us-ascii?Q?AJjTjCbaPdhJyUh4GAwJXoBseBBfACFXekwEDrDWiznD3xPHCCCPfooISCRW?=
 =?us-ascii?Q?n/cQQrs4y5uk0ZNLPNcOIQRUFuw5eCNMnqvH1GP3MyUHkrwmXBAQ0yITO9wl?=
 =?us-ascii?Q?trNmwGidbNlbO5WdpssyShFHZt6mz6VO4AII2WJ/xu109pFyIlRRowoQlXhl?=
 =?us-ascii?Q?OBhvCFT1S2N6A22Vxb2j87QGK/NELkdPu+XO/PJWMeboF3SzCGL3CX/Rbt2A?=
 =?us-ascii?Q?9T3aSwiWucJ9m+NSj8OF9Pp8CJHcIxfnjnPicpuYTtPp+HaCW2QCF1Labsuc?=
 =?us-ascii?Q?gegzOzqIwMMnSFWtS0yna/WBhMarKCl6mFOEefO1FnL1kaaeb0VmS1bXNqn2?=
 =?us-ascii?Q?luAAMbkoo8SBS4YDa4+h7wY4/mIO6oWLMpbKIJF1DVIURES3xwbBDONyG+WO?=
 =?us-ascii?Q?TXRdAhgodyCiVsMRsHtcXeTHyXnozbiW/xvdLMdYHrGIJkgZaMfAebcSjrO+?=
 =?us-ascii?Q?/ahDJwyeYzuos/MgUj4heY53hipnSkSg2qFWd49QZK87uj5IT+arqjoTTkhW?=
 =?us-ascii?Q?obDSWPhNYSoWNe9hlKdWYbI3OKHb/Ri5/hYS9dc4QmebpRjMv/KdjHO/3fgZ?=
 =?us-ascii?Q?XVpOvLEI7SkJbYzQEP47IdBmwTE3//tmCP7/aTDNJ+1MgmJoqdBH8rNg4Ep2?=
 =?us-ascii?Q?FwWJNPtPl3pa6ELzftFfT5Uo1U/xmhgDp5w8SE4nb5IcUF7++a1En4Q4sOl2?=
 =?us-ascii?Q?WuHj0aIxzk7JSrYLO9KK17pvGvFrebEsu1ASt4LNsCl1zfo1M2RjlL//X6Vp?=
 =?us-ascii?Q?KREfuTi6NE40FFWx/KHv0x5KtmFHBr1KPWc6oldyt3mf5709JuzA+m90Bo9U?=
 =?us-ascii?Q?xG0NJvdqbTCBjkAMMLxIgwMjMbLkFsKv3aU98MC36wUxu256AJdg8hF+/np5?=
 =?us-ascii?Q?LdmepUw4CYPbX+6qAqo9rgJPpqrEzV01Qco2aVpjl7HgIVwYQezn?=
X-OriginatorOrg: cyber.gent
X-MS-Exchange-CrossTenant-Network-Message-Id: 094ca5c9-5e57-47f1-ec7c-08df4b15028d
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:56:11.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5a0a0d6-18b4-44e3-8e5e-e5dbe37f9ee2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Kg8/M1LIE4FT19vGlyMVOCPzfR3NpH5Zh0LmcnTJ1N9R/dNmO8n/xpjsZDbZNgjvYDhQJO5QFkQ8FEQf3R02g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0516

Run a nested guest from a state description without the z/Architecture
flag, with KVM_CAP_S390_VSIE_ESAMODE enabled, and let it execute STORE
FACILITY LIST EXTENDED twice. vsie intercepts the first one of every SIE
entry to shadow the facility list guest 2 designates and then has the
instruction repeated.

The test checks that the second doubleword of the PSW field, which is not
part of an ESA/390 PSW, comes back unchanged, that the PSW points behind
the last instruction, and that the first instruction stored the
designated list. What the second instruction stored is printed for
diagnosis.

The test is skipped without the capability, without interpretive
execution for the guest (SIEF2) and without facility 7 in the guest's
model.

Signed-off-by: Yvan Janssens <yvanj@cyber.gent>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/s390/vsie_esa_test.c        | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390/vsie_esa_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 283c59d7649c..aef64ec2719c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -227,6 +227,7 @@ TEST_GEN_PROGS_s390 += s390/shared_zeropage_test
 TEST_GEN_PROGS_s390 += s390/ucontrol_test
 TEST_GEN_PROGS_s390 += s390/user_operexec
 TEST_GEN_PROGS_s390 += s390/keyop
+TEST_GEN_PROGS_s390 += s390/vsie_esa_test
 TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
diff --git a/tools/testing/selftests/kvm/s390/vsie_esa_test.c b/tools/testing/selftests/kvm/s390/vsie_esa_test.c
new file mode 100644
index 000000000000..a52603e30f63
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390/vsie_esa_test.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test nested guests that run in ESA mode (KVM_CAP_S390_VSIE_ESAMODE).
+ *
+ * Guest 2 runs a guest 3 from a state description without the
+ * z/Architecture flag. Such a state description has the eight-byte ESA/390
+ * PSW in the first doubleword of the PSW field. vsie rewinds the PSW of
+ * guest 3 when it has to repeat an instruction; the test uses STORE FACILITY
+ * LIST EXTENDED, which vsie repeats after it has shadowed the facility list
+ * guest 2 designates.
+ */
+#include <stdio.h>
+#include <string.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "kselftest.h"
+#include "sie.h"
+#include "facility.h"
+#include "ucall_common.h"
+
+#define G3_MEM_LEN	0x100000UL
+/* mso/msl have 1MB granularity */
+#define G3_MSO		0x10000000UL
+#define G3_START	(2 * 0x1000UL)
+/* where guest 3 stores its facility lists, in its first page */
+#define G3_STFLE_1	0xf00
+#define G3_STFLE_2	0xf80
+
+#define FAC_STFLE	7
+
+/* bit 12 of an ESA/390 PSW is one, bit 32 selects 31-bit addressing */
+#define ESA_PSW_MASK	0x0008000080000000ULL
+#define ESA_PSW_ADDR	0x000000007fffffffULL
+
+/* facility list for guest 3: only the first doubleword is looked at */
+#define G3_FAC_0	0x4000100000000001ULL
+
+static const u8 g3_code[] = {
+	0xa7, 0x08, 0x00, 0x00,			/* lhi   %r0,0 */
+	0xb2, 0xb0, 0x0f, 0x00,			/* stfle G3_STFLE_1 */
+	0xa7, 0x08, 0x00, 0x00,			/* lhi   %r0,0 */
+	0xb2, 0xb0, 0x0f, 0x80,			/* stfle G3_STFLE_2 */
+	0x83, 0x00, 0x00, 0x44,			/* diag  %r0,%r0,0x44 */
+};
+
+static u64 scb_real;
+
+static void guest_code(void)
+{
+	while (1) {
+		asm volatile("	sie	0(%[scb])\n"
+			     :
+			     : [scb] "a" (scb_real)
+			     : "memory", "cc");
+		GUEST_SYNC(0);
+	}
+}
+
+static void get_machine_feat(struct kvm_s390_vm_cpu_feat *feat)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+
+	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_MACHINE_FEAT, feat);
+	kvm_vm_free(vm);
+}
+
+static bool machine_has_sief2(void)
+{
+	struct kvm_s390_vm_cpu_feat feat = {};
+
+	get_machine_feat(&feat);
+	return feat.feat[0] & (1ULL << (63 - KVM_S390_VM_CPU_FEAT_SIEF2));
+}
+
+static bool machine_has_facility(int nr)
+{
+	struct kvm_s390_vm_cpu_processor proc = {};
+	struct kvm_vm *vm = vm_create_barebones();
+	bool ret;
+
+	kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR, &proc);
+	ret = test_bit_inv(nr, (unsigned long *)proc.fac_list);
+	kvm_vm_free(vm);
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_s390_vm_cpu_feat feat = {};
+	struct kvm_s390_sie_block *scb;
+	u64 *g3_page0, *fac_list;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gva_t gva, fac_gva;
+	u64 psw_end;
+	struct ucall uc;
+	void *code;
+	int i;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_VSIE_ESAMODE));
+	TEST_REQUIRE(machine_has_sief2());
+	TEST_REQUIRE(machine_has_facility(FAC_STFLE));
+
+	ksft_print_header();
+	ksft_set_plan(3);
+
+	/* SIEF2 must be enabled before the first vcpu is created */
+	get_machine_feat(&feat);
+	vm = vm_create(1);
+	kvm_device_attr_set(vm->fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR_FEAT, &feat);
+	vm_enable_cap(vm, KVM_CAP_S390_VSIE_ESAMODE, 0);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	gva = vm_alloc_page(vm);
+	scb = addr_gva2hva(vm, gva);
+	memset(scb, 0, getpagesize());
+	scb_real = addr_gva2gpa(vm, gva);
+	sync_global_to_guest(vm, scb_real);
+
+	fac_gva = vm_alloc_page(vm);
+	fac_list = addr_gva2hva(vm, fac_gva);
+	memset(fac_list, 0, getpagesize());
+	fac_list[0] = G3_FAC_0;
+
+	/* guest 3: two prefix pages and one page of code */
+	for (i = 0; i < 3; i++) {
+		gpa_t gpa = vm_phy_page_alloc(vm, MEM_REGION_TEST_DATA);
+
+		virt_pg_map(vm, G3_MSO + i * getpagesize(), gpa);
+		memset(addr_gpa2hva(vm, gpa), 0, getpagesize());
+		if (i == 0)
+			g3_page0 = addr_gpa2hva(vm, gpa);
+		if (i == 2)
+			code = addr_gpa2hva(vm, gpa);
+	}
+	memcpy(code, g3_code, sizeof(g3_code));
+
+	scb->cpuflags = CPUSTAT_RUNNING;
+	scb->ihcpu = 0xffff;
+	scb->mso = G3_MSO;
+	scb->msl = G3_MSO + ((G3_MEM_LEN - 1) & ~0xfffffUL);
+	scb->psw_mask = ESA_PSW_MASK | G3_START;
+	scb->psw_addr = 0;
+	scb->fac = addr_gva2gpa(vm, fac_gva);
+	TEST_ASSERT(!(scb->fac & 7) && addr_gva2gpa(vm, fac_gva) < (1UL << 31),
+		    "facility list not usable for a designation");
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+	/*
+	 * The capability does not tell whether the machine (or the hypervisor
+	 * this host is a guest of) runs a state description without the
+	 * z/Architecture flag. If not, it answers with validity 0x0001.
+	 */
+	if (scb->icptcode == ICPT_VALIDITY && (scb->ipb >> 16) == 0x0001)
+		ksft_exit_skip("the host cannot run nested guests in ESA mode (validity 0x0001)\n");
+	TEST_ASSERT(scb->icptcode == ICPT_INST && scb->ipa == 0x8300,
+		    "guest 3: icptcode 0x%02x ipa 0x%04x ipb 0x%08x psw 0x%016llx 0x%016llx",
+		    scb->icptcode, scb->ipa, scb->ipb, scb->psw_mask, scb->psw_addr);
+
+	psw_end = ESA_PSW_MASK | (G3_START + sizeof(g3_code));
+	ksft_test_result(scb->psw_addr == 0,
+			 "second PSW doubleword of the ESA mode guest untouched (0x%llx)\n",
+			 scb->psw_addr);
+	ksft_test_result((scb->psw_mask & ~0x0000300000000000ULL) == psw_end,
+			 "ESA/390 PSW after the last instruction (0x%llx)\n",
+			 scb->psw_mask);
+	ksft_print_msg("second STFLE stored 0x%lx\n",
+		       g3_page0[G3_STFLE_2 / sizeof(u64)]);
+	ksft_test_result(g3_page0[G3_STFLE_1 / sizeof(u64)] == G3_FAC_0,
+			 "first STFLE of the ESA mode guest executed (0x%lx)\n",
+			 g3_page0[G3_STFLE_1 / sizeof(u64)]);
+
+	kvm_vm_free(vm);
+	ksft_finished();
+}
-- 
2.47.3

