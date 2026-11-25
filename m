Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625771;
	b=h+A3GJIUWko3PK13g4FmYuHqzFlR5ysSRIpVU4sObFnZdi7mliOxPmXSHRWs7+JPe92E
	 hBm1lVya+8up8i2mSG6Nxzk/YBA9hdWKJowZ0/0EBWzNME5keneoNLSDdV69thknXWuKn
	 E+hDYdQOyO6AWqywGwME6AzxBaOMFZx9b4C1s3pKMMoGrBT9SYh3ih9paCzpG6BremmLF
	 w/8q8rOCOiOBb67l4HS29Sw4DAmutXS+piytAoUf2ENfRwl/vcvGTWmQoLxEQOvVtOG4D
	 7JHpNHfBDNL9AVJ9s4mBsQpfLEmRkyUBx+Zd6GUXqw9UR1MVc42XPKTI928ut7DvT8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625771;
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
	bh=BmaJJ4v+BSISTMNtROCSTH+HroBEIUnZpLXM6XnIkQI=;
	b=xxUMd8AS4x6wq/jzp5gR6sFyNzZ+5u9Z7ZqamNLNya3hx+EJ4lIW89Ye9LZJfrZ9KNOo
	 Zz2NX4MJ3w3iavTzDGKkCas+G2A7vR3O6BQfgEw/ItgQ13HMzC0S+m0fzvqumaLH6PWAi
	 zPO7SfWrGB6QNfAjihCReMKWVHxR4k1JpmpkRdp3WpS/j2fa+Fih49SLxqXHquH+lTtvZ
	 DTKwr5vT2q69Tb9uTva/wjbPMk8oB7Forh5tPl0be/zREt09Xv4TFI/sNSmsNhmtVQoF8
	 kj1wc/RmeMML/iLKlGHesCyaTzZAfZzWLj5EThp+pIRvJjoIyYLq7HOiYKJBsl0ARPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyber.gent;
	spf=pass smtp.mailfrom=cyber.gent;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.79
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021079.outbound.protection.outlook.com [40.107.130.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208A606A323;
	Wed, 25 Nov 2026 16:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D208A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyber.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyber.gent
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/Gi+XcwAXrKOKbEi0Qi0a3M4Rigu4qptdm7yELBusb6Scnr6BeenDec3UtkNDM5g5u6YqWTfOQnlwjOmpNBEfBQz4ol4+vPPTGq7BsgqrNFimdEgf0loNeWP7+lAPvpnEnbgNkSI7spEWduy9mUF9gMQHLEYNHUGGUinrYpQ6Lgco9yZXd6Rd83pc6QCZIJzvMwiX28FzJ9Z6I0+704h6gQ1Z1X75nQKv4sZnvODJVAr3ANMvjqZ7KashOHsnVueU9umu36fyUxI2fGalYygi9a5UOS7itzze5JSCCIS28WkBMsQbn4pq2ASXPfx1OFfrsEIx59/7U5wjlmxgDGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmaJJ4v+BSISTMNtROCSTH+HroBEIUnZpLXM6XnIkQI=;
 b=o+/imUg30fAY5qdx8TDrO3S0l9ihMtOEay39cW1aUQeCXkCdT9LDop3dlkilFVXD3hXWqdmTrqkF0h2GDfaevPU/zFVFVfekhxdobdQZFVV2tGbk32BSKv2b2IRtHdTypQdoNlt6yeTUd42afvwJHWlBg8/V8I14ecqCflrH46/ztAhX+j8IdO2syf+uVLFwZjdL4S8Hojql+7NzRLStw+fRhd85EefCvhinjONf+dvrkJwcxbuLRtiuKlvejr1psp7dqF90/VSw3nGuflcpBSvKsqcIRz2RyOdPAwBxkGeyokCv4f+XWjXwdtKVtY7I/FTAHqwEOOg3CWTchm0cvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyber.gent; dmarc=pass action=none header.from=cyber.gent;
 dkim=pass header.d=cyber.gent; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyber.gent;
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fd::8)
 by AM0P193MB0516.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:56:08 +0000
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452]) by AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452%2]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:56:08 +0000
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
Subject: [PATCH v2 0/2] KVM: s390: vsie: fix instruction retry for nested guests in ESA mode
Date: Wed, 25 Nov 2026 17:56:01 +0100
Message-ID: <20261125165604.3074595-1-yvanj@cyber.gent>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::25) To AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 25f637f8-ae96-49f3-b0c2-08df4b150083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|23010399003|366016|6133799003|261009223027099003|18002099003|3023799007|10067099003|56012099006|261028144727099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	AhBQ4RQdz5/Bi7x+69QagneQ5yfYKEpg6TEwv57tAhmKCfAVkdsBVFre4kCKtIN9p6i4VltXPamp7IzwLWOCeLQCkhe1O0FBb7NirtZkQZ5rWqM4pew0DnHAaOHrvMIEvEyu2PRryChavN/I6dCvHzSbimJCRHOCeeQ586KZHyCVcAH4JOh043w04cxupbGznYm7rSmJdeKHHbZXEc0w6urwdgkw4txyfJFacen9gTMvhLkL0ghinr0a/rclNIvVNAISu7GngiWzuh3ZBIg6LBHHx+n5FcqgGFiyCSefK/Z1/qNc+WMBj+DZ2CeaOc98TIsxVWVx16fdvET4dckb9r0bjgvpuFA4RePioNpFLnKRd8plKQgmhoLKc1Fd+fqLg9eyuvCzG5PJeaYuYOEk7id1is3OzWPNhWqXd/LiQ4bKzqmD/B3EsOQpnI3H2NMyNgxcNbGVfLiNwQCOKYqRsYq7j+joHQR5DAaT0rsTmE5nQzadzFeLY+bStY+glslLrZpjMtDbqKuNaBg/cppu7BjJ9v5dfelu54mydyLj7/OoiNKWsIqzFOeleebcg0hPSI220gaGus2BsRa8sKp37i0Z9+guMQ6EgDneX2RkGT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1508.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(6133799003)(261009223027099003)(18002099003)(3023799007)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3Qx622/CIEmjU1xcyRF6PKlAPtybKcNevGilxwKqK38U32g22lzjGtJ2Rgc?=
 =?us-ascii?Q?BgTH3q6sAt2zcBe4jPQIED9k4YsiOtpFvLWGHEv6DSBZ0e6SYRnSiGZENQa7?=
 =?us-ascii?Q?9Z9oFwsMYbbMFCaPNfqDyWCjF6hIDESD6OTpMojGPq1DafPwUae79rHVLd0s?=
 =?us-ascii?Q?bsdh8GujPQdB5YeW4VDtNP2cMi0VQJu5MQQVvf++ilx6uNvXsMwhXHHhI8G6?=
 =?us-ascii?Q?qj+89ieVuNO9hZ95f9lNQYaKsahPNp2qLmhCggcuIHXa8BZr+JCz4ifgG+pA?=
 =?us-ascii?Q?d8FUAYllcyNHl328U1mO258ZFZY96cMGXy/3IX4NHjCo0qGc063iIqxSxelo?=
 =?us-ascii?Q?xB2RwczlbIwHIeJw/AI5gi8TGjxTEO4i1eZG1xodbzALDxUVfQOlfYFkko0A?=
 =?us-ascii?Q?FW2+AHe9diqkdlrolcCPnbzPVGoDq/1jpqpm0QJPuEYuDQDxl27b/tnkLs04?=
 =?us-ascii?Q?WjPf10dIUp4S0dKYCm25z1tbhAEwtvw0tGq4BkaMovr2lFiJEZn6X0Y/uMRb?=
 =?us-ascii?Q?vlGZQhfp8sH+INZ9VAwxq4KRkAf9d1nDzum1jje4ZDYiTn5fxlHRoM2YGC+0?=
 =?us-ascii?Q?DitIUxBAIVVWoYlKES8KmlypYKdK0EMe6ym17xPiI8u1CBxPpL5Zz3tVMKix?=
 =?us-ascii?Q?65qfluB/iDjfQILZr2+YnPYSuHAt0W/wM+TTEKTpo8cNHHwF/wvl7xXDTU7s?=
 =?us-ascii?Q?CaT7ssbmW3jyUsePXXW7rOjdXBMG0tO0eHGOe8XjTv/9Fyl7NAihafBphkCA?=
 =?us-ascii?Q?SgWtkKotyINwC66i5qPkTDnLIuVUKsb1RFFfZApKfdiHCaAYve7SDt7SMO2Z?=
 =?us-ascii?Q?UaYjMCvBYTdYvil+puptwQg7orqKiwcSJiI+fjWRaO7zw88U9+irGej6/D/l?=
 =?us-ascii?Q?8UN8kTq6P6wf2NMpXvmRPJQRLpJKqTvb3A3R6VhXDOgiNleoytipQRiPstcV?=
 =?us-ascii?Q?J+9iTGchOsMiNze9kM5/vufIh+WTyD+oMTeLFOuF13uhnd+Pnr3XPsUiF3Ar?=
 =?us-ascii?Q?WBqEJsyEKREre/uhS39f++uTXi6avoQLSXH3m6fYWgJajdIUEmBo9FEJvH3H?=
 =?us-ascii?Q?fKzD4Wp3+n2ZbKYbm8tyEDRzQkop5VpoiGbssQfzYrC1713XzUiM6WxfB0H/?=
 =?us-ascii?Q?pzGyXwQby7lXhW/aSsUwlQE5KnJ+xgzkFeQiKJXYtYGR71drh1a5QyHVKtp2?=
 =?us-ascii?Q?rsNF862/QxoRz0bBs13+nIGOuexVv91F0aOJUKTFbzg1idVoHh9rfku0EFIF?=
 =?us-ascii?Q?j3xb3A1DWTGhpM+3aBZV+kuE79VKTIpwFwT2PIXczWi5f2nj2MIdVLGNSFC7?=
 =?us-ascii?Q?d25Rc1D+KNuB6Xfo7mYYUjZLi4bJBvIGk+BvXEMuF91gdM5FGrTMT6yZyvAT?=
 =?us-ascii?Q?dulj6kfl0CaFp70JRKSmMo0GFbPPRSaUzE1Cd+NYAHsGMA/owokxhWYlCYRE?=
 =?us-ascii?Q?3IMiddAnTiD7Xm4XzC5A33fmLgND/qv6rR0dmRJB1ZFE7Yc4CVNnjmzMsmqn?=
 =?us-ascii?Q?ZKDnl/AYFJsewo1tkd7wKkcho8MqSnWBconVH1pCh3uXV81WgwJ3jfF1QyfB?=
 =?us-ascii?Q?Muwiq60cbDpGAyWQToLfbI46aSCJuffveU32hbDaNV96YXi0kgRuzDh8ZU9n?=
 =?us-ascii?Q?bmJYir2L+bF9xpAj2rnyDXuUZ6KzFqGyS0v4bDP6uXbOUFCgDubpBvbMihew?=
 =?us-ascii?Q?kRYukehjtx/fFXZifQ7N9qgpxek/k4FjehI6daPv/Lyi/ygm+N8bsoJgBtAx?=
 =?us-ascii?Q?fi3hjBttGX36pDBvKUtBbl3uJ6O9yuUq+LwosWlS6i5evK/1R7fW?=
X-OriginatorOrg: cyber.gent
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f637f8-ae96-49f3-b0c2-08df4b150083
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:56:08.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5a0a0d6-18b4-44e3-8e5e-e5dbe37f9ee2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iJX4XIFJNKbEMJ/e+cxh0C/a+762Kzto40OR+Y5ic/tJdCBFhA9XYZTqOpfQlJMVNNK+fbXvUzVo5HyrMSm8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0516

This series of patches fixes vsie rewinding the PSW of ESA-mode nested
guests in the wrong doubleword, which made an intercepted instruction be
skipped instead of repeated. Patch 1 is the fix, patch 2 is a selftest
that reproduces the issue. The base is the current mainline
(v7.4-rc4-260).

Claude has been used to try to find this bug; it was used to figure out
what went wrong and what would be the most appropriate way to fix the
problem. I've reviewed, verified and tested the results myself on my own
machine (MTM 3907).

Changes in v2:
- patch 1: shorter commit message;
- patch 1: removed the comment block above vsie_rewind_psw(), added a
  short comment in the ESA branch (as requested by Janosch);
- dropped the Assisted-by trailers (removed from the documentation in
  the 7.4 cycle); the AI assistance is disclosed above instead;
- no code change in patch 2.

v1: https://lore.kernel.org/all/20261125151607.3039477-1-yvanj@cyber.gent/

Also - a note on the context of this fix; these problems were identified
when trying to bring up Proxmox on s390x in my lab while adding support
for non-Linux guests. This bug was found while trying to bring up z/VM
as a KVM guest. There is another patch set on its way as an RFC to add
the ESA/390-compatibility mode for first-level KVM guests, for programs
that start in ESA/390 mode themselves, such as stand-alone utilities and
the early IPL code of older systems. z/VM's ESA guests, e.g. CMS,
already run as nested guests with this fix; what is still missing there
is support for its ESA/XC guests, which is later work.

I understand the concern wrt. ESA accommodations; the annoying thing is
that there are a bunch of potential guest OSes from the transition
period from ESA to z/Arch only that need this to work to survive their
initial bootstrap until they can reach z/Architecture mode; one example
here is the IPL text used in z/OS 1.10->1.12.

I also understand that the support cycle for these systems expired long
ago, and that the support cycle for a 3907 has also expired. My
remaining question here is if you are open to support for this, as long
as this does not provide a significant amount of overhead for
maintenance.

If you want to discuss this off-list, I'm also available on the Open
Mainframe Project Slack.

Yvan Janssens (2):
  KVM: s390: vsie: Rewind the PSW of ESA mode guests in the right format
  KVM: s390: selftests: Add a test for nested guests in ESA mode

 arch/s390/kvm/s390/vsie.c                     |  18 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/s390/vsie_esa_test.c        | 180 ++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390/vsie_esa_test.c


base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.47.3

