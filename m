Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6C2DAF8B;
	Tue, 29 Apr 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967902; cv=fail; b=WSEp2yRJ+RD911+RYIhk/22eplsfxEJdDcIuGXPfmNEZZs/2g/cuUMUNeTS+WWo3khx9LX47lG21qkfG/OrZrudyG+xJybYt4IgwzeDL3fDGCwCVqnvKg4jDjMHmTWAv/SB5BHdeqLQR3PKurEwfKbxi9/5zqwTzcwpfRzIsC2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967902; c=relaxed/simple;
	bh=vSxo/xfEkdMy/qDO5t30kURKTuHE7MFYJjq35Fg1xTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwGClH7BlmK7gA03sHUSHunxwiDdQ66sarD65lcLyLiaC+k2FJzNDexI37Q0crZPJmYnGXbByk1pe1tB/P4uCOQnQeKMQmKMpClLyuEt5UDRU4rEbPfmfE2IISHK5XKm0fhs56/eTb76Zwm2sbw7/Vo+b1I52ZBtoNBh6ICAUrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kBivXIWM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QO2VlE7B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBivXIWM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QO2VlE7B"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLbNcv010608;
	Tue, 29 Apr 2025 23:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8wg3WrlZpPA5XQaIh9
	aP1MZ6tpD9RkesYlNyuV898+0=; b=kBivXIWM/rV2cYahAjFEoNZTTzrH4uhncH
	eADvHuEOWNDVViNK6UFUAJNLnomRrsxqSSWnwF79sqUq451I9UJy5ikiLh6xFamn
	VvgxpJ2XPZsd+zxGYxskheY1IM/DvOGqg0xmLOE10ni9qJbmfrn077+5XHdIhsjS
	waZ0hlXHU6R8LmFLmoNyKYgaTJMHePEJpSMfBpFzPL57dO1xYD9fZ5uINrshS37L
	s61+8wxmqE+0v5z0/sZ+3lMqjTmBruyIGs4gsgd8Gh7KitRziO3FDYWw3rqvJKCq
	tqyG/deMtnnAPaT6bA6VM0AQxb5tT08IxqQUzB15A8p5C0qNwKNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ucg2y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 23:04:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLnBWS035456;
	Tue, 29 Apr 2025 23:04:50 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxaagyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 23:04:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxie1KNuMvrX+nYsYjQ7DSqLkwRPRgX8UZUT9OG6balLg638QPOV0EWHZM4ZKWVPK7Wnoe/dcwWeel50SYN/IRx3op+xvRYW5YZUGM+i+jCcR/giGccD+f5e1QnuxRcg0hxtKlAZVimSEEyDpMfxRuNKHXbFnSRKuzFbjyNR8s2CJ1fzj9cj8P3DUc8mU/vg9GBlb1hCfy4eRN8gneS/fuUvkC5uyjaYs72JxVi38YgD9ZnbLw6KkczlcEb+Rpm6Dal3Z9fPTc5NZhStin7u6TxilkMeOGGnyaqbMhLk9s9wSxNiWUn2dz9ZLeSpp1sIT8JrYw292Y2XB+7jwDwabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wg3WrlZpPA5XQaIh9aP1MZ6tpD9RkesYlNyuV898+0=;
 b=Ass18t39EVoYZob78Ks9zh4rBA7TAxTyNrq2Ap1mmJF++qfyE1T0f17uZPC8NJ7zKyaeBdHzcyB0eArYtR2Kc7RhCs1cYMxIMdJJoCQdeJ0CkcyxPt7sBCQpK+MqQIEHDdM9J782Y24zYZmOKyomcq/Mq+Lm++BBGwl7/SxEfBp7XWvhKyNLvMX7BKFvsUaadrEe1/YOpqyrr1yOwp+9lvw+pN45KDfftnyipgoNCzCR68Y9ou1XCpyvhDewGNlWhF6641FYFwqyJehh6n2B1pTmR+BicS7Sb6trLXl0v1t4l8ccmuZrMonSKUKPpTn9MbzzMTEwhiL2oMO7AYdMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wg3WrlZpPA5XQaIh9aP1MZ6tpD9RkesYlNyuV898+0=;
 b=QO2VlE7BzxZNcR6Cb4OQsFMdIzrwKVHqdN34YVpx7yOeEwhnBds3bBEiqv2CkGhIwisk2a9GsyEAAWgpigt4wZnyH8xygDZ9p/yGTVrtC5RV/fJDY44HNF2NQS5A2gu+nSkky2ff2guiKaCqZ55yAutWEJK+D9mJvcrP0bCvpvA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 23:04:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 23:04:48 +0000
Date: Wed, 30 Apr 2025 08:04:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aBFbCP9TqNN0bGpB@harry>
References: <cover.1745940843.git.agordeev@linux.ibm.com>
 <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
X-ClientProxiedBy: SEWP216CA0052.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abe7dc0-2399-4ffa-915d-08dd87723d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tF83vNBuhDySoPBw+AJKyydf6qYDADjTSWYVPe75nfQIspq5xnkP6NOOB17?=
 =?us-ascii?Q?INmQY/WJ7iDbhEgG9BNSM5yFb8HnOoFWUS5i9D0VwlbybUJt58qdv0jkN8Dv?=
 =?us-ascii?Q?Wz45Tp4w3G87lGSZD1pF/8aytp11GhMDR//u8t/D3GTvzczwQIU8W0hMfV3A?=
 =?us-ascii?Q?upO344cbz7QTXnfkfoA1cYVChPj+72N4EBC6WKFdnmWGtlVEPRh4xBGmRRe9?=
 =?us-ascii?Q?A+TgNISHPpvD0PdMB9lXBhl8xFtQsU4PBFvXkBQ3149Dn1bUSZRMj1JP23fW?=
 =?us-ascii?Q?U11SYhzHyry81X7whX3g696mvwpTy6+vzHeM/VuTAMi/9E0F2HXdJmAvI7Bn?=
 =?us-ascii?Q?Apy8YscfULHNgGcY1+wg3ZEVFKhbP5SK5Bv5a5dlmFrdkMRxsXL6igxpixnd?=
 =?us-ascii?Q?BZLLs8+TD2IBICo/CrDJdEkEwUwrEqxEpkvcSk+9MmFQjAaXfNxLKwzrmwHH?=
 =?us-ascii?Q?0uADBll2b9B7kMeMZE8mSiq/VQRQ3voRbfkYQmKOdKlNcWOkVD2J5bn5issb?=
 =?us-ascii?Q?ItwLtTwpZGnGxxHd4KIyTsfYtM0I1qgmOlKi8MR2zlGGSiUb9Wdg35yv042I?=
 =?us-ascii?Q?8RQjdxOh7uFreh7WMJ4S/54lwkqIUhpwFy4pVQzStyHZZTYBjJDxpSdCkDB8?=
 =?us-ascii?Q?KMYWCwGDjAsC5u6M2qBpOithKxFV8SGc5+cyr0uH4dXI94ssvLmZoTSBn0a1?=
 =?us-ascii?Q?ZSmr6t21MkmharDA9Wz9RG0jE9JFsErVi5i8m/KoFza50QyPJIzoPn7U2Pa1?=
 =?us-ascii?Q?acYpUdjK1rMia8d9yiyhiMgt/jN/+pdfLg7Svy2jkKdWf2EsbW2T2z/6g6AS?=
 =?us-ascii?Q?+k37plRTREm/DjmPxPFj/zeKA9j+qFa5fvy75WdpiVMEYNiXBZ51kByW53h4?=
 =?us-ascii?Q?BCDFZDSMTjlRTccbVG1G2ES3UbD5IjR+YTuPIQ5nbrnYEk8I6KTSLuU7mSle?=
 =?us-ascii?Q?LptlEl65H+LempOUpB+5zjimWOETZKbtxQf1k+WFYa/MBSXt5X4iUyCgsIl5?=
 =?us-ascii?Q?qfVNksjV44/2JBfzjj0sYln/jR84cywSW/5doxR/DAWXImR+Bp9JWC/IBwaa?=
 =?us-ascii?Q?wiOcO+uK5d54tzssvgrIMGEssfrFL7mV+5jhJcVXA9fMucUOJwXaBVTXSLjJ?=
 =?us-ascii?Q?O3u5iHtziSsNNFnYG11LZR5m6T6MHWn4AguTCya/ThY8BR/BfimBPw+U9s/H?=
 =?us-ascii?Q?RrQkK8OSoUUCD0Sw0Rn+Nqt4fwLsOHSk4hkuqwOY9oFvYrHtd03Vowq8TxOL?=
 =?us-ascii?Q?Ovy9asW++Axk6GGGcSkZYaYuAbu+qsnPqoOSGcXtmghyiBWChbZn/APttcAb?=
 =?us-ascii?Q?SwXBkQzLfnAgb7g+gE3a5dkM/fkH9GGLHnkPyWyqIVHRs7zsIuhI6vEcvnl3?=
 =?us-ascii?Q?zzTDKeSH5+iR1s2OlPdmqDLC3/KI9XmLox9zPdkVOPDYv++BS//8BDmPVVQD?=
 =?us-ascii?Q?IbgLGA/Rk60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9GK8KV7RYwUuvqhqvP5JVZZ0+gZn2zOEr69wjpAUIUgbarrB9P2h4QW6yfL?=
 =?us-ascii?Q?XIEeA0ct0JQzMIL/6LDSW60eL69VaWnRDhkq76wHmBlUfCzn5Bb/UCsMUF4A?=
 =?us-ascii?Q?uXHz9lW2rUZrCJwG/by9nHEqlALPNDzdjccyoUWkYWJsbnElEBGD7nUcF+9v?=
 =?us-ascii?Q?jMP3hofEBMR6vc8l58NJk8+xhGwtTfjcQC5LMGxQM3AP3DhTyGljCgCyfhqG?=
 =?us-ascii?Q?Y3UmIJLlTO+r9mXdCXRgBX87EO6yvaTX46wbbywjooIFcFh+mF2IYi8BfzB6?=
 =?us-ascii?Q?nqt+4EMnoOoPZaGyWglBzgYa2crIsw8ZYvflA5P1MRp+xRO+KsTsyXKwaGPL?=
 =?us-ascii?Q?Wlfl1RknYJZ7XPmz+x8fJ5inKRMw+CjXEH4o8MeGfcYtuUw7Oi8/QsLtZJbh?=
 =?us-ascii?Q?WHn4PI4Cb1XBYtkA3mYJbVQ6wMsM56u6CvIQVSKBFjc3EjBhBZZiVSMfEw9h?=
 =?us-ascii?Q?4ESYcci47OohRDB30cttqD6zb16gOm8wlLE2EYQhoakz5LKjiH5hrzitNriL?=
 =?us-ascii?Q?eFPtWXg+8Xkc0QYidcXQ8KJanWuwiBKdFynQpdG7ZoTzWfSqupvJGv3t6ZCl?=
 =?us-ascii?Q?+nbwtJEbBtVQR5XFQqlHVlvpgJY6POC/Pbt0d1W5VzMbnb54mS0TYn8BGV2e?=
 =?us-ascii?Q?6tNE5tPqnJS2hALokA/ckibZTyXxfaikp59GnIb1tOW04xbhKrAJ6Vdt/KmP?=
 =?us-ascii?Q?zVCGblrFD/9DDHUxwnapSyoVUK8jxJB+0vNa58w2UIEUeXuaEBDgIO/mMTp1?=
 =?us-ascii?Q?YcwveKYbP5zVhA8a3v2+S1Q3JRueuWy7hq5g0QlLUCNVwBZxkuSSI2lkoWDT?=
 =?us-ascii?Q?Dc+rYhQtlmxNV3RthJKTRKh7Xa7DLm0NQThqpj/C47/DYUig9TT2lC2RKo5K?=
 =?us-ascii?Q?gAANu6com7M/FxJueiY4T27w3AbN35N6GMgq+Q9PKKKiRMFsbhG04rtLi/Jg?=
 =?us-ascii?Q?HjRHRsfOSU629Qi4HX9b042X9/tCq973+wsNrU9nLqRvfvS51mN4EsZcMUh2?=
 =?us-ascii?Q?px4+HmEgVzSIe0+XqKI9A3WS1t8ioIUVDkxXZYHFsYcfkOMdAn7pQu0uxtkt?=
 =?us-ascii?Q?y0l3JuwveQhlSJ60m88biAXjhE9ZNbDWoCHXUmTIFNxLyUcLvpQLGUEsDe2d?=
 =?us-ascii?Q?MMq9ZkzEQQIUK9lqa880fTflm4hyK0cfXQocsHL6nP50IixfpVEkZqDoDIGB?=
 =?us-ascii?Q?RLjGPFfnIjKb1Gm+BDUX59k91o4r7l6yczSfa6LQCOCzj4cAHyUwoThXltfP?=
 =?us-ascii?Q?9b0TG6VEzhQwhmhsb+8ADiH70Jeu3pJpPtfFO8X3j69TICOoKAHa1xhntwmX?=
 =?us-ascii?Q?gEf6Cwp7ayynTZWaq1cOHn9qQAmC5MZ+zbp7+7ZDF2LcsX3B07LtdDV0Sx3W?=
 =?us-ascii?Q?/YALq1n4EA4ObqLiIc5seGyKxuKnBPLo1G2KMRubVU08+NtyET617YruSUBF?=
 =?us-ascii?Q?k578WlQXyjpy17opqaiGO4q4Q2tVUY3HDKYiFWp6oSC0HTnSOxJpBOJQtPQp?=
 =?us-ascii?Q?kSwv1DFmam2BgxD0AxW0RNG4qEqKSIRqNdh82cIFcA6AhVxcXp3LahccRv9j?=
 =?us-ascii?Q?uSmb9acGsF9/xTV+1Kx+Gl4THXFhB7UOzoFiIXo4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PDKZht0lg1ArAVABUVFUgKUspn/iMwDO20Og+IirTQZl82Oez6QMlFSpl1HvjTp9SAYFYxWOYsB0d+S6pZ6wHcPmavKS4YWQWjObY0wHI9HNb5Hyf3d595PSV3hE5xZQYYLsTyZ5LzRBxW2CdrQVCwzp40Gfegk5zSp61P8RUKvvHhQc1VntDn2A82hd0fqNUscwRoQkZwSRXfzDulIdGv1NuCsTDDTAM6NOT3Xw5wk9AchOSNXxAMnIVig8pjJbguWKSCtea/IRu2zIU9jPw5QJhZcFq/kLWMlaf2CSGvaVTPPC3pdYfQkq9DQQSc+qN6dIwE4Lhnr5GQWe6JQC8NtVfsCq708qPNOsfrwvowStlUkGxI96Z81M66L29rW0blUYfskNQkA/Fpa9sjWJYcXjfKt/n0zeGGRVCUGelh74hVUADadm1+HrscHpxrIGomLyK+G8kDm93/IdFW3ypTz4+lSvRJ40tmLsMnEraHWa2r0KZrvrZ50ke6NUT6jk4Pe96iVrAyTJuUSnOP/XQad7HJqteNFy8oY/jzhbe5XMTZeZgXnMzUdDQzD6G+syLao677pdrCcdpbWRai6JwhsDPPK9EKEnpsqBkgWBYA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abe7dc0-2399-4ffa-915d-08dd87723d0d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 23:04:48.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKSsi++Rkc+H4bBUxBK+iY4Bx+BrxmkbwT8ltIqbLZZcsY/DY0KRVmEhyCv2JNmqLohKuxCak2wgmw/nvQFOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=629 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290171
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68115b13 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=gKAaLPBbVuH3SKO-n2sA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: zdU-DTlFAaNVkT9nv4bVUSFJamY9kSs7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE3MSBTYWx0ZWRfX2j+nFOxCknM0 HSw+4pbkVBdoLbs0QO6e2ChR8D0NVo2+r0SA4BLhkbkb1ipq8C34qm0Ia2Y6PBMwYD/f6Ev71Qb hItI7zxOw9eva85uCrLOfB5hb5v7Vcb6mcFMS0B3gfcBGtky1iwCYFmL7pjqk1tzFwJAZlpF0Wo
 amK7Fmvjxi6na9oUuoNEeyOn2qhtkQVM8juOBgQLKQxWplGBs0bruOau6V+raN2ZN+qlCETwVFR gOSH+J4RfbWComPpKGEQOJZs3vkpRSXP2xSO2e7sLrsKcST4WQ7YXh3edReYV5f8wN2IVc/rBJj 8RD0HUVryhFg+GZw3gm2RcJosAYAmq+1LP3uL/2NV1rycvhG7POky6kXHk7idWwOplGBvURjkIP
 uYgxo6FP+pH4BCc9BxiYMEBlThVaBSWaCN9aD54hrfwfq0AYvFcEPJLVq0B2XnlpPwJdUw3x
X-Proofpoint-GUID: zdU-DTlFAaNVkT9nv4bVUSFJamY9kSs7

On Tue, Apr 29, 2025 at 06:08:41PM +0200, Alexander Gordeev wrote:
> apply_to_pte_range() enters the lazy MMU mode and then invokes
> kasan_populate_vmalloc_pte() callback on each page table walk
> iteration. However, the callback can go into sleep when trying
> to allocate a single page, e.g. if an architecutre disables
> preemption on lazy MMU mode enter.

Should we add a comment that pte_fn_t must not sleep in
apply_to_pte_range()?

> On s390 if make arch_enter_lazy_mmu_mode() -> preempt_enable()
> and arch_leave_lazy_mmu_mode() -> preempt_disable(), such crash
> occurs:
> 
>     [  553.332108] preempt_count: 1, expected: 0
>     [  553.332117] no locks held by multipathd/2116.
>     [  553.332128] CPU: 24 PID: 2116 Comm: multipathd Kdump: loaded Tainted:
>     [  553.332139] Hardware name: IBM 3931 A01 701 (LPAR)
>     [  553.332146] Call Trace:
>     [  553.332152]  [<00000000158de23a>] dump_stack_lvl+0xfa/0x150
>     [  553.332167]  [<0000000013e10d12>] __might_resched+0x57a/0x5e8
>     [  553.332178]  [<00000000144eb6c2>] __alloc_pages+0x2ba/0x7c0
>     [  553.332189]  [<00000000144d5cdc>] __get_free_pages+0x2c/0x88
>     [  553.332198]  [<00000000145663f6>] kasan_populate_vmalloc_pte+0x4e/0x110
>     [  553.332207]  [<000000001447625c>] apply_to_pte_range+0x164/0x3c8
>     [  553.332218]  [<000000001448125a>] apply_to_pmd_range+0xda/0x318
>     [  553.332226]  [<000000001448181c>] __apply_to_page_range+0x384/0x768
>     [  553.332233]  [<0000000014481c28>] apply_to_page_range+0x28/0x38
>     [  553.332241]  [<00000000145665da>] kasan_populate_vmalloc+0x82/0x98
>     [  553.332249]  [<00000000144c88d0>] alloc_vmap_area+0x590/0x1c90
>     [  553.332257]  [<00000000144ca108>] __get_vm_area_node.constprop.0+0x138/0x260
>     [  553.332265]  [<00000000144d17fc>] __vmalloc_node_range+0x134/0x360
>     [  553.332274]  [<0000000013d5dbf2>] alloc_thread_stack_node+0x112/0x378
>     [  553.332284]  [<0000000013d62726>] dup_task_struct+0x66/0x430
>     [  553.332293]  [<0000000013d63962>] copy_process+0x432/0x4b80
>     [  553.332302]  [<0000000013d68300>] kernel_clone+0xf0/0x7d0
>     [  553.332311]  [<0000000013d68bd6>] __do_sys_clone+0xae/0xc8
>     [  553.332400]  [<0000000013d68dee>] __s390x_sys_clone+0xd6/0x118
>     [  553.332410]  [<0000000013c9d34c>] do_syscall+0x22c/0x328
>     [  553.332419]  [<00000000158e7366>] __do_syscall+0xce/0xf0
>     [  553.332428]  [<0000000015913260>] system_call+0x70/0x98
> 
> Instead of allocating single pages per-PTE, bulk-allocate the
> shadow memory prior to applying kasan_populate_vmalloc_pte()
> callback on a page range.
>
> Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: stable@vger.kernel.org
> Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/kasan/shadow.c | 65 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 88d1c9dcb507..ea9a06715a81 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -292,30 +292,65 @@ void __init __weak kasan_populate_early_vm_area_shadow(void *start,
>  {
>  }
>  
> +struct vmalloc_populate_data {
> +	unsigned long start;
> +	struct page **pages;
> +};
> +
>  static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> -				      void *unused)
> +				      void *_data)
>  {
> -	unsigned long page;
> +	struct vmalloc_populate_data *data = _data;
> +	struct page *page;
> +	unsigned long pfn;
>  	pte_t pte;
>  
>  	if (likely(!pte_none(ptep_get(ptep))))
>  		return 0;
>  
> -	page = __get_free_page(GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> -
> -	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
> -	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
> +	page = data->pages[PFN_DOWN(addr - data->start)];
> +	pfn = page_to_pfn(page);
> +	__memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
> +	pte = pfn_pte(pfn, PAGE_KERNEL);
>  
>  	spin_lock(&init_mm.page_table_lock);
> -	if (likely(pte_none(ptep_get(ptep)))) {
> +	if (likely(pte_none(ptep_get(ptep))))
>  		set_pte_at(&init_mm, addr, ptep, pte);
> -		page = 0;

With this patch, now if the pte is already set, the page is leaked?

Should we set data->pages[PFN_DOWN(addr - data->start)] = NULL 
and free non-null elements later in __kasan_populate_vmalloc()?

> -	}
>  	spin_unlock(&init_mm.page_table_lock);
> -	if (page)
> -		free_page(page);
> +
> +	return 0;
> +}
> +
> +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> +{
> +	unsigned long nr_pages, nr_total = PFN_UP(end - start);
> +	struct vmalloc_populate_data data;
> +	int ret;
> +
> +	data.pages = (struct page **)__get_free_page(GFP_KERNEL);
> +	if (!data.pages)
> +		return -ENOMEM;
> +
> +	while (nr_total) {
> +		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> +		__memset(data.pages, 0, nr_pages * sizeof(data.pages[0]));
> +		if (nr_pages != alloc_pages_bulk(GFP_KERNEL, nr_pages, data.pages)) {

When the return value of alloc_pages_bulk() is less than nr_pages,
you still need to free pages in the array unless nr_pages is zero.

> +			free_page((unsigned long)data.pages);
> +			return -ENOMEM;
> +		}
> +
> +		data.start = start;
> +		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
> +					  kasan_populate_vmalloc_pte, &data);
> +		if (ret)
> +			return ret;
> +
> +		start += nr_pages * PAGE_SIZE;
> +		nr_total -= nr_pages;
> +	}
> +
> +	free_page((unsigned long)data.pages);
> +
>  	return 0;
>  }
>  
> @@ -348,9 +383,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>  	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
>  	shadow_end = PAGE_ALIGN(shadow_end);
>  
> -	ret = apply_to_page_range(&init_mm, shadow_start,
> -				  shadow_end - shadow_start,
> -				  kasan_populate_vmalloc_pte, NULL);
> +	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.45.2
> 
> 

-- 
Cheers,
Harry / Hyeonggon
