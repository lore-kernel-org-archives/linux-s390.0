Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CB11712;
	Tue, 13 May 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096240; cv=fail; b=h2EI/UpKC9+fC6l0wpqUZrigj3MQWr1Upl0usMg7+enqhGWMRXzpXvc+ULntf7j8475dYItbi/eddIUkfF3aAk8IT376WP6SF9UqYf83aR+XCqhTk5IfhaBIcbYgZOyfNUvZhL7A8xl0B4X+vpx1d04Ivsur1+0lS0zMJN1vJ5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096240; c=relaxed/simple;
	bh=pxy8t+BAr07m6t53LLFGyBulGgOqn8yg9GRPRFwibeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bb6Z+KIKyQOlImgC1u2svqzuFJTtEqqQGA/m3xtQbEfgyOE61/vZbhjCOPM4F1VxQTdA1zeDG92tOsrBQ6TXgS9SfMM/uwhSZDAAIu0xr2YHkGphJKgPNTCFzrw3Wb044iR7IQUlq9kjlLO39SRRMpUxStdt7438g/rnf57QEnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AlgujIEc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K3Zj6Z58; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AlgujIEc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K3Zj6Z58"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CK6sT8017916;
	Tue, 13 May 2025 00:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5nu07v2jjWQnv6aeX9
	byVkSi85cE+spiyMYRTa5kogQ=; b=AlgujIEcaAXpekYvKtc2dBEXmzvJHBRQVZ
	9m3CGrPRGeY0u77LD8kRfFgEQBkrwX/l6H5FVq5RV8O6qjtlA1IGdeE0UG4v8iem
	tCoimqUDxMbZwgeYdMtp9F//U+lAiZma6dfSfX6dFKWTSpgN0a0JYLWthrPOuWNA
	H9NyUgtp86dzgw/F93h6gLblZFlDTSEcesr5IHE31FQrVtoc134MYb1I2M5ZdANO
	azXZMLMBGNvHvzT4Alo3BTNjUjQFITJ7Lp3KMhNvn1wCaFucjOPT2TEmWIGbMtlW
	87FeFC+Ko/H2R+QHFHg7mohZc5hcFZnQWwWBI/MxHk4llmcxnNEw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1663r4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 00:30:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D0G1JU001944;
	Tue, 13 May 2025 00:30:20 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8ehx82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 00:30:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C71fVK36xILMr6lsnW0ANkqR6wLxCLnLWqR12U7SRYGAr4KxK2elU+v7JsjdyYr64yrZ070Z8t8VbbT4CEqtO7fSwMWwNfXXYzSAOllDggm9/4FpeKNYrCPK9fKUJEhEUhizjQDGVAbDzC7sSbCEXLF2XFYwkVqrvgBTCGnwkWdqy9NiwFBbhYdEDX856PXa9GRi3N6+qD01IPPQXraeLBPtq9XCQgEMUiXPAO/YpcFDDfQDT6zGevqGF07W7FFszPi2qlDoyBU9Qk7YNQ/kuP6/zXPwFWrRTcuRSBMLVJkThp1h6hIeDy4whJnVk/VILaMBU3giSIw7zjw6REt4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nu07v2jjWQnv6aeX9byVkSi85cE+spiyMYRTa5kogQ=;
 b=etvA/EJa+S4O7vgS5P2XzbQ1bPG4a333MoP+5AXRcVhkYgL5DxcX/lVs1lOB49lZBvbMcuhtcCS0+0z3Hbl2ABmj6RPKmK3Y98/voghXZc/JxxtfdUPjIrL6SFkg4N4wVHKjvuPQuu4rs+1y2c7/51zy0ZwTePxJFd5Afb0VqQ76sIekFzuLwOUNLTQVePaYSAeM1C26zEwB1hjQhqp6Bkm2vR5isoz65SnwNQcpW9HHHWvpuB8UIbgrhWQTXfdkd46in9ZONq6Xo/8k9VUP6zKyzxhiTEH4lY8XgIvDFkNVPCtIpwNTlPnzN140KkhyO7rcAjOtQQ5IBcJiZ6pnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nu07v2jjWQnv6aeX9byVkSi85cE+spiyMYRTa5kogQ=;
 b=K3Zj6Z58M4nIFXOO1IHe0y4QKv5h+F6gcutHeuchvyr4Kn/aKkPDe0Ofp12ja698+o0/WZcykBPnVsFh+ZJj6LtHsO/eYSkFdRtHnSh4UfK3lWD99pxFvgEf3z8uvsvkRbWYpH/uHHaeKMzVfe9fyfAP6yjcWjGW5+BoaKKiX1k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8399.namprd10.prod.outlook.com (2603:10b6:208:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 13 May
 2025 00:30:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 00:30:16 +0000
Date: Tue, 13 May 2025 09:30:06 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aCKSjnQdzaRvgZzo@harry>
References: <cover.1747059374.git.agordeev@linux.ibm.com>
 <c8eeeb146382bcadabce5b5dcf92e6176ba4fb04.1747059374.git.agordeev@linux.ibm.com>
 <aCIUz3_9WoSFH9Hp@harry>
 <aCIiYgeQcvO+VQzy@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCIiYgeQcvO+VQzy@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-ClientProxiedBy: SEWP216CA0037.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8399:EE_
X-MS-Office365-Filtering-Correlation-Id: b40bc458-72e2-4a94-ef96-08dd91b554dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?csw1Z1mAJLWdzja6AJ/wlyZ9jU16v/L7OHVYoInHs/n6nivfgZydqQm1glBr?=
 =?us-ascii?Q?RusjEtCoAmJRJ5kB+4dndRyf+Q+V4+Ywrs2L5h+O740tZntCF2Vi2yXHw0tz?=
 =?us-ascii?Q?sUCIcgep8hLX03JsrF7RF2XObc7qoB/yVVBMwJX0orlUiAEmKKcxmHOc9z8K?=
 =?us-ascii?Q?mTzfnLTknN8iw7bSD/tep67JmPpctOro7fHpVv7V1o3v3qogTvzR1sR1m3F3?=
 =?us-ascii?Q?KLQa8AbB/AZx04HUyQBQd7Ni/WwSZYPlUOTQdSurKd2JOpqM8W0+CpQu+vzF?=
 =?us-ascii?Q?N/UTeho4wO3NQXoKWeDvbNsngP75CeIg2/jPDTeeWB3OOrRn9YyZYpsU3RIE?=
 =?us-ascii?Q?td9IGM9ZtNd0lNC6kCbK0QMOdhU/U3wABBhNQk3vsoq5n2o0/6Hr5a1on/nF?=
 =?us-ascii?Q?mL3lxqkNIQtKbsHf+FjjXVokhRBXVNtAqrwK5LikwnrUZJzCi8W9D8RDqyYg?=
 =?us-ascii?Q?NgK+m4GrRRouCKZE1EjnrG030avCYfQm/FmWHFMGhJasqsZLkW3NFqoIYVrE?=
 =?us-ascii?Q?zPQyirMzXt5YOw6da+0WqV6qamVmHSSJ+Riu3tBLxksGpBe9jvqNzUCXAp4s?=
 =?us-ascii?Q?VeMcuAVadZori6nxdEdL76RQCib6GD0STqSIdZ2l47nWXZ/dFGH8QufnXArU?=
 =?us-ascii?Q?Q/jXVHf51W2QKknNdKXvvDDjaiousafkRRKj8keh/v49x4mY8fDpqWpI20DE?=
 =?us-ascii?Q?9rU/EyJDSkD7bvb1K2Jx8p6+XAeN4IggRz9+7YpBRK02Dnsmjk+e0MLcGi1+?=
 =?us-ascii?Q?NA97fYpO0mP0nJ8yCGMhd1AstF2093Q/r8D5JpkBi5uO2N4HIQI8lzggmqfj?=
 =?us-ascii?Q?fmLx88+rrN3ANGSxEvhAIAuvp4IwKCkhxGf8QCeQY86V9lg2ma8ZSarIbAZT?=
 =?us-ascii?Q?r01Nt2mwNFZFtHDadedemCZWzPdGTR3OpBMhGjLDt3tzb/c9KKk5t9NjP+kN?=
 =?us-ascii?Q?g6bw4i8EBtCb4DLphwXS1IE+C42SfODGwZVsKK+OUw+DOiOfJOQrfGcWWB6S?=
 =?us-ascii?Q?narUzlTnSQ+bhVa87437DI5ygAR1h9GJXIGOgzESQuGri2d11OlgpKdOH960?=
 =?us-ascii?Q?NU5Ch+U2pA/VsGcCfee8peLdhonz1TnE1/rN8/pPfC1vpOfVvOymkOndO53l?=
 =?us-ascii?Q?LFhTWTdYMk3ELH+rQfih4IZdcnHi7CvfYj3UvXsNZRqHFrIx9z9OMPoHlJmp?=
 =?us-ascii?Q?Z4SiyJOcIWx75mUO/jZ4spPQTaPmOLRXXYNQEuIByIaLfEXEwga6lUj1/zwQ?=
 =?us-ascii?Q?lc8f7xHFY5Tu6CWMUX9bytlL4oGq15XxCIpT66v+0i5ey252XeM5eyhwiit9?=
 =?us-ascii?Q?JR9q6kN/wrMufaueZwjSJxXdq07fbFkhRcUYQOXDUMvObDb2ri9eIG8Raq1T?=
 =?us-ascii?Q?TK15tSh+ydH2yKhwfdCxWC1K+TjWAnzITDeySBJUNTeQARIFFFVrewupgneg?=
 =?us-ascii?Q?AlzWxI6fglg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vToVpjLPi/ZZ3ezgEblZRifR2HbCwvLndUBFP7obsgP2ojoUHmeqWotbesc6?=
 =?us-ascii?Q?+M25DJBI6wV0DSr0St0CRejZ1LThyLUcaZtBvenrrtvd/SvK5laSNDmcaYy8?=
 =?us-ascii?Q?RNS3oRsSmNSCC/RahTGr8nNZEuCl0/UssS6mdlW0v+nUKAwtsE4eQ9KXiK9l?=
 =?us-ascii?Q?PbIF48QrAF4PFlCdYVznIUaEsU72GGHTUs7dJkcMyRBQbt8alK64jxns1A16?=
 =?us-ascii?Q?LvB7o2ItTD+RaF38D6w2oCRLltFg1lqNJ6Y3wYQ3V/k1/M8OPwresNUWrhFB?=
 =?us-ascii?Q?9vVwpjP027OGY/b9tb1CP1uOE9+i8RaRkNq6xl2XjiDHYgrtDQ/VI6fH2rdo?=
 =?us-ascii?Q?FWL+1Idld2e6eJiQKz99nv774uSrTZpOoI960PAGrA37Xmn64Ui+eIsjF/Ql?=
 =?us-ascii?Q?A3qJ/dJPQtPoonmpdYVMXIkekUN0Vqfbb+yrAe4w3uWE5aNkRpxsvi1UdEb3?=
 =?us-ascii?Q?BLB4mfK4fhxq+F+3s1f4X0JL2108NZ8iSG4lMnWXR8NwZv1bV9g2P4oQZ0Dy?=
 =?us-ascii?Q?WpRDpZ/vN4WM/GQYYYQblY6h8g0xK5OSXAk+xTgzU9TXR5oxtRps5r7XrAwX?=
 =?us-ascii?Q?58hvVf7sg9Ub/nofIskJKuCzHsH40bZHES+BoFSuLFegAzmhCBXLvpHqX9w4?=
 =?us-ascii?Q?Y9it/UUXbmydcT2TkfBmgTnaniwgLcBDXbTrjv/tQxP3UzUHRK436s2gq3eR?=
 =?us-ascii?Q?mk00p2r4NfL/O+RSIYfDFEuLD+QPKVaCFLMnNB0owyv+geylWDnes97Y8FKb?=
 =?us-ascii?Q?mEa3HqM2VEl0bygg9Hjg9CjmgIi2j/K3MhMA2esGZkhXk8snFRDM48p9Jk+C?=
 =?us-ascii?Q?yyx2fLMc9Dkf11jAfMot+m34fUZSDRe/HjtZ5gBOhV0y6jeW78A/CNOIYief?=
 =?us-ascii?Q?TXzSwQH/VvOPhudE+9wXzhIGAqDly7WWSd/PMnwY+ogoXX4W+pyMSe6hHczY?=
 =?us-ascii?Q?RPEsXxCtLB2JpCfffy6hLF9hKvNZEmWCIOXxPrL2yhlUbYkDsoKYzN19qRYZ?=
 =?us-ascii?Q?JRgSBf3l6o1tE8Cxfz8El9nPuyAy7yQAFZeb0F7YCwXSddOkrzjbSlS8rk2V?=
 =?us-ascii?Q?jd0yLn5upocfsq9AjPmhe+8I4oiptzmmWpVW1RUd2kox6tmHLk4UMtXRWlNU?=
 =?us-ascii?Q?iJNnR68/r7LKSAANCgOC1Hew3JOXsyjoFmCeBx0n0WMX2J7EQLkfanxiFyp7?=
 =?us-ascii?Q?kR7Cq//F0iJf8/sBaPCarOqjNu7SPz0+DIdnKk52Af5rK6XfFKmWRvl4y9EL?=
 =?us-ascii?Q?rFNPQ3BxOaFioDYMMQvwgMzeOQoCrYmGP2kObJsiU8kSEJX095Ti1W26iJSs?=
 =?us-ascii?Q?4Isb0mUQlIf2+pugKEcgLYfRBCrI6phyUrTKdKDOFwQN6AZljmJqVhdp9g8/?=
 =?us-ascii?Q?8Z3/a4Gh9Mn8/4QhAAFa6w7lL8C9/XewYIVU65KwXajWSX6Y17rCzbNSH66Y?=
 =?us-ascii?Q?ItSQOJbk3bYT/i8luGVgxMd//OlF+aTU4ZYHmYRNcfh9ollZH+BK9wpcOGf5?=
 =?us-ascii?Q?7ozh2L135Vrme68YqcV56GjGoS7gr6yETNAdUBO7LD74nNUKSrsk1ClbU+GL?=
 =?us-ascii?Q?aDj1apxfduRpAg8S7lZW5YwTvs5tycc3Rt8sdXDc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	liQihTcW3Sd2J5+X81Z6/Y8FtttGzDkvtYrC4Tzbl0Pir05D9z+GjucVUOfb2RsbE4CsIuS5ncG1SSrbo5BjP1U5bjRwjlU61AUTyKLooxppEIkZHRWlqWmFZje+MRmZTSi9z96yMWkQwVHFbUPtCm/ln518SH/pkcbLNztaaiUMxh1GSskwTktCGefLnuMU4JDPGSFcGmxSfMCB5mlhUvN8pONvW7bFm+G5PaePQDVpJyTqYiZ6vPDXZf+G+593W9vnpOCdaEuqeJ8+9rSoeyqIgJF+h3yWQ7Uig107jmeqVW/riPNGgXnqULnBnVeYW844DChbiD/bP7ojHYxgB/FB+xYU08ji57eUqpiu6RM/aKUZXkWn7+fdFXIkn1tgf+Vw51sDcws/t+Ru+4N3T6UyZ1Oloo/WXM7scKnLimwLNxK2od6w/rRdWChIBoBaKwWcMdPTR0aw2OWgs8Nmcr56d+eKIw/QIlUVp1Kh6kXyVfG5HXvVnthyMn4Zu0Dv5wNwA6hURGN5epon9H2GSVpf2Kpdkj0QoOaDT9dzwm5dvEWAsrU3Snc3YrI4+h7tqTxFQxzPuLmWyw/rI5KAB6WSpQg3Nd/bz3O/rsdpFBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40bc458-72e2-4a94-ef96-08dd91b554dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 00:30:15.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM3/QBdYXajUSVPpw+xxEdmnI48kzN6fIQndvQDxwpjG+dG54nalPg7Omh/7oo6Q45i0lG6+Z25VEx6PykMwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=982 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDAwMiBTYWx0ZWRfX94dcU3WzLesK shlTeLyWydrDvwXsN0y6s/TplCck09iqfU7X2PUGi9YMepqS3qgt3wU+WyhXL912VlipMYx+vG2 vhWliWO1OVnu7TSx37r02NBanpYwF84CopsrLxzySh0HU6XlvJShgWyzvej4DEwI5nOQK7QqLqy
 jxdFskDIPvEHt8C4NNh3Bba062AKUZk0PwTpiiKpbkPd3fpQxiTC5FqFKGu2z55Rj37QjYOOpS/ CbmnfZQf6xtiMvcVRVDywjgvDkzzUFFpAzmC4PE5tZD9SQtDVdPxxEGmxIHsIxFLTzVBkowQZFn r/olV3dZIx1Sq34AUOuwBAoWQWUZX3dW3EgS+gf9xUmDnnzMzNuMFApq10MMeLw/qC1sFpJaI7G
 fWbE20jeJdmhY8AtH4S9OOwOx7YI4leG0nrTUteQdZXrjdtCs3g132Xy9G8NCkuOVHyViKPx
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=6822929d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=8spYyqAcjxGn2WIhPwQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: H3z0oSeVPG_fqM_8cuaS6SmfrBW9R4ek
X-Proofpoint-GUID: H3z0oSeVPG_fqM_8cuaS6SmfrBW9R4ek

On Mon, May 12, 2025 at 06:31:30PM +0200, Alexander Gordeev wrote:
> On Tue, May 13, 2025 at 12:33:35AM +0900, Harry Yoo wrote:
> > Thanks for the update, but I don't think nr_populated is sufficient
> > here. If nr_populated in the last iteration is smaller than its value
> > in any previous iteration, it could lead to a memory leak.
> > 
> > That's why I suggested (PAGE_SIZE / sizeof(data.pages[0])).
> > ...but on second thought maybe touching the whole array is not
> > efficient either.
> 
> Yes, I did not like it and wanted to limit the number of pages,
> but did not realize that using nr_populated still could produce
> leaks. In addition I could simply do:
> 
> 	max_populted = max(max_populted, nr_populated);
> 	...
> 	free_pages_bulk(data.pages, max_populated);

Yeah that could work, but given that it already confused you,
I think we should focus on fixing the bug and defer further
improvements later, since it will be backported to -stable.

> > If this ends up making things complicated probably we should just
> > merge v6 instead (v6 looks good)? micro-optimizing vmalloc shadow memory
> > population doesn't seem worth it if it comes at the cost of complexity :)
> 
> v6 is okay, except that in v7 I use break instead of return:
> 
> 	ret = apply_to_page_range(...);
> 	if (ret)
> 		break;
> 
> and as result can call the final:
> 
> 	free_page((unsigned long)data.pages);

Uh, I didn't realize that while reviewing.

I think at this stage (-rc6) Andrew will prefer a fixup patch on top of
v6. I think this [1] could fix it, but could you please verify it's
correct and send a fixup patch (as a reply to v6)?

[1] https://lore.kernel.org/mm-commits/aCKJYHPL_3xAewUB@hyeyoo

-- 
Cheers,
Harry / Hyeonggon
