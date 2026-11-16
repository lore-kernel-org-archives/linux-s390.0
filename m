Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794852250;
	b=xSQaDiOP5TZ6afZY6MubB7ANeuMlXzIyX3+qM0tqjvjkRyVAPnFf7mWPSO/zMhecL9PN
	 ZlmkWE5XR9i6BTVGMiKKgR6QkGpPaOM5zPIcQPy9Tzd8I2JAUwO+M+tCpxds5QR1IKmZz
	 hwYek+J7ZFuBisyZitKJXPCWk5hoPzxi9FcUDtB6nqxJEsVRq3Tsgr1HPZDEfWJExMqaT
	 YuMfyr0a+Z1UXJ26nQLEKn0SV6bB3f6ipaeOCzIUVBDgUMv3fEbmWDLaLO53vmTPYw8kI
	 Cc92yUmM6ZjtiKaddjmSJFiSrzCxEFG7l4ddYAV/n0BHaOPmHS9+cpQkLXzhuHqqolA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852250;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis;
	bh=cQQT7Fzfj6dM/panU6e5jEQ1ZN+KXy0m32bSDZkTtAg=;
	b=Brq8akF2HRIejpQa4pVk8sQBqEHxQ2ds2n+0aUyAMYgLxg1zac4R9EV5uhCoH8O113hp
	 EkVNElaSUIaeAabwiVu84JhLMyf7uy4yt/0DzlxbbHwsBpLehfPTdxeu+s5Pytby4C1ki
	 9QgaLEiFi01k+B6DjC9n33t8vTvKSVzpx3sRdRAJt2O/IABE56JdXrZ5/a2hfNfp2Yfwd
	 jovummHcBFxw/FTpiJ2jQoP+SYklNSv0LOdJpww4JcRDdcOqv8VhQ9g5bnRMrjhkWasNV
	 KqJ0eQHWCCTA4YxmjJ5K6Sd8s4lTJ65dRO5+pNIFIOGhW50T07snTwyTiEf0ChlJgow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=BqeAIXyp;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=TkOylkUU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D3606A31C;
	Mon, 16 Nov 2026 18:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 891D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=BqeAIXyp;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=TkOylkUU
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCAbIb2402820;
	Mon, 16 Nov 2026 18:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cQQT7Fzfj6dM/panU6
	e5jEQ1ZN+KXy0m32bSDZkTtAg=; b=BqeAIXypBPn2ZAjLW3dPkiWaIPflZAK8Ur
	PHrrkwyj+DJ5asEEySz9969Es5GoxxES8PEtwJg8qxJkW34U0cuJqqjTzuSNUv9K
	2BSzFbO3kvJj5dC/y9ARGFh3wpzkuKsgiumbhJZczqzh+eTMweXqd2K1FAgYYPHD
	ak9r54skCUV5duhSqu9xeik8e+BZXzpnBBGzNsBl25FxqKIZqprQiei08M0zY2VZ
	eE2a6WU8Frw1rHfqksLFwK1lSXmLksMyiAurWoPJtc9CRQWEQpIFJ98vZGUS2YkM
	/Ij/cS9wCnhtG60/Ub5VVLy5Skf2/BKAcA0JwhZGDFS5SjHKAXEQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxg9jtpyg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 18:04:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGH6qCc145490;
	Mon, 16 Nov 2026 18:04:04 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j05xmjbm7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 18:04:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUXX/MD0d6OiBWf5cN9BZUCCtd0swXQy+orNDO6rzz9oHBKu8rerXNONCJ6KtDkbEN4pP1a3hMQziT8U41OYQDGbtXfGHFdGx2OjQTp/dv7y0v0JivP1hSBXugAPE7K25xdgWZHff2386A9LQrDruWj0TMSsiXFSs94vjKXwZtHjPM1Wt1KDFHbfjtNPyVpy9cV6oGbQAwnc9yR99a24XkqWCM7e/ss5ZUYQhOlR9ihsXPwiPqrIbo7FgePhMJueLaw8XFrsKijfL2Z6zkYt8XrsRB7wpSoAVSPpGbEBf8ITOALdT+Zh6/XHLS2r3MQMdkpvJdnJXuhebBfjpIt9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQQT7Fzfj6dM/panU6e5jEQ1ZN+KXy0m32bSDZkTtAg=;
 b=Df1cWq1+C69VuXSxGW2ikv8mon1VtLdIGC8pMvw2jtLwpEKsodtMBb8aHZGHYPd8XoICu0CmKAEyoA1u2gsmzmkij+9Ravx+6J2/2EQQv7dzwloWtxegX/H5LlXOi9plGdu40u+aLej6Ow5uw6T/ZA+rdV6eHtwQdFCHHpjxTnairKwNauVwB9GGrUx/Jb30B2aBZ7yDxnC9CbC2Wni6jbV12Ci7SELgiYg1tQIan1RVBAGzHFIVDZRfrYMETX+QoAUh9Ixz4nVC092mUYfL3Kd5YS8Yh/kb6Q+f3RiDXUTs2I7d3KmhmZJME2ciA5tPfwCRr4PSaG00ErGHIYOdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQQT7Fzfj6dM/panU6e5jEQ1ZN+KXy0m32bSDZkTtAg=;
 b=TkOylkUUXCmnIKGT0r4ir5KIzNTcy20AAD5iO7zXTvC2UPiFvU8v5m5N71B9kIBlA56jCvFTE3zRwgZm35GM7GTaGEOOT/PBEuwnY4bTQnjZHs2GuQW+DtS8cigi3nLeQ27G051YfEfNS7kw5yjVzRLQ4RyhSPgJVq/VwiHgOWk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by IA3PR10MB088736.namprd10.prod.outlook.com (2603:10b6:208:70f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:03:00 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 18:03:00 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Donnellan
 <andrew+kernel@donnellan.id.au>,
        linux-s390@vger.kernel.org, linux-debuggers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: add CFI directives for call_on_stack
In-Reply-To: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
References: <20261030231714.1319773-1-stephen.s.brennan@oracle.com>
Date: Mon, 16 Nov 2026 10:02:57 -0800
Message-ID: <87qzgkpsby.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:510:174::15) To SN6PR10MB2557.namprd10.prod.outlook.com
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2557:EE_|IA3PR10MB088736:EE_
X-MS-Office365-Filtering-Correlation-Id: d44f28de-40dd-4792-9b7d-08df440bd9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|56012099006|5023799004|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FE/MNnN6yhJ8QbVACHBTQAvoE7W4VXpvBsdKNPQ33SZki2Zzd/WTQN/X9s6Do8ztxE9OHOPEREeJUGh0Wm7qpzoWym/PcdHuWBTJ81VAbsoVigLMVFMGfb6zIhURuNU74549iKvLRoYKD2T3+vBZCneESScq3t2Tvz6iD0RoHnax+zhj3FhgcUi9DrcGDMxXxsP+rcKtV3LaVOSi/wDKmsWgb+sXfGWyjs9nzHw7NjT5JqNZtA7IJQGl5Zydumyu2TGUgTeNHPAMVPYuV4vHKsVlbgKosRqvJEqISQ6ZAvyCxixY5e2RIbVEMf6YJMJqw/uOPdTyJV/MsOs6u9ht5vUT4jPl5l3gme5Arhhd9cQTuHKumrnHMp2o27xen6WloCYOCS0B37FuM1FsR9xIxuF3LDG4DCIf+3WBUTgJ5NjC/rYoVwWpoAlu3/E/6C3BwW8OITft4dQWKpYi/zfndDASv1TBXDc9+MXO9m9wX4aCpAAm8CrfHdRR0t1rFeznBzdPjUQxz+CbmkH/n+30+/ntEsXgfkaiASuGHXjko2wUQ2NVsdWxRi6RuMcLh0mU/SNSQoTU07T8p42CW63kzyCxeARXc3NiKnl/nD4UGi/rhiFDux6qcVHcXVrMJAOi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2557.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(5023799004)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19mF7X7YcSHtLip9UBhhJoV0zgpoTnkYzD4L1T63JbJqxzxSeyV+IdhT7O4B?=
 =?us-ascii?Q?XoW7SoPyBb6UqflS7cHAxXMnvY9uaoNSoJTuu+U7da/P7J3tGIPdjtl0zI/Z?=
 =?us-ascii?Q?5brdg6HdEhfCQLnBL1G78z6uuWyJcfDKjmUFuf80LI3vgDeBO7kYcap1X8gw?=
 =?us-ascii?Q?jVbNvgdeZAyh/ZaI2EoQvs+irM6YBOW0hfwXetK/SjvpHolyLCe/vA5EZgB2?=
 =?us-ascii?Q?4rNy0KQAFHKSwiGqlEjT1Vtupqw37qba8lvMMuiTtxQAOmdCLLQlqMJliPex?=
 =?us-ascii?Q?JWJsHa2hMaZjwbRslniizlzi1OHHSzLPm+vpFss5SiDqORJlEXFxugABqrVu?=
 =?us-ascii?Q?ucJzstXRmnb8SldYMlSRwe7rO5B+WmWf52r/WXxzZsb0YoBuz6zWHmiRSVFU?=
 =?us-ascii?Q?VOK3sChWMDfvDBqSfsjpO/UjjsE0pvYuvInI0OxC7TtMOstt63LLEtgR1uK/?=
 =?us-ascii?Q?kxQj2gWmwT1aEF0umZ9AgFWS+cpiSpx8G3LsUTjOtS8c4ARUXsG6gLAdb9iU?=
 =?us-ascii?Q?RFMBwEQPaTDjFP7T2ST9xew/uTjzyvamkfeIYm0gyqP+AlpMOwR3qxhdnYZR?=
 =?us-ascii?Q?aEZdptIAkjWLaBpI/qR99o/FwJYQbxKJqBH8OK6+wv/+yFzDsG+e1dRqnb0F?=
 =?us-ascii?Q?MBb7qND3NH7s55c61K+LPTT2QU82/b418nRw59OpIGaYFgXA5oqvVjZ62sGs?=
 =?us-ascii?Q?o7mShUfCrAmCgEZHaLJ0/NJVK4SPTq55bJsPejiPZ+kBRVAtooYYVuYce69h?=
 =?us-ascii?Q?Olx9NDF8yQfK6aGEgJtn0aEJwQ54ktsLx/14KCuamH9WcsfgRmLytlt8jHEt?=
 =?us-ascii?Q?AkKe+LrQNhIQ5ydW99WGFW2sFh+zWf627LaZN7JNdP2lS74jgncz3Z90JEbC?=
 =?us-ascii?Q?HkW5KGwATx4e/VV/9PnsUy6IegWSdjAkhts8lVUujhO8N+/kGbrzgPRS3AO6?=
 =?us-ascii?Q?/t6b+N0rhXmZZ6C+J4CvkgVvMvSirQ7qBsMBXv/HkbbJy2AHGQWReXdeMIqm?=
 =?us-ascii?Q?Q5pu3sDegwg4CGKC+0XTJm/5i0o3Q36jBz71/iVCgJW7RpPd79Rd7tGxT9vi?=
 =?us-ascii?Q?aRbRs/RneNAhJ493Iqmez13nQ7IMIwLke5zwSKm+3vC5hcv5WKZerKQ49MV6?=
 =?us-ascii?Q?Nd9SDfaf/GLEJKKO34zjEFLQQdpbyiqTo2eQ7zUfbnK/Of8jFl3zpFd3jnci?=
 =?us-ascii?Q?2y8TjAQQxD5a8r4Nh3Bwnrz2xfv9ZQQWtrx4arAe5QhMk/I1FG+RLjPS1S5u?=
 =?us-ascii?Q?4hx1Vpo762q1F+bu4erHu789QcJmWUoknRQV6Hn6Nokev+mBYIsDe2fEezeF?=
 =?us-ascii?Q?CKD6L8gKyc8bO8EFyxBpHxcvyuKzQ6dy5RxL67vGYzAfN72sskVNvJ5Il+6v?=
 =?us-ascii?Q?ai97BzA6xXlHfLAZlcS+EZU7XWn/cNwF1bCwSSq4BA9KlWnN1yK5c5pw4OXv?=
 =?us-ascii?Q?LCcTApJkCP2SGERxv6g+KEyZn8QOaA6oRhmu7PINsePWCN9s5BseIrzQP/0P?=
 =?us-ascii?Q?s1KmF+U4gjgI+9SdQe986oqud6EF2eiFiTc6TKjYD+PA0W1KBw8FPGAUrvmC?=
 =?us-ascii?Q?BOWA0P/8nTM3FTOg8nbUzQ4N1Dl7gHXBdGqaeOeSrGEoGLTsLv1Y35BiXeid?=
 =?us-ascii?Q?Z/rYxEjsECFpdBGRdK9oDLgeFvuyrae7bHHAzx4mh6Tz+aya1NDNUaEJqA5u?=
 =?us-ascii?Q?bKNDO/rEpUwEPFPPctWLtNDKobwEyDLojMuQqPY9twOP5RzNcYKAl8sP8Ey/?=
 =?us-ascii?Q?uX6zF8dgENGwiaOVLKgvTiy/acOezzI=3D?=
X-Exchange-RoutingPolicyChecked:
	PpK/xR2QjajcgYtmWL8hsnJ+lg+94I3rFWEhwCJHFdeaq2mAE4olr/hzNEE+55vsY1jgmlm3MkTLpconEPCNh1df4KAU2wBrNtTv68CSB/wSTV4VxNBMlSaEWbtrF0e2HSbT8SqNtdO+xLySq1k0fX0FAyeb/2SaniItk5gNRnd5ivAZJrGqyKbkTgawubumfnkJc1z2Sg9Q28uPStQoTrVn/OK9BwV1eWw5LyvInfWnEAXQcBCpMDistdao1fmIo3i3Z1aLG6Q4YnjDalU/J/BH8CYvnTLl4sfbLYr2ak4nOrOC4MPDMGqMAEkndzi+ekDcS8wjHiaqIrYOuFRDiQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3SpBg496XrBUP4cY/X8xbKk47JAZpbIPbtjuZEWs306KeiBR/xQdo5kgEWhPcjHLzKH6J2ehb8t0xEq06p5bR6KyNLUltU+GfeII9pqrVO8X137XWh+aKD3TNlgN4nK1bA6EJWxZNkoisrsZLARbbluG8XBdabkz79X8oV7OzOCf7w4YOahZfaCOK2jkV0QmSxwy2vMhvc/PcNyp6yD6GNZwt0GqaTV+CYHf3qJbZ9TSaFMvRRgMwLb6sg/UXe/HCX+SkPGdVAr0MtoaWOn5ajMPm67pXCSppQ3Pf3lUiIrHCQDH1lUGG0GKkdwUykFYlgq7aRTw8ZY1gVCUvcJCO4pq7R0QQEShBjydL9pgEeSv6ljG0p/N/lOJEGJC0cA3mvUd1+tLKxls8THReF1otuOFMfjT10JJFvHiVVxx2p+IAkClFQjgYwoCGRv3KPWoM4UG9Yi1aNTMuNwe+jWN4Q4aCyjlcrzxpa1MhoJPV5ekc2oiS862oaoFAQNF9rhpVfqPRKkXfwoYTEoFWh/yIk0yGZbtMW34Ct8YwbyXGXzYfDyt4eSGD3kQgT+WiZ8QTnwqYXnbK/695oBLQPoxs5Lw55aJsGMGUn506BedTII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44f28de-40dd-4792-9b7d-08df440bd9c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:03:00.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uRt2Bwls91uF2/MQ0OFgGoNCQoyl18X8gex3m2Yk7uslTiVwzTxxUEucAl91Il7iTFaanZJbpKJDVd2UPpzFmznXLcRpF2J6IJN8b4aC1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB088736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160071
X-Proofpoint-ORIG-GUID: LVS1_fJpvM0JuJzVDCYRfd6T7lUMHd_3
X-Proofpoint-GUID: LVS1_fJpvM0JuJzVDCYRfd6T7lUMHd_3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA3MSBTYWx0ZWRfX/XMJWatV1ys7
 XHfHdutL/gdkfDC4yWjnjLDwrtgYv4BMoAiH7Yn3v8tZpbwHVYN+NVdkmix2mduCstC8AX6Hh2j
 5tf8559Kxjza4tn5/b1P4/vIe5egmdkwFuDEbWBVh7lWqeodVj/Amk6CqQhFFCZE+i2Q/W8GoJk
 2/ZeyRWl7O7f51b7MvhexLWbrmNisYLpAqMmxN9gD5u4ekWUmNvjv1lNpuTnig56d5zkWhWjd1m
 VmHSy7Hc03U2YakT/YMZsi99SkWLImPAWbIU/yegBVIyegCs7fHlLi0cAt2IfX87qB06GTc8aZT
 HKEdEv7/XajdobnBowHoYczGAaYT5DPzwgKbbz7SO1+E9ZBmEoc6nL15xfvJl5uXjb4gK8d8f49
 ZUbuly2qOqiJ4yWgNpOGJ0qjNgw7h6XHqtO6gwH+IOxD5C8OHfN6LJqHMSLnUS4u6cn3PqNb3HI
 2NzFkbW/k0uNyXALLXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA3MSBTYWx0ZWRfX1y89lGtW6Dbv
 aVUaaoFP5DcuTivMouuSdnZfZr4n/bTp/8Sz6dVlghLmb9LXgeK7YH7Oo2xjQebpcl8zcGWQiT4
 iFifiJ97d/q5jHh/Tj4/p3/xtywUAhXu5E3Hq7DyH41p6LtsRmv7
X-Authority-Analysis: v=2.4 cv=DMoacCNb c=1 sm=1 tr=0 ts=6afb4595 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=17FYL03jAAAA:20 a=yPCof4ZbAAAA:8
 a=828xrCdWP7lNTI15hL0A:9 a=bA3UWDv6hWIuX7UZL3qL:22

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> When debugging s390 on drgn, we experience two issues. First, when a
> panic is triggered on CPU 0, drgn is unable to unwind past a stack
> switching event[1,2]. Second, drgn is unable to unwind through an
> interrupt exception frame.
>
> It turns out that the reason for both is the generated call_on_stack()
> assembly. It modifies %r15 (the stack pointer) without any CFI
> directives describing this change. Thus, the compiler-generated CFI is
> wrong, and drgn tries to unwind using rules based on the wrong SP value.
>
> To resolve this, use %r10 (a callee-saved register) to store the CFA in
> a temporary register. Then, emit a CFI directive describing the change.
> So long as DWARF CFI is used to unwind all leaf functions, the value of
> %r10 should be recoverable, and unwinders will be able to use it to
> determine the CFA and continue to the new stack.
>
> I've tested this only in a QEMU VM using drgn's vmtest framework.
> With the patch, drgn is able to unwind through two stack changes: the
> change to the IRQ stack, and the change to the CPU0 nodat_stack during a
> panic on CPU 0.
>
> [1]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/vmtest/enter_kdump.py#L69-L74
> [2]: https://github.com/osandov/drgn/blob/97b613c23bd4d100a61b3b06fb1b5097fcef9f61/tests/linux_kernel/vmcore/test_vmcore.py#L19-L25
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Hello,

Following up on this patch. Is there any additional verification I can
work on to help facilitate review?

thanks,
Stephen

> ---
>  arch/s390/include/asm/stacktrace.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
> index ac3606c3babe4..ed9ae00fa339c 100644
> --- a/arch/s390/include/asm/stacktrace.h
> +++ b/arch/s390/include/asm/stacktrace.h
> @@ -170,6 +170,12 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
>  #define CALL_PARM_5(t, a, ...) t, CALL_PARM_4(__VA_ARGS__)
>  #define CALL_PARM_6(t, a, ...) t, CALL_PARM_5(__VA_ARGS__)
>  
> +#ifdef CONFIG_DEBUG_INFO
> +#define CALL_ON_STACK_CFI(str) str
> +#else
> +#define CALL_ON_STACK_CFI(str)
> +#endif
> +
>  /*
>   * Use call_on_stack() to call a function switching to a specified
>   * stack. Proper sign and zero extension of function arguments is
> @@ -177,6 +183,10 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
>   *
>   * rc = call_on_stack(nr, stack, rettype, fn, t1, a1, t2, a2, ...)
>   *
> + * Keep the original CFA in callee-saved register 10 while running on the
> + * alternate stack so that DWARF register save rules still refer to the
> + * original stack.
> + *
>   * - nr specifies the number of function arguments of fn.
>   * - stack specifies the stack to be used.
>   * - fn is the function to be called.
> @@ -189,6 +199,8 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
>  ({									\
>  	rettype (*__fn)(CALL_PARM_##nr(__VA_ARGS__)) = fn;		\
>  	unsigned long frame = current_frame_address();			\
> +	register unsigned long cfa asm("10") =				\
> +		frame + STACK_FRAME_OVERHEAD;				\
>  	unsigned long __stack = stack;					\
>  	unsigned long prev;						\
>  	CALL_LARGS_##nr(__VA_ARGS__);					\
> @@ -196,15 +208,19 @@ static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
>  									\
>  	CALL_TYPECHECK_##nr(__VA_ARGS__);				\
>  	asm volatile(							\
> +		CALL_ON_STACK_CFI(".cfi_remember_state\n")		\
>  		"	lgr	%[_prev],15\n"				\
> +		CALL_ON_STACK_CFI(".cfi_def_cfa %[_cfa],0\n")	\
>  		"	lg	15,%[_stack]\n"				\
>  		"	stg	%[_frame],%[_bc](15)\n"			\
>  		"	brasl	14,%[_fn]\n"				\
> -		"	lgr	15,%[_prev]"				\
> +		"	lgr	15,%[_prev]\n"				\
> +		CALL_ON_STACK_CFI(".cfi_restore_state\n")		\
>  		: [_prev] "=&d" (prev), CALL_FMT_##nr			\
>  		: [_stack] "R" (__stack),				\
>  		  [_bc] "i" (offsetof(struct stack_frame, back_chain)),	\
>  		  [_frame] "d" (frame),					\
> +		  [_cfa] "d" (cfa),					\
>  		  [_fn] "X" (__fn) : CALL_CLOBBER_##nr);		\
>  	(rettype)r2;							\
>  })
> -- 
> 2.52.0
