Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619825;
	b=SvqZ4U9SRH/CNFkBFIBzTbrdfMod/VqmjN06/NJorv0ZAg18QpQ7pJCPMoaO+qW4ca1d
	 52VOoBqRGKIGGwFA4D6yyawGtsQsvFu/p4ckk5kvKVKgAjmgOWUO5FmzMe3WuKQjVpsAj
	 GaRnifNNE3oIdvrah/DIZlPMqV4Mk7NjMiNwGDuZSdIK6q/x0LiXPJeystH2PyYaYIRHz
	 QdgYLhNQyMMxz0vtP+do6eZlSp5TSWIBCWTQFvVJhGeyatetQoFigwsR1HHymES8lpU8l
	 6L/XUWEpzN7ywAatXTSKt66k2670rS1mPnlViCRJz201IDC7Bks9EYrwmEZGSQID8HA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619825;
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
	bh=JnzsjkDOh4PUQQAaMQrnEiMGBhaUYDp/YaRRP8IpsB0=;
	b=ljZY9ljt6HljmBXr6YhCyJ4uG98kvMG6/V+c1nu/aHBwlc+5yVuKHxU5DaJlhF3Btykz
	 gVodqYiAogbszoKqnIPZZG1lZgtQ+G3V2i1sw3trxZiO9/HTbx6Y3uajhwmktLtlI6h6+
	 DakhKg0wvfxMwQwpsbpMoGX78n9GqiQBKIFM1d1pSnBCuJJgRAmS0mwEf60kocE49AdHs
	 pfvXzzIZ3EbOJsAecnhRwWL6hs4fI5OjJYi4q2ricQLslOo73oC/Q7+gsNec0v0VTlowf
	 DN69iJTu5yG8CvozM2ZK24u27sIl/xVQNGrCXRakoEZ8wXrWHj5aEoZ3IZHTAN5MDPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyber.gent;
	spf=pass smtp.mailfrom=cyber.gent;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.117
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021117.outbound.protection.outlook.com [52.101.70.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09332606A326;
	Wed, 25 Nov 2026 15:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09332606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyber.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyber.gent
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIR1f4/vcAEwexfMqCtAHKzcKDStEea82cOk8lveyTGNHZ/X+C73IimJtII6ovVKkE+F+Cmlwe6YmGTNk8B1jy5XHW8SjYPe9bp4RjE7pDKnT+xQVtnTk2EYJDeWy12PMWYiwTXLd4S+BorDkoWmDjYVxqlNjamurASWgVjwqdDtLbaJQvZ2u6bFAQOtQjGWFD4ZQ5bVb6mM+VOLEU5rrlm36IFmKejHuKoomRnnaQpbZnXDdXh8rJDNSNob+AaE8ZT9/Fr3HJLWMfMCfTsUWkBgpBEoaE2ZUCiEeHhr3gvtpXZJsXdIRr7ONNZWBAR3tHXNtWzlrWz+pKLWcDYg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnzsjkDOh4PUQQAaMQrnEiMGBhaUYDp/YaRRP8IpsB0=;
 b=bs8hcXNxphUG8z83/VHiHqSJuimqHKr1kUwRQCUMYf0mie7YHDMetA780w5AfXghRUxCZZbBkLq/WMr+c4pEeBGhIbiLB+JfDXN/4HV8vvYDq+HqpgoGpc+ROy7kY/F1tOUzRy5v7Hgj8D1VKexcCJ6nuUb4A6Ua/2smwuNgkof9rxpt6uShVkkvyGO+6R6d6ATdSDZmTB6PuiNp6KF2VxDhwU2tMMg06FAGeuz8ePho8hBzJfc8vm7pxYNEo+PZ5kzKexp8Es4uxi4BZT04/EEHWIciumzqvQbAb+8el5cYEp3IjrsPcAUr+WMTOxz56kecv0MFjsLGGq8KIvYnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyber.gent; dmarc=pass action=none header.from=cyber.gent;
 dkim=pass header.d=cyber.gent; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyber.gent;
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fd::8)
 by AS8P193MB2127.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 15:17:02 +0000
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452]) by AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452%2]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 15:17:02 +0000
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
Subject: [PATCH 1/2] KVM: s390: vsie: Rewind the PSW of ESA mode guests in the right format
Date: Wed, 25 Nov 2026 16:16:06 +0100
Message-ID: <20261125151607.3039477-2-yvanj@cyber.gent>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125151607.3039477-1-yvanj@cyber.gent>
References: <20261125151607.3039477-1-yvanj@cyber.gent>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR05CA0013.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::27) To AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0355403c-796b-4319-0fbb-08df4b072882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|10070799003|1800799024|18002099003|261009223027099003|22082099003|3023799007|10067099003|56012099006|261102123227099003|261022075727099003|261026121527099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	oBJHF9MVQXJw9/zyxnJQt6bTwdjeaGf1M72BuFEcYSpgRUixDETdUuXNF+tmb7YV2xQfdifgG7AaN7UHLDl5Idmt/5aQZbcczQnH1dnua+z0mb8rH8hqSr1nBpBDFRieMr0HwbIy5kLHUCTyVlO39z4N3GrSsFQ6eyZNAGfpNsTonUPfKp7IFq7fqwzSxLgz3ABAPJecfFWgyZaAVA/JNl5UcfT2ZJRmL9wpj+HrJd+pPj9Zf+INc8ljSM5mZ4XAIdtZcCSpi3mnv6h+cQTknVdZgIyyWQsrU0goJv93FEZDdOChMPa9VhBTjPm0N9KUTkxlLmv3iRStQS5Nk31pScboNH0eB6iKj7LfjEo6tASqVv/3FAgf/QhSwDeTLtqZUvQJ7KzcYNoFhus9o75C76sCMOuwD/9jKqiIh4Src3vU9b5pDL3z46H9qdMgeUEABcu1XaGDDeQKo/Ir1XoNTSDx2oKs9p2dBtL4hwY3aX+TJueV+peWGRk26DF157/R98u2fmpfS+09aR09a7j//5CPb4yl4ZqpHN6asLhzgPtGR20VrueJXDDaP/pTX1KOps2ARYkWxMUW+VrW5mISElQGihztIXA3X1Mhm+tGM9yBowZWFbjkmnQszg/b70ZUBMEFPu7kGI9nmo/m1ZBNwCQID2ru1g6kBeRj83H76YY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1508.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(10070799003)(1800799024)(18002099003)(261009223027099003)(22082099003)(3023799007)(10067099003)(56012099006)(261102123227099003)(261022075727099003)(261026121527099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUo/BQmNh0HC1mwNGgNJ8yjY8tQ1dAWNDZZc7GiJH23TnI2lVT/AN1m9874X?=
 =?us-ascii?Q?NdUlSV9KtSewH7iutl4hlBHBfta0vqCwxnlBAx63y5ksw1jlohRfuQ59Wreo?=
 =?us-ascii?Q?1hM3oV+fTVEr1rPfEMbBdDLnDE7wh0ZlklOjK2w+9vfaTgTL1kqFKw4TpU1a?=
 =?us-ascii?Q?YeUN+9OHqmnPrvaMRPHtMkQngQG45STJH/VPuJ38FgnzxyJcPMGH3qkYE4S5?=
 =?us-ascii?Q?GGUgrQuSWkMfN7rTg1CSDIzsm75pZCzbV+WTqlEqTcYvAKFdjLEQ42lY0ai9?=
 =?us-ascii?Q?QjBQc1Piq/n6CJumN4DuJ+TKzpautQiVrErtReh1JbG/iLnAGdYF3DyIzgLh?=
 =?us-ascii?Q?Rtaet+AKnK19/OdkD6qgLLa2FQJu6+d5rYGPnp+ip/wHUX9n8Ix+lYC3byJr?=
 =?us-ascii?Q?c7hFSI+py6p1yDmjI3Q1WlWEGmIqtOEm11imHnnQt44RddE4y86bYw7teCB3?=
 =?us-ascii?Q?TLGD0LA4tKD3jF/HC9TLra+1T5C38EtlPJ+n0JgL0s8SF2Q0mG7LOUnJvQGu?=
 =?us-ascii?Q?KnQDVzIU5GvTJHKCJuy6hdl2JJAXYZuSRNxtg7ypB+pOOUrnxwIDyxbDtLkC?=
 =?us-ascii?Q?QfrZK0WRR2qsd3y5AJsLCpJJ6ATGJqyjfUQ6Zv+QWdQV1CyUKYsK87ODgfOp?=
 =?us-ascii?Q?rBgKoY10AdVA/YB2DmjSoJ5GlNpkWfscRuKvqFauRdbCG0vLSqCgVjiRogak?=
 =?us-ascii?Q?FKOtzfNNlUl0jRban5DcAfZCrb/zNjNrapVJhPT3YnLO84GI3rEPlRwbQgYW?=
 =?us-ascii?Q?OHk3uo0vLKlOmI5CLTpja6+T5fsyYhgitiZQ1/c0fJxn2xfLDImhFSLvR3zq?=
 =?us-ascii?Q?SQp9Pg7EqLIlOYnQztjz/wfV9dtzXaEoFnkEgrS1ChbMOHSf4x479T18nqUE?=
 =?us-ascii?Q?/lQuTy1T4P0hmkacZMOFxuNGr+MMBOMWDshPUcVt0U3fN8QAqL+XN2g7m7w5?=
 =?us-ascii?Q?STXXVGg+Sx2BKPVFV2Z01y6cxSLermerHJd3ehmrXv1RH/HP+/4uXxX8i0R4?=
 =?us-ascii?Q?xVzMp2YgxCWMKt4JY3yuvqK6bY4k6+pYkZVbBN9ueP2bqylUfe/Jxg+M+4dv?=
 =?us-ascii?Q?mqYYRuVGW0DcDBnG/f4huuMjV/0Lg6TBgJBA7YgH7TRJ/wztEs2kjzIwh10o?=
 =?us-ascii?Q?qbShh00eXnv10qIuZwC7bBW8iAi1jcc7r7vgHW/zu4ECMU5q0TYHqiqpRpQ5?=
 =?us-ascii?Q?rvo6jzRtCBxNGKkgin1nWEPiBg/D/z5jRlp74RP3pAQG/DlJpEUyAyNAVzha?=
 =?us-ascii?Q?ipM71if+yrrYwUZXmKQNMz8zv+WgbKv5cNoBe/rivP2siknEPk/1i9ZvAqvg?=
 =?us-ascii?Q?IpT2rRfblbKpFiD/2eGm2K3Ai4ly1IzzO02gIy/0Nhq3Ny2fFJyfwIqVDpZQ?=
 =?us-ascii?Q?GJ+VwYrAb7bkBBKHQ71ieimCDa7d60fvg/7b1G5+9t4DcnR9SVFaN2t+DZP3?=
 =?us-ascii?Q?z5m0dBoWsUZCrDa/8O5iJs1LXLHeoKafE0SaXFP0qMMSeSKNNUal+5Rev32R?=
 =?us-ascii?Q?kBccqRfxWqgAJRJLdUBp/tskqzDD1lWqnjvspnQgfRAP+Pz0V6QfE0mT3z3E?=
 =?us-ascii?Q?k5ZEMDspul1QtdfweAf/aA2FQ/UZIjK++JQkSKnDcen454MpI0f+RToVM0aQ?=
 =?us-ascii?Q?abp8KgRwz6UluRrrhDBlT6eQyJMu9ylZfEb2SBrIhptEB1C7jq4FcsQttWRS?=
 =?us-ascii?Q?XZWU1fqeDHL5DzdNsTLnv4aT1KdGjlo6XHDfS/nbzRmq5p+ohpRDFjduYSN0?=
 =?us-ascii?Q?1/xxTrneb56Nb6vprUA+Rb9Z7Zgq2/ROm+De1OLCAkKq+lX+oa0c?=
X-OriginatorOrg: cyber.gent
X-MS-Exchange-CrossTenant-Network-Message-Id: 0355403c-796b-4319-0fbb-08df4b072882
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 15:17:02.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5a0a0d6-18b4-44e3-8e5e-e5dbe37f9ee2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8i+m51P1dXkfx7/r71jotXj33ThhrWpgCrSHDgg0JtRvCGSBKlty8N/IVB5dnZ6rmmFdr9Z+prfK7VT3qQi9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2127

A state description without the z/Architecture flag holds the eight-byte
ESA/390 PSW in the first doubleword of its PSW field: the addressing mode
is bit 32 and the instruction address is in bits 33-63 of that doubleword
(Principles of Operation, "Program-Status Word" as it applies in the
ESA/390-compatibility mode). The second doubleword is not part of the
PSW.

Since nested guests can be run in ESA mode, vsie still rewinds the PSW of
their shadow state description as if it were a z/Architecture PSW. It
subtracts the instruction length from the second doubleword, which leaves
the instruction address alone and stores a wrapped address there
(0x7ffffffc for one four-byte instruction). The value is copied back into
the state description of guest 2 when the shadow is released.

The rewind is how vsie repeats an instruction: STORE FACILITY LIST
EXTENDED after the facility list that guest 2 designates has been
shadowed (handle_stfle()), MOVE PAGE after a fault was resolved
(vsie_handle_mvpg()), and the instruction that is reported with an
addressing exception when guest 3 touches memory guest 2 does not have.
For a guest in ESA mode the instruction is skipped instead. The first
STORE FACILITY LIST EXTENDED after every entry into SIE returns with its
operand and the condition code untouched, so a program in the nested
guest that looks at the facility list sees zeros.

Rewind the instruction address where the format of the state description
has it.

The selftest in the next patch reproduces the problem: on 7.3.6 the
second doubleword of the PSW field comes back as 0x7ffffff8 after two
skipped instructions and the nested guest never stores a facility list.

Fixes: b0ad874d9852 ("KVM: s390: vsie: Allow non-zarch guests")
Cc: stable@vger.kernel.org # 7.1+
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Yvan Janssens <yvanj@cyber.gent>
---
 arch/s390/kvm/s390/vsie.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 3ce133f20fa2..58afe913bff4 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -948,6 +948,25 @@ static inline void clear_vsie_icpt(struct vsie_page *vsie_page)
 	vsie_page->scb_s.icptcode = 0;
 }
 
+/*
+ * Rewind the PSW of a shadow scb. An ESA mode guest has the eight-byte
+ * ESA/390 PSW in the first doubleword of the PSW field: the addressing mode
+ * in bit 32 and the instruction address in bits 33-63. The second doubleword
+ * is not part of its PSW.
+ */
+static void vsie_rewind_psw(struct kvm_s390_sie_block *scb, int ilen)
+{
+	u64 addr_mask;
+
+	if (atomic_read(&scb->cpuflags) & CPUSTAT_ZARCH) {
+		scb->gpsw.addr = __rewind_psw(scb->gpsw, ilen);
+		return;
+	}
+	addr_mask = scb->gpsw.mask & PSW32_ADDR_AMODE ? PSW32_ADDR_INSN : 0x00ffffffUL;
+	scb->gpsw.mask = (scb->gpsw.mask & ~PSW32_ADDR_INSN) |
+			 ((scb->gpsw.mask - ilen) & addr_mask);
+}
+
 /* rewind the psw and clear the vsie icpt, so we can retry execution */
 static void retry_vsie_icpt(struct vsie_page *vsie_page)
 {
@@ -960,7 +979,7 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
 		if (!ilen)
 			ilen = 4;
 	}
-	scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, ilen);
+	vsie_rewind_psw(scb_s, ilen);
 	clear_vsie_icpt(vsie_page);
 }
 
@@ -1413,7 +1432,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->icptcode = ICPT_PROGI;
 		scb_s->iprcc = PGM_ADDRESSING;
 		scb_s->pgmilc = 4;
-		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
+		vsie_rewind_psw(scb_s, 4);
 		rc = 1;
 	}
 	return rc;
-- 
2.47.3


