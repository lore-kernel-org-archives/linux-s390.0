Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23A17AE1D;
	Mon,  1 Sep 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738029; cv=fail; b=NBVldVj4dNW3bZ//mXIegUJX3jxrLr4+Jgnu0TmuOtY3+M6c0QXwwiNig/v2eLt0rvMdLUjnRJLOxfJmJJ0w+d39YnFG0Uu7MQmrPUfGdrMxz88ffQmgJzQxSpW38nwd1qeOMGn6cTIYhmcjYRw6EFfBGSfwCiWiOIqII9NUkio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738029; c=relaxed/simple;
	bh=9Mq8h5tcXgHiV7+l4VvElMoCtj65+p66/zV56bxVOn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=psgaI0+sZvcw7ecDHGv+T2PJuHihzy821wpRXb3lynzVQA0zpumaWWPRVS37yIQybjhR+LK2s7/xX+r4m6eDNn3K7DCxMr7BRciV1URDdJyK10M0oLf2N804f9KBJ9SSydFgL+x+nFrER78IzQcXaDxns5lk/jz3M8ZRzzs+W9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ed40cCKR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iEXNjS71; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ed40cCKR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iEXNjS71"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815g1p2024373;
	Mon, 1 Sep 2025 14:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iPALIOwqRYcL15LMLG
	qQ1jKOOevSPrMtzBoWSGbh7ZE=; b=ed40cCKRWgBJ+1HJ+qJbmuBpftOYWqr57e
	SLdEAqFrDRgSlEp+DeKBjrT9b6dcr1CwdmIMt8k5lo+O+UFkl9OVq25VDZIabK32
	KAGOqjKp347xLRyBwH7CjOEMJV5kwC9XxxZyvOgGS5vkoXXmDZ5l0/Qofx+U6qwL
	nfeEAbg0fAORgmUEFxAa7pubxKWPRprTXWYrR70bXaaH7KRp4F9Yo+67cuqQ9+36
	wP/PBLVFbIimzDln0y2U0fbYIv3RzYiSVbd5FxQYvGTlOee1ugmT7Tjsl6MeBgoB
	MZBZnpSVhLNyk6Y+5wIm8TnDLX8GgDdGzon3R5QeyFbxBw+Mz8Sw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4j257-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:46:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581D2sYG024963;
	Mon, 1 Sep 2025 14:46:09 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr7xupw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:46:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPaeyOz/vkFHvBmHilRd7XwXNQnIogOMpaoLovH1CR+LYRxBgfaWf2F0kdo6HTPHV3KQJS18l5kaf1JC8AHkWrj+S0QcXyJye+8Uz2vD1pKaRVO6pOC646uteEF8dFo3GuuT3yROvbrOQ21n0jb32//g5euovHXCXXfHtOpVAlwd+tQKEZj2m1rPOycof+4RdLhZBpDCkCIpR9gxzGOz5tO4vLDtzZENYJ8I+XLd2wLo3iNkBVJapp5EqYApbFK2kktqCvkwLT7//PhqNU+eBdmEwNyYLdNrRv9CGTGdHbW2OorT4eQqR77kcn5L+HpnYg5ycWfUi+fpwb1XpyPTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPALIOwqRYcL15LMLGqQ1jKOOevSPrMtzBoWSGbh7ZE=;
 b=UQZwsyC0jYcTmDk+aNUGe+x+DReHOapG+o+Ro1oZqMxdsEzv9MCac7zsRmr0HUByk6OTgW+iuNXTtGph8K4/C+KXHmPYyvTLw4g4TL9oo7+Dd6m/nat6k4T2pdo2baazmsVP2IG+1Rj6UOuLZqp0iuy7IkLh6xkatjjTAPDuZlKwtBN9KtEeKIs9nj9kzxSFFODHiPag0abtMM1U0P7qlqsTEUHjc4H3xqfOeW4WHR8yEyvenY3T2F0PYj/RzsKffNOsRvPwcBE6XReOJ7JhJhVBbl2qtHcp7leCz833DcjAIXHEonMVBS5CgkL6DRgqYRC/zSPyrMhRmuNYjjqJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPALIOwqRYcL15LMLGqQ1jKOOevSPrMtzBoWSGbh7ZE=;
 b=iEXNjS71FBEIeK71a63eLGx2h1EXdKW+s4/3NIvp/jhLjLoBtL1I4n2PVcpkXRhPVrK/2O0MrHAENeHQzwEDrIUcPv4mGHV/yGvGrEvDEyq1uJt1C1iNu9qefg7epfrUlrMZQASiXUs5+xRWu+I9JHWjBDNzlyYj3oni2TgbPkE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA4PR10MB8709.namprd10.prod.outlook.com (2603:10b6:208:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 1 Sep
 2025 14:46:05 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:46:04 +0000
Date: Mon, 1 Sep 2025 15:46:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 05/12] mm: constify process_shares_mm() for improved
 const-correctness
Message-ID: <7bc9e9c5-369e-4049-a4b2-e3a0a3d9b58c@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-6-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-6-max.kellermann@ionos.com>
X-ClientProxiedBy: GV3P280CA0071.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::6)
 To BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d68fe7-1299-4a0d-9396-08dde96646b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTAFOFxV/HwjlyIDq+n0zRFWnafqdjrTLNHuoR1sbUMH+EE6SAo6PEtlrlT/?=
 =?us-ascii?Q?TDgu4IA+54FV1jekRxP9PsGZjNwhhjECXZveiCEB/kU/bK/W/xAl6ry8AnMZ?=
 =?us-ascii?Q?JvihTqzXLeHYkOIxoRLfL4MaBbiWO9wzue1YMQy0S+XnTMFEh3YJVFRecL3B?=
 =?us-ascii?Q?oy4HNo0JSaI2XGGpJT2MMCkoTnWuvhZtTEquzJPmYMYGTLBuCxNOJ7gLAprk?=
 =?us-ascii?Q?9CAYNxPKwMyx1UAHMYmpJjRFZjcEYDC9kQwR0t1kJ9rLYKVrEKHqisoiP54o?=
 =?us-ascii?Q?tHRQbGypDQAv2F/4sc6sdr6hUB0ZiQGhWgKKf5dl/hkoQ/0Rx+dJUcg/nbRD?=
 =?us-ascii?Q?RVrLQy3MIaszfLm/DS77dkXOZDqIS/SjMcYYhKbLAPHHu9pnuoYWEuAyjiZ0?=
 =?us-ascii?Q?TO4+jEjSCmZbrTctaIehgqyQzjKz/Q+GAVsqRPIKjVIfa37FYas9Q10V4lNd?=
 =?us-ascii?Q?Eb45v+Q9KNw1F9oyPwOBrFitCbU/k1I9qA+c7KCZNFRsR2zYoPlKoWND6RvB?=
 =?us-ascii?Q?TFepovUlYspj8AHl2s9eF6KvglLNke7RIcy5Yzmkh2f1t5ygxDNJNCQjVErx?=
 =?us-ascii?Q?bSClnN44iBk/OW7kyFiDbF4w0UdnjeTWXTxb4oDT6umO/xpkCdePvmyb4spU?=
 =?us-ascii?Q?MJNNvOCjakuja4jryrRwhzzG5zrJT3DOiusYBmPFAsFodv8kEXXsaqc1K9yY?=
 =?us-ascii?Q?pmgP2nFEciNc8TTWcpoanvl97oBbATI1CSR3+CQpaCgRv/qYblo8dXSy855p?=
 =?us-ascii?Q?9AGRgck24jH1XJ9nLc1EMDUFLvZhOAS1FNLRO3LQOcSeKgzDFVOFBhsnm3w7?=
 =?us-ascii?Q?VCnV9A85RhsesYSgR45/LlxYwEjZv1kOpq1bm2Eph7do6rFZK6OBj+MhEudT?=
 =?us-ascii?Q?nJnLYnn4V4aoZqWhGcukonuaxzyKnmIj5eq49V1pJFVbXujpYFwxoiaGTHeC?=
 =?us-ascii?Q?03TA8Xze8gxAJcRGum6cpRjlblxg+VozJq4O8cdLpmxWs570rjZ7l/EFFMc6?=
 =?us-ascii?Q?5t41//0jIQhRzFTJ1HdPt93RRbdbxdchFBx8kAg6f9P/m1uLvpV25USutUMh?=
 =?us-ascii?Q?lsmfJXHGtVfX4u5kE9kws1zefAoXkO+3yu5GgG3fehY8QBt9G1UKjsBEaRNL?=
 =?us-ascii?Q?ctC960GjFXPhybiJPAsZs9qZZYsUTBkxSMFJYbCm/QbKJ4BGI31cifl7I7ft?=
 =?us-ascii?Q?lXVCZ7bAyzE/Ke9IGp52RQURv3wAlQmhuQal3sOMUdBcLwIf5UUENf23DIH/?=
 =?us-ascii?Q?37n2WVDjmIOAi5hjV4fVYVvuL6FVQNiqEIz9bRVN28E3VUdeelzBte2M7nsx?=
 =?us-ascii?Q?QCGHqVBjAQMe+Nq0EyToE4bzd3TRzpyK6iQLcKZEvxDfHBQXNEssq17W9vFE?=
 =?us-ascii?Q?QOjhCv7ILVs7sL15P51K3GCpCKcTYlVuYSk/7tLE2PsF/G7vuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xe/JK4vCkIEnXCecVb4nLdYeKJuxzoy1m3DBbPQTonJcxIP723ISj6ippul2?=
 =?us-ascii?Q?WH1aOHZefIwkduDbA1zleJJCKXMnEdWym/FE/XkcMxFWZDkp/BUXqZkIysOR?=
 =?us-ascii?Q?t7ue6Y09kNqZCOLGCXvlTyawquZahH+HynB+PN9V0MTySzE6FPFHk8X37WX/?=
 =?us-ascii?Q?1ynY3shjTgnmkowuLtDb1ZcQFpuTzkySDzb4WD1OMJjJQVEOiIAnBP5Mrl+o?=
 =?us-ascii?Q?hBM+KpkUJXiMulf079e5F4s85QOi2rAS301ZCJrx5BGq5Z+Bg2/+8dDhDCQ7?=
 =?us-ascii?Q?5WrbMp6Pm8rvf24BY2+1bhPw5kf9EI+3Q4ePKlx9w7PIN2wgtO+/MMOpmKvm?=
 =?us-ascii?Q?BsiPww8RDkSdUXKiRlIaUHIgiC20x4+K/707vD5HDqbf5+roJWef2ZySwkyZ?=
 =?us-ascii?Q?ZhZtlPHuMnm8BVAH07W3HuA8GRl0Qlq0dU68KK+7xBW/KbLGN5V8V2PKw5wS?=
 =?us-ascii?Q?m1dJgU9vQ3bOkjO+vS5hDfqazDkRkak/TcKk8CQiCI6f2STnVEm6C39M1mkS?=
 =?us-ascii?Q?WH7z7Q0yVbGrWvwcZs/athWLONCK0Fy72sHhO8aSarg4cp3i2DRU40hkN2WE?=
 =?us-ascii?Q?C1tpRr8DyaGdXrqmWmjFWQU7Keh+ZS9X7GTcZ7ZdeV/XaVOSTWHLaipwoFKN?=
 =?us-ascii?Q?clbtr/YbrzmsJobPSJDSN5c+wx6OjnZYz5S6GSKxRmvtDJEdn4sa7neFStOc?=
 =?us-ascii?Q?LtZAhLDwhgLyOrSb0ND1+t0xLlLtQeIXF5TgyajIkE0kN/kp1x1nXybGh7lM?=
 =?us-ascii?Q?AjzZwuy+4JuUkQMDJsk6KfmlM6VA+B/UM2HHCYWAAghe07kp164T4UOYRRn1?=
 =?us-ascii?Q?wKuXjZgqqjkoNmIxrHK5bQaBf4Rb0OGztLptTVHo6QmLcLQA0ThsJNE7HQlk?=
 =?us-ascii?Q?jW38453Jc8wQEL9GTNZbPN6PYKRraDO3dyhpBHA60DImFoTD/w+s+rVIZt7b?=
 =?us-ascii?Q?P2UKE+8jNpqUtBL3mU6QXNAGER8LyvKEUO6NkciWwuWKGTl0xoSl/gPXq24b?=
 =?us-ascii?Q?Ol3qJgxuGhb5uU72lOTcsK+Ljs7BdQhOHUA5NXgim9J0T4HPfV6ZWdBtg0tn?=
 =?us-ascii?Q?iUz2ymqen+w4Ut2Elu5wLjW1XhetC9cCAyR3ZlFuD/2rnhAnLghXqPsGOs0N?=
 =?us-ascii?Q?oL47YLe+M4ywQi6nQWh/cCNdwFh/Vl2l4OoErgtXkgI2uH76siRd5319KGhP?=
 =?us-ascii?Q?0bxPQWyKYwjYXSylrZsskh23MWFKCcQIpY3+N7/roQCrNw0k0v1RrKciRaUi?=
 =?us-ascii?Q?/JJGFwwZF2K57rcfkcrGMpfmLM3TLSi3gs5XTQTP5v+4inXuuASs4jPhc0eR?=
 =?us-ascii?Q?f8VHDA4GNKKyuH3Z17rccepKa+KZ/a2B18RzKPTyxHF4UiR8pf3CIUQUK9ra?=
 =?us-ascii?Q?ZhJvWCdHbzEkI7OuJTRGSuB5aYq3cWC0Akxbzso0TikKFj8uky88Afw3AUr7?=
 =?us-ascii?Q?cYH27fB5xXP7g92/V5MSiT9McPw5zTCm7wG8yIJP0upAAI+5pHPwwLBDPOpk?=
 =?us-ascii?Q?eNjjjKqqDSIlAdv1dOJVAVorcKynJtkv/Mf8CJC/rgY878WplzVEQsT96Cwf?=
 =?us-ascii?Q?TGZpVgXNk6MkGmOf34Xy8k4upfpQEJ5vIXyxd/0Fy/xFEsDmeWpR2aMv2Cr6?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	igt0x8q3xhQq/zIFm815KOQZYzd2SCw2pChPZEsWNEtgQwJSfvaifjNsrgYrvLwKEm8LMFHHQtXQxgzd7t24GoKYuXvxIBXSO2P1F7VTDrwN0is7UwHN1QdRO55R3jj4iIfOVhHrEXALK5+quXW5dRcFcl2jRYx4tbFkKiMnLmA4ioAnRa/H4EuGpQnNYId3APgSsnyfKVSIGoSWxVBjIcrQG00JiVjS5tPwsWH1M3BkPEaaFMKC5rGXNd4VZww8Tf6wdN6aeRKAsla5Apyl/8yLi2J+qD+1XPT5PF2Wx1P+KpWk4d6+Eg1np3kVoz4mb6BI2ICphJ48PgHoVgdbJIjquVtau/0ttXxaZ/crbRuhWOKQNkPWoZ9bKzB04G43N1Kq0vfZFSLkp6j0lTl0KOZZG0umTQFaDHFGlF2KzQyanO8z2tNtA8XKDywjrLVu3sdf/CaXEUeW8c/Mi7cnlAB9fMEgrFPOq9g/FZQpIw900BOT+IOp88liYWwLt+CXNm8dQIKTGxWJPcfoeFCfkeGG1A2UJcawqPogw74rgDmulOVli/Nr/e2+BMqQXfMwTyGJEttC6gQ9icGEbIvF0wWH3m2/eqHQH+Ha/RNH9B4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d68fe7-1299-4a0d-9396-08dde96646b5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:46:04.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJss4VscaT5gXiwdC7jgKu8VQkgeqoFaIxckovxE/LHPwSHKXnfJLAeFif4hO05b1R/X08YH7u/jw8BlQFk+2qoaaLzHNxSeNcwIUM5qR30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010156
X-Proofpoint-ORIG-GUID: a6GcgS6tzya773wUQ0WsnPpjwr0NNIqU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX7DCOQNWqdPo/
 8uXdpJgfs0f2fO2EsJF2DTzxmS0uNu+dmqhQt2h26zSlbzB5TYlKl7GtbnvpPGT2a2zlTU/8xAg
 bLiUjOFoajOEhF+mxlh52o8y1HlKIyAWYrQ5L5dyt26QeTkR89uZrk7CZuMNLrhwpIWU1SC54QY
 UkpZFK67wnpYgHaimnQDym+9/TJnE9gOzqdqE7w0wPhI6/fZczSXYW9YikLvCkjnBsGXe+ZPI4g
 5unCH6IGEJbw8VOiE87wNpczrvY9FaBMDdZMgZrtGicLyMJhlwMOusqDzq8jxv9CgIWVmsRKGg7
 1W7kAYgIKHTamSgLS1QaSpjFYGvtRnrzZAO7dIr6Y0pYtTekh4pJG1ATZ96e5hGHbf0ctPd5HDc
 saAE73/R
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b5b1b2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=yPCof4ZbAAAA:8
 a=Mji3MZ-BkHda3IM1usoA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: a6GcgS6tzya773wUQ0WsnPpjwr0NNIqU

On Mon, Sep 01, 2025 at 02:30:21PM +0200, Max Kellermann wrote:
> This function only reads from the pointer arguments.
>
> Local (loop) variables are also annotated with `const` to clarify that
> these will not be written to.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

This is nice thanks,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h | 2 +-
>  mm/oom_kill.c      | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 18deb14cb1f5..f70c6b4d5f80 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3840,7 +3840,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
>  }
>  #endif	/* __HAVE_ARCH_GATE_AREA */
>
> -extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
> +bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm);
>
>  void drop_slab(void);
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 17650f0b516e..6a888a5de2a4 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -490,12 +490,13 @@ static bool oom_killer_disabled __read_mostly;
>   * task's threads: if one of those is using this mm then this task was also
>   * using it.
>   */
> -bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
> +bool process_shares_mm(const struct task_struct *const p,
> +		       const struct mm_struct *const mm)
>  {
> -	struct task_struct *t;
> +	const struct task_struct *t;
>
>  	for_each_thread(p, t) {
> -		struct mm_struct *t_mm = READ_ONCE(t->mm);
> +		const struct mm_struct *t_mm = READ_ONCE(t->mm);
>  		if (t_mm)
>  			return t_mm == mm;
>  	}
> --
> 2.47.2
>
