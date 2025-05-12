Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EEB1AA1E0;
	Mon, 12 May 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064039; cv=fail; b=LjF8U9UfbqzgO2HzgyFCJDaA2AMKNeh0+al8nPN43TVoiVlAO7pyMa0Cw5/bMrFBjKDzAKG75ehaA7gMVw/N1nrWZjkp8gpCBhLZNyJSh+6uclFAmIAxot4gIeSCotj17FkCNGZ5KgJXfpAae2rdakK9hPkilz5LTyArtfdgJiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064039; c=relaxed/simple;
	bh=c/G6bwn6j7kD0ULkMVfDY3AHNe2XBaZ63ADzVbsMcfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fQqbdYNXThoUhbWdLb8jQoQOxgQWNd8dWrQPpxEw33fzw5Xn3UdsgrD/rssmhpoE+tf+J2lXWWFRymTivqhe89c9nCIP0aXWwOfP5c9UL/nq9WFipyO9OpejB59fxl8fPpS31+G9GPJcYwGjjfxOSwC27jUvag/ZSeFahNtZPvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ix9bI0Yj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zqrKZcIN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ix9bI0Yj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zqrKZcIN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9eMj024087;
	Mon, 12 May 2025 15:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hd0A2kFHk9daJnP+dm
	iC8soXmR3Zc9zHaa6KP/RCm9w=; b=Ix9bI0YjR6JSR0duBwoFX2DtO/2q+vdLuN
	auE6FpmXVChEawUkvX1Rgm56Ty8drNVW2KgJi+5XwAI1P7wOlCO3BrNgE6hMsmC/
	plPFrzpXPNgrAow1yT+oqEuwO2xWFEY4hTSKksFDW+hon1+1HQ/MruT6TSRwahEh
	BDMgLp/hgiRYrsB3yTBzd/I+wUQQRz3hwMVdBi47Kb27LPNm9+m5k0UE0q7O+D78
	EB6dtLAkP1hOImYcMoUsg8N5Gx8ca7WhDbVQoOKMeizy9oldTJZ8w82GcLwPh3ye
	lW8yxiyp+CXBHEJuEqtomoYZFXLco3wGxQqmNgxg25I0KhZ2wlhQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2aqt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 15:33:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CDpvMF022445;
	Mon, 12 May 2025 15:33:48 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88hkv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 15:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNQ5hNj+LcMt/xUQUbhNN0+HOszBeniq+e6dRHkduyTKXyQ3Sst8vZ/bfm8GJ9GdEqzwuHiV3wmfo4UqIoD2BWKxp8Y/nu55E4Lr6CmhUKTVMqgIO3gmE7s746uYeHavm5EGK8m6UUMU+U3aLnyuh7qHOooVLcrtfQOlQiUTzmoeWaWR7u2gEQRMyD5eVbP0c5rIH4dJLfyOEO/6wMF3DZulgnU/pncYo8erCuo0rzxPuugOLuOnPsvCNC2OwdTkHXs3D2mi0wBTJJXHSxmNqFJk+CJB+kAgaHpuULSQLpxblEL7pqdGx5k2qmbZArVjsqEYa6BLXudrgKxqhR4wgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd0A2kFHk9daJnP+dmiC8soXmR3Zc9zHaa6KP/RCm9w=;
 b=YRJbJlHpP+5qDsVaWD/60ugDgXfGWTW2gGKhaFMv35GlmvgxyVYByq5SGbYlIxg6Oi9m71rorUUSsBl6b4uWIwsyvY2Ty3mpyFQIL4uxZstLxGmHRrQDE9HKK03SlMxV57tb+jmvumjDf+Gr1jHEVjioZgHYYR6KmLAciH10PODUhkEeYdmvOVBJdday8O9/iX6zZPyz8Z+wreJUcpiCJpEipJKVtrrAj7fXToCqMvAnu/ZFAYpp1doy6eKjnM09+M6GNm08uV64yN4qGn6itQQNuUl3OdAq9luTo8dAMjfDZHAXzoCuIbWe5ruRjOR93fF1V4exMrknakhvhyLa/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd0A2kFHk9daJnP+dmiC8soXmR3Zc9zHaa6KP/RCm9w=;
 b=zqrKZcINRs6R/grJBykBcmVCjdOUDBvCCcXybDjHSOwbqHAzveklTh8xaYoioyTGoFWnwUFbRFHXES5VNyzwgCJ8pxFYbj/8+vFLGd6kJvy1CwhJ1vwAqJvjMM5iPe7XitPM/KP0tutngtzHRKiyD7ialCdyft2R23GLfbIhNDs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY5PR10MB5939.namprd10.prod.outlook.com (2603:10b6:930:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 15:33:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 15:33:42 +0000
Date: Tue, 13 May 2025 00:33:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aCIUz3_9WoSFH9Hp@harry>
References: <cover.1747059374.git.agordeev@linux.ibm.com>
 <c8eeeb146382bcadabce5b5dcf92e6176ba4fb04.1747059374.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8eeeb146382bcadabce5b5dcf92e6176ba4fb04.1747059374.git.agordeev@linux.ibm.com>
X-ClientProxiedBy: SEWP216CA0107.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY5PR10MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6450ac-37e8-41c5-6dd3-08dd916a6058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYyV2N4VNXq9U7NYpHKxCheEUE7IQnAmALZGNYMwZrK3vzLVZLpTlzWOdezz?=
 =?us-ascii?Q?MVSBgbywy+MFlJAG9eS6CoeygHNmdLQig8gWNG1GlZepS8pYj6IU4EKX6HTa?=
 =?us-ascii?Q?N6ELdGC2UC1+ThMgbihKpUYV5MBqHWCTgn3uoyOCBUb1gKs6AjP/BxYEIZpa?=
 =?us-ascii?Q?zKXfU93Uso6Ql16Lyk7lO69yeh8nzv8zsulXLHAdNjSfb1NUO6bTns+nwv6w?=
 =?us-ascii?Q?s6IDNiHP9LIHL9NkmmCXrPFd2NygHZ5qnqQKkMyDhKQ/UNeD+1SGtPgjEO91?=
 =?us-ascii?Q?dZefnHApQlBPyN1GkElmYenbdgXzKQXsUj1LiscU2Ga3DrFLTszPT/zWrlww?=
 =?us-ascii?Q?rpicYBk3cUiWw5AoQhElp/MB1e9b6sCSOJZ7a/4AkcnuA1fYh/vE+eahkxyq?=
 =?us-ascii?Q?Xh2k91q4r2pw2zCaNW97owdejxHBzdZin13bBUK5RemubD7o5VSA4jGXk9T5?=
 =?us-ascii?Q?KTDjzkU2UJSpS0JimTGwLJq9wXbPqEUvPClmu6kK/RAdH1cKRMjpAiyobmgb?=
 =?us-ascii?Q?QgTrqz126G2s8evWxqYAWZ4edpX0r1sVjXAuxpMAGKkyor+j/04uH5S4rxqT?=
 =?us-ascii?Q?KkNfEqDEKJNbJ+SCRW4flw63MRNo0d34V9cCJo0JfnUbNNu7bbRAg/+d9KKo?=
 =?us-ascii?Q?ISZvtEu5Js70zg7ADtWKM/HHO8H4XaBg+PWFUF80tt9c1M0AeUEFf6XRx2Ta?=
 =?us-ascii?Q?UGVLibbgsHSVHdVDbdQNazSRQ29vdSBn8vfFLUG4OFS5Pe0GTKIZSouEtu4f?=
 =?us-ascii?Q?zTimjKxPYJWL8DDvmiQI9chvN1lpj957DupwBFNfJqb7xREtrdb607b7pHd+?=
 =?us-ascii?Q?X/uSfpkhVMrXOShjqz77Wyi683DMK93BUFlN+paNeXEL9SLBrjTHkqioldjn?=
 =?us-ascii?Q?5joLO+Kw9Txr0Nv7orhlQQdcOxLyRjsWMPoAXdsSwUEzwQBw8VYqxlQuIqyn?=
 =?us-ascii?Q?IpMGsPYQHJmEXyncnqZRXHB6qmsMYjRMsZc2Qou+SsKg4r5XN1BW1NpS89Yz?=
 =?us-ascii?Q?7krba0btabT6BhhyCGgxJd6Vvq+TR0ZEsTZjugwvszccNnJMulHl0jVKDh6s?=
 =?us-ascii?Q?ZKmTTPEW5vXlTQbZrEC2ccqzM3OzaP/2woDDCbaxIkC2TCbg2eaFQQcia04b?=
 =?us-ascii?Q?DCiA5FhIqMcy8Xi2Bw0NGl1cNbVZGlfnbRii5aVf0tWsGhNsMHPCoHjTB2Mo?=
 =?us-ascii?Q?Sgzb4ktWrB4N0zQ9d+uKkV+G5pPUSK1ue9uzdyksHoWLg5LmpJnDZoJYG6ws?=
 =?us-ascii?Q?cxZ504vWzZ+82nzipEhC44N1tfBbp5/eu85Q4D6DWQRJPF2s1iH3Y9FX5bGs?=
 =?us-ascii?Q?GMdk44CGmvt6wSPqJRx4oEw5ia7SszukgKdrmoj284y7qRruW3xhXE882WUP?=
 =?us-ascii?Q?1ayppQa7p5dqyO3m2IZzyNL65v6khPtO/YmkLP+ph/aVqh3RtiVDhJBomZhB?=
 =?us-ascii?Q?CtMBH7XnJh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1p5M5QuyObj7lQXHkHlJmoSAz9PNJdki/8R7PTvI6QL1/SJva+YPzl5cWmMz?=
 =?us-ascii?Q?TZvy7SHyPTY9PsfGrvca4SKefzAl4RKxR90eEXpY/5zaEihg4zyPzpI8Lw7h?=
 =?us-ascii?Q?TzUjd+qwtCrTcCe5ZWRLYX87PfI0G44+hnk3AOt4GPbVh0SVn5ZRe+kPUH0w?=
 =?us-ascii?Q?Ia8ZBlaHLy3azLY4RPuMljugpigiV7TxSqmU7H1h7xpZkYtd3Rbay10qDz5m?=
 =?us-ascii?Q?cOnIsPq5NGj7qfILMtyySouuldUY8UOgaYR8NgDseW3r3JuIhWX66CJ/Xinz?=
 =?us-ascii?Q?oUO9a8I0kQT4bxwTDKaB9zvg4rt59kkhUTlOVd9Y7nMVsSvJBFiefbAMd/wQ?=
 =?us-ascii?Q?nIlO+uJQnIpa5tP5UWviDPYYxtS62wfRpngJHm6HtYuiEkwjnOnXSsOllkdJ?=
 =?us-ascii?Q?OV50i5LEcoW5km7e26w/thsBUOxk1SuBcGB/UGl9Y1VJH+NgkGfrLD4pTkEA?=
 =?us-ascii?Q?uUhAMmpe8smFWqCESWa+IEGrIgzuyyVLWtXWwUNzrFkWfJQ4T/NYj7hnqkhc?=
 =?us-ascii?Q?Ti4ECewJR5b7KYiUcO0EKdshRoYVBg0rw7Ge92a91XC65G7a5x4zvgeNcdkG?=
 =?us-ascii?Q?hEuLmSOKjKm0AZDd0c8Bo4owRsf6NCXzS3XmYSOkTyIBcrd+VJcY0XYRndoc?=
 =?us-ascii?Q?jPtRe/N3UvEQwl9qEduieoK1ZnFZEoVYG6cRg0ydseaimYo+Kc+ugesQlv15?=
 =?us-ascii?Q?e6RRCJnc74CwIaiXN3FVVivITgFPm/4XKQ9ZN4ola7M9tzeMJLxxKeAo0P1c?=
 =?us-ascii?Q?tO1rYIPzGnRuhqDSI2CSBdwQq58gazz7ojKcqo0wPAbA3IaWbQZd/7aRutQT?=
 =?us-ascii?Q?no2t8IFUkG3hRLct9MjivN/Tx25YmcwjUfswhtwOS9VfMxn4KVt72+GQjZ6I?=
 =?us-ascii?Q?MdigOVgL0EOgYDKftp9A/BqPUpJBdrTg/fFm5NMCdoMRr+pAdpSyJk5SnPat?=
 =?us-ascii?Q?BLrzPf0qBKGXaOefqsFVTx/Zfu/aPTiUHkeBnkrandZ544cmEAYL9Kx84AsS?=
 =?us-ascii?Q?GE52XV/4WrkoEtqE+QkGKwYHl42xQnOIh6NPdmSTS7vZ74EKNp18mutm3PN1?=
 =?us-ascii?Q?4g9ffjhMMzp7RB7ePakC2BfRyWCazwP8IbScT5vp/VyyVD55xAkZbOrwizEF?=
 =?us-ascii?Q?MYlqwCZkYkq2arEjN853mzFv9bb73t51JAAs+IJblCH+0tt7UU9LEgJTEzaj?=
 =?us-ascii?Q?BNhMD3q35pFi8tWlkq6hnSDpd6SZHLahm+xXAxG821Uodk4Y5zmetazy/9iy?=
 =?us-ascii?Q?7yatqCZmTXJSM8tQeEy9sBqMrKH0ODW5FPDJ5e+PYuKuBlIhxwiVqTFpFTrP?=
 =?us-ascii?Q?qrzpY8y/ieL5lWHMNrbVTG+OBLTJn80b8DcBxWst+vebU+DruOGtsdxN3L/W?=
 =?us-ascii?Q?9EB3DBCNW7BkF+gSdJVxii68Jbt99RUeHIUdYz0rBdWzblYTrZ4ljx1DW+5H?=
 =?us-ascii?Q?6f2cB0RMYrC28SwSm6bHPhO3p5RxY7yPm+dNvDeousPA9aP/ZdVnWlat/hfl?=
 =?us-ascii?Q?rr7dTKM22dXnR0jNfpWh313v3qjFnS64OjpYQmSl3VVm6sMK1lIISTQNGj/i?=
 =?us-ascii?Q?1iuL0LbIBrSMiYgBjmmkNwD+lJrPQnv3OEPnX/7M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GlEuZJiauNh9SJbIQgBIiMDPzGuMvo1P3m45DJWYgufQzzxggxjYySxI5xVY5eHrlIvqAS8I41Amj9LLLiquujBEOV/hnPT+JKn7ZAVGuHOROYuewAl5nQYH6O0NK00Fut5/ectnqWzcAQtqDd4e83F9jMPu0CzLIYccIha09KW21m0gvxpSlNhOu6cpYFxks0tFrpfHvRjJXUUsMznJ7kKRij+qLnXMDldStAnFBdJhGNp4e19AD3XprXvKzvR7Z/MJvBIQMluaO6fT/hlTfP4eiwDKFIpa3c5SAgzBp60kY0t0hihdP2I2sDKhQfAhYRZYkygdAqcydQmfT0F7D5r8Bgmlbay46hlaq+pK51j0KlvyTGmCSbMF2LoXvwcknmt/ZRwmLXwb+YzLF7jBqSPExWB85CUwwWOM3pnzi8G5gHX1JOMWakmE/CkkUQntLb+ECow41MlsrV+w4DRkgjAqSWXxxCqOAGeOzxlqdGePLRWrR/6WhfXvyerwvW3gR3ElQLKphxwnLrd4CiSv3baKIm2KAziRQbH90jeNfJIR0juU49qIRpT8RMjfl7LfYhG7WxjVbf89utwd/PS7aiApYB/olOkID3eWdbQGlBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6450ac-37e8-41c5-6dd3-08dd916a6058
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:33:42.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4fuEMvxAuWopSwUSZchWFeLHW7c0aX81CcxrG1lJaD+11TKps0EBs5UdaVO+Kvr5JIKeAG82WmQPKaqhg2zlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=860 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120161
X-Proofpoint-ORIG-GUID: b5GIA6ZQbm8LE5sIAWfmQP25od9R3mqb
X-Proofpoint-GUID: b5GIA6ZQbm8LE5sIAWfmQP25od9R3mqb
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=682214dd cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=vaTU-BCyYeUDStg8xvQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX8AKhRlSCzI/n a1x918DS44JclGHnwRsHGmP3gwMZJC2ag+8+Lu5FP1vv/SDC0lE7JnIiNToA7TskDthgPA/SwXa sGMaQCIEPEZhhiNVs/8nzJUSu4MKJisER49UEvl6AVvJSqwzUKi3Ug2iWQ5s+Msb5kaJNVSg7Fx
 3oaTQPMPOsLCq1VkIHYmXc9QgGXD0nUUkLpoGswRZVnlppQ0dcpyANUzOySB+G4n4wv2zFyDQ31 qMyss5yQXqiL/dparXUm8dzXt5q2RLvbybdiBbzoKqEHVlv4ZKg7geysWgrXyvo0FTLgbeJxF3F RRvgqVXmJfx56rI/BM/2nQ6WLZm7dDA1G7zvqtetoXEgBUoVUZOkaHDZ2Kf+isfmT6C57SSPEHU
 MevUdkKvowlX0UOTLzotB9ht3c9wAIB4e0mWy3CtDGaEzwxAl1Ettv/MVMX7LctqSRskike9

On Mon, May 12, 2025 at 04:27:06PM +0200, Alexander Gordeev wrote:
> apply_to_pte_range() enters the lazy MMU mode and then invokes
> kasan_populate_vmalloc_pte() callback on each page table walk
> iteration. However, the callback can go into sleep when trying
> to allocate a single page, e.g. if an architecutre disables
> preemption on lazy MMU mode enter.
> 
> On s390 if make arch_enter_lazy_mmu_mode() -> preempt_enable()
> and arch_leave_lazy_mmu_mode() -> preempt_disable(), such crash
> occurs:
> 
> [    0.663336] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
> [    0.663348] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2, name: kthreadd
> [    0.663358] preempt_count: 1, expected: 0
> [    0.663366] RCU nest depth: 0, expected: 0
> [    0.663375] no locks held by kthreadd/2.
> [    0.663383] Preemption disabled at:
> [    0.663386] [<0002f3284cbb4eda>] apply_to_pte_range+0xfa/0x4a0
> [    0.663405] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 6.15.0-rc5-gcc-kasan-00043-gd76bb1ebb558-dirty #162 PREEMPT
> [    0.663408] Hardware name: IBM 3931 A01 701 (KVM/Linux)
> [    0.663409] Call Trace:
> [    0.663410]  [<0002f3284c385f58>] dump_stack_lvl+0xe8/0x140
> [    0.663413]  [<0002f3284c507b9e>] __might_resched+0x66e/0x700
> [    0.663415]  [<0002f3284cc4f6c0>] __alloc_frozen_pages_noprof+0x370/0x4b0
> [    0.663419]  [<0002f3284ccc73c0>] alloc_pages_mpol+0x1a0/0x4a0
> [    0.663421]  [<0002f3284ccc8518>] alloc_frozen_pages_noprof+0x88/0xc0
> [    0.663424]  [<0002f3284ccc8572>] alloc_pages_noprof+0x22/0x120
> [    0.663427]  [<0002f3284cc341ac>] get_free_pages_noprof+0x2c/0xc0
> [    0.663429]  [<0002f3284cceba70>] kasan_populate_vmalloc_pte+0x50/0x120
> [    0.663433]  [<0002f3284cbb4ef8>] apply_to_pte_range+0x118/0x4a0
> [    0.663435]  [<0002f3284cbc7c14>] apply_to_pmd_range+0x194/0x3e0
> [    0.663437]  [<0002f3284cbc99be>] __apply_to_page_range+0x2fe/0x7a0
> [    0.663440]  [<0002f3284cbc9e88>] apply_to_page_range+0x28/0x40
> [    0.663442]  [<0002f3284ccebf12>] kasan_populate_vmalloc+0x82/0xa0
> [    0.663445]  [<0002f3284cc1578c>] alloc_vmap_area+0x34c/0xc10
> [    0.663448]  [<0002f3284cc1c2a6>] __get_vm_area_node+0x186/0x2a0
> [    0.663451]  [<0002f3284cc1e696>] __vmalloc_node_range_noprof+0x116/0x310
> [    0.663454]  [<0002f3284cc1d950>] __vmalloc_node_noprof+0xd0/0x110
> [    0.663457]  [<0002f3284c454b88>] alloc_thread_stack_node+0xf8/0x330
> [    0.663460]  [<0002f3284c458d56>] dup_task_struct+0x66/0x4d0
> [    0.663463]  [<0002f3284c45be90>] copy_process+0x280/0x4b90
> [    0.663465]  [<0002f3284c460940>] kernel_clone+0xd0/0x4b0
> [    0.663467]  [<0002f3284c46115e>] kernel_thread+0xbe/0xe0
> [    0.663469]  [<0002f3284c4e440e>] kthreadd+0x50e/0x7f0
> [    0.663472]  [<0002f3284c38c04a>] __ret_from_fork+0x8a/0xf0
> [    0.663475]  [<0002f3284ed57ff2>] ret_from_fork+0xa/0x38
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
>  mm/kasan/shadow.c | 76 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 88d1c9dcb507..2bf00bf7e545 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -292,33 +292,83 @@ void __init __weak kasan_populate_early_vm_area_shadow(void *start,
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
>  	pte_t pte;
> +	int index;
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
> +	index = PFN_DOWN(addr - data->start);
> +	page = data->pages[index];
> +	__memset(page_to_virt(page), KASAN_VMALLOC_INVALID, PAGE_SIZE);
> +	pte = pfn_pte(page_to_pfn(page), PAGE_KERNEL);
>  
>  	spin_lock(&init_mm.page_table_lock);
>  	if (likely(pte_none(ptep_get(ptep)))) {
>  		set_pte_at(&init_mm, addr, ptep, pte);
> -		page = 0;
> +		data->pages[index] = NULL;
>  	}
>  	spin_unlock(&init_mm.page_table_lock);
> -	if (page)
> -		free_page(page);
> +
>  	return 0;
>  }
>  
> +static inline void free_pages_bulk(struct page **pages, int nr_pages)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		if (pages[i]) {
> +			__free_pages(pages[i], 0);
> +			pages[i] = NULL;
> +		}
> +	}
> +}
> +
> +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> +{
> +	unsigned long nr_pages, nr_populated = 0, nr_total = PFN_UP(end - start);
> +	struct vmalloc_populate_data data;
> +	int ret = 0;
> +
> +	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!data.pages)
> +		return -ENOMEM;
> +
> +	while (nr_total) {
> +		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> +		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, data.pages);
> +		if (nr_populated != nr_pages) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		data.start = start;
> +		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
> +					  kasan_populate_vmalloc_pte, &data);
> +		if (ret)
> +			break;
> +
> +		start += nr_pages * PAGE_SIZE;
> +		nr_total -= nr_pages;
> +	}
> +
> +	free_pages_bulk(data.pages, nr_populated);

Hi,

Thanks for the update, but I don't think nr_populated is sufficient
here. If nr_populated in the last iteration is smaller than its value
in any previous iteration, it could lead to a memory leak.

That's why I suggested (PAGE_SIZE / sizeof(data.pages[0])).
...but on second thought maybe touching the whole array is not
efficient either.

If this ends up making things complicated probably we should just
merge v6 instead (v6 looks good)? micro-optimizing vmalloc shadow memory
population doesn't seem worth it if it comes at the cost of complexity :)

> +	free_page((unsigned long)data.pages);
> +
> +	return ret;
> +}
> +
>  int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>  {
>  	unsigned long shadow_start, shadow_end;
> @@ -348,9 +398,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
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

-- 
Cheers,
Harry / Hyeonggon
