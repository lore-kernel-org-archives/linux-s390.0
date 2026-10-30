Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793402246;
	b=xHKlIr1HkNoJ8jy77o6MgYl3DGpOZ5QB0gpDF4NVFbtvCaKMUojVtG3n7RE1ULbkrgAS
	 av4kwqTMHi7Z2iVMJsc/8pHQk30ujxbH5lxNRZrCx6Bxua693um+FJdfyskKuZylz3VKw
	 rbcWHrLOm1vvPvkx4FLHz81duJad7wjs2kYOyklrNpwC0LLvgY4yw7zPmCh+q0+F8LCL0
	 BsemgGVeny0Nnm+HzOkdX7gkDGde7Rmv/S3oiPRP1IyXJs9R+EqJQ7I3l7vsloHNbMKnZ
	 1NjDJ012NfrCaeo6tYjTQ7c7TvqcNAJ7PvMJ1DiyBtoit1axWbUb2HeXqIouxPAa4rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:X-MS-PublicTrafficType:
	 client-request-id:request-id:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc;
	bh=epPMyHANuRqIeyYiM/LaR11HNHCnbAeU/KBeBhoiuWc=;
	b=17UNdYlGM2em4guMdqZaizyF26AJ55JwK3nvpBz9umIy6yZ5ju9XGMZrTt/lHB/Imroy
	 /m5F4uYcThy8+6VzJdabBXWWIn2NApDmXRNhI3S7iT3foAt/kIEP+Z8qD5Wb+1w/NHxYt
	 YrfQWqiUvx3YqrnXnrZf5RIp6U+vrBVsv7yYj1BF5oi3UjhkNAMDvYVZ2L5SAQr/WyS82
	 LtK/rdmlhfFoUkBHeQnESwmLyntSCkQ5Ff1cyYGU3O2Bg3xaGKT081AWIn7niC5fem/IY
	 Xr3QDt32dyAv/Y4HeZTgRuGrkP9xP4yJg3HymvqCVTnhavEt9A7e1OKarWz7SnoDHeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GcXy3AOv;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=0TtQPSON;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C8606A31A;
	Fri, 30 Oct 2026 23:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GcXy3AOv;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=0TtQPSON
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UL9Whs3124608;
	Fri, 30 Oct 2026 23:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=epPMyHANuRqIeyYi
	M/LaR11HNHCnbAeU/KBeBhoiuWc=; b=GcXy3AOvEgw2AeLMZV4E4urm92BX+VjA
	R1OfzVMYawwaB6y/FJdwInAVXsgvxxrumaG2VSdiA3OjzDwzAxcPgdyM6eJDvy2C
	6IukBFx2SYKJCVsFHbCutwChnWQzmnJpHYkRTPxwwgnlq3os0XvA9bn+fZzQEOSY
	3mE5KQnBehQRIvU0gReYn53YjME/V0eRuN1M97FYydMxIq8zbyyt01eoRVPe9tCJ
	EJq67ezoIN77kB60ggGhZ/JfeHiI52zTIq6+1UDat+mSsaUrgElXqDvEkAWGCXHa
	BPWSE8jOgjL5X5MIgPwcD9aDQIcELil30qW24M79MSPPovFbwwYdcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn2vy02r7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 23:17:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULvqai1052499;
	Fri, 30 Oct 2026 23:17:21 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hn2waafvf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 23:17:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQWHbVuGTnORS/qEXG7rszLm7Sr1/qyFMVlrKEMxVOqpf/nmSQ2WThA5r1XzB28LPYkEtkhUrvwxuKRwnrvYH7duTUk4e5yGv+UhQtFhrSTqZNmtRYNdvIfPybgh2Rz6Xh+RaE5o78YN3Slly/gu1rHEQAk8WFa0e9eq5t44VHnkktheAUS2tKzWMtr5k4mbyxlPuLtC0j43EEzJD7Yul8QMEWHRBFMCPaAyzGArMIhwlD2LEHtqq22CmsaaHKZIYdzkVYktGefJ6oH7FRtkUjGICM6msohLE63sN2Mi3EEONUkhbfTWJnKa8990xkQQP97+KMVOmReVq/jgh8Dvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epPMyHANuRqIeyYiM/LaR11HNHCnbAeU/KBeBhoiuWc=;
 b=J8VKR/FyGYgtI7KyZwR877oGA1fC3vZ4OUGaooVYtJYh79TjxprwZFyWIOxqkcOF+Pmae3AghiOsmTOi50o0kAHLRIXq+AOr2aZTMUfC82gshMv2Li3HmJEQliwBIPQarORBR3DGBY4euZuC0R7KswAAkxS+p+6yg3ewEIWkgowpuRzHIVtbAegNPC78vSjjyeDWDVTb8ycDaPRJbGYELZ0bOTc3YDIft2L5GfaK2xP2o/88J9/l7+9wGdKFTMBlH8UOSbap0rb71n3y4Pqaaul0OUJ0inFA64MDNKFNgVFRaRZsh1dA9vDc87T9+Uw6NKudlsCyYSrIB39Mijm5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epPMyHANuRqIeyYiM/LaR11HNHCnbAeU/KBeBhoiuWc=;
 b=0TtQPSONxFDsNjtS1hlyOxKwRBYqv/A+E183q9f1zOGKx8UfX3YBcau+6Zq2rFYc4/dpjLgOU1gsbRe6xWydDrQ613Ix0dKfQcSrXDnEt4L8QDMp//x11xWymHEAPUNwt7B5Cus/MOVLp9IHXA1ttTbPhlbIpFu/KHSC3mZa/+o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by CY8PR10MB7195.namprd10.prod.outlook.com with HTTP via P2P; Fri, 30 Oct
 2026 23:17:16 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 23:17:16 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        linux-s390@vger.kernel.org, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: add CFI directives for call_on_stack
Date: Fri, 30 Oct 2026 16:17:10 -0700
Message-ID: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To SN6PR10MB2557.namprd10.prod.outlook.com
 (2603:10b6:805:3f::22)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: SN6PR10MB2557:EE_|CY8PR10MB7195:EE_
X-MS-PublicTrafficType: Email
client-request-id: c2f458a3-9970-4ac8-b8e3-cdcce039434a
request-id: 613acb95-9dba-4b9d-92cd-08df36dbefbc
X-MS-Office365-Filtering-Correlation-Id: 613acb95-9dba-4b9d-92cd-08df36dbefbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|5023799004|56012099006|261009223027099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261022075727099003|261021135927099003|261022105027099003|10067099003|261021123027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cX5r9QIhKVU04n8DPwNss6dxiPXWDbvsnTBltS5wH7EoBjPQw0vwzsvWOaLYswttKIkCw/n0DJrjlXbkCEhb2pMqLkYLajnaqvNXwX2EtDCYB4bgNFy0mYgAJNg/fhPnX1RydjIxLE6RZRm8U4L/wPFxrCp9RNws7c0VuaxBimXM5HVdqbr3JYNtL7CVjbrdnenNtIPUMfPwTGNHUr9xgGekZ7DfOTnAdtwa6yNshC6/AJmBHWbAs/B0MxOLWpLEQQsYpVb1O0KjnXjMR7q7u/74k5foA05iDO/zSiI0Cmx7YeH/rDYgxqwM2peG3jvLiJhh2pMXgeJBhBS5N73whsuQEZ3/jm24VyMlv19rpSVPe/pyR7ISPlMq34KPPBjN5mqhiSvs//UAEkX0AHUIzg0UP8Lm1zhrMc+2NW14nz6n54gfKDz5Sny2EY/fmwWIuv0m7DslIsa6UGaXQ1nq0EVsXBtRHryaveXlvCaTT46W3eXFveL7odcf7NnTc8DMCVn1pdgmJh/LztKpnu9DY4kq11V1O9IZp4LkcGDCgd/NjL4z90O1OAUYX099OZP1RNpLxkTId8dL4+CbwT9xD9A3tZqzdt6l0O3BOKWydYGsMoNnKtdT+AqWbasEPXp/PIN2ZgFb1aGGY7RF2FXpvaP5WguYY6DPyr0Q3bW6Mhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(5023799004)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022075727099003)(261021135927099003)(261022105027099003)(10067099003)(261021123027099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y4cPw5hA+lG7ygrsUzBCofbqk0tnUS4/XCpuCk9Qao4lqQ9wIaFFOTtiIQ4p?=
 =?us-ascii?Q?avZv5j1C6acG71lpRvtXvBszaROan4Oc+mCPwrDuggnxsjBPN/VY3jSJY5r6?=
 =?us-ascii?Q?eSLpltc3HsjcIpKjZhVI+baZEdxgVKd/U4TBJCzeU3SfZIeP0gbP5mYPek5S?=
 =?us-ascii?Q?hGkYaEE3fb8IrK53yzA8S3ErDetXO4HDHnMByOsfPfk32Hw3kv+Zxd61/mpP?=
 =?us-ascii?Q?U0pStjbgmIUYDFdO+anfE7toYQoJdCjIKA4U9fdqLn8A1A5vqPYZfP1xWzBk?=
 =?us-ascii?Q?b6vxUz7rtIw5OA5hZSwacxjvUwELz2UAIZDUfMtPm2S0DWvvHdBGyNWC9INK?=
 =?us-ascii?Q?fd4Jix07VUcJa9Wyt+50Cw0crOeHmipxzSWgdxtaKV0SYWl+FO9qhAdxzEIA?=
 =?us-ascii?Q?3GH4L0zMeItty3dnZVi1vZZIjUTuZ7FsikBAbl01zoe4uthP1I00GjKSLzR6?=
 =?us-ascii?Q?Emum1U8Fo52AOfNMKHcXH1MO4uj5mk4ADwFJ8Npka7JwByWIVK4JjWM1VGnk?=
 =?us-ascii?Q?Gz0tpXNYsujXzG/llJeYHGDGTwBcdp/1kqYefOwbsnzxbhNxNqrXbc/ZJG4g?=
 =?us-ascii?Q?g3vC+Zu+9wtuMCyJVDhUyPZR7BQNZXy+RFr8bOcZyOYbMVpBFKJOuh9oH+zD?=
 =?us-ascii?Q?yEbdGTLPW2GSZeQHt9xRHKXubQ7Ubp+XyodA0tQbJeXPQLmf5amIsWbpinQH?=
 =?us-ascii?Q?iQH4FjLO3VnsV+zPAiGAhobV9/ISAPXCbVySPwOHm6/NLr6POXH7OCdn3d6T?=
 =?us-ascii?Q?SRZSzM88TBrNZO8raotjWmArQvDjOzPvonz6tvfgB0gqFJYxeEXOqIsrrrQi?=
 =?us-ascii?Q?FTT5lXU6rJr24oodeKHxU6Sg+K6qvk9SiiIl/3kRULy0kJ03/NB8VzNwXXBt?=
 =?us-ascii?Q?0kJFwLZD/it7rjBE30W4i825B66qJc6zT98gdaCOIWCK8UNSDbWPmTFX2ewD?=
 =?us-ascii?Q?OLQhehkRjyomPBX/f1eef1JLNeShIxGwjyQ4QiD8el5gMo1OKLusAgU3tvbn?=
 =?us-ascii?Q?84z4FZu9Pmtbp4ZlFmBSn+AEg9b/V9Gj9XgpoL5IgpYoaBWUsC9pOLHOb0bs?=
 =?us-ascii?Q?1UlcF9wAYOAyY6JR9iy3gO/1xYmF4GKzRZPpx8EENw1fMgqIsgBvwuhngkFl?=
 =?us-ascii?Q?OHWcCVyB2fd/L0PhVTiG09tEi1RGYQwGDO5BnWIBDZOElVF+mauB2PlmR+Sw?=
 =?us-ascii?Q?HhcsZHG36Byl8KVM0VYSS/7ZOTWV7zY88Kp61LcZcvXeONe0Jo+qLH58ExTp?=
 =?us-ascii?Q?ONKjrvIMKaCOliBbNRYLi9VUfozsbs2695mo1gUoRChUJT4r0tkJTm3OyGFn?=
 =?us-ascii?Q?WjPYGopxnEoWyms6kqyWeoGhqI7N+J/mbdh9pqrZZK02Y8Iio9pGUQ1piFGz?=
 =?us-ascii?Q?bJ2eddAtVCbxePqTGfR4oikbHv81VtLYN6VTKsYD/fDiZbam5meyqd2uIqKI?=
 =?us-ascii?Q?PPYjl2awxNLQym1/2WzLZBzjye0Eb11gGdEN8MbZgJukpVdOIKpP0xXrG41L?=
 =?us-ascii?Q?RDJoYlTtCLNj5C6tNbw0+uOK29HctqJUEt2cenlhjehG0J4HPpOPzI9lywIZ?=
 =?us-ascii?Q?HLrPGk3UlTJcrWdC75mq57ylJrEBQvCDZVrNq63p4vF+Y8pPk57zkPNzWfkW?=
 =?us-ascii?Q?au5MvJRhRv/ZA/lttxYsTnycafbeHyIJ/1Jt+sQisvbn+t0oSsc2vd9KqDCV?=
 =?us-ascii?Q?2gevmFC5OcYRfE6vxNEc3FUi6FwZyrkZRf8Xl1kdA066kDhWZ190pc41i/ii?=
 =?us-ascii?Q?Jm59s3ThjoR1i/eW0lzfmBJkoA6x86g=3D?=
X-Exchange-RoutingPolicyChecked:
	SrMHm8gWBjVOUJ6dvTTN+R1HR4y2ga2H2z2gTQp657mlyifAreV5HHt2gwafBbReOwbdoMAsGcc0AYXL6bE+GUXRKAkAuxuWFauWigEUi15z+Rh1iD5gp/dfEWH16oROS7HbMurI5nkwJ5SXVgImF+ZwOuH3pp1mXDzfPHsiraueoCyz5p86Er5RXsdtGPn6Puk/WINMxpj7bgo5fKI2YK+dhC5iMto+CGFlKu8fNZJGvY4/URy8CYM3APQ7uX43BgxgKMjSFoj1DYgIFHtTxPseSfk0inGiH+PmaZb1HIYKzthXKOGaFj2KqmCpiYfC1mTJo+lg7kHS237/o0NQrg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CMSOgd6AkVPW2EKpaS5YkknhyOgIm284PMp4SLqMst7VbfK8jM7VT1aX6GDUnpwS/tuiHMGIZD5R2MzRwfzSpB1joSPN9ENDCKd44mpXe6ljtmmwp9uyYrMX4VOMo7PMxRe7UVz1QpzByU2mh2EKiglb5jjhNcvbHaINcjlG4AXgHhbLIX1o2A2FqkCPElGIAQbZa29ka+Ski0pYrK0gCd1/+Kg+n7UcKKatslRy0r/oyAgp3PP0roN3HwDNFXZ+lOZLQOUcl9g/jQjC/LL87pv0l96AFbYIvPLjitgTK2r3l7QQc+A9lN3kuIcgnS50OuP0J2/hiqKau0GnYv0HhVFKuSlvUA8MspEv5zw98iPFr/4XiJV0ITb7/Ds6dKknqHeb1umum1oSNXeN8FqZyHGyn9XWbNhdlFFxnA6k96IbuYw9aG10cWsweRCEUR4u4K2iRn6lyQV98fIiraaYY4ryHrs+aV+/Td6tmXnbJr2t1VSkdw2mJ6ouXMcd8rUgPqJQSBd5itR/kQz29keOPgJYX6eY7jaD4tiKP3+b0SsJrIjYa1y+W1ZmlO4xR8sydPvTpivFwnBFBvUaaKKJmZtjN9Wi7PCLfq0ie3MoiC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613acb95-9dba-4b9d-92cd-08df36dbefbc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 23:17:15.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTk7D2RhFFwjyHXHBYgxYMzIWxvvYmQP8Wo3jyYphtSB0lWdOWauMPzUJy7KHg+3lNKQeB/k+osTjiW6iMHmT6yG2fJQtO0toeIVm12hxks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2610300092
X-Proofpoint-GUID: h1dlJOokOTX4TcJYKetNMFZobA3IuxJe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA5MiBTYWx0ZWRfX4kp1eqLeO9tQ
 HZcrvjBB0dm9VlTlPV9MqAjOmjp8AKjhV/YGu+XEkNxg162qlRVsFrA6kWw5wUwaV2OYk/ZMaM3
 X13N4nCGPaxFUECdstiwf5x0EEr6RbFdEANvKn+ePplJvgpRV61x
X-Authority-Analysis: v=2.4 cv=V+XoQuni c=1 sm=1 tr=0 ts=6ae52582 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=17FYL03jAAAA:20 a=yPCof4ZbAAAA:8
 a=4y6ffcx9BbnVZogFFskA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: h1dlJOokOTX4TcJYKetNMFZobA3IuxJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA5MiBTYWx0ZWRfX+SKZcKVGYjHf
 ngCookDPutukyOAtKZg2YYlCrRQLfZ0acyRZgva/mx6QLINnqliqfadfXZky0pPlTs6XyWhTiNe
 Wok7viEvWndnnrYL3dyMSUnnc+aHmr8vWWuX7sZW3wcHkbAzp4gHuRSYM6/0DDeIWAirs0SJk7D
 /8bDEIi38u3fjwAYYcS2M41df1uOFwGELW0kl4SHMqkggspMB4a9ngJlTfa4PaZ4sFPLsMBCtyQ
 rVseP4BLDEpXMdawsEBSTpxhq//6fZQC20RBQBYjmRVLi5d7ShdlZjbM584y8HHDa6T3KfZxbzv
 qKASTNB4Kxd9vC6tYk0YRgeNe80N/zyrNuXNnB9hgfEC9PJJTt7SSzhP+eNRXaXgQ7qN8zKjNdj
 acrKmKqMwvlv/6ptyAly9RMgfdjT+Yv0vquv8TFLWfeEvGzXWRnLx+dZzzXJo7QNn9/ezikXwmw
 dLjl/rz5qm2ckw/wCXw==

When debugging s390 on drgn, we experience two issues. First, when a
panic is triggered on CPU 0, drgn is unable to unwind past a stack
switching event[1,2]. Second, drgn is unable to unwind through an
interrupt exception frame.

It turns out that the reason for both is the generated call_on_stack()
assembly. It modifies %r15 (the stack pointer) without any CFI
directives describing this change. Thus, the compiler-generated CFI is
wrong, and drgn tries to unwind using rules based on the wrong SP value.

To resolve this, use %r10 (a callee-saved register) to store the CFA in
a temporary register. Then, emit a CFI directive describing the change.
So long as DWARF CFI is used to unwind all leaf functions, the value of
%r10 should be recoverable, and unwinders will be able to use it to
determine the CFA and continue to the new stack.

I've tested this only in a QEMU VM using drgn's vmtest framework.
With the patch, drgn is able to unwind through two stack changes: the
change to the IRQ stack, and the change to the CPU0 nodat_stack during a
panic on CPU 0.

[1]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/vmtest/enter_kdump.py#L69-L74
[2]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/tests/linux_kernel/vmcore/test_vmcore.py#L19-L25

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 arch/s390/include/asm/stacktrace.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index ac3606c3babe4..ed9ae00fa339c 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -170,6 +170,12 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
 #define CALL_PARM_5(t, a, ...) t, CALL_PARM_4(__VA_ARGS__)
 #define CALL_PARM_6(t, a, ...) t, CALL_PARM_5(__VA_ARGS__)
 
+#ifdef CONFIG_DEBUG_INFO
+#define CALL_ON_STACK_CFI(str) str
+#else
+#define CALL_ON_STACK_CFI(str)
+#endif
+
 /*
  * Use call_on_stack() to call a function switching to a specified
  * stack. Proper sign and zero extension of function arguments is
@@ -177,6 +183,10 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
  *
  * rc = call_on_stack(nr, stack, rettype, fn, t1, a1, t2, a2, ...)
  *
+ * Keep the original CFA in callee-saved register 10 while running on the
+ * alternate stack so that DWARF register save rules still refer to the
+ * original stack.
+ *
  * - nr specifies the number of function arguments of fn.
  * - stack specifies the stack to be used.
  * - fn is the function to be called.
@@ -189,6 +199,8 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
 ({									\
 	rettype (*__fn)(CALL_PARM_##nr(__VA_ARGS__)) = fn;		\
 	unsigned long frame = current_frame_address();			\
+	register unsigned long cfa asm("10") =				\
+		frame + STACK_FRAME_OVERHEAD;				\
 	unsigned long __stack = stack;					\
 	unsigned long prev;						\
 	CALL_LARGS_##nr(__VA_ARGS__);					\
@@ -196,15 +208,19 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
 									\
 	CALL_TYPECHECK_##nr(__VA_ARGS__);				\
 	asm volatile(							\
+		CALL_ON_STACK_CFI(".cfi_remember_state\n")		\
 		"	lgr	%[_prev],15\n"				\
+		CALL_ON_STACK_CFI(".cfi_def_cfa %[_cfa],0\n")	\
 		"	lg	15,%[_stack]\n"				\
 		"	stg	%[_frame],%[_bc](15)\n"			\
 		"	brasl	14,%[_fn]\n"				\
-		"	lgr	15,%[_prev]"				\
+		"	lgr	15,%[_prev]\n"				\
+		CALL_ON_STACK_CFI(".cfi_restore_state\n")		\
 		: [_prev] "=&d" (prev), CALL_FMT_##nr			\
 		: [_stack] "R" (__stack),				\
 		  [_bc] "i" (offsetof(struct stack_frame, back_chain)),	\
 		  [_frame] "d" (frame),					\
+		  [_cfa] "d" (cfa),					\
 		  [_fn] "X" (__fn) : CALL_CLOBBER_##nr);		\
 	(rettype)r2;							\
 })
-- 
2.52.0

