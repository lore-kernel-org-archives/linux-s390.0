Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177442AD0B
	for <linux-s390@vger.kernel.org>; Mon, 12 May 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066618; cv=fail; b=q6OhR81CkTiG57N1h1SZWPJ9SbKEWkrKRY64cE6cKjBcyHDHvvmvoRAujNxvefviXijTdT+yKyXHUhiwnYMf1S5I/AaiDzmn9ZkFTlEcW8j+xBi7M42ZHoyh+PSpbIXPJWXLwsKHt5c5L220bR4ChBRiHrQOz9Xfgo1cmBTfvRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066618; c=relaxed/simple;
	bh=SjNNB+E5OZvh6YPRNVMbwVCqzzMiyqBgiFFTuiGXWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EYvGP5PUG3TzxoLKjNgeKQwFGeasXJL2kDs/fQ292anOg5aHzSWQI6Gr+Ijc3iXkLPbbaU372qcd+CP0/eSTPZFrtylzw/J1u6krOgV0rDjKTNGRpDH1bba7asnjUIHqLKnA5D2I6JtEQcNlGHqfmu0weutPzzd1FJRIItU3ETk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dCnGbBD5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J3EFVkoI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dCnGbBD5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J3EFVkoI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CFu7Ma031043;
	Mon, 12 May 2025 16:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9YgIQnHMchahHI3mGY
	0Zg+84acaa4lWoh09B3I1D28c=; b=dCnGbBD57P46F9VB/wsYsecqeUTLwhmefI
	eyiXW3HwFJCUVL1eJYG9kxomAqJEzTkJHESnCTJBQdte6EWpiaHlO8sIrAhINBkI
	vY3e1VfBOaaBjOmoPDxAk6zZypN/r/tP8fUzf+F49PpgmVmMqoJWZDdQ1jzLMHET
	Jz5QfTHqM9DVj1/w+thPQpi6g7MAr7vo1AEY1pCBQpsXaDl4j8OBphOqLyz+nmLh
	yXIgPqYafVaGrLC5khX6FT+EvY639e890s7GtVy5deAGFPKqdy/EXBvTzpKsAN+R
	N2x5AJOGFt1JNn3QxNkzjht3zvTNJpI5h9x+1+h6B32WcjJJXzmA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059u07m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 16:16:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CEpkEU016096;
	Mon, 12 May 2025 16:16:39 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87k18s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 16:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDj7sc7YLDhfvy2StLjvPVF6GvYpe9vpzbkr4yNPR/zAlbbKt7EILRd6OJAHVgbrv2MaAM6p0flmZG2l4kxBu2v25Z50b3JY27lrsthZwBpqdU4BOZzmkWPnm2rPh9noynW2OxYc4qop3iS5/vG9AOAYDotLJ+4A5O4RBrdJIJnFP9h9GBXgNv6Mu8XHT/TjDiinvkEE3hL0sBBzobecYZaVNTrT/SqsdO8QlP/6/3Q88MK97JkBBgVroX7QYgkI8tpZeCKVJqx4SjjiV9unEU4XA+EX4tMLMgKPXnejwLF4F82pgv2HUtI8aPc/5C2J0K6nAPaHmbsfM0ghzOkgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YgIQnHMchahHI3mGY0Zg+84acaa4lWoh09B3I1D28c=;
 b=XWfCAXcCIrY/bud4FwC7m7QWaxsaCRyf7TGDo7Kj6zKIETrhSwP6PpvODBxchhUC0AIknBIxY/7OGRw/1VUf8uhMje4aHFkcCLKQfU6WMRX8QL77HaOM6+mXPJ75ONHrwgcEm0D/yhBytcU+PO6oXO7k5N2ejVSDeyKwObCq5eJDwIYtPn84B+e33gsqBlA2zZFQUnlP2lbyje4ZEK1fkf2WYGwffZ9PZteoobjn5MXuaCTM641ye5rHo7Mcn8aCDcn2vpqMQnBCPk4KepSWt3+Le2ftgqt6R7zNuie9oftI9D+CGu1XAZDDhpZxcKYVO6yiG+AfAcvH3GrgaTlgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YgIQnHMchahHI3mGY0Zg+84acaa4lWoh09B3I1D28c=;
 b=J3EFVkoI5GnU4GzodssIMQyXg4HXLhaiqm7v39OegJ54rfsqqrpvIRb8b2x6pgF7vmQwwIzXaOf3ozJBa84rsegwndRGIsqmnqHSldAr/6GFv4tuhqnG/uMay0C+tqVTBs3T3mAcQlnaMp9vUS6RUNNNEM2EvqezeHjCoZlpPck=
Received: from CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7)
 by DM3PPF72E3677A1.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:16:36 +0000
Received: from CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::e4f5:cb34:9b58:be90]) by CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::e4f5:cb34:9b58:be90%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:16:36 +0000
Date: Mon, 12 May 2025 17:16:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
Message-ID: <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
References: <87wmalyktd.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmalyktd.fsf@linux.ibm.com>
X-ClientProxiedBy: LO2P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::27) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB8215:EE_|DM3PPF72E3677A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4f0c52-da20-45b5-e4ce-08dd91705e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUFXZMxnGHy1ce3CLPmLzch6GFunfjVRX+MtIiEXH6Zn74UhzFhR1rKNnUVC?=
 =?us-ascii?Q?Lj3gQaO7s6+lfSCXqITAcOnOHOTGOc8JO0XThz3/ItLI+bftfUH6V1mo6TGN?=
 =?us-ascii?Q?D90WVWrfHLauciIix3Vs945ak2fCrPnhSPOkhHy6LA8nVb6cwrx6gzp+2fTP?=
 =?us-ascii?Q?YnwyK5enjvzMiyoBwOYPybAOmWOfhPvDDcgu00t3Mt0wpIX9HkyVFuyc7NTT?=
 =?us-ascii?Q?wUpr2BG4g6NmTVhzrbE39BVfmTiMu9yvLKLVBsuwYCWw/2+jUxl3276flHNO?=
 =?us-ascii?Q?SlyOGFEIv9SicS2YoHCxmffjqjGMyqyIcxz8t/KFKNMlFlWCBHjUx3lLM7nu?=
 =?us-ascii?Q?ta93HFecR3OcbjnALO416/O42PBg/LqndifQihJbk58csO3v8jzenbEdpgBX?=
 =?us-ascii?Q?49fY2XqMYORLHOn0hZAw9nw+cf4TfRcDrGLdkZ173eJ5RVAMNG6Kr/xOMTcE?=
 =?us-ascii?Q?79xNBTsIMEe+hy5ySJmLcqcsxx6+jbzMvSPMe5MSjlszr1T3XHvGtjBSQeX+?=
 =?us-ascii?Q?0XjVc5nEP58LY3SoMlvozk59tq9ofGy78j1Hct5xlxYU/A63hyMoyGBclZNT?=
 =?us-ascii?Q?pOv6LYvFgdPPcsQCNoSCKjT8hf2mpMH6bGhv7VsjQmH9i92SRTYH5URuqoqp?=
 =?us-ascii?Q?vvR2910evSiALJ8PDN+t3SNwHuti/j69oAtney+mZ0ocJavgH6xrkeeEySWi?=
 =?us-ascii?Q?vlq0vOsFegcdGq/c4BhMB9Z3FQL3VTiNbsVYlfZrbFdVdJm2DvHc6oqOVQ/U?=
 =?us-ascii?Q?4LztinmKBToGgTsaw3TK6IqUEN4TV9ajSU+iwVZGvQBOHwq5MyIMpAc9nWHp?=
 =?us-ascii?Q?k07GSnGyZ8nXNF9GCI0GkW1Y7s1r4iB+A6YV0eDdwQc7230Qow2v0jU0uPxQ?=
 =?us-ascii?Q?CHgR/3pC4gr7jSeVjxzLJWdYrqMjB3kZgLA0bjpmlHcNAGwIOhCuloW4+t87?=
 =?us-ascii?Q?rbgBIHthWr+E3pgU9ArH2szrC9PHOyYMcg5DzIYvRvu/YjlMRXSeCsJeA6ut?=
 =?us-ascii?Q?f8AastObkBlJG6zv5gaXbiHufBg90kWmS49RGdMULMBVlRejifuJKWXde81P?=
 =?us-ascii?Q?jGl9/yOlX0Oz+4MBZpQTTBDC+39jOGxNCKgEWAUpfQ5W3I8i/d3PbsoKlXay?=
 =?us-ascii?Q?1aEA8Ut/KG8HgmUg0/qUIZtfMLwYA3BOP89G0GihQx4Xn7i5vl4IhLH7ITwP?=
 =?us-ascii?Q?YQeTv9PrsZRUSrIiC3fzIO/AmQUUnNndDUih3N7pFxEAlW+G8wHkV6amUSkT?=
 =?us-ascii?Q?QTHtTpHHXNCGVymhXw9Es66nP/D3rsCd28zN5bSOtE+cpjPQkuWZKrr4Ep9U?=
 =?us-ascii?Q?pFnmvYv4US6iEECzTqsx4jmZUHLjqP2IWG7eZLBJ+29oMRBTuPhskiiqQZUo?=
 =?us-ascii?Q?fVMN7S6Cs50LCTXmXhU0gOdE0z4wRi0i63s0UKOUeXqw6dxygzodOTLnlD0w?=
 =?us-ascii?Q?RywKfwG+pFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB8215.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MNzg0Oi4LSJvGc+/Ty3qtPaM/eqdrDd35TDrTqJbqBq8cWgwjmMv6iveRkE/?=
 =?us-ascii?Q?fdDWVA5ahm9W0uoG52JY3D3RFvrF6OY+bCPZw/aUX8pO/6t3aQWD/cFzNgQe?=
 =?us-ascii?Q?gBbS7dIEa3wySbCLL4wcWLTgP8kZ2GA6sVXQbGAs/68jEVN0twSQSr7LOQKk?=
 =?us-ascii?Q?BuQ1FufVJqUzG07qCL8uaZaVYAhUr+BzeHYdbhevwcfdN48OkbxYQaFU7zHS?=
 =?us-ascii?Q?WQVpUdG+qpBnTuCo3U5qb5a/DQMgkm1XT4F82Q0vOG3O+N5V5oHjgu2dtVHM?=
 =?us-ascii?Q?zzJ+ihwJgd2dZxwj3UuAYfPKFYcCwly9REAxZ/x2rjZGFwbbWHUSpJ9L0zFq?=
 =?us-ascii?Q?kImNAukIKEjLN2QL35ouIonK4k6wa/g/2aGrQwm2GOvqJIwe6EDq6winzzxi?=
 =?us-ascii?Q?0a3Ct8ePITPkr3QgyX0Ko3/UYpDimJbfwb4b0D0v1K2fIRKjRJeMY9lbYU7M?=
 =?us-ascii?Q?cnkW3QbSHtj3Oa02CUsxz30UpFPtaE1ATPjlD1Dy3BrtHYvxMn/aN53QPgPH?=
 =?us-ascii?Q?DJhFypLYrKSMB0eATv2/xB/KbgiKmfd7YcmB2vfXtzV6GdADbwoXQQ5dFFhB?=
 =?us-ascii?Q?w4uJTrlBDTk9K/fJ2F2gcYowDqkgum8SFMdgLH3YChCKp7MswNRzwtdS70op?=
 =?us-ascii?Q?KxTDLuT7BmEJTOdLM4AiTSy/tOBBbhSWP04zTU9kNnRyLJDxGwadjoF2FBcJ?=
 =?us-ascii?Q?hIOwA7L4QYZflwbFPl9gC6S+aUjHUZuPfdyBS54FvvG7kYs4oG+ZuznBnkMv?=
 =?us-ascii?Q?qXgNAQa+cizVMYd9egVuSN5xbigC4aGaoQH+qwsRB9QXmzxx9E4qTmp3jcVr?=
 =?us-ascii?Q?zZWMzC6OvNnjw/LgQ8SXNk1PFIdiLrzhSAz0pLbHD0jso7MpL8FSKV5BNAGD?=
 =?us-ascii?Q?QGLlG0VhvaSwlQzl5gisrrwXf/8WftoEOzcrmYeaEvMut4FEUasX/Frbwhn2?=
 =?us-ascii?Q?Vsa+ORr3ZX5pDvbqbcbWAxQLcg/U3vNjfKEDcoyXePD9V4H85Z0nTKgPw4Te?=
 =?us-ascii?Q?fk+g6HVS3+uyYOlNOJEf1AAEurnPbPQToRqRCioKOWuQzjXxkKDo0rhVcZ6v?=
 =?us-ascii?Q?8ZiuT3fyLX1QLmu2gu+KKAdOkruZhXFcIDIF/HECtfQQlFCYK+IyttJ8/sl1?=
 =?us-ascii?Q?Quw2dy9VDCGQyacx8S+4+bQgy+bK7JzXOYGIWHVqPTOzDhDy/xWXHk5UMTdL?=
 =?us-ascii?Q?0Nf462Bwt7gx6Ez7jgJBBQc4KxCYQk9xH9AoorB/sMs+qs3pTOxbRQVfTJ9k?=
 =?us-ascii?Q?6LZt+zH74q62pqxGBGsWTp2niZWzk1n40ij3R+xAqkKEDinluzOvCyASZpdh?=
 =?us-ascii?Q?2ViRsnOFvL/G8AYAwhC9f8n6b3AOdJdACQQ9oigkEynpWKioa73Zz4123XjP?=
 =?us-ascii?Q?r3TobIA8z3V7FWZKBv/7YC8kDZFBqpw2chg0XwQ98LofGFSQyoeaMPBnDCuQ?=
 =?us-ascii?Q?wliGlnMdyPAziQ8PeyWQjtoAbARlelOnedqoFL5td9nqLT+mdhGxCAx58KFB?=
 =?us-ascii?Q?gaMWIbl91zxbsrRA50Rqs99IeN8nmzvgZd8HlwfzDBj2KWsgohdoAJl6MZw5?=
 =?us-ascii?Q?H64FdSmP0eFMKjtZCizgQNeXGQdU1LRtbpmJJ28HPY2jLoJOgcnQV3DTboXb?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GNgEIsCqI/0e6aNw2z+gB5aSb4SFVJbdTl/cdiOh6KumPqqu9nCBooPmtCo1TVe4ppXi4xjN0H2v5U2wP14Wui1L7nWYfHwqV8YVLo+5LLdCgprQZ4eVJNmj4HWbMG+eHlzjGu007Vl91WIasCE6v94HuQrhy6ofttNJyrcmhw5suHcK+l0FNhuwLVd/Tje1tVdffKjvPSif8RiRuKCwcuH3urWjCgIJOStXEWbjBV+DSfitw2M53KKAu+AlPFUujbBcQfVltZVrur/tdchgWJPIfpQHaGtajdGJ5hsmcqCpzRNj/KKq9ulpaRdP7pDHJDP3OLm79QCWNs0K4FRebYzEmiFC9lDy396+7sBId1QTJtB/enXtsgaV6yJZHtqRYNmF+tCOMqLHnKKIVRY+aTu8zl9Mp7GzrVQJvbh/Kz7NSihmDSICSO6uKXH40yo2nefv8AL5uz3EncuVsWjcuOm4GcvoNufjjgEUEx5m0Wo8huuFDf0JvJV/b6hCzLrIiVHTeENKtLVo9ZM0NTX4oQCaWn68WrpOgg3AnZEAxQYxXYhiJcAba8DlZp41YlftMZy2WvoAfWtHiBkey49eLzZAIXCGCrZWK9siyFYeNd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4f0c52-da20-45b5-e4ce-08dd91705e47
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:16:36.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AevlJ5EXkf3/ItOblqambserY2xSnui5RtYWq6bwidS45JdYMpS6mOccMxe3mYcwP4oJNCXIXcQksbmZeWkctz6425p/4fi2uW3hSZOqb44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF72E3677A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2OCBTYWx0ZWRfXwaJdb6VbY2SN ZC//X3n8u38pyuCVgDXBiIZbKGH4dR1gw2UtlI7NGTAudgt+4BzsgFSHgqj1jpr4mJAxNYVPBO8 rD69J/XOPJO3Y28SIJKCULQZvYqzZOxpitXK1+NlvmF7CjlP7olzQOk8/uSdaSAPYFtQ68BOeWf
 ASNSaTsG2rbpTH3Oh63BRmW0e41e3P00Qy7RxbPK2/kKqYLDBV9TCGr00xlru8yvmN4aP8FbRLQ QzkBx1NZkQ/Hy5yaCJTUDqjZyoXbKSSzWRegQxBETElarM6IaBTmigptIRq/FfhI4l0D/m4EB7C 5fmc7m8pk5fJBcf7yZVDd59YxK9TJcGirxDcNR7Aw61krOAzDvi6DZFyk1i0iIzy8TWZWg1v7kC
 D4OXUFGsUXUTHBiHSO7zYiOb12omBj/Q9orGSBSpPuAijXfJyrXi9Y0M6+kpbP6k2xdEOyuF
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=68221ee8 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=TVzpxmwAr9b6T8QSrDYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: H9U3rZ_K2GupmuI8cZ3-ktDgTtPGK6S7
X-Proofpoint-GUID: H9U3rZ_K2GupmuI8cZ3-ktDgTtPGK6S7

+cc Zi

Hi Marc,

I noticed this same bug as reported in [0], but only for a _very_ recent
patch series by Zi, which is only present in mm-new, which is the most
unstable mm branch right now :)

So I wonder if related or a coincidence caused by something else?

This is triggered by the mm self-test (in tools/testing/selftests/mm, you
can just make -jXX there) transhuge-stress, invoked as:

$ sudo ./transhuge-stress -d 20

The stack traces do look very different though so perhaps unrelated?

Cheers, Lorenzo

[0]: https://lore.kernel.org/linux-mm/ef5f6776-b405-48e8-9fa9-c56af392bc4f@lucifer.local/#t

On Mon, May 12, 2025 at 04:18:06PM +0200, Marc Hartmayer wrote:
> Hi all,
>
> In a QEMU/KVM guest with 2 vCPUs, when running a test that
> enables/disables a vCPU by writing 0 and 1 to the sysfs
> `/sys/devices/system/cpu/cpu1/online` in a endless loop and doing some
> `dd` operations (block size of 1MB) in the guest in parallel, I
> sometimes see the kernel warning:
>
> "page type is 0, migratetype passed is 2 (nr=256)"
>
> The first time this happened was after the warning was added with commit
> e0932b6c1f94 (mm: page_alloc: consolidate free page accounting").
>
> Below is a "beautified" (via `decode_stacktrace.sh`) kernel stack trace
> (note: it's a self-compiled kernel using the debug config + Linux
> v6.15-rc5 + an unrelated patch on top):
>
> ```
> [   31.079925] page type is 0, passed migratetype is 2 (nr=256)
> [   31.079967] WARNING: CPU: 0 PID: 512 at mm/page_alloc.c:668 expand (mm/page_alloc.c:668 (discriminator 2) mm/page_alloc.c:1576 (discriminator 2))
> [   31.079974] Modules linked in: essiv authenc dm_crypt encrypted_keys loop pkey_pckmo pkey diag288_wdt watchdog rng_core ghash_s390 prng aes_s390 des_s390 libdes vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock virtio_console vfio_ccw mdev vfio_iommu_type1 sha512_s390 sha256_s390 vfio sha1_s390 sha_common sch_fq_codel drm i2c_core drm_panel_orientation_quirks nfnetlink autofs4 ecdsa_generic ecc
> [   31.080051] Hardware name: IBM 2964 NC9 702 (KVM/Linux)
> [   31.080055] Krnl PSW : 0404f00180000000 000003339b22f52c expand (mm/page_alloc.c:668 (discriminator 10) mm/page_alloc.c:1576 (discriminator 10))
> [   31.080064]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
> [   31.080071] Krnl GPRS: 0000033380000004 0000000000000005 0000000000000030 00000333ffffffff
> [   31.080075]            0000000000000005 0000033380000005 0000000000000100 0000000000000008
> [   31.080080]            000003339cf5e290 00000229260c99d8 ffffffff00000008 000002a8827cc000
> [   31.080084]            000003ffb7d50b58 0000000000000008 000003339b22f528 000002b39be17240
> [ 31.080095] Krnl Code: 000003339b22f51c: c02000936173 larl %r2,000003339c49b802
>
> Code starting with the faulting instruction
> ===========================================
> [   31.080095]            000003339b22f522: c0e5ffe40e37        brasl   %r14,000003339aeb1190
> [   31.080095]           #000003339b22f528: af000000            mc      0,0
> [   31.080095]           >000003339b22f52c: a7f4ff49            brc     15,000003339b22f3be
> [   31.080095]            000003339b22f530: b904002b            lgr     %r2,%r11
> [   31.080095]            000003339b22f534: c03000933a81        larl    %r3,000003339c496a36
> [   31.080095]            000003339b22f53a: c0e5fffdaad3        brasl   %r14,000003339b1e4ae0
> [   31.080095]            000003339b22f540: af000000            mc      0,0
> [   31.080123] Call Trace:
> [   31.080126] expand (mm/page_alloc.c:668 (discriminator 10) mm/page_alloc.c:1576 (discriminator 10))
> [   31.080132] expand (mm/page_alloc.c:668 (discriminator 2) mm/page_alloc.c:1576 (discriminator 2))
> [   31.080137] rmqueue_bulk (mm/page_alloc.c:646 mm/page_alloc.c:1592 mm/page_alloc.c:1762 mm/page_alloc.c:2315 mm/page_alloc.c:2368)
> [   31.080142] __rmqueue_pcplist (mm/page_alloc.c:3090)
> [   31.080147] rmqueue.isra.0 (mm/page_alloc.c:3128 mm/page_alloc.c:3159)
> [   31.080153] get_page_from_freelist (mm/page_alloc.c:3687)
> [   31.080158] __alloc_frozen_pages_noprof (mm/page_alloc.c:4971 (discriminator 1))
> [   31.080164] alloc_pages_mpol (mm/mempolicy.c:2303 (discriminator 1))
> [   31.080170] alloc_frozen_pages_noprof (mm/mempolicy.c:2374)
> [   31.080176] allocate_slab (mm/slub.c:2454 mm/slub.c:2618)
> [   31.080182] ___slab_alloc (mm/slub.c:2672 mm/slub.c:3858)
> [   31.080187] __slab_alloc.isra.0 (mm/slub.c:3948)
> [   31.080193] kmem_cache_alloc_noprof (mm/slub.c:4023 mm/slub.c:4184 mm/slub.c:4203)
> [   31.080199] alloc_buffer_head (fs/buffer.c:3033)
> [   31.080204] folio_alloc_buffers (fs/buffer.c:938)
> [   31.080212] create_empty_buffers (fs/buffer.c:1697)
> [   31.080217] __block_write_begin_int (./include/linux/pagemap.h:1025 fs/buffer.c:2134)
> [   31.080222] iomap_write_begin (fs/iomap/buffered-io.c:825)
> [   31.080228] iomap_write_iter (fs/iomap/buffered-io.c:952)
> [   31.080234] iomap_file_buffered_write (fs/iomap/buffered-io.c:1033 (discriminator 1))
> [   31.080240] blkdev_write_iter (block/fops.c:690 block/fops.c:755)
> [   31.080246] vfs_write (fs/read_write.c:592 (discriminator 1) fs/read_write.c:684 (discriminator 1) fs/read_write.c:664
>  (discriminator 1))
> [   31.080251] ksys_write (fs/read_write.c:737)
> [   31.080257] __do_syscall (arch/s390/kernel/syscall.c:125 (discriminator 2))
> [   31.080262] system_call (arch/s390/kernel/entry.S:263)
> [   31.080268] INFO: lockdep is turned off.
> [   31.080272] Last Breaking-Event-Address:
> [   31.080275] __s390_indirect_jump_r14 (arch/s390/lib/expoline.S:12)
> [   31.080284] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [   31.080294] Hardware name: IBM 2964 NC9 702 (KVM/Linux)
> [   31.080297] Call Trace:
> [   31.080300] dump_stack_lvl (lib/dump_stack.c:122)
> [   31.080305] panic (kernel/panic.c:372)
> [   31.080310] check_panic_on_warn (kernel/panic.c:247)
> [   31.080315] __warn (kernel/panic.c:751)
> [   31.080321] report_bug (lib/bug.c:176 lib/bug.c:215)
> [   31.080327] monitor_event_exception (arch/s390/kernel/traps.c:227 (discriminator 1))
> [   31.080333] __do_pgm_check (./arch/s390/include/asm/irqflags.h:48 (discriminator 1) ./arch/s390/include/asm/irqflags.h:86 (discriminator 1) arch/s390/kernel/traps.c:347 (discriminator 1))
> [   31.080338] pgm_check_handler (arch/s390/kernel/entry.S:334)
> [   31.080344] expand (mm/page_alloc.c:668 (discriminator 10) mm/page_alloc.c:1576 (discriminator 10))
> [   31.080349] expand (mm/page_alloc.c:668 (discriminator 2) mm/page_alloc.c:1576 (discriminator 2))
> [   31.080353] rmqueue_bulk (mm/page_alloc.c:646 mm/page_alloc.c:1592 mm/page_alloc.c:1762 mm/page_alloc.c:2315 mm/page_a
> lloc.c:2368)
> [   31.080359] __rmqueue_pcplist (mm/page_alloc.c:3090)
> [   31.080364] rmqueue.isra.0 (mm/page_alloc.c:3128 mm/page_alloc.c:3159)
> [   31.080369] get_page_from_freelist (mm/page_alloc.c:3687)
> [   31.080374] __alloc_frozen_pages_noprof (mm/page_alloc.c:4971 (discriminator 1))
> [   31.080380] alloc_pages_mpol (mm/mempolicy.c:2303 (discriminator 1))
> [   31.080385] alloc_frozen_pages_noprof (mm/mempolicy.c:2374)
> [   31.080390] allocate_slab (mm/slub.c:2454 mm/slub.c:2618)
> [   31.080396] ___slab_alloc (mm/slub.c:2672 mm/slub.c:3858)
> [   31.080401] __slab_alloc.isra.0 (mm/slub.c:3948)
> [   31.080407] kmem_cache_alloc_noprof (mm/slub.c:4023 mm/slub.c:4184 mm/slub.c:4203)
> [   31.080412] alloc_buffer_head (fs/buffer.c:3033)
> [   31.080417] folio_alloc_buffers (fs/buffer.c:938)
> [   31.080422] create_empty_buffers (fs/buffer.c:1697)
> [   31.080427] __block_write_begin_int (./include/linux/pagemap.h:1025 fs/buffer.c:2134)
> [   31.080433] iomap_write_begin (fs/iomap/buffered-io.c:825)
> [   31.080438] iomap_write_iter (fs/iomap/buffered-io.c:952)
> [   31.080444] iomap_file_buffered_write (fs/iomap/buffered-io.c:1033 (discriminator 1))
> [   31.080449] blkdev_write_iter (block/fops.c:690 block/fops.c:755)
> [   31.080455] vfs_write (fs/read_write.c:592 (discriminator 1) fs/read_write.c:684 (discriminator 1) fs/read_write.c:664
>  (discriminator 1))
> [   31.080460] ksys_write (fs/read_write.c:737)
> [   31.080465] __do_syscall (arch/s390/kernel/syscall.c:125 (discriminator 2))
> [   31.080470] system_call (arch/s390/kernel/entry.S:263)
> [   31.080476] INFO: lockdep is turned off.
> ```
>
> Any ideas?
>
> --
> Thanks in advance,
>
>  Marc
>
>
