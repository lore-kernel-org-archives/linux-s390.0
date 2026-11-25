Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625772;
	b=PdbFMpUoNajTPURLR3DoZpH2yHtP1Pli+zqzSj/leQZpRdCMvjH3caGSxUMn8V4j8Y3t
	 gZ7pXt0JvE0x3H/MsSLgdSNbHiKVXJMckQAyemNhUgXlcbg1TW2SMlQcg9l3PD5tP5KAn
	 C14s65/ofRMawQt5RmrECGQm9Ay2Vv4llykcJjJlTO8sdw/2xwH467EKs0dHF+yR/adzN
	 RQFFSE+IHjWlfcizobfkslxzeQXuPmWoIBbNX7xgwYnNNE5ytNhqpBQ2oBPwTSiQAV6Xu
	 13Lshn/KMRsRWhNEf0i4GJBR11Z/GoDBGM01GUL0InXCpfyqVjB/ElpPjo9ZAE9f9CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625772;
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
	bh=jc/xBKq0iFS5p+sDc7LL6t40Gugo0nFzq65Ak5y/rks=;
	b=unGx6hVpF3n768mJ7KhwSR8K+WhKSuKrJ97LtR0Khf6Psq5DVchiiLxrGseDIfe2al7w
	 8uiROYzVPM3y5zEM2/kjuSbq8/SicXNO0EF2zFzqoIAF+rTRQk2g7lm7bBjQ468KtzLM/
	 aNnQlEnDl5udrhie61i+XEzL8Bsa3zfoJyIyXukHqOxfPr7xo+szaA6ON3zUg4+W6yMsq
	 sqzt9ecwU/3mYkyoPIPtwqzbna2DIxfYXVLOT+/E3UqyfBOiyjMoBv6gAYblsgabTRRxX
	 aT0JKczAAwjPecaCUUBV3WElT9NQ95C8lSVKuhmQkc0PMm+SqoFRy4PrQTFzjYnxiPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyber.gent;
	spf=pass smtp.mailfrom=cyber.gent;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.79
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021079.outbound.protection.outlook.com [40.107.130.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59C606A32E;
	Wed, 25 Nov 2026 16:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF59C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyber.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyber.gent
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjtgdMD2KPRGthsK8kmRsdNBFi2a3vJcfIA/sXKfw6cQkNINljj+3zdzfr6mQn9fTPDMWgGKXa9p33H4JzdlWTnnJaAf6lCLH69mwoi6rD4wAsndC10BNuxMmzG+ap7+GGbwM+JKKV+irxaMztt3usxg2t8X0frbzXWfSYuOqvFJGYeQfbENVeFvFFCh92GoikGJDgZa0560GYATsqM64fK4+T5xxhWibwYALifGd2gE0M89Cnlym62LlCI5J7fbImJmMJp7zDGXmxi81N7mFFODRij+jC3ZCfx9zKGrkp6xsQ8NNVFkiat8A7/ff76Pa8Tn4fCXIoAcuhASVbrTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc/xBKq0iFS5p+sDc7LL6t40Gugo0nFzq65Ak5y/rks=;
 b=T94jdGlIXcLdfbibWuSSu2qm1GZ0eBJGsEs76FjrAk+2a1VnhViQSA6KorAcdy3HCN8FoQxwKAkMMqGat7F5b0ahndU/70MmvwjAfpEy5yxk2DKC9H8Qb5d2qJfLxrztBIiQXJmJko2kVAVjvUfFH5f/tCn8rG7uCsIsvd7Ua86e7nZpqCwFklSiCNPXM7MnBp7NQjcJ2D1TKgUOhP9cY+PuOr4EMTas8Ao8vbmqGBcxhpeEmzTZY9h4EB7CFkqaKJvLyGFrThUBgIn1avK/zLybHd0hDu8mJibqs6/Tz2Lwqgp6JrkGCQRq7P9cfKKHZQ2VGLxM/ysE4vXtQiMtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyber.gent; dmarc=pass action=none header.from=cyber.gent;
 dkim=pass header.d=cyber.gent; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyber.gent;
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fd::8)
 by AM0P193MB0516.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:56:10 +0000
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452]) by AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452%2]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:56:10 +0000
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
Subject: [PATCH v2 1/2] KVM: s390: vsie: Rewind the PSW of ESA mode guests in the right format
Date: Wed, 25 Nov 2026 17:56:02 +0100
Message-ID: <20261125165604.3074595-2-yvanj@cyber.gent>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165604.3074595-1-yvanj@cyber.gent>
References: <20261125165604.3074595-1-yvanj@cyber.gent>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::26) To AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: d62df646-c6e7-45de-897a-08df4b150186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|23010399003|366016|261009223027099003|18002099003|22082099003|3023799007|10067099003|5023799004|56012099006|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	mSfwa0dbnwkf3+prJSzUzq/1mVrE4M1zb//aOMq/O+hqakkb0zDwkSKPp1C2S+XuORNS82HloSB+g7gH8zko5/aCoq3kdLDXMR9t1yabXAUfwBJ68RFXl1zNCxz+lVj3cCSAr1du7LqEHRIKFOGUlOJwzK63qfbd92YBqhOtSRuWNbGCsqUgim2AzB7sVy7jd0duAqEi4H9STobae/qNV9JuHbIii2nTG3InNAHojzhPAl1goOTCh9QnKF8qczqkmXQYKN1dX9YzFHWg3XYOZK4l98fgA2eU5HPwnNpWRgCY7ZxZKo9xScPBa9odNYqsB/D4+D3SSfeZuELQ4h7IGpFVsrD9IzE94MIwT4T2wdWjXQjeK5R6hV6j/ndxV1JMIc9V8SUct0Guev+jFfwv3SjFymrjDV9dTbNx4q+hrLbYkUQ6AHMw2xFM9N1+UwS2oRs5dz7WkJ/hpF6QbSbfu94JiZob9isyZ6Iz5stniW52M3CIcXKf6IamjL7ivDw84Ja32bsVwHQh1L0pphreIXzawZ6CV6AFk6bJ+gt26rSWDOrpvBBrtMKDQqHS/futxP0e3gBM/wck1HH116AaOagkn3gLTiE6B+IMTc9WzEnbdBRyeF5Xzs2HgPf7xLEJqidWRP27mJHa+Rcaa/h2NH71cag//bLPXWaw0TV+trg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1508.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(261009223027099003)(18002099003)(22082099003)(3023799007)(10067099003)(5023799004)(56012099006)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYhez5VZvfrn22vo8rPNY/ZmJqcDq2PsJLI63ZxQVws7ZTu0Co9dAWrDXS2B?=
 =?us-ascii?Q?qWDSBS4rl0aUHyIjjGLPm2M1ijlbY/sjqUFHnBqetUT+ZEeAEcnkBXRm/PSM?=
 =?us-ascii?Q?j3I8hMow5/Vi16NAbKF+oxv3BdpNZYqkyccRY0mBvIokrejdkxH04ONQGHrE?=
 =?us-ascii?Q?NqYLqCoAAzqz6boQKgwpg8WQjcb44n0z+HTkheAuOGcjL3nemOBO45hWFg/P?=
 =?us-ascii?Q?LigiBK6acjEnzKecPCQS7UeoQw+KIH8Y07PJCy5W9qqq9oHNFJOCYl6RjYI3?=
 =?us-ascii?Q?l6xADpupSQC7oBRTJnkDLcdsmcD326CZkEVbXh0RHiMzy8IsSpLvmaBGfsT+?=
 =?us-ascii?Q?PnrFuHJcFRXT4YUod4/ytAv6d2PdSOe+1VpI/aQW4oRF9Mj9Ja+pKYFFVN1Q?=
 =?us-ascii?Q?/NJkwXrWEKalDt5rdKOLQIpOCTOkdtonTz6oYUDxxCrF3s+HuuUb4mkg0lpI?=
 =?us-ascii?Q?5YNGtQ73YMx5rbO8DdVL29xXQIczWSIddCiz6fWkMF9gGxYhcjIGtLv6e4HB?=
 =?us-ascii?Q?OX4XNVL8Wt5KQ05n9VPpJ28Oh18rYYRtPy5jYdUCGv0MjIeseD82euHzdWqU?=
 =?us-ascii?Q?dJfMy0Mgl2QINBrJZkaSFH2CTzZUC8snrpO+Z36l1ZzUT2W/1Un+EixRHYFA?=
 =?us-ascii?Q?WmqFGLxzf6Xs2s8ep8ppDv9ZPOYhLE1twzNi2EuA6x05K61bdRWsUPJdzl+T?=
 =?us-ascii?Q?3yUUvdyzIxrDzscTCUK/NsS8hF3ezsYljr0CVDRQkaRF7KlSmMVvwhLmz6nQ?=
 =?us-ascii?Q?g8mzKHL8tZ9YafxhZ8Fiu5jM43A0qyhsYGwfGhTyNZZYS/pPRv7GxrrqLkyY?=
 =?us-ascii?Q?v+n3g1scyRoivI/lf2RTMgYBZuuuvLdV4+hewygXCjpBxf9M0S3AuIBx5O0Y?=
 =?us-ascii?Q?7LZ7pGrgtqdiDG7W+DT/XdFB4kndlxXLWDoglvgFWTjqsaoOLMtIbfMJnplz?=
 =?us-ascii?Q?QLhWszvIWUL98e5tPqR8hP6+IBeJ1i6ZZqc+nWZG1tVtakRqhynBMSaMPKo0?=
 =?us-ascii?Q?D48ilQP48T1gnwCoLxybej0KVyjcT58bFkvyonBEFFl20Ipf6FUopgBdLVBr?=
 =?us-ascii?Q?ARUaZ5OntGJv+a+8/VqCL8IcDCY+lbtEi32nghTaxhqkkQ/AsEXAGbhG68YR?=
 =?us-ascii?Q?Uy2a3lp7EGMrs0SYkfCBrUryOMRhCLLtgftw6kMnYUfPHHTwlXOrQq2XDEKf?=
 =?us-ascii?Q?gSYLeRJ6F3bx/gkksFMHMMMwimsWMgQfASowS8RgCOLfFo6pvk8+cpmtQj4e?=
 =?us-ascii?Q?aGm9TkfT7pVfiGVZCTkhp2AU26bXnzAiYwBYqIQzx+rtQ78gjyZTXRss/abv?=
 =?us-ascii?Q?8ULdFYx6CyHLtL+Hi7gFejW9nekQMX9H22SnMjxTkePmw377ueP9ioG+as7+?=
 =?us-ascii?Q?kd6gZOlBsCEsrmP/tcMPSdWAngft3QT8Q26PVt+IG0nZXzKHkB3yJqeUoijH?=
 =?us-ascii?Q?A0qpJLv+olmLPEq+HsrgK2Owvwx3UiWd7WKF293wK9tbpWIgxVl0bN0IzjB4?=
 =?us-ascii?Q?lgfatCHFL7cnaWqmuuVeX5IpD3gJrionEv5EjVQbjRNkhgLWXvta23vyTwUe?=
 =?us-ascii?Q?kmIuM7OTcqNT4j/tzP8eWibqIXql4gdR3809NxUNc2Qr+R/oAo0qFZqtBKYS?=
 =?us-ascii?Q?6PGtkFZvNk7tkIL+lbefmY0hsEbL13hN8cI2U6EOVNA/PNTLYkBxRe7C1M2c?=
 =?us-ascii?Q?rMlJzJ+Y9QEco9VxVc+0mYlaw7sa+Gg4NLSR80d3Cp7iEIlA1ouU6ZZ29OcW?=
 =?us-ascii?Q?TCX3wu9H3WtgsuBwmoN9i0NFIKA6aDACWBcDStAeVgOyFZqMqdk4?=
X-OriginatorOrg: cyber.gent
X-MS-Exchange-CrossTenant-Network-Message-Id: d62df646-c6e7-45de-897a-08df4b150186
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:56:10.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5a0a0d6-18b4-44e3-8e5e-e5dbe37f9ee2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8s2aNavXNU7BssCftQ7VLb9CmJ5PaQ4pGC63E1Q38/Nch6hY3FSz1z63W0eolX84V056RjegYOhpOjdFZyKgmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0516

ESA-mode guests in vsie have existed since commit b0ad874d9852 ("KVM:
s390: vsie: Allow non-zarch guests"); they use the 8-byte short PSW -
the mask and instruction address share one doubleword.

vsie's PSW rewind originally still changed the second doubleword, which
is unused in ESA mode, so the instruction is skipped instead of
repeated. The visible effect is that the first STFLE after entering SIE
does nothing in a nested guest.

This patch adds a vsie-specific rewind function that handles both
formats; no short-PSW type is introduced - for ESA guests mask and
address are written into the mask field.

Fixes: b0ad874d9852 ("KVM: s390: vsie: Allow non-zarch guests")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Yvan Janssens <yvanj@cyber.gent>
---
 arch/s390/kvm/s390/vsie.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 3ce133f20fa2..ed40d40d89e4 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -948,6 +948,20 @@ static inline void clear_vsie_icpt(struct vsie_page *vsie_page)
 	vsie_page->scb_s.icptcode = 0;
 }
 
+static void vsie_rewind_psw(struct kvm_s390_sie_block *scb, int ilen)
+{
+	u64 addr_mask;
+
+	if (atomic_read(&scb->cpuflags) & CPUSTAT_ZARCH) {
+		scb->gpsw.addr = __rewind_psw(scb->gpsw, ilen);
+		return;
+	}
+	/* ESA short PSW: mask and address both live in gpsw.mask */
+	addr_mask = scb->gpsw.mask & PSW32_ADDR_AMODE ? PSW32_ADDR_INSN : 0x00ffffffUL;
+	scb->gpsw.mask = (scb->gpsw.mask & ~PSW32_ADDR_INSN) |
+			 ((scb->gpsw.mask - ilen) & addr_mask);
+}
+
 /* rewind the psw and clear the vsie icpt, so we can retry execution */
 static void retry_vsie_icpt(struct vsie_page *vsie_page)
 {
@@ -960,7 +974,7 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
 		if (!ilen)
 			ilen = 4;
 	}
-	scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, ilen);
+	vsie_rewind_psw(scb_s, ilen);
 	clear_vsie_icpt(vsie_page);
 }
 
@@ -1413,7 +1427,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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

