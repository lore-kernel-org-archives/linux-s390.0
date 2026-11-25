Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619830;
	b=WavBxm8/sFotl6zYlono7poAlq1LuyGCe5B1ebcSLRY36TMaoytp2ztILvpx4AKEdIjN
	 ODfbkbwd92rFgDks78nFU13ZXGAJuuEzOsSmn0O1OH6/n9gbuWKwbn/k0LxL/guemhQRj
	 OjES0zFpuQYFEfgFvMN7QkyMYCaVNmdvK9wH+LhhzB/1EWp9OugmqyqhVPlg7wm4dXQaq
	 yLbI5RSVIzEmmZ95z74b3C4Ep3J4ffYxBy6mFGLWDH2f7zoRvpH0osyPf362PW1rlJYWj
	 QB2SNdihu7+7hB5xCSATMN+m3a8NN5KWwPEIsWHUiHQIlkdjaN17XNynaNd3OsODxGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619830;
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
	bh=eY6uxwlzEeigUe4vHDYqs+o21vIW1wlsbR6RjuZ0I38=;
	b=Pxcq1mK6My2Yc6dVic3V2JtpW4PYLcrkZ0hp5TY85YyDlsriNPptnjSxQLQbKFrELlRh
	 5EpjlkeDiXXPcDqEvxkT3fQiZSBEv8ix7wizHBcO4CNt9ys6W3EJuuWqIeHWO616BjLFW
	 sdb18sti9enX52xpClv5Dod8UpsCVZ5sd788tIf0e9Z7F7CLyq+KUTKX8/tzICxCHolA6
	 2RM0g1l7lFscgEXqvXGkZjLjgU+vE4++LBuG+lkWJAtIoRtBmwe8qPStysq4KVsdsuC4M
	 goVRlYq0blH62RCLEo2/nXd+0PQ2bWv0TrOYy50y4uunu02FpgjWof4Wqbse0wBUUsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyber.gent;
	spf=pass smtp.mailfrom=cyber.gent;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.113
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021113.outbound.protection.outlook.com [52.101.70.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB95606A31E;
	Wed, 25 Nov 2026 15:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB95606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyber.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyber.gent
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OID86y/LgfRQPumPvWYUOorvMRzMi3cSbTFj+r+QgoHEPrdZY4sGJkWj3db13uIupSSVSHY8w7U6FbLzBlpeGKfd3N/ydSD63jI9ICiJtz/qxqIddOYYfxse8bGXCohm7PyqCjlg9s05jKsRVTPfHr/VhuKgjgZNuE2CU9Wy5mPC3VHUWDm6YbA54IBoQWr/jWr+nItsOCDlY0oJTwGGB9Wc1k1tAMFCTnTXHpkyYZ4fwPd1zy8I406gkRnzexIHIKIyWE6MKrhdX68NzJ+0WUAAYifDRvSwOdwzHQl9+m09r+IOkWnS2NcbHBjjyHncWG5BREUCqo7rPsHBjvRCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY6uxwlzEeigUe4vHDYqs+o21vIW1wlsbR6RjuZ0I38=;
 b=wpkzBD1c5jxARp0iI7vzcr54cfOOIjIj7YPTCneBJ0txteCEVWGBt9enwBBI9TQT/18mPKZPeVbD93NyD3QHdZPvl+kj83kU9al3Zd1A8n7XexyMxS6vIOYvOea1sQj3V8xw+2sHyLtgXAi+yrPU+DdjNgHq+2rxO2tDW4LNZ0MC9eZTX1nFyuT5rSlbp1SGtwsiMulq5VHCMowKCDOawVFycgHZwX2Joz34A46EDAE9tSTD873UApX94mYBtP6ea36IpK4SCIgvbTW9yNrktnRWvAq9xwzbvS6NPjH9co9bb3LxwOlZXow6GEocbzkrh2bCoHIfBuZ++rOTUYjFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyber.gent; dmarc=pass action=none header.from=cyber.gent;
 dkim=pass header.d=cyber.gent; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyber.gent;
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fd::8)
 by AS8P193MB2127.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 15:17:05 +0000
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452]) by AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452%2]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 15:17:05 +0000
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
Subject: [PATCH 2/2] KVM: s390: selftests: Add a test for nested guests in ESA mode
Date: Wed, 25 Nov 2026 16:16:07 +0100
Message-ID: <20261125151607.3039477-3-yvanj@cyber.gent>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125151607.3039477-1-yvanj@cyber.gent>
References: <20261125151607.3039477-1-yvanj@cyber.gent>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::11) To AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 76f7865a-00fb-484b-036e-08df4b072a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|10070799003|1800799024|18002099003|6133799003|261009223027099003|22082099003|3023799007|10067099003|56012099006|261102123227099003|261022075727099003|261022105027099003|261028144727099003|261026130827099003|261022115727099003|261026140227099003|261022113327099003|261026121527099003|261026135527099003|261021135927099003|261021133027099003|261021123027099003|261021130227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	Zh3bbKGNJyX258ZDcNuc/H5t2Tt/NiESXnYfVQzYqwg8eNtcNGMYuAUAYcRx919DjOG+QV6zblS/1dG39RfTxtny4iJCQQmU3NmaeFm3PW6rhT4KkMuIqdwWNY6AInFH7YikrQ/b2CfLpcaEnDgtilAWDvExpaw9IG9nGHqZpuMCT3yacy8jXkpVu4KnvyDEe3uslY3zi1Zjyqx6U7KcQDnjkciCjJlYwOcWPFt9bFXZdVPYzy8l45kdDGHy1tS8oKg72dmhjKLsLg2svlnUaVj8IAXZd4a0Je3fiSOZxT2PoMbDWqQPdQIamjT6xXhO4JzSESIriEzQNKvV96rj+7yU7SsoUqOs4AA5lvRs9zR2ysMFs5TEtViupkJyomkA3gh5b9jqKzZcY/segylDMCJf9gtI1DgHmyxpL90G1lm6VyEmyntK3Jpi2JTFqFtFqntxE6HQKkCh8BzhgbhhGKZCsLGGKxuNfSFEYPPr9sAGHAR76+0KVc0BuT6GkQroLachmeGSKX2l/cfLiYTv4dar/k5w6lWNsfQ8Q9dopTrWqu0/pryXfnkuTipdvErn/mFHSnFRN5KydvT0101ahwfVpx5Gi72A+4OHdEI4DThATQzEaWmR651Ioz1NkssN3I6F3QvsFFXr/w5Oz2Tv7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1508.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(10070799003)(1800799024)(18002099003)(6133799003)(261009223027099003)(22082099003)(3023799007)(10067099003)(56012099006)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026130827099003)(261022115727099003)(261026140227099003)(261022113327099003)(261026121527099003)(261026135527099003)(261021135927099003)(261021133027099003)(261021123027099003)(261021130227099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ocTf80X6jWpv4eUHCZNdj3ZPch1dLmZbxW1h1Nvn5XcIhM+I+YtI8DUG3sjY?=
 =?us-ascii?Q?DjbjELSpPz9GRvYwA1uQt9AR5tnl91xUab514RivF9VoY4xZWDqXrqn0PWGt?=
 =?us-ascii?Q?QNYokvrBCIQh/lVEQUw9ctfmzDTlfiAZfMSSYYt9+ElHMNkOk/0IJ+uq00o6?=
 =?us-ascii?Q?suY+E9dCTGhLEJqwycLl443A0lWRZWA26ZLDjnUUQa9drX6OjdjhaD29JVl9?=
 =?us-ascii?Q?emQbxC4xvqUnywvxk1eqgRmeorVyJdVMOBOiZyNjbw8sLBjSaFuFZN94SpzB?=
 =?us-ascii?Q?uA6T0wbY4CAst3/C6a/AQQ8MhwuPWtFDrgZLBBatuty9xkZBikU5Ju+OayMK?=
 =?us-ascii?Q?wTt2bf79WkFkmswKXvAFHgy+Mfaa8E+RjF3m2ZdaaOIuwP4Ncc+CFgD0KxET?=
 =?us-ascii?Q?omScYkP75maEBDPa5nY8BVPXwxx6cmrWzStBqVZJfAMNZHPVTktzVxGhb55x?=
 =?us-ascii?Q?5ZYK505JtTq80seLyFcPlfQzy71qQWqsDoZ6ajOodi88/dCtzuEajGvBXk1o?=
 =?us-ascii?Q?eZsceVXR2d2h1AxQtk7HbM/vpD/r5lfzaKvkCbKqy7U9+WRBXS4MKApKJSaB?=
 =?us-ascii?Q?RSu+pncNMs2iB/F7SC/N+h4kvjl9IPTlH9Ay8fOyAkixbslqYGRidqQuw3Lz?=
 =?us-ascii?Q?i6pwiAJ3+8q39en3MV54He+1uqa88N/gL5ChmeAZKtxb0839eEfIUKBSmSXr?=
 =?us-ascii?Q?hm1hp/CJ0A4Wf7AH/xjuMBcllCY/roGRnZ0w1q/IejcULlSDTJjirJyuTJru?=
 =?us-ascii?Q?R7SNKEO7pm4TFlG8rXGQ74fEPRm7GCC03+wfy/dXBtLlGpYSOXYWwFAA5mCy?=
 =?us-ascii?Q?ZLQLt73Jh5XO8Zi/lw+bB4mRS+8AEet+SzjcD3tpD1NQIo0v1p+6Qwh6GKt5?=
 =?us-ascii?Q?c/FUIQh0UHxDSDkWVeOvbs8VBXaoIqVWah28neTB47SDY10lB4bE1A4ib8SS?=
 =?us-ascii?Q?pnyZBLnGeeqNDMi0ucd43tQ2enjftHc7yi2jKRcQaA5jbb4bfUDi16JRYCVU?=
 =?us-ascii?Q?nzpAt/ymap7PLsmzA7boSCuOBY4dO+RhnxoVrPiraKpRbtvETZSTdFfGAXoW?=
 =?us-ascii?Q?zK91v3TFoga4UnZxja4EHSg++0D8DXix4gXCRHd8yRfFwhJUNoxCR7yhhO0r?=
 =?us-ascii?Q?1f0EahS6dP576FCaSxSRSHR5b5gS8ZrGIiyE44FgmejM9fy3ACxhwjUAt7nS?=
 =?us-ascii?Q?VNiaKGftvc9JmmcuBy+SbFmx+FhlmRKnzETDgXsLOGDiI4XqZWWPf3/uDfY+?=
 =?us-ascii?Q?tm1zqC7gRYhUskDNm7wM0CaASztlHqteJTemKE72s/Wf4YnR+zvZWf66fXd+?=
 =?us-ascii?Q?Lh2+3vNKcaX1tCSA0bvkAGxjeAqhECkSg6YXNpGUPmTMKo3X+X0TKkaZ2nQn?=
 =?us-ascii?Q?CssZX4PwHuIDSjvXfCSEmXYkqOAJqTCCGoTYhUShfFesx4b+A+e4TTPBQ93W?=
 =?us-ascii?Q?3xDRT8fuJpOfZtjJQQ5af1dOpE3NZcgw+OLuIxjtwbBbegrgek/m0JSCLkxw?=
 =?us-ascii?Q?wGs8ERaMIxiv52mBFXlknmONNplSdcBViKH3cFoLuIZUJVIGtlkz7gEKJA2R?=
 =?us-ascii?Q?l5J3ANJUl81i5YryrxO2+dlhBjFHscviRH3BkP5imwufcnU746S1yPYx3cuK?=
 =?us-ascii?Q?r5v5jTrsRcsC0TaNh6XxJderVvf7WWjjLsV3o2eJmqdOXjUSaIEY/as9hm8e?=
 =?us-ascii?Q?NF49jyYg3pZYA464x63C23tbsZh4UB8H/AoSHktSi4BxCMymc4z1h6PHgbZA?=
 =?us-ascii?Q?U6SxC7oBAy4CN8ezcHqwQCVZnsS7QSLMGH3rYDYs+gFVKdpBcX20?=
X-OriginatorOrg: cyber.gent
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f7865a-00fb-484b-036e-08df4b072a35
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 15:17:05.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5a0a0d6-18b4-44e3-8e5e-e5dbe37f9ee2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq4iIIASHZpAS6ud3OXoJog02Wz+u0873T6hng3R3Vu8eVTM6mu8fBqBtPObt/rlKdnyFrVoCPC9cVPc+v80aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2127

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

Assisted-by: Claude:claude-fable-5-2
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


